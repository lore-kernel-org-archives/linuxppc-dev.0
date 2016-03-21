Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTB655YLtzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 20:55:41 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Mon, 21 Mar 2016 05:55:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 503F36E8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 05:42:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2L9tZds27394142
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 09:55:35 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2L9tXN5017025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 05:55:34 -0400
Subject: Re: [RFC 6/9] powerpc/hugetlb: Enable ARCH_WANT_GENERAL_HUGETLB for
 BOOK3S 64K
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-6-git-send-email-khandual@linux.vnet.ibm.com>
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
Message-ID: <56EFC50E.6090901@linux.vnet.ibm.com>
Date: Mon, 21 Mar 2016 17:55:26 +0800
MIME-Version: 1.0
In-Reply-To: <1457525450-4262-6-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/9/16 8:10 PM, Anshuman Khandual wrote:
> This enables ARCH_WANT_GENERAL_HUGETLB for BOOK3S 64K in Kconfig.
> It also implements a new function 'pte_huge' which is required by
> function 'huge_pte_alloc' from generic VM. Existing BOOK3S 64K
> specific functions 'huge_pte_alloc' and 'huge_pte_offset' (which
> are no longer required) are removed with this change.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>   arch/powerpc/Kconfig                          |  4 ++
>   arch/powerpc/include/asm/book3s/64/hash-64k.h |  8 ++++
>   arch/powerpc/mm/hugetlbpage.c                 | 60 ---------------------------
>   3 files changed, 12 insertions(+), 60 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9faa18c..c6920bb 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -33,6 +33,10 @@ config HAVE_SETUP_PER_CPU_AREA
>   config NEED_PER_CPU_EMBED_FIRST_CHUNK
>   	def_bool PPC64
>
> +config ARCH_WANT_GENERAL_HUGETLB
> +	depends on PPC_64K_PAGES && PPC_BOOK3S_64
> +	def_bool y
> +
On the source code, the PowerPC specified huge_pte_alloc() function will 
not be defined if the configure logic is "!PPC_4K_PAGES && 
PPC_BOOK3S_64", but on the Kconfig file the general huge_pte_alloc() 
function will only be defined if the logic is "PPC_64K_PAGES && 
PPC_BOOK3S_64".

It works if PPC_4K_PAGES and PPC_64K_PAGES always against each other, 
but I also find PPC_16K_PAGES and PPC_256K_PAGES on the same Kconfig 
file. What happens if we configure PPC_16K_PAGES instead of PPC_4K_PAGES?

>   config NR_IRQS
>   	int "Number of virtual interrupt numbers"
>   	range 32 32768
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 849bbec..5e9b9b9 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -143,6 +143,14 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>    * Defined in such a way that we can optimize away code block at build time
>    * if CONFIG_HUGETLB_PAGE=n.
>    */
> +static inline int pte_huge(pte_t pte)
> +{
> +	/*
> +	 * leaf pte for huge page
> +	 */
> +	return !!(pte_val(pte) & _PAGE_PTE);
> +}
> +
>   static inline int pmd_huge(pmd_t pmd)
>   {
>   	/*
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index f834a74..f6e4712 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -59,42 +59,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>   	/* Only called for hugetlbfs pages, hence can ignore THP */
>   	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL, NULL);
>   }
> -#else
> -pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
> -{
> -	pgd_t pgd, *pgdp;
> -	pud_t pud, *pudp;
> -	pmd_t pmd, *pmdp;
> -
> -	pgdp = mm->pgd + pgd_index(addr);
> -	pgd  = READ_ONCE(*pgdp);
> -
> -	if (pgd_none(pgd))
> -		return NULL;
> -
> -	if (pgd_huge(pgd))
> -		return (pte_t *)pgdp;
> -
> -	pudp = pud_offset(&pgd, addr);
> -	pud  = READ_ONCE(*pudp);
> -	if (pud_none(pud))
> -		return NULL;
> -
> -	if (pud_huge(pud))
> -		return (pte_t *)pudp;
>
> -	pmdp = pmd_offset(&pud, addr);
> -	pmd  = READ_ONCE(*pmdp);
> -	if (pmd_none(pmd))
> -		return NULL;
> -
> -	if (pmd_huge(pmd))
> -		return (pte_t *)pmdp;
> -	return NULL;
> -}
> -#endif /* !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64) */
> -
> -#if !defined(CONFIG_PPC_64K_PAGES) || !defined(CONFIG_PPC_BOOK3S_64)
>   static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>   			   unsigned long address, unsigned pdshift, unsigned pshift)
>   {
> @@ -211,31 +176,6 @@ hugepd_search:
>
>   	return hugepte_offset(*hpdp, addr, pdshift);
>   }
> -
> -#else
> -pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
> -{
> -	pgd_t *pg;
> -	pud_t *pu;
> -	pmd_t *pm;
> -	unsigned pshift = __ffs(sz);
> -
> -	addr &= ~(sz-1);
> -	pg = pgd_offset(mm, addr);
> -
> -	if (pshift == PGDIR_SHIFT)	/* 16GB Huge Page */
> -		return (pte_t *)pg;
> -
> -	pu = pud_alloc(mm, pg, addr);	/* NA, skipped */
> -	if (pshift == PUD_SHIFT)
> -		return (pte_t *)pu;
> -
> -	pm = pmd_alloc(mm, pu, addr);	/* 16MB Huge Page */
> -	if (pshift == PMD_SHIFT)
> -		return (pte_t *)pm;
> -
> -	return NULL;
> -}
>   #endif
>   #else
>
Why these code need to be added on patch 4/9 but removed on 6/9?
