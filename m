Return-Path: <linuxppc-dev+bounces-19358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9715AEEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:56:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXXF1WWlz2ynP;
	Sun, 05 Apr 2026 22:56:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393789;
	cv=none; b=nCZSvCDdlIdtdS69ldn0Pe32UrSjFFY8aBXjIYp0z29UIHbs2LSCOBJGr/Oj6MMV+3QVWGgO5ppDXLUwK5sCvOzKr2N6qroUITGC8NpxGndSIzrZQYQ3Eey4h47/mc2uF0YjMViAorx7MWqv2I96lk0Bscx1YLL04WQCp2l/lfTrKZEpLTwy8qKOv79XIyALqfcoznWlWD6zZCZFug11oYqJB69xYZhmCPbk0ICuhsy8JkmmA22Zg0y27AYi3LkxIFNJSpEmm6fA8jzWpcuEsu4eRNJBe4R2S8J7Ak9dKgjGG/oMfMGVWK4ZrAgidNHKzrEzGNMNl06P3z38ftuJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393789; c=relaxed/relaxed;
	bh=awaFXPFMYUbrBte65uesX1HHeaiEoqtP90DsGctc43A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2vmzqNR2uShxVl5CHS+U3V/IwfAoj5lJEgYzSFtUHYACWm2z7tukYtARXg8Dig+CNw8+6M8wpkRwu53Dg8xmzRsghFV5yxpd6I7hISqwIDLKgUCJjZgU3WBSO8yZOzlsP3bh1ldDFtteHRawdRazGKhhsUH2xjhjY6wNsa5rKgV4MRqoWhNJo5OHE6/m2nPQUZzM7x71LkGLvq+8SunyJo2qON5q9wV5++pAIBxtKZk5CTS1s2UzMqRMgfxOnD5WwrykK5bEYmTm0EUSDnTVTuBniW0QsRmvJtzpBj3A77shjJQ5tlYMteXX00iKLJiR5F7Ov1o/nduyUptlj+iDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=P8bHFICq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=P8bHFICq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXXD1xwGz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:56:28 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2429616a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393786; x=1775998586; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awaFXPFMYUbrBte65uesX1HHeaiEoqtP90DsGctc43A=;
        b=P8bHFICq1YpSes/Vu1wDrfie3oCQ+1tHcssX1TZ1Xh7lS8QOphAZlZzpe3dAZkziy4
         RfQdAyvCeznqbjYuViyiJFF4U5JS1G8ME+V3n2mEvJTPeSZLgzp6mtT1Pk5vW5PSJjpx
         F3GQ4O2FmMhB4rndwX6v4CeI/5KIiY+W88zwshHMFhIHSob6B0YWBYDVuI7cjozRQxI6
         3yMVbfnkS264tD23K0AOhPuaOjIF8A6z9mnbXyj/0bR2An3ZNHHdQPY30dwYIbIgSni5
         RXXeMs4gx5pYlZMmNS/13+A9+thWazQ8iTMzsPOP71v9gAoHDGHcFvOAz+R+8+QL0dN+
         9Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393786; x=1775998586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awaFXPFMYUbrBte65uesX1HHeaiEoqtP90DsGctc43A=;
        b=kAPEZ39c2wEMVlyqtOvKg8edMQQ9O2PQ84CMzNxc42gXY6+WouFtfgR2nzYRrUgPuc
         gWNU4XynW+Aqi9BAIAaulHlcLpaZwDkOM/8/jdXQOx/DTbwarUGJsFrBO0ziVUnu1GCp
         pyEyyK3rjqI6aOibm6wxm+Hu5BSLJyyhE5fiGeLFp8ZcoyvDGkxG7PQZNcwo7aMh5vJN
         JqvP1gD9FmPbPucl1YeCAteDBwRLRh8igQxv9ZxGiGy2SWuL4Nwp4FAA79dWm4PoXQvm
         x27qLaC05H7netIj8W47fDfubtrSo/1mIOGpzwR+3nRRQ7sLifYQClOjSCXXau43RFWt
         QYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVusuQbb8Ca5RlnLylSM5Vot8aITU/DLxDWXLCo1N2FLbhz0P3ADXvZMcqs40SoNvUFnJ6DV8HhBTv17zs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWuStMTbm1atLlutf/oagKk/oEtd70deOs69BkSRL/2+s4iEcR
	2TXyt7OlewItBWcsnsIVLvFWcsg/7iUo+Tp/rEI9Brhr2DvE6OxGXm9K1DlqAmq+DAM=
