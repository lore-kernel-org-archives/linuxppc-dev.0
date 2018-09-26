Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kj1b6NN8zF116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 12:43:47 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q2dRdb035895
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:43:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqvmgtk7d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:43:45 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 26 Sep 2018 03:43:43 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 14/22] powerpc/mm: Move pte_fragment_alloc() to a
 common location
In-Reply-To: <de995657691084fe1b8a5c31393a82e52604def8.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <de995657691084fe1b8a5c31393a82e52604def8.1537892499.git.christophe.leroy@c-s.fr>
Date: Wed, 26 Sep 2018 08:13:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvmdgeqv.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In preparation of next patch which generalises the use of
> pte_fragment_alloc() for all, this patch moves the related functions
> in a place that is common to all subarches.
>
> The 8xx will need that for supporting 16k pages, as in that mode
> page tables still have a size of 4k.
>
> Since pte_fragment with only once fragment is not different
> from what is done in the general case, we can easily migrate all
> subarchs to pte fragments.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h |   1 +
>  arch/powerpc/mm/Makefile                     |   4 +-
>  arch/powerpc/mm/mmu_context_book3s64.c       |  15 ----
>  arch/powerpc/mm/pgtable-book3s64.c           |  85 --------------------
>  arch/powerpc/mm/pgtable-frag.c               | 116 +++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+), 101 deletions(-)
>  create mode 100644 arch/powerpc/mm/pgtable-frag.c
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index bfed4cf3b2f3..6c2808c0f052 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -39,6 +39,7 @@ extern struct vmemmap_backing *vmemmap_list;
>  extern struct kmem_cache *pgtable_cache[];
>  #define PGT_CACHE(shift) pgtable_cache[shift]
>  
> +void pte_frag_destroy(void *pte_frag);
>  extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
>  extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
>  extern void pte_fragment_free(unsigned long *, int);
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index d0c1ce1297e3..db2f001183d1 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -15,7 +15,9 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
>  obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
>  hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
>  obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
> -obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
> +obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
> +				   $(hash64-y) mmu_context_book3s64.o \
> +				   pgtable-book3s64.o pgtable-frag.o
>  obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
>  obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
>  obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 510f103d7813..f720c5cc0b5e 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -164,21 +164,6 @@ static void destroy_contexts(mm_context_t *ctx)
>  	}
>  }
>  
> -static void pte_frag_destroy(void *pte_frag)
> -{
> -	int count;
> -	struct page *page;
> -
> -	page = virt_to_page(pte_frag);
> -	/* drop all the pending references */
> -	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
> -	/* We allow PTE_FRAG_NR fragments from a PTE page */
> -	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> -		pgtable_page_dtor(page);
> -		__free_page(page);
> -	}
> -}
> -
>  static void pmd_frag_destroy(void *pmd_frag)
>  {
>  	int count;
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 01d7c0f7c4f0..723cd324fa34 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -317,91 +317,6 @@ void pmd_fragment_free(unsigned long *pmd)
>  	}
>  }
>  
> -static pte_t *get_pte_from_cache(struct mm_struct *mm)
> -{
> -	void *pte_frag, *ret;
> -
> -	spin_lock(&mm->page_table_lock);
> -	ret = mm->context.pte_frag;
> -	if (ret) {
> -		pte_frag = ret + PTE_FRAG_SIZE;
> -		/*
> -		 * If we have taken up all the fragments mark PTE page NULL
> -		 */
> -		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
> -			pte_frag = NULL;
> -		mm->context.pte_frag = pte_frag;
> -	}
> -	spin_unlock(&mm->page_table_lock);
> -	return (pte_t *)ret;
> -}
> -
> -static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> -{
> -	void *ret = NULL;
> -	struct page *page;
> -
> -	if (!kernel) {
> -		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
> -		if (!page)
> -			return NULL;
> -		if (!pgtable_page_ctor(page)) {
> -			__free_page(page);
> -			return NULL;
> -		}
> -	} else {
> -		page = alloc_page(PGALLOC_GFP);
> -		if (!page)
> -			return NULL;
> -	}
> -
> -	atomic_set(&page->pt_frag_refcount, 1);
> -
> -	ret = page_address(page);
> -	/*
> -	 * if we support only one fragment just return the
> -	 * allocated page.
> -	 */
> -	if (PTE_FRAG_NR == 1)
> -		return ret;
> -	spin_lock(&mm->page_table_lock);
> -	/*
> -	 * If we find pgtable_page set, we return
> -	 * the allocated page with single fragement
> -	 * count.
> -	 */
> -	if (likely(!mm->context.pte_frag)) {
> -		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> -		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
> -	}
> -	spin_unlock(&mm->page_table_lock);
> -
> -	return (pte_t *)ret;
> -}
> -
> -pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
> -{
> -	pte_t *pte;
> -
> -	pte = get_pte_from_cache(mm);
> -	if (pte)
> -		return pte;
> -
> -	return __alloc_for_ptecache(mm, kernel);
> -}
> -
> -void pte_fragment_free(unsigned long *table, int kernel)
> -{
> -	struct page *page = virt_to_page(table);
> -
> -	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> -	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> -		if (!kernel)
> -			pgtable_page_dtor(page);
> -		__free_page(page);
> -	}
> -}
> -
>  static inline void pgtable_free(void *table, int index)
>  {
>  	switch (index) {
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> new file mode 100644
> index 000000000000..d61e7c2a9a79
> --- /dev/null
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + *  Handling Page Tables through page fragments
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/percpu.h>
> +#include <linux/hardirq.h>
> +#include <linux/hugetlb.h>
> +#include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +#include <asm/tlb.h>
> +
> +void pte_frag_destroy(void *pte_frag)
> +{
> +	int count;
> +	struct page *page;
> +
> +	page = virt_to_page(pte_frag);
> +	/* drop all the pending references */
> +	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
> +	/* We allow PTE_FRAG_NR fragments from a PTE page */
> +	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> +		pgtable_page_dtor(page);
> +		__free_page(page);
> +	}
> +}
> +
> +static pte_t *get_pte_from_cache(struct mm_struct *mm)
> +{
> +	void *pte_frag, *ret;
> +
> +	spin_lock(&mm->page_table_lock);
> +	ret = mm->context.pte_frag;
> +	if (ret) {
> +		pte_frag = ret + PTE_FRAG_SIZE;
> +		/*
> +		 * If we have taken up all the fragments mark PTE page NULL
> +		 */
> +		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
> +			pte_frag = NULL;
> +		mm->context.pte_frag = pte_frag;
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +	return (pte_t *)ret;
> +}
> +
> +static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> +{
> +	void *ret = NULL;
> +	struct page *page;
> +
> +	if (!kernel) {
> +		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
> +		if (!page)
> +			return NULL;
> +		if (!pgtable_page_ctor(page)) {
> +			__free_page(page);
> +			return NULL;
> +		}
> +	} else {
> +		page = alloc_page(PGALLOC_GFP);
> +		if (!page)
> +			return NULL;
> +	}
> +
> +	atomic_set(&page->pt_frag_refcount, 1);
> +
> +	ret = page_address(page);
> +	/*
> +	 * if we support only one fragment just return the
> +	 * allocated page.
> +	 */
> +	if (PTE_FRAG_NR == 1)
> +		return ret;
> +	spin_lock(&mm->page_table_lock);
> +	/*
> +	 * If we find pgtable_page set, we return
> +	 * the allocated page with single fragement
> +	 * count.
> +	 */
> +	if (likely(!mm->context.pte_frag)) {
> +		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> +		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +
> +	return (pte_t *)ret;
> +}
> +
> +pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
> +{
> +	pte_t *pte;
> +
> +	pte = get_pte_from_cache(mm);
> +	if (pte)
> +		return pte;
> +
> +	return __alloc_for_ptecache(mm, kernel);
> +}
> +
> +void pte_fragment_free(unsigned long *table, int kernel)
> +{
> +	struct page *page = virt_to_page(table);
> +
> +	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> +	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> +		if (!kernel)
> +			pgtable_page_dtor(page);
> +		__free_page(page);
> +	}
> +}
> -- 
> 2.13.3
