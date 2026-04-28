Return-Path: <linuxppc-dev+bounces-20216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A072EFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:30:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4XCV2Tgsz2xld;
	Tue, 28 Apr 2026 17:30:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777361430;
	cv=none; b=VMLL5hArnLN1j3beh/D/a7HReoVpUBIms9GYCZzSvhey7AuNf4JVf6XIbspP+3xLaXMizHwHkSblmanMyuzW/7e3ykDLHr/tc0UoHY9gJGIiqmMUjxqGYzhrc6Fw5VrwFn6cnPd9qF20NXnbSWsMdo6RFLayBwrL8iT14zGXDtYgXsrZ+2DovNloYUUhI6gIKq2Vun89S01Fte8JRsmkAoC2LKzylybCS3zfmj2eGDRLV/mQe048P5ZRfLRNtWeiEYBKQ0DhrkKiLo6t1Zi/GIinp64vhMl7wdNOvsfJaJAOGro0wB8R8k5D0BdODGbAJbSr6gORc+jk3eKmR2Tf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777361430; c=relaxed/relaxed;
	bh=vB0MwZldZDv8Ot9Iyk/GJtj0eYSJ/ozod/d4F7lt7E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J82td8zrZS91vJGL5pil/fXCIAq0mE2lQxvlaGZ3rsMX042VncrL3SvQeOHgCDoIADLpQW9guOuqqytx/e8TbX8QTOgt1Gngar11ar6B9MQvXBSo7KNoY5K+r2foRwM4a5iS4ZKGM1/bQlMUjOvlkENLM4IMjL0qmMMO/qGYSydzI2hXYwA9cczu4TiX5pNRbhJP6uj2kL4u/dXFmo6yfRCcRh3A4IfBNcC1TmuZ+5u1kzTSsbipvvkKi2IWCs+ejVpXPWF5Hbs85jhQluaNFRzzUM2lr10nsoGwFbhEcClvresDXA6KMOkqRLtGwSyoLixy0sGHo+tOU0v+RWF7Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DzAuyE4m; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DzAuyE4m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4XCT2mtwz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:30:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B196660133;
	Tue, 28 Apr 2026 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE594C2BCAF;
	Tue, 28 Apr 2026 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361426;
	bh=NUkahn2fQKcVscwh1ZNhP9Ux4hzuiTG9l+Ex0RnXqrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzAuyE4mHR73GXt0aEhL4Y1y83XCRo5dzQEP/Naos4y98wjCQ3+9aVHy87wYPKQm+
	 UyvY1H4A3aspMp0YlGRzaaUe5/YbbHn/YHN1tLdka8XMlHq9q0NvVois7IJSPXFSqK
	 vMZv9CHHYxEQ9z8gIpmeOg0a2KgeizAFD5YSP1VeSjqtkkFjuFQ39sTC34VNvNDMiR
	 BqN+HDCOHVr5miGYAw2BWbnMH+Ifcq3QUG9DctkZ8+uruJzCf6i6RnZ5o6wRH5DKtL
	 sOpCO4BrNFXx4plg4ylgJhsiUBNjYKTXiPrwg9lfXVo+rqnvVWmE5jUYURupXpH4I9
	 KBsRCgfEo5Ebg==
Date: Tue, 28 Apr 2026 09:30:13 +0200
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
Subject: Re: [PATCH 14/49] mm/cma: validate hugetlb CMA range by zone at
 reserve time
Message-ID: <afBiBUq98Msv7ZFc@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-15-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-15-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:05PM +0800, Muchun Song wrote:
> During hugetlb_cma_reserve() we already have access to zone information, so we
> can validate that the reserved CMA range does not span multiple zones.
> 
> Doing this check up front allows future hugetlb allocations from CMA to assume
> zone-valid CMA areas, avoiding additional validity checks and potential
> fallback/rollback paths, greatly simplifying the code.
> 
> The pfn_valid() check is removed from cma_validate_zones() because mem_section is
> not initialized at that stage and it can trigger false warnings; keep the
> sanity check in cma_activate_area() instead. This is preparatory work for the
> follow-up simplification.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/cma.c         | 3 ++-
>  mm/hugetlb_cma.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 15cc0ae76c8e..dd046a23f467 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -125,7 +125,6 @@ bool cma_validate_zones(struct cma *cma)
>  		 * to be in the same zone. Simplify by forcing the entire
>  		 * CMA resv range to be in the same zone.
>  		 */
> -		WARN_ON_ONCE(!pfn_valid(base_pfn));
>  		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
>  			set_bit(CMA_ZONES_INVALID, &cma->flags);
>  			return false;
> @@ -164,6 +163,8 @@ static void __init cma_activate_area(struct cma *cma)
>  			bitmap_set(cmr->bitmap, 0, bitmap_count);
>  		}
>  
> +		WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
> +
>  		for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
>  		     pfn += pageblock_nr_pages)
>  			init_cma_reserved_pageblock(pfn_to_page(pfn));
> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
> index f83ae4998990..b068e9bf6537 100644
> --- a/mm/hugetlb_cma.c
> +++ b/mm/hugetlb_cma.c
> @@ -233,9 +233,10 @@ void __init hugetlb_cma_reserve(void)
>  		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
>  					HUGETLB_PAGE_ORDER, name,
>  					&hugetlb_cma[nid], nid);
> -		if (res) {
> +		if (res || !cma_validate_zones(hugetlb_cma[nid])) {
>  			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
>  				res, nid);

The warning here should be updated as well. Other than that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +			hugetlb_cma[nid] = NULL;
>  			continue;
>  		}
>  
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

