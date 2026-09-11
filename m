Return-Path: <linuxppc-dev+bounces-27091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561EC88E42
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:03:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2WH490jz2yrr;
	Fri, 11 Sep 2026 15:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103019;
	cv=none; b=oWyt+f72OHwePWZPiZBOituIgonW9Gk/6/YZjHKzmcTwacRkSAWoE5zRKy9FMSdKWhgC4qZFgNvxUTiPEeLt3oq7Zgoso3/kMwMm7mhW1VWgxYyu1Z+swHtsUwgTKjH/Gxhoyigp3VOT0H43QriNFARYmyBDjB21zBO5/MNlCjQ0z6n+pJKjusU4uIO4kNwRSOAQALsQuzx3LdA6Q7gKf2lbhUfexEnSktUpFN1kJSLq4oSlgiJgkfJhq/MAoYgPUj3+VkBzmQ2euJfVzIM8y8aTsu5T6SLYyIDEvvx6HiLikxgMt2E42w8Yk1/+y0D7F/AKopf3lDYLXJ6fma8j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103019; c=relaxed/relaxed;
	bh=6bR1GMYxjFGrp68HZ8kexJBvgYVBJednZ0YGt4vUS+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSQr2gEe46j4nnNp21jxKnkNbsKWllAtAOe2Hg9JDYO9MYyuCSAufYCoWL1+aRYj1s5HDImpFSVS++7+MVQc6ClzM7gGfVggGWXav9oYrPePwLQjvG/AfZC2k6217PFp4dPH91MgLSPTfDng+JYgkcfNJacHQ9O1noQPeBX1O9OTLFNNu/fIq2LUvwnHpDoN6UqrU/oObQwf9dw7uqentoYavXfKy3sRZPxk48onTQayHeTzrM9mzJcywpTfNTxVKdf0MnUlApGFbyjRlg6plDV1S1G0oVBF0oxwJr3z90WKZ+JSR/fFdHTL8vBTL70/hT5KigOxqGmNfrc0YlLn/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e66Ic3cn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e66Ic3cn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2WG6Yjfz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:38 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccafb752so475615a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103016; x=1789707816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bR1GMYxjFGrp68HZ8kexJBvgYVBJednZ0YGt4vUS+s=;
        b=e66Ic3cn19johv/CoY+FzBWPdxd0sPxlfa7F37ilyYx7e/4DteLsGaJwyUOMWDiEVZ
         ft/g6+kBH4cDBBckyWbrMNxPpsuoofffq8+Dkj80zvAxBSxxuUQsN8oRke6pCj4WVbPe
         OnzCnRP23zCm8D4zdAPAli6TJInlVImVSMbWQPhbfVd95DmHvyPsJD+SAzb1XqdxyXbe
         m83AtDHbylTz68jmYEBIW7aMV1b9d1QFcw+nk/KL8GlXLYUv7h5YBenfl5rIQUoTMq7+
         zxyhB9RsR6HB/UYJ8QMXljUhgTR+17g+TzbU0qJeaX0GaiqOjuXl3s5ZcBroSZQZKRoq
         /qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103016; x=1789707816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bR1GMYxjFGrp68HZ8kexJBvgYVBJednZ0YGt4vUS+s=;
        b=e0bGM+rvxRZI6uPgZGQ20Fuhjrq10wNh4KJATgb3WyxlIrrdjHcEQI1313qXqHi3u3
         n6yqGpF8eXNEcesqwNmgaeJCdwgwNHVgpJKoUCVg2jA4UAJQVhVzjHRKsZaavH8DwrCT
         vs29uGyY/GEz+XpA4imLRkTlqyfAHKG6fngBHXG/39Ptu93AQ1+5acUa8i+lNf4Dze8r
         PTuRp1H2zfJSun/sBOLOOFX73dc9lA/A3yP3wutdzfE8C/GptGKsbNPRuGxAup5hBmDW
         /SI4yA6Zi2Q/araEf0DuiE/cWjqRvYcg4q90jXgdvvEtNzZPAfah6SPmV5iIceTg6nDy
         g+Dg==
