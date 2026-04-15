Return-Path: <linuxppc-dev+bounces-19780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDD1F43853
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 15:59:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwm6D5Hkgz2yvh;
	Thu, 16 Apr 2026 01:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776268740;
	cv=none; b=im+bVEcJ0slHNSwisPYdIeK+tE2KT8lwF3g5PIhzKX0Yc6Mg1WR8d3enXKDiubbFHnEcsOD3EryZLcXPqTt1yijVJDlrW8E/2wBEDReBxp5CIbFmD59/Ggq1RTJHV/nA4r2APnEIqBQM/ZxRXao3+ewIIvD5IT6FXkNSMi6DR07BciXR5KC7KdvPpPQiUt38PR9tDcJORLAO3JfvMRm/GjABNETRwEnfO12HXP0Hk/vcXwrZL0avwrGDiUYAVu7rf6uWShRKbHQcMnyj0vlgRzBR/ySIYZv+WcNVskFjdjohduA+8fse0kzgfSAnyiqEz8qSUh5QVkCKnFIWziELbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776268740; c=relaxed/relaxed;
	bh=O7rgm7cxZaadd6+va1WKqLPVDJoEG/g/j6EWoeXD+ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXJ2EzGN6uOR1Ax2JNtMsn8GkwvTj0KGpvNI4QkwFPJVLFm3qrU/ef8+Dow1duNEWW6mQfWBx4mpatwAJeHpEDl/DKj4rCXrQZuIaZwx53pH9DnKazv/5vI9fijq26JqsBfsfKzJpyS8GshhhxrRCdTBl8jSfzFxeq/ZFCf6usYPNyDncaZv2CpbfVmH8uft8HKZysBd4vNitebSTmfa91UiOKfe+5IKFvnw9F2IiGV2N6+jEwzaibztQjh4E4vuTyM0gcjZxijoC0dihoRwYU6H0uyFJYPYVBc5HkqXiiALeCDQZDCO+Ksu+8IEKGo7GKPLgONusBtQr98vy4ozmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H0i33bJZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H0i33bJZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwm6C4nq5z2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 01:58:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B94F404B4;
	Wed, 15 Apr 2026 15:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6368DC19424;
	Wed, 15 Apr 2026 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268737;
	bh=y+oq4INIxgbLQllztrJYjafmJkeuG9Q8awCwafdTv18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0i33bJZOnaxzNBKISduWbARJbUIWH5tRHgMmNW9tGUDA65uuEWbQytdZpKAwleUm
	 2R/5Xj3BYQt06J9Pt8r1Umg7yauBzgLvmDnjAGySIE0ayUcHQHxeky8KavBuS9QUcs
	 ZF0KFAz/6OUD0nQ+T+f1dJDvWHdhhTq8+PDYVBnlLr4nuTkaADeTEMzJXYlVO7s3AX
	 o6fAv2+7lLuamfYG62wd2tnlRZNPn97bj0RSkuegYp/wVfhHKD0B1KQpV14gm4I9da
	 BQ9hZk46xrvcn+0wl4O3LCZCwKYjlZ/63x5kdPTeA9qbpk182SsVzVmouMLLhLdgnI
	 itjpqaY6gD1Cg==
Date: Wed, 15 Apr 2026 18:58:47 +0300
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
Subject: Re: [PATCH v2 3/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
Message-ID: <ad-1t9sMWBqmgJ3g@kernel.org>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-4-songmuchun@bytedance.com>
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
In-Reply-To: <20260415111412.1003526-4-songmuchun@bytedance.com>

On Wed, Apr 15, 2026 at 07:14:09PM +0800, Muchun Song wrote:
> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
> counter in /proc/vmstat is incorrect. The current code always accounts
> for the full, non-optimized vmemmap size, but vmemmap optimization
> reduces the actual number of vmemmap pages by reusing tail pages. This
> causes the system to overcount vmemmap usage, leading to inaccurate
> page statistics in /proc/vmstat.
> 
> Fix this by introducing section_vmemmap_pages(), which returns the exact
> vmemmap page count for a given pfn range based on whether optimization
> is in effect.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse-vmemmap.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 40290fbc1db4..05e3e2b94e32 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -652,6 +652,29 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  	}
>  }
>  
> +static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
> +					   struct vmem_altmap *altmap,
> +					   struct dev_pagemap *pgmap)
> +{
> +	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
> +	unsigned long pages_per_compound = 1L << order;
> +
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound,
> +							PAGES_PER_SECTION)));
> +	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
> +
> +	if (!vmemmap_can_optimize(altmap, pgmap))
> +		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
> +
> +	if (order < PFN_SECTION_SHIFT)
> +		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
> +
> +	if (IS_ALIGNED(pfn, pages_per_compound))
> +		return VMEMMAP_RESERVE_NR;
> +
> +	return 0;
> +}
> +
>  static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap)
> @@ -659,7 +682,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
>  						      pgmap);
>  
> -	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> +	memmap_pages_add(section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
>  
>  	return page;
>  }
> @@ -670,7 +693,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>  	unsigned long start = (unsigned long) pfn_to_page(pfn);
>  	unsigned long end = start + nr_pages * sizeof(struct page);
>  
> -	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
> +	memmap_pages_add(-section_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
>  	vmemmap_free(start, end, altmap);
>  }
>  
> @@ -679,9 +702,10 @@ static void free_map_bootmem(struct page *memmap, struct vmem_altmap *altmap,
>  {
>  	unsigned long start = (unsigned long)memmap;
>  	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
> +	unsigned long pfn = page_to_pfn(memmap);
>  
> -	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
> -						  PAGE_SIZE)));
> +	memmap_boot_pages_add(-section_vmemmap_pages(pfn, PAGES_PER_SECTION,
> +						     altmap, pgmap));
>  	vmemmap_free(start, end, NULL);
>  }
>  
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

