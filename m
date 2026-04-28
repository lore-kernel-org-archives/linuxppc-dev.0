Return-Path: <linuxppc-dev+bounces-20211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7531FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:06:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Wgy3JxFz2xld;
	Tue, 28 Apr 2026 17:06:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777359998;
	cv=none; b=ZEph8qHDuUIqIWl51lltN+ooZNd9jwDs6Gx2JqB1AaNXQpeLjNpIpOX0DLJLNPwN9HPMWDB1wWZljIcBZ0hEpljxgixSKJsBo7cvs8AGspCKxzs6PjFyUUV8bC5f9Z2LB5m9WRn6sIoaB6iwoLkxtt6K+pYzhtoN6y1KXJYafwwqhkk0onTTQTFnQVJe0fwdcxqSkO96GJ13NflRVHFVWZNEja4ufc5Ar02H8o2jIaW5P2t9ouzeahH3RZTiIm2wSsMhhFq4+iIkbEp0q+S7jI4EYRpXmLsn91W7BaYsF0C3Z+NESgUnxTcTNSroUYuJDIRZTdqlWk9v4pwjOq9ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777359998; c=relaxed/relaxed;
	bh=ugKPT3dFXN0JQbPmNQ4wIwkZSWZLGY/HgU+sxJALhB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtel4EGgwEfVCyc2ENcj/HM4jtqMyHYW8X3nqW/lk94wFZRpARZN8XU1FR6ZNBeOkaukJarrRbhP4baS8lRm1v4fT+dOfWe+DJYhNM4lH30RKoRhd6OX6JtZrDygtWbJxH28GnXTl6mYjZiX32HFgjLnrnxl9d3JMis+ER0mV6vXQXRph0Xl2l4ZS7b8g9BSv0etKJrXuXE0ccWIC/2flNUuS5t+GO1rAf57XDIMwKzVI/UlDgBJP6UmthqFmNzOstqYFeaVfNHIEjHnzQK5tgf5gWdq4u6kVYPYBTr3+DOJSanK15g6qhIPkaKaSFpoG89oui6mMR6vAlYd5MZcww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YHP11C4p; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YHP11C4p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Wgx56tKz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:06:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A87A41AF5;
	Tue, 28 Apr 2026 07:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B5C2BCB6;
	Tue, 28 Apr 2026 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359996;
	bh=AmZrrVrVvG/hI74hQkTxsZH0QSUjw9p1a/uNen2G+Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHP11C4pRdasJf8eSkFixOJZscPHF3WGc1114N0tgEsBPJ41Xd0z6h9TjAFYnbvJM
	 6y8Wf+ohZ5wiNa0HQkT7ae1lo345jSHffVXCEOCCoRBCT5GpReFRA9X1M71HtFJvif
	 P17JyJzUyh8L8A2gSfyGDFLC0cOB+EAkIBe4ctFiXmd7ySQsCFQ0tPNHTyjQqHyvSE
	 QC+Dn3CN1GUu2FBGysCWCgwEC5OV9JpLUbiC9jdgbFEEtkzn24mKdzqu86utR2iMkO
	 PMRH5C3TOy9b/2AdjexXKjybnzLB5eFGdshOg490dVsPabUWLRggSLBL6eWPkkuC+6
	 5D2C2UsDkrI0w==
Date: Tue, 28 Apr 2026 09:06:26 +0200
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
Subject: Re: [PATCH 10/49] mm: move subsection_map_init() into sparse_init()
Message-ID: <afBcckUTQt-7xPPN@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-11-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-11-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:01PM +0800, Muchun Song wrote:
> Move the initialization of the subsection map from free_area_init()
> into sparse_init(). This encapsulates the logic within the sparse
> memory initialization code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/internal.h       |  5 ++---
>  mm/mm_init.c        | 10 ++--------
>  mm/sparse-vmemmap.c | 11 ++++++++++-
>  mm/sparse.c         |  1 +
>  4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index edb1c04d0617..d70075d0e788 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1004,10 +1004,9 @@ static inline void sparse_init(void) {}
>   * mm/sparse-vmemmap.c
>   */
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
> +void sparse_init_subsection_map(void);
>  #else
> -static inline void sparse_init_subsection_map(unsigned long pfn,
> -		unsigned long nr_pages)
> +static inline void sparse_init_subsection_map(void)
>  {
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */

I side note: we might want to split out mm/sparse.h and also move some
declarations from include/linux/mmzone.h there.

> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a92c5053f63d..5ca4503e7622 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1857,18 +1857,12 @@ static void __init free_area_init(void)
>  			       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
>  	}
>  
> -	/*
> -	 * Print out the early node map, and initialize the
> -	 * subsection-map relative to active online memory ranges to
> -	 * enable future "sub-section" extensions of the memory map.
> -	 */
> +	/* Print out the early node map. */
>  	pr_info("Early memory node ranges\n");
> -	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
>  		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
>  			(u64)start_pfn << PAGE_SHIFT,
>  			((u64)end_pfn << PAGE_SHIFT) - 1);
> -		sparse_init_subsection_map(start_pfn, end_pfn - start_pfn);
> -	}
>  
>  	/* Initialise every node */
>  	mminit_verify_pageflags_layout();
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 0ee03db0b22f..b7201c235419 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -603,7 +603,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  	bitmap_set(map, idx, end - idx + 1);
>  }
>  
> -void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +static void __init sparse_init_subsection_map_range(unsigned long pfn, unsigned long nr_pages)
>  {
>  	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
>  	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
> @@ -626,6 +626,15 @@ void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages
>  	}
>  }
>  
> +void __init sparse_init_subsection_map(void)
> +{
> +	int i, nid;
> +	unsigned long start, end;
> +
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
> +		sparse_init_subsection_map_range(start, end - start);
> +}
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  
>  /* Mark all memory sections within the pfn range as online */
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 5c12b979a618..c7f91dc2e5b5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -424,5 +424,6 @@ void __init sparse_init(void)
>  	}
>  	/* cover the last node */
>  	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> +	sparse_init_subsection_map();
>  	vmemmap_populate_print_last();
>  }
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

