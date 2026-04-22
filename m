Return-Path: <linuxppc-dev+bounces-19978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC2BFA1FE3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 19:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g18481hxYz2ytT;
	Thu, 23 Apr 2026 05:12:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776885144;
	cv=none; b=eJfAeeqnquHMGCeWGht4dfWAEyBpNfqAe6oYuzI/pB41s85vIzdN+djnapCo1Cp28q9173N3j7sEZC/VrNVkEW+4tXTVgd9sMXY8QpSX5taBC3vXWwjbagCTcHU7YNVDxjlSvdUNQuhUGXAAFl3hY95zJaSjJH4eTDNHOWwbabYfOzI70mLN1f3qBq+N2tnZzLfH7EX1QHXzLkfguLjZMkccUfjPpHcSUqGb3UkdT22A2R24zUiG3kVqQHdfjr+742lJV1d440IscnpttxI0HiAJ8xQDJDNosmX6j7BVnqFxc6uxBrLuUEyWuPJzOtMMiG8vE+JVI3CWrbUGbhuFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776885144; c=relaxed/relaxed;
	bh=mGVKYKKpt3fqUJPzWGuT7XPO04NRkoaxLUpzTEEjFIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3T7BpLEpWxBXows+rj3bea14M/gTC7zKsV4qjeyejQV2JKBAXcphglMKz0aL0TVK7ylqLahcLJffLQnXmzMUeycO0CM5WGOihEddUxYeF+P+zbflAAyP5iCqCCIbX5MQNCivuciFwCYUcu2CcxLSshsqZeO2yoGCFD2/85V+LuxBCWwl04T1zAsab6ZoRWBuN+0V3F8oIbmpXbMX37q9h7T1eMb3oARjVaawesAvpTLtvQXMPQw+YFC0eV3xq5ndIYjBYPUt72jmTm9OaFL9EPaehX1M3XvNPW8pvES3L/h+WyJBtqSt3rkSDgpBGIjYRSnJRP8ZrZp1fFR2PIKWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I/r2+Oco; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I/r2+Oco;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g18472P9Tz2yrl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 05:12:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2559C61863;
	Wed, 22 Apr 2026 19:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41490C19425;
	Wed, 22 Apr 2026 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776885140;
	bh=soo6QUGKM77sfvtH8onoPyYjoKLrihsrqjzIxYqu+FA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I/r2+Ocol0HVb6piUtmzScYnaDu6PTEfqHd1Ph8H0LIzUEXxcGrm3jONjMYaoW+x7
	 VlldFwjZWbZwe+dwXs2BmDRzMib1sV0yrkmpbtg6h7xK1U5TQfkY8F/OwcSiO2Hdcz
	 gCYCcs0m+kIBWh70H5m/ELxl8dpZxrIV/PwPXtxKbGhtCiVtqV5cTVj8nueQTprsLM
	 7+CazLdNqTpMdp4HI+VArEHAncvIsQ9OctzbWOxDFRGgQspQCtklZw8XX5vI+rCwhH
	 9wH3U7OK/0H5ADnjadagi2LpyhIaIM88uWjtb98kVuRwiu9Ci0DGr62tqCPhiDHbpj
	 CcK6cXwu0e87g==
Message-ID: <229d2191-afd3-4206-8ccb-002f93d2c4c0@kernel.org>
Date: Wed, 22 Apr 2026 21:12:13 +0200
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
Subject: Re: [PATCH v4 5/5] mm/mm_init: Fix uninitialized struct pages for
 ZONE_DEVICE
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
 <20260422081420.4009847-6-songmuchun@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260422081420.4009847-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 10:14, Muchun Song wrote:
> If DAX memory is hotplugged into an unoccupied subsection of an early
> section, section_activate() reuses the unoptimized boot memmap.
> However, compound_nr_pages() still assumes that vmemmap optimization is
> in effect and initializes only the reduced number of struct pages. As a
> result, the remaining tail struct pages are left uninitialized, which
> can later lead to unexpected behavior or crashes.
> 
> Fix this by treating early sections as unoptimized when calculating how
> many struct pages to initialize.
> 
> Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/mm_init.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 9d0fe79a94de..3d5af40d0943 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1056,10 +1056,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>   * of how the sparse_vmemmap internals handle compound pages in the lack
>   * of an altmap. See vmemmap_populate_compound_pages().
>   */
> -static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
> +static inline unsigned long compound_nr_pages(unsigned long pfn,
> +					      struct vmem_altmap *altmap,
>  					      struct dev_pagemap *pgmap)
>  {
> -	if (!vmemmap_can_optimize(altmap, pgmap))
> +	/*
> +	 * If DAX memory is hot-plugged into an unoccupied subsection
> +	 * of an early section, the unoptimized boot memmap is reused.
> +	 * See section_activate().
> +	 */
> +	if (early_section(__pfn_to_section(pfn)) ||
> +	    !vmemmap_can_optimize(altmap, pgmap))
>  		return pgmap_vmemmap_nr(pgmap);
>  
>  	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
> @@ -1129,7 +1136,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  			continue;
>  
>  		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> -				     compound_nr_pages(altmap, pgmap));
> +				     compound_nr_pages(pfn, altmap, pgmap));
>  	}
>  
>  	/*

Nasty, but yes, we cannot really optimize in that case.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

