Return-Path: <linuxppc-dev+bounces-27462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D10C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8W60GKHz2yGT;
	Wed, 16 Sep 2026 16:44:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541058;
	cv=none; b=WzTt/VmYTh8bUKFHLcHRXEkv274HZpxud5DeNzCS8MyISqTorT0ywJ5EAOyH5FRB7tk2rQi3KhSq735kscX2d83NaP/l5uAkIu2y4QYFVewAq/QDDyUWHXg0kGsmeHwxjrRC8ri/Ikokac6PvN9p5Q2CmTzEVicUFxpMiZvn4kjyl5XydyAiWdon421AbzSMSXRq6SgddEIkYSE9ColJ3MxLWN+zhl/2CQVm7M7dIXv6g3EVMKU7+5iSsoyfkt/K+KZywO80NTcB0R+dY9VNEJSlkGh3bLYpxMWPjBLJJP1tBbzYirULDQZJF0w/Mv5bWXnjD8XSu6XnYjfhYhvWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541058; c=relaxed/relaxed;
	bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsXyXor0tbQq13frMxxrSc8oy+QW1JiUiKv7MxKs2rr5Cg31Q8wk/FyLAgNtbSCOiPY6bTcLRd0LCqJVAdYT9bT6ELoW3Iplaop8Y+CVR47lZ1zkYjZn4JZayFaVvkXquGWc33rWmjy3yrqrTWed+OvaR3E7Ge0TpEWV/1Fv+Jr1vtBkfcYtMI3IQewZimbzRCLxy3kffwg9ZDgzrtzpJuBy8KoEet45DBo9R4bBPxzod6ZhTDJI4vwTNNngVN83I5MfEebGmrGdR4n+bfN9UmuKbDn7kyPSoy/3DAKsbzbhcyhkVq1AlaaUBWZZUra4tYkFGdnOWoK2n1KZ3TQLVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=g58DXagG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=g58DXagG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8W526kSz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:17 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747eb79f6so3861575ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541055; x=1790145855; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
        b=g58DXagGiPEW5pSUkO8LPhTy4VatdfevpZvb8xLoE6AAw43tMwNUmDl3Txg2fn+wJr
         BaVkp6iRMiKinu6MDKeNQjThew0FF/n0uerX99mYd9xh4AH8YUU4SmIvb4CVAi9lgPUY
         BMjLB4frNFnmZSbQoOeZXthn1NneC2jT5yfkqZWkNKj5lRIqQdbqyrLbzjVK8QW42yYF
         T6+Zg8/SiENgoiESjqOInfjSbJzAA2ok0V+XRq1zgUH0hjleuEMP5mm5pcbilpfduzYY
         W6QXRXuIdOVpxUenHg94EnaEBwldlrCGEX4djWgEEUomPyAsDXb0VgcAREc3Yhj+gwp4
         Gl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541055; x=1790145855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6sM9zpfll+quDztLFFF0jfXeRCau4il9IJzrgeT16pM=;
        b=MS/sF/9VWSosMUSiBq+WKIEpus0GClJquYArdOSNY+MWIJEovn2SBoe77eqczi8spV
         dkQqYLY6OtyPIi9ErfPEojwxhskqNFH2j1YUjuDRn3LRjTdXjqd/fUfngtkBcp7LENEa
         pOT/rOkitgwNHI1ZGu6HkXN0lePoH7+VLKdIGzSADZgZx6fgUT0DI9bXwg+6b796ExvR
         UNnaaCD1H9SbdQlnVY+ymO/uMHVNIenViaqb++VLxnb/U49VP/J/gG3U0o8wlK26ehJ6
         OWX8CcDFN4+FSdq2LR894Z2z7Lci3gEKY24rHuvH+9swemRiMzvgu8JN3T8L9cdhpFdd
         Ly7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzPm2mXfFdpOHX9b1E4esoSRphc/l3EQmdGkal8/4qfaA4r9sI34MJO5POFbx1c0ZVh9p+bD5iWv6k3UaQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l3dNOmBQYyERezWUI6czjMKaOC3rwpPsNLp/FYq31k4ycKkNX7
	wQ+AtshurHtLkiPtUDsXC9BZkkJ388ySlQCkl5S1VQyFNZwjVL+qPTvxmyax06DSWWM=
