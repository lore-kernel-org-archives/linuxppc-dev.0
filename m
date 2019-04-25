Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC2C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:34:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C43B2067D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eY+EvgBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C43B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qfp12znVzDqbD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:34:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="eY+EvgBl"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhZ5mYNzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:34 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhT5vppz9v06x;
 Thu, 25 Apr 2019 16:29:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=eY+EvgBl; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id U6aEaWtYe1JW; Thu, 25 Apr 2019 16:29:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhT4tcKz9v06V;
 Thu, 25 Apr 2019 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202569; bh=GVDuLoQb6VnPqNHr6ylViu69YpIvJCbNltXlI+5u404=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=eY+EvgBlBLxI5w3UJJCzHJezxWbwT/Fe52zf5qqeON0TF/xd7wNWCdvxfWaCLUn+E
 iyfXYLF9Wzttr8gAUpRmIIwn1iKYmSjE+QAysZhFap8Fa1HrrCWpwHt3u0AG3/WJB+
 miOsT47v4qr5SImtajg9SewgAQzdBtBhjJKHJI/0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 37E348B931;
 Thu, 25 Apr 2019 16:29:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id eYze8WkAalAN; Thu, 25 Apr 2019 16:29:31 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D334D8B923;
 Thu, 25 Apr 2019 16:29:30 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A699C66276; Thu, 25 Apr 2019 14:29:30 +0000 (UTC)
Message-Id: <f406fa36f3bf7bd8ec5bcf8e3d00f40270050c6a.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/11] powerpc/mm: move slice_mask_for_size() into mmu.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:30 +0000 (UTC)
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

Move slice_mask_for_size() into subarch mmu.h

At the same time, replace BUG() by VM_BUG_ON() as those BUG() are not
there to catch runtime errors but to catch errors during development
cycle only.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/mmu.h     | 17 +++++++++++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 42 +++++++++++++++++++---------
 arch/powerpc/mm/slice.c                      | 34 ----------------------
 3 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 230a9dec7677..ad00355f874f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -203,6 +203,23 @@ static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
 }
 #endif
 
+static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
+{
+#ifdef CONFIG_PPC_64K_PAGES
+	if (psize == MMU_PAGE_64K)
+		return mm_ctx_slice_mask_64k(&ctx);
+#endif
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_16M)
+		return mm_ctx_slice_mask_16m(&ctx);
+	if (psize == MMU_PAGE_16G)
+		return mm_ctx_slice_mask_16g(&ctx);
+#endif
+	VM_BUG_ON(psize != MMU_PAGE_4K);
+
+	return mm_ctx_slice_mask_4k(&ctx);
+}
+
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index c503e2f05e61..a0f6844a1498 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -184,7 +184,23 @@
 #define LOW_SLICE_ARRAY_SZ	SLICE_ARRAY_SIZE
 #endif
 
+#if defined(CONFIG_PPC_4K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_4K
+#elif defined(CONFIG_PPC_16K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_16K
+#define PTE_FRAG_NR		4
+#define PTE_FRAG_SIZE_SHIFT	12
+#define PTE_FRAG_SIZE		(1UL << 12)
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
+#define mmu_linear_psize	MMU_PAGE_8M
+
 #ifndef __ASSEMBLY__
+
+#include <linux/mmdebug.h>
+
 struct slice_mask {
 	u64 low_slices;
 	DECLARE_BITMAP(high_slices, 0);
@@ -255,6 +271,19 @@ static inline struct slice_mask *mm_ctx_slice_mask_8m(mm_context_t *ctx)
 	return &ctx->mask_8m;
 }
 #endif
+
+static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_512K)
+		return &ctx->mask_512k;
+	if (psize == MMU_PAGE_8M)
+		return &ctx->mask_8m;
+#endif
+	VM_BUG_ON(psize != mmu_virtual_psize);
+
+	return &ctx->mask_base_psize;
+}
 #endif /* CONFIG_PPC_MM_SLICE */
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
@@ -306,17 +335,4 @@ extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
 
 #endif /* !__ASSEMBLY__ */
 
-#if defined(CONFIG_PPC_4K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_4K
-#elif defined(CONFIG_PPC_16K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_16K
-#define PTE_FRAG_NR		4
-#define PTE_FRAG_SIZE_SHIFT	12
-#define PTE_FRAG_SIZE		(1UL << 12)
-#else
-#error "Unsupported PAGE_SIZE"
-#endif
-
-#define mmu_linear_psize	MMU_PAGE_8M
-
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 8eb7e8b09c75..31de91b65a64 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -150,40 +150,6 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 			__set_bit(i, ret->high_slices);
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
-{
-#ifdef CONFIG_PPC_64K_PAGES
-	if (psize == MMU_PAGE_64K)
-		return mm_ctx_slice_mask_64k(&ctx);
-#endif
-	if (psize == MMU_PAGE_4K)
-		return mm_ctx_slice_mask_4k(&ctx);
-#ifdef CONFIG_HUGETLB_PAGE
-	if (psize == MMU_PAGE_16M)
-		return mm_ctx_slice_mask_16m(&ctx);
-	if (psize == MMU_PAGE_16G)
-		return mm_ctx_slice_mask_16g(&ctx);
-#endif
-	BUG();
-}
-#elif defined(CONFIG_PPC_8xx)
-static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
-{
-	if (psize == mmu_virtual_psize)
-		return &ctx->mask_base_psize;
-#ifdef CONFIG_HUGETLB_PAGE
-	if (psize == MMU_PAGE_512K)
-		return &ctx->mask_512k;
-	if (psize == MMU_PAGE_8M)
-		return &ctx->mask_8m;
-#endif
-	BUG();
-}
-#else
-#error "Must define the slice masks for page sizes supported by the platform"
-#endif
-
 static bool slice_check_range_fits(struct mm_struct *mm,
 			   const struct slice_mask *available,
 			   unsigned long start, unsigned long len)
-- 
2.13.3

