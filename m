Return-Path: <linuxppc-dev+bounces-20854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AE3CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv031rh2z2ybQ;
	Wed, 13 May 2026 23:08:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677683;
	cv=none; b=XaLE0CeYzRyB0QyL3Q/BWwPHsPbg3gKHJsW0xtmcrMTvq9TVpB9Pd5bKRHOa0SWb5z0wY/fXjF5LVjJbfhosMA1/uSPETS9mu3sBh00g3L4kWZWNdjV+cXyjNhCgvXfATjqGALoE9HYFchvIk0Z4jWYjPg3DKEIOLsAc43Jz3ZseUhfMUFbYKxi6XsRpeat/I48yLXiks5cp6hjn8Ew2+H2MOqsVJ46Yjj5PsH/bLxk/ugbrvshfyeUpQEHFAr5ftjMpbnjLTa1QnzhWGgmUFVOA/Rp1uMfC8w/cyv/WR31DW3fy1D2gpMiB62VrY44WCeCgq3qDAydVKUHYZU/Jew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677683; c=relaxed/relaxed;
	bh=UmVa4U0u+W/oPX/GlMpJ9lsDnm/CfX2AcDL6FiyA9T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqLflOF4AQIEnjshW0waO47XWbSXIV+4Q6O5zKDZSWHZORssvrg+BuRQJFRqRg1MJNL5UyKS9xYFrfbrE6wOIr4fh00mJBPY5l+vzX/j9xIg6GtpPTcimZ0Ngs2KHhih3OFOhxu7jPJ0dLm6i1bNhWVHBr210mxVI73msStXJWWOYP5gPhrOhApbe1QZIUMir9aQx/lhOwKiHlgpuPzTDfBZB7sYn9qbKGzrQh5htrttAGcPBZ7o54uevDV8KZ4Qwv01qcfhU7efAG+auptmaVy3u9tNDjzGIfrRhY6/uwC+YZvxHd3fU6rRsShJ5iv5BHdOxcLGzremTkUV/y4hTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ABD90Red; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ABD90Red;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv024KvXz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:02 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2bc763e2ba8so21640955ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677680; x=1779282480; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmVa4U0u+W/oPX/GlMpJ9lsDnm/CfX2AcDL6FiyA9T4=;
        b=ABD90Redeaz8D5RIoPoEDkqjSgG74+AZ7ExRH8akKTRd0TReDMUq9Cc9nEm7X6THRl
         vTlNt7C0Gk5q1uaSPZ0fVV3DqpN1dgRRaD6qoPtPLYWw6QnSvoE2tcnNF3fMNmVGMnqR
         X4jMChk6Jnw/Q5y2DKHGzn6rdnQMwjytKrq/dq5gxYPaoKAT6ISWZ25mroSIoIN43kCT
         RKOidYjSHOwkocX52eEKGZl4BUL3IpDrkH+3CEolX1y+8kITIfUo7PzfTHTv8iQ6mcXj
         bhRN7VSrOa9faHv1nmvwWEMolAoLPto2qXmWJOS8cRW1BoT/VZt00QiLGAwIAnl0tFmV
         323Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677680; x=1779282480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmVa4U0u+W/oPX/GlMpJ9lsDnm/CfX2AcDL6FiyA9T4=;
        b=i0fWM95vJHWFvkvuoHX+KV3eTECuNYqZAT5rOaTqBF7bgOQC3eaTEzFCgQNWZUBNZI
         yUCsebGH3oRfs6ufo9zOBTODZEVl0dOlXCG3QMBKDb1donElV0HylG+neO+8chhzGB3t
         32sah27KQiZ+nzZOg0pTJARVWeNX1GAQ71rRvZajvZJ2tS1UqSdfpVH28GZ8dWzOfEvW
         WrVjniPOnri0m1PXYBZvAUsAAcvE8at5ikfkFwJ0GE9V1AO2aspiKq1VjW+IwWjj2Cbl
         Y5XbKVUWdmxtqahYd4pEa8w95Ga4QGlDqd/Xwzne8ateKgmblohqaOYtutW9UTqPE5aF
         SrKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Kljcyl1P+ITkQfw0bFSlQHPbNER8tud24R2aBMBGIAZcdPW+yyxDbOuLJdp33wliYWhQ/QZhGYj/Qvig=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLmQCe5sfOG4tmpiQbj1KTh+9w9hWKg3Yq+g+k54N32RzpKEWY
	w/3YO8nS/Vak1ExWtzHO7N0juthpe0StzzCRCrIAh3MZvzDruhU2gAJUPj0Q9ti6IR0=
