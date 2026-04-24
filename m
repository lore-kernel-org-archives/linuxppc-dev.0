Return-Path: <linuxppc-dev+bounces-20050-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFDAFB44CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25W763f2z2xwH;
	Fri, 24 Apr 2026 18:20:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777018835;
	cv=none; b=D/gjlwcF59NhgkAvVg235HRm0rGZBqwB/YCb2JaN1IvQ8nPyANu6eGnG2pqkr4NeWdWeX8IJt1whjODqlKbKnZcInmAEt/dEGtJEMWID3xLba1HoFR5Vkl5uZUU2JqjaSpcF6tXwyohAMFRqTyhCnjXpstvOOxC/EOHu70Zw7GxVx4T2oqhNCAxjkLp44DxJj5Cedp4rdEplRaI8T59Y/7/RL1/QEeM7udGa4f3Qk/l3eOJ3U8fNmvt3aj+lF4SSIcTrcrMt6B0QaY1Gpw4I/U4omgMkr3B2hz4efWL0ES6MtDxzZw6vi6DgVgi3dbbZhfgXoeD0xtK9/0Z6aTmX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777018835; c=relaxed/relaxed;
	bh=IEwVWEzE2Dj0wHkg3NnVA6TubIBJog0kwGg5D1sN2jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcXwa9g+ek1/7P27Gz+s+LPs0h7AkeronLR0ck137ysvT2NzNFhKfeBAOegrjUXM/V12EUyvjEVfUM4Q0UuIbzMZqxnLSal8Y/rSW4Z+Rgfv8pn1yCFadE2/5yGT6I4XjkKZhjsP81gTQa0+lE2a/ECHu8b0gkpGlWPOzw/gFvPDPux1668R/3vw1FPww6rYPCA0ASUCwl69lwKd/yTkIVQt/US4PdX7HBZVRkf+obuv93JJ0jRkxdsVMoxJINel8/c+g/sZJhTxN7kqiX7FQzDFT8L4cXgm0SKAfcZDAZcXNYtSWQmIbH/dJm12cXWlDE3Kb6TyDnwJJhNr3S+COQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mOMKksAU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mOMKksAU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25W55s9mz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:20:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E24046001A;
	Fri, 24 Apr 2026 08:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68013C19425;
	Fri, 24 Apr 2026 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777018830;
	bh=Rv6jBW9C6+YIR0iVvSndpiy1+KRdv3tYvLeHDMmVn0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOMKksAUWZvCKb8Ojm6kYghsEM28I/Mztw1a92GaD+6XofYQMD1pQHKguAWOCnWjB
	 mTCyWZ3OkABdRLM9eSm+SbbPUvMy2otzMEK1ea5pHoNTIwmN90fPnX4+fAc41Z7+g8
	 QjLLsZLJEJfajKQorsSixJXC+QFFbdXKzmcVZXz68mssOqhvNN/+zrqCUrmfPet45f
	 Q7yhOOr6zoUcXl7tErxPsUGjWtZ5bDM/D/3/qNHD/2j09YrukMF1PMHi8WLDddOZgk
	 jGqxoyyzGn8vdvAf3mgz3hXtt5u+ISYKkrx106+Dc9WhXMb5NeUdq+P491a72duOd0
	 kyqvtA1rMJUCg==
Date: Fri, 24 Apr 2026 11:20:20 +0300
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
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 6/7] mm/mm_init: Fix uninitialized struct pages for
 ZONE_DEVICE
Message-ID: <aesnxK_Use6wrCfE@kernel.org>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-7-songmuchun@bytedance.com>
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
In-Reply-To: <20260424025547.3806072-7-songmuchun@bytedance.com>

On Fri, Apr 24, 2026 at 10:55:46AM +0800, Muchun Song wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cfc76953e249..bd466a3c10c8 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
> @@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  			continue;
>  
>  		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> -				     compound_nr_pages(altmap, pgmap));
> +				     compound_nr_pages(pfn, altmap, pgmap));
>  	}
>  
>  	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

