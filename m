Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED120C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 16:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F9A2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Awv3v4aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F9A2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4404Dq1RSPzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 03:07:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Awv3v4aW"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4404C350nVzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 03:06:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4404By67BYz9vKHs;
 Wed, 13 Feb 2019 17:06:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Awv3v4aW; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id JkcZxiPCcmkG; Wed, 13 Feb 2019 17:06:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4404By50clz9vKHr;
 Wed, 13 Feb 2019 17:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550073978; bh=8ErHIAMKq6v8CWQ3FEQ3Gj9oj8klOJFs8lShbzUGTeU=;
 h=From:Subject:To:Cc:Date:From;
 b=Awv3v4aWzbSnc+27jOBcFaUk6FRiJ46Y5jYMcBZTjTt6nFEqiBekG05fZYOW0qSmh
 GW5S09PUcYLKy3mrVYHRc6pZu0H3JrypbMujRjkoLjirv7x/yBWKHAlHhQyhudEk0l
 W0h140KRJJWl75ge/IAw43h31bDi8bvrE5iSQPng=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F39A8B876;
 Wed, 13 Feb 2019 17:06:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SPCs4reF-30U; Wed, 13 Feb 2019 17:06:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 231358B756;
 Wed, 13 Feb 2019 17:06:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 04E2869D7C; Wed, 13 Feb 2019 16:06:19 +0000 (UTC)
Message-Id: <21f171c0cbd460905a134ce9b9afc2ecb5277269.1550073540.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] powerpc/8xx: replace most #ifdef by IS_ENABLED() in
 8xx_mmu.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 13 Feb 2019 16:06:19 +0000 (UTC)
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
 v3: no change

 v2: left CONFIG_BDI_SWITCH change aside as it goes away in another patch

 arch/powerpc/mm/8xx_mmu.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index bfa503cff351..92b677faea8c 100644
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
@@ -110,12 +106,10 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
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
 	}
-- 
2.13.3

