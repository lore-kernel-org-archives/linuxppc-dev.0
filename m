Return-Path: <linuxppc-dev+bounces-26714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D09C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 04:10:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf9Sy0CSfz2yFK;
	Tue, 08 Sep 2026 14:10:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::e7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788840609;
	cv=none; b=aM4S1p7hnAeF8iq2dYSqzOTagVnlIbfyLdevO96HLFPKi7do4eJLWqpCMCv4foDS2Nba56tqaLxmEa/vUOb0CmnUb4C9ZlfCFCW9djafu0xETvebUR3SCEOgaCOMKDa+QKLHdY0+BkmNxXHK/GOzDah1vweoLESWM4TRKeF2HwO/6eyE7WvzfQxArm7X25Ne0axk+7NlVliryX526FgOpTxo4oy7jMi7bIM+zRBrO/Mqvr3YpEQ1PRbntB6IbUtbzCierRMzFGeokluavzxLAPqh110uvOeN2UzqLkXKrA+LN8UwqddWOy+UWrhyif5E13LlPS3yuLxAU4DPErPt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788840609; c=relaxed/relaxed;
	bh=ETu/+IdC6wkVcR7kfefhUdeU0dpDBUqiUlZER/ibfSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRD6d6gJhrpbvJOhZI5Oe62UNJLImfsLFss77l6QkA2m+pAAr3h9t7/iqerL/t76b/S+0aIBrLFk/5VBvnluLe8evqYG7B1LzFm8/qpWQUD5wWD86a8FQP0wa3QnkTeoltZ7yVc2H6rhSroRT3JlRAca8cKKWZ7DA+PAZ2ADe3YfTU0mwNAsYi+ntCElKZlBqdHHLyEsE2hAsZMY4jxZHvPOmvDr/g80rFlYiaW5i9GQvOO0HnxdjVhMypPoeOmO3B1R9L6S41ZFd69Jv7hZ/i2Cx6d1Y3cDIOZewG86XdESMSUIf7UkSqtTDBuG2nPGxeG3BK9oUrJVuef4SRUq2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B6wMX3rO; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::e7; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B6wMX3rO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::e7; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-231.mta1.migadu.com [IPv6:2001:41d0:203:375::e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf9Sp2fm3z2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 14:09:58 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=x0VZgiJePeWqh4cLtuV0TthQ7an0Lkb4/kBk4eS0cSE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788840575; v=1; x=1789445375;
 b=B6wMX3rOxLJUReXa9Auyrgrk7+wZbrTI31hMBeZ64A7kLLekvpbjRg5ar5rESFwFZcx0S+fo
 +CV7YXgUzqAHJIJfX/g9zZbVTC6U/IE1Qkx8js0gkjce7/jSuffyvD5H5I2R/UIk7FRsGEvz1Pb
 FOmRXIDG4fZndVAfk7s1tRbk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id aa67825df359c637;
	Tue, 08 Sep 2026 04:09:34 +0000
X-Mizu-Trace-ID: aa67825df359c637
X-Migadu-Flow: FLOW_OUT
Message-ID: <3856ab3a-5bc6-4483-a116-601ae431b2c1@linux.dev>
Date: Tue, 8 Sep 2026 12:09:24 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] mm/sparse-vmemmap: switch device DAX to shared
 tail vmemmap pages