X-Gm-Gg: AeBDiesoRwzjuUyY5NRyfmbBW1gTkRCHlhGkvWeiexfkqRNYb2E+FFiCbAIoLoIvBUx
	7arzYSjonb115XcSTwHxFMFshGL91d5NqO3xClZIIj0kln2PfLfjcvXg4lf8dWZTvcPst81uXSe
	Bwem4pWV9rOHm9NSIp4AspkNotO2lgP0d3O4udluSHg+HHFiBrG/UW93vy9Vrbnt3DSOExbRSQ9
	740/Qisyu75nOLO7ZFXz+ujrRt7wZIO1PgAHEISnOM1I1XvLM93/drLqHFKBLo2oisUt9uoQ9U8
	ErWT+p+nKgBnoRuswNyCG/a/9WuFMyMPmX9uHSGgy4mgJqXyakUmTWgzn/PKao542mPu2PUzoWr
	gMefbz+tYEIucgqf05+8xiZN9DW2yA1Hvb1sRsLQuzbUxUOuWHWi0Xv6xZDlWYhhAvNFCmxjUTL
	qU3/K8PNY3PTwBvxFtzxVD2wHjKb1QDlFyQr8s2DzkvupHwIU5ct0c0g==
X-Received: by 2002:a17:90b:3811:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-35de68ebf53mr9391600a91.17.1775393786359;
        Sun, 05 Apr 2026 05:56:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:56:26 -0700 (PDT)
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
Subject: [PATCH 28/49] mm/hugetlb: switch HugeTLB to use generic vmemmap optimization
Date: Sun,  5 Apr 2026 20:52:19 +0800
Message-Id: <20260405125240.2558577-29-songmuchun@bytedance.com>
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

Switch the HugeTLB vmemmap optimization to use the new infrastructure
introduced in the previous patches (specifically, the compound page
support in sparse-vmemmap).

Previously, optimizing bootmem HugeTLB pages required dedicated and
complex pre-initialization logic, such as hugetlb_vmemmap_init_early()
and vmemmap_populate_hvo(). This approach manually handled page mapping
and initialization at a very early stage.

This patch removes all those special-cased functions and simply calls
hugetlb_vmemmap_optimize_bootmem_page() directly from alloc_bootmem().
By explicitly setting the compound page order in the mem_section
(via section_set_order), the generic sparse-vmemmap initialization code
will now automatically handle the shared tail page mapping for these
bootmem pages.

This significantly simplifies the code, eliminates duplicate logic, and
seamlessly integrates bootmem vmemmap optimization with the generic
vmemmap optimization flow.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h     |   3 -
 include/linux/mmzone.h |  13 +++++
 mm/bootmem_info.c      |   5 +-
 mm/hugetlb.c           |   8 ++-
 mm/hugetlb_vmemmap.c   | 121 +++--------------------------------------
 mm/hugetlb_vmemmap.h   |  11 ++--
 mm/sparse-vmemmap.c    |  29 ----------
 7 files changed, 32 insertions(+), 158 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aa8c05de7585..93e447468131 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4877,9 +4877,6 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       struct dev_pagemap *pgmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-int vmemmap_populate_hvo(unsigned long start, unsigned long end,
-			 unsigned int order, struct zone *zone,
-			 unsigned long headsize);
 void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
 			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e4d37492ca63..0bd20efac427 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2250,6 +2250,19 @@ static inline unsigned int section_order(const struct mem_section *section)
 }
 #endif
 
