Message-ID: <3BE7E505.DC9DE6E8@laposte.net>
Date: Tue, 06 Nov 2001 14:26:29 +0100
From: ibm405gp <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: list <linuxppc-embedded@lists.linuxppc.org>
Subject: Abatron Bdi2000 and 405GP
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

How can i read back (or write) for example, the FPGA registers from the
walnut board (at @OxFO300000) with abatron.
I can read this memory area just after the ioremap operation (in
walnut.c) when the entry for 0XF0300000 is present
in the TLB without any problem (0xF0300000 -> 0xF0300000). With the
abatron debugger, i should be able to read any virtual adress, even if
this adress is not present in the TLB. Am i right ? Any suggestion ?
Thanks.

I'am using the latest version of bdiGdb (1.07), with the folllowing
config file :

[INIT]
; Setup MMU info
WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
WM32    0x000000f8  0x00000000  ;invalidate process page table base
WM32    0x000000f0  0xc00000f4  ;invalidate page table base

[TARGET]
MMU         XLAT 0xC0000000     ;enable virtual address mode
PTBASE      0x000000f0          ;address where kernel/user stores
pointer to page table

the hhl 2.0 from monta vista with the following head_4xx.S

	/* Add helper information for the Abatron bdiGDB debugger.
	*/
	lis	r5, abatron_pteptrs@ha
	ori	r5, r5, abatron_pteptrs@l
	stw	r5, 0xf0(r0)	/* This much match your Abatron config */
	lis	r6, swapper_pg_dir@h
	ori	r6, r6, swapper_pg_dir@l
	tophys(r5, r5)
	stw	r6, 0(r5)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
