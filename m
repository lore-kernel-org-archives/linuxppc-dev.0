Return-Path: <linuxppc-dev+bounces-26710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9664C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:05:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81Q527Gz2yqL;
	Tue, 08 Sep 2026 13:04:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836682;
	cv=none; b=HqTM9NeTZjP8NRlmDTquyzDz0CVCMTkDnPQcwsi6SViOG5ovnVgBjQQyp2JVrGkNtqnj8cT7lVmPlOpe0siJI4J0xdHAZXh8zFOa13eIXt+iQCBBNSY15nwWb4+dTWMdH1FOZjIim/FK1LixuzymV+zLBvkIxhSLr8G/dxbvWcXpldzBKuDSqEis8m2hEOoY7hQY4UhTwMP9eQAdD23mFGc0/ncgbGHSzUw0ZnN7etkP4UqsZBu1G0q/nWGGQmUC2MKgJwaNseSGNRhMpUC37iAY8qLLdMHmlBcpqwU3jTO+GkqL3CZez8QOmBJYkZZj3sh3oO8C7QHSpzDeUlGNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836682; c=relaxed/relaxed;
	bh=wfKr3rCUX839N8PLHteC+GkG6En7LO38FWq77XHuH2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKBnukH2SmhvAgL2shdqlI3oVKswFfJZX2wrsX20nf7AH19cNy4YTQu8aFVLHCG1deh4DzKfVu1KA4PKk8Wzb6tjzx00BWm3j4iXf8KQ+9jqtF41/0zPOCq+TE6uX2pHYzZe4/JADQcnVaY1wrOgtCZ9OKpWfgeJzg08Zbnhdw/W9HIrcX8Zl0iusIMFbeM92nbdFhDzLFWLHpdxB0QE3SFl4ac6aOmITFGUJ30+L8QiC+MtGktq6kCS7J8/teuNqvl6kGJ/eCdLp3RXHU+oBjfbEM9wSMyksmgkiQQX/i3el6uqVM2wujAudtIvY/OIdY94zDA2CcyV4YNkGERx4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IuoMGVUu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IuoMGVUu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf81P6XcWz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:41 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-862815e2683so2525323b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836680; x=1789441480; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wfKr3rCUX839N8PLHteC+GkG6En7LO38FWq77XHuH2Y=;
        b=IuoMGVUusHWaZvAWjyr/XfM8StCG7fBarHdsDpZTSAbZDLoLAaYyEJeXvFtkv55Y0Y
         i08f1OgmyKHOfUowBOKSSdWAnZoXdPxm+klngxdc71XvJRItQ1RBNNtSunZD5MfOgWIA
         mFkXUefpCtb/au1ssmU1EYCYuGDy8uw8K/uIyZ7DQOX03iyGl5zU7jSNF1W3/qx1Q4ec
         q4lNXhK+Y9P4jAl9uJUYlEBbbvLhrXfbyhi7Ke20TULVk/6+ahLJOR2aOZstvE5K/+mI
         V4pPLZcYVC2w9943RTpA5HK4oMSq13anpEAO+eSrL+8sJ+C0k+oUOTzSBXJ0CCvgDesx
         9Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836680; x=1789441480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wfKr3rCUX839N8PLHteC+GkG6En7LO38FWq77XHuH2Y=;
        b=ExkKaSHU+uHK8YMm3CwtxQ6iiM0x5F0QycvAzzn+bK4+eSbMqPpC3G4sxuGcfM74kD
         paO0ra45GCdyAXctrQzhJlN+AoD1474MQV5ubIl1NRtC9C87yKxQJGHdT/TUXQDYxp8P
         faShVhF8ZZqwMLep50u6Q61oVkV3MqbSFYl4rezUzGJLnDa/pC9Au+VemrI3rxCy6dP5
         JVDgm0heg4vo4r8rQLN9kJ/yCybaepVPKBkiSShIWJxiRFL/pJaM7vrJMWWO6IrULyzq
         HpYME6l7DX2vpjcTfxR6A2mY2pRcMbu1YdokLgQ/CSw8dCCuybpByd95PrcIrnz73eW4
         XScA==
X-Forwarded-Encrypted: i=1; AKwUvBxbHtfSlHqKf1zQSQ2XxrrRF7PemoFpXPJeAcVFEcUkbkq3WfR8OoHHpmRRnBiHkjBo2gsfLKGRGW2fPPs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lvm4JUd3JLOrmDT2rrXhUJG3QztOa7yCVDFQM6u/Wo13U2439T
	Bm8rrJo87d3D5oAHP1P4pyBTSq0L3F0FQDEGkwnUTrG43bktBxDxlrpaK6zHGB33Q9g=
X-Gm-Gg: AYBFou0acjvRTkfQYbTfLSq4q+FWBa8VlYkLYNXuI4eL4DMRgjfSAaUcq7vbn8fzvOm
	gJLSEreN2PEwNHkjCA+zPw9glUUf9EU53kX/z3S/9D5bigTi1fXE5fHmWlwKFZEwrg8cJqlZHdv
	hfyrXGed9pSyGTtSeZ/87i74vYOusTKFU+HiR6JnTkX9Y21aausLxnc3LUxzMFRUHW1UeUt7cg5
	3iGOWv0lTwkUGkKzzj1kzJvgWZXJryW9MW8RjgPkAG3r5Klglql45mYvtiGT7hNa2MPf+XoUgP9
	usXnYL4ev8SjlUKNeQdNZGnTfabs7bX/m1mnxwKBib4NC+HF65GzwouqOk5bF3nVInYbMYiN1Fs
	NY7yWKIKv4A+DqrjJtUZY5dAycJUr+UMU8T7iD1Gbw5AbQeIyspQJOMes/iBggybcJXS6yeQY/7
	Z3ywM6h9I1zO34VHW5oISYLqidXS6IYg1YRO+X+lBqREKA0qJxqN1NUX5X+5TTEUC0XYANf0EjY
	17TXbAbrsu5BeuuHfQdnqfH
X-Received: by 2002:a05:6a00:4f81:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-86166bc01c9mr34022528b3a.9.1788836679806;
        Mon, 07 Sep 2026 20:04:39 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:39 -0700 (PDT)
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
Subject: [PATCH v2 09/11] mm/sparse-vmemmap: drop the extra tail page from device DAX reservation
Date: Tue,  8 Sep 2026 11:03:33 +0800
Message-ID: <20260908030335.96549-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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
index a2ebe87e7654..969594074fd2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5167,7 +5167,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 					  struct dev_pagemap *pgmap)
@@ -5187,7 +5186,7 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
 	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
 	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
 	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
+	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
 }
 /*
  * If we don't have an architecture override, use the generic rule
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7a2e58d631c2..629420a83891 100644
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


