Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BEC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:38:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC962081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oReuuvNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC962081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qftR1mspzDqY5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:38:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oReuuvNO"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhZ57cVzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:33 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhS6mQ7z9v06m;
 Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oReuuvNO; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id lVzmeJPcinRv; Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhS4hPBz9v06V;
 Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202568; bh=V3Ay+oVpeMvFnmoC0pfU9lApmae+qc8K7Kd/t0Mltng=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=oReuuvNORsPMYAXcbYqLetX8wZqDCuQnrhMU9Q6N3jaG5AgmnLlzNonm5LKbR0T7I
 EKHG4q1ld6sz2455o+zYv80aeN9gWA6aee7u3wnxVDeni4SpZU4lIfgyY+/qaleOQr
 cS/SLOpCDaSRq+4nQYM9hQnmHP/CtVa8gjXl3dcw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F9028B932;
 Thu, 25 Apr 2019 16:29:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id CPwrahaT6Ana; Thu, 25 Apr 2019 16:29:30 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DCFA18B923;
 Thu, 25 Apr 2019 16:29:29 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A001566276; Thu, 25 Apr 2019 14:29:29 +0000 (UTC)
Message-Id: <633e11daecb440a8233890589a4025ed5003f222.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/11] powerpc/mm: hand a context_t over to
 slice_mask_for_size() instead of mm_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:29 +0000 (UTC)
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

slice_mask_for_size() only uses mm->context, so hand directly a
pointer to the context. This will help moving the function in
subarch mmu.h in the next patch by avoiding having to include
the definition of struct mm_struct

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 35b278082391..8eb7e8b09c75 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -151,32 +151,32 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
-static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
+static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
 {
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
-		return mm_ctx_slice_mask_64k(&mm->context);
+		return mm_ctx_slice_mask_64k(&ctx);
 #endif
 	if (psize == MMU_PAGE_4K)
-		return mm_ctx_slice_mask_4k(&mm->context);
+		return mm_ctx_slice_mask_4k(&ctx);
 #ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_16M)
-		return mm_ctx_slice_mask_16m(&mm->context);
+		return mm_ctx_slice_mask_16m(&ctx);
 	if (psize == MMU_PAGE_16G)
-		return mm_ctx_slice_mask_16g(&mm->context);
+		return mm_ctx_slice_mask_16g(&ctx);
 #endif
 	BUG();
 }
 #elif defined(CONFIG_PPC_8xx)
-static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
+static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
 {
 	if (psize == mmu_virtual_psize)
-		return &mm->context.mask_base_psize;
+		return &ctx->mask_base_psize;
 #ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_512K)
-		return &mm->context.mask_512k;
+		return &ctx->mask_512k;
 	if (psize == MMU_PAGE_8M)
-		return &mm->context.mask_8m;
+		return &ctx->mask_8m;
 #endif
 	BUG();
 }
@@ -246,7 +246,7 @@ static void slice_convert(struct mm_struct *mm,
 	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
 	slice_print_mask(" mask", mask);
 
-	psize_mask = slice_mask_for_size(mm, psize);
+	psize_mask = slice_mask_for_size(&mm->context, psize);
 
 	/* We need to use a spinlock here to protect against
 	 * concurrent 64k -> 4k demotion ...
@@ -263,7 +263,7 @@ static void slice_convert(struct mm_struct *mm,
 
 		/* Update the slice_mask */
 		old_psize = (lpsizes[index] >> (mask_index * 4)) & 0xf;
-		old_mask = slice_mask_for_size(mm, old_psize);
+		old_mask = slice_mask_for_size(&mm->context, old_psize);
 		old_mask->low_slices &= ~(1u << i);
 		psize_mask->low_slices |= 1u << i;
 
@@ -282,7 +282,7 @@ static void slice_convert(struct mm_struct *mm,
 
 		/* Update the slice_mask */
 		old_psize = (hpsizes[index] >> (mask_index * 4)) & 0xf;
-		old_mask = slice_mask_for_size(mm, old_psize);
+		old_mask = slice_mask_for_size(&mm->context, old_psize);
 		__clear_bit(i, old_mask->high_slices);
 		__set_bit(i, psize_mask->high_slices);
 
@@ -538,7 +538,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	maskp = slice_mask_for_size(mm, psize);
+	maskp = slice_mask_for_size(&mm->context, psize);
 
 	/*
 	 * Here "good" means slices that are already the right page size,
@@ -565,7 +565,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * a pointer to good mask for the next code to use.
 	 */
 	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
-		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
+		compat_maskp = slice_mask_for_size(&mm->context, MMU_PAGE_4K);
 		if (fixed)
 			slice_or_mask(&good_mask, maskp, compat_maskp);
 		else
@@ -760,7 +760,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	/*
 	 * Slice mask cache starts zeroed, fill the default size cache.
 	 */
-	mask = slice_mask_for_size(mm, psize);
+	mask = slice_mask_for_size(&mm->context, psize);
 	mask->low_slices = ~0UL;
 	if (SLICE_NUM_HIGH)
 		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
@@ -819,14 +819,14 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 
 	VM_BUG_ON(radix_enabled());
 
-	maskp = slice_mask_for_size(mm, psize);
+	maskp = slice_mask_for_size(&mm->context, psize);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* We need to account for 4k slices too */
 	if (psize == MMU_PAGE_64K) {
 		const struct slice_mask *compat_maskp;
 		struct slice_mask available;
 
-		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
+		compat_maskp = slice_mask_for_size(&mm->context, MMU_PAGE_4K);
 		slice_or_mask(&available, maskp, compat_maskp);
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
-- 
2.13.3

