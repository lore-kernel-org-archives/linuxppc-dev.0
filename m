Return-Path: <linuxppc-dev+bounces-19355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79533EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWs5FPKz2yty;
	Sun, 05 Apr 2026 22:56:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393769;
	cv=none; b=WFzQt4U1BVTnArbRSiUMTgwMxbhgEOeMP8tTs4gObtKapb0MOUB18jf3NmLo5hYk3cdkbha43326l5KPTm9qI9e98dS4v3Miq53d9U3PloAxxZmTmi4YMOos0VwW/HYHiOeax1InsqKgipXeYD1r3iOrww1xZE/5tHg5MQw3QK7PVlsT4CmNT3CVGtEGg2lMhXJWBnsBUmMmzW1CtpdVyNqUf+T1c2fpG3z7pM79fWTsq/9VOIw/JcSXwWai3WZSmU4thm4UCCL9Amc1Tb9xi+wQIoqM/Tt8ASU+dx5OmIPzDawhLfnseINE2mCgUuy3a8t9okJ5qiNjznnFuxAviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393769; c=relaxed/relaxed;
	bh=yuildpo+hHfNl+izDYgZmo65TSC8uYjcfc21fVKbu/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rq/gxdLqhYC37s1+WpihqCWtUFsnC6wdDnD7NhgUtIMNgEWDeMahntbaTb5zpU7nOzi5s3CAtGtvrH7Wm7SXTdCET1WTZXhIEsOzJsk1UmFbDgtbKLYgLO4y3Y/R7AXdrfhTEcwq4RxLmIwHfjPBhTA7Hg7XGsJHXdx24hz5VPTgFmXx/37A50NnhEhPA0yNry3mLG2w9hdEDvwOZhSM4+2JiUS5FCbx9ZCJoEqA2rk1rAQFkpVQqtCBEEa+wFmhWn7mtIpsEiVjvoDxO1RawP0xvWgjiH3S/H+3RaL4dvv4r5BQs9RzhasugQL0GHGpMwFvmUY0WF3SHvY7edxuOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gTcGykho; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gTcGykho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWr6q2yz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:08 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so2885473a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393767; x=1775998567; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuildpo+hHfNl+izDYgZmo65TSC8uYjcfc21fVKbu/w=;
        b=gTcGykhos/hVr65U+kRBhl2UjerRGzGe+KZHw6c1pwBQmBQCW/uGKWK3sBQRwedLCU
         7Bg+8RuOVx9eN2KdC7sU5kGq55F7Wh6TcZQiDuYBbmQQVnFpaV5UYLdrVozpgFHUyaq9
         0f5lPAVNHsE2XvdRpNbpKNXMlr00fTyXn48YGmikqm0TVDvcKxXve6VM0wv5JrhI+gjB
         HW6la7YmAPIVdW51kshacrMZyCioEytdBDHNl3cpvU8+JSaGxYRyamsYxZqaZqsI3s5j
         Qh42uoSofONETIOabTyh8qUIS8FRDcwpQIksI+Q65d6nJ2guDk90MnFpF77mN1jgMeTm
         Ic+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393767; x=1775998567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuildpo+hHfNl+izDYgZmo65TSC8uYjcfc21fVKbu/w=;
        b=ne3ZcfJJMWQ8xpPJXHPS9ZHPzzf3AjL0s5cEusQb2i7mO2tT1f0SWEJNpVciarfV1h
         6MecIxSX+/K1SH2YMkWzRze+liwzZBDY+or8mPmYOLGBpAV/aATSuwpDtQz38W2Q/Bhw
         Ni2s3IkjXSjikE06si/MgOUJySk8mcP9xuLxexvTyZyWNK3LhtBEla4b7j+ly50ddu0K
         b3MNPD2s/xijxwQ1qFMrpCT/cmKg3sz5XEWsUcs8RvVyY758tpvT8gM0QyDwje2Qis4n
         ObABMZZ24QJlWkzi6lTAunyXfjjYcBEfKD00XzZ78fjd20ULQHs2xe4YFB1DcT2v9jDK
         4JXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe3cAAALFr5t5JqC3rDIEnmSZdYtGkUpU/qErrvuzT8W0WQDXSbSwgr0yYjB85Yz9DpsWdWxEtPKuMpSc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YykC9Ebr7UinySLcCts8f7lxjY5X+dpsXCi6iOwizxUhmrNgNTZ
	zeDZWRB6u0xeaAuBnbCRoca++Giki+rZBaKpTrplG/Em7ARQ4kSFkg8U7WW6OolovK8=
X-Gm-Gg: AeBDietxsRWh1kJUXSwKraucwaKx0ceEa1U819AQjwffELb81clBqB9KyMFzP43rGJG
	usjguY5PjvHoWu7wx02cG2/+IGSvS+l4cZhOv55JWuZjDBIvF8PK1LWeCQEzr7AaYiyKBdPIsPN
	5FK5GI30LxJipA6uk3vlF3+RjNbdHkc0B3NO2R+VUbhf2rEgZG/w1awPCg6Py7O1dUalywKQgNf
	2hbK5ml2iTdkys9LGIALIfKA+Bo7pGwyeAerCsQLxmVSQBIxtFgogZaCqWYU3Ar1Ox0iCrDBBv9
	TnKUoFdaAmoyV2MSs1wjKxK2EREpKOEPcbiIJywkqgtvM3jr6M523QZThyM2YfyzZMQVhrTje1K
	Je8NqQ6Af086uTNFh0Qf9Njhp+sYMt2STVfCkhQZd9vlWCDAqmIIci6JEhiCu8zakqqWUPMulBL
	C3HEhii2hgRRThe8HarKrflXEbDI8i2exwEIwKLMD6vHP1nVAGJMsaNA==
