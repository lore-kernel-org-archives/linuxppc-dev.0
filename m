Return-Path: <linuxppc-dev+bounces-20876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB9CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:11:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv2P5Nwtz2yTQ;
	Wed, 13 May 2026 23:10:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677805;
	cv=none; b=OKuXiywTxPyO0d9TZFP0RtH5aoGXQgaSbB+uyV8B+zLr21x0pklVqsAKr1fmCxu5g3BJTFtZNZY3tvhpL/rscjYpiBN1se5g7jCHlfm0fTNf1IwszAy08NohyshslNjiEaKya+nXJgV+sWg8i4fCFPrUBTgLBL9lgxyVJekredCieU9BI1UoN92jtlICQKvvizuNoa3jK3AN2yGRStbx4/1d720dnfrH9Um9gHfAOqKxWoqEMhASRCFvuEg0tFd1YqZAQy5WXAfHwUu7J0tOCxOp/+T9wON+Zl22py/XK9jc0PZANN5e7pKwAkxAwzo71rKA4V1ElDlTTqSlm+dTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677805; c=relaxed/relaxed;
	bh=YTByyvfyvRQXp0QDzHJ+fbRqWZip61THGdhvQJfTIW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OabchBcPLu87euiB2MMZgGLMqWRTFqq70e2vStQ7H143Sb6SX4b/lvlQcQVaThvRgFxVaIlw3ImG80p/hy9WViMCMpchfZoLAOipfOsLv0BghWwnLk+uV3r8PX7oxXfAqKzx5emtpmEdOtMb4S2deqYmKOXYQe7oajWKhTG0rS9yaB09bz+rQV4gIHHx1FuL06uY0otlTwKd3iw5mEBl7BV9bLwuonA8GKJhXpZC/Q9pb1kZT42esJAkefESMiypPxe+0wz/p7D3W7r0AySXouIE7bJm1juj9AHZ9/zH0wku/uVC4N3Qke1e5RkCAZurXIWoca/1YiJVzXcb+Mu6ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SNQ876Oa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SNQ876Oa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv2N57RNz3cPc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:04 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b788a98557so50708225ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677803; x=1779282603; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTByyvfyvRQXp0QDzHJ+fbRqWZip61THGdhvQJfTIW8=;
        b=SNQ876OaKiuBbgG87XQ6hVUc2N3Y+Y7p/fj9s4K5jQxZ/T68MYpXFvrZUFmQLn2IBJ
         uPdef8BqYfgFmQMeTj6/4/AZeb5n5XlwrPUK7sfe6f7iQ1BDpeB/Bs+IJrKHW/jtkcu1
         6M90ZCU16RdXc9OG8lOmn0JfXy/aqG3deRBjtPv4twDzBcxWnXHOSvzAUjWh9/vXjIao
         v2LJXOet0RwMehyLKUVTTm+YGhFLPg+cBmuET4gEOy/8gtFZsbEWD5rifmXd2U6zgbEA
         1N2tv8h8MaNO+oD+BnAwkwQNl7jIWsfzfQvrM+oDrw0e0FuDy42sNHnKU/7ZPcaG0umR
         36Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677803; x=1779282603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTByyvfyvRQXp0QDzHJ+fbRqWZip61THGdhvQJfTIW8=;
        b=Cc5v9UDpB19b8GuSQdGJckOVB1zH9WXHsrgOJ89A0EZZ6Y/maoql7X8IfS7vp0gmzs
         pOQDUzNdQdIqil6ntfI6shGjWypJhBsjsR+vxzjDF7XVpJh+D5U34PaFA89wpEPJM04m
         yuxoYCN6VnFy3OtOxQIjqRU9RHBNb5VBxviWMHQZrSX/w5cg8bUooyiZPkt9yLmKVvZw
         GPM7Jo3FNvJn0+klqFgH8e1KVKE7Oa9lte1e1sa/6J6OOi9I+7u2lwkFWPRkGZ4KFEBL
         M+n2NxICkZ3kloLLQMy0TRYMw80s2Is8D0iUujo/DUk33W0VerafZnoC9Ss75M3MsRUl
         AHrg==
