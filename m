Return-Path: <linuxppc-dev+bounces-26248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE069C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLrK5wkFz2yDs;
	Mon, 31 Aug 2026 17:55:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162913;
	cv=none; b=VcySGrZG89P9Q+m2u+1Y0IogaeoV/3C2VidVyFbsSTXvFx17qvvgFI658/tQGerLKZuk0/TLa+/esac5pO/W6wEJjlwNHIwTvqE+I6sB9twTvjkY4cX9zlabUUUrCWys7CnJby1sZzaxt0b9PaYRa93hskAsO/G7u56vjiIk51Lb8OGSbttMkieWFaD/Hqjuy/5hP3pqigqicQlKDpty0e8HYwmRgP4cRInuvBNYb8zo8KQesHIyHLbQ8CAaKiOKvihHK7VcYEUS7CukKFE6A2y7wqk6QovNPw5DHDS3ghP7vJzHGDpEmlLW1h9mJPaFupQXENqHXEYROka/HLJUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162913; c=relaxed/relaxed;
	bh=0tkr6D1mJkSgu6ygeW9vA9keYBBS8zHk8hkf8RCBkSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhu6m1TtMrIi+ZfdNIxKBB/S0vrLUobelhUF62bc68yWkCino8ZKORZmFsa6xtjDnqVe2jPdMnuTQQZfjbLT7MVYOO83mxfwNPiyDbvxam4FKorICZOf6dpXb2fSxWJGlztPc6MchnAt700UfbHuZ9cXwEOU88EoD2cSTuD4m2iTufDi+QaeJa91jZnfdz48eR8nlfv6KzXkss/lLG6uxUiQAjFC5UD2SgEsfGj+YCjkXPGHyU9Ut0IQnft90XoLeCiAtw1De8RldVUitu/tXd24avHMiR/Bfd/CwrEhvWFsAD5xEThEASakVqDwkA5MpD3cenKPpXrSxzRblwZxtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jxKvx8Dv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jxKvx8Dv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLrJ5Y7Vz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:55:12 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8485b358552so3095597b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162911; x=1788767711; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tkr6D1mJkSgu6ygeW9vA9keYBBS8zHk8hkf8RCBkSI=;
        b=jxKvx8DvAwaPpC5DdYa6f4ePHg35Y+xxoDGjT0Hoat4aiPFdfJw2XtDRQaCvAPeYpb
         pWdWa62YUAjk+ryhegbixNs/WBNI17yt0/7Iof2/gl/h5/JOYbXnWTkDtVGA68oEKSKt
         fwVRT2WDNp1AvUIkLWvqEeW1B2N4cbS64qX6snnZtjtyN1Ge7eh7Falx2ubhfN/K1soQ
         qDbEcLCIxMh5Xe0Ng88FpyIV1owQxWZW6hSTQ8XMgGk7SzvnElKQIJnjGzlimnE2MJH8
         PHkeo+ubEwrv4FQH33jG1IbrFOvAiFF+7sZ57YhnfoYBzs6ADnSL6L8X4DccZsIDt/7n
         f+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162911; x=1788767711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tkr6D1mJkSgu6ygeW9vA9keYBBS8zHk8hkf8RCBkSI=;
        b=MOmZMgbepc7fpG8Ahvywu6jATglNXFLXZS3e941dOZ1rT0Q87kIDZ4NYLpl9fYbH4L
         9AAVGW0h5cXJ54sb9UCxPVi9lcEbO+nb3cmz4gvMK05mBsd8218C5fvE+spzgPopxoXR
         3x+qVjCmucFrBNFPA50dOqp3VHYdXlOzdXIMnnZdaU1gIdRBhrIn3HaG5gBYkOh3aoRJ
         dgutv3Zn3IIHDCKfBMa4m82WtcPROIAynHtFnqMV0ldqwaqN0RTkP32Oa6R/z4Mqnp3n
         2s6HiGqdq/Mg82I2XU1r9BJo1jdz2e4F+soABJioZPsFUS/kNOMGIGfUjqj31afMLbGC
         CkmA==
X-Forwarded-Encrypted: i=1; AHgh+Rp66C1Qnxnqjvg0A0XoAhRluStukuXrNhzoUgp7nIcOlumRrnPAapAIhiWVXzW6JIOZUNEW+ZFzu/nsC2g=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mAoHYphJO70sbWyQM5Iixp4qbJG7j8ew98eQSPQ5iSqAE423G6
	fHslrm7xhqJapT/7xY5iPdiYV71MdP6qa25pQLZGrI06QlAqpqBgTNRLBlAxxfuS2a4=
