Return-Path: <linuxppc-dev+bounces-28305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF18BC98324
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 05:51:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hstpq6Q19z2yPq;
	Sun, 27 Sep 2026 15:51:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790488275;
	cv=none; b=DSwUof3XlSVB+qFq4RumwsQ02JFISUb9ewzVjHCMvt6H+ou6EpeJJmaylyEvi9tU7dDB5lF1V7Yb5Z2PNQvbxJBjAtBFuqweWaCwIk6bdFBUt9x1vBEzNtEgBIRnma5HSpfP0Wy2jZGDSIiWjiswAbBILODKH5Eg0+EF/CZCWgToV3MRGkiunCbe3cOBkEFI8oZT/jpusmaWy6SmGc4uKryosfURZEaNLIpLhTCESI5q7Sg6mZjbpgOZ9cJduKBjxFfqbZyR0rXPza0exxK29hMZzXGzWzyBElfbcnODHwhN70AXT0BZIN5G9Y/snPQXJpwH0ls+k99qHFikbNlkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790488275; c=relaxed/relaxed;
	bh=UHrAQJDjpZkXol5VEY6/BSqUifaqAPBbX8o+2SqFxC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ci5PLX6pP6pjVgwFKtnEiZCaVxSgAEd+/vP/zorUgizKp/CQXzeqldlHv9X9oqtYLkIM4dLhsocj3KtJO/+8n2Q6GvXk6nhrovQGuBcUafQ1fjyOuDydLXIa2scCVS4t6E46SrINXOccR9W9d8zYf58mZJon5l+gAKugm+yWf2pn4V8AIAu68I+o8g6WdMAlfoB3uNRD8Q1+QrqV2p2hduaNpCBqhVTpBCNkwQfyO0XkyDH1C7dNSk2PCVuDeG8T9LIR9PQqTwN98ieq33lwe2FYlCZ3c4k00KkZPAZEXgXvN+W25CsreVBbwPcu6MOLXB8lUc8g4rhheTuf505wpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zJtyTOLx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zJtyTOLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hstpk41Y7z2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 15:51:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98A77414C9;
	Sun, 27 Sep 2026 05:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AE51F000FF;
	Sun, 27 Sep 2026 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790488266;
	bh=UHrAQJDjpZkXol5VEY6/BSqUifaqAPBbX8o+2SqFxC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zJtyTOLx9AzZW4ceULP1f5wpwRT2S4P6gkxVsut8kjkqSTxNh5x6hLRAGKDAfxlbL
	 DIR4BCawrmMPx/OsYsTVZ+OhvOXxWeI5Rji1wbVfkcaxxSh1vASsLh9BiwnfIegVs+
	 MySOGQKlazDuj2QhwomrLRpDzb1lF597f+vI6jUw=
Date: Sat, 26 Sep 2026 22:51:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v5 00/12] mm: Switch device DAX to section-based vmemmap
 optimization
Message-Id: <20260926225105.a56f29d76b2f496c8dc2dac0@linux-foundation.org>
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 10:54:29 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> After the HugeTLB conversion, optimized vmemmap state is described by
> the memory section and the sparse-vmemmap population path can allocate or
> reuse shared tail vmemmap pages based on that metadata. Device DAX still
> uses the older DAX-specific population model, including a separate tail
> vmemmap page reservation and architecture-specific logic to locate or
> populate reusable tail pages.
> 
> This series makes device DAX use the same section-based model. Device DAX
> records the compound page order from pgmap->vmemmap_shift in section
> metadata before vmemmap population, uses the common per-zone shared tail
> vmemmap page, and drops the extra reserved tail page. The powerpc radix
> path is updated to use the same shared tail-page helper, so the generic
> and powerpc DAX paths follow the same reservation model.

Thanks, I've updated mm-unstable to this version.

Sashiko asked a thing:
	https://sashiko.dev/#/patchset/20260927025441.741633-1-songmuchun@bytedance.com

> v5:
> - Move the shared tail-page factoring before introducing
>   CONFIG_VMEMMAP_OPTIMIZATION
> - Add a new patch to allocate the per-zone shared tail-page array
>   dynamically and fix the RISC-V build failure reported by the kernel
>   test robot
> - Select VMEMMAP_OPTIMIZATION from ZONE_DEVICE instead of DEV_DAX so
>   MSHV_VTL cannot set vmemmap_shift while leaving the optimization
>   disabled (reported by Sashiko)
> - Move the vmemmap optimization macros and MAX_FOLIO_VMEMMAP_ALIGN from
>   mmzone.h to vmemmap-optimization.h

Here's how v5 altered mm.git:


 arch/loongarch/include/asm/pgtable.h |    1 
 arch/riscv/mm/init.c                 |    1 
 include/linux/mm.h                   |    1 
 include/linux/mmzone.h               |   27 +----------------
 include/linux/vmemmap-optimization.h |   29 ++++++++++++++++--
 mm/hugetlb_vmemmap.c                 |    1 
 mm/sparse-vmemmap.c                  |   39 +++++++++++++++++++++----
 7 files changed, 64 insertions(+), 35 deletions(-)

--- a/arch/loongarch/include/asm/pgtable.h~b
+++ a/arch/loongarch/include/asm/pgtable.h
@@ -72,6 +72,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/mmzone.h>
+#include <linux/vmemmap-optimization.h>
 #include <asm/fixmap.h>
 #include <asm/sparsemem.h>
 
