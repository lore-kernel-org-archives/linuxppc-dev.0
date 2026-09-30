Return-Path: <linuxppc-dev+bounces-28614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A607FCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 19:01:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw4C11PKnz2y24;
	Thu, 01 Oct 2026 05:01:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790794877;
	cv=none; b=W1osdTrccKP1NiQe3YdeZvzfuN5zYCpopHkMnqoZdgwRsxdDHNok8o/l9Css2mcasNdGoCtyq6NgNtQKQiiDFJAKGdZiRlhjPiNPo91FWatvTAxuo6vyQo+/TFdLsP1dlCYw7Z4S7AnCY4lGoTYTuXIzLyVwVbZ0FVMek6C49dnUONGUYPK4ZPPp5YJzdE6ogDuSs9ReyOueXdVFfrRm43+lfDY7f9iGMY7D97X7IKoewz1czC7RQXGWem7XzqE6rzG9+PZCU6caQW1ak945MLnoLrA53Ei1mak32noMji1SnSjdSptX5hmei3jcoO5h/0Z2R5ndyCvHk5gB+JbvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790794877; c=relaxed/relaxed;
	bh=XZ9p+0TXsTapVE0fUDcxcrxFDfTJp6cr+bt+UngMYk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DoXV9mQam226bvGQ6s4pR3O9vwSGEyPXxGUD+t93kYmWRJ+h5DGcc/9jakpWwHW/reje3fg0dwGoCgqi8bGFyLFdL9pRE5w0xymfYhiXqh4nNRuixLi+zkkhlnl9GXbx9LMeDCpTo/35+b7BD8JdiptbBB/9C+9APFOAo1/wMzd23a3TLX7H/e/MHYSxh++14psBA4iy9JUVoEZUNacXsVyVw3r6GHvVwljnyEC/k9LcEabl3+n9bN4oPrCPz07HQWE7dtR2qP6nM+zbd4Uhpape1y55wZxaim7dOXD4D4h9xutYpJ7iJw9rHUW7b/AJiP6aX+LpnE3cqMX58o4WFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=AfOugEP9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=AfOugEP9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw4Bz0S6vz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 05:01:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16668402BF;
	Wed, 30 Sep 2026 19:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E41F008A1;
	Wed, 30 Sep 2026 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790794872;
	bh=XZ9p+0TXsTapVE0fUDcxcrxFDfTJp6cr+bt+UngMYk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AfOugEP91NYVCmPmVOD6zXRVsG4tpdYvKHH57PQ0NhP32hoFVSp1mwVpKuJGcbMxk
	 IVSyP/V5SJfJtM+kNKQQES/oP7r4sOtjDeBVT04Y6h8Pa9lfdAvwu2qn4YVNUMYTjK
	 xoz1+LkQVNjPzQr88ZznUqCs7RO5t9ViwPP+3GVQ=
Date: Wed, 30 Sep 2026 12:01:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Randy
 Dunlap <rdunlap@infradead.org>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v6 00/12] mm: Switch device DAX to section-based vmemmap
 optimization
Message-Id: <20260930120110.3ace5f23b7530e179272fac4@linux-foundation.org>
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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

On Wed, 30 Sep 2026 22:06:15 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This version is based on mm-new commit a878c908dc92.
> 
> This series is split out from the earlier, larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
> vmemmap optimization across HugeTLB and device DAX, this subset addresses
> a single, self-contained step: switching device DAX to the section-based
> sparse-vmemmap optimization infrastructure introduced for HugeTLB.
> 
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
> 

Thanks.  I updated mm-unstable to this version.

> 
> v6:
> - Use try_get_page() to prevent the shared device DAX tail-page
>   reference count from overflowing (suggested by Andrew Morton,
>   reported by Sashiko)
> - Move constant declarations to the top of their functions and fold
>   the shared tail-page array lookup into vmemmap_tails() (suggested by
>   David Hildenbrand)
> - Clarify the DAX population flag description and why optimized tail
>   pages must not be poisoned (suggested by David Hildenbrand)
> - Collect Acked-by tags from David Hildenbrand
> - Rebase onto mm/mm-new


Here's how v6 altered mm.git:


 arch/powerpc/mm/book3s64/radix_pgtable.c |    8 +++--
 mm/sparse-vmemmap.c                      |   32 ++++++++++++---------
 2 files changed, 25 insertions(+), 15 deletions(-)

