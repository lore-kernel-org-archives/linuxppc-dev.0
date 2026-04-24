Return-Path: <linuxppc-dev+bounces-20031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D132F34C45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yK46frtz2xnl;
	Fri, 24 Apr 2026 12:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999384;
	cv=none; b=Iz4b0bbi0gcou2Sdy5px1v73rs2AOdcc3/Mqua6znG1niW6QGfR7/c0GVUkQTY+ix6EDA08nsxq1ueTlsmTNukJEmz6esqw1kLwLY8JMYjiZH55025F1FSAYGySv/OHPfECW9AmpwvDqPLC1V1ZO3bE9mQ+U52GXjKhBcv75MhaqDqZTgZT+UuaAFxBx6WEq1S/7Yyxa7fj4RS+K0NkqPrLW2njtlWMzpghi4t9t/OjvdpTB/Knzt8JdIvncfAlLBgnCrtP3qrSGo6W4YiT6cxM/wOfeH7ojKtOc0IqJxB6qssHV1/Df8jmmfY2p7F8goU4YTUEb+EgftoBuR41+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999384; c=relaxed/relaxed;
	bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MT4ieh7bkIVeS0gfI4siroL1w1Zn5fxc09ufwMAM4ajvY9J5VLZ7bDFLmoWxZKSeKMF8ufmJDXAwIm/WLzRH1gfMKQ0ChvDdt2nvhbR8k+PlM3LlNCy2skKnTFkSMWfAUHiKzEkYJf2eGzaFQwggiKzo6HoYbbvh68L+GjCy4sz3Hw1bmXcJlFeDvKN0MaF61c12qFIkKlXJqZaPOMb/8QiGjYUqB6417OkqqNuqA/7jpxEvvTdJ8QiRFCKYyPvA64kpkzGEsmCtvdIPTeYHuUz6u5oMm+5BsuJZ3edBTKo3isqMug0RfuWm8aS73M+71PZFevnb6xI6cfhDo0kyTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UAC1THZl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UAC1THZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yK40s71z2xls
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:24 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b2429f98d0so43400045ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999382; x=1777604182; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=UAC1THZli0W4+AQiKsDNGi7yho0X+6MT5k8nMOv1oNwgWd+hsAcXivlV2TCWfkxvR0
         lCL9kTZDiF5tTYWxvzGac8yOXyqnTZy6Iip5CMJvdBs2I39y+sphnFlhQowkxTjQ+ze3
         AkZ+qe2QvfIIhmPNi5z5JbhFOEoUWVXDZiIkd/x6r0APJiYDRzJHMFyvGopOcOIwjH/p
         e0a/JQgPyIERMS5nhBoQoBjiNrMsFMcUqJFnHzivdcOSFeyMDDP06iuGzVLP+fkMKJzF
         DzwLRYY9Le78swCabzM/HFN/UvMjKwnPQ1NVmCV+jr8ReB2WRHFhw30spVEe5fGlGx+0
         Wb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999382; x=1777604182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=iZ1Fep6ha/L7hMkFH98G7epjY2J0umefpe2y/kUvOFXmEloMkiJdx5XmABtf098vzi
         u9epDthqre0MEhwXaQz+oHQXIPAMxbcA6rW7j5hvukiCiM4Ux9YZz0QrseBgBzM3xwzh
         IFZrl2UPOjjLYiCIfApUThq3f8g4D5sm+aRn4wtSC9GVy8fpG4FA8P1ZX1yJId12WdOM
         FBnwHVsYY7UvA168enqjHRkCFtlCX3DThnc7x9eGWyPU993Sxc83hAN2X76Ydt5qpJp6
         Wa9dDnckJsVIZw8JxY/pNi1xdCZNUgev/K1tvLAmazrm5S4Oqjep2964SO5Fi3KuD79B
         YhXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YHXUs7crcAW06MsqwkKNZCTL2jwaXkRoud7wP0SclTEUtfLIZDxftClvRUpmxf9gnVYPpOZvkZQDL418=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylzVeUjHz4Ny7Nm/7Z/ly9U0oruWn5oWVSpHi9LRdyvPELevrN
	lVMeRIz+LXdtMy/zIH7kf7ORbJ1IonOc9AOReaMpkAPzpHTGbPVGquWgo4/Bzpqoh54=
X-Gm-Gg: AeBDieus5bTRE+6axDqympRGx1LGqYgD/y2slls2nEBKh+tpGLSAWfcnZZfMIaEB4f2
	IdPG2GhxXbM8se7yLi2e/mG2GFmBW6P3tSFxOrxCEHv4V7VNlw10v13J4qXHzAIOlScYqGwNukw
	MtdzxxmX3avVaeNJOSfYGrDG24GuEfYtZO8XBCCgDtQsBTZePK9ZZRO+/4OCUakhBLG/sUAihr3
	j30LqBr/wYLrMCitzyOP9tGRFrlkloCbRlWRTMXlCYuIdTnsp/WTua9IrYFmfLBKnZk4gqaTuSq
	L6ijfz3g8Sg2hL4nig7nXrzlYoVC+8cYcVZBgD2q916EpLnkAlVULtIqGq7VJ20WcXHa7aERezo
	VtSg/nuZ8QjH2/2xdy7s7TSP9Eed8oJ2QOpbjq0UOLMgoDzY096axztSuwfNQvPfQBOV/k2xnhY
	66Wjg1MdkzIXszT5upQRZXs3Ox6NqZSv4Y9HuPieYm0iy6i6kPo/lFUNw=
X-Received: by 2002:a17:903:1a83:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b5f9f36f53mr299091855ad.20.1776999381981;
        Thu, 23 Apr 2026 19:56:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:21 -0700 (PDT)
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
Subject: [PATCH v6 5/7] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Fri, 24 Apr 2026 10:55:45 +0800
Message-Id: <20260424025547.3806072-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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


