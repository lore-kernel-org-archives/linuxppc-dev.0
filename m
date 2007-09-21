Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 017C7DE19C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:04:54 +1000 (EST)
Date: Fri, 21 Sep 2007 18:04:37 -0500 (CDT)
Subject: [PATCH 6/15] bootwrapper: help for 64 bit cpus
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-06.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add code to check if the processor is in 64 or 32 bit mode using
only instructions from the 32 bit subset.  If the processor is in
64 bit mode, switch to 32 bit mode by clearing MSR[SF].

Also add a 64 bit procedure descriptor to use as a elf64 entry
point.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
vs 12173
correct comment (equal vs not-equal)

Index: kernel/arch/powerpc/boot/crt0.S
===================================================================
--- kernel.orig/arch/powerpc/boot/crt0.S	2007-07-10 03:33:36.000000000 -0500
+++ kernel/arch/powerpc/boot/crt0.S	2007-07-10 03:39:08.000000000 -0500
@@ -17,11 +17,47 @@
 _zimage_start_opd:
 	.long	_zimage_start, 0, 0, 0
 
+	/* a procedure descriptor used when pretending to be elf64_powerpc */
+	.balign	8
+	.globl	_zimage_start_64
+_zimage_start_64:
+	.long	0, _zimage_start	/* big endian, supported reloc ppc32 */
+	.long	0, 0, 0, 0, 0, 0
+
+
 	.weak	_zimage_start
 	.globl	_zimage_start
 _zimage_start:
 	.globl	_zimage_start_lib
 _zimage_start_lib:
+	/* Check if the processor is running in 32 bit mode, using
+	 * only 32 bit instructions which should be safe on 32 and
+	 * 64 bit processors.
+	 *
+	 * Subtract bottom 32 bits of MSR from full value recording
+	 * the result.  Since MSR[SF] is in the high word, we will
+	 * be equal iff in 32 bit mode (either the processor is
+	 * a 32 bit processor or MSR[SF] = 0).
+	 */
+	mfmsr	r0		/* grab whole msr		*/
+	rlwinm	r8,r0,0,0,31	/* extract bottom word		*/
+	subf.	r8,r8,r0	/* subtract, same?		*/
+	beq	0f		/* yes: we are 32 bit mode	*/
+
+	/* We are in 64-bit mode.  This program must run in 32 bit
+	 * mode.  Assume we are actually running somewhere in the
+	 * low 32 bits of the address space, so we can just turn
+	 * off MSR[SF] which is bit 0.
+	 */
+	.machine push
+	.machine "ppc64"
+	rldicl	r0,r0,0,1
+	sync
+	mtmsrd	r0
+	isync
+	.machine pop
+0:	/* We are now in 32-bit mode */
+
 	/* Work out the offset between the address we were linked at
 	   and the address where we're running. */
 	bl	1f
