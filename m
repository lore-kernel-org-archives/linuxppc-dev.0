Return-Path: <linuxppc-dev+bounces-20892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F04CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:13:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv436M0Wz2ygn;
	Wed, 13 May 2026 23:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677891;
	cv=none; b=BLvS81Ud4lQ2XLPcuqz1ixNjSBGT/j+d4xIp+0pHCV08WFA6la+v2FU+JutTnGuE6MiA+A9y3ExXgxSPDPh/TqWGTfy1tQXYvjjrvoT/rFapc+otE34gYm8Rtk7gLchwcHILG8n1IO7myFCaWzJKAMgs2l8Vjedsa1QaXgcdqwdNmf3fbR6SNb7bbfHnVxeTweI/4WsfMuJpaNEY3c6s1HNmn7aKK9xeYe68DcZWHwOd/nPsRPXXChjBEMLM8aVqJgrcXf4hby1sLH3tQ8LciClssnk6qI0ZQAevk16XN7vGoi+pgJPtOzAFn9nBq0PtDwg7byVBhpQW8FpTQXoSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677891; c=relaxed/relaxed;
	bh=puCoZmQRDxwpateuYAk/P74OaRyzUWBl0IwVomJ8OUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFXg4SMU3zK3ZPHdZv1WK7Oz/BNCK5WWCJ7LNU7WfaBvvitjK+HQHw8LtZ3pMQTmK31lKS6d+3yoHaUog4kc3TKkiyWKBmuo7t94DMi5MW0fq0uIvoy8z+rWkKWfHevZe8smddZZ0uWcTcgN33xRdUssPVp5nZGgLb+Hx4r0w+Z3zd9R1w5Gqei7VqAS4Oyd2Mq2qocJghSY947HUYQQ60zbcVH4jkzKN0OCxWaiUfhAMtW6YbTYM4lWKs9cs6t2G7m7K/jV82N12eajWkgeYen9LSyqRRdFCLdPZ3ifPDHE8wt+PEXz/Gb5AD9+eS62H9ibRT/1yVJH5ikNzEavfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NUTQMRxK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NUTQMRxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv430dgqz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:30 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ba4a1a0325so46803635ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677889; x=1779282689; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puCoZmQRDxwpateuYAk/P74OaRyzUWBl0IwVomJ8OUY=;
        b=NUTQMRxKjOknaa1JBZ4wGrJNKd/OXIcjph7PJXqEOYNXGicBu8hMCUNPRVt/5LZRwR
         LOSOlKsz1iU17+FYVysKfz9DOu12u8eGDnXZIJ5Pl6Z5jT/KMKyTez3cjwgWlQmxmpmL
         pUSqbZtke3Uhfa/0qlYblewPB0z8OIsUSpNR3yV9jwBsBFqMiNadO7O64fEkhSz8KT9f
         qnL5Ve/VjyWOSlAGTYyJtQiaFC3PTXKVyoS4We0j78shZZxH6E6G2ILuevjz/lX0m9Sz
         2W+UCdVkHPvP1pvQJgA5aNzBKgTuj64C2vn+NPY8l11nEr8fy/IGfDzvfjbGkdImU8/1
         +opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677889; x=1779282689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puCoZmQRDxwpateuYAk/P74OaRyzUWBl0IwVomJ8OUY=;
        b=UnONgxT6a2SFqfyPf9x1hWh1XOK+MpyMktPHGQznxl7OP3Mbq3j6FmymB4PnuJLZig
         PrI4W7sWPosXfJNOHWPLXY5sEdPrrqyF8gFmvWI9tY514ZwJDBZZFi8ZUJL/TTImEXcm
         VYY+wnxvVM1aXki4oazlVv0wq4g8HOt0Oea5QtD0wLE00/J9WnwNUIkOlwIZ1BdTvdwG
         0KhB/PgABWrUdAS8UCvjNdeo0Ppw+F/axEZY2GsqJJPDBF3A05xAFJHF9e/omQMwDmk6
         BqJ9zfGLx5guYGveLJo+RMcL84fmCSKuejNqkUN5TtLWDBEVdZTolVBA17n11dfCGgHr
         YkEA==
X-Forwarded-Encrypted: i=1; AFNElJ+9TjjY6fFdBtV+Bp+Jw7opXr9jG10WhKvnai+DkmEhQUqDJJEgSXNBO1FSLLTrK9lIGKPoNJFiO9kyNO8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrJ5oJ4WXUt9WRKuUPHBLvgJntP5myDWRAB3VxMIv/zsW1rqcC
	TxqbC7K4uVg4k5Zlett1a4p/3ZLCbYuxPdO9LhDX0GhN1hHFVukMNPiVY6cb6VdQdNo=
