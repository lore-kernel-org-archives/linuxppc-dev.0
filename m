Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4AC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3A72184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="c+uFbXNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3A72184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRPV1Y1yzDq6J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:44:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="c+uFbXNj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZF3Qd6zDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:07:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZ86zn1z9vC0D;
 Wed, 20 Mar 2019 11:06:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=c+uFbXNj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id umyeJqd1wBQu; Wed, 20 Mar 2019 11:06:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ85jDyz9vByx;
 Wed, 20 Mar 2019 11:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076416; bh=3wj14ovWj0bxI9kXPpQeF2rROgvA1DxngsyiMABrpko=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=c+uFbXNjsDcEU+OdYuvAFRkiK+Jp1yxtgIRv9gD6FiOAIK6jNWLRhqu4EJADZgv6t
 SGPfx4MM9P9uH1wCEzTrFXWpUvWTTLJn4GC3RN8VFJKG/NJmqwhbi0VKV98LHAfxk4
 dBJaQSZU0xe9wo6HAHxiXRM/88ODs6HghBL/HdcI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E49F08B918;
 Wed, 20 Mar 2019 11:06:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2IsWvKPiThur; Wed, 20 Mar 2019 11:06:57 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C1AB48B911;
 Wed, 20 Mar 2019 11:06:57 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 95B6363AEF; Wed, 20 Mar 2019 10:06:57 +0000 (UTC)
Message-Id: <a4787f336899dfe3650506e8d79b4634bd4f13e4.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 21/27] powerpc/mm: hand a context_t over to
 slice_mask_for_size() instead of mm_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:57 +0000 (UTC)
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
index f98b9e812c62..231fd88d97e2 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -127,33 +127,33 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
-static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
+static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
 {
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
-		return &mm->context.mask_64k;
+		return &ctx->mask_64k;
 #endif
 	if (psize == MMU_PAGE_4K)
-		return &mm->context.mask_4k;
+		return &ctx->mask_4k;
 #ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_16M)
-		return &mm->context.mask_16m;
+		return &ctx->mask_16m;
 	if (psize == MMU_PAGE_16G)
-		return &mm->context.mask_16g;
+		return &ctx->mask_16g;
 #endif
 	WARN_ON(true);
 	return NULL;
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
 	WARN_ON(true);
 	return NULL;
@@ -221,7 +221,7 @@ static void slice_convert(struct mm_struct *mm,
 	unsigned long i, flags;
 	int old_psize;
 
-	psize_mask = slice_mask_for_size(mm, psize);
+	psize_mask = slice_mask_for_size(&mm->context, psize);
 
 	/* We need to use a spinlock here to protect against
 	 * concurrent 64k -> 4k demotion ...
@@ -238,7 +238,7 @@ static void slice_convert(struct mm_struct *mm,
 
 		/* Update the slice_mask */
 		old_psize = (lpsizes[index] >> (mask_index * 4)) & 0xf;
-		old_mask = slice_mask_for_size(mm, old_psize);
+		old_mask = slice_mask_for_size(&mm->context, old_psize);
 		old_mask->low_slices &= ~(1u << i);
 		psize_mask->low_slices |= 1u << i;
 
@@ -257,7 +257,7 @@ static void slice_convert(struct mm_struct *mm,
 
 		/* Update the slice_mask */
 		old_psize = (hpsizes[index] >> (mask_index * 4)) & 0xf;
-		old_mask = slice_mask_for_size(mm, old_psize);
+		old_mask = slice_mask_for_size(&mm->context, old_psize);
 		__clear_bit(i, old_mask->high_slices);
 		__set_bit(i, psize_mask->high_slices);
 
@@ -504,7 +504,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	maskp = slice_mask_for_size(mm, psize);
+	maskp = slice_mask_for_size(&mm->context, psize);
 
 	/*
 	 * Here "good" means slices that are already the right page size,
@@ -531,7 +531,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * a pointer to good mask for the next code to use.
 	 */
 	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
-		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
+		compat_maskp = slice_mask_for_size(&mm->context, MMU_PAGE_4K);
 		if (fixed)
 			slice_or_mask(&good_mask, maskp, compat_maskp);
 		else
@@ -709,7 +709,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	/*
 	 * Slice mask cache starts zeroed, fill the default size cache.
 	 */
-	mask = slice_mask_for_size(mm, psize);
+	mask = slice_mask_for_size(&mm->context, psize);
 	mask->low_slices = ~0UL;
 	if (SLICE_NUM_HIGH)
 		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
@@ -766,14 +766,14 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 
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

