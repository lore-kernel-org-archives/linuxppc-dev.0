Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy3WX6CFgzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 19:26:32 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v349Nive119718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 05:26:24 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m1njknmd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 05:26:23 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 14:56:20 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v349QJPO16122034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:56:19 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v349QIBp019156
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 14:56:19 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
In-Reply-To: <20170328052559.12912-1-aik@ozlabs.ru>
References: <20170328052559.12912-1-aik@ozlabs.ru>
Date: Tue, 04 Apr 2017 14:56:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871st834na.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The CMA pages migration code does not support compound pages at
> the moment so it performs few tests before proceeding to actual page
> migration.
>
> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
> it should be called on head pages. Since we also test for PageCompound(),
> and it contains PageTail(), we can simply move PageCompound() in front
> of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Some of actual POWER8 systems do crash on that BUG_ON.
> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index 497130c5c742..ba7fccf993b3 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -81,7 +81,7 @@ struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
>  	gfp_t gfp_mask = GFP_USER;
>  	struct page *new_page;
>
> -	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
> +	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))


A checked for compound page should be sufficient here, because a
Huge/TransHuge page is also marked compound. If we want to indicate that
we don't handle hugetlb and THP pages, we can write that as a comment ?



>  		return NULL;
>
>  	if (PageHighMem(page))
> @@ -100,7 +100,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
>  	LIST_HEAD(cma_migrate_pages);
>
>  	/* Ignore huge pages for now */
> -	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
> +	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
>  		return -EBUSY;
>
>  	lru_add_drain();
> -- 
> 2.11.0
