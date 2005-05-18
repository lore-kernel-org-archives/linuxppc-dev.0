Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A684767A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 20:21:08 +1000 (EST)
Date: Wed, 18 May 2005 03:21:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050518102103.GB32493@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc32: fix CONFIG_TASK_SIZE handling on 44x
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

This patch fixed CONFIG_TASK_SIZE handling on 44x. Currently 
head_44x.S hardcodes 0x80000000, which breaks if user chooses to 
change TASK_SIZE (e.g. for 3G user-space). Tested on Ocotea in 3G/1G 
configuration.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

Index: arch/ppc/kernel/head_44x.S
===================================================================
--- 59c3218467807e1793fb4fc5d90141e072ab2212/arch/ppc/kernel/head_44x.S  (mode:100644)
+++ uncommitted/arch/ppc/kernel/head_44x.S  (mode:100644)
@@ -330,8 +330,9 @@
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
 
@@ -464,8 +465,9 @@
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
 
@@ -533,8 +535,9 @@
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
 
