From: "Brian Padalino" <bpadalino@perigee.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI2000 and 440GP
Date: Fri, 21 Nov 2003 11:07:54 -0500
Message-ID: <DGEEIPOFGGPOACEFBGGCEECBCBAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know if this is the right place to post something along these lines,
but I don't think I have much anywhere else to turn.

I have a BDI2000 and a 440Gp Ebony board.  I have a desire to cut the DDR
memory bus in half so it only uses 32-bits instead of 64-bits.  I change, in
the init, the B0CR and the CFG0 for the DDR Memory Controller.  Here is what
my INIT looks like:

[INIT]
; Setup TLB
MMAP    0xFF800000  0xFFBFFFFF  ;Flash memory
MMAP    0xFFF80000  0xFFFFFFFF  ;Flash memory
WTLB    0xF0000095  0x1F00003F  ;Boot Space 256MB
WTLB    0x00000098  0x0000003F  ;SDRAM 256MB @ 0x00000000

; Setup Peripheral Bus
WDCR	0x12	0x00000010	;Select EBC0_B0AP
WDCR	0x13	0x9B015480	;B0AP: Flash and SRAM
WDCR	0x12	0x00000000	;Select EBC0_B0CR
WDCR	0x13	0xFFF18000	;B0CR: 1MB at 0xFFF00000, r/w, 8bit
WDCR	0x12	0x00000012	;Select EBC0_B2AP
WDCR	0x13	0x9B015480	;B2AP: 4 MB Flash
WDCR	0x12	0x00000002	;Select EBC0_B2CR
WDCR	0x13	0xff858000	;B2CR: 4MB at 0xFF800000, r/w, 8bit

; Setup SDRAM Controller (DDR SDRAM)
WDCR	0x10	0x00000082	;Select SDRAM0_CLKTR
WDCR	0x11	0x40000000	;CLKTR: Advance 90 degrees
WDCR	0x10	0x00000080	;Select SDRAM0_TR0
WDCR	0x11	0x410A4012	;TR0: V2.0
;WDCR	0x11	0x41054009	;TR0: V1.0
WDCR	0x10	0x00000081	;Select SDRAM0_TR1
WDCR	0x11	0x8080082B	;TR1: V2.0
;WDCR	0x11	0x40400800	;TR1: V1.0
WDCR	0x10	0x00000040	;Select SDRAM0_B0CR
WDCR	0x11	0x00024001	;B0CR:
WDCR	0x10	0x00000030	;Select SDRAM0_RTR
WDCR	0x11	0x08200000	;RTR: V2.0
;WDCR	0x11	0x06180000	;RTR: V1.0
WDCR	0x10	0x00000020	;Select SDRAM0_CFG0
WDCR	0x11	0x04000000	;CFG0: 32bit, PMU disable
WDCR	0x11	0x84800000	;CFG0: enable SDRAM

This is based mainly around what came with the BDI2000, with the exception
of the 2 changed registers and the added MMAP entries at the top.

The problem is that the INIT is flaky at best.  The BDI seems to not want to
_always_ boot it properly.  I turn off both, turn the BDI on, telnet to it,
wait for it to say "Waiting for VCC" then turn on the target.  It is about a
50/50 chance it will come up properly with the dev kit and it has never come
up successfully with the custom board.

The error I get is:

- TARGET: waiting for target Vcc
- TARGET: processing power-up delay
- TARGET: processing user reset request
- TARGET: resetting target passed
- TARGET: processing target startup ....
*** TARGET: processing target startup failed
# PPC: JTAG instruction stuff overrun
- TARGET: target will be restarted in 10 sec
Core#0>

I have tried changing the JTAG clock speed as well as checking out the
signals and they look pretty clean to me.

Does the CPU go out and fetch code in the I2C EEPROM when it boots using the
BDI?  Could that be an issue?  Is there a smaller [INIT] section I can have
to try to test it out with?

Right now I am stuck and I hope someone can help.

Thanks,
Brian Padalino


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