To: Muchun Song <songmuchun@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-7-songmuchun@bytedance.com>
Content-Language: en-US
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260908030335.96549-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/9/8 11:03, Muchun Song wrote:
> HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap pages.
> Device DAX has not been switched to that mechanism yet.
>
> Switch device DAX to vmemmap_shared_tail_page() as well. This aligns DAX
> with HugeTLB by using the common per-zone shared tail vmemmap page.
>
> The optimization is enabled only for DEV-DAX through pgmap->vmemmap_shift,
> which is assigned when a DEV-DAX device is initialized. Unlike FS-DAX,
> DEV-DAX does not modify tail struct pages, so sharing them is safe.
>
> Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
> initialize its entries with PG_reserved for device zones. Also skip
> poisoning vmemmap-optimizable sections while their struct pages may be
> shared.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Explain why sharing tail vmemmap pages is safe for DEV-DAX
>    (suggested by Qi Zheng)
> ---
>   include/linux/mmzone.h | 10 +++++++++
>   mm/memory_hotplug.c    |  5 +++--
>   mm/sparse-vmemmap.c    | 47 ++++++++++++++----------------------------
>   3 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d3778ba976a5..03ed9232f186 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1686,11 +1686,21 @@ static inline bool zone_is_zone_device(const struct zone *zone)
>   {
>   	return zone_idx(zone) == ZONE_DEVICE;
>   }
> +
> +static inline struct zone *device_zone(int nid)
> +{
> +	return &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
> +}
>   #else
>   static inline bool zone_is_zone_device(const struct zone *zone)
>   {
>   	return false;
>   }
> +
> +static inline struct zone *device_zone(int nid)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b428da66d279..0db0379826df 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -554,8 +554,9 @@ void remove_pfn_range_from_zone(struct zone *zone,
>   		/* Select all remaining pages up to the next section boundary */
>   		cur_nr_pages =
>   			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
> -		page_init_poison(pfn_to_page(pfn),
> -				 sizeof(struct page) * cur_nr_pages);
> +		if (!section_vmemmap_optimizable(__pfn_to_section(pfn)))
> +			page_init_poison(pfn_to_page(pfn),
> +					 sizeof(struct page) * cur_nr_pages);
>   	}
>   
>   	/*
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index aed1e7429daa..0201877a7f80 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -193,6 +193,8 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
>   		set_page_node(page, zone_to_nid(zone));
>   		set_page_zone(page, zone_idx(zone));
>   		prep_compound_tail(page, NULL, order);
> +		if (zone_is_zone_device(zone))
> +			__SetPageReserved(page);

Sashiko said: "
   Could setting PG_reserved here cause a use-after-free
   during device hot-remove?

   When a DEV-DAX device is removed and vmemmap_free is called,
   remove_pte_table calls free_vmemmap_pages. In free_vmemmap_pages,
   the PG_reserved flag redirects execution:

   arch/x86/mm/init_64.c:free_vmemmap_pages() {
       ...
       else if (PageReserved(page))
           free_reserved_pages(page, order);
   }

   Does this forcefully drop the refcount and free the shared
   page to the buddy allocator, leaving a dangling pointer in
   zone->vmemmap_tails[idx] that breaks other DAX devices
   sharing this page?
"

It is a false positive.

The struct page marked reserved here is an entry stored
inside the shared vmemmap backing page; after mapping, it
represents a Device DAX tail page. It is not the struct
page describing the backing page itself.

remove_pte_table() passes pte_page(*pte) to free_vmemmap_pages(),
which is the latter. The runtime-allocated backing page is
not reserved, so removal takes the __free_pages() path. Each
reused PTE takes a reference via get_page(), and removal
drops one such reference, while the allocation reference
retained by zone->vmemmap_tails[] remains. Therefore removing
one DAX device does not free the shared backing page or leave
a dangling pointer.

>   	}
>   
>   	page = virt_to_page(addr);
> @@ -490,23 +492,6 @@ static bool __meminit reuse_compound_section(unsigned long start_pfn,
>   	return !IS_ALIGNED(offset, nr_pages) && nr_pages > PAGES_PER_SUBSECTION;
>   }
>   
> -static pte_t * __meminit compound_section_tail_page(unsigned long addr)
> -{
> -	pte_t *pte;
> -
> -	addr -= PAGE_SIZE;
> -
> -	/*
> -	 * Assuming sections are populated sequentially, the previous section's
> -	 * page data can be reused.
> -	 */
> -	pte = pte_offset_kernel(pmd_off_k(addr), addr);
> -	if (!pte)
> -		return NULL;
> -
> -	return pte;
> -}
> -
>   static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>   						     unsigned long start,
>   						     unsigned long end, int node,
> @@ -516,21 +501,18 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>   	pte_t *pte;
>   	int rc;
>   	unsigned long flags = VMEMMAP_POPULATE_DAX;
> +	struct page *page;
> +	unsigned int order = pfn_to_section_order(start_pfn);
>   
> -	if (reuse_compound_section(start_pfn, pgmap)) {
> -		pte = compound_section_tail_page(start);
> -		if (!pte)
> -			return -ENOMEM;
> +	page = vmemmap_shared_tail_page(order, device_zone(node));
> +	if (!page)
> +		return -ENOMEM;
>   
> -		/*
> -		 * Reuse the page that was populated in the prior iteration
> -		 * with just tail struct pages.
> -		 */
> +	if (reuse_compound_section(start_pfn, pgmap))
>   		return vmemmap_populate_range(start, end, node, NULL,
> -					      pte_pfn(ptep_get(pte)), flags);
> -	}
> +					      page_to_pfn(page), flags);
>   
> -	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
> +	size = min(end - start, (1UL << order) * sizeof(struct page));
>   	for (addr = start; addr < end; addr += size) {
>   		unsigned long next, last = addr + size;
>   
> @@ -546,12 +528,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>   			return -ENOMEM;
>   
>   		/*
> -		 * Reuse the previous page for the rest of tail pages
> +		 * Reuse the shared page for the rest of tail pages
>   		 * See layout diagram in Documentation/mm/vmemmap_dedup.rst
>   		 */
>   		next += PAGE_SIZE;
>   		rc = vmemmap_populate_range(next, last, node, NULL,
> -					    pte_pfn(ptep_get(pte)), flags);
> +					    page_to_pfn(page), flags);

Another report is like:

"
   When this shared tail page is used to back the
   DEV-DAX tail pages, could concurrent initialization
   corrupt the compound_head pointer for the entire
   node?

   Looking at memmap_init_zone_device which calls
   memmap_init_compound, the head page template is copied
   unconditionally into the tail pages:

   mm/mm_init.c:memmap_init_compound() {
       for (pfn = head_pfn + 2; pfn < end_pfn; pfn++)
           zone_device_page_init_from_template(pfn_to_page(pfn), pfn, 
&template);
   }

   Since page_to_pfn(page) here points to a node-wide
   shared physical page, would this template copy overwrite
   the compound_head for all DEV-DAX tail pages on the node
   to point to the latest initialized PMD's head page?
"

This is also a false positive.

memmap_init_compound() does not initialize the full
compound range when the section uses vmemmap optimization.
compound_nr_pages() limits it to:

   2 * PAGE_SIZE / sizeof(struct page)

i.e. exactly the entries in the retained vmemmap page.
The shared mappings start at addr + PAGE_SIZE, so the
template-copy loop stops before reaching them.

Thanks
Muchun

>   		if (rc)
>   			return -ENOMEM;
>   	}
> @@ -883,13 +865,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>   	if (IS_ERR(memmap))
>   		return PTR_ERR(memmap);
>   
> +	ms = __nr_to_section(section_nr);
>   	/*
>   	 * Poison uninitialized struct pages in order to catch invalid flags
>   	 * combinations.
>   	 */
> -	page_init_poison(memmap, sizeof(struct page) * nr_pages);
> +	if (!section_vmemmap_optimizable(ms))
> +		page_init_poison(memmap, sizeof(struct page) * nr_pages);
>   
> -	ms = __nr_to_section(section_nr);
>   	__section_mark_present(ms, section_nr);
>   
>   	/* Align memmap to section boundary in the subsection case */


