Return-Path: <linuxppc-dev+bounces-21906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC353CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 14:46:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVDDh3KXMz2xLm;
	Wed, 03 Jun 2026 00:46:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780411604;
	cv=none; b=XhhiamdmGtn5U0L+H1OyxjgZOQQFIF5Oa+LSqTBYEmKJTy4T1EaQMnwO9dLvWX4XJbGJD9x2hHEbkKyPcoCEzQyboOh0r28GfYeF/hdjtKJdHNMwYbzkK2q/QXirAeFSQeqg+xEZGuBHE8DfEBMPjrRixvqAGlOJrfSymzVt40ltIOjgSOvareDM61gLHosEEaeC6Njz4yY57hmbzfxNMLzIIYOwvGiiogmLmHsIKrhWm2WlQX1zwMWBl2o2xSmDT9+9vk9DAWd18jNowLLFUmWlSyac1fgF2tPnTD3m7it7BPiNUxP3MWtlyW0u+LsGYyE33ehlQquZQsHgDwFm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780411604; c=relaxed/relaxed;
	bh=4NFd70hWGL8P5zEehk7GPp+B6cZq/FHBhT/mSt5ArDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRbA1/zoYbHk5LWzyuM203xzWVRuzBPKRURiACOCzQ0Ui1lrjRWph6lrT4lvewd0LBZtN8SfY4PQbB97zyNE8BOboeEdALgD8TFUPgSfOHgmICoXIPL4R3+lZrJegeScefhVEsqhQ4eHtxevRvhYMMZq+tmmt4aXjG1zq1RTnwp/w48X4fA0pEQADMsdVd7+L9CPcub2Dfono8+RO7q8SED+WIpx26ZbCN7FtMeceQ5jERncouhfDwwrdzIWSuDOTD/3ElK+7YDplh7wo0HZhnPzB+7e4KHGXn1O1idXQGFklYeuvQjTXs7qAEf6wRuixHzrm+w3ei+Qygzzl9AGlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM1g+JEX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM1g+JEX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVDDg2grNz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 00:46:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B039E6008A;
	Tue,  2 Jun 2026 14:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3811F00893;
	Tue,  2 Jun 2026 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411600;
	bh=4NFd70hWGL8P5zEehk7GPp+B6cZq/FHBhT/mSt5ArDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mM1g+JEXbWh/t59o/u4O+aWUWSA2HDFoJg1p2byPHhxS/579iO/AQguWyMy9rgWw3
	 GAbrtIjzEw56ZYFRk6rXc9IVIK+2G1UtX8+ICCujPIHbKOcGccNYDwd8bDct6tHwyQ
	 RFFWwOGRn8YkjljKH2HbwXvhLhQuK7ngENeBSos+e/F0MGOtueJji71Zu1YMS71HiV
	 NKFndrSaeiL9msFB56weG0VNs/tHWybudHZut6ZOOxGrILBaHsSjhKZq/MZzDJTKYT
	 cRnXo5pZwp5JXjwrlNFfBSbLduf+hrV4qETakfA6m00qZFNRgpvdtKCQnTLjUPQiGS
	 OA+BymabXUfRA==
Date: Tue, 2 Jun 2026 17:46:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 19/19] mm/mm_init: Fold __init_page_from_nid() into
 __init_deferred_page()
Message-ID: <ah7sx7eh1JQctWYO@kernel.org>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-20-songmuchun@bytedance.com>
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
In-Reply-To: <20260602101039.1867613-20-songmuchun@bytedance.com>

On Tue, Jun 02, 2026 at 06:10:39PM +0800, Muchun Song wrote:
> __init_page_from_nid() no longer has external users and is only used
> locally in mm/mm_init.c under CONFIG_DEFERRED_STRUCT_PAGE_INIT.
> 
> Fold it into its sole caller __init_deferred_page() and remove the
> separate helper declaration.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2->v3:
> - fold __init_page_from_nid() into __init_deferred_page() since it
>   only has a single caller (suggested by Mike Rapoport)
> ---
>  mm/internal.h |  1 -
>  mm/mm_init.c  | 44 ++++++++++++++++++--------------------------
>  2 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 8497673d0ac3..b33fc87e4555 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1760,7 +1760,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
>  
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  				unsigned long zone, int nid);
> -void __meminit __init_page_from_nid(unsigned long pfn, int nid);
>  
>  /* shrinker related functions */
>  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 41b83dd18c01..f1bbf3b9a321 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -688,31 +688,6 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
>  }
>  #endif
>  
> -/*
> - * Initialize a reserved page unconditionally, finding its zone first.
> - */
> -void __meminit __init_page_from_nid(unsigned long pfn, int nid)
> -{
> -	pg_data_t *pgdat;
> -	int zid;
> -
> -	pgdat = NODE_DATA(nid);
> -
> -	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> -		struct zone *zone = &pgdat->node_zones[zid];
> -
> -		if (zone_spans_pfn(zone, pfn))
> -			break;
> -	}
> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> -
> -	if (pageblock_aligned(pfn)) {
> -		enum migratetype mt =
> -			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
> -		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
> -	}
> -}
> -
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
>  {
> @@ -771,10 +746,27 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  
>  static void __meminit __init_deferred_page(unsigned long pfn, int nid)
>  {
> +	pg_data_t *pgdat;
> +	int zid;
> +
>  	if (early_page_initialised(pfn, nid))
>  		return;
>  
> -	__init_page_from_nid(pfn, nid);
> +	pgdat = NODE_DATA(nid);

Nit: we can initialize pgdat at declaration line, other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


> +
> +	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> +		struct zone *zone = &pgdat->node_zones[zid];
> +
> +		if (zone_spans_pfn(zone, pfn))
> +			break;
> +	}
> +	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> +
> +	if (pageblock_aligned(pfn)) {
> +		enum migratetype mt =
> +			kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
> +		init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
> +	}
>  }
>  #else
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
> -- 
> 2.54.0
> 
> 

-- 
Sincerely yours,
Mike.

