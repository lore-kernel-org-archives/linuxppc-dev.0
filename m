Message-ID: <3950D6BE.8E51A444@essegi.net>
Date: Wed, 21 Jun 2000 16:52:46 +0200
From: Stefano Totaro <tost@essegi.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MMU problems on YellowKnife board (PPC750) with SmartFirmware
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,
I am trying to port linux (kernel 2.4.0 and I tried also the 2.2.14 for
ppc7xx from MontaVista) on a Motorola YellowKnife development board
(CHRP like) based on the PPC750 running CodeGen
SmartFirmware (it should be openfirmware compliant but the one I am
using is
an evaluation and so I am not sure of its behavior).

I am experiencing problems in setting up the MMU.
I had to move the kernel from the original running address (0x100000)
because it overwrote the firmware. So I moved it to 0x30100000 and then
after then it relocates in 0.

The problem raises when head.S tries to turn on the MMU exactly after
the rfi

turn_on_mmu:
	mfmsr	r0
	ori	r0,r0,MSR_DR|MSR_IR
	mtspr	SRR1,r0
	lis	r0,start_here@h
	ori	r0,r0,start_here@l
	mtspr	SRR0,r0
	SYNC
	rfi

I am not able to understand exactly what is going on because I am using
a JTAG debugger but I cannot put breakpoints near the rfi.
It looks like the CPU jumps at the right address but there is INVALID
code only and then it jumps to 0x700 (I have set up the exception prefix
to 0x0000_0).
The DBAT0L, DBAT0U, IBAT0L and IBAT0U seems to be correctly setup to map
the first 256Meg to c0000000 with read and write privilegies and the
code is at the right physical address but something does not work.

I have tried also to turn on the MMU without jumping to 0xC000... as
described in the Motorola Application Note "A Minimal PowerPC Boot
Sequence for Executing Compiled C Programs"

address_translation_on:
	mfmsr r5
	ori r5,r5,0x0030
	mtmsr r5
	isync
	blr

I did it to avoid to use the rfi, but when I put back r5 to MSR the cpu
jumps to 0x700. Moreover, the MSR IR and DR bit do not look to be setup.

I have no more ideas I am reading all the application but I do not find
an explaination of this behavior.

Can someone of you help me in solving this problem?

Thanks in advance

Best wishes,
Stefano


p.s.

I have noticed many MMU setup problems reported in this  mail list but I
didn't find one that exactly matches mine.  However, just in case, I
apologise if some of you as yet answered to this question.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