X-Gm-Gg: Acq92OHkitgJZaKJiN0AS6e1eDxthTodZ/P7N5Rwq1QkHAdXRkCpO2gk6Q+tia5oPqR
	JXHVMjXZBsbOe0NGpaoNnEOO5StaBfFX0Jn0yl+vPc41HJUGH8b3LJ+uzrgLhDGbCF7u+GVNnRu
	XjLtbrFNZzhWpE/EEnz+F0zfRLGqgzHws8J/CaRjeZ9gl+dZgbwQAVthv8AQ0nZl5cwh2r4o1Qu
	phD/xDqrkn66TOoTdqEem5rmnMAS8v0JQMIIYxPmouIhSpeNbd33hAUmaTFruDV+GbaAOqRETPK
	AdVtm94sEL4aR6Mw0T1aKv1rd5IjplsdEqbpOsuAvGhA4k43KkwLIBfVF7GsGpxBcgdhfp1Uqjo
	Qb2BgcHH2Ftbb3kyI0aMpk7l5hn+uYZO2/2Ue/cDwdybIO9fzXDiLwxPJ7sd1i6A7N73IuISvQ4
	6n3CyFfCn0exir9XMGFQ+i9CHdFxfDllJKWBYhMLkTywJ3ZT9+bATJOqJQG00=
X-Received: by 2002:a17:903:94d:b0:2b9:f59e:aca5 with SMTP id d9443c01a7336-2bd27702f8dmr38772485ad.39.1778677680317;
        Wed, 13 May 2026 06:08:00 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:59 -0700 (PDT)
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
Subject: [PATCH v2 05/69] mm/mm_init: Simplify deferred_free_pages() migratetype init
Date: Wed, 13 May 2026 21:04:33 +0800
Message-ID: <20260513130542.35604-6-songmuchun@bytedance.com>
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

deferred_free_pages() open-codes two loops to initialize the pageblock
migratetype for a range of pages.

Replace them with pageblock_migratetype_init_range() to remove the
duplication and make the code clearer (Note that deferred_free_pages()
may be called from atomic context).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v1->v2:
- Add Acked-by from Mike Rapoport
---
 mm/mm_init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5a910cc5534c..96e0f2d8c3ea 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,15 +674,15 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_ZONE_DEVICE
+#if defined(CONFIG_ZONE_DEVICE) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
-		unsigned long nr_pages, int migratetype)
+		unsigned long nr_pages, int migratetype, bool atomic)
 {
 	const unsigned long end = pfn + nr_pages;
 
 	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
 		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+		if (!atomic && IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
 	}
 }
@@ -1142,7 +1142,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
-	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE, false);
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
@@ -1993,12 +1993,12 @@ static void __init deferred_free_pages(unsigned long pfn,
 	if (!nr_pages)
 		return;
 
+	pageblock_migratetype_init_range(pfn, nr_pages, mt, true);
+
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
-		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			init_pageblock_migratetype(page + i, mt, false);
 		__free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
 		return;
 	}
@@ -2006,11 +2006,8 @@ static void __init deferred_free_pages(unsigned long pfn,
 	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), nr_pages * PAGE_SIZE);
 
-	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if (pageblock_aligned(pfn))
-			init_pageblock_migratetype(page, mt, false);
-		__free_pages_core(page, 0, MEMINIT_EARLY);
-	}
+	for (i = 0; i < nr_pages; i++)
+		__free_pages_core(page + i, 0, MEMINIT_EARLY);
 }
 
 /* Completion tracking for deferred_init_memmap() threads */
-- 
2.54.0


