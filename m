Return-Path: <linuxppc-dev+bounces-26249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264EFC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLrQ0J5Nz2ybK;
	Mon, 31 Aug 2026 17:55:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162918;
	cv=none; b=KryuSUYd95uGlwenzRaEAlOZ85bdZoeK/6eYOGi2iCrjzDFJJ8GCqDGFfL5czgm+BX8FMqCfSRvLL0QrMzar2hjLeACVqFt7K6CJSHO8UAYUos57TdmlGV1vSHE4VpHQH7AalEvEBW6jMCwbCx1cyio8govaaMqeyPdzpXJ8iQX0vkJ4h2SmL12juoBveY6gprxx9iYbQaXuNIFcU3BbhwUADxikJH0xp7mYbBYdL+6TVYB+f8DrxTGle4Jj3LzuZP+S9HooHHVR7QKAf4wfmn/QrMnDBKFbN63N+lQckbIWSl1Lrv/Il9ZxZIW7fJgatYnHYpVUKVZ9vmBt+8bTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162918; c=relaxed/relaxed;
	bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehNlsx/auI1d4o6lVdVSdMsvCQTsx6QuZUTjYSs7BUSVrLnGMDi/o2uHpDDtLH6NGh+75Qlhf/UVqn1/BXaYoL2zhpcu6Dk1DSmjBoVersdpMzuP02ZyQ4qFzo5zc4efR3NpwCUhKklVGAAh8JbQBLuvK+xWxVb8f47tS0x5XmeSB5efwQHm7n9cTR+Go/ztvjb9K4MuG5K1AkgC0weD739RAsw/f1hhCinLMLcFvITCLlnmCK9RRRezJNCDK8yss2bgr+l/1qDnBdfzQwDWa+m48D3fOHDO6kxfFmQ5J1AWSQPlbnx49oA32GyzYOyYiUoXrpihNjIkdDCWOIen8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HWYPe45G; dkim-atps=neutral; spf=pass (client-ip=209.85.210.177; helo=mail-pf1-f177.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HWYPe45G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=209.85.210.177; helo=mail-pf1-f177.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLrP23T2z2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:55:17 +1000 (AEST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso2895283b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162914; x=1788767714; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
        b=HWYPe45G1M5pLcPpG/ef0wOlwgVFhzbNnexPBC3Neg/Py6ryCXcHp9DRNpEFxf7VNH
         f0DjPx5juQCgglG/RorF4MzM+4gd+8sUP76mqQNxRgv00siCbIG96MnAVUnGDqVyUvh2
         QiitQ7iY9dr7deiLANvaxC01lQXWSL+IlcZoZJdRhePGj6Bt5GQeywCm0hQB7/CUcORU
         sYh8c4N5pvIwjJtvgb45E6E6ikmq2gOwpgzoQt6DHjq3NM43Xe5XChGw1GDDbxRHxB5a
         U8XRogvKfUdeWsqPiW+t++/b535E5h0UPkoHCvSYWEhSidhtWlEaieOpQ6aSejO4tOWK
         /frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162914; x=1788767714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Uns/ZJlTRrXsZn1DdaJluablabo4P2O8/HR8HKp5bE=;
        b=XgPypfUmAktjwc4KPEk0nP8dy68QpT5pwVhbhxOIyI6QJ+cMDUSqyOcSJKNg9WSnxN
         l/T9vA5XHCo/Np165fdqHZyyjGrixYty+o3QxylsTgkuJeuqq4ktauRW+8ebL3sOpkin
         BkwvIlPLtiezKKCGvxmI+IR+2afHGuSwA3rNcMUZURVm3qeWWgtHmGdRG6ccEyTU6NEh
         I31ja1vBNhd7/2PMVlE+ZFUxN9HOudtEJopReosO7ElHTIIK/hRrLKOhWwZK9jWv0R3k
         9yiHKmSTbAKJ5tGonwMz7UN9DpIrT/u6CLLfM8uf3NReIDTeOphCG4XU8R/CEqWsAKEy
         kEfA==
X-Forwarded-Encrypted: i=1; AHgh+RpsRE232LaRWlxydr0/bVG6JrnIAekREjwNdF/7RvnRsbC4wP1hdn4EoXSPHO7MOLfAJLoIk0oZCn+ES/Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l/j8o0Jyo3jYs2TLViKYgxJ6j0ND8OlLtmB0I63/QzcisR7MzK
	MIF4rCrHSeWIKCYBGSEdQnf/Z0thv5LiCe1eQh1jblTCLs9qCpmJZ/S9WGxDh4WanTw=
X-Gm-Gg: AR+sD13NQWYDxa5S/Jb9FF+rL8Lytbsvip5rDBe7PrVwCjToNW16vr26Ir+Qb1pJLdw
	hqR7FwDXsCfFVUuJ1//8lsOo4DctHc/LwgzGxp+Aw0WyBba/dowpx8j39txbyWcXErKmxeOUgkE
	amymSZ7XQoAnuEIAVGzBwHMuO39TzJIXSsZpM1zHVIEHXw0aHrakfNL/tag/3X0vstjFoP8LoF2
	lOgSBC3rWEhvFhNaV8pgo16OLJijZdtyIGoqL6momAcdWSYSxNIm6szgRzKMB5uR8cJlYj1JdLW
	ilpoo4Kx6UV/Oa6AqUqM3bPX2/ryIuCwLye3jkXPsgnFEXbnAQ22kUE/AIoW4Pxjp778N1MV/1P
	vxT9k5f48cGBbCswPPbLmXbW+lA7nLyMTX+nudocDZOr47s373/8ynaznde7zXKCvP1qqvvS4+F
	/gUg0oxcUeFlUwkrdgSJi9hoMIkxX1zPJqFpCOiM6ehlyqrM5W81m5wNNY3DotlTPQ7sXfwduPj
	9KTXFO/Fc3wocBVU8JuVnc5
X-Received: by 2002:a05:6a00:845:b0:857:72ba:ff11 with SMTP id d2e1a72fcca58-85adca7066cmr2156632b3a.25.1788162914397;
        Mon, 31 Aug 2026 00:55:14 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.55.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:55:14 -0700 (PDT)
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
Subject: [PATCH 10/11] mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
Date: Mon, 31 Aug 2026 15:53:41 +0800
Message-ID: <20260831075342.57563-11-songmuchun@bytedance.com>
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

section_nr_vmemmap_pages() no longer uses the altmap or pgmap
arguments, so drop them from the helper and its callers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 10 ++++------
 mm/sparse.c         |  3 +--
 mm/sparse.h         |  6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e655d9d1348f..4950ac2a1c01 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -131,8 +131,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
 	const int order = section_order(ms);
@@ -637,7 +636,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages));
 
 	return page;
 }
@@ -648,7 +647,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -658,8 +657,7 @@ static void free_map_bootmem(struct page *memmap)
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							NULL, NULL));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 	vmemmap_free(start, end, NULL);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 9349ed6326c0..adf057f54c0f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -251,8 +251,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 						nid, NULL, NULL);
 		if (!map)
 			panic("Failed to allocate memmap for section %lu\n", pnum);
-		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
-							       NULL, NULL));
+		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
 					SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
diff --git a/mm/sparse.h b/mm/sparse.h
index e511d99fc26b..5d0f407bde7e 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -70,12 +70,10 @@ static inline void sparse_sections_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
-int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages);
 #else
 static inline void sparse_init_subsection_map(void) {}
-static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+static inline int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages)
 {
 	return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
 }
-- 
2.54.0


