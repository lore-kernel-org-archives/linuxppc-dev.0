Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419fhc67Y4zF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 19:30:56 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5K9SqoG076369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:30:54 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqk3du2kp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:30:53 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 20 Jun 2018 05:30:53 -0400
Subject: Re: [PATCH V2] powerpc/mm: Initialize kernel pagetable memory for PTE
 fragments
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20180620092255.19393-1-khandual@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 20 Jun 2018 15:00:46 +0530
MIME-Version: 1.0
In-Reply-To: <20180620092255.19393-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6440f9eb-6b2d-bd8d-f9b7-8593873c9315@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2018 02:52 PM, Anshuman Khandual wrote:
> Kernel pagetable pages for PTE fragments never go through the standard init
> sequence which can cause inaccuracies in utilization statistics reported at
> places like /proc and /sysfs interfaces etc. Also the allocated page misses
> out on pagetable lock and page flag init as well. Fix it by making sure all
> pages allocated for either user process or kernel PTE fragments go through
> same initialization.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V2:
> 
> - Call the destructor function during free for all cases
> 
>   arch/powerpc/mm/pgtable-book3s64.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index c1f4ca4..a820ee6 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -335,23 +335,21 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
>   
>   static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>   {
> +	gfp_t gfp_mask = PGALLOC_GFP;
>   	void *ret = NULL;
>   	struct page *page;
>   
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
> +	if (!kernel)
> +		gfp_mask |= __GFP_ACCOUNT;
>   
> +	page = alloc_page(gfp_mask);
> +	if (!page)
> +		return NULL;
> +
> +	if (!pgtable_page_ctor(page)) {
> +		__free_page(page);
> +		return NULL;
> +	}
>   
>   	ret = page_address(page);
>   	/*
> @@ -391,8 +389,7 @@ void pte_fragment_free(unsigned long *table, int kernel)
>   	struct page *page = virt_to_page(table);
>   
>   	if (put_page_testzero(page)) {
> -		if (!kernel)
> -			pgtable_page_dtor(page);
> +		pgtable_page_dtor(page);
>   		free_unref_page(page);
>   	}
>   }
> 

If we really are going to do this, may be we can  do it as 
alloc_for_pmdcache, kill the kernel arg and compare against init_mm?

-aneesh
