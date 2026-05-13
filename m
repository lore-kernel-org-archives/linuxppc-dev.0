Return-Path: <linuxppc-dev+bounces-20891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC0CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3y2hSBz2ygl;
	Wed, 13 May 2026 23:11:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677886;
	cv=none; b=FON37lrOhHy328zuVSvY1umHAR6Mvgj5hUuy3rIZbZt2F558prtHY/BTOoaKQhiX4NnDMhdUatmnEP38HUIfI5yGDBQU2AJ09MGbFP9c6vWvfE/nH3C/slP7DIyYNyc5j9RlK4LTL6WcS1ZKyEl3NqGrsMWfOQy8aAYz/ukywmxKhWQuhoUnpkwfe6cxaGPl69sYN/IdyrH1zL2VltP4LvJqVYuaY7AW9O7UmXhIqjjmG78oe3p8MIfAbnhzgNusH29s6ET4ljQAkVe+Kdw0kZbzH6oopXgTBwRBoSdGFVbDxqMyPqXwg+JbwrhRBHkMNElZpRkunfI+QwLCBlHRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677886; c=relaxed/relaxed;
	bh=4mBY0+2gPF5yrifjarXE+EeA1By9caS7ano4A0QDHP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVmFvbL+PMv2WgXGCTnjMBYYqT449CvEGgFjHuCrMgPhjw1UjJyyXDRur01SC6v/FzMOEHTmGdK24hcJvItdQYJY4oeP61FwKuK0Q2s45axfcIPA/T0qYhd0MqqYwMQG7938n7+4p0W8LVXEFmrKGj16z5Ujho0hCPAZDLmfzGAkcQy70loUvwzNY7HOJQiwJuckpAvOt9z9FvwUQQ6fUz58q5PS8/tHxt0DXU2qIz+vQjxcmYWK9gmUbekEphgOloA4bkhyPiv0viVy0nWwzBlBdmJvH4BLeRzl7X+vqAWtXuQlGb6SXhehz+Ha0C2zK9NNoW+Ofu6f6Dtmwy/X5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RcOKXBVF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RcOKXBVF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3x3pNLz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:11:25 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2bd266f6fc0so4815665ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677884; x=1779282684; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mBY0+2gPF5yrifjarXE+EeA1By9caS7ano4A0QDHP8=;
        b=RcOKXBVFexUZUGUhbJgg03mMii/wrHAoU6DZOVkOmiatz6bHyZ6PAsePqmYl9JAX53
         wcGCDqZQ1ErVCb/E/o06Tg6k7tU4PNvg9x0FSh4s0AW2te9emrNfxZDvN3/lmB9HkUPR
         RzMfHwIoh9/NteXmHcGqHZyZXS2r1PLiKvyXHfrZZ8NhIbNwst6NtW1oxvZfN4+3T+d5
         Wf0jbsthupOY9f9HTMc44fAS8ERyFN4IhHqu8Hs/Te0qEQ/wPFpXtrjrlABc9qIebVR/
         f9fZWRvSfedywox7oB7XaoZYAqgjtY/jCjuKuRylAHHl7GdSeMOYqAoB4/pR2r0SMMIQ
         QKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677884; x=1779282684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mBY0+2gPF5yrifjarXE+EeA1By9caS7ano4A0QDHP8=;
        b=IcFASov9WsDBA4pFj6A/Tb7vCY3WgXqphR7GyBq2Xg7l0ivAB0eDzPcOhsLqRYPxxr
         NmxIJd9JOu+ZwkL3IGp9aGUBvZxAGlfnoJvqT20xs38ZzADGi353Kh2/eZvTigf1O27M
         cKaalmCbNlnSUG8HN+tq8RPwDMbP3fjTDfr7yjxPgNUOjXMpXuH/nFXzM8l2KWUk0rkd
         yqF6KinRYxkQntNZ8hcAQHYCDpI5A5elIN7Dvx0+EyMOA1JBPx7ZQpRaGjJPfW5lU/aD
         HaMLbjY1RxqIfI8Ld+OfC98vRtmG9cSBX549f8pw90qGFnzKgO1ldx43eLVphME/UppH
         fEFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rk61n2yiykCsIEmR7/Mc/4KpBWPEIOvIYSWPGdWSrN25jEV63ZlwkvKyF73HXOVL927kkm+FyC1ckOpg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpAci3J9Nt0+KEtUPKDPVfri1H2FPBqPkxFL2qLWJiMsswv+qe
	s3q+hcP9qGlNQmHrvdfcnpiT2DR4zGMdndMVmlb3xEdHbYiQGsS1PcKw1bOpx4/o1Cw=
X-Gm-Gg: Acq92OHIXbIDAhizPqYkN4BLWgsr9W69gjQJ0t2WQEw3F1IMKrKVZWo/ux/A3l6aJVs
	nwPChDbIZKEE3WfUSiW4uMJtB6Nj+LtE6hb++LN1xfNzr7XnBo7biqwU5MmhB65yTIIoBWKvHUS
	GGcekCU4esXoMmdVo/t7rlCGK+hTyjZoS+huNGgvHr1DM4RsXu37gowr5M1lPDnnHrEdtyrxEDf
	oG39jEN+C64QVvnNI7donAVbsCBmRjS8FPxhx8F8rj8n+LlCtJoiYW3taoacTlKXLc+kCoBkvy/
	K7xqrbgcUIzdKTZk+b4O4OASfc2SUvx8QWSONLHBPJAeCQz/qh8cVJbUV7J88/cW3N4JpAveMLD
	JvwvVNqHMIiHV7ISYi+t/aPT2kejS8/Gtq5JHKYNSMp8fCtVhLbHC0ozccfy4n4THvlQjEcNsfP
	i7Gg0qKwHZVT7YQHm5WnrXXfxD/vMCn226edRA+AU+kuIk8V9zDaZaaBZo2fY=