+static inline void section_set_order_pfn_range(unsigned long pfn,
+					       unsigned long nr_pages,
+					       unsigned int order)
+{
+	unsigned long section_nr = pfn_to_section_nr(pfn);
+
+	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
+		return;
+
+	for (int i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
+		section_set_order(__nr_to_section(section_nr + i), order);
+}
+
 static inline bool section_vmemmap_optimizable(const struct mem_section *section)
 {
 	return is_power_of_2(sizeof(struct page)) &&
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 3d7675a3ae04..24f45d86ffb3 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -51,9 +51,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 	section_nr = pfn_to_section_nr(start_pfn);
 	ms = __nr_to_section(section_nr);
 
-	if (!preinited_vmemmap_section(ms))
-		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
-					     PAGES_PER_SECTION);
+	register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
+				     PAGES_PER_SECTION);
 
 	usage = ms->usage;
 	page = virt_to_page(usage);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a7e0599802cb..dff94ab7040a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3096,6 +3096,7 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 		 * is not up yet.
 		 */
 		INIT_LIST_HEAD(&m->list);
+		m->hstate = h;
 		if (pfn_range_intersects_zones(listnode, PHYS_PFN(virt_to_phys(m)),
 					       pages_per_huge_page(h))) {
 			VM_BUG_ON(hugetlb_bootmem_page_earlycma(m));
@@ -3103,8 +3104,8 @@ static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
 		} else {
 			list_add_tail(&m->list, &huge_boot_pages[listnode]);
 			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
+			hugetlb_vmemmap_optimize_bootmem_page(m);
 		}
-		m->hstate = h;
 	}
 
 	return m;
@@ -3283,13 +3284,16 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 					   OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS);
 		init_new_hugetlb_folio(folio);
 
-		if (hugetlb_bootmem_page_prehvo(m))
+		if (hugetlb_bootmem_page_prehvo(m)) {
 			/*
 			 * If pre-HVO was done, just set the
 			 * flag, the HVO code will then skip
 			 * this folio.
 			 */
 			folio_set_hugetlb_vmemmap_optimized(folio);
+			section_set_order_pfn_range(folio_pfn(folio),
+						    pages_per_huge_page(h), 0);
+		}
 
 		if (hugetlb_bootmem_page_earlycma(m))
 			folio_set_hugetlb_cma(folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0af528c0e229..8c567b8c67cc 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -638,9 +638,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			epfn = spfn + pages_per_huge_page(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
-					&folio->page,
-					OPTIMIZED_FOLIO_VMEMMAP_SIZE);
 			continue;
 		}
 
@@ -706,108 +703,21 @@ void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head
 	__hugetlb_vmemmap_optimize_folios(h, folio_list, true);
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-
-/* Return true of a bootmem allocated HugeTLB page should be pre-HVO-ed */
-static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
-{
-	unsigned long section_size, psize, pmd_vmemmap_size;
-	phys_addr_t paddr;
-
-	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return false;
-
-	if (!hugetlb_vmemmap_optimizable(m->hstate))
-		return false;
-
-	psize = huge_page_size(m->hstate);
-	paddr = virt_to_phys(m);
-
-	/*
-	 * Pre-HVO only works if the bootmem huge page
-	 * is aligned to the section size.
-	 */
-	section_size = (1UL << PA_SECTION_SHIFT);
-	if (!IS_ALIGNED(paddr, section_size) ||
-	    !IS_ALIGNED(psize, section_size))
-		return false;
-
-	/*
-	 * The pre-HVO code does not deal with splitting PMDS,
-	 * so the bootmem page must be aligned to the number
-	 * of base pages that can be mapped with one vmemmap PMD.
-	 */
-	pmd_vmemmap_size = (PMD_SIZE / (sizeof(struct page))) << PAGE_SHIFT;
-	if (!IS_ALIGNED(paddr, pmd_vmemmap_size) ||
-	    !IS_ALIGNED(psize, pmd_vmemmap_size))
-		return false;
-
-	return true;
-}
-
-static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
+void __init hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
-	struct zone *zone;
-	enum zone_type zone_type;
-
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		zone = &NODE_DATA(nid)->node_zones[zone_type];
-		if (zone_spans_pfn(zone, pfn))
-			return zone;
-	}
-
-	return NULL;
-}
-
-/*
- * Initialize memmap section for a gigantic page, HVO-style.
- */
-void __init hugetlb_vmemmap_init_early(int nid)
-{
-	unsigned long psize, paddr, section_size;
-	unsigned long ns, i, pnum, pfn, nr_pages;
-	unsigned long start, end;
-	struct huge_bootmem_page *m = NULL;
-	void *map;
+	struct hstate *h = m->hstate;
+	unsigned long pfn = PHYS_PFN(virt_to_phys(m));
 
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
-	section_size = (1UL << PA_SECTION_SHIFT);
-
-	list_for_each_entry(m, &huge_boot_pages[nid], list) {
-		struct zone *zone;
-
-		if (!vmemmap_should_optimize_bootmem_page(m))
-			continue;
-
-		nr_pages = pages_per_huge_page(m->hstate);
-		psize = nr_pages << PAGE_SHIFT;
-		paddr = virt_to_phys(m);
-		pfn = PHYS_PFN(paddr);
-		map = pfn_to_page(pfn);
-		start = (unsigned long)map;
-		end = start + nr_pages * sizeof(struct page);
-		zone = pfn_to_zone(nid, pfn);
-
-		BUG_ON(vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
-					    zone, OPTIMIZED_FOLIO_VMEMMAP_SIZE));
-		memmap_boot_pages_add(OPTIMIZED_FOLIO_VMEMMAP_PAGES);
-
-		pnum = pfn_to_section_nr(pfn);
-		ns = psize / section_size;
-
-		for (i = 0; i < ns; i++) {
-			sparse_init_early_section(nid, map, pnum,
-					SECTION_IS_VMEMMAP_PREINIT);
-			map += section_map_size();
-			pnum++;
-		}
+	if (!hugetlb_vmemmap_optimizable(h))
+		return;
 
+	section_set_order_pfn_range(pfn, pages_per_huge_page(h), huge_page_order(h));
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		m->flags |= HUGE_BOOTMEM_HVO;
-	}
 }
