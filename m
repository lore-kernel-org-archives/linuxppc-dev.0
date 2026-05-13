Return-Path: <linuxppc-dev+bounces-20873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E9ECD4F39
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv245Kr5z2yTP;
	Wed, 13 May 2026 23:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677788;
	cv=none; b=DUZRbtW/ScScCI0/X/bBjosQPsqHwDYiZIoI3fYBOUglckU0r7VGvF7ATKkxesb4I91bHv6PsbW4GexWfCyoyu0xRt36tLltqZyUDLZcwUOEmB4Nq/P0gCG9X22o6KFc0GGEzAPq6L5LIs1IlZmTmfxu0qqorc2f2iIQ2Gr30bXz1ikredNONcys61BzOZCPdZ58ogDv/2GjWuZsjLRhMPn+kbZ71PUaRC9OkNbqrlWOMsMHq//dL87wsw1zxK4RctqI8NuM1ppInw7WQeohkNg4WgWs7/zFiAHUpKNlxgOr2TsX8trr2LLqLg7Kd0rcQBScy0kDrHnOoO4WUBFnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677788; c=relaxed/relaxed;
	bh=3cDXE+87tm7ASxvvK0pHPqOmmyuztiqWVG9E1ozeyTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwhEXZdzeiwax99zotGU6m3w/X053wLb6md05l3d6t2BegXKpL+7DMsKlicH3vvbQCo9iHi2vju/xBWn5Jz4ISexUnJhLERIBAFNtPw+3SSa+w8FNGvk1kTnIPY17fMa5j9f5BuzVcPcTx6dcy7TY31eLBH9n4miI+7/dS1v2yQGQSdGwoWG8KFfm7vfxh2rkLuqqrPBKALeBwO/FA6/4f9fPUoOXj6jTtJ5t81QbGHTXoAq0z3d+/1DnbaRz2NzFO5lbekpweiTGxYmHpsvx2JZUNj6BLPIgoDdm7sniHtVUxr8sJSGS/dPRfBARhOW6e9affasPBV2/QYungCbbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cDMhsTwb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cDMhsTwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv240Rxmz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:47 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3664df30f53so3312794a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677786; x=1779282586; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cDXE+87tm7ASxvvK0pHPqOmmyuztiqWVG9E1ozeyTc=;
        b=cDMhsTwbtB2tLOGZSJHJqZg62wycuIzvYEvCKm6+nyWr7gzd2r/oWj1tAa8jMZxddj
         Eqk7ryhOtsYrpuEk9QOsoH6mHwtiPDdktKg2DqlW0GxOi5jApIauIK92m5vDHsFmnt/A
         /mZX2tlhHt745yWsVBHxHpOM9+dIbPq/0CcW94d/Q0w3/VfiHhIiOBWUcmgptLM+TBCf
         UlYj8AAfd/PfmwZ/EzO2O32lWuN0Wa4S28anjC4ZFxkqmGRWKXDcsJ/gG3/hlsdgOr5e
         AsrXY4eqaSWuwgA+FYCEEmtgOBgSWd+YlZMuiFieaIuijkuMC9Z696EEVK0H3zVLxIoX
         L1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677786; x=1779282586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cDXE+87tm7ASxvvK0pHPqOmmyuztiqWVG9E1ozeyTc=;
        b=Nc4rzJIQbQRlq5PVlTB2SjD5L2E2Nv3Mm+eVVTTMsdPQc159IqIZLk8Ba6F9/le8u4
         EQuoZ+D9dX7ZBN23HW+TOD8ipoFgIoVVoXpuvImN5Fc0Z/eDZRSD+lvzt+GT8ZzmZToM
         JLjnZqRs9tX3KlmyaM/5DmE5eGyGmaI7kHz4eL1FVT1scjuynRYrzk6qIb6VwkhA5pQu
         H58VhlAE5AhSdPEFBJzr6VI/6YqEnXgA0fc2c4j8UTFOJaiPn3EfHQORbWoLP3YLbyDR
         0slkR2TXdKVd6L4x8pNqh3+1Pm3b1WL0TCxDKQRwx54Uhj4apHjlzuGzOgKUw9YIWptq
         r/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+cE3fvq9MNQy4xhzgI/MqubAvM6XDVP931u3vkeXiGyJc+cJoDH9oN54mKGP/U9CEAevbXRiHURShe7iw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJv/evGh3Bp+rl7SgftGExjijmNMwHRPoPpY9IGBkG449CXOto
	ovxKDJ5MxEdWRPWD9UgdAf2nKwH7H3VIfpT9xxwiw2HxeHc8dHPEwlB8tAS17O5XB9o=
