Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2RX04QBbzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 13:42:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v653dPKH033832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 23:42:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bg9tq4fkc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 23:42:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 21:42:19 -0600
Subject: Re: [RFC] powerpc/mm: Enable gigantic HugeTLB page support for powernv
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170704104608.22397-1-khandual@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 09:12:08 +0530
MIME-Version: 1.0
In-Reply-To: <20170704104608.22397-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9daa97d2-b0a7-6416-c6c5-28e6dbc727ef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 July 2017 04:16 PM, Anshuman Khandual wrote:
> All the functionality for memblock allocation during boot was
> already present in Book3e and embeded platforms. This change
> just moves around some code under config conditions to make
> the function happen on powernv platforms.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Tested lightly on both powernv and pseries platforms with two
> 16GB pages. Will appreciate comments and suggestions on the
> approach.
> 
> On PowerNV while asking for 16GB pages through kernel command
> line, we need to be careful not to starve the system of memory
> which can make it unable to boot.

I have a patch series that does this here. How is this different ?

http://mid.gmane.org/1496327441-7368-1-git-send-email- 
aneesh.kumar@linux.vnet.ibm.com




> 
>   arch/powerpc/include/asm/hugetlb.h |  2 +-
>   arch/powerpc/mm/hash_utils_64.c    |  8 ++---
>   arch/powerpc/mm/hugetlbpage.c      | 66 ++++++++++++++++++++------------------
>   3 files changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 7f4025a..b0c1464 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -224,7 +224,7 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
>    * the .dts as on IBM platforms.
>    */
>   #if defined(CONFIG_HUGETLB_PAGE) && (defined(CONFIG_PPC_FSL_BOOK3E) || \
> -    defined(CONFIG_PPC_8xx))
> +    defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_POWERNV))
>   extern void __init reserve_hugetlb_gpages(void);
>   #else
>   static inline void reserve_hugetlb_gpages(void)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index a3f1e7d..7862fdb 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -473,7 +473,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
>   	return 1;
>   }
> 
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE) && !defined(CONFIG_PPC_POWERNV)
>   /* Scan for 16G memory blocks that have been set aside for huge pages
>    * and reserve those blocks for 16G huge pages.
>    */
> @@ -513,7 +513,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
>   	}
>   	return 0;
>   }
> -#endif /* CONFIG_HUGETLB_PAGE */
> +#endif /* CONFIG_HUGETLB_PAGE && !CONFIG_PPC_POWERNV*/
> 
>   static void mmu_psize_set_default_penc(void)
>   {
> @@ -566,10 +566,10 @@ static void __init htab_scan_page_sizes(void)
>   		       sizeof(mmu_psize_defaults_gp));
>   	}
> 
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE) && !defined(CONFIG_PPC_POWERNV)
>   	/* Reserve 16G huge page memory sections for huge pages */
>   	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
> -#endif /* CONFIG_HUGETLB_PAGE */
> +#endif /* CONFIG_HUGETLB_PAGE && !CONFIG_PPC_POWERNV */
>   }
> 
>   /*
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a4f33de..be0be5d 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -258,6 +258,40 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
> 
>   	return 1;
>   }
> +#else /* !PPC_FSL_BOOK3E */
> +
> +/* Build list of addresses of gigantic pages.  This function is used in early
> + * boot before the buddy allocator is setup.
> + */
> +void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages)
> +{
> +	if (!addr)
> +		return;
> +	while (number_of_pages > 0) {
> +		gpage_freearray[nr_gpages] = addr;
> +		nr_gpages++;
> +		number_of_pages--;
> +		addr += page_size;
> +	}
> +}
> +
> +/* Moves the gigantic page addresses from the temporary list to the
> + * huge_boot_pages list.
> + */
> +int alloc_bootmem_huge_page(struct hstate *hstate)
> +{
> +	struct huge_bootmem_page *m;
> +	if (nr_gpages == 0)
> +		return 0;
> +	m = phys_to_virt(gpage_freearray[--nr_gpages]);
> +	gpage_freearray[nr_gpages] = 0;
> +	list_add(&m->list, &huge_boot_pages);
> +	m->hstate = hstate;
> +	return 1;
> +}
> +#endif
> +
> +#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_POWERNV)
>   /*
>    * Scan the command line hugepagesz= options for gigantic pages; store those in
>    * a list that we use to allocate the memory once all options are parsed.
> @@ -339,38 +373,6 @@ void __init reserve_hugetlb_gpages(void)
>   		add_gpage(base, size, gpage_npages[i]);
>   	}
>   }
> -
> -#else /* !PPC_FSL_BOOK3E */
> -
> -/* Build list of addresses of gigantic pages.  This function is used in early
> - * boot before the buddy allocator is setup.
> - */
> -void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages)
> -{
> -	if (!addr)
> -		return;
> -	while (number_of_pages > 0) {
> -		gpage_freearray[nr_gpages] = addr;
> -		nr_gpages++;
> -		number_of_pages--;
> -		addr += page_size;
> -	}
> -}
> -
> -/* Moves the gigantic page addresses from the temporary list to the
> - * huge_boot_pages list.
> - */
> -int alloc_bootmem_huge_page(struct hstate *hstate)
> -{
> -	struct huge_bootmem_page *m;
> -	if (nr_gpages == 0)
> -		return 0;
> -	m = phys_to_virt(gpage_freearray[--nr_gpages]);
> -	gpage_freearray[nr_gpages] = 0;
> -	list_add(&m->list, &huge_boot_pages);
> -	m->hstate = hstate;
> -	return 1;
> -}
>   #endif
> 
>   #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
> 