-#endif
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
@@ -822,27 +732,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static int __init hugetlb_vmemmap_init(void)
 {
 	const struct hstate *h;
-	struct zone *zone;
 
 	/* OPTIMIZED_FOLIO_VMEMMAP_SIZE should cover all used struct pages */
 	BUILD_BUG_ON(__NR_USED_SUBPAGE > OPTIMIZED_FOLIO_VMEMMAP_PAGE_STRUCTS);
 
-	for_each_zone(zone) {
-		for (int i = 0; i < NR_OPTIMIZABLE_FOLIO_SIZES; i++) {
-			struct page *tail, *p;
-			unsigned int order;
-
-			tail = zone->vmemmap_tails[i];
-			if (!tail)
-				continue;
-
-			order = i + OPTIMIZABLE_FOLIO_MIN_ORDER;
-			p = page_to_virt(tail);
-			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
-				init_compound_tail(p + j, NULL, order, zone);
-		}
-	}
-
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
 			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 66e11893d076..ff8e4c6e9833 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,10 +20,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-void hugetlb_vmemmap_init_early(int nid);
-#endif
-
+void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -69,13 +66,13 @@ static inline void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h,
 {
 }
 
-static inline void hugetlb_vmemmap_init_early(int nid)
+static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
+	return 0;
 }
 
-static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
+static inline void hugetlb_vmemmap_optimize_bootmem_page(struct huge_bootmem_page *m)
 {
-	return 0;
 }
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6522c36aac20..d266bcf45b5c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -32,7 +32,6 @@
 #include <asm/dma.h>
 #include <asm/tlbflush.h>
 
-#include "hugetlb_vmemmap.h"
 #include "internal.h"
 
 /*
@@ -381,33 +380,6 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	return tail;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
-				       unsigned int order, struct zone *zone,
-				       unsigned long headsize)
-{
-	unsigned long maddr;
-	struct page *tail;
-	pte_t *pte;
-	int node = zone_to_nid(zone);
-
-	tail = vmemmap_get_tail(order, zone);
-	if (!tail)
-		return -ENOMEM;
-
-	for (maddr = addr; maddr < addr + headsize; maddr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(maddr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-	}
-
-	/*
-	 * Reuse the last page struct page mapped above for the rest.
-	 */
-	return vmemmap_populate_range(maddr, end, node, NULL, page_to_pfn(tail));
-}
-#endif
-
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 				      unsigned long addr, unsigned long next)
 {
@@ -595,7 +567,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
  */
 void __init sparse_vmemmap_init_nid_early(int nid)
 {
-	hugetlb_vmemmap_init_early(nid);
 }
 #endif
 
-- 
2.20.1


