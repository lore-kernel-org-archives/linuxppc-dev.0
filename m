Return-Path: <linuxppc-dev+bounces-28561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C36ACA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxgy5PdTz30Nl;
	Thu, 01 Oct 2026 00:07:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777246;
	cv=none; b=eo/fNEeKfEjc6cf8P1fo6pyuweFd+KKJN/f6UdLvbMHNiaWJQ0tDRgxTeY1wdJLDOauRAd4SxMF4ylukpi+8yqEGIiY885IOEb0m1PAIIJOp5qtZmSACdc5P96T0/gWwm0hdHdJV97CaQ8Cv+wA4BVbplTY7Hpk4ue2Y3nfDg+ljWiVBQ1OpzvByBYLPbQiYufZLcPCPBcNu2pbVgWdJVNMTv+i2cT4IqEC7ZEEozPFSyWsAfWzS81PNV1vEOYNONzhoyVJfAq2f7fKCI9OCb3N0TBHBltvE4QDrxtD3i1Jb+WPeD+a67AXYdEknuWWU7dNvQqEiLGOe6NdrX3TCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777246; c=relaxed/relaxed;
	bh=9/Fb5g8MDUieQ0AsGZlC/m2n+LM+/+hXUoXNvWx5za0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlPO1xGVK5bDrApKGkAAhBAwLYVBP8SqXd7jgGEO4mOvzJDFWJO6IuFtEbiA7qiI8jsIgTDJJBWw1wEY7A6Do/O+xxwnTNsZtEH3UczoBFUSgMKhemGe6B/u0YyijiiiFhUYzXEsYGb1gogzPMRVKkv/dVLEh2Rx8BVbHpnMm+xh6uXqOhBMcorCEv7R9g1TUKLwlzdN4MHV4PqGqIDzqLjMN9NDIYdkVmqUo/pPEIttXssHv4XGMELD6ecoYmEZY/x5BO4gaIpcJH85JKJDrSMYU24MjsgJXbg2oPiol+TJsYxnEV21HcAVwWfxdDykYa9ZeJEGpEBhen+BNah1sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jqvs+UfB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jqvs+UfB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxgy057Kz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:07:25 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso3068249a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777244; x=1791382044; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/Fb5g8MDUieQ0AsGZlC/m2n+LM+/+hXUoXNvWx5za0=;
        b=jqvs+UfBEnPXs/zQi7pIcizqMyveXiK9KeZZP3eB+gjmqGYKPdcJuj4AOZgkflPmYv
         FGba24UqlitrbDBDCDdoC9ZVKGRe+QRTkjiSdBWPn9zIfBg/KVNgdA2RYPIWuMUcYPLF
         FYkI+vtdIy0OCMJcVFMykO3wwvW2EtDSeW+M1VK5d+o++CdFSCXmHKdnE5MOlXWMI5k8
         Wfx6jMXGT7NGXimhFpOrlrKW4auFAlmGFUz0lpRJoDgmfvcwgbsP9IOCKpLYi0zXyq3z
         e9OCIcXyxGwcBHzzftzQNWySf+QOveSk0wg5luXquX+kd77+ksGCvM2afnPfMUKD7Gvx
         zHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777244; x=1791382044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/Fb5g8MDUieQ0AsGZlC/m2n+LM+/+hXUoXNvWx5za0=;
        b=1PdvGq6Y3As3spDnB2KlReFQyUEo9c5qldQjU31MIny3+gJHdKX8zTV1QXWsvWUDqQ
         sUPTF4T8FHW9NyMz/S5TkZZPLJ3jwININdND8zQdmU+n5i06Yu7rpMQFeh3BVRwmxO0Q
         BNVI3w/6oVDXoT6dhsWsZ5sNV/hUgQrIkOWc5ZEiv/RTIID8kPovM0o8wBMh6OlglwjL
         iBniKTRNErnoSLPpHFBT3AwzrozdDckUrjBt8TYGcAB9Gx1o0DAHhJzB7VM9oi2WssU6
         vvrrHm0KD9FjRbstfpd7fRwqzTS0P7BXTWBnMSewctCLCqEdCN27HwXoC/lpce4cWfNX
         Ijeg==
X-Forwarded-Encrypted: i=1; AKwUvBzNNRp313xlpleoTZ0+am81Pue4KcjKTat7NqG0G/PAUPZMJgweXIznjjx0eOP6yDO7YY/hUjQhagSl3eQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKfpe5XJkWI6Z1p1J5+swQCz98okaz6RMPZo/Zj3YisSvgqaNYy
	XJW+mK8XZ2p6Lps7uLUxC/5gjXvV1AkLxrqFrwdaJfGHU/1XX9K83HIUkhuctBBogbk=
X-Gm-Gg: AYBFou1Bm7j8Dubl1peSBLgFzC5fyEf0z6K7EYf0uiPB+mB+M0GNOnHmEJeRuPrf/0/
	wSstzfGuaNZDNNjmyr7TqO4MAGBbBTyu050UjkV6nqSFQcpPuqwC2aOju0H6wSP+o/GUTan/Fkq
	cNWDpSCRi1R0i8koJpp8db8+0/0Ka4riZ3WLsduyPiUa5hn+iYt8ONW6V6l+d7xuWDBwPPvnfrR
	aCJfLDlpKc0N5xczYFQT92f7wQDr10MWpRo9M+vzsjM9OVtzUm0ZMoeksWNY8PNFpmgbV8k0cB/
	lzPlWsbISKjwH5Ih47/SWfKTbchHaVBKvW2p/wQY+L5Fed49naHhUu7Y92birgcSVT04dqEiwRs
	D9RgHzUi+reiwdqMoNOCZNIiIhzWlucnDkKRm+JTGrLMomPdACiYz2hXLZEgGftQCuml9ej4Tcy
	8enbQDZ4Gr7tkLC583srKmAAhtwIzb7RNgzKIlz1koCOf09yNoa3CbLL+IWbl9tVK9uJ09iwCH7
	autY/wQ53ropw==
X-Received: by 2002:a17:90b:2687:b0:3a4:a270:23f1 with SMTP id 98e67ed59e1d1-3a4d103d004mr1307962a91.4.1790777243537;
        Wed, 30 Sep 2026 07:07:23 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:22 -0700 (PDT)
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
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 01/12] mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
Date: Wed, 30 Sep 2026 22:06:16 +0800
Message-ID: <20260930140627.57431-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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
allocates the page through vmemmap_alloc_block(), initializes the tail
struct pages, and uses cmpxchg() to install the per-zone shared page.

This removes duplicate allocation logic while handling both early boot
and runtime allocation through the same helper.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Move the constant declaration to the top of the function (suggested by
  David Hildenbrand)
- Collect Acked-by from David Hildenbrand

v5:
- Move this patch before CONFIG_VMEMMAP_OPTIMIZATION is introduced

v4:
- Update the commit message for the renamed VMEMMAP_OPTIMIZATION config
- Collect Acked-by from Mike Rapoport

v2:
- Collect Acked-by from Qi Zheng
---
 mm/hugetlb_vmemmap.c | 29 +-----------------
 mm/sparse-vmemmap.c  | 70 ++++++++++++++++++++------------------------
 mm/sparse.h          |  3 ++
 3 files changed, 36 insertions(+), 66 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f977d0a7e002..76765c97ff68 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -19,7 +19,6 @@
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
 #include "sparse.h"
-#include "internal.h"
 
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
@@ -493,32 +492,6 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
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
@@ -535,7 +508,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	nid = folio_nid(folio);
-	vmemmap_tail = vmemmap_get_tail(h->order, folio_zone(folio));
+	vmemmap_tail = vmemmap_shared_tail_page(h->order, folio_zone(folio));
 	if (!vmemmap_tail)
 		return -ENOMEM;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f22d815d7af0..9af349581fbd 100644
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
@@ -185,34 +170,43 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
+struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
-	struct page *p, *tail;
-	unsigned int idx;
-	int node = zone_to_nid(zone);
+	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
+	struct page *page;
+	void *addr;
 
-	if (WARN_ON_ONCE(order < VMEMMAP_OPTIMIZATION_MIN_ORDER))
-		return NULL;
-	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
+	if (WARN_ON_ONCE(idx >= VMEMMAP_OPTIMIZATION_NR_ORDERS))
 		return NULL;
 
-	idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
-	tail = zone->vmemmap_tails[idx];
-	if (tail)
-		return tail;
-	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-	if (!p)
+	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	if (page)
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
 #else
-static inline struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
+static inline struct page *vmemmap_shared_tail_page(unsigned int order,
+						    struct zone *zone)
 {
 	return NULL;
 }
@@ -229,7 +223,7 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
 	zone = pfn_to_zone(pfn, node);
-	page = vmemmap_get_tail(order, zone);
+	page = vmemmap_shared_tail_page(order, zone);
 	if (!page)
 		return NULL;
 
diff --git a/mm/sparse.h b/mm/sparse.h
index d3a71ef4fad0..6e7aaeaa5594 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -142,6 +142,9 @@ static inline void sparse_sections_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+#endif
 void sparse_init_subsection_map(void);
 int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-- 
2.54.0


