Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9700C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:33:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A363206D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A363206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgSjX4lrnzDqft
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 02:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgSWL0GTszDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 02:24:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CgSWB4BYwz9v0d9;
 Tue, 24 Nov 2020 16:24:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7cTqc_ntIoWS; Tue, 24 Nov 2020 16:24:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWB3NT4z9v0d5;
 Tue, 24 Nov 2020 16:24:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 178EF8B7B5;
 Tue, 24 Nov 2020 16:24:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6q8Yq4LHP8Ri; Tue, 24 Nov 2020 16:24:55 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 70B638B7B3;
 Tue, 24 Nov 2020 16:24:55 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4FE64668E2; Tue, 24 Nov 2020 15:24:55 +0000 (UTC)
Message-Id: <203b89de491e1379f1677a2685211b7c32adfff0.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/6] powerpc/8xx: Always pin kernel text TLB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 24 Nov 2020 15:24:55 +0000 (UTC)
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

There is no big poing in not pinning kernel text anymore, as now
we can keep pinned TLB even with things like DEBUG_PAGEALLOC.

Remove CONFIG_PIN_TLB_TEXT, making it always right.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig               |  3 +--
 arch/powerpc/kernel/head_8xx.S     | 20 +++-----------------
 arch/powerpc/mm/nohash/8xx.c       |  3 +--
 arch/powerpc/platforms/8xx/Kconfig |  7 -------
 4 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..bf088b5b0a89 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -795,8 +795,7 @@ config DATA_SHIFT_BOOL
 	bool "Set custom data alignment"
 	depends on ADVANCED_OPTIONS
 	depends on STRICT_KERNEL_RWX || DEBUG_PAGEALLOC
-	depends on PPC_BOOK3S_32 || (PPC_8xx && !PIN_TLB_DATA && \
-				     (!PIN_TLB_TEXT || !STRICT_KERNEL_RWX))
+	depends on PPC_BOOK3S_32 || (PPC_8xx && !PIN_TLB_DATA && !STRICT_KERNEL_RWX)
 	help
 	  This option allows you to set the kernel data alignment. When
 	  RAM is mapped by blocks, the alignment needs to fit the size and
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 66ee62f30d36..775b4f4d011e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -42,15 +42,6 @@
 #endif
 .endm
 
-/*
- * We need an ITLB miss handler for kernel addresses if:
- * - Either we have modules
- * - Or we have not pinned the first 8M
- */
-#if defined(CONFIG_MODULES) || !defined(CONFIG_PIN_TLB_TEXT)
-#define ITLB_MISS_KERNEL	1
-#endif
-
 /*
  * Value for the bits that have fixed value in RPN entries.
  * Also used for tagging DAR for DTLBerror.
@@ -209,12 +200,12 @@ InstructionTLBMiss:
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10)
 	mtspr	SPRN_MD_EPN, r10
-#ifdef ITLB_MISS_KERNEL
+#ifdef CONFIG_MODULES
 	mfcr	r11
 	compare_to_kernel_boundary r10, r10
 #endif
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-#ifdef ITLB_MISS_KERNEL
+#ifdef CONFIG_MODULES
 	blt+	3f
 	rlwinm	r10, r10, 0, 20, 31
 	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
@@ -618,10 +609,6 @@ start_here:
 	lis	r0, (MD_TWAM | MD_RSV4I)@h
 	mtspr	SPRN_MD_CTR, r0
 #endif
-#ifndef CONFIG_PIN_TLB_TEXT
-	li	r0, 0
-	mtspr	SPRN_MI_CTR, r0
-#endif
 #if !defined(CONFIG_PIN_TLB_DATA) && !defined(CONFIG_PIN_TLB_IMMR)
 	lis	r0, MD_TWAM@h
 	mtspr	SPRN_MD_CTR, r0
@@ -739,7 +726,6 @@ _GLOBAL(mmu_pin_tlb)
 	mtspr	SPRN_MD_CTR, r6
 	tlbia
 
-#ifdef CONFIG_PIN_TLB_TEXT
 	LOAD_REG_IMMEDIATE(r5, 28 << 8)
 	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET)
 	LOAD_REG_IMMEDIATE(r7, MI_SVALID | MI_PS8MEG | _PMD_ACCESSED)
@@ -760,7 +746,7 @@ _GLOBAL(mmu_pin_tlb)
 	bdnzt	lt, 2b
 	lis	r0, MI_RSV4I@h
 	mtspr	SPRN_MI_CTR, r0
-#endif
+
 	LOAD_REG_IMMEDIATE(r5, 28 << 8 | MD_TWAM)
 #ifdef CONFIG_PIN_TLB_DATA
 	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET)
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 231ca95f9ffb..19a3eec1d8c5 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -186,8 +186,7 @@ void mmu_mark_initmem_nx(void)
 	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
 	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
 
-	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
-		mmu_pin_tlb(block_mapped_ram, false);
+	mmu_pin_tlb(block_mapped_ram, false);
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index cdda034733ff..1a8400bfbe82 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -202,13 +202,6 @@ config PIN_TLB_IMMR
 	  CONFIG_PIN_TLB_DATA is also selected, it will reduce
 	  CONFIG_PIN_TLB_DATA to 24 Mbytes.
 
-config PIN_TLB_TEXT
-	bool "Pinned TLB for TEXT"
-	depends on PIN_TLB
-	default y
-	help
-	  This pins kernel text with 8M pages.
-
 endmenu
 
 endmenu
-- 
2.25.0