X-Forwarded-Encrypted: i=1; AKwUvBx2tnQBxaDrZFv28sNpma+vfaw+GsA2FLj5sB9VSgMLcNuNPdf2/oRxJbqpWTdvEw0vermkXIqhpZf+vXQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mRoEA5+mDtlgYYf+EsarW6bYKPahgmK8qo3DyqBEfOt/rakmaW
	DJOpwo8Nrcyejn9wOum3PayiykXzojTuBRxASV0OAFB4N7FhX9uGIBki5ybzFXSA988=
X-Gm-Gg: AYBFou3hq7VF75WJi1rz1q6Tjp7RwahtniT4vvBjVLKMj/JzKuI+hd7DOuAIdSmyMuC
	jVU8ycNnJ41PGjRXZD+d1/1b4V5H0UCQQnK18u6b2eJ9O6glP/uABKZ7hjfwkiZnlQedJiBOnWa
	817hLd+J7zzQGZGa8o6op6PsvLDsgHtrSM451//4DtM9b+VJglp4WuskKXJYl1iMGnc3CVoz0Bi
	oP4U/GME5KCmnEwR39gPvssXJ5V3lpJXcHlmtiNJWQGrTpN1tXkQ/DnRPlx1RrnPIAp79eMXsJ5
	Aad3m6UMCw8SEA1ypMYfJ4BEA6vvKADbk8BpAnd+2V92mY6p8ysZ4J/lTNHwqfWtZ+w8G7FLtJK
	aYGTFnMmGMvyQBW4xB6dh01I0KWjZ2BfPDd6Y745QP7/PwVN0Obuion32Jmrvb/YfNNM/EV5fKw
	TN3r3R/kcTlSDHpp43XOboR0+DCFeHSRmLzK43x9oON96CukXu9GRj7U5Y4PrN+uRY89fFioV0Y
	6Oxm3i3tCfLeiSbAerLPoWnNbwy/zB0byPyJg==
X-Received: by 2002:a17:90b:48c7:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39d9c226c4dmr4442740a91.19.1789103016270;
        Thu, 10 Sep 2026 22:03:36 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:35 -0700 (PDT)
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
Subject: [PATCH v3 02/11] mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
Date: Fri, 11 Sep 2026 13:02:19 +0800
Message-ID: <20260911050228.58884-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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

HugeTLB and sparse-vmemmap each have their own helper to allocate the
shared vmemmap tail page used by vmemmap optimization.

Factor that logic into a common vmemmap_shared_tail_page() helper. It
allocates the page through vmemmap_alloc_block(), and uses cmpxchg()
to install the per-zone shared page.

Expose zone->vmemmap_tails under CONFIG_SPARSEMEM_VMEMMAP to match the
shared helper's build condition. This avoids a
!CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION stub; when optimization is
disabled, the array has no entries and the compiler folds away the unused
paths, so no storage or runtime overhead is added.

This removes duplicate allocation logic while still handling both the
early boot and runtime paths through the same helper.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v2:
- Collect Acked-by from Qi Zheng
---
 include/linux/mmzone.h |  2 +-
 mm/hugetlb_vmemmap.c   | 28 +---------------
 mm/sparse-vmemmap.c    | 74 +++++++++++++++++-------------------------
 mm/sparse.h            |  1 +
 4 files changed, 33 insertions(+), 72 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 97511f651ebc..1a18c1c40c8c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1156,7 +1156,7 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
 #endif
 } ____cacheline_internodealigned_in_smp;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f977d0a7e002..5ddf06b83c96 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -493,32 +493,6 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 	return true;
 }
 
