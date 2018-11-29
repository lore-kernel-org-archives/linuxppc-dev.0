Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCAC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:00:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD46B21019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD46B21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435LKq02xXzDqCM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 02:00:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435K8j5zq7zDrF0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 01:07:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435K8d36f5z9vGDx;
 Thu, 29 Nov 2018 15:07:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IlDJTt94-uQG; Thu, 29 Nov 2018 15:07:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435K8d1cvGz9vGDm;
 Thu, 29 Nov 2018 15:07:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 756768B89E;
 Thu, 29 Nov 2018 15:07:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7_a1AQVb5AQf; Thu, 29 Nov 2018 15:07:14 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A8BA8B899;
 Thu, 29 Nov 2018 15:07:14 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D647F69AE8; Thu, 29 Nov 2018 14:07:13 +0000 (UTC)
Message-Id: <a16697297f3c1b25188942dcfef77771d00e57ef.1543499865.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 14/20] powerpc/8xx: Temporarily disable 16k pages and
 hugepages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 14:07:13 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation of making use of hardware assistance in TLB handlers,
this patch temporarily disables 16K pages and hugepages. The reason
is that when using HW assistance in 4K pages mode, the linux model
fit with the HW model for 4K pages and 8M pages.

However for 16K pages and 512K mode some additional work is needed
to get linux model fit with HW model.
For the 8M pages, they will naturaly come back when we switch to
HW assistance, without any additional handling.
In order to keep the following patch smaller, the removal of the
current special handling for 8M pages gets removed here as well.

Therefore the 4K pages mode will be implemented first and without
support for 512k hugepages. Then the 512k hugepages will be brought
back. And the 16K pages will be implemented in the following step.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           |  2 +-
 arch/powerpc/kernel/head_8xx.S | 74 +++---------------------------------------
 arch/powerpc/mm/tlb_nohash.c   |  6 ----
 3 files changed, 6 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8be31261aec8..ddfccdf004fe 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -689,7 +689,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x || PPC_8xx
+	depends on 44x
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c203defe49a4..01f58b1d9ae7 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -314,7 +314,7 @@ SystemCall:
 InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mtspr	SPRN_SPRG_SCRATCH2, r12
 #endif
 
@@ -325,10 +325,8 @@ InstructionTLBMiss:
 	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfcr	r12
-#endif
 #ifdef ITLB_MISS_KERNEL
+	mfcr	r12
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
 	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
 #else
@@ -360,15 +358,9 @@ InstructionTLBMiss:
 
 	/* Extract level 2 index */
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
-	mtcr	r11
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
-#endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
-4:
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mtcr	r12
 #endif
 	/* Load the MI_TWC with the attributes for this "segment." */
@@ -393,7 +385,7 @@ InstructionTLBMiss:
 	/* Restore registers */
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
@@ -406,35 +398,12 @@ InstructionTLBMiss:
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-#ifdef CONFIG_PPC_16K_PAGES
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -472,11 +441,6 @@ DataStoreTLBMiss:
 	 */
 	/* Extract level 2 index */
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
-	mtcr	r11
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
-#endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
 4:
@@ -534,29 +498,6 @@ DataStoreTLBMiss:
 	rfi
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-	/* Extract level 2 index */
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -773,12 +714,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 
 	/* concat physical page address(r11) and page offset(r10) */
 200:
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT_8M - 2), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-#else
 	rlwinm	r11, r10, 0, ~HUGEPD_SHIFT_MASK
-#endif
 	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index ae5d568e267f..4f79639e432f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,12 +97,6 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
-	[MMU_PAGE_512K] = {
-		.shift	= 19,
-	},
-	[MMU_PAGE_8M] = {
-		.shift	= 23,
-	},
 };
 #else
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
-- 
2.13.3

