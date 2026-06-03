Return-Path: <linuxppc-dev+bounces-21972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52000CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 12:03:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVmZ7620Yz2yZZ;
	Wed, 03 Jun 2026 22:03:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780488223;
	cv=none; b=fm4KP65F6hYRiSWOpxLOndfAyZMSD74zXlzPUXnWMpIkeH3w167WfkWZ2cszu6GX9q9UsNXdiFxX6q4OH9zK6P4VhP6iDuaTHBUU34izkuaaMyAX2ukady4HnuMEVMc0/zuCvTEp6+qbRjYZn18H+EuQuJIDJlFys6h2C+1VtQW0KqgfA1ATvV5cmZIGmd4BGv0B+/lQ7Iad6Sjlz3BmaKw67u+UlISCpdJcz9G1rIi1kXwfNy2eCdOrooIKiS/6WXKkjY2NtvI20xB1AeUcOFvIc8544V8LMHmY4o4tTJjij79C8gMkkqFKVwtTe3A59lxc2r0Mm81HsdroGFRblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780488223; c=relaxed/relaxed;
	bh=SCpohelG7l6LyhUQ07RSrgnLyItsWmnms5P59P39ZIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEZe8QV6SMsLqj+mQL0hLkqmFk2vBR3EXgGq5iaVR+MJwE8nLFDB1rkql0d2oaA66wftD/SWpE4yc6a/v8NI6Eqt15gHGw44GwwNSETxlhqKVHfjl5hMVHQO+v6/rZZ2itpZvibH4b9eW1agb3BJIoBYpvKKp/AHgz8n+EiUQy9yO+HepWMeQzfv8ih2E4ZTYRaaCs5EoBt/2nW850jg8pnVUIbX/sww67/T+tnlVgHeCbFmwihyH8ot/9sczxj/FUR+p1v+WIEnYb4Muw4uo3kXjLpENvn4H5cbWCoE3l0eC2OlVKZG7MED+7Y3FIZf6Shagr/UHlvvEOskwZvurQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HUtNH7w0; dkim-atps=neutral; spf=pass (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HUtNH7w0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVmZ314cRz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 22:03:39 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780488188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCpohelG7l6LyhUQ07RSrgnLyItsWmnms5P59P39ZIU=;
	b=HUtNH7w0NlcTlfK4uJ5OKX2uFNebPH93cM5pZOWhpnZySBJtVcuEW78fCaVP5wlFo2YTPS
	FzgVSj5+2TsKi/D7szWfqoeoAE83hINvRXcZTwLthMkqQE8GhtxUARv8KkMAgKoXnr9pQ/
	NOTwiKwWI8Yqcwb84dOy/Z2/iKlCkHI=
From: Usama Arif <usama.arif@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
Date: Wed,  3 Jun 2026 05:02:44 -0700
Message-ID: <20260603120246.1572177-1-usama.arif@linux.dev>
In-Reply-To: <20260602101039.1867613-16-songmuchun@bytedance.com>
References: 
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
X-Migadu-Flow: FLOW_OUT

On Tue,  2 Jun 2026 18:10:35 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> Bootmem HugeTLB pages currently defer HVO setup to
> hugetlb_vmemmap_init_late(), because the optimization needs zone
> information.
> 
> Now that zone initialization is available earlier, the bootmem HVO setup
> can be done directly from hugetlb_vmemmap_init_early(). This lets
> gigantic HugeTLB pages apply HVO as soon as they are allocated.
> 
> Bootmem gigantic pages that span multiple zones are now filtered out
> when they are allocated, so the remaining bootmem gigantic pages seen by
> later hugetlb initialization are already zone-valid. As a result,
> hugetlb_vmemmap_init_late() no longer needs to handle bootmem HVO setup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 67 +++++++++-----------------------------------
>  1 file changed, 13 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ea6af85bfec1..464578ee246e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -745,6 +745,8 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
>  	return true;
>  }
>  
> +static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
> +
>  /*
>   * Initialize memmap section for a gigantic page, HVO-style.
>   */
> @@ -752,6 +754,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
>  {
>  	unsigned long psize, paddr, section_size;
>  	unsigned long ns, i, pnum, pfn, nr_pages;
> +	unsigned long start, end;
>  	struct huge_bootmem_page *m = NULL;
>  	void *map;
>  
> @@ -761,6 +764,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
>  	section_size = (1UL << PA_SECTION_SHIFT);
>  
>  	list_for_each_entry(m, &huge_boot_pages[nid], list) {
> +		struct zone *zone;
> +
>  		if (!vmemmap_should_optimize_bootmem_page(m))
>  			continue;
>  
> @@ -769,6 +774,14 @@ void __init hugetlb_vmemmap_init_early(int nid)
>  		paddr = virt_to_phys(m);
>  		pfn = PHYS_PFN(paddr);
>  		map = pfn_to_page(pfn);
> +		start = (unsigned long)map;
> +		end = start + hugetlb_vmemmap_size(m->hstate);
> +		zone = pfn_to_zone(nid, pfn);
> +
> +		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
> +					 zone, HUGETLB_VMEMMAP_RESERVE_SIZE))
> +			panic("Failed to allocate memmap for HugeTLB page\n");

The replaced hugetlb_vmemmap_init_late() path used to fall back to
vmemmap_populate() if vmemmap_populate_hvo() returned an error and
just lost the HVO optimization for that page.

The new path panics on any non-zero return.  Is the panic intended,
given that vmemmap_populate_hvo() returns -ENOMEM on allocation
failure and HVO is normally treated as an optimization rather than a
hard requirement?

> +		memmap_boot_pages_add(DIV_ROUND_UP(HUGETLB_VMEMMAP_RESERVE_SIZE, PAGE_SIZE));
>  
>  		pnum = pfn_to_section_nr(pfn);
>  		ns = psize / section_size;
> @@ -800,60 +813,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
>  
>  void __init hugetlb_vmemmap_init_late(int nid)
>  {
> -	struct huge_bootmem_page *m, *tm;
> -	unsigned long phys, nr_pages, start, end;
> -	unsigned long pfn, nr_mmap;
> -	struct zone *zone = NULL;
> -	struct hstate *h;
> -	void *map;
> -
> -	if (!READ_ONCE(vmemmap_optimize_enabled))
> -		return;
> -
> -	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
> -		if (!(m->flags & HUGE_BOOTMEM_HVO))
> -			continue;
> -
> -		phys = virt_to_phys(m);
> -		h = m->hstate;
> -		pfn = PHYS_PFN(phys);
> -		nr_pages = pages_per_huge_page(h);
> -		map = pfn_to_page(pfn);
> -		start = (unsigned long)map;
> -		end = start + nr_pages * sizeof(struct page);
> -
> -		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
> -			/*
> -			 * Oops, the hugetlb page spans multiple zones.
> -			 * Remove it from the list, and populate it normally.
> -			 */
> -			list_del(&m->list);
> -
> -			vmemmap_populate(start, end, nid, NULL);
> -			nr_mmap = end - start;
> -			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
> -
> -			memblock_phys_free(phys, huge_page_size(h));
> -			continue;
> -		}
> -
> -		if (!zone || !zone_spans_pfn(zone, pfn))
> -			zone = pfn_to_zone(nid, pfn);
> -		if (WARN_ON_ONCE(!zone))
> -			continue;
> -
> -		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
> -					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
> -			/* Fallback if HVO population fails */
> -			vmemmap_populate(start, end, nid, NULL);
> -			nr_mmap = end - start;
> -		} else {
> -			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
> -			nr_mmap = HUGETLB_VMEMMAP_RESERVE_SIZE;
> -		}
> -
> -		memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
> -	}
>  }
>  #endif
>  
> -- 
> 2.54.0
> 
> 