X-Received: by 2002:a17:903:290f:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2bd2f6071femr19517135ad.16.1778677883529;
        Wed, 13 May 2026 06:11:23 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.11.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:11:23 -0700 (PDT)
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
Subject: [PATCH v2 42/69] mm/sparse-vmemmap: Switch DAX to section-based vmemmap optimization
Date: Wed, 13 May 2026 21:05:10 +0800
Message-ID: <20260513130542.35604-43-songmuchun@bytedance.com>
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

DAX vmemmap optimization still uses pgmap-specific state to decide
whether a section should use the optimized layout.

Switch DAX to the compound page order recorded in struct mem_section, so
it follows the same section-based optimization state as the rest of
sparse-vmemmap.

This lets the DAX population, initialization, and teardown paths make
their optimization decisions from the section metadata instead of
carrying separate pgmap-specific state.

This makes DAX vmemmap optimization section-granular. Only
section-aligned ranges record a compound page order, so subsection
mappings remain unoptimized. The resulting loss of vmemmap savings
is negligible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |  5 +++--
 mm/memory_hotplug.c                      |  6 +-----
 mm/mm_init.c                             | 13 ++++---------
 mm/sparse-vmemmap.c                      | 24 ++++++++++++++++++------
 mm/sparse.c                              |  2 +-
 5 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index fb8738016b30..f0043c57694e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1235,8 +1235,9 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pmd_t *pmd;
 	pte_t *pte;
 	struct page *tail_page;
+	const struct mem_section *ms = __pfn_to_section(start_pfn);
 
-	tail_page = vmemmap_shared_tail_page(pgmap->vmemmap_shift, device_zone(node));
+	tail_page = vmemmap_shared_tail_page(section_order(ms), device_zone(node));
 	if (!tail_page)
 		return -ENOMEM;
 
@@ -1268,7 +1269,7 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
-			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long nr_pages = 1UL << section_order(ms);
 			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9ff830703785..c9c69f827efa 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -551,11 +551,7 @@ void remove_pfn_range_from_zone(struct zone *zone,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages =
 			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
-		/*
-		 * This is a temporary workaround to prevent the shared vmemmap
-		 * page from being overwritten; it will be removed later.
-		 */
-		if (!zone_is_zone_device(zone))
+		if (!section_vmemmap_optimizable(__pfn_to_section(pfn)))
 			page_init_poison(pfn_to_page(pfn),
 					 sizeof(struct page) * cur_nr_pages);
 	}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 35c99e5c215c..2b94115e6dd5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1071,16 +1071,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of an altmap. See vmemmap_populate_compound_pages().
  */
 static inline unsigned long compound_nr_pages(unsigned long pfn,
-					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	/*
-	 * If DAX memory is hot-plugged into an unoccupied subsection
-	 * of an early section, the unoptimized boot memmap is reused.
-	 * See section_activate().
-	 */
-	if (early_section(__pfn_to_section(pfn)) ||
-	    !vmemmap_can_optimize(altmap, pgmap))
+	const struct mem_section *ms = __pfn_to_section(pfn);
+
+	if (!section_vmemmap_optimizable(ms))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1150,7 +1145,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false, false);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b5c109b8af6f..ad3e5b54abf7 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -455,8 +455,9 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	pte_t *pte;
 	int rc;
 	struct page *page;
+	const struct mem_section *ms = __pfn_to_section(start_pfn);
 
-	page = vmemmap_shared_tail_page(pgmap->vmemmap_shift, device_zone(node));
+	page = vmemmap_shared_tail_page(section_order(ms), device_zone(node));
 	if (!page)
 		return -ENOMEM;
 
@@ -464,7 +465,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		return vmemmap_populate_range(start, end, node, NULL,
 					      page_to_pfn(page));
 
-	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
+	size = min(end - start, (1UL << section_order(ms)) * sizeof(struct page));
 	for (addr = start; addr < end; addr += size) {
 		unsigned long next, last = addr + size;
 
@@ -501,7 +502,9 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
+	/* This may occur in sub-section scenarios. */
+	if (vmemmap_can_optimize(altmap, pgmap) &&
+	    section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
@@ -718,8 +721,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	else if (memmap)
 		free_map_bootmem(memmap);
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -729,8 +734,14 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
+	unsigned int order;
 	int rc;
 
+	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
+	/* All sub-sections within a section must share the same order. */
+	if (nr_pages < PAGES_PER_SECTION && section_order(ms) && section_order(ms) != order)
+		return ERR_PTR(-ENOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -756,6 +767,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
@@ -801,14 +813,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
+	ms = __nr_to_section(section_nr);
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	if (!section_vmemmap_optimizable(ms))
 		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
-	ms = __nr_to_section(section_nr);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
diff --git a/mm/sparse.c b/mm/sparse.c
index 54c38ea08190..6878f8941b4c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -251,7 +251,7 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 	if (vmemmap_can_optimize(altmap, pgmap))
 		vmemmap_pages = VMEMMAP_RESERVE_NR;
 
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+	if (!section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
-- 
2.54.0


