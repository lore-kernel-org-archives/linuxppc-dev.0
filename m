Return-Path: <linuxppc-dev+bounces-29165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EFCA6017
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:58:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x1l4CK6z3bqV;
	Sat, 10 Oct 2026 18:58:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619115;
	cv=none; b=HCYKYCyK6sglrojM5u6F0SesQc69uarx82uV0z+RJmi7ADKLo8Jiqw6KZtSiaQhjQb7faKAAmoUCZ4xUMSK/Mb7aoduDMlGoTqysovVanBtK9xaBjrK+NTuDuiG6Yi+wCihvvTvNyxksHiXT71FfBFqTiP/UwH+VrJ4p0vKr62aCsoGpZBk5Fpfs+iSDfZLi5nj5/+TKtQJsGTUQGYj3GKMJM1UYYJDlhbKFqQnfOiee/njTB99vOQQ7tn3mLCSCvHKgS39xNSUEfJIkVJuflzBcHpzGtaqghCcz+vBrs/YT8eUfEWjiwXDeAqg2mOpz6Uu/51C6XVmPrpdVIySAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619115; c=relaxed/relaxed;
	bh=mkGffN6L6o3olbDL65GC0/HySqZZtRBE5Le50XaNNq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKkn371AlEHsyATQagpPuvgn0zaydO6a/Aq63voAs0YRuRBlVz3Fi+5iR6Om+aGuZJAc2EPvXIyg56BJ1otWzy1L98/CUVyY1E5RFX2HTlKBIeLJNZxi6oqdy1cacqBHtHMvehjOqi95P1lXJDZRNZJFNVO6ikTIjdxngy2ltzxJLPwnbF8TUeOH4dELjoj/R1Pt5XkWpKT57SzjKCHknhXrFBfQ0eqfkbYQTiZwwBH0kT7Gm8t37KGHFVj+jusp12ciCpcPJvyoVR1jDtGJaXwh7duYICKx8XBH2b2Kol1OpRYRejge2Tz7XNYUNNLkfJEUsBAPEwNlc6npUj21AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gpYjkn5S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gpYjkn5S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x1k5k5bz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:58:34 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so131002a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619112; x=1792223912; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mkGffN6L6o3olbDL65GC0/HySqZZtRBE5Le50XaNNq4=;
        b=gpYjkn5S/0pX4cYPvhHqmGUKmua/WZ8XHEuAmQWsRocK/yJ9Jn7pMxFF2aLxElF6uw
         FkHNK+vlpVo0FKOu4lxqLYDVMH3xqE1CSsmpt7VzkOYvyokhh8JuIn+RnPlAMUSwglIk
         XJCGzv9e8JuEZLxtSOdTDRSSUEmtrPLT9rVf1pwBRNCvOTLstSzjRn0pjAfP0aq5cYnq
         QaXD9E1ZKVKaIf/2OawdtjPkayxy3Hnwy6EDH6oE2WvhDZzw7awZgky9K60nsLhlcOVX
         siwZn3wwl7U0nXChOYB7TTAI8VQ9Ypu+j1HJeL6ZxaCNVuBu7YImJALm4afqAdIsbehi
         iJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619112; x=1792223912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mkGffN6L6o3olbDL65GC0/HySqZZtRBE5Le50XaNNq4=;
        b=1x/pFFrunaBrqNF3aBCUGj7WhYb7E+QngdHEHrrDEgWaAoRGxX+46uyZUKxsD5IFIz
         5DXWRmGzg2ixuE5v7ehC+umV1rsH6ud438Li6GcClBEYuFu8zQQjAiexYgKz0Xu0Rb/X
         0XlUiZWs3ghGZ1Ul9qHdrROL4Ohk4OxcLBGdFx1lSCQ6GotF5dPVGOPupRkIz/oQyBm0
         7tQ+fqYOzgh/U7cZ2HPlrQGEuK+PpbAxS2SiYlpF0eEKkEbhhE9MHX7iiux2RuOx/AMl
         UbabVXvzJvcI2h3NR8rAIzEALB+2CUc4WUd+iPhyfttzY7lz/FwxkPEpWsFwOXjNNDDc
         oq0A==
X-Forwarded-Encrypted: i=1; AKwUvBzFRAAcJIb1eEbLQxipYi0ejcSWc32/9QqPiZETYg60P5wQvg1YLUY/y9wAVGBswvH0CGCRvjTrsIqEgTU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJIX6/SkDHi3hlOV9R8URl2DrKj+F3bPLUAbN3KLSPFmhZFn19j
	HXl9JUwS9/SOahdNUalMnOdL/hTzHuypptG3oqCjGpMNNAY9U3oPf21vTJMuVP7XzPo=