X-Gm-Gg: Acq92OGGV3cQC2qLdB2BDqmBwRDA1/P8NuYuj+/KvJS0kYzZ/B2ITnu9/i3stMgpzYG
	emNvg3AzEb+lIiJJDU0IWVTNO/emidiySblL4NceCkkFj33AbzrfH/aqZ8KpTAS7R00hoUTWm4I
	Fdq56eivd1zys5OEuE0hDVoNQMJDF28oM8uVMpXwB8GCsYgPcBRxw10uuMIisBOTDqu1V87IAVV
	tzz6n3PijGCFdQKXDOj5C+IvT1U8YKP73ySjP7JaKC5DaoeSpnr5DcCVPoW0GBywrUwBG9PaL9G
	fCgmDPbFHw7JQDsQCA4OclInx0ceD11Tc6jLm0Uo4y0mJUMHn/rHI5pwrsJOGkLCO+gUdkAteFJ
	O1K6J3veRV2lBBDzEnog6rH1aqu3U2N1MWbC9kOg2jpOf4uyaCS1PQHO3Qx1J8MwEXDaHEmlY54
	QxHH2sLc2PbpOBvbstGB9BDNINsXhXRyEHrqcpD8og0jeeH0iWPdKPpOGxoZU=
X-Received: by 2002:a17:902:9a0c:b0:2bc:810b:5c0c with SMTP id d9443c01a7336-2bd2770eddfmr29915325ad.34.1778677888928;
        Wed, 13 May 2026 06:11:28 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:28 -0700 (PDT)
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
Subject: [PATCH v2 43/69] mm/sparse-vmemmap: Unify DAX and HugeTLB population paths
Date: Wed, 13 May 2026 21:05:11 +0800
Message-ID: <20260513130542.35604-44-songmuchun@bytedance.com>
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

Now that DAX and HugeTLB use the same optimized vmemmap layout, they no
longer need separate population flows.

Move the shared-tail-page handling into vmemmap_pte_populate() so both
users can go through the normal basepage population path.  This removes
the compound-page-specific population helper and leaves the optimized
mapping decisions in one place.

At runtime, the optimized users are limited to ZONE_DEVICE memory, so
use device_zone() for shared-tail-page allocation instead of relying on
pfn_to_zone() before zone spans are available.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |   3 +
 mm/mm_init.c                             |   2 +-
 mm/sparse-vmemmap.c                      | 183 ++++++-----------------
 3 files changed, 50 insertions(+), 138 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index f0043c57694e..c7f2327681cc 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1121,7 +1121,10 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned long pfn = page_to_pfn((struct page *)start);
 
+	if (section_vmemmap_optimizable(__pfn_to_section(pfn)))
+		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2b94115e6dd5..9ff118e35641 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1068,7 +1068,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * initialize is a lot smaller that the total amount of struct pages being
  * mapped. This is a paired / mild layering violation with explicit knowledge
  * of how the sparse_vmemmap internals handle compound pages in the lack
- * of an altmap. See vmemmap_populate_compound_pages().
+ * of an altmap.
  */
 static inline unsigned long compound_nr_pages(unsigned long pfn,
 					      struct dev_pagemap *pgmap)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ad3e5b54abf7..4833a2295abb 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -127,49 +127,48 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
 {
-	pte_t *pte = pte_offset_kernel(pmd, addr);
-
-	if (pte_none(ptep_get(pte))) {
-		pte_t entry;
-
-		if (vmemmap_page_optimizable((struct page *)addr) &&
-		    ptpfn == (unsigned long)-1) {
-			struct page *page;
-			unsigned long pfn = page_to_pfn((struct page *)addr);
-			const struct mem_section *ms = __pfn_to_section(pfn);
-			struct zone *zone = pfn_to_zone(pfn, node);
-
-			if (WARN_ON_ONCE(!zone))
-				return NULL;
-			page = vmemmap_shared_tail_page(section_order(ms), zone);
-			if (!page)
-				return NULL;
-			ptpfn = page_to_pfn(page);
-		}
+	pte_t entry, *pte = pte_offset_kernel(pmd, addr);
+	struct page *page = (struct page *)addr;
+
+	if (!pte_none(ptep_get(pte)))
+		return WARN_ON_ONCE(vmemmap_page_optimizable(page)) ? NULL : pte;
+
+	/* See layout diagram in Documentation/mm/vmemmap_dedup.rst. */
+	if (vmemmap_page_optimizable(page)) {
+		struct zone *zone;
+		unsigned long pfn = page_to_pfn(page);
+
+		/*
+		 * At runtime (slab available), only ZONE_DEVICE pages (DAX)
+		 * trigger vmemmap optimization, so device_zone() suffices.
+		 * Note: pfn_to_zone() cannot be used at runtime because the
+		 * zone span is not set up now.
+		 */
+		zone = slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, node);
+		if (WARN_ON_ONCE(!zone))
+			return NULL;
+		page = vmemmap_shared_tail_page(pfn_to_section_order(pfn), zone);
+		if (!page)
+			return NULL;
+
+		/*
+		 * When a PTE entry is freed, a free_pages() call occurs. This
+		 * get_page() pairs with put_page_testzero() on the freeing
+		 * path. This can only occur when slab is available.
+		 */
+		if (slab_is_available())
+			get_page(page);
+		ptpfn = page_to_pfn(page);
+	} else {
+		void *vaddr = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+
+		if (!vaddr)
+			return NULL;
+		ptpfn = PHYS_PFN(__pa(vaddr));
+	}
+	entry = pfn_pte(ptpfn, PAGE_KERNEL);
+	set_pte_at(&init_mm, addr, pte, entry);
 
-		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
-
-			if (!p)
-				return NULL;
-			ptpfn = PHYS_PFN(__pa(p));
-		} else {
-			/*
-			 * When a PTE/PMD entry is freed from the init_mm
-			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
-			 * put_page_testzero() on the freeing path.
-			 * This can only called by certain ZONE_DEVICE path,
-			 * and through vmemmap_populate_compound_pages() when
-			 * slab is available.
-			 */
-			if (slab_is_available())
-				get_page(pfn_to_page(ptpfn));
-		}
-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
-		set_pte_at(&init_mm, addr, pte, entry);
-	} else if (WARN_ON_ONCE(vmemmap_page_optimizable((struct page *)addr)))
-		return NULL;
 	return pte;
 }
 
