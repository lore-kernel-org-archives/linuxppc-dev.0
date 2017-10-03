Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y604q568ZzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 00:19:55 +1100 (AEDT)
Date: Tue, 3 Oct 2017 15:19:52 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v9 12/12] mm: stop zeroing memory during allocation in
 vmemmap
Message-ID: <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-13-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920201714.19817-13-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 20-09-17 16:17:14, Pavel Tatashin wrote:
> vmemmap_alloc_block() will no longer zero the block, so zero memory
> at its call sites for everything except struct pages.  Struct page memory
> is zero'd by struct page initialization.
> 
> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
> we will get the performance improvement by zeroing the memory in parallel
> when struct pages are zeroed.

Is it possible to merge this patch with http://lkml.kernel.org/r/20170920201714.19817-7-pasha.tatashin@oracle.com

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  include/linux/mm.h  | 11 +++++++++++
>  mm/sparse-vmemmap.c | 15 +++++++--------
>  mm/sparse.c         |  6 +++---
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7bba4ce79ba..25848764570f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2501,6 +2501,17 @@ static inline void *vmemmap_alloc_block_buf(unsigned long size, int node)
>  	return __vmemmap_alloc_block_buf(size, node, NULL);
>  }
>  
> +static inline void *vmemmap_alloc_block_zero(unsigned long size, int node)
> +{
> +	void *p = vmemmap_alloc_block(size, node);
> +
> +	if (!p)
> +		return NULL;
> +	memset(p, 0, size);
> +
> +	return p;
> +}
> +
>  void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
>  int vmemmap_populate_basepages(unsigned long start, unsigned long end,
>  			       int node);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d1a39b8051e0..c2f5654e7c9d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -41,7 +41,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
>  				unsigned long align,
>  				unsigned long goal)
>  {
> -	return memblock_virt_alloc_try_nid(size, align, goal,
> +	return memblock_virt_alloc_try_nid_raw(size, align, goal,
>  					    BOOTMEM_ALLOC_ACCESSIBLE, node);
>  }
>  
> @@ -54,9 +54,8 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
>  	if (slab_is_available()) {
>  		struct page *page;
>  
> -		page = alloc_pages_node(node,
> -			GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL,
> -			get_order(size));
> +		page = alloc_pages_node(node, GFP_KERNEL | __GFP_RETRY_MAYFAIL,
> +					get_order(size));
>  		if (page)
>  			return page_address(page);
>  		return NULL;
> @@ -183,7 +182,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>  {
>  	pmd_t *pmd = pmd_offset(pud, addr);
>  	if (pmd_none(*pmd)) {
> -		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
> +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
>  		pmd_populate_kernel(&init_mm, pmd, p);
> @@ -195,7 +194,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
>  {
>  	pud_t *pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud)) {
> -		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
> +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
>  		pud_populate(&init_mm, pud, p);
> @@ -207,7 +206,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  {
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
> -		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
> +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
>  		p4d_populate(&init_mm, p4d, p);
> @@ -219,7 +218,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  {
>  	pgd_t *pgd = pgd_offset_k(addr);
>  	if (pgd_none(*pgd)) {
> -		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
> +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
>  		pgd_populate(&init_mm, pgd, p);
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 83b3bf6461af..d22f51bb7c79 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -437,9 +437,9 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  	}
>  
>  	size = PAGE_ALIGN(size);
> -	map = memblock_virt_alloc_try_nid(size * map_count,
> -					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> -					  BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
> +	map = memblock_virt_alloc_try_nid_raw(size * map_count,
> +					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> +					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
>  	if (map) {
>  		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
>  			if (!present_section_nr(pnum))
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
