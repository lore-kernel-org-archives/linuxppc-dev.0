Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx2.magma.ca (mx2.magma.ca [206.191.0.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F1A167A3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 03:00:37 +1000 (EST)
Received: from www-webmail1.magma.ca (www-webmail1.magma.ca [206.191.0.225])
	by mx2.magma.ca (8.13.6/8.13.0) with ESMTP id k51H0XA5026415
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Jun 2006 13:00:34 -0400
Date: Thu, 1 Jun 2006 13:00:32 -0400
Message-Id: <200606011700.k51H0WJw014425@www-webmail1.magma.ca>
To: linuxppc-embedded@ozlabs.org
From: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
Subject: memset hangs part way through; called from early_init
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
I'm running a V2Pro-based development board, and I'm working on a linux 2.6.15 port.
Currently, the board hangs in the early_init function. Specifically, at the following line:
memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);

This memset_io() call eventually calls memset() (from arch/ppc/lib/string.S) to zero the
region of memory. Using a BDI2000, I'm able to step through the assembly and see that
within memset, it enters a two-instruction loop where it is writing zeros to consecutive
memory locations. Everything is going fine, but after 10 or 20 iterations of the loop
(it's not consistent), everything blows up.

GDB reports the following:
------------------------------
(gdb) stepi

Program received signal SIG110, Real-time event 110.
0xc000b3e8 in memset ()
(gdb)
------------------------------

The BDI2000 reports the following:
------------------------------
*** MMU: address translation for 0xC000B3E8 failed
*** MMU: address translation for 0xC000B3E4 failed
*** MMU: address translation for 0xC000B3E8 failed
*** MMU: address translation for 0xC000B3E4 failed
*** MMU: address translation for 0xC000B3B0 failed
*** MMU: address translation for 0xDEADBEEF failed
*** MMU: address translation for 0xDEADBEEB failed
*** MMU: address translation for 0xDEADBEEF failed
*** MMU: address translation for 0xDEADBEEB failed
*** MMU: address translation for 0x00000000 failed
*** MMU: address translation for 0xDEADBEEF failed
*** MMU: address translation for 0xDEADBEEB failed
*** MMU: address translation for 0xDEADBEEF failed
*** MMU: address translation for 0xDEADBEEB failed
*** MMU: address translation for 0x00000000 failed
------------------------------

Here is my BDI2000 configuration file:
------------------------------
[INIT]



[TARGET]

JTAGCLOCK   0                   ;use 16 MHz JTAG clock

CPUTYPE     405 		;the used target CPU type

BDIMODE     AGENT   	        ;the BDI working mode (LOADONLY | AGENT)


BREAKMODE   HARD      	        ;SOFT or HARD, HARD uses PPC hardware breakpoint

STEPMODE    HWBP                ;JTAG or HWBP, HWPB uses one or two hardware breakpoints


MMU         XLAT 0xC0000000     ;enable virtual address mode

PTBASE      0x000000f0          ;address where kernel/user stores pointer to page table

STARTUP     RESET




[HOST]

IP          192.9.200.213


FILE        ppcboot.bin

FORMAT      BIN 0xfff80000 ;0x200000

START       0xfff80000 ; 0x200000

LOAD        MANUAL              ;load code MANUAL or AUTO after reset

DEBUGPORT   2001

DUMP        dump.bin            ;Linux: dump.bin must already exist and public writable



[FLASH]

WORKSPACE   0xffffd000

CHIPTYPE    STRATAX16

BUSWIDTH    16

CHIPSIZE    0x400000


[REGS]

IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA

IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA

IDCR3	0x014	0x015	;KIAR and KIDR

FILE    reg405gp.def
------------------------------

Any ideas would be appreciated.

Regards,
Chris Dumoulin
