Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427CBC43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3825206BF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MQv/Q88M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3825206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qgGm4ZlZzDqHF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:55:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="MQv/Q88M"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhh5pHzzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhb6NvGz9v191;
 Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=MQv/Q88M; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6BQ8CGsX5bka; Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhb5Lvhz9v06V;
 Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202575; bh=9IPln7D4KRMZNphfhh9LxkOxBssa8KJfKmL3X4lBKzY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=MQv/Q88MnDgy1GevnaHD9Wgf2awATzXBfRIMB02WM+OFIbyTR0CrvkogUZuz+SQhM
 wJtVtZYzZNUkHf3rM6kqEy5pwjazDHS3rgXSALHCRJxURyzxBFmoGxeKAJdRqb+3/v
 ntAP6c0pvik/BU6R1TkkbDH0p4j378VeCCBboP0g=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8F78B931;
 Thu, 25 Apr 2019 16:29:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HCsUzkTsj201; Thu, 25 Apr 2019 16:29:37 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1216D8B923;
 Thu, 25 Apr 2019 16:29:37 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D072966276; Thu, 25 Apr 2019 14:29:36 +0000 (UTC)
Message-Id: <c21aee3bc21b17c7a3491ef07e563ba235aeb101.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/11] powerpc/mm: define subarch SLB_ADDR_LIMIT_DEFAULT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:36 +0000 (UTC)
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

This patch defines a subarch specific SLB_ADDR_LIMIT_DEFAULT
to remove the #ifdefs around the setup of mm->context.slb_addr_limit

It also generalises the use of mm_ctx_set_slb_addr_limit() helper.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 2 ++
 arch/powerpc/include/asm/nohash/32/slice.h | 2 ++
 arch/powerpc/mm/hash_utils_64.c            | 2 +-
 arch/powerpc/mm/slice.c                    | 6 +-----
 arch/powerpc/mm/tlb_nohash.c               | 4 +---
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index 062e11136e9c..f0d3194ba41b 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -11,4 +11,6 @@
 #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW_USER64
+
 #endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
index 777d62e40ac0..39eb0154ae2d 100644
--- a/arch/powerpc/include/asm/nohash/32/slice.h
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -13,6 +13,8 @@
 #define SLICE_NUM_HIGH		0ul
 #define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
 
+#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW
+
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f727197de713..884246e3bf0b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1050,7 +1050,7 @@ void __init hash__early_init_mmu(void)
 	htab_initialize();
 
 	init_mm.context.hash_context = &init_hash_mm_context;
-	init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+	mm_ctx_set_slb_addr_limit(&init_mm.context, SLB_ADDR_LIMIT_DEFAULT);
 
 	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ace97d953040..97fbf7b54422 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -704,11 +704,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	 * case of fork it is just inherited from the mm being
 	 * duplicated.
 	 */
-#ifdef CONFIG_PPC64
-	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW_USER64);
-#else
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#endif
+	mm_ctx_set_slb_addr_limit(&mm->context, SLB_ADDR_LIMIT_DEFAULT);
 	mm_ctx_set_user_psize(&mm->context, psize);
 
 	/*
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 088e0a6b5ade..ba4bff11191f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -802,9 +802,7 @@ void __init early_init_mmu(void)
 #endif
 
 #ifdef CONFIG_PPC_MM_SLICES
-#if defined(CONFIG_PPC_8xx)
-	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#endif
+	mm_ctx_set_slb_addr_limit(&init_mm.context, SLB_ADDR_LIMIT_DEFAULT);
 #endif
 }
 #endif /* CONFIG_PPC64 */
-- 
2.13.3

