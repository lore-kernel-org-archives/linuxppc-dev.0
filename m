Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF11ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:19:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EDC20869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EDC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42by3X5CpDzF3FL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:19:52 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxW75TrnzF3Vn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxW34Jkrz9ttFT;
 Fri, 19 Oct 2018 08:55:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CGWfijFFKmI1; Fri, 19 Oct 2018 08:55:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxW33ngJz9ttFM;
 Fri, 19 Oct 2018 08:55:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A94998B8DF;
 Fri, 19 Oct 2018 08:55:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QwpsrPdsAq60; Fri, 19 Oct 2018 08:55:12 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8452A8B75B;
 Fri, 19 Oct 2018 08:55:12 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 600986F496; Fri, 19 Oct 2018 06:55:12 +0000 (UTC)
Message-Id: <4d14168ad502bbad2e11e2df9162f81e50bb6cb0.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 10/20] powerpc/8xx: Temporarily disable 16k pages and 512k
 hugepages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:12 +0000 (UTC)
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
this patch temporarily disables 16K pages and 512K pages. The reason
is that when using HW assistance in 4K pages mode, the linux model
fit with the HW model for 4K pages and 8M pages.

However for 16K pages and 512K mode some additional work is needed
to get linux model fit with HW model.

Therefore the 4K pages mode will be implemented first and without
support for 512k hugepages. Then the 512k hugepages will be brought
back. And the 16K pages will be implemented in further steps.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           |  2 +-
 arch/powerpc/kernel/head_8xx.S | 36 ------------------------------------
 arch/powerpc/mm/tlb_nohash.c   |  3 ---
 3 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3d008115fe18..287befcf37ab 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -690,7 +690,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x || PPC_8xx
+	depends on 44x
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c203defe49a4..9b31721b522c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -363,7 +363,6 @@ InstructionTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -414,23 +413,8 @@ InstructionTLBMiss:
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
-#ifdef CONFIG_PPC_16K_PAGES
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
 	/* Level 2 base */
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
 	b	4b
 #endif
@@ -475,7 +459,6 @@ DataStoreTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -537,22 +520,8 @@ DataStoreTLBMiss:
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
 	/* Extract level 2 index */
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
 	/* Level 2 base */
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
 	b	4b
 #endif
@@ -773,12 +742,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 
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
index ae5d568e267f..8ad7aab150b7 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,9 +97,6 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
-	[MMU_PAGE_512K] = {
-		.shift	= 19,
-	},
 	[MMU_PAGE_8M] = {
 		.shift	= 23,
 	},
-- 
2.13.3

