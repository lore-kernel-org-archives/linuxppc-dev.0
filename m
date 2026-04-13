Return-Path: <linuxppc-dev+bounces-19672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF8EBFD25
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvMdP3Pccz2yrZ;
	Mon, 13 Apr 2026 19:32:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776072761;
	cv=none; b=LqaB8ierdtlDNnQqD6ApmQT5DfRTqPh6L2lL05jRfrq0kHffdCMqEdYZU5otSLtRXS7sre699yW5mUef95rvVpjRnow0WCcXwpnRextbxtUfdaFDnqZj59aA6NRiLNEEBhwUX3efcba1gufvdgAIwes0EGPbGzWrw5vnTuxtXrZVxBSj0nOosSmMGiDY4Wa731DemLkuLiXG1tiEB50T83FlxN2+R1/Yf1TkBzg0AddwQ/YplkK5tt79RDJlCbiQ2Q0mKloCRclFJAtrw2SI18/icqj/cqVf8xGUhekUKzwVM4U/621BH3YVp+2/vaXVAdHQH0zcYIIBs8OazaT3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776072761; c=relaxed/relaxed;
	bh=/KMOAZ7SVr6g5vUKFGrCwww5uVj/ZVa5plkq1tQ6p9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S54V57i8oy8F2JbW4mHHqN0UI3yHx3AwkJhBUrg471ZZOF5xAD1pQ2W64NeyN/bsVaaOGavNZuwMvmAwRtj/Aug/LWUlVhCJG6g7VcNCRUrdbDu6I0Q17saR3WYSOzmPEsst4t7K9yRiHQYJ4i7sviNXg4LsOF8M+hFMcUv9JhxqB0qG6mazKs4TpIQW5TzgkJOsslQs6hF4VElw8phLHBRiqpeDA4I3wq+dycifaARm5U3qId5BRNnPdqIJfrq9EX6ofDC4MBURG9ksaVNMHzowiXw/vUvjtK3gUYsnYaLAyOjLxnxsIDpF4LDz3HRWJTs3mVQUBa7210haoGNM/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tNn9OWyN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tNn9OWyN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvMdN4ZLCz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:32:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A71060172;
	Mon, 13 Apr 2026 09:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6FAC116C6;
	Mon, 13 Apr 2026 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776072758;
	bh=JRZWemltksdWoEBhaBDF2gLrvxOl6lymdz6gK0hrGbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNn9OWyN2iOjVuYi6CPt63fahnmPUSEpc9OBeODdPvpBmVWVqEJ9VkP/s3F3/LkWc
	 M3D6XOlui3DwCNa/oRFVZYcFelpdBxw1uzz2hyPoj9IeevEzAwY4gfIg9vLVwkRUjN
	 1o9lyi5gDuYluIyQ7YS3c+gqJMTJElNAfV2DFF6S5DMap2bmm50mlJdjs1nzl61nrp
	 GCd9cHivlBrgRl4bJ/YXyhK06h7Zhzwg0lrqFtnA8fQqNdMFgrcUPHOa8To2zbUdwo
	 HylUc08gkSGh8JQFkgI56dvl+nF8OSz4o1mp/5aTj4GMZWDP20ZX+UrfAB1EBa7Caq
	 U0B3CRA5lKHxQ==
Date: Mon, 13 Apr 2026 12:32:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock
 migratetype for ZONE_DEVICE compound pages
Message-ID: <ady4LBppz-na5lM5@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-7-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405125240.2558577-7-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:51:57PM +0800, Muchun Song wrote:
> Previously, memmap_init_zone_device() only initialized the migratetype
> of the first pageblock of a compound page. If the compound page size
> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
> subsequent pageblocks in the compound page would remain uninitialized.
> 
> This patch moves the migratetype initialization out of
> __init_zone_device_page() and into a separate function
> pageblock_migratetype_init_range(). This function iterates over the
> entire PFN range of the memory, ensuring that all pageblocks are correctly
> initialized.
> 
> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/mm_init.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 9a44e8458fed..4936ca78966c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -674,6 +674,18 @@ static inline void fixup_hashdist(void)
>  static inline void fixup_hashdist(void) {}
>  #endif /* CONFIG_NUMA */
>  
> +static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
> +						       unsigned long nr_pages,
> +						       int migratetype)
> +{
> +	unsigned long end = pfn + nr_pages;
> +
> +	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
> +		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
> +		cond_resched();

Do we need to call cond_resched() every iteration here?

> +	}
> +}
> +
>  /*
>   * Initialize a reserved page unconditionally, finding its zone first.
>   */
> @@ -1011,21 +1023,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	page_folio(page)->pgmap = pgmap;
>  	page->zone_device_data = NULL;
>  
> -	/*
> -	 * Mark the block movable so that blocks are reserved for
> -	 * movable at startup. This will force kernel allocations
> -	 * to reserve their blocks rather than leaking throughout
> -	 * the address space during boot when many long-lived
> -	 * kernel allocations are made.
> -	 *
> -	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> -	 * because this is done early in section_activate()
> -	 */
> -	if (pageblock_aligned(pfn)) {
> -		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
> -		cond_resched();
> -	}
> -
>  	/*
>  	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
>  	 * directly to the driver page allocator which will set the page count
> @@ -1122,6 +1119,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  
>  		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>  
> +		cond_resched();

Originally we called cond_resched() once per pageblock, now it's called
once per page plus for every pageblock in the tight loop that sets the
migrate type. Isn't it too much?

> +
>  		if (pfns_per_compound == 1)
>  			continue;
>  
> @@ -1129,6 +1128,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  				     compound_nr_pages(altmap, pgmap));
>  	}
>  
> +	/*
> +	 * Mark the block movable so that blocks are reserved for
> +	 * movable at startup. This will force kernel allocations
> +	 * to reserve their blocks rather than leaking throughout
> +	 * the address space during boot when many long-lived
> +	 * kernel allocations are made.
> +	 *
> +	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> +	 * because this is done early in section_activate()
> +	 */
> +	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
> +
>  	pr_debug("%s initialised %lu pages in %ums\n", __func__,
>  		nr_pages, jiffies_to_msecs(jiffies - start));
>  }
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