X-Gm-Gg: AR+sD11iZ7IWYjvVfCM7fvypfLKSgQXd/gaTcrYWsUUlIVkuz8eRkzS4PLnwJnNLqbY
	oVawjeTsbJnq6lYJCcBcfFtix5T25T3hHBWhvkPo9CuNYJeU+ivod2TqYeICLm8GuERUOrEl60G
	LHzUjD0YBRGjj4mrvPatNfHtMRR/M6FEuOkbWytHEL92CXjDhvxxWVjXaDGAVTLzXgwcuAN6iMB
	+v/bs83Sc4oA7WjhQ64q4O/HJocojF0h/2Wa53Du8oWkRloyrRHwJm6/9Y1zjYe3gevEaqrbH7m
	KhMC4Hi0tnYH1aarNGMxptB2F3VKhHi0/dCIGHZ9IJKFrH1Iq7M6eLJFQfVSIMlDNqtJF861jD7
	g4SD5pW+M99J9ZwkGxmjs18+VrzQuVXj7oR5DN6rXuMjfI12wUR1+xbeAiV7PtpI/7N9FlrPnmn
	5iJupBRd/8foafJC4wVV2C9O7fSesHpVkjScAZR197bg27W06sy0UBLJlQHlXMCxKqpmWe5Zez2
	EvIAljzSPXv+UBATEDotWfO
X-Received: by 2002:a05:6a00:1c9a:b0:84e:9257:d0c2 with SMTP id d2e1a72fcca58-8562a00149emr40654262b3a.9.1788162909920;
        Mon, 31 Aug 2026 00:55:09 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:55:09 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 09/11] mm/sparse-vmemmap: drop the extra tail page from device DAX reservation
Date: Mon, 31 Aug 2026 15:53:40 +0800
Message-ID: <20260831075342.57563-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device DAX vmemmap population still reserves one extra tail vmemmap
page after the head page.

Drop that extra reservation and let the shared tail page cover all tail
vmemmap pages after the head page, so DAX follows the same reservation
model as HugeTLB.

This reduces the reserved vmemmap pages for optimized DAX mappings to
one and removes the now-unneeded first-tail population from the generic
and powerpc paths to simplify the code as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 46 ++----------------------
 include/linux/mm.h                       |  3 +-
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 13 ++-----
 4 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 831c231a4a18..e7e751c48dd2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1218,39 +1218,6 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-static pte_t * __meminit radix__vmemmap_populate_address(unsigned long addr, int node,
-							 struct vmem_altmap *altmap,
-							 struct page *reuse)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset_k(addr);
-	p4d = p4d_offset(pgd, addr);
-	pud = vmemmap_pud_alloc(p4d, node, addr);
-	if (!pud)
-		return NULL;
-	pmd = vmemmap_pmd_alloc(pud, node, addr);
-	if (!pmd)
-		return NULL;
-	if (pmd_leaf(*pmd))
-		/*
-		 * The second page is mapped as a hugepage due to a nearby request.
-		 * Force our mapping to page size without deduplication
-		 */
-		return NULL;
-	pte = vmemmap_pte_alloc(pmd, node, addr);
-	if (!pte)
-		return NULL;
-	radix__vmemmap_pte_populate(pmd, addr, node, NULL, NULL);
-	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
-
-	return pte;
-}
-
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					      unsigned long start,
 					      unsigned long end, int node,
@@ -1297,7 +1264,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pte_none(*pte)) {
 			/*
 			 * This could be because we already have a compound
-			 * page whose VMEMMAP_RESERVE_NR pages were mapped and
+			 * page whose retained vmemmap page was mapped and
 			 * this request fall in those pages.
 			 */
 			next = addr + PAGE_SIZE;
@@ -1318,16 +1285,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				/*
-				 * Populate the tail pages vmemmap page
-				 * It can fall in different pmd, hence
-				 * vmemmap_populate_address()
-				 */
-				pte = radix__vmemmap_populate_address(addr + PAGE_SIZE, node, NULL, NULL);
-				if (!pte)
-					return -ENOMEM;
-
-				next = addr + 2 * PAGE_SIZE;
+				next = addr + PAGE_SIZE;
 				continue;
 			}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index edadd7549b72..edc7b9ce9e79 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5180,7 +5180,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
@@ -5200,7 +5199,7 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
 	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
 	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
+	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
 }
 /*
  * If we don't have an architecture override, use the generic rule
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c4cd61978ce8..d520fd8de0df 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1049,7 +1049,7 @@ static inline unsigned long compound_nr_pages(unsigned long pfn,
 	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
-	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
+	return VMEMMAP_OPTIMIZATION_PAGES * (PAGE_SIZE / sizeof(struct page));
 }
 
 static void __ref memmap_init_compound(struct page *head,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 0201877a7f80..e655d9d1348f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -136,7 +136,6 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_order(ms);
-	const int vmemmap_pages = pgmap ? VMEMMAP_RESERVE_NR : VMEMMAP_OPTIMIZATION_PAGES;
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
@@ -147,13 +146,13 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 
 	if (order < PFN_SECTION_SHIFT) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return vmemmap_pages * nr_pages / pages_per_compound;
+		return VMEMMAP_OPTIMIZATION_PAGES * nr_pages / pages_per_compound;
 	}
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
 
 	if (IS_ALIGNED(pfn, pages_per_compound))
-		return vmemmap_pages;
+		return VMEMMAP_OPTIMIZATION_PAGES;
 
 	return 0;
 }
@@ -521,17 +520,11 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		if (!pte)
 			return -ENOMEM;
 
-		/* Populate the tail pages vmemmap page */
-		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, -1, flags);
-		if (!pte)
-			return -ENOMEM;
-
 		/*
 		 * Reuse the shared page for the rest of tail pages
 		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
 		 */
-		next += PAGE_SIZE;
+		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
 					    page_to_pfn(page), flags);
 		if (rc)
-- 
2.54.0


