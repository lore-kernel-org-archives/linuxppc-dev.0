Return-Path: <linuxppc-dev+bounces-26241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84611C624C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:54:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLqg6V4hz2yqT;
	Mon, 31 Aug 2026 17:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162879;
	cv=none; b=Ox35D9R1OGerF1JV1SXCx2WO5XgXIlyy1v815MzjIzmGWJYq75/eh6GhIoi0hdD3Mk+dvc3u6fRVd256p2Km53vWiwq2Ebhk/Y8/AYBSUMYWZbULCGPs90+2217JRCpBP+2S/YDgQwUQUXsfC9WffNn/5Gq2A2c5ywzq0BnLnv0/dleRRIbV/ZgOesdAYCPXC9AHeCF816a1ngl3gcxvmVy2jMwuQRKna2yqrtRYsLOXLIdbj1dKNiyZEDuR1D5MAEMZmnydlxwhMGm4BbRGgZh4QjI5kH556dHpOAPkviMzUGxRGziRd6OavxkA9Yr0EShE1WfVeBeL2jPrqD4LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162879; c=relaxed/relaxed;
	bh=4jDvtv3kIRHCHEO8kcmf2tbgWKyzjUPm6N9KUwqqy5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5TVQKKD0DeBEDR1ZJL/3fCWzzRdexf9BNEHdL2WFdWBoQQszUu4gSphwVx9w1T6pYa6gF6pcUsyTYdsfmQpZzAwuoZ0bSyfyBv1CoIEONa+oUj8WS1XKVC5x4iPE718ZMavNffTvxFmvAC/vgTlySWgYp90SOwS/lcXROqa/ziQPJVrLXlfjtYWAbR/F9oQ422v6k5NrjuaWIcVmX2AeBL/WRVhzxvzN4cO85RyijXOnKsBhsFenjI7Dtf28+Q7qJqv7VZeYH4eL6Jv4q1IZKfR8wHyh9PDcczigqDRQYNr8iN18lwzR/WFbIaXKy++euE5d1MuRXn+gqCBzcseYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VTYB4xLD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VTYB4xLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLqg1Q32z2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:39 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2891068a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162877; x=1788767677; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jDvtv3kIRHCHEO8kcmf2tbgWKyzjUPm6N9KUwqqy5o=;
        b=VTYB4xLDa7zKlo87sGCjDs7DmXEqq0QamEev66AhTiZX5sNGdxAiDs0RTrhpLapSa0
         JOVl2JXwSGL6dMdRRxkws6aBvyKGIGtTGCL51ke8JCEpjR1q9j7loQhKj4+BAtmq3HX4
         92KvMrzmgZiqgqJhuMzOphRwrArjEneUS2Yw866kK7iXIJ6CB+EDesOpkaoXVoXJN91h
         xYWiY3Mf5V72v88034Se+wq++ZUkg8h+XqZRBHGBxWPDSqxGBlj1gjRLUVr+V09epy49
         bA8hFJN3PRZaSWqr/XLENRg6eHISxJ7Xz6qAMTQFV6R/6rPq0bXe1z6pmmkC2uVPpq84
         EwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162877; x=1788767677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jDvtv3kIRHCHEO8kcmf2tbgWKyzjUPm6N9KUwqqy5o=;
        b=N9JXr3RgxPgRCieZ9EOGkOPx1di45LKXnJBzBgNY8uEaH8NIE9mRqhRsNXeVsDaxjX
         kCEbMGtbFhMMquUFlO4cwdW7aVeHNIqM4DIWrXs6BaN8lHWY7SN+pClGakvPsOKl6kGx
         YhLMRwIjU17mHMglJelC0+GcnXOFkk1lAVUOeDS1FLibBJGa5CIx6Z88TtK0WRAQmX0O
         HJWOoLJejjfgHZ1d3HCmgvxhF066eXHSxxtDX2QpTnFVlSXiQhQUzfiuSXvX7Hgyv/E/
         Az0VVW4SkyQn6iH4txpAq2Jvicibjhl7I7S/gxm4GA7WuvZ3Bfx80gT5Yr7NiIhJ0DUn
         yLZA==
X-Forwarded-Encrypted: i=1; AHgh+RqXWhrbHLweWujpU6mvxM0TTEwTnML019ek2K+yz28H58yKtvSSF1maBL2VB6Do4eY+9dTvI7Ms1JFt8A8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kWAsgcFIQ22SvyCxPkVrZADOypaOz65irZOqI1uXkkuj3EH9lI
	VVPkGQLTmpqDwTtt1xzTDcNzzHl6r3fD7iaRdce1GWUjumy4UH/FpxQRxvLYb9+sSx0=
X-Gm-Gg: AR+sD11pUJAk9tAgWhQJazJi2jBWowpDyb2UIOu45UMg4eUAGD05pPVtkYDzdyPcer1
	3CoLSQVosSq05QLWRX51IGR4NY24I/Kpu9Hjuy39fQl1nkOyxciibSCLxhpZ8I9ax7+eanAPUiy
	mVC6bt54ByuATXYm12sPqa3/1xzHEXnhYhTYBcmGutsZWeV/m6DXSaoAzHtWmqs0XVkauqUMz75
	gJopKLE2Mu1DnMZwDZpipZtlnoIn9PYlPqNpw9n3B5Bzp8TN0cb/jbwnEiuSJonIGPaZqMmuMBO
	YGJtNNx71jCrpnnQPV0PABLORW88YJAVCa6AK4GBp/zscIrV1Cn4JNqyr1RGmz3KEf2Ck7mTOpS
	D1NNY22CvJ5vsp9t8nnwi1zf1vKQ5E4WAAOs10FP7M0tBzhsnZ8Xw2HePCM3kHUIhU/DsaPE3AW
	sH7R10HXj8pykNSiaLBoiyTsa9erwNPm6IbwEUH89yZJAx0RG6cvWVdMt0CEKbxd4+Zhby4iIjd
	rTa0z1j4uIPnWTYlxFYE47G
X-Received: by 2002:a05:6a20:6a15:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3d2688bd9c8mr37731922637.18.1788162876874;
        Mon, 31 Aug 2026 00:54:36 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:36 -0700 (PDT)
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
Subject: [PATCH 02/11] mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
Date: Mon, 31 Aug 2026 15:53:33 +0800
Message-ID: <20260831075342.57563-3-songmuchun@bytedance.com>
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