@@ -265,30 +264,16 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	return pte;
 }
 
-static int __meminit vmemmap_populate_range(unsigned long start,
-					    unsigned long end, int node,
-					    struct vmem_altmap *altmap,
-					    unsigned long ptpfn)
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
 {
-	unsigned long addr = start;
-	pte_t *pte;
-
-	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap,
-					       ptpfn);
-		if (!pte)
+	for (; start < end; start += PAGE_SIZE)
+		if (!vmemmap_populate_address(start, node, altmap, -1))
 			return -ENOMEM;
-	}
 
 	return 0;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
-{
-	return vmemmap_populate_range(start, end, node, altmap, -1);
-}
-
 /*
  * Write protect the mirrored tail page structs for HVO. This will be
  * called from the hugetlb code when gathering and initializing the
@@ -425,94 +410,18 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-#ifndef vmemmap_populate_compound_pages
-/*
- * For compound pages bigger than section size (e.g. x86 1G compound
- * pages with 2M subsection size) fill the rest of sections as tail
- * pages.
- *
- * Note that memremap_pages() resets @nr_range value and will increment
- * it after each range successful onlining. Thus the value or @nr_range
- * at section memmap populate corresponds to the in-progress range
- * being onlined here.
- */
-static bool __meminit reuse_compound_section(unsigned long start_pfn,
-					     struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
-	unsigned long offset = start_pfn -
-		PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
-
-	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
-}
-
-static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-						     unsigned long start,
-						     unsigned long end, int node,
-						     struct dev_pagemap *pgmap)
-{
-	unsigned long size, addr;
-	pte_t *pte;
-	int rc;
-	struct page *page;
-	const struct mem_section *ms = __pfn_to_section(start_pfn);
-
-	page = vmemmap_shared_tail_page(section_order(ms), device_zone(node));
-	if (!page)
-		return -ENOMEM;
-
-	if (reuse_compound_section(start_pfn, pgmap))
-		return vmemmap_populate_range(start, end, node, NULL,
-					      page_to_pfn(page));
-
-	size = min(end - start, (1UL << section_order(ms)) * sizeof(struct page));
-	for (addr = start; addr < end; addr += size) {
-		unsigned long next, last = addr + size;
-
-		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, -1);
-		if (!pte)
-			return -ENOMEM;
-
-		/*
-		 * Reuse the shared page for the rest of tail pages
-		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
-		 */
-		next = addr + PAGE_SIZE;
-		rc = vmemmap_populate_range(next, last, node, NULL,
-					    page_to_pfn(page));
-		if (rc)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-#endif
-
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
-	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	/* This may occur in sub-section scenarios. */
-	if (vmemmap_can_optimize(altmap, pgmap) &&
-	    section_vmemmap_optimizable(__pfn_to_section(pfn)))
-		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
-	else
-		r = vmemmap_populate(start, end, nid, altmap);
-
-	if (r < 0)
-		return NULL;
-
-	return pfn_to_page(pfn);
+	return vmemmap_populate(start, end, nid, altmap) ? NULL : (void *)start;
 }
 
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
-- 
2.54.0


