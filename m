Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPBqT6q2pzDrhx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 14:14:44 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so2060595pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 21:14:44 -0700 (PDT)
Subject: Re: [RESEND][v2][PATCH] KVM: PPC: Book3S HV: Migrate pinned pages out
 of CMA
To: bsingharora@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
References: <20160714042536.GG18277@balbir.ozlabs.ibm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3ba0fa6c-bfe6-a395-9c32-db8d6261559d@ozlabs.ru>
Date: Wed, 31 Aug 2016 14:14:35 +1000
MIME-Version: 1.0
In-Reply-To: <20160714042536.GG18277@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 14:25, Balbir Singh wrote:
> 
> From: Balbir Singh <bsingharora@gmail.com>
> Subject: [RESEND][v2][PATCH] KVM: PPC: Book3S HV: Migrate pinned pages out of CMA
> 
> When PCI Device pass-through is enabled via VFIO, KVM-PPC will
> pin pages using get_user_pages_fast(). One of the downsides of
> the pinning is that the page could be in CMA region. The CMA
> region is used for other allocations like the hash page table.
> Ideally we want the pinned pages to be from non CMA region.
> 
> This patch (currently only for KVM PPC with VFIO) forcefully
> migrates the pages out (huge pages are omitted for the moment).
> There are more efficient ways of doing this, but that might
> be elaborate and might impact a larger audience beyond just
> the kvm ppc implementation.
> 
> The magic is in new_iommu_non_cma_page() which allocates the
> new page from a non CMA region.
> 
> I've tested the patches lightly at my end, but there might be bugs
> For example if after lru_add_drain(), the page is not isolated
> is this a BUG?
> 
> Previous discussion was at
> http://permalink.gmane.org/gmane.linux.kernel.mm/136738
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>



Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  arch/powerpc/include/asm/mmu_context.h |  1 +
>  arch/powerpc/mm/mmu_context_iommu.c    | 80 ++++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 9d2cd0c..475d1be 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -18,6 +18,7 @@ extern void destroy_context(struct mm_struct *mm);
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  struct mm_iommu_table_group_mem_t;
>  
> +extern int isolate_lru_page(struct page *page);	/* from internal.h */
>  extern bool mm_iommu_preregistered(void);
>  extern long mm_iommu_get(unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index da6a216..c18f742 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -15,6 +15,9 @@
>  #include <linux/rculist.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mutex.h>
> +#include <linux/migrate.h>
> +#include <linux/hugetlb.h>
> +#include <linux/swap.h>
>  #include <asm/mmu_context.h>
>  
>  static DEFINE_MUTEX(mem_list_mutex);
> @@ -72,6 +75,54 @@ bool mm_iommu_preregistered(void)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
>  
> +/*
> + * Taken from alloc_migrate_target with changes to remove CMA allocations
> + */
> +struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
> +					int **resultp)
> +{
> +	gfp_t gfp_mask = GFP_USER;
> +	struct page *new_page;
> +
> +	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
> +		return NULL;
> +
> +	if (PageHighMem(page))
> +		gfp_mask |= __GFP_HIGHMEM;
> +
> +	/*
> +	 * We don't want the allocation to force an OOM if possibe
> +	 */
> +	new_page = alloc_page(gfp_mask | __GFP_NORETRY | __GFP_NOWARN);
> +	return new_page;
> +}
> +
> +static int mm_iommu_move_page_from_cma(struct page *page)
> +{
> +	int ret;
> +	LIST_HEAD(cma_migrate_pages);
> +
> +	/* Ignore huge pages for now */
> +	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
> +		return -EBUSY;
> +
> +	lru_add_drain();
> +	ret = isolate_lru_page(page);
> +	if (ret)
> +		get_page(page); /* Potential BUG? */
> +
> +	list_add(&page->lru, &cma_migrate_pages);
> +	put_page(page); /* Drop the gup reference */
> +
> +	ret = migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
> +				NULL, 0, MIGRATE_SYNC, MR_CMA);
> +	if (ret) {
> +		if (!list_empty(&cma_migrate_pages))
> +			putback_movable_pages(&cma_migrate_pages);
> +	}
> +	return 0;
> +}
> +
>  long mm_iommu_get(unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
> @@ -124,15 +175,36 @@ long mm_iommu_get(unsigned long ua, unsigned long entries,
>  	for (i = 0; i < entries; ++i) {
>  		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
>  					1/* pages */, 1/* iswrite */, &page)) {
> +			ret = -EFAULT;
>  			for (j = 0; j < i; ++j)
> -				put_page(pfn_to_page(
> -						mem->hpas[j] >> PAGE_SHIFT));
> +				put_page(pfn_to_page(mem->hpas[j] >>
> +						PAGE_SHIFT));
>  			vfree(mem->hpas);
>  			kfree(mem);
> -			ret = -EFAULT;
>  			goto unlock_exit;
>  		}
> -
> +		/*
> +		 * If we get a page from the CMA zone, since we are going to
> +		 * be pinning these entries, we might as well move them out
> +		 * of the CMA zone if possible. NOTE: faulting in + migration
> +		 * can be expensive. Batching can be considered later
> +		 */
> +		if (get_pageblock_migratetype(page) == MIGRATE_CMA) {
> +			if (mm_iommu_move_page_from_cma(page))
> +				goto populate;
> +			if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
> +						1/* pages */, 1/* iswrite */,
> +						&page)) {
> +				ret = -EFAULT;
> +				for (j = 0; j < i; ++j)
> +					put_page(pfn_to_page(mem->hpas[j] >>
> +								PAGE_SHIFT));
> +				vfree(mem->hpas);
> +				kfree(mem);
> +				goto unlock_exit;
> +			}
> +		}
> +populate:
>  		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
>  	}
>  
> 


-- 
Alexey
