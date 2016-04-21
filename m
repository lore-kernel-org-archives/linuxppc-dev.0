Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrDbj4QP6zDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:53:53 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id e128so28458768pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 02:53:53 -0700 (PDT)
Subject: Re: [PATCH V2 29/68] powerpc/mm: Move hugetlb and THP related pmd
 accessors to pgtable.h
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718A328.10309@gmail.com>
Date: Thu, 21 Apr 2016 19:53:44 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Here we create pgtable-64/4k.h and move pmd accessors that is common
> between hash and radix there. We can't do much sharing with 4k linux
> page size [1]. So for now it is empty. In later patches we will add
> functions that does conditional hash/radix accessors there.
> 
> [1] 4k linux page size with hash config don't support THP.
					 does not
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h    | 83 ---------------------
>  arch/powerpc/include/asm/book3s/64/pgtable-4k.h  |  7 ++
>  arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 94 ++++++++++++++++++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h     |  7 ++
>  4 files changed, 108 insertions(+), 83 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index d60c431c96cb..173f35e9faef 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -118,57 +118,6 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
>  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
>  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
>  
> -#ifdef CONFIG_HUGETLB_PAGE
> -/*
> - * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
> - * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
> - *
> - * Defined in such a way that we can optimize away code block at build time
> - * if CONFIG_HUGETLB_PAGE=n.
> - */
> -static inline int pmd_huge(pmd_t pmd)
> -{
> -	/*
> -	 * leaf pte for huge page
> -	 */
> -	return !!(pmd_val(pmd) & _PAGE_PTE);
> -}
> -
> -static inline int pud_huge(pud_t pud)
> -{
> -	/*
> -	 * leaf pte for huge page
> -	 */
> -	return !!(pud_val(pud) & _PAGE_PTE);
> -}
> -
> -static inline int pgd_huge(pgd_t pgd)
> -{
> -	/*
> -	 * leaf pte for huge page
> -	 */
> -	return !!(pgd_val(pgd) & _PAGE_PTE);
> -}
> -#define pgd_huge pgd_huge
> -
> -#ifdef CONFIG_DEBUG_VM
> -extern int hugepd_ok(hugepd_t hpd);
> -#define is_hugepd(hpd)               (hugepd_ok(hpd))
> -#else
> -/*
> - * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
> - * need to setup hugepage directory for them. Our pte and page directory format
> - * enable us to have this enabled.
> - */
> -static inline int hugepd_ok(hugepd_t hpd)
> -{
> -	return 0;
> -}
> -#define is_hugepd(pdep)			0
> -#endif /* CONFIG_DEBUG_VM */
> -
> -#endif /* CONFIG_HUGETLB_PAGE */
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
>  					 unsigned long addr,
> @@ -239,44 +188,12 @@ static inline int pmd_trans_huge(pmd_t pmd)
>  		  (_PAGE_PTE | H_PAGE_THP_HUGE));
>  }
>  
> -static inline int pmd_large(pmd_t pmd)
> -{
> -	return !!(pmd_val(pmd) & _PAGE_PTE);
> -}
> -
> -static inline pmd_t pmd_mknotpresent(pmd_t pmd)
> -{
> -	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
> -}
> -
>  #define __HAVE_ARCH_PMD_SAME
>  static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
>  {
>  	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
>  }
>  
> -static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
> -					      unsigned long addr, pmd_t *pmdp)
> -{
> -	unsigned long old;
> -
> -	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
> -		return 0;
> -	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
> -	return ((old & _PAGE_ACCESSED) != 0);
> -}
> -
> -#define __HAVE_ARCH_PMDP_SET_WRPROTECT
> -static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
> -				      pmd_t *pmdp)
> -{
> -
> -	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
> -		return;
> -
> -	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
> -}
> -
>  #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif	/* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> new file mode 100644
> index 000000000000..423735f897f5
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> @@ -0,0 +1,7 @@
> +#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H
> +#define _ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H
> +/*
> + * hash 4k can't share hugetlb and also doesn't support THP
> + */
> +
> +#endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> new file mode 100644
> index 000000000000..ceadc2fd408f
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> @@ -0,0 +1,94 @@
> +#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
> +#define _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
> +
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_HUGETLB_PAGE
> +/*
> + * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
PGD_INDEX_SIZE
> + * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
> + *
> + * Defined in such a way that we can optimize away code block at build time
> + * if CONFIG_HUGETLB_PAGE=n.
> + */
> +static inline int pmd_huge(pmd_t pmd)
> +{
> +	/*
> +	 * leaf pte for huge page
> +	 */
> +	return !!(pmd_val(pmd) & _PAGE_PTE);
> +}
> +
> +static inline int pud_huge(pud_t pud)
> +{
> +	/*
> +	 * leaf pte for huge page
> +	 */
> +	return !!(pud_val(pud) & _PAGE_PTE);
> +}
> +
> +static inline int pgd_huge(pgd_t pgd)
> +{
> +	/*
> +	 * leaf pte for huge page
> +	 */
> +	return !!(pgd_val(pgd) & _PAGE_PTE);
> +}
> +#define pgd_huge pgd_huge
> +

??
<snip>

Balbir Singh.
