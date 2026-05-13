Return-Path: <linuxppc-dev+bounces-20886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C200CCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:12:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv3R0pVDz3dHp;
	Wed, 13 May 2026 23:10:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677859;
	cv=none; b=N7WMPqXmuaXdGHJZc6gn+kip+jZZsukbKupUgzueMf7uy+E3g6L6EHaWl+PdVnhIcjRgipRxR4eA5EhZ1KEol+oHgSjiMyWsCV0U2dY0HKB386DEY8lIYZ/PdmTYHVRfp9wYboDd4k/mndQ08SubMCpLNyqfPhL19w/jrECwdERMRJEfr/JyqZrV5/kiWNhrZC35nrxutgRRK4GVnWWLTGI6faHcOktkgr8ffcRXtL3rdgWMw1aM1teHSe/+LwzTX3dVbqaXjhbY+un0mJTdpKLgnF3FvIaLuB+3KFLQ+uX4ihoAbnt2cagmcCpwA5wrcgmv5yeZw5SB8v9Gs6F7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677859; c=relaxed/relaxed;
	bh=dToyrDGV72K3gHJcuzQsCSmu29LS3Njm8M96u525pzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrdMeGEg84nGG2GaGhxOGR5F7MX5Yk+R2+dZb9TyLzuZ9jEfFlTctBgRkMXkIPPEQ7uKAx8+O74hdIGKOdLHDFaF4DYa89BA+p4ZXxuSSRMJ7GBFo11YQoQh00JzaH0+gcYjq/fXmZ1rQCKbYOLtlH2lBHCDLC5DaQ6WSIw6V1z+3CHyj2CiMYuB/8Lg8JLgrybP8a95X7zVFN6Qf/0Nk6VfPA8Iy1Wo1M2W7eHfsU2o4nmvL1C633JkvwroOKjqGwGC2YPeh/nhcm+PPL4lX9YujRgERMz5ix1vYVue4+/0XgBc+mHLM40KC/z8apCZLwXoNgRWrXQRa6p7DwUtaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fHn6RvcZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fHn6RvcZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv3Q2VgJz2yfN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:10:58 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso65526405ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677856; x=1779282656; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dToyrDGV72K3gHJcuzQsCSmu29LS3Njm8M96u525pzE=;
        b=fHn6RvcZuw5Fw3Wy1T+yJr9M73TGJ+XUCnyhvxYcXb/cjcmKFFqt93+YgK3KYhADFE
         AmwCrEth1RtkzwCEG5cyGBgWqxlG9y1+eNsSgcoE42k9nxUQ2FoQLuOR5FI7V1M+f717
         MrSi35hXXh4/dgqk2a7WymxTOj8ZpPLHu7rgsnBF7ENR9ssF5HQfTXWrDIfGQCRFDriC
         Z1S9hvvx/+kJ4s5WbF6wmZPxBzXk/pFQEkPeS9IVZFg2DBaSk32oi0XeHR7R/j5FpRI0
         /7T+Hu77pChfxA0lpw4tauyPG5Oo9IAR8XWmGIxi/i7Q1pROlk+9Q1c1I3n+mcpP7dtw
         05/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677856; x=1779282656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dToyrDGV72K3gHJcuzQsCSmu29LS3Njm8M96u525pzE=;
        b=eOJMIxWQWdBzAkf6nX2qz3roV+jK1lcd200DbsvIY5sLsWSWldToUjKG4/c1GQRBLr
         b6iyUr/SE6PkZPAG2NoMR09qwiu7WHjWYbTsX/YZWemjj5aiD+bXkBoPicT9yrscDVlb
         a27kZeXaem8VXyhmRC0PzT4PPciNMHLgSTTebd+TvrBtUdQeTNc019aCNOgLqzcFUtAo
         hcedBqE4utnX95TVa73Z9RC1XPA5Y3wL0UrjifoF4BJN8gy2LSpZsleodpeq1iZhvfqx
         e0N6nH46y4NYT87AEWI+aflZ+pjfo859VcHgYEUWOQKgZiMg7TmtOaGtPlaxXsStQH1c
         70vA==
X-Forwarded-Encrypted: i=1; AFNElJ9zVsyRySz5u3xACMzxPW73o590ntEAqcQUHrzuRJA9dgJW8cSoRM4wlbXgErsNDG0CVTlAkimUZLh1aJY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNX1JPH4HrsPEruWlLCN+xLs4kuxchO3jv6p7nZIdJNamWsF+w
	ScU/+Pm6AJmMvCp3c10JCBh3DztjKY3ovE9JSlk+wSBvckAz+uZAyzbV7uSkmYoq+2I=
X-Gm-Gg: Acq92OFwDftPbywbLc423Y9zGFz/d0wj+M/4neeWjx2nW1U6NouF6oDT+1Mmjuhqbg7
	BNWhufc1OW4ngapOY6HUVsDa0WdKcDxHRuNLwfJlnmm+WGr4WRCr/S8h8xh5Sn3CevjKM6DYBYq
	zq+rfy3gOgtFnwyV7K2i29mSfg2lgK+3pcavDAaTaxQ9b03pLl85zjiVFbL+PGcseuy6kIgonK6
	I116gvNFGK6sRUEiO3mAomg0x1N7klMRz7C3y2k/8It+BnFDubkaFTZ4hzWiQyLK96V9jZM2r0V
	FJVyybFdSpx8v00hvxSFrJHz7M+4GNa8ro5q8Hu4xXnGruZSHcCerAwhZppPgux/EToHrDluruV
	pBVfwbRDKcvH+kEgvEA1DpkxNIsQ29Rkl5f9LWBrFbD1AATiRCKpXSfwR6n38dlQrIsEM5cmWwv
	8rTn3P9rP9kSGQQS95Qcghy40B3Q/Q3uG4wnf5DMM4GaxedSWoKhu5faMNsSI=
