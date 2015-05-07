Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15E321A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 18:17:53 +1000 (AEST)
Message-ID: <1430986646.3453.34.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/mm: Return NULL for not present hugetlb page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 07 May 2015 18:17:26 +1000
In-Reply-To: <1430982981-23700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1430982981-23700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-07 at 12:46 +0530, Aneesh Kumar K.V wrote:
> We need to check whether pte is present in follow_huge_addr and
> properly return NULL if mapping is not present. Also use READ_ONCE
> when dereferencing pte_t address.

Do that need to go to stable as well ?

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 0ce968b00b7c..f5688423bc69 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -689,27 +689,34 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  struct page *
>  follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
>  {
> -	pte_t *ptep;
> -	struct page *page;
> +	pte_t *ptep, pte;
>  	unsigned shift;
>  	unsigned long mask, flags;
> +	struct page *page = ERR_PTR(-EINVAL);
> +
> +	local_irq_save(flags);
> +	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
> +	if (!ptep)
> +		goto no_page;
> +	pte = READ_ONCE(*ptep);
>  	/*
> +	 * Verify it is a huge page else bail.
>  	 * Transparent hugepages are handled by generic code. We can skip them
>  	 * here.
>  	 */
> -	local_irq_save(flags);
> -	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
> +	if (!shift || pmd_trans_huge((pmd_t)pte))
> +		goto no_page;
>  
> -	/* Verify it is a huge page else bail. */
> -	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep)) {
> -		local_irq_restore(flags);
> -		return ERR_PTR(-EINVAL);
> +	if (!pte_present(pte)) {
> +		page = NULL;
> +		goto no_page;
>  	}
>  	mask = (1UL << shift) - 1;
> -	page = pte_page(*ptep);
> +	page = pte_page(pte);
>  	if (page)
>  		page += (address & mask) / PAGE_SIZE;
>  
> +no_page:
>  	local_irq_restore(flags);
>  	return page;
>  }
