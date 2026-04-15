Return-Path: <linuxppc-dev+bounces-19779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AEEF4384E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 15:55:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwm2B00Vfz2yvh;
	Thu, 16 Apr 2026 01:55:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776268529;
	cv=none; b=mgAGqjZETmu8DTxmrkioqs6jIrgWxI3vPH53h+dzJXYbCIlnTPMPgcn13+BhmiayxPQ+JWau12Tha0k9xAh8KqtyJHllI3skIKQntRfAWz991tpLmSF1yUYi8imB1KIDwe/eFfWB2vlCA1Vdn3GDkDh36GIbDocrqQrZtPsv1olfWi1QgSCafeMbPXBIW9qYecyq1VtQyY38/0dDZgPdbop6Oo4/L5V0eLt+NvSvi3sMXisv1wkxOJRMDEjPbt8vMKTHbXxDNRvcIlSKZjpFlpdP6zrxARGcx6kG/Omvb6vXAdTKeOIfQ+zQroS2kOE+0yRKeP2kZ5Mv6JBo9V/9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776268529; c=relaxed/relaxed;
	bh=GnnIfCksJ5uQMJ5NyRezSriUywzuLdH3gxtyktG6Zrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU+iAG0CEL22ryHakLMMWdFizGUKmbvenuz6jD3T+ltvx2N4F5Cr4blJVFRUBgkDlyXqCr55Le6PqGvvzou7H+ngy7OrffwydX7KwfTd/zBFyeoiqi+1f2f8xKTR1jgZn6KzfWjgtCbCUbgQZuB4HY2IBHtpxSHl9lCPEaIAtW0R/DIE3nkaxJ1dAzv6xVwjoEKWsMvE/0zXWd5ZsxSseeOXlux6JLrOL7UTC9xwmzeyg3/fXckxtQdXc0pDDUkMS/A2M/0mujYyKXxzJRkAzRA6WyA8F/hUg5S5/n6snN7hq5CJldXzDzS/WLZpi6NdVM/Acw7SWlxO06yFv7mMzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FN3T4pdX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FN3T4pdX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwm2901Lzz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 01:55:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC3EB43A0C;
	Wed, 15 Apr 2026 15:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2FBC19424;
	Wed, 15 Apr 2026 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268526;
	bh=iwixORW5qtkGBB6dbk60dbN6Q9CKk75q8eWQsJtSYvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FN3T4pdXOcDMmuVqXAKyLFrDTss8cLQMRFGw8K7CpoF2nEsb7j5cXLDUjSBb4ea4l
	 obR8VUcNr4M4SY2jJ+wft0MXcOKnw+YHpoazAsumBmwPzVT/FVzFxRrfo9e/ysr33N
	 t+0s1GAYeDmf2mua+idCxuHVlTFp+Hh4Je1KnUrVDG8bSdNuSAirsS5Lil3t6OxbiS
	 7Ccqac33uvsQ4JPOMWAJBb4pCBoAjWIyuQiGBx48gPIVQbBCd0f/HhANjb70RDS/xZ
	 vo7/C/i2DAmxueq1DilcDdUlRD2BQpipPWlca498c/StaRMbBmCrM66q6NiPWHbieg
	 N0kR+tOvjG+5A==
Date: Wed, 15 Apr 2026 18:55:17 +0300
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
Subject: Re: [PATCH v2 2/6] mm/sparse-vmemmap: Pass @pgmap argument to memory
 deactivation paths
Message-ID: <ad-05cimuc2oXHIE@kernel.org>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-3-songmuchun@bytedance.com>
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
In-Reply-To: <20260415111412.1003526-3-songmuchun@bytedance.com>

On Wed, Apr 15, 2026 at 07:14:08PM +0800, Muchun Song wrote:
> Currently, the memory hot-remove call chain -- arch_remove_memory(),
> __remove_pages(), sparse_remove_section() and section_deactivate() --
> does not carry the struct dev_pagemap pointer. This prevents the lower
> levels from knowing whether the section was originally populated with
> vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).
> 
> Without this information, we cannot call vmemmap_can_optimize() to
> determine if the vmemmap pages were optimized. As a result, the vmemmap
> page accounting during teardown will mistakenly assume a non-optimized
> allocation, leading to incorrect memmap statistics.
> 
> To lay the groundwork for fixing the vmemmap page accounting, we need
> to pass the @pgmap pointer down to the deactivation location. Plumb the
> @pgmap argument through the APIs of arch_remove_memory(), __remove_pages()
> and sparse_remove_section(), mirroring the corresponding *_activate()
> paths.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm64/mm/mmu.c            |  5 +++--
>  arch/loongarch/mm/init.c       |  5 +++--
>  arch/powerpc/mm/mem.c          |  5 +++--
>  arch/riscv/mm/init.c           |  5 +++--
>  arch/s390/mm/init.c            |  5 +++--
>  arch/x86/mm/init_64.c          |  5 +++--
>  include/linux/memory_hotplug.h |  8 +++++---
>  mm/memory_hotplug.c            | 12 ++++++------
>  mm/memremap.c                  |  4 ++--
>  mm/sparse-vmemmap.c            | 17 +++++++++--------
>  10 files changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dd85e093ffdb..e5a42b7a0160 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -2024,12 +2024,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	return ret;
>  }
>  
> -void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			struct dev_pagemap *pgmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  
> -	__remove_pages(start_pfn, nr_pages, altmap);
> +	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
>  	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
>  }
>  
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 00f3822b6e47..c9c57f08fa2c 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -86,7 +86,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
>  	return ret;
>  }
>  
> -void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			struct dev_pagemap *pgmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> @@ -95,7 +96,7 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  	/* With altmap the first mapped page is offset from @start */
>  	if (altmap)
>  		page += vmem_altmap_offset(altmap);
> -	__remove_pages(start_pfn, nr_pages, altmap);
> +	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
>  }
>  #endif
>  
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 648d0c5602ec..4c1afab91996 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -158,12 +158,13 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  	return rc;
>  }
>  
> -void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			      struct dev_pagemap *pgmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  
> -	__remove_pages(start_pfn, nr_pages, altmap);
> +	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
>  	arch_remove_linear_mapping(start, size);
>  }
>  #endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index decd7df40fa4..b0092fb842a3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1717,9 +1717,10 @@ int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *param
>  	return ret;
>  }
>  
> -void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			      struct dev_pagemap *pgmap)
>  {
> -	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
> +	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap, pgmap);
>  	remove_linear_mapping(start, size);
>  	flush_tlb_all();
>  }
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 1f72efc2a579..11a689423440 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -276,12 +276,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	return rc;
>  }
>  
> -void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			struct dev_pagemap *pgmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  
> -	__remove_pages(start_pfn, nr_pages, altmap);
> +	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
>  	vmem_remove_mapping(start, size);
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index df2261fa4f98..77b889b71cf3 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1288,12 +1288,13 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
>  	remove_pagetable(start, end, true, NULL);
>  }
>  
> -void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			      struct dev_pagemap *pgmap)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  
> -	__remove_pages(start_pfn, nr_pages, altmap);
> +	__remove_pages(start_pfn, nr_pages, altmap, pgmap);
>  	kernel_physical_mapping_remove(start, start + size);
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 815e908c4135..7c9d66729c60 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -135,9 +135,10 @@ static inline bool movable_node_is_enabled(void)
>  	return movable_node_enabled;
>  }
>  
> -extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap);
> +extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
> +			       struct dev_pagemap *pgmap);
>  extern void __remove_pages(unsigned long start_pfn, unsigned long nr_pages,
> -			   struct vmem_altmap *altmap);
> +			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
>  
>  /* reasonably generic interface to expand the physical pages */
>  extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
> @@ -307,7 +308,8 @@ extern int sparse_add_section(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap);
>  extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
> -				  struct vmem_altmap *altmap);
> +				  struct vmem_altmap *altmap,
> +				  struct dev_pagemap *pgmap);
>  extern struct zone *zone_for_pfn_range(enum mmop online_type,
>  		int nid, struct memory_group *group, unsigned long start_pfn,
>  		unsigned long nr_pages);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a943ec57c85..6a9e2dc751d2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -583,7 +583,7 @@ void remove_pfn_range_from_zone(struct zone *zone,
>   * calling offline_pages().
>   */
>  void __remove_pages(unsigned long pfn, unsigned long nr_pages,
> -		    struct vmem_altmap *altmap)
> +		    struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	const unsigned long end_pfn = pfn + nr_pages;
>  	unsigned long cur_nr_pages;
> @@ -598,7 +598,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  		/* Select all remaining pages up to the next section boundary */
>  		cur_nr_pages = min(end_pfn - pfn,
>  				   SECTION_ALIGN_UP(pfn + 1) - pfn);
> -		sparse_remove_section(pfn, cur_nr_pages, altmap);
> +		sparse_remove_section(pfn, cur_nr_pages, altmap, pgmap);
>  	}
>  }
>  
> @@ -1425,7 +1425,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>  
>  		remove_memory_block_devices(cur_start, memblock_size);
>  
> -		arch_remove_memory(cur_start, memblock_size, altmap);
> +		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
>  
>  		/* Verify that all vmemmap pages have actually been freed. */
>  		WARN(altmap->alloc, "Altmap not fully unmapped");
> @@ -1468,7 +1468,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>  		ret = create_memory_block_devices(cur_start, memblock_size, nid,
>  						  params.altmap, group);
>  		if (ret) {
> -			arch_remove_memory(cur_start, memblock_size, NULL);
> +			arch_remove_memory(cur_start, memblock_size, NULL, NULL);
>  			kfree(params.altmap);
>  			goto out;
>  		}
> @@ -1554,7 +1554,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		/* create memory block devices after memory was added */
>  		ret = create_memory_block_devices(start, size, nid, NULL, group);
>  		if (ret) {
> -			arch_remove_memory(start, size, params.altmap);
> +			arch_remove_memory(start, size, params.altmap, NULL);
>  			goto error;
>  		}
>  	}
> @@ -2266,7 +2266,7 @@ static int try_remove_memory(u64 start, u64 size)
>  		 * No altmaps present, do the removal directly
>  		 */
>  		remove_memory_block_devices(start, size);
> -		arch_remove_memory(start, size, NULL);
> +		arch_remove_memory(start, size, NULL, NULL);
>  	} else {
>  		/* all memblocks in the range have altmaps */
>  		remove_memory_blocks_and_altmaps(start, size);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ac7be07e3361..c45b90f334ea 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -97,10 +97,10 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>  				   PHYS_PFN(range_len(range)));
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>  		__remove_pages(PHYS_PFN(range->start),
> -			       PHYS_PFN(range_len(range)), NULL);
> +			       PHYS_PFN(range_len(range)), NULL, pgmap);
>  	} else {
>  		arch_remove_memory(range->start, range_len(range),
> -				pgmap_altmap(pgmap));
> +				pgmap_altmap(pgmap), pgmap);
>  		kasan_remove_zero_shadow(__va(range->start), range_len(range));
>  	}
>  	mem_hotplug_done();
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index a7b11248b989..40290fbc1db4 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -665,7 +665,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  }
>  
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> +		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	unsigned long start = (unsigned long) pfn_to_page(pfn);
>  	unsigned long end = start + nr_pages * sizeof(struct page);
> @@ -674,7 +674,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>  	vmemmap_free(start, end, altmap);
>  }
>  
> -static void free_map_bootmem(struct page *memmap)
> +static void free_map_bootmem(struct page *memmap, struct vmem_altmap *altmap,
> +		struct dev_pagemap *pgmap)
>  {
>  	unsigned long start = (unsigned long)memmap;
>  	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
> @@ -746,7 +747,7 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>   * usage map, but still need to free the vmemmap range.
>   */
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> +		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  	bool section_is_early = early_section(ms);
> @@ -784,9 +785,9 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * section_activate() and pfn_valid() .
>  	 */
>  	if (!section_is_early)
> -		depopulate_section_memmap(pfn, nr_pages, altmap);
> +		depopulate_section_memmap(pfn, nr_pages, altmap, pgmap);
>  	else if (memmap)
> -		free_map_bootmem(memmap);
> +		free_map_bootmem(memmap, altmap, pgmap);
>  
>  	if (empty)
>  		ms->section_mem_map = (unsigned long)NULL;
> @@ -828,7 +829,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  
>  	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
>  	if (!memmap) {
> -		section_deactivate(pfn, nr_pages, altmap);
> +		section_deactivate(pfn, nr_pages, altmap, pgmap);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -889,13 +890,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  }
>  
>  void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
> -			   struct vmem_altmap *altmap)
> +			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  
>  	if (WARN_ON_ONCE(!valid_section(ms)))
>  		return;
>  
> -	section_deactivate(pfn, nr_pages, altmap);
> +	section_deactivate(pfn, nr_pages, altmap, pgmap);
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

