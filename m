Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C527DDDFE2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:50 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:05 -0600 (CST)
Subject: [PATCH 5/7] bootwrapper: missing relocation in crt0.S
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-05.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

crt0.S had provisions to provide run address relocaton to got2 and
cache flush, but not on the bss clear or stack pointer load.  Apply
the same fixup for them.

--- 
Compiles and links.  Stack is created within the image when linked at
4M and run at 0.  Did not verify bss relocation.
 crt0.S |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: kernel/arch/powerpc/boot/crt0.S
===================================================================
--- kernel.orig/arch/powerpc/boot/crt0.S	2007-03-16 23:22:00.000000000 -0500
+++ kernel/arch/powerpc/boot/crt0.S	2007-03-16 23:42:42.000000000 -0500
@@ -63,21 +63,30 @@ _zimage_start:
 	/* Clear the BSS */
 	lis	r9,__bss_start@ha
 	addi	r9,r9,__bss_start@l
+	add	r9,r0,r9
 	lis	r8,_end@ha
 	addi	r8,r8,_end@l
+	add	r8,r0,r8
 	li	r0,0
 5:	stw	r0,0(r9)
 	addi	r9,r9,4
 	cmplw	cr0,r9,r8
 	blt	5b
 
+	/* recreate relocation offset */
+	lis	r9,_end@ha
+	addi	r9,r9,_end@l
+	subf	r0,r9,r8
+
 	/* Possibly set up a custom stack */
 .weak	_platform_stack_top
 	lis	r8,_platform_stack_top@ha
 	addi	r8,r8,_platform_stack_top@l
 	cmpwi	r8,0
 	beq	6f
+	add	r8,r0,r8
 	lwz	r1,0(r8)
+	add	r1,r0,r1
 	li	r0,0
 	stwu	r0,-16(r1)	/* establish a stack frame */
 6:
