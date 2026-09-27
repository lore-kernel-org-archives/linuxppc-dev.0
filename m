Return-Path: <linuxppc-dev+bounces-28293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0113CC9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvQ3ZRtz3048;
	Sun, 27 Sep 2026 12:54:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477698;
	cv=none; b=YJvPCc/x99+Cv6Fk5A0Wb4DS0u4Rgeci9X8X5WpcvuA5BMdp5iyPMyjJ0xh96kiwOwac+QHxOmOEBY5iBY/CZFj4dLqsdL7cjCO2eRP87FiJ2QmqxXEFRUE13lxOT1OlC2OPRaPqdNGEg4HVyxVTvp3Ht/f+EX/YI0lslK++22+OMh9jcPkQfuCr+PU4f8l4Eho/6FTRhQSop8kfLCghAS5gsNoauQNx3lLKlslhkLGxjHQS8HcO+0cUOKkYLdogXR/BlbNz97JkMrnbZahdr3aN7TNcdnmU6Dg49VLtmiG3IB+kHEi76IEijJwMaNjk+eF3hA517h/rBYVswodwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477698; c=relaxed/relaxed;
	bh=P4fFb5jWFZ2W8X/tUSizSdLW9y/fwSZ4mGTJ1PbgeB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN3o45PE9csBVkUWNeoGhcK9HrJLAzfJ2v/0A6n8qvOHyVzPRurXWiM3wRb44d5IVzfshrem1oAuSzmkQ6FyBZCqyxxbLjMFBqfUNpdLQXaim3MRipg/H5w+h7zMatADmb04Vfsuw955CzWbwAhAWpqt5aTPekA65wgxf6fhDo7aoeSd6U8k9h+k9vWETvpcS0Lqw2DEOOwMxo5+vsG+8xfclf3ltzQnawlnngL+VfOER2Pqv7BMJ1NbWZtXWoZyWvQ/E0JIHe2ZGNhxGTKoOQyCFzpPmutHxTWlgKKGEScSxBdI1rbP52uAotpBwpuCUCLHxArYZwSlHXmjIVSPaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QEj1BRmk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QEj1BRmk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvP2l89z30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:54:57 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-39d654f02baso850249a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477695; x=1791082495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4fFb5jWFZ2W8X/tUSizSdLW9y/fwSZ4mGTJ1PbgeB4=;
        b=QEj1BRmkUuR9sg7nZb5exWt4U9Xs7Kwcmd7dQgZGBGjrdvVRd83p6Mio6AEU59wu/s
         pJ9gIHTdoO+msYDoNlAhG0VJMV8db6FuSMqSP1TPjWIY6HHablztvttPB5hLHbjtBhGr
         B7ZxSFzbSIx9dd7TOA7jyxtJAgaGNyEN0LPIKrrclqZbYeVsmsE75hwc0kKnxtA2D/W5
         Dmnj7Q/VAvppKsjKWn3IcAe5nZ6fK90OarYbtOg/RYpPFweq8O4rRT7Sno2rxQzijNy6
         bEOeJ3GLgruPdTEq5UfJ1TFk1VjHpdDbX8i1z13mR9KXq0Z9xRHhZmmFoHVze8Wv5KKw
         jANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477695; x=1791082495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4fFb5jWFZ2W8X/tUSizSdLW9y/fwSZ4mGTJ1PbgeB4=;
        b=vWvkZPo7YF/mAFPIGWVrmDq6N78G6RPvbpDkvLApPnV88Y5JC7N32hO90M48l7318c
         /r3zb+dEL+iMeb37oBDe3bxyYdChlnx3nofyPd0n7ockVILGrTKXhmVTJB/YBkZWqMqp
         Ip1dvzAu7SCtxgfUYdbEd/HTDlR3mX2HU6GIP1egEt4v15AdlwUojTB+G7uYzxOsBjDp
         utohDDGG5EWfomqXVhyXeH9Mk2G1ebnBlueKwJgQTAXgj/UvGpRV7qBJVXDymNokr+In
         huH6cwRsi4UlZ4OE2uJbZ3ft1qXl4jTpgIesK15Eu2joHR6f2vhtIM3a3dA1+oNM0df1
         Kopg==
X-Forwarded-Encrypted: i=1; AKwUvBw+3VPMLN4jfE+xcDJA3UZI4qjXiB/yg9EqmxyRrUpyFpwWMwahZd/tgtoyHuFyoQTSKkUvwZqq/pKAH1A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLubxLk30ZDuh1P+o5pqshogmfkWy1CF8x1pqM3EKAIiRS7x6wa
	BRSc/tfzOhlLxqy0ASEluBgi0vP1vqW0vThzC72FZF62ASKV8eb98VbMAk+KxfmB1dc=
X-Gm-Gg: AYBFou1VFirrJo1YxbqIg+Nzk20tB5qd6jjMSNrGKgRm/mpFFf/leYOgNnUjnSLlUfS
	e49HVX3P9q+RdK9TEwU9+I9TOnrofK80zzKLDsXwNeJpW12NVE/X4zoAEsFjd9ayhO2xZz3Cwhz
	ha63Cy8+UmSia42QpZ7qBEgJOW65C3fT+19yQLTEYUR3LHJn3zKWq8Bksyqvv/kdR9xc7A55CSV
	3bCL1dkLxvrabRhqNzw2fMlkprID6QNAxPasDNd0CqC1WzufNNpzSNLMfltHYRoNFRgNlcnYHnj
	gPAaUs+IjW185q9BpYmX31YX/eri63I+4jEFGIe3dkhRt+TukCMQS59+HwqlMV5GEDXKPRGgsnZ
	Dqlef6EB1n7WgQD8D7TlZoT14YQv4ScSf5YjC5YZSsVx7MDJnO9h+r4846Ugg8+Mg/FPkA1ery4
	E9oCLiESRTngW8mK9tNkYP3hfUVcFTPMYIKVFjp8vzmwtbpjKTq1vY4RZXa1Zld6kGcFM3P4VgY
	JOkzxIaSVEnhEOTxoBT
X-Received: by 2002:a17:90b:28c3:b0:3a0:d18f:4be4 with SMTP id 98e67ed59e1d1-3a0d18f8399mr3416950a91.33.1790477695213;
        Sat, 26 Sep 2026 19:54:55 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:54:54 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 01/12] mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
Date: Sun, 27 Sep 2026 10:54:30 +0800
Message-ID: <20260927025441.741633-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
---
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
index f22d815d7af0..9b00085122b2 100644
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
+	void *addr;
+	struct page *page;
+	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
 
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


