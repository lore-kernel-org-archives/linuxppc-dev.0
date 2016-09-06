Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT4lf4W0KzDsNn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:54:54 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u86BqSG3030884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 07:54:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259ur9dt0s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 07:54:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 21:54:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3512E2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:54:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u86BshOj63242426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 21:54:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u86BsgDe022661
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 21:54:43 +1000
Date: Tue, 06 Sep 2016 17:24:40 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Migrate pinned pages out of CMA
References: <20160714042536.GG18277@balbir.ozlabs.ibm.com>
 <3ba0fa6c-bfe6-a395-9c32-db8d6261559d@ozlabs.ru>
 <cf34d62d-164c-bc7b-5538-ebd3c22657a5@gmail.com>
 <2e840fe0-40cf-abf0-4fe6-a621ce46ae13@gmail.com>
In-Reply-To: <2e840fe0-40cf-abf0-4fe6-a621ce46ae13@gmail.com>
Content-Type: text/plain; charset=koi8-r
Message-Id: <57CEAE80.1050306@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/06/2016 11:57 AM, Balbir Singh wrote:
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
> I've tested the patches lightly at my end. The full solution
> requires migration of THP pages in the CMA region. That work
> will be done incrementally on top of this.
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
> Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/mmu_context.h |  1 +
>  arch/powerpc/mm/mmu_context_iommu.c    | 81 ++++++++++++++++++++++++++++++++--
>  2 files changed, 78 insertions(+), 4 deletions(-)
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

Small nit, cant we just add "mm/internal.h" header here with full path ?

>  extern bool mm_iommu_preregistered(void);
>  extern long mm_iommu_get(unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index da6a216..e0f1c33 100644
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
> @@ -72,6 +75,55 @@ bool mm_iommu_preregistered(void)
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

So what guarantees that the new page too wont come from MIGRATE_CMA
page block ? Is absence of __GFP_MOVABLE flag enough. Also should not
we be checking that migrate type of the new allocated page is indeed
not MIGRATE_CMA ?
