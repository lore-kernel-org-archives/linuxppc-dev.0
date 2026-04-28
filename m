Return-Path: <linuxppc-dev+bounces-20226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6FCFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YJ56Sdlz2yr4;
	Tue, 28 Apr 2026 18:19:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364373;
	cv=none; b=kU+zN8ZHoqsTlZW7sLBieib1Fan8LFpPWy6YHkHvEQZE/Ym1akHLRgB34mtanIe4bBQKQHk+8HYlvef6O69lbjhlTqCyFcm4TUuJalkkqFqTOfSqPSPObJAo/HXySr0+9qiaWjzSio6lpk7oqW/jqZNkUipaWF8JyQQD3KFKXgtrMp4yUz6j2M3+gmP6cG1v+vm8G/PzIUk9fd85FJ0cfOk7yKHbhqMt2J7xLpb9qt8dJp9wMguA5diyaEggB1EsJVLk00Cd7xjp+v/UGNlwbf6hbwHkOVTsLUfpVTZ+tQHj+yHxZ+6ulc8NmlrvQO0rfQQs+1iOcdMf/TgygTS3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364373; c=relaxed/relaxed;
	bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oB8l/ef60wHckD4vm/Gk6y36n2Q+zl8VBqwz8O86Cfik9ZPFA8GbuKVNvl8FXi0UKncl4o4ywx6sLCHlxSQOHr8FGmlNf9kJH4XtBouCSD/bXfhC9sQewDAQiJmP0cYMvJt/EjU/YV2ar0j58/nhjGauHmN/JyI2FSwXDXVyTzqDY2Gi7197koWnacd3RQhy5odoLDCopK5yYqbwSQJ5kAxiunrA+BRECRBrf0mm2DihV8nl1zHSSzHz3xCLdWJ6z0it84lgYt4O3aAzlM6nIgxYYOWCFJIJcrnnsPgGLUHHCqWVvBrsVhW7KDb6UIUR8tey3pfqjx+0lBNo6r3w6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WN/9wxVo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WN/9wxVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YJ517mwz2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:33 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-362e30526f8so2065109a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364371; x=1777969171; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=WN/9wxVoRtoPVzD4AYKrCQREEUSGBzfoarCKq3YNoL5aoR7kCmBloPRPfekIcO60zo
         bK0sPR6slHJ38JSPoV+idnzJEq1C6OOWpK8HsDq7uOg43N26MtHPOGba/j8mgUNw59Ur
         CFsjiNj3P8HuCDHH5f1x5iJFtSXfCl7TqD5yTfayOtRJmEd+4TYVRGBEMADC9JJtKXvx
         NHB8Rea3KS4XS0KmVQSJ1fYUmvrs/gyW1rMVGq3Ck1fnMIKCGd0xjnVjUo/y3TNvbJY7
         l3bUSo3QqIGUi9dbYv8mcZ+GnEFfV64INcqtCLBqVqmadDLd3j2W+WAvq85oER2xoejd
         1jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364371; x=1777969171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=OsLqrDKSBfxiicaSqKWaB0flzsC9lXrwY9q/LFpBnNB3iN/pJibzDFXrcr00ksQVkp
         6CWbTLKA46udjaHhGj5oApmGA1694WoWaZ2jw77Om68jL2XpOmdWmebsFpGlbjesgsty
         Fgl9LfECP1R81WC1NDJpeOYqphhjTzjGfkPpgDKxpX4MHUZ4x/qNyX83oo+9g/ZB89bK
         WkFRjR6Kb0Sm06B7Rp2tGNgPMnKzq0S3clwx/ARRkR6lFrNz4ERhauMTUD7tVj5rm8jS
         wf3AQecRI6GamLH0MXnm38OQ0HfFdv/s1mNOF+PRxFaVCdz1fTPz+/kckzFTqNeypTP5
         pH/g==
X-Forwarded-Encrypted: i=1; AFNElJ+OntN15iEBhpCK6p5ipbDvL3c937NMHYYWc8c7QeaFkZJz4D6xS/sjNcccMZmE42PmsOMZqLEcukRz+Q4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBbJbooAr0JUYzas7gm+SWFwjioalVEggGfYLHst7aBjmVyK02
	gBhMoHzVgoFOxA5SdYA8CaQHDa4Pw0SV2WSpYn9qyn7HsMdz7H0XQIi0U87ds4XQVbA=
X-Gm-Gg: AeBDieuSTADgEI9zRsD8G5bJ16zbzt81Fq8rv1bKo7yJ5ME/z9FzG7ei4Segs06qqUy
	d3cLlLArYrtQfkwb1oUwB/GsR1On1wTZgkfb7t3YWAhwke5xVlNmIe5uJINNDw/gLAaxeqBci7n
	VTH4fd2TdZjC5kZ1qzU5Oau/ebneGoYGNqFGhjKRLiTPyQwgNun6MWH0VjV6l55V11QN3KrDsOa
	QOWf8XCQMXDfMszepfcYSEK/1fdlmkhhAWsEHQYWsEZfbyMFY2jxfsC3Rn7hWSgbBCf9uKF9YSJ
	LpSdsQZGQ/jZQcaSD6dNiLD0ld55SgberEBALvX2g0BfjAvxxkscJmxf6xvQuNwI+25zqg2U17U
	cMO1OKi8mFwVGpCKgcBdacylnhrN0cZH3mI5cserTVKJUp+Mb4QQi7rWqSPoRUnCmUwIvNiis8J
	dGSbnW31gcfbaxpriFdiZ7n2PYRYXJYF94Jl8ovVgRgBTrHi916wKfNDo=
X-Received: by 2002:a17:90b:17c1:b0:35d:a3b4:2ef6 with SMTP id 98e67ed59e1d1-364920601f9mr2483211a91.21.1777364371205;
        Tue, 28 Apr 2026 01:19:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:30 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 5/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Tue, 28 Apr 2026 16:18:54 +0800
Message-Id: <20260428081855.1249045-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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

The memmap_init_zone_device() function only initializes the migratetype
of the first pageblock of a compound page. If the compound page size
exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
subsequent pageblocks in the compound page remain uninitialized.

Move the migratetype initialization out of __init_zone_device_page()
and into a separate pageblock_migratetype_init_range() function. This
iterates over the entire PFN range of the memory, ensuring that all
pageblocks are correctly initialized.

Also remove the stale confusing comment about MEMINIT_HOTPLUG above
the migratetype setting since it is an obsolete relic from commit
966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the point
where we init pgmap") and no longer makes sense here.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..cfc76953e249 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,20 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+		unsigned long nr_pages, int migratetype)
+{
+	const unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+	}
+}
+#endif
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1025,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
 	 * directly to the driver page allocator which will set the page count
@@ -1122,6 +1121,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1131,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1


