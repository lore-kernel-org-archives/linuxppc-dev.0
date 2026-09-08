Return-Path: <linuxppc-dev+bounces-26706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462BEC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81509Gvz2yjN;
	Tue, 08 Sep 2026 13:04:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836664;
	cv=none; b=ZKMFGC0TxI4mjn+zxQUWVh/oXVxj/sPkavCZyvKTTKD+pNn+hHgSeKx2VnN8nwMc1rCpA4UcVoUJxrWFojx9x/dBNjJPa7ItxbUDwMWL7Eqb7i8RCZu0alqOsmeexOLR3fuC+kuJx47hvcAtTSOwdpq9kuDbUCHih73KPzc4VlCTsMFh9f/XgCiJ6yb9gSGOpZ4FmpcSurhjbkkB8iSDGb4NgcoBLJ47ClZ7RbJdokz+ihLebYvShVNtahLWfBr8onei1MYsBbZuoS4OgcIBeyIk4L0M/39EfVfFrS11zAZ5atjf7BVrPW/ybU4s59S9wFDsZa8tBUQOW9/YGQq2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836664; c=relaxed/relaxed;
	bh=Nco6X6VSmg3b4sCsw2GCdeq7qTzf+r3pWDgUiD6K2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUTGkfRZtHC7qy1AhXMz2C9a26eV0PM2Wwlj/4Rc1HVXXzKwym39XR4BkqXWbWcNeVvrJqsR8VZo3azt0TwkGqVwC0yqEZkrMXk7F9gJ4Qtam5IVlQ0Hsy2mphMa3acG5VNYir/wIuGZdumpAtk1bRiX9IHqseg4YXe+/GM7Vl1NSfjFD+UB9ISuYEvunJwBYQupUudER9qQ4pmB+qj1Bty9uGJ4g9S+4hqgF1hti9CusWGMxV5Xa3625GiSMcVuFGUVrRF4Wz+ksdWnpvoWw4miMg2mh8j3TUbO2RxeKgoHU2WbsT+puER+/GeM/5KqYkqBmh/KWrbDiOpQLLBmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZzU1KaQA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZzU1KaQA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf8141D32z2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:24 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-863c229c3adso1978200b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836662; x=1789441462; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nco6X6VSmg3b4sCsw2GCdeq7qTzf+r3pWDgUiD6K2qM=;
        b=ZzU1KaQAlGzSQHh/6cXv7hYZuXsbhjPk9wmAHJZbsM5YCghoVsGfqjusgcL9k4LdC5
         EuvDIfHYaCfoMqjaYA2T4QUJ/qbYLlQdUc9+yYtkbeB0bAwcTok+27p1XXq52vJCQEbr
         umTKBfox4yd48JqZNph/JTWN0lHk3kYYhX0uS5NhNbQCKvJ2r5Plg015KgHgN8FJtGXd
         LvYb9bDxynBWC5cK48tv3OPxIHaAK10Ugqu6MRJVuow6y4kn2g2VGDFfGv5a5rDp/HGi
         8Lohtxoed9oIv3YxzAMhFcmTXA1fSPLzC7wXZ6W1u1neMyDVvcWfVRMrDRWW49H/b2bL
         I3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836662; x=1789441462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nco6X6VSmg3b4sCsw2GCdeq7qTzf+r3pWDgUiD6K2qM=;
        b=kWKghm3mF4cO0MxUd9um8VVeukpvvtXS34RdP+pUBQTJ0M40pa/QLojnJQDwppapgf
         hvo1aFwGZ584ZAh1mJUCmpLKM/KTPSYuLRhrUUihxHQgXtJQeYq/r/RQoiz978X2obb5
         I4b9Atreu7CyLQBy99aNTTpm7UDgJ/RyRThe8AMfjjiFuHQG0Tc4yulQlyMaSqyFdHUX
         aIV4ltLevxUJybw0jzXy5KIfvC9sD8OraTm+k5tqAQWPzQ5iRkS7JVt3lMzTkrOLBZqO
         m6rMF8HM9uim61n+nEUHyjuR7E/q4xvAS8azhbgnxbWp9D98t15GfnJlGABW3q1NlvjS
         diRg==