X-Gm-Gg: Acq92OECqbsm2mNIGjxGegoj9sPJnWXuO4vIPS+hZWYHbJzFVosyUR5CuACcEv+a+0N
	RmxV9NJ4ZfMkSn34et28r05XdBn5B6/BRRg0Rx3Frii359ROsyYKwo9RQb+RE9tvMP7MCDanKqZ
	uOaj+Iah9NToNMkD2exf6I3ZpThsshHKUn6hthvFuU2ecyMsOndlwq/wJ7CxYgZB16bBYsilAqF
	U/9lF6A2XlHSvctSA8TdeOn4rn/bBsRNCJ3QXqJ9Q6oelVA8uciJnzSjwWHVyxcaT4RILtzuCbO
	QZJ2h3YbbwTRVeujCh2JX7W3+CJ9KkhO7V8kFJUZg//pbHkJTd9tjKfieAD2GE4A7e1RqmDgZ+M
	dEZ0KPHoDtuOfi0o1VSpGjCJLcuX1O5rkssZbT4G2C8hW+d0adic5rGhL8rZQU2JnyuOdoN4m02
	w9/5yy2qbmPvJvcKjRz9q1V2tdWNsobpGihXeJGbgIwPblAIjnMDJMClBYMJM=
X-Received: by 2002:a17:90b:580d:b0:368:9021:3195 with SMTP id 98e67ed59e1d1-368f3ab5cccmr3651001a91.9.1778677785949;
        Wed, 13 May 2026 06:09:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:45 -0700 (PDT)
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
Subject: [PATCH v2 24/69] mm/mm_init: Skip initializing shared vmemmap tail pages
Date: Wed, 13 May 2026 21:04:52 +0800
Message-ID: <20260513130542.35604-25-songmuchun@bytedance.com>
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

memmap_init_range() initializes every struct page in the target range.
For compound pages with vmemmap optimization, the tail struct pages are
backed by a shared vmemmap page.

Initializing those tail struct pages would overwrite the shared
vmemmap page contents, so users such as HugeTLB have to open-code
follow-up handling to restore the metadata afterwards.

Use the section's compound page order to detect struct pages that fall
into the shared tail vmemmap range and skip their initialization in
memmap_init_range().  Still initialize the pageblock migratetypes for
the skipped range so the surrounding setup remains intact.

This is a preparatory change for consolidating handling across users of
vmemmap optimization, and it also avoids redundant initialization of
shared tail vmemmap pages during early boot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  9 +++++++++
 mm/internal.h          | 16 ++++++++++++++++
 mm/mm_init.c           | 19 +++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6f112e6f42bb..5fc968bac1f7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2264,6 +2264,11 @@ static inline unsigned int section_order(const struct mem_section *section)
 }
 #endif
 
+static inline unsigned int pfn_to_section_order(unsigned long pfn)
+{
+	return section_order(__pfn_to_section(pfn));
+}
+
 void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
 			       unsigned long flags);
 
@@ -2404,6 +2409,10 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
+static inline unsigned int pfn_to_section_order(unsigned long pfn)
+{
+	return 0;
+}
 #endif /* CONFIG_SPARSEMEM */
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index 4a5053368078..1f1c07eb70e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1004,10 +1004,26 @@ static inline void sparse_init(void) {}
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 void sparse_init_subsection_map(void);
+
+static inline bool vmemmap_page_optimizable(const struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long nr_pages = 1UL << pfn_to_section_order(pfn);
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+
+	return (pfn & (nr_pages - 1)) >= OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES;
+}
 #else
 static inline void sparse_init_subsection_map(void)
 {
 }
+
+static inline bool vmemmap_page_optimizable(const struct page *page)
+{
+	return false;
+}
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c64e5d63c4ae..3aaee1cf7bf0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,19 +674,17 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
-#if defined(CONFIG_ZONE_DEVICE) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
-		unsigned long nr_pages, int migratetype, bool atomic)
+		unsigned long nr_pages, int migratetype, bool isolate, bool atomic)
 {
 	const unsigned long end = pfn + nr_pages;
 
 	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
-		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, isolate);
 		if (!atomic && IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
 	}
 }
-#endif
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
@@ -916,6 +914,15 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		}
 
 		page = pfn_to_page(pfn);
+		if (vmemmap_page_optimizable(page)) {
+			unsigned long start = pfn;
+
+			pfn = min(ALIGN(start, 1UL << pfn_to_section_order(pfn)), end_pfn);
+			pageblock_migratetype_init_range(start, pfn - start, migratetype,
+							 isolate_pageblock, false);
+			continue;
+		}
+
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMINIT_HOTPLUG) {
 #ifdef CONFIG_ZONE_DEVICE
@@ -1142,7 +1149,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false);
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false, false);
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
@@ -1982,7 +1989,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
-	pageblock_migratetype_init_range(pfn, nr_pages, mt, true);
+	pageblock_migratetype_init_range(pfn, nr_pages, mt, false, true);
 
 	page = pfn_to_page(pfn);
 
-- 
2.54.0


