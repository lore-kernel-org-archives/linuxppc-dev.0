Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:58:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52657214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52657214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b8Hw3FvHzDqcF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 01:58:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b8G75nSNzDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 01:56:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43b8G20bGnz9v10Z;
 Thu, 10 Jan 2019 15:56:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rl9HS-dhm25l; Thu, 10 Jan 2019 15:56:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43b8G175pZz9v10W;
 Thu, 10 Jan 2019 15:56:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 723B68B899;
 Thu, 10 Jan 2019 15:56:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ht3OTm41Sfu5; Thu, 10 Jan 2019 15:56:27 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3323B8B898;
 Thu, 10 Jan 2019 15:56:27 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F37FE6BF21; Thu, 10 Jan 2019 14:56:26 +0000 (UTC)
Message-Id: <d61e312b60352073192975746c24901a37d881c7.1547132111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 10 Jan 2019 14:56:26 +0000 (UTC)
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

This patch replaces most #ifdef mess by IS_ENABLED() in 8xx_mmu.c
This has the advantage of allowing syntax verification at compile
time regardless of selected options.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/8xx_mmu.c | 65 +++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 1f339deea7e2..2300fe88e1f2 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -66,26 +66,22 @@ unsigned long p_block_mapped(phys_addr_t pa)
 void __init MMU_init_hw(void)
 {
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
-#ifdef CONFIG_PIN_TLB_DATA
-	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
-#ifdef CONFIG_PIN_TLB_IMMR
-	int i = 29;
-#else
-	int i = 28;
-#endif
-	unsigned long addr = 0;
-	unsigned long mem = total_lowmem;
-
-	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
-		mtspr(SPRN_MD_CTR, ctr | (i << 8));
-		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
-		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
-		addr += LARGE_PAGE_SIZE_8M;
-		mem -= LARGE_PAGE_SIZE_8M;
+	if (IS_ENABLED(CONFIG_PIN_TLB_DATA)) {
+		unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
+		unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
+		int i = IS_ENABLED(CONFIG_PIN_TLB_IMMR) ? 29 : 28;
+		unsigned long addr = 0;
+		unsigned long mem = total_lowmem;
+
+		for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
+			mtspr(SPRN_MD_CTR, ctr | (i << 8));
+			mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
+			mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
+			mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
+			addr += LARGE_PAGE_SIZE_8M;
+			mem -= LARGE_PAGE_SIZE_8M;
+		}
 	}
-#endif
 }
 
 static void __init mmu_mapin_immr(void)
@@ -110,18 +106,15 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	if (__map_without_ltlbs) {
 		mapped = 0;
 		mmu_mapin_immr();
-#ifndef CONFIG_PIN_TLB_IMMR
-		patch_instruction_site(&patch__dtlbmiss_immr_jmp, PPC_INST_NOP);
-#endif
-#ifndef CONFIG_PIN_TLB_TEXT
-		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
-#endif
+		if (!IS_ENABLED(CONFIG_PIN_TLB_IMMR))
+			patch_instruction_site(&patch__dtlbmiss_immr_jmp, PPC_INST_NOP);
+		if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
-#ifndef CONFIG_PIN_TLB_TEXT
-		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top,
-				    _ALIGN(__pa(_einittext), 8 << 20));
-#endif
+		if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top,
+					    _ALIGN(__pa(_einittext), 8 << 20));
 	}
 
 	mmu_patch_cmp_limit(&patch__dtlbmiss_linmem_top, mapped);
@@ -166,14 +159,14 @@ void set_context(unsigned long id, pgd_t *pgd)
 {
 	s16 offset = (s16)(__pa(swapper_pg_dir));
 
-#ifdef CONFIG_BDI_SWITCH
-	pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
+	if (IS_ENABLED(CONFIG_BDI_SWITCH)) {
+		pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
 
-	/* Context switch the PTE pointer for the Abatron BDI2000.
-	 * The PGDIR is passed as second argument.
-	 */
-	*(ptr + 1) = pgd;
-#endif
+		/* Context switch the PTE pointer for the Abatron BDI2000.
+		 * The PGDIR is passed as second argument.
+		 */
+		*(ptr + 1) = pgd;
+	}
 
 	/* Register M_TWB will contain base address of level 1 table minus the
 	 * lower part of the kernel PGDIR base address, so that all accesses to
-- 
2.13.3

