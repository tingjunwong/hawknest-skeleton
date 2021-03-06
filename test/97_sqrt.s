.include "test_hdr.inc"

; DESC: 16-bit sqrt

; Returns the 8-bit square root in $20 of the
; 16-bit number in $20 (low) and $21 (high). The
; remainder is in location $21.

sqrt16:  
	LDY #$01     ; lsby of first odd number = 1
	STY $22
	DEY
	STY $23      ; msby of first odd number (sqrt = 0)
again:
	SEC
	LDA $20      ; save remainder in X register
	TAX          ; subtract odd lo from integer lo
	SBC $22
	STA $20
	LDA $21      ; subtract odd hi from integer hi
	SBC $23
	STA $21      ; is subtract result negative?
	BCC nomore   ; no. increment square root
	INY
	LDA $22      ; calculate next odd number
	ADC #$01
	STA $22
	BCC again
	INC $23
	JMP again
nomore:
	STY $20      ; all done, store square root
	STX $21      ; and remainder
	RTS
       
test:
    lda #16
    sta $20
    lda #0
    sta $21
    jsr sqrt16
    TEST_END