X-Received: by 2002:a17:90b:4ac7:b0:35b:9720:98d0 with SMTP id 98e67ed59e1d1-35de679086dmr9103094a91.5.1775393766817;
        Sun, 05 Apr 2026 05:56:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:06 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 25/49] mm/sparse-vmemmap: support vmemmap-optimizable compound page population
Date: Sun,  5 Apr 2026 20:52:16 +0800
Message-Id: <20260405125240.2558577-26-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Previously, vmemmap optimization (HVO) was tightly coupled with HugeTLB
and relied on CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP. With the recent
introduction of compound page order to struct mem_section, we can now
generalize this optimization to be based on sections rather than being
HugeTLB-specific.

This patch refactors the vmemmap population logic to utilize the new
section-level order information by updating vmemmap_pte_populate() to
dynamically allocates or reuses the shared tail page if a section
contains optimizable compound pages.

These changes centralize the HVO logic within the core sparse-vmemmap
code, reducing code duplication and paving the way for unifying the vmemmap
optimization paths for both HugeTLB and DAX.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  8 ++++-
 mm/internal.h          |  3 ++
 mm/sparse-vmemmap.c    | 66 +++++++++++++++++++++++++-----------------
 mm/sparse.c            | 30 +++++++++++++++++--
 4 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 620503aa29ba..e4d37492ca63 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1145,7 +1145,7 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	struct page *vmemmap_tails[NR_OPTIMIZABLE_FOLIO_SIZES];
 #endif
 } ____cacheline_internodealigned_in_smp;
@@ -2250,6 +2250,12 @@ static inline unsigned int section_order(const struct mem_section *section)
 }
 #endif
 
+static inline bool section_vmemmap_optimizable(const struct mem_section *section)
+{
+	return is_power_of_2(sizeof(struct page)) &&
+	       section_order(section) >= OPTIMIZABLE_FOLIO_MIN_ORDER;
+}
+
 void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
 			       unsigned long flags);
 
diff --git a/mm/internal.h b/mm/internal.h
index 1060d7c07f5b..c0d0f546864c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -996,6 +996,9 @@ static inline void __section_mark_present(struct mem_section *ms,
 
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
+
+int section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+			  struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2a6c3c82f9f5..6522c36aac20 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -144,17 +144,47 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
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
+
+			page = vmemmap_get_tail(section_order(ms),
+						pfn_to_zone(pfn, node));
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
@@ -323,7 +353,6 @@ void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
 	}
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
 {
 	struct page *p, *tail;
@@ -352,6 +381,7 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	return tail;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 				       unsigned int order, struct zone *zone,
 				       unsigned long headsize)
@@ -404,6 +434,9 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 		return vmemmap_populate_compound_pages(start, end, node, pgmap);
 
 	for (addr = start; addr < end; addr = next) {
+		unsigned long pfn = page_to_pfn((struct page *)addr);
+		const struct mem_section *ms = __pfn_to_section(pfn);
+
 		next = pmd_addr_end(addr, end);
 
 		pgd = vmemmap_pgd_populate(addr, node);
@@ -419,7 +452,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(pmdp_get(pmd))) {
+		if (pmd_none(pmdp_get(pmd)) && !section_vmemmap_optimizable(ms)) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
@@ -437,8 +470,10 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 				 */
 				return -ENOMEM;
 			}
-		} else if (vmemmap_check_pmd(pmd, node, addr, next))
+		} else if (vmemmap_check_pmd(pmd, node, addr, next)) {
+			VM_BUG_ON(section_vmemmap_optimizable(ms));
 			continue;
+		}
 		if (vmemmap_populate_basepages(addr, next, node, altmap, pgmap))
 			return -ENOMEM;
 	}
@@ -705,27 +740,6 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 	return rc;
 }
 
-static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-					   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
-	unsigned long pages_per_compound = 1L << order;
-
-	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
-	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
-
-	if (!vmemmap_can_optimize(altmap, pgmap))
-		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
-
-	if (order < PFN_SECTION_SHIFT)
-		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
-
-	if (IS_ALIGNED(pfn, pages_per_compound))
-		return VMEMMAP_RESERVE_NR;
-
-	return 0;
-}
-
 /*
  * To deactivate a memory region, there are 3 cases to handle:
  *
diff --git a/mm/sparse.c b/mm/sparse.c
index cfe4ffd89baf..62659752980e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -345,6 +345,32 @@ static void __init sparse_usage_fini(void)
 	sparse_usagebuf = sparse_usagebuf_end = NULL;
 }
 
+int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+				    struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const struct mem_section *ms = __pfn_to_section(pfn);
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	unsigned long pages_per_compound = 1L << order;
+	unsigned int vmemmap_pages = OPTIMIZED_FOLIO_VMEMMAP_PAGES;
+
+	if (vmemmap_can_optimize(altmap, pgmap))
+		vmemmap_pages = VMEMMAP_RESERVE_NR;
+
+	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
+	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
+
+	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT)
+		return vmemmap_pages * nr_pages / pages_per_compound;
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
@@ -376,8 +402,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 							nid, NULL, NULL);
 			if (!map)
 				panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
-			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-							   PAGE_SIZE));
+			memmap_boot_pages_add(section_vmemmap_pages(pfn, PAGES_PER_SECTION,
+								    NULL, NULL));
 			sparse_init_early_section(nid, map, pnum, 0);
 		}
 	}
-- 
2.20.1


