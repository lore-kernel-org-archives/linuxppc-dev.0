Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDD2767A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:34:29 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:34:11 +1100
Message-Id: <1106012051.4499.28.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: update cpu state save/restore
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch updates the ppc32 cpu state save/restore code to deal with the Motorola/Freescale
MPC7447A, used, among others, on recent Apple laptops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/cpu_setup_6xx.S
===================================================================
--- linux-work.orig/arch/ppc/kernel/cpu_setup_6xx.S	2004-11-22 11:49:17.000000000 +1100
+++ linux-work/arch/ppc/kernel/cpu_setup_6xx.S	2005-01-17 13:49:16.268678952 +1100
@@ -292,13 +292,15 @@
 	cmplwi	cr2,r3,0x800c	/* 7410 */
 	cmplwi	cr3,r3,0x8001	/* 7455 */
 	cmplwi	cr4,r3,0x8002	/* 7457 */
-	cmplwi	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr5,r3,0x8003	/* 7447A */
+	cmplwi	cr6,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
 	cror	4*cr0+eq,4*cr0+eq,4*cr3+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
 	bne	1f
 	/* Backup 74xx specific regs */
 	mfspr	r4,SPRN_MSSCR0
@@ -316,7 +318,7 @@
 	mfspr	r4,SPRN_LDSTDB
 	stw	r4,CS_LDSTDB(r5)
 1:
-	bne	cr5,1f
+	bne	cr6,1f
 	/* Backup 750FX specific registers */
 	mfspr	r4,SPRN_HID1
 	stw	r4,CS_HID1(r5)
@@ -359,13 +361,15 @@
 	cmplwi	cr2,r3,0x800c	/* 7410 */
 	cmplwi	cr3,r3,0x8001	/* 7455 */
 	cmplwi	cr4,r3,0x8002	/* 7457 */
-	cmplwi	cr5,r3,0x7000	/* 750FX */
+	cmplwi	cr5,r3,0x8003	/* 7447A */
+	cmplwi	cr6,r3,0x7000	/* 750FX */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
 	cror	4*cr0+eq,4*cr0+eq,4*cr3+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
 	bne	2f
 	/* Restore 74xx specific regs */
 	lwz	r4,CS_MSSCR0(r5)
@@ -404,7 +408,7 @@
 	mtspr	SPRN_LDSTDB,r4
 	isync
 	sync
-2:	bne	cr5,1f
+2:	bne	cr6,1f
 	/* Restore 750FX specific registers
 	 * that is restore HID2 on rev 2.x and PLL config & switch
 	 * to PLL 0 on all
