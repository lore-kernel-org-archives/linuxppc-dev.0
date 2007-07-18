Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E7A6DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:30:00 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6IGTtsv008448
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 09:29:56 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6IGTsDG028663
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:29:55 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6IG5Bhs029477
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:05:12 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CFAAEAEFC9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:29:53 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6IGTrQl020284
	for linuxppc-dev@ozlabs.org; Wed, 18 Jul 2007 11:29:53 -0500
Date: Wed, 18 Jul 2007 11:29:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/61] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070718162953.GA20273@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Only map 512K of the IMMR, rather than 8M, to avoid conflicting with
the default ioremap region.
2. The wrong register was being loaded into SPRN_MD_RPN.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Apparently I missed sending this one yesterday...

 arch/powerpc/kernel/head_8xx.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 7488f30..c1469f3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -701,7 +701,7 @@ initial_mmu:
 	mtspr	SPRN_MI_AP, r8
 	mtspr	SPRN_MD_AP, r8
 
-	/* Map another 8 MByte at the IMMR to get the processor
+	/* Map another 512 KByte at the IMMR to get the processor
 	 * internal registers (among other things).
 	 */
 #ifdef CONFIG_PIN_TLB
@@ -714,7 +714,7 @@ initial_mmu:
 	mr	r8, r9			/* Create vaddr for TLB */
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
-	li	r8, MD_PS8MEG		/* Set 8M byte page */
+	li	r8, MD_PS512K		/* Set 512K byte page */
 	ori	r8, r8, MD_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
@@ -736,13 +736,13 @@ initial_mmu:
 	mtspr	SPRN_MD_TWC, r9
 	li	r11, MI_BOOTINIT	/* Create RPN for address 0 */
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
 #endif
 
 	/* Since the cache is enabled according to the information we
-- 
1.5.0.3