--- a/arch/powerpc/mm/book3s64/radix_pgtable.c~b
+++ a/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1042,13 +1042,17 @@ static pte_t * __meminit radix__vmemmap_
 			/*
 			 * When a PTE/PMD entry is freed from the init_mm
 			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
+			 * above. Thus this try_get_page() is paired with the
 			 * put_page_testzero() on the freeing path.
 			 * This can only called by certain ZONE_DEVICE path,
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
+			 *
+			 * Use try_get_page() to prevent the shared page refcount
+			 * from overflowing.
 			 */
-			get_page(reuse);
+			if (!try_get_page(reuse))
+				return NULL;
 			p = page_to_virt(reuse);
 			pr_debug("Tail page reuse vmemmap mapping\n");
 		}
--- a/mm/sparse-vmemmap.c~b
+++ a/mm/sparse-vmemmap.c
@@ -170,10 +170,14 @@ static void * __meminit vmemmap_alloc_bl
 #ifdef CONFIG_VMEMMAP_OPTIMIZATION
 #define VMEMMAP_OPTIMIZATION_NR_ORDERS	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
 
-static __ref struct page **vmemmap_tails_alloc(struct zone *zone)
+static __ref struct page **vmemmap_tails(struct zone *zone)
 {
-	struct page **pages;
-	const size_t size = array_size(VMEMMAP_OPTIMIZATION_NR_ORDERS, sizeof(*pages));
+	const size_t size = array_size(VMEMMAP_OPTIMIZATION_NR_ORDERS,
+				       sizeof(*zone->vmemmap_tails));
+	struct page **pages = READ_ONCE(zone->vmemmap_tails);
+
+	if (pages)
+		return pages;
 
 	pages = slab_is_available() ? kzalloc_objs(*pages, VMEMMAP_OPTIMIZATION_NR_ORDERS) :
 		memblock_alloc(size, __alignof__(*pages));
@@ -193,19 +197,19 @@ static __ref struct page **vmemmap_tails
 
 struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zone)
 {
-	void *addr;
-	struct page *page, **pages;
 	const unsigned int idx = order - VMEMMAP_OPTIMIZATION_MIN_ORDER;
+	struct page *page, **pages;
+	void *addr;
 
 	if (WARN_ON_ONCE(idx >= VMEMMAP_OPTIMIZATION_NR_ORDERS))
 		return NULL;
 
-	pages = READ_ONCE(zone->vmemmap_tails) ? : vmemmap_tails_alloc(zone);
+	pages = vmemmap_tails(zone);
 	if (!pages)
 		return NULL;
 
 	page = READ_ONCE(pages[idx]);
-	if (likely(page))
+	if (page)
 		return page;
 
 	addr = vmemmap_alloc_block(PAGE_SIZE, zone_to_nid(zone));
@@ -218,9 +222,9 @@ struct page __ref *vmemmap_shared_tail_p
 		atomic_set(&page->_mapcount, -1);
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
-		prep_compound_tail(page, NULL, order);
 		if (zone_is_zone_device(zone))
 			__SetPageReserved(page);
+		prep_compound_tail(page, NULL, order);
 	}
 
 	page = virt_to_page(addr);
@@ -528,12 +532,12 @@ static int __meminit vmemmap_populate_co
 						     unsigned long end, int node,
 						     struct dev_pagemap *pgmap)
 {
+	const unsigned long flags = VMEMMAP_POPULATE_DAX;
+	const unsigned int order = pfn_to_section_compound_order(start_pfn);
 	unsigned long size, addr;
 	pte_t *pte;
-	int rc;
-	unsigned long flags = VMEMMAP_POPULATE_DAX;
 	struct page *page;
-	unsigned int order = pfn_to_section_compound_order(start_pfn);
+	int rc;
 
 	page = vmemmap_shared_tail_page(order, device_zone(node));
 	if (!page)
@@ -891,8 +895,10 @@ int __meminit sparse_add_section(int nid
 
 	ms = __nr_to_section(section_nr);
 	/*
-	 * Poison uninitialized struct pages in order to catch invalid flags
-	 * combinations.
+	 * Poison uninitialized struct pages to catch invalid flag combinations.
+	 *
+	 * Tail struct pages in a vmemmap-optimized section are initialized and
+	 * shared during vmemmap population, so they must not be overwritten here.
 	 */
 	if (!section_vmemmap_optimizable(ms))
 		page_init_poison(memmap, sizeof(struct page) * nr_pages);
_