X-Received: by 2002:a17:903:1b28:b0:2bc:d026:eeff with SMTP id d9443c01a7336-2bd27188006mr39565445ad.8.1778677856477;
        Wed, 13 May 2026 06:10:56 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.10.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:10:56 -0700 (PDT)
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
Subject: [PATCH v2 37/69] mm/sparse-vmemmap: Factor out shared vmemmap page allocation
Date: Wed, 13 May 2026 21:05:05 +0800
Message-ID: <20260513130542.35604-38-songmuchun@bytedance.com>
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

HugeTLB and sparse-vmemmap each have their own helper to allocate the
shared tail page used by vmemmap optimization.

Factor that logic into a common vmemmap_shared_tail_page() helper in
sparse-vmemmap.c.  It allocates the page through
vmemmap_alloc_block_zero(), initializes the tail struct pages, and uses
cmpxchg() to install the per-zone shared page.

This removes duplicate allocation logic while still handling both the
early boot and runtime paths through the same helper.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  1 +
 mm/hugetlb_vmemmap.c | 28 +-----------------
 mm/sparse-vmemmap.c  | 67 ++++++++++++++++++--------------------------
 3 files changed, 29 insertions(+), 67 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fef39be8acd2..5281f073230c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4866,6 +4866,7 @@ int vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
 			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
+struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 66362e553870..d24143dd6051 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -499,32 +499,6 @@ static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *
 	return vmemmap_should_optimize(h);
 }
 
-static struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
-{
-	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
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
@@ -541,7 +515,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	nid = folio_nid(folio);
-	vmemmap_tail = vmemmap_get_tail(h->order, folio_zone(folio));
+	vmemmap_tail = vmemmap_shared_tail_page(h->order, folio_zone(folio));
 	if (!vmemmap_tail)
 		return -ENOMEM;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index dde4486195ad..53a341fcde74 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -34,27 +34,13 @@
 
 #include "internal.h"
 
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
@@ -68,8 +54,7 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 		}
 		return NULL;
 	} else
-		return __earlyonly_bootmem_alloc(node, size, size,
-				__pa(MAX_DMA_ADDRESS));
+		return memmap_alloc(size, size, __pa(MAX_DMA_ADDRESS), node, false);
 }
 
 static void * __meminit altmap_alloc_block_buf(unsigned long size,
@@ -138,8 +123,6 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone);
-
 static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
 					      unsigned long ptpfn)
@@ -158,7 +141,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 
 			if (WARN_ON_ONCE(!zone))
 				return NULL;
-			page = vmemmap_get_tail(section_order(ms), zone);
+			page = vmemmap_shared_tail_page(section_order(ms), zone);
 			if (!page)
 				return NULL;
 			ptpfn = page_to_pfn(page);
@@ -190,7 +173,7 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 	return pte;
 }
 
-static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
+static void *vmemmap_alloc_block_zero(unsigned long size, int node)
 {
 	void *p = vmemmap_alloc_block(size, node);
 
@@ -329,32 +312,36 @@ void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
 	}
 }
 
-static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *zone)
+struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
-	struct page *p, *tail;
-	unsigned int idx;
-	int node = zone_to_nid(zone);
+	void *addr;
+	struct page *page;
+	const unsigned int idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
 
-	if (WARN_ON_ONCE(order < OPTIMIZABLE_FOLIO_MIN_ORDER))
-		return NULL;
-	if (WARN_ON_ONCE(order > MAX_FOLIO_ORDER))
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(zone->vmemmap_tails)))
 		return NULL;
 
-	idx = order - OPTIMIZABLE_FOLIO_MIN_ORDER;
-	tail = zone->vmemmap_tails[idx];
-	if (tail)
-		return tail;
+	page = READ_ONCE(zone->vmemmap_tails[idx]);
+	if (likely(page))
+		return page;
 
-	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-	if (!p)
+	addr = vmemmap_alloc_block_zero(PAGE_SIZE, zone_to_nid(zone));
+	if (!addr)
 		return NULL;
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
-		init_compound_tail(p + i, NULL, order, zone);
 
-	tail = virt_to_page(p);
-	zone->vmemmap_tails[idx] = tail;
+	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++)
+		init_compound_tail((struct page *)addr + i, NULL, order, zone);
+
+	page = virt_to_page(addr);
+	if (cmpxchg(&zone->vmemmap_tails[idx], NULL, page) != NULL) {
+		if (slab_is_available())
+			__free_page(page);
+		else
+			memblock_free(page_to_virt(page), PAGE_SIZE);
+		page = READ_ONCE(zone->vmemmap_tails[idx]);
+	}
 
-	return tail;
+	return page;
 }
 
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
-- 
2.54.0


