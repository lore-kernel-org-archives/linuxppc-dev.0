Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72239DDFA5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:01 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF2vp7008512
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:02:57 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF2vYQ008511
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:02:57 -0600 (CST)
Date: Wed, 21 Mar 2007 09:02:57 -0600 (CST)
Subject: [PATCH 2/8] bootwrapper: missing relocation in crt0.S
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-02.miltonm@bga.com>
In-Reply-To: <boot-2-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, david@gibson.dropbear.id.au
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

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Compiles and links.  Stack is created within the image when linked at
4M and run at 0.  Did not verify bss relocation.

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