-static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
-{
-	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
-	struct page *tail, *p;
-	int node = zone_to_nid(zone);
-
-	tail = READ_ONCE(zone->vmemmap_tails[idx]);
-	if (likely(tail))
-		return tail;
-
-	tail = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
-	if (!tail)
-		return NULL;
-
-	p = page_to_virt(tail);
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail(p + i, NULL, order, zone);
-
-	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, tail)) {
-		__free_page(tail);
-		tail = READ_ONCE(zone->vmemmap_tails[idx]);
-	}
-
-	return tail;
-}
-
 static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 					    struct folio *folio,
 					    struct list_head *vmemmap_pages,
@@ -535,7 +509,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	nid = folio_nid(folio);
-	vmemmap_tail = vmemmap_get_tail(h->order, folio_zone(folio));
+	vmemmap_tail = vmemmap_shared_tail_page(h->order, folio_zone(folio));
 	if (!vmemmap_tail)
 		return -ENOMEM;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f22d815d7af0..7388a5b5cce3 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -42,27 +42,13 @@
 #include "mm_init.h"
 #include "sparse.h"
 
-/*
- * Allocate a block of memory to be used to back the virtual memory map
- * or to back the page tables that are used to create the mapping.
- * Uses the main allocators if they are available, else bootmem.
- */
-
-static void * __ref __earlyonly_bootmem_alloc(int node,
-				unsigned long size,
-				unsigned long align,
-				unsigned long goal)
-{
-	return memmap_alloc(size, align, goal, node, false);
-}
-
-void * __meminit vmemmap_alloc_block(unsigned long size, int node)
+void __ref *vmemmap_alloc_block(unsigned long size, int node)
 {
 	/* If the main allocator is up use that, fallback to bootmem. */
 	if (slab_is_available()) {
 		gfp_t gfp_mask = GFP_KERNEL|__GFP_RETRY_MAYFAIL|__GFP_NOWARN;
 		int order = get_order(size);
-		static bool warned __meminitdata;
+		static bool warned;
 		struct page *page;
 
 		page = alloc_pages_node(node, gfp_mask, order);
@@ -76,8 +62,7 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 		}
 		return NULL;
 	} else
-		return __earlyonly_bootmem_alloc(node, size, size,
-				__pa(MAX_DMA_ADDRESS));
+		return memmap_alloc(size, size, __pa(MAX_DMA_ADDRESS), node, false);
 }
 
 static void * __meminit altmap_alloc_block_buf(unsigned long size,
@@ -184,39 +169,40 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
+struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
-	struct page *p, *tail;
-	unsigned int idx;
-	int node = zone_to_nid(zone);
+	void *addr;
+	struct page *page;
+	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
 
-	if (WARN_ON_ONCE(order < VMEMMAP_OPTIMIZATION_MIN_ORDER))
-		return NULL;
-	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(zone->vmemmap_tails)))
 		return NULL;
 
-	idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
-	tail = zone->vmemmap_tails[idx];
-	if (tail)
-		return tail;
-	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-	if (!p)
+	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	if (likely(page))
+		return page;
+
+	addr = vmemmap_alloc_block(PAGE_SIZE, zone_to_nid(zone));
+	if (!addr)
 		return NULL;
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail(p + i, NULL, order, zone);
 
-	tail = virt_to_page(p);
-	zone->vmemmap_tails[idx] = tail;
+	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
+		page = (struct page *)addr + i;
+		mm_zero_struct_page(page);
+		init_compound_tail(page, NULL, order, zone);
+	}
 
-	return tail;
-}
-#else
-static inline struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
-{
-	return NULL;
+	page = virt_to_page(addr);
+	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
+		if (slab_is_available())
+			__free_page(page);
+		else
+			memblock_free(addr, PAGE_SIZE);
+		page = READ_ONCE(zone->vmemmap_tails[idx]);
+	}
+
+	return page;
 }
-#endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 					 struct vmem_altmap *altmap)
@@ -229,7 +215,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
-	page = vmemmap_get_tail(order, zone);
+	page = vmemmap_shared_tail_page(order, zone);
 	if (!page)
 		return NULL;
 
diff --git a/mm/sparse.h b/mm/sparse.h
index 3151d4db7575..a250bea4088e 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -142,6 +142,7 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


