Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8DD5C67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 03:09:52 +1000 (EST)
Date: Wed, 18 May 2005 10:09:49 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050518170949.GA6766@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc32: fix CONFIG_TASK_SIZE handling on 40x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

This patch is virtually identical to my previous 44x one. It removes 
0x8000'0000 TASK_SIZE hardcoded assumption from head_4xx.S.

I don't have any 40x board which runs 2.6, so this one is untested, 
bit it compiles :).

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

Index: arch/ppc/kernel/head_4xx.S
===================================================================
--- 59c3218467807e1793fb4fc5d90141e072ab2212/arch/ppc/kernel/head_4xx.S  (mode:100644)
+++ uncommitted/arch/ppc/kernel/head_4xx.S  (mode:100644)
@@ -291,8 +291,9 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andis.	r11, r10, 0x8000
-	beq	3f
+	lis	r11, TASK_SIZE@h 
+	cmplw	r10, r11
+	blt+	3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
 	li	r9, 0
@@ -479,8 +480,9 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andis.	r11, r10, 0x8000
-	beq	3f
+	lis	r11, TASK_SIZE@h 
+	cmplw	r10, r11
+	blt+	3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
 	li	r9, 0
@@ -578,8 +580,9 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andis.	r11, r10, 0x8000
-	beq	3f
+	lis	r11, TASK_SIZE@h 
+	cmplw	r10, r11
+	blt+	3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
 	li	r9, 0