X-Forwarded-Encrypted: i=1; AKwUvBw/t+IMa5VelYUgzA8q99tk0aIBvj5w7OcrMCOlRCeEBxELnNQ4SMCduR/2ZX0uaObKGwWZ0zxs8P5czww=@lists.ozlabs.org
X-Gm-Message-State: AFuF++knBmHHjqfm8tz3viNcrZLBu1mhkheqUG8qxN80vRrW9r/VJxdh
	ohKkVE30wGC0+GyDWWiGxHnmLpl4VB+Udy/IlvcOlwwnMNOcWHVceLk9/8d0cppyn94=
X-Gm-Gg: AYBFou1dDebaQTTpalAIijBVlzhwfDiG869hDVRKt3cjiBxsnj1lEYAObaui7YpzaIW
	/vcf31m3iU1n1pEbKktPR0r6geVdSPyziA/GZb90Wex/0gZ7DaaJlgYXmfMHIjptFMCTHDq54hz
	J1oR+oO00dm4+OFwQf2dhcK0IidBmSRz2pk3mTW3nUfTvkjqsv0e9ufjhEKJ6IwVJabCvD7h+1v
	tfzShe7/ydueQjyX9LMa1U4muto0TZMLX9FLzvJoKTNS6E7X7kgytM36A/GekCojlI4WsV+I/BY
	thPGbmHS0/klNAG+P6uHWH2Sxt6UIHAC9RUG8do5Fx57BXyMgMLcf6TOw7QwAoGUesQ2RReovrF
	ek2gaPguy8ucYrXCMJq579lgV1PrGa3hueP9Se9V5uB1L1pY/L/GLBY5yFQvR9arSjVaZpXDucY
	hvKoDmUnOhMgps/4xuCdlKSImDEORnHFXxxdeRDXmjKiPhO2GyUFguLbKOebvglY8i6uzt7BJLA
	E+yUihns8CGtWYt25NyKb7kEA==
X-Received: by 2002:a05:6a00:4ac6:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-86168992df1mr41275963b3a.8.1788836661718;
        Mon, 07 Sep 2026 20:04:21 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:21 -0700 (PDT)
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
Subject: [PATCH v2 05/11] mm/sparse-vmemmap: set section order for device DAX
Date: Tue,  8 Sep 2026 11:03:29 +0800
Message-ID: <20260908030335.96549-6-songmuchun@bytedance.com>
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

Device DAX can use vmemmap optimization only when a full section is
populated with a compound-page geometry. Record that geometry in the
section order before populating the section, so later vmemmap accounting
and population decisions can use the section state directly.

Clear the section order when the section becomes empty again. Also reject
partial additions to a section that already has optimized vmemmap mappings.
compound_nr_pages() determines how many struct pages to initialize with a
section as the smallest granularity. A section therefore cannot safely mix
optimized and ordinary vmemmap layouts.

Partial additions continue to use ordinary vmemmap population, so they do
not save vmemmap memory. Such additions are uncommon, and the lost saving
is negligible.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Explain why optimized and ordinary layouts cannot share a section
  (suggested by Qi Zheng)
- Collect Acked-by from Qi Zheng
---
 mm/mm_init.c        | 15 +++++----------
 mm/sparse-vmemmap.c | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9e8ffd01b4f7..7a2e58d631c2 100644
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
index 54ae8c284324..aed1e7429daa 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -135,14 +135,14 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	const struct mem_section *ms = __pfn_to_section(pfn);
-	const int order = pgmap ? pgmap->vmemmap_shift : section_order(ms);
+	const int order = section_order(ms);
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
+		section_set_order(ms, 0);
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
+	if (nr_pages < PAGES_PER_SECTION && section_order(ms))
+		return ERR_PTR(-ENOTSUPP);
+
 	if (!ms->usage) {
 		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 		if (!usage)
@@ -830,6 +837,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	section_set_order_range(pfn, nr_pages, order);
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap, pgmap);
-- 
2.54.0