X-Forwarded-Encrypted: i=1; AFNElJ/dHg8rhRMs+4ky9Yjhgaoc85XtVhyphVWfQzHyzSrINliIAYyWoTwp5pmVRSEOVGCKQAltlrxNPdiaJak=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YybnF8AxM3gcSyI6G7HfLFr1/U/nH/V8cnU2N2cEJl/0DLaT0fH
	9WDsxD9IG8LNp5dL+emrkWOpEOGcipTl4OmOxqW5ao7F+WQvSUg9iBiYsAm4FoGbi9c=
X-Gm-Gg: Acq92OGpoBJlygqs5R/v91oygRJPhQUhjEHI6LDai6fU8nAf/UgxtGOMA/BRVaTX3Z0
	Q+dsio/kKSMvLrqSId3STB9j/WQHo3NdMEc+PH7S1wiH1lBuay6JwTC/ki1Cwt0El349tvruwN2
	IleFX6XjcTrfZ8P9pDrCXWH7/UWaG2nf1u8ta30nwrEilrJYl1BJpnJoUy/N7kqnQ8esd+Rc7gV
	nhUCH7oOlskm6+xkNvi0s3TAx6PPCyh3OFFVBdDC7M+kdkfMeVmGVGq5a0Zh1dFPFsyn31LP4B9
	YG07/S1BzXS8q5JeX3qcP1CPvs4C6evNKVB+Yvw13K0TUDJHC4p21zzwPgUseeZAfatu1a/a+lG
	u/Tprey0VPl/yY/if/hYr8ChyRNsTELkxXrMZSB6qXKqGPPM8S4mHmwYZK8Va7oCjdmWDXn/AD3
	7uG2/yxU+rsDnw+ho/FISv9aaUY+zXQrfVCaezyKd7SN41iZMu1O4K5a2riEZRZxnep0BSUA==
X-Received: by 2002:a17:902:c209:b0:2bc:f1da:4bfb with SMTP id d9443c01a7336-2bd275a75b1mr25305165ad.34.1778677802375;
        Wed, 13 May 2026 06:10:02 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:02 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 27/69] mm/sparse-vmemmap: Support section-based vmemmap optimization
Date: Wed, 13 May 2026 21:04:55 +0800
Message-ID: <20260513130542.35604-28-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

Teach sparse-vmemmap population code to use the compound page order
when deciding whether a vmemmap page can be optimized.

With this information, the common sparse-vmemmap population path can
allocate or reuse shared tail vmemmap pages directly instead of relying
on HugeTLB/DAX-specific handling.

This centralizes vmemmap optimization logic in the sparse-vmemmap code,
based on section metadata, and prepares for sharing the same mechanism
across different users of vmemmap optimization, including HugeTLB and
DAX.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  2 +-
 mm/internal.h          |  3 ++
 mm/sparse-vmemmap.c    | 89 +++++++++++++++++++++++++-----------------
 mm/sparse.c            | 34 +++++++++++++++-
 4 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0974205abd3d..bf4c40818b63 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1147,7 +1147,7 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	struct page *vmemmap_tails[NR_OPTIMIZABLE_FOLIO_ORDERS];
 #endif
 } ____cacheline_internodealigned_in_smp;
diff --git a/mm/internal.h b/mm/internal.h
index 1f1c07eb70e2..2defdef1aedf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -995,6 +995,9 @@ static inline void __section_mark_present(struct mem_section *ms,
 
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
+
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 94964363d95c..69ae40692e41 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -139,17 +139,49 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
+static struct zone __meminit *pfn_to_zone(unsigned long pfn, int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (enum zone_type zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
+		struct zone *zone = &pgdat->node_zones[zone_type];
+
+		if (zone_spans_pfn(zone, pfn))
+			return zone;
+	}
+
+	return NULL;
+}
+
+static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone);
+
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
+
 	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
