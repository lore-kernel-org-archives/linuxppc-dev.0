Return-Path: <linuxppc-dev+bounces-26703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7BFC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf80p6zYQz2yrP;
	Tue, 08 Sep 2026 13:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836650;
	cv=none; b=Lynly/lsud1RqlcUzQHpkFy3thTHqUlOm7j9OD8GPvFMLeFZ2m3jJUmtJ2pVx0Gck9SfhiHijNU3mX70DGbY3PwJgXArRjGHrxtp4IUcZ0WzvXjo4Hwt1GJw7q4nVlEhxfQY9kVBy3N3Uhtua9xiCkMRVlwL9dWrteNV6YbsKVP8CX5P4K1OU4KJSSa3R5FAjsQbcvZS5lNXPX+h7+PhldTOeg+tCR2GGF9qhSnpDF7pKhUlL1PryLagrcs2sitid2RJn0DbDdgMZi5B2Bn/f5oqekj5emMtrCerwXOdFHq5OmOT0u2PB6Xl5nGeTXbsG6afXOcLHjJgKID23TY8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836650; c=relaxed/relaxed;
	bh=8ftmCWznJ9sK2TfrzbteNQ0qTXPtrb89VSG1QYG+6OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5icl/hTBz+NSmeom1gHrvwABrVawecguGRjrSTVVQVuLcD6SfmyK0ATyKe6ZhMGIgK+/9AdHiETTrNTq6lkV2QssbQDuzfYICpKbh2NTFbrwCMD9O0nlvpbNeJy5ePymnDVTBjDZjcXeBrKRvG7ksx+x3mpK+t+plfJ+F63L+vddfBIfmoW9oAUxjNeoG4ZEhzTKa4ug4bQcFyJv1v4oVTcmFYisS0Fz+QUm0/M7Hvm0lhNiOKPKO3/FckS9HAuQJoJVCo4hJDRv0pS1APlsJQYYaS02DqxN0x9jSkxjuvbZJ9jIN4DVfsjnGH2GNKem+QVQddbhsriZDQMZPlYDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AH+IYveN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AH+IYveN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf80p1F0Hz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:10 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-851cbd64814so1558516b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836648; x=1789441448; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ftmCWznJ9sK2TfrzbteNQ0qTXPtrb89VSG1QYG+6OE=;
        b=AH+IYveN8Jo2ujVeL4tf2mr5qWrxvh3hD3arUveNMZV+ZwhubZNCJG35lGGtqK5KtN
         XYGdg3wo7/G5xr5xY5sE8RJVHL6wNcka2Pb1OztuvTJSTJ827wrEog6MNPQdIegI6Hu7
         Nofqy417iau+p7VNQhxuezACmHfnTft4HvWW4FNqZKbM6K9spTsWu0I+sAZ31372mrHD
         cGUHAk+xSfIgbOHIKU36OWXLqprbxuDK+8pJiXPpAI4fm3q/GRbv3OEVrOh1OQ1osyJX
         CJP0J1MVkO5V3TQ8oeqPIaoIxffHGLOy4bJ5nGYsgSR/sum//mKFbTekypL1QRKLPPfq
         43Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836648; x=1789441448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ftmCWznJ9sK2TfrzbteNQ0qTXPtrb89VSG1QYG+6OE=;
        b=klu36Hxe3Dqa5W4UYUX1J6yASZ2tp6KI+JqAIJKB9LzXQGtQy16+puMSDJVkkMDjoE
         2va3RDqCrwT33uVjrgQgGF/t8WFURS2mVkkMH/SjB6KwNNsRxCpgbK7emcqm3hCOyQbi
         /gTxDkgJiXCRUqz+dyueM4DJpgq4kv+DeVGCe0RNUqvepgo1b2g/dU2UkB3xjgMVCGBQ
         vVu0iW0iQ/Z8fRe1GBjkmSUPDt2ylJ3V8URO7JBNAO0NSs2NtY1nP16R7cLmIClGXmLa
         1fOEVmD1JJVnNJxXImBOCRU/Sslds5i2TOdtM1gcXjIKNkyqskIFqrXxKq/wW1W7cZS0
         hZOg==
X-Forwarded-Encrypted: i=1; AKwUvBys0KyTC9LYlbo8QJOH1bSgJrNrEKRbnYaeIwROse+c9XosjoGZNDfUgTkSxo5WEuU3cfHgrcwRnDXyzMY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lksQ3m/GJfQiAxOrwwkS+y+ZEQq02MosZieKdbNT82jmEERUzf
	oXQGFjPTSGGrWAYlEUAprNyQrzFg0k6CHjvuMlYrF5dhC/fPCmxr69oxBzUmTLwnfkg=
X-Gm-Gg: AYBFou3rl3nge1Kz5Md25HQ5fjwGRYvI9tT5mNt3p+3afHv5cu887qsiMNDKfKCIXNB
	mAp7AxXOXPicrJlvuuA5aRWBgW/SPrRdnmaSjnYpYBdXh1HZgm/yYEHaCKllKq2pft8+bFyZIYD
	m9hDqq2HJQQ8hNdASh+4dumN8ow5remL27nATDKxouysKLYenKJQVpBIyzMR0hrxXJ8Yeqaz/Y8
	0ikeHS3hae+fhgQuLWLZjzddiNlbnPhZNGySNA/DKyzkR1PdPDd5Mq++YYZMNIwGL0Fa1kcgoqJ
	OgBtOFheVUCIjJdLEUJdJO500//We0200UmC9nASAnnlH5LPSpdf65NARhswpfbWKaUz4i4U70b
	NTnIoBP4jILvnwnFHmHob/jqYgNe0078kIVqDf5tWKUExtl1IXHbFy6N/dzci1XaqWgYsB4jJfN
	KIzXKk7oeTE++I37xttwx/lzEpiu1FOqOUHrf7H2Iyld5jdW9Zz2QDeSPq8UliONm7AeVMlBwWR
	ojBX0k4QEVny/3y5pYCB6x8
X-Received: by 2002:a05:6a00:98b:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-86169c71e5cmr35224717b3a.10.1788836647750;
        Mon, 07 Sep 2026 20:04:07 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:07 -0700 (PDT)
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
Subject: [PATCH v2 02/11] mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
Date: Tue,  8 Sep 2026 11:03:26 +0800
Message-ID: <20260908030335.96549-3-songmuchun@bytedance.com>
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
index e9b54ea0eff0..d3778ba976a5 100644
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
index eb339c4a71f4..4a57e6c3352c 100644
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
index e62e6aa07f12..70143dd8b579 100644
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
index b408d15baf7b..59b825df83b9 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -139,6 +139,7 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


