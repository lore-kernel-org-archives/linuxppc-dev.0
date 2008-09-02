Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6645EDDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 22:44:52 +1000 (EST)
Date: Tue, 2 Sep 2008 13:44:42 +0100
From: Mel Gorman <mel@csn.ul.ie>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>,
	libhugetlbfs-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
Message-ID: <20080902124442.GD29766@csn.ul.ie>
References: <20080902050510.GB12965@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080902050510.GB12965@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (02/09/08 15:05), David Gibson didst pronounce:
> When BenH and I were looking at the new code for handling 16G pages,
> we noticed a small bug.  It doesn't actually break anything user
> visible, but it's certainly not the way things are supposed to be.
> The 16G patches didn't update the huge_pte_offset() and
> huge_pte_alloc() functions, which means that the hugepte tables for
> 16G pages will be allocated much further down the page table tree than
> they should be - allocating several levels of page table with a single
> entry in them along the way.
> 
> The patch below is supposed to fix this, cleaning up the existing
> handling of 64k vs 16M pages while its at it.  However, it needs some
> testing.
> 

Actually, Jon has been hitting an occasional pagetable lock related
problem. The last theory was that it might be some sort of race but it's
vaguely possible that this is the issue. Jon?

> I've checked that it doesn't break existing 16M support, either with
> 4k or 64k base pages.  I haven't figured out how to test with 64k
> pages yet, at least until the multisize support goes into
> libhugetlbfs. 

Mount a 64K point yourself and then set HUGETLB_PATH?

> For 16G pages, I just don't have access to a machine
> with enough memory to test.  Jon, presumably you must have found such
> a machine when you did the 16G page support in the first place.  Do
> you still have access, and can you test this patch?
> 
> Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2008-09-02 13:39:52.000000000 +1000
> +++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2008-09-02 14:08:56.000000000 +1000
> @@ -128,29 +128,37 @@ static int __hugepte_alloc(struct mm_str
>  	return 0;
>  }
>  
> -/* Base page size affects how we walk hugetlb page tables */
> -#ifdef CONFIG_PPC_64K_PAGES
> -#define hpmd_offset(pud, addr, h)	pmd_offset(pud, addr)
> -#define hpmd_alloc(mm, pud, addr, h)	pmd_alloc(mm, pud, addr)
> -#else
> -static inline
> -pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
> +
> +static pud_t *hpud_offset(pgd_t *pgd, unsigned long addr, struct hstate *hstate)
> +{
> +	if (huge_page_shift(hstate) < PUD_SHIFT)
> +		return pud_offset(pgd, addr);
> +	else
> +		return (pud_t *) pgd;
> +}
> +static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
> +			 struct hstate *hstate)
>  {
> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
> +	if (huge_page_shift(hstate) < PUD_SHIFT)
> +		return pud_alloc(mm, pgd, addr);
> +	else
> +		return (pud_t *) pgd;
> +}
> +static pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
> +{
> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>  		return pmd_offset(pud, addr);
>  	else
>  		return (pmd_t *) pud;
>  }
> -static inline
> -pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> -		  struct hstate *hstate)
> +static pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> +			 struct hstate *hstate)
>  {
> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>  		return pmd_alloc(mm, pud, addr);
>  	else
>  		return (pmd_t *) pud;
>  }
> -#endif
>  
>  /* Build list of addresses of gigantic pages.  This function is used in early
>   * boot before the buddy or bootmem allocator is setup.
> @@ -204,7 +212,7 @@ pte_t *huge_pte_offset(struct mm_struct 
>  
>  	pg = pgd_offset(mm, addr);
>  	if (!pgd_none(*pg)) {
> -		pu = pud_offset(pg, addr);
> +		pu = hpud_offset(pg, addr, hstate);
>  		if (!pud_none(*pu)) {
>  			pm = hpmd_offset(pu, addr, hstate);
>  			if (!pmd_none(*pm))
> @@ -233,7 +241,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
>  	addr &= hstate->mask;
>  
>  	pg = pgd_offset(mm, addr);
> -	pu = pud_alloc(mm, pg, addr);
> +	pu = hpud_alloc(mm, pg, addr, hstate);
>  
>  	if (pu) {
>  		pm = hpmd_alloc(mm, pu, addr, hstate);
> 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Libhugetlbfs-devel mailing list
> Libhugetlbfs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/libhugetlbfs-devel
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
