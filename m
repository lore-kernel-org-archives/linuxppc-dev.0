Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D386DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:35:17 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id lBK4Z87A018465
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:35:08 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBK4bYO2170214
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:37:35 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBK4XgGg002628
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:33:42 +1100
Date: Thu, 20 Dec 2007 15:33:24 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: add hugepagesz boot-time parameter
Message-ID: <20071220043324.GA29058@localhost.localdomain>
References: <47699CC3.1050909@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47699CC3.1050909@linux.vnet.ibm.com>
Cc: mel@csn.ul.ie, linuxppc-dev <linuxppc-dev@ozlabs.org>, csnook@redhat.com,
	Paul Mackerras <paulus@samba.org>, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 04:35:47PM -0600, Jon Tollefson wrote:
> Paul, please include this in 2.6.25 if there are no objections.
> 
> This patch adds the hugepagesz boot-time parameter for ppc64.  It lets
> one pick the size for huge pages. The choices available are 64K and 16M
> when the base page size is 4k. It defaults to 16M (previously the only
> only choice) if nothing or an invalid choice is specified.
> 
> Tested 64K huge pages successfully with the libhugetlbfs 1.2.
> 
> Changes from v1:
>     disallow 64K huge pages when base page size is 64K since we can't
> distinguish between
>         base and huge pages when doing a hash_page()
>     collapsed pmd_offset and pmd_alloc to inline calls to simplify the
> main code
>     removed printing of the huge page size in mm/hugetlb.c since this
> information is already
>        available in /proc/meminfo and leaves the remaining changes all
> powerpc specific

[snip]
> @@ -82,11 +81,31 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>  	return 0;
>  }
>  
> +#ifndef CONFIG_PPC_64K_PAGES
> +static inline
> +pmd_t *hpmd_offset(pud_t *pud, unsigned long addr)
> +{
> +	if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
> +		return pmd_offset(pud, addr);
> +	else
> +		return (pmd_t *) pud;
> +}
> +static inline
> +pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr)
> +{
> +	if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
> +		return pmd_alloc(mm, pud, addr);
> +	else
> +		return (pmd_t *) pud;
> +}
> +#endif
> +

I'm baffled by this section of code; I can't see how it can work
properly with 64k base page size.  hpmd_offset() and hpmd_alloc() are
only defined if the base page size is 4k, but they appear to be used
unconditionally in huge_pte_offset() and huge_pte_alloc() (since you
remove the #ifdef that was there).

>  /* Modelled after find_linux_pte() */
>  pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t *pg;
>  	pud_t *pu;
> +	pmd_t *pm;
>  
>  	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
>  
> @@ -96,14 +115,9 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>  	if (!pgd_none(*pg)) {
>  		pu = pud_offset(pg, addr);
>  		if (!pud_none(*pu)) {
> -#ifdef CONFIG_PPC_64K_PAGES
> -			pmd_t *pm;
> -			pm = pmd_offset(pu, addr);
> +			pm = hpmd_offset(pu, addr);
>  			if (!pmd_none(*pm))
>  				return hugepte_offset((hugepd_t *)pm, addr);
> -#else
> -			return hugepte_offset((hugepd_t *)pu, addr);
> -#endif
>  		}
>  	}
>  
> @@ -114,6 +128,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t *pg;
>  	pud_t *pu;
> +	pmd_t *pm;
>  	hugepd_t *hpdp = NULL;
>  
>  	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
> @@ -124,14 +139,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
>  	pu = pud_alloc(mm, pg, addr);
>  
>  	if (pu) {
> -#ifdef CONFIG_PPC_64K_PAGES
> -		pmd_t *pm;
> -		pm = pmd_alloc(mm, pu, addr);
> +		pm = hpmd_alloc(mm, pu, addr);
>  		if (pm)
>  			hpdp = (hugepd_t *)pm;
> -#else
> -		hpdp = (hugepd_t *)pu;
> -#endif
>  	}
>  
>  	if (! hpdp)

[snip]
> diff --git a/include/asm-powerpc/pgtable.h b/include/asm-powerpc/pgtable.h
> index d18ffe7..66ff7e5 100644
> --- a/include/asm-powerpc/pgtable.h
> +++ b/include/asm-powerpc/pgtable.h
> @@ -37,6 +37,12 @@ extern void paging_init(void);
>  #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
>  		remap_pfn_range(vma, vaddr, pfn, size, prot)
>  
> +/* Base page size affects how we walk hugetlb page tables */
> +#ifdef CONFIG_PPC_64K_PAGES
> +#define hpmd_offset(pud, addr)		pmd_offset(pud, addr)
> +#define hpmd_alloc(mm, pud, addr)	pmd_alloc(mm, pud, addr)
> +#endif

These functions are only used in hugetlbpage.c, I don't see any reason
they should go in the header file.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
