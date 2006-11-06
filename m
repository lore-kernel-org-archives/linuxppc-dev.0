Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3F1B67C53
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 19:38:33 +1100 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA68cMiW011043
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 09:38:22 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA68cK5G011012
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 09:38:20 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Flash programming using a BDI2000 on a MPC8248 CPU
Date: Mon, 6 Nov 2006 09:42:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611060942.05419.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm having problems using my BDI2000 to program an external flash on a MPC8248 
board. I contacted Abatron's technical support (through its French 
distributor, as nobody at Abatron seems to speak English or French). They 
haven't been able to provide a solution (they really don't seem to care) 
after more than a month, so I'm hoping to find some help here.

I can't get the BDI2000 to program the flash using the internal workspace 
(fast algorithm) on a blank flash.

What works:

- Programming the flash without using the internal workspace (slow, JTAG-only 
algorithm).
- Programming the flash using the internal workspace ONLY WHEN the flash has 
already been programmed with a valid U-Boot copy, and the breakpoint 
specified in the BDI2000 configuration file (BOOTADDR) is set to a wrong 
value.

What doesn't work:

- Programming the flash using the internal workspace when the flash is empty.
- Programming the flash using the internal workspace when the flash has 
already been programmed with a valid U-Boot copy, and the breakpoint 
specified in the BDI2000 configuration file (BOOTADDR) is set to the right 
value.

When the reset breakpoints fails (BOOTADDR set to 0x00000100 instead of 
0xFFF00100 for instance), U-Boot starts to initialize the board before the 
BDI2000 freezes the CPU. I assume that must be the reason why programming the 
flash using the internal workspace then works. I tried having a look at the 
U-Boot startup code, and initializing the same registers in the BDI2000 
configuration file, but without success. I probably missed something.

Here is my BDI2000 configuration file. The hardware reset configuration word 
is set to 0x00000000.

-----------------------------------------------------------------------------
[INIT]
WREG            MSR             0x00000000
WM32            0x00010004      0xffff2081      ; SYPCR
WM32            0x00010024      0x00000000      ; BCR
WM32            0x00010000      0x82240000      ; SIUMCR
WM32            0x00010c80      0x00000001      ; SCCR
WM32            0x000119c4      0x00000000      ; RCCR
; Initialize the flash memory controller
WM32            0x00010100      0x40001001      ; BR0
WM32            0x00010104      0xf8000834      ; OR0

[TARGET]
CPUTYPE         8260            ; the CPU type (603EV,750,8240,8260)
JTAGCLOCK       0               ; use 16 MHz JTAG clock
BOOTADDR        0xFFF00100
BDIMODE         AGENT           ; the BDI working mode 
BREAKMODE       SOFT            ; SOFT or HARD
VECTOR          CATCH           ; catch unhandled exceptions
DCACHE          NOFLUSH         ; data cache flushing (FLUSH | NOFLUSH)
SIO             2002 115200

[FLASH]
CHIPTYPE        MIRRORX16       ; Flash type
CHIPSIZE        0x1000000       ; The size of one flash chip in bytes
BUSWIDTH        16              ; The width of the flash memory bus in bits
ERASE           0x40000000 CHIP
FILE            u-boot.bin
FORMAT          BIN
;WORKSPACE      0x00008000

[HOST]
IP              192.168.2.1
LOAD            MANUAL          ; load code MANUAL or AUTO after reset

[REGS]
DMM1            0x00000000
FILE            bdi2000/reg8272.def
-----------------------------------------------------------------------------

Any help would be greatly appreciated (and would also prove community support 
is better than Abatron's commercial support ;-) ).

Best regards,

Laurent Pinchart
