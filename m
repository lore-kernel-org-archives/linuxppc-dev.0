Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EE2FDDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 18:21:06 +1000 (EST)
Date: Wed, 28 Mar 2007 02:21:02 -0600 (CST)
Subject: [PATCH 1/4] bootwrapper: missing relocation in crt0.S
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-3-01.miltonm@bga.com>
In-Reply-To: <boot-3-00.miltonm@bga.com>
References: <boot-3-00.miltonm@bga.com>
	<17923.25798.710476.476462@cargo.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
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
This one uses r10 to zero, so that the offset in r0 is preserved.

Index: kernel/arch/powerpc/boot/crt0.S
===================================================================
--- kernel.orig/arch/powerpc/boot/crt0.S	2007-03-28 01:09:05.000000000 -0500
+++ kernel/arch/powerpc/boot/crt0.S	2007-03-28 01:09:21.000000000 -0500
@@ -65,10 +65,12 @@ _zimage_start_lib:
 	/* Clear the BSS */
 	lis	r9,__bss_start@ha
 	addi	r9,r9,__bss_start@l
+	add	r9,r0,r9
 	lis	r8,_end@ha
 	addi	r8,r8,_end@l
-	li	r0,0
-5:	stw	r0,0(r9)
+	add	r8,r0,r8
+	li	r10,0
+5:	stw	r10,0(r9)
 	addi	r9,r9,4
 	cmplw	cr0,r9,r8
 	blt	5b
@@ -79,7 +81,9 @@ _zimage_start_lib:
 	addi	r8,r8,_platform_stack_top@l
 	cmpwi	r8,0
 	beq	6f
+	add	r8,r0,r8
 	lwz	r1,0(r8)
+	add	r1,r0,r1
 	li	r0,0
 	stwu	r0,-16(r1)	/* establish a stack frame */
 6:
