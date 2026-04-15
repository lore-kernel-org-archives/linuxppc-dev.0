Return-Path: <linuxppc-dev+bounces-19781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD2DF43858
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 17:03:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwnXR2Nppz2yj1;
	Thu, 16 Apr 2026 03:03:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776272599;
	cv=none; b=AbuV5PUeSWydEfDI7xMr5JhH20S7v9PtHDeJu8jcuEd/y3PqGo3prgjVt3lso2PVbt50gpcux9uU4UytSLhOIG8nqpNLscbN2v6O5yPlk45c8ULahs/cc5cxkt+7pBIL7lfmWgalX10Lp9VgT1DHXmLIdm+rwQKNTvduIBeKPcEzlQjk1iNDYY0lJ3Pmu6xhfwR/RfdH8b7Lo+bSfPtt5c/jwmsJNeWcPax4VETlYVnJg8gYAgy2je6GILY1si1TCwJhtrGJYzAV865euxTxr7Pcn6b+Q8A6EwgFZqV9J+izuDUc9PIlihTcg7y7A7xOOyO2zirTBkhMhp1P9g6m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776272599; c=relaxed/relaxed;
	bh=BeK4x1dxgJguKDNqttCCDO06v9f5N1pztpozpFeGrH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLV1hP9B+fLNQn2f5/8PZgzq87651mGUSjRGQgF0gF+X1oOMHz9/7c6hP2fFM9CBWzXHg00LqhFMdQTSpCw8WviuB1S/CxTR8gBZDS7XFYKgVW3Zz9UWg3U4Fs5P0bPYo12Nb1HjlvyscsT65G6a9gUbq2o9U8Aheu5Bw2n/SAf8ZsZpx2qs8ZeERwnvSKFDIfuFCkbORhuVCkNu2tQVdY9gD23HnGdGFnABOBxG9ALFlgjumoWQjkh8MyPYbDNkTpaat+3pd+MM1zXa8CpPHw6ZNNml0SsbQV+S1FNBvzZjHMs+p8u8hZoEq7KZ0/upyk7U2TL1Jbg6NMmsf+LSDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L06wAtHS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L06wAtHS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwnXQ15T5z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 03:03:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 21284600AD;
	Wed, 15 Apr 2026 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83C4C19424;
	Wed, 15 Apr 2026 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776272594;
	bh=mTAGT4DOoB+Ql7bFiOXRTX+ODnCO2UkCTVqe5r/JaGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L06wAtHSsRMa8OvFoMaXwNH+1eYa2W/v97alLbMISAOhCVynQoCeVmWJ5ZTbJM2MU
	 QP7uytxhoWHErO3ob8f61vSccJltnPjAWtlZt4lsROLQKwiy6NhoQ5oVgulzUN2XE7
	 Uo3FI5DmnXnfiqIlq8mgXKJj1rnTTcT/r34LozkpmiTLGt7Qjx1MyAk6v8ee1n+Rpk
	 74o3/NiC27Orm8AO8F1joPLIciZG77gcb4LXn7GyeQNAW8nrMjUVV+grPXZ+Huzp/Z
	 RmjoqCkMBFE6XBtZkfqKwxw5eGbivNgTzlGo0+AdBKR6c4ga/EKSAl1llk+H4Pev8Q
	 9k3GwIuIRnuKA==
Date: Wed, 15 Apr 2026 20:03:06 +0300
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
Subject: Re: [PATCH v2 6/6] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
Message-ID: <ad_EygHWDi19SS9y@kernel.org>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-7-songmuchun@bytedance.com>
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
In-Reply-To: <20260415111412.1003526-7-songmuchun@bytedance.com>

Hi Muchun,

On Wed, Apr 15, 2026 at 07:14:12PM +0800, Muchun Song wrote:
> The memmap_init_zone_device() function only initializes the migratetype
> of the first pageblock of a compound page. If the compound page size
> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
> subsequent pageblocks in the compound page remain uninitialized.
> 
> Move the migratetype initialization out of __init_zone_device_page()
> and into a separate pageblock_migratetype_init_range() function. This
> iterates over the entire PFN range of the memory, ensuring that all
> pageblocks are correctly initialized.
> 
> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/mm_init.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..30528c4206c1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -674,6 +674,19 @@ static inline void fixup_hashdist(void)
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
> +		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
> +			cond_resched();
> +	}
> +}
> +
>  /*
>   * Initialize a reserved page unconditionally, finding its zone first.
>   */
> @@ -1011,21 +1024,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
> @@ -1122,6 +1120,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  
>  		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>  
> +		cond_resched();
> +

I don't think we want cond_resched() for every page here too, even it's a
compound page :)

Otherwise

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  		if (pfns_per_compound == 1)
>  			continue;
>  
> @@ -1129,6 +1129,18 @@ void __ref memmap_init_zone_device(struct zone *zone,
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