X-Gm-Gg: AYBFou0xrV0UqgzBzOuDv3La6nnipVSS0AT8KLRcraOro+0+mGwa0nOIgZG91kkNuir
	DpigvhXXUGUVmiSgtA6Cj7H4IyQu7wr4W1ZXpbsVuuM3Fze4ZG6dm9UqGYnVybTZMuIBlvqgxH6
	3UDABWxi9FpIfeK+lCliyAOIH83uLUBDL6rjD6umi29cP9s/tPwGs7ZfUaN4myGJo6YQ691xqlk
	HUGeksUyB1+qTgWlkKZjaOmC8pvDE6OfS2q+tZexdQPd1D0KdjV57EKp1+IbIfr2IW+rwXc1P78
	zKX6h0ES4S5ftSKCiz/9d8mmZzNbOoMtqJTLTLG2Fmj/c/j2p5/UAnFt4F9iev0TmaF/OH9uA+W
	qDL9UQHRZ2zbKHmDRlY0QB76th5zOoi3T7xr1Iwwfem43umhHw9mPjKoMbh76uUUxzUTenLGCIq
	Kh51RLKRxOMRCFXyhBFNfkF1SdA7JdY/37ADdi/RaQeANQI7XNzux2YiUxztelZvrlMBs37llRA
	FTKcDpLdT7eQ5mADzQl
X-Received: by 2002:a17:903:1b2f:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2dd8dbf6ed0mr31915195ad.2.1789541055247;
        Tue, 15 Sep 2026 23:44:15 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:14 -0700 (PDT)
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
Subject: [PATCH v4 05/11] mm/sparse-vmemmap: set compound page order for device DAX
Date: Wed, 16 Sep 2026 14:43:35 +0800
Message-ID: <20260916064341.1825793-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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

Device DAX can use vmemmap optimization only when a full section is
populated with a compound-page geometry. Record that geometry as the
compound page order in section metadata before populating the section, so
later vmemmap accounting and population decisions can use the section state
directly.

Clear the compound page order when the section becomes empty again. Also
reject partial additions to a section that already has optimized vmemmap
mappings. compound_nr_pages() determines how many struct pages to
initialize with a section as the smallest granularity. A section therefore
cannot safely mix optimized and ordinary vmemmap layouts.

Partial additions continue to use ordinary vmemmap population, so they do
not save vmemmap memory. Such additions are uncommon, and the lost saving
is negligible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Update the subject and commit message to use compound page order
  terminology
- Use EOPNOTSUPP instead of ENOTSUPP

v2:
- Explain why optimized and ordinary layouts cannot share a section
  (suggested by Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/mm_init.c        | 15 +++++----------
 mm/sparse-vmemmap.c | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 97e0158d2aca..efffa8609b85 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1049,16 +1049,11 @@ static void zone_device_page_init_from_template(struct page *page,
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
@@ -1144,7 +1139,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	memcpy(&template, page, sizeof(*page));
 	if (pfns_per_compound != 1)
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	pfn += pfns_per_compound;
 
 	/* Initialize the remaining head pages from template. */
@@ -1160,7 +1155,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(pfn, altmap, pgmap));
+				     compound_nr_pages(pfn, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index aa89c16f7fc7..02da1321197d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -135,14 +135,14 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
-	const int order = pgmap ? pgmap->vmemmap_shift : section_compound_order(ms);
+	const int order = section_compound_order(ms);
 	const int vmemmap_pages = pgmap ? VMEMMAP_RESERVE_NR : VMEMMAP_OPTIMIZATION_PAGES;
 	const unsigned long pages_per_compound = 1UL << order;
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
 
-	if (!vmemmap_can_optimize(altmap, pgmap) && !section_vmemmap_optimizable(ms))
+	if (!section_vmemmap_optimizable(ms))
 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 
 	if (order < PFN_SECTION_SHIFT) {
@@ -573,7 +573,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_can_optimize(altmap, pgmap))
+	if (pgmap && section_vmemmap_optimizable(__pfn_to_section(pfn)))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
@@ -792,8 +792,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	else if (memmap)
 		free_map_bootmem(memmap);
 
-	if (empty)
+	if (empty) {
 		ms->section_mem_map = (unsigned long)NULL;
+		section_set_compound_order(ms, 0);
+	}
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
@@ -803,8 +805,13 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
+	unsigned int order;
 	int rc;
 
+	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
+	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -830,6 +837,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_compound_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


