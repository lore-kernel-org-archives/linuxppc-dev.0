Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix bad pmd error with book3E config
In-reply-to: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 15:48:15 +1000
Message-ID: <25129.1371620895@ale.ozlabs.ibm.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Book3E uses the hugepd at PMD level and don't encode pte directly
> at the pmd level. So it will find the lower bits of pmd set
> and the pmd_bad check throws error. Infact the current code
> will never take the free_hugepd_range call at all because it will
> clear the pmd if it find a hugepd pointer.
> 

Please explain what changes you are making.  Currently you are only
describing what the issue is.

Also include which the SHA1 which caused the regression (ie
e2b3d202d1dba8f3546ed28224ce485bc50010be "powerpc: Switch 16GB and 16MB
explicit hugepages to a different page table format")

Mikey

> Reported-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index f2f01fd..0d3d3ee 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -536,19 +536,26 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  	do {
>  		pmd = pmd_offset(pud, addr);
>  		next = pmd_addr_end(addr, end);
> -		if (pmd_none_or_clear_bad(pmd))
> -			continue;
> +		if (!is_hugepd(pmd)) {
> +			/*
> +			 * if it is not hugepd pointer, we should already find
> +			 * it cleared.
> +			 */
> +			if (!pmd_none_or_clear_bad(pmd))
> +				WARN_ON(1);

How often are we going to hit this?    Should this be a warn_on once or
even a bug_on?

Also just make it: 
  WARN_ON(!pmd_none_or_clear_bad(pmd))

Mikey

     

> +		} else {
>  #ifdef CONFIG_PPC_FSL_BOOK3E
> -		/*
> -		 * Increment next by the size of the huge mapping since
> -		 * there may be more than one entry at this level for a
> -		 * single hugepage, but all of them point to
> -		 * the same kmem cache that holds the hugepte.
> -		 */
> -		next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
> +			/*
> +			 * Increment next by the size of the huge mapping since
> +			 * there may be more than one entry at this level for a
> +			 * single hugepage, but all of them point to
> +			 * the same kmem cache that holds the hugepte.
> +			 */
> +			next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
>  #endif
> -		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
> -				  addr, next, floor, ceiling);
> +			free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
> +					  addr, next, floor, ceiling);
> +		}
>  	} while (addr = next, addr != end);
>  
>  	start &= PUD_MASK;
> -- 
> 1.8.1.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