-		void *p;
+
+		if (vmemmap_page_optimizable((struct page *)addr) &&
+		    ptpfn == (unsigned long)-1) {
+			struct page *page;
+			unsigned long pfn = page_to_pfn((struct page *)addr);
+			const struct mem_section *ms = __pfn_to_section(pfn);
+			struct zone *zone = pfn_to_zone(pfn, node);
+
+			if (WARN_ON_ONCE(!zone))
+				return NULL;
+			page = vmemmap_get_tail(section_order(ms), zone);
+			if (!page)
+				return NULL;
+			ptpfn = page_to_pfn(page);
+		}
 
 		if (ptpfn == (unsigned long)-1) {
-			p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+			void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+
 			if (!p)
 				return NULL;
 			ptpfn = PHYS_PFN(__pa(p));
@@ -168,7 +200,8 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 		}
 		entry = pfn_pte(ptpfn, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
-	}
+	} else if (WARN_ON_ONCE(vmemmap_page_optimizable((struct page *)addr)))
+		return NULL;
 	return pte;
 }
 
@@ -311,7 +344,6 @@ void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
 	}
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
 {
 	struct page *p, *tail;
@@ -340,6 +372,7 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	return tail;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 				       unsigned int order, struct zone *zone,
 				       unsigned long headsize)
@@ -388,6 +421,9 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	pmd_t *pmd;
 
 	for (addr = start; addr < end; addr = next) {
+		unsigned long pfn = page_to_pfn((struct page *)addr);
+		struct mem_section *ms = __pfn_to_section(pfn);
+
 		next = pmd_addr_end(addr, end);
 
 		pgd = vmemmap_pgd_populate(addr, node);
@@ -403,7 +439,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(pmdp_get(pmd))) {
+		if (pmd_none(pmdp_get(pmd)) && !section_vmemmap_optimizable(ms)) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
@@ -421,8 +457,19 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 				 */
 				return -ENOMEM;
 			}
-		} else if (vmemmap_check_pmd(pmd, node, addr, next))
+		} else if (vmemmap_check_pmd(pmd, node, addr, next)) {
+			const struct mem_section *start_ms;
+			unsigned long align = max(1UL << section_order(ms), PAGES_PER_SECTION);
+
+			/* HVO-covered sections must not use PMD mappings. */
+			start_ms = __pfn_to_section(ALIGN_DOWN(pfn, align));
+			if (!IS_ALIGNED(pfn, align) && section_vmemmap_optimizable(start_ms))
+				return -ENOTSUPP;
+
+			/* PMD mappings end HVO coverage for this section. */
+			section_set_order(ms, 0);
 			continue;
+		}
 		if (vmemmap_populate_basepages(addr, next, node, altmap))
 			return -ENOMEM;
 	}
@@ -626,36 +673,6 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
-static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	const struct mem_section *ms = __pfn_to_section(pfn);
-	const unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
-	const unsigned long pages_per_compound = 1UL << order;
-	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
-
-	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
-	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
-
-	if (vmemmap_can_optimize(altmap, pgmap))
-		vmemmap_pages = VMEMMAP_RESERVE_NR;
-
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
-		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
-
-	if (order < PFN_SECTION_SHIFT) {
-		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
-		return vmemmap_pages * nr_pages / pages_per_compound;
-	}
-
-	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
-
-	if (IS_ALIGNED(pfn, pages_per_compound))
-		return vmemmap_pages;
-
-	return 0;
-}
-
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
diff --git a/mm/sparse.c b/mm/sparse.c
index 9457a4d6a6fc..3e96478a63e0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -284,6 +284,36 @@ static void __init sparse_usage_fini(void)
 	sparse_usagebuf = sparse_usagebuf_end = NULL;
 }
 
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const struct mem_section *ms = __pfn_to_section(pfn);
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	const unsigned long pages_per_compound = 1UL << order;
+	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	if (vmemmap_can_optimize(altmap, pgmap))
+		vmemmap_pages = VMEMMAP_RESERVE_NR;
+
+	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return vmemmap_pages * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return vmemmap_pages;
+
+	return 0;
+}
+
 /*
  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
  * And number of present sections in this node is map_count.
@@ -314,8 +344,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 							nid, NULL, NULL);
 			if (!map)
 				panic("Failed to allocate memmap for section %lu\n", pnum);
-			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-							   PAGE_SIZE));
+			memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+								       NULL, NULL));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
-- 
2.54.0


