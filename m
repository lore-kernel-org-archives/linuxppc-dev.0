Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0996@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: debugging IBM405GP with  abatron bdi 2000
Date: Tue, 5 Aug 2003 11:52:47 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone used an Abatron BDI 2000 to debug Linux on an IBM 405GP
processor?  I am using an Embedded Planet ep405 with the latest
linuxppc_2_4_devel tree.  Linux boots fine on the board until I connect the
Abatron.  When the Abatron is connected I can step through the code until
the rfi command in head_4xx.S then I get the following.

- TARGET: target has entered debug mode
    Target state      : debug mode
    Debug entry cause : JTAG stop request
    Current PC        : 0x00000700
    Current CR        : 0x28004088
    Current MSR       : 0x00000000
    Current LR        : 0x000007a8
# Step timeout detected


Below is the config file I am using.  I would appreciate any adive anyone
can offer.


[INIT]
;
WSPR	954	0x00000000	;DCWR: Disable data cache write-thru
WSPR	1018	0x00000000	;DCCR: Disable data cache
WSPR	1019	0x00000000	;ICCR: Disable instruction cache
WSPR	982	0x00000000	;EVPR: Exception Vector Table @0x00000000
;
; Setup TCR (Timer Control Register)
WSPR	986	0x00400000
; Setup MMU info
WM32    0x000000f0  0x00000000  ;invalidate page table base
;
;
[TARGET]
JTAGCLOCK   0			;use 16 MHz JTAG clock
CPUTYPE	405			;the used target CPU type
BDIMODE	AGENT			;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   SOFT			;SOFT or HARD, HARD uses PPC
hardware breakpoint
STEPMODE    JTAG			;JTAG or HWBP, HWPB uses one or two
hardware breakpoints
MMU	    XLAT 0xC0000000	;enable virtual address mode
PTBASE      0x000000f0  	;here is the pointer to the page table
pointers
;
[HOST]
IP          10.0.0.198     ;Windows host
FILE        rImage.srec
FORMAT      SREC
LOAD        MANUAL              ;load code MANUAL or AUTO after reset
;
;
[REGS]
IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA
IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA
IDCR3	0x014	0x015	;KIAR and KIDR
FILE    defs/reg405gp.def


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