--- a/arch/riscv/mm/init.c~b
+++ a/arch/riscv/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/hugetlb.h>
 #include <linux/kfence.h>
 #include <linux/execmem.h>
+#include <linux/vmemmap-optimization.h>
 
 #include <asm/alternative.h>
 #include <asm/fixmap.h>
--- a/include/linux/mm.h~b
+++ a/include/linux/mm.h
@@ -38,6 +38,7 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
+#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
--- a/include/linux/mmzone.h~b
+++ a/include/linux/mmzone.h
@@ -96,29 +96,6 @@
 
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
 
-/*
- * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
- * be naturally aligned with regard to the folio size.
- *
- * HVO which is only active if the size of struct page is a power of 2.
- */
-#define MAX_FOLIO_VMEMMAP_ALIGN					\
-	(IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION) &&		\
-	 is_power_of_2(sizeof(struct page)) ?			\
-	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
-
-/* The number of retained vmemmap pages with HVO enabled. */
-#define VMEMMAP_OPTIMIZATION_PAGES		1
-#define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	\
-	(VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
-#define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
-
-#define __VMEMMAP_OPTIMIZATION_NR_ORDERS	\
-	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
-#define VMEMMAP_OPTIMIZATION_NR_ORDERS		\
-	((__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 &&	\
-	  IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION)) ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
-
 enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
@@ -1156,8 +1133,8 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
+	struct page **vmemmap_tails;
 #endif
 } ____cacheline_internodealigned_in_smp;
 
--- a/include/linux/vmemmap-optimization.h~b
+++ a/include/linux/vmemmap-optimization.h
@@ -14,6 +14,23 @@
 #include <linux/mmdebug.h>
 #include <linux/mmzone.h>
 
+/*
+ * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
+ * be naturally aligned with regard to the folio size.
+ *
+ * HVO which is only active if the size of struct page is a power of 2.
+ */
+#define MAX_FOLIO_VMEMMAP_ALIGN					\
+	(IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION) &&		\
+	 is_power_of_2(sizeof(struct page)) ?			\
+	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
+
+/* The number of retained vmemmap pages with HVO enabled. */
+#define VMEMMAP_OPTIMIZATION_PAGES		1
+#define VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES	\
+	(VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
+#define VMEMMAP_OPTIMIZATION_MIN_ORDER		(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
+
 #ifdef CONFIG_VMEMMAP_OPTIMIZATION
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -44,6 +61,8 @@ static inline unsigned int pfn_to_sectio
 {
 	return section_compound_order(__pfn_to_section(pfn));
 }
+
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #else
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -64,6 +83,12 @@ static inline unsigned int pfn_to_sectio
 {
 	return 0;
 }
+
+static inline struct page *vmemmap_shared_tail_page(unsigned int order,
+						    struct zone *zone)
+{
+	return NULL;
+}
 #endif /* CONFIG_VMEMMAP_OPTIMIZATION */
 
 static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
@@ -87,8 +112,4 @@ static inline bool vmemmap_optimizable_o
 
 	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
 }
-
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 #endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
--- a/mm/hugetlb_vmemmap.c~b
+++ a/mm/hugetlb_vmemmap.c
@@ -19,7 +19,6 @@
 
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
-#include "internal.h"
 
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
--- a/mm/sparse-vmemmap.c~b
+++ a/mm/sparse-vmemmap.c
@@ -167,16 +167,44 @@ static void * __meminit vmemmap_alloc_bl
 	return p;
 }
 
+#ifdef CONFIG_VMEMMAP_OPTIMIZATION
+#define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
+
+static __ref struct page **vmemmap_tails_alloc(struct zone *zone)
+{
+	struct page **pages;
+	const size_t size = array_size(VMEMMAP_OPTIMIZATION_NR_ORDERS, sizeof(*pages));
+
+	pages = slab_is_available() ? kzalloc_objs(*pages, VMEMMAP_OPTIMIZATION_NR_ORDERS) :
+		memblock_alloc(size, __alignof__(*pages));
+	if (!pages)
+		return NULL;
+
+	if (cmpxchg(&zone->vmemmap_tails, NULL, pages) != NULL) {
+		if (slab_is_available())
+			kfree(pages);
+		else
+			memblock_free(pages, size);
+		pages = READ_ONCE(zone->vmemmap_tails);
+	}
+
+	return pages;
+}
+
 struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
 	void *addr;
-	struct page *page;
+	struct page *page, **pages;
 	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
 
-	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(zone->vmemmap_tails)))
+	if (WARN_ON_ONCE(idx >= VMEMMAP_OPTIMIZATION_NR_ORDERS))
+		return NULL;
+
+	pages = READ_ONCE(zone->vmemmap_tails) ? : vmemmap_tails_alloc(zone);
+	if (!pages)
 		return NULL;
 
-	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	page = READ_ONCE(pages[idx]);
 	if (likely(page))
 		return page;
 
@@ -196,16 +224,17 @@ struct page __ref *vmemmap_shared_tail_p
 	}
 
 	page = virt_to_page(addr);
-	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
+	if (cmpxchg(&pages[idx], NULL, page) != NULL) {
 		if (slab_is_available())
 			__free_page(page);
 		else
 			memblock_free(addr, PAGE_SIZE);
-		page = READ_ONCE(zone->vmemmap_tails[idx]);
+		page = READ_ONCE(pages[idx]);
 	}
 
 	return page;
 }
+#endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 		struct vmem_altmap *altmap, unsigned long flags)
_