X-Gm-Gg: AYBFou3TdFNPtj3i4OTrQcD8G6urd27Bc43qsOsj6Dazbv/xOil4pjoQE6xcO4jUkpB
	M9YaPPYxTpLKVi9WJXPSjUuOOAPUJ1aA4A1p9LGjLNjatwbjBScbt2dGoQISkjrTqV6h7piKZ5+
	iNngxVhXEzJRW8zv8vdlgL2rCRGlqRojKfns+fApwwa11VBGLFVvVjrr0EpqUc8rFlILJ2DHg0A
	DLTXqxcSetzdkjtrk5FAo5n3PNL8coZWobmcrrv0CWKN0jDEmtCJrGImoa0NdnjHVt5JO8Tvl/i
	6YspqmIpVUlqbE/L3YEMrbi3J6IhgIfcEOkRMqnXx8KLGtfz8KjpW68jIfuWmaneVtzi1RaAXBc
	Tbh+6oidO1ACHeoaOjuE6RIR69ORYwt1xu4ZEAgP3lJ/hoNXXPQSJs+2hGdJ1yBuF5ghYW8bzDP
	RAPF0fnBwUlyovyRmXWhJEG5TmW5/ZFtiopxF4L6Om+89epbX0zO+vA3uEBZzm27Fu1NsHx7qd8
	0cgcrmFkXeD5c8YzqN/OSBfgoU0za8f8QiAXg==
X-Received: by 2002:a17:90b:2e4b:b0:3a8:195f:186 with SMTP id 98e67ed59e1d1-3ab3a9fc457mr3160126a91.42.1791619111478;
        Sat, 10 Oct 2026 00:58:31 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.58.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:58:31 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
Date: Sat, 10 Oct 2026 15:57:50 +0800
Message-ID: <20261010075755.83339-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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

VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in
two places: it keeps allocations on the normal path and takes a reference
when a backing page is supplied for reuse.

After Device DAX switched to the common per-zone shared tail page, both
conditions can be determined locally. DAX supplies ptpfn for every shared
tail mapping and requests an allocation only for compound head mappings,
whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
selects the correct allocation path.

When ptpfn is supplied, the caller is reusing an existing backing page.
Once the slab allocator is available, take a reference for each reused
mapping to balance the release performed by vmemmap_free(). Although the
buddy allocator is available before slab, no vmemmap population occurs in
that interval. Earlier mappings are backed by memblock/reserved memory and
do not need page reference accounting.

Remove VMEMMAP_POPULATE_DAX and the flags argument from the vmemmap
population helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v4:
- Collect Reviewed-by from Lance Yang

v2:
- Explain why the buddy-to-slab initialization gap is safe (suggested by
  Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/sparse-vmemmap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 098975861523..b23efff80137 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,12 +32,6 @@
 #include <asm/dma.h>
 #include <asm/tlbflush.h>
 
-/*
- * Flags for vmemmap_populate_range and friends.
- */
-/* Vmemmap population for ZONE_DEVICE compound pages */
-#define VMEMMAP_POPULATE_DAX		0x0001
-
 #include "internal.h"
 #include "mm_init.h"
 #include "sparse.h"
@@ -241,7 +235,7 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-		struct vmem_altmap *altmap, unsigned long flags)
+		struct vmem_altmap *altmap)
 {
 	struct zone *zone;
 	struct page *page;
@@ -251,7 +245,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	 * Device DAX still relies on vmemmap_populate_compound_pages() for
 	 * head/first-tail allocation and tail-page reuse.
 	 */
-	if (!vmemmap_optimizable_pfn(pfn) || flags & VMEMMAP_POPULATE_DAX)
+	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
@@ -263,8 +257,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 }
 
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap,
-				       unsigned long ptpfn, unsigned long flags)
+		struct vmem_altmap *altmap, unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	unsigned long pfn = page_to_pfn((struct page *)addr);
@@ -273,7 +266,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		pte_t entry;
 
 		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap, flags);
+			void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
 			if (!p)
 				return NULL;
@@ -291,7 +284,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 			 * Use try_get_page() to prevent the shared page refcount
 			 * from overflowing.
 			 */
-			if ((flags & VMEMMAP_POPULATE_DAX) &&
+			if (slab_is_available() &&
 			    !try_get_page(pfn_to_page(ptpfn)))
 				return NULL;
 		}
@@ -355,8 +348,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      unsigned long ptpfn,
-					      unsigned long flags)
+					      unsigned long ptpfn)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -376,7 +368,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -387,15 +379,14 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn,
-					    unsigned long flags)
+					    unsigned long ptpfn)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
 		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn, flags);
+					       ptpfn);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -406,7 +397,7 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+	return vmemmap_populate_range(start, end, node, altmap, -1);
 }
 
 /*
@@ -532,7 +523,6 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
-	const unsigned long flags = VMEMMAP_POPULATE_DAX;
 	const unsigned int order = pfn_to_section_compound_order(start_pfn);
 	unsigned long size, addr;
 	pte_t *pte;
@@ -545,14 +535,14 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 	if (reuse_compound_section(start_pfn, pgmap))
 		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page), flags);
+					      page_to_pfn(page));
 
 	size = min(end - start, (1UL << order) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1, flags);
+		pte = vmemmap_populate_address(addr, node, NULL, -1);
 		if (!pte)
 			return -ENOMEM;
 
@@ -562,7 +552,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next = addr + PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page), flags);
+					    page_to_pfn(page));
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.54.0


