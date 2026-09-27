Return-Path: <linuxppc-dev+bounces-28302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8842C9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspwG6Jcpz30fh;
	Sun, 27 Sep 2026 12:55:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477742;
	cv=none; b=bwWp1RMzFyFyjIrlNjplFTF1XFmdQQQw44RFGaxV3Umc0WXTaza5DIvPHHwRiRnuu1rqQCzi8QioMtTE3iVQ8NFtPuK5R+LM2mOjrE/8abfRiI9vhtMHCfJzzQIDikpta9PDOP0hmD6ib1sNkfm5f0ADAsRzB8UghqisN0xYE4ybLwX27431BD0rfnS2HXsX+JeTZdUUEPkPs3SkUXXLXh2ZnLRiggFiBx6DcHdBbFJDkcR1Tispr42cOs53J+EjZ5LyOqB69MPmX1kWL8xDiJAqG/V2SiIiYwkmfX/FSvMxNplHXTJ1k944xgID23Vze/ZWiJvNoiTscTopDAy/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477742; c=relaxed/relaxed;
	bh=uoDGlxDfQClS9LJzaMCGDThB6goPDglPo8AWl0LRFoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOu6JTNAfMn7BoX+1opYGVdVSxIwgc8wZxvYYwoE5OXoqeKRFPBVQCSFX6+MwiamVe2CzIAFrUBk4pUKMBfvaLGReJZnWhPhkzkOFQzdAw/+j9Y3SftETgiyL3Ak248nQxd4nh8HYvF60X49Zxarm9b8rXJbyLTRL8BkRKzUwg1hw63O547Ji4zSaLNwU4gjhr9qhacuxm9Eo2k3Ol4mll+8KbNT1nLhxVhuzYbXSGoL9V4JAk9SyaN4PIxk12z+6xUlqaDP2AQ4quoxhXpGto9yUKytEgGhoDZ5TKAogJU/A6wWQ1YPtCJlj4KH4KF49ikYUqN7FWip0gT8+ZjJqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lfv2OTuB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lfv2OTuB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com [IPv6:2607:f8b0:4864:3b::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspwG1GT4z3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:42 +1000 (AEST)
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so596944a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477740; x=1791082540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uoDGlxDfQClS9LJzaMCGDThB6goPDglPo8AWl0LRFoA=;
        b=lfv2OTuBvfpHeCR/csLfZrC0NUlSv5WBQHXelNjSaFILRe9UzLzJMHVDl17Br6js9V
         Z5CZ6s8DHwzEnyLZnPTkIu+/kDZpUmFObyjudC1tz6Oz5QKNT47/4Fz26C1KPL2IGWhe
         eoVBF5ni9rrCWlgJWNlkakcu6Wk4J4GvhLUWtlhTXQiUvM1xgNfXkBAerLJ0hqj2zFxw
         QqkQiC9lnTz2HqxEovcrUr8te0DP5lmjljUDUfw/9ZSFCXyDB8VWZ9rbSuF8klMN8+Rr
         M95a8+r2vQsa4DYJvqJGbKnCuZHXIcMRjtpR6M9YBTRzYVJs46LC+N4rewljjF/5Whq+
         4oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477740; x=1791082540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uoDGlxDfQClS9LJzaMCGDThB6goPDglPo8AWl0LRFoA=;
        b=1klGE1tuixIT6gceEJfw2nwKJhiUW64PGZzV5x3tFSLgUu6a5Xmr0BeFS8jZX2oz/t
         zOhRk4Ddjl0mQwXG9U8XuobihtFS3lrYLubR9vKS+a9dIo6ZxG0fHb8wrkaUSzbWBf0L
         RtpmXFk8mMG0cLsA3gDzTsV+HuwNgqSvxu6nxjMOLzEMD/3AJQnyAsEvR6AeHcey/m9s
         U+4gd5Vc8+ZGrBryLq/t9kWFRmc00b2A0HNCcgyfuZv872juyqAuiaH0p5NXos0PlWc1
         row6ejG+JnSmwC2BgerbIYh3lgfJm0t3Lsiq/diYqR9t+Dbb+1CH+4VlahmZDnrp329j
         gxxA==
X-Forwarded-Encrypted: i=1; AKwUvBzfc+08s+b6b8tbs1XfYcHInYj5B3gNGGj8Y2BK6J8/OBAJ7HP//z9h1OQHMoJTSg32Tmax90hOkIF8+ss=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKVP7NRoKh67/U05eJyYH45ZyjMCEoffK1dy+pZEARj2cIkCurF
	yhyRHv/me3b/vbmkC/t0Q+WSlHL4jlg6x4CA01V4coGjm1hPz7wYGXweKjnXyHju3gY=
X-Gm-Gg: AYBFou0OERO/DOUiKEIXNDFR8a+R0iCeSdJiVuUtHuN17netXOus3o+LxUC2ez0GQiU
	Q3kBP0ahsnGc88mxMCxA5Nz9dv7/Y+7TfKgRhyJ6bEED3GI94nbL8bkhChxb8aJl5K28slOXZdW
	gQQ8Nn+VY+IDO5+nP0KtRSaibZOS8otel4o7r0Zg/7/msjP6avtDu/3nutsFzNYunsmHWBzBVo9
	WRm3UeUgwbw2Uxpiusvw9ixbisya9TlicXwL/3HnaXia1dRjs/oc0ev7YS4mGJVy4paf7UVQxR7
	zK9df4Rg6eAUz676bOAe/ufRLzz1Tuvmf7Cmz2m1COJC7UY+95L4pNTvIfdBsgAwY9mfLdC+sls
	n16XuJfS0HINsk9hi1+T+qFNCnKVOToB5yX9J17bw9kgD11LURAEtXQ+7qPxUt+Cd9dnBCUzI4l
	8D+XVqSaTOOw6x1Ti3yrsuleDx4F2yzlvX8viAl3HrDHe7owglP3VP5N7wGWvRQRxwdS///P3Wm
	d9J2VTx9Jc77xXHxpft
X-Received: by 2002:a17:90a:e7c4:b0:39e:6c6a:4b73 with SMTP id 98e67ed59e1d1-3a098e3eef6mr8558907a91.61.1790477740110;
        Sat, 26 Sep 2026 19:55:40 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:39 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 10/12] mm/sparse-vmemmap: drop the extra tail page from device DAX reservation
Date: Sun, 27 Sep 2026 10:54:39 +0800
Message-ID: <20260927025441.741633-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 46 ++----------------------
 include/linux/mm.h                       |  4 +--
 mm/mm_init.c                             |  2 +-
 mm/sparse-vmemmap.c                      | 13 ++-----
 4 files changed, 8 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ee068f24a79f..9ca28e4a610a 100644
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
index 070ce27e9cd3..30a3365bca82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,6 +38,7 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
+#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5167,7 +5168,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
@@ -5187,7 +5187,7 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
 	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
 	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
+	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
 }
 /*
  * If we don't have an architecture override, use the generic rule
diff --git a/mm/mm_init.c b/mm/mm_init.c
index efffa8609b85..56bb4567a494 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1056,7 +1056,7 @@ static inline unsigned long compound_nr_pages(unsigned long pfn,
 	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
-	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
+	return VMEMMAP_OPTIMIZATION_PAGES * (PAGE_SIZE / sizeof(struct page));
 }
 
 static void __ref memmap_init_compound(struct page *head,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 4309f8b626f5..b6378826b9a2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -136,7 +136,6 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_compound_order(ms);
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
@@ -550,17 +549,11 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
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


