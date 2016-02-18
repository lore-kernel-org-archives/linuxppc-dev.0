Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 350A41A048F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 15:45:40 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id fy10so23661338pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:45:40 -0800 (PST)
Subject: Re: [PATCH V6 05/35] powerpc/mm: Move hash specific pte width and
 other defines to book3s
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, Denis Kirjanov <kda@linux-powerpc.org>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56C54C6B.2000401@gmail.com>
Date: Thu, 18 Feb 2016 15:45:31 +1100
MIME-Version: 1.0
In-Reply-To: <1448941020-15168-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/12/15 14:36, Aneesh Kumar K.V wrote:
> This further make a copy of pte defines to book3s/64/hash*.h. This
> remove the dependency on pgtable-ppc64-4k.h and pgtable-ppc64-64k.h
>
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 86 ++++++++++++++++++++++++++-
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 46 +++++++++++++-
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  6 +-
>  3 files changed, 129 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index c134e809aac3..f2c51cd61f69 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -1,4 +1,51 @@
> -/* To be include by pgtable-hash64.h only */
> +#ifndef _ASM_POWERPC_BOOK3S_64_HASH_4K_H
> +#define _ASM_POWERPC_BOOK3S_64_HASH_4K_H
> +/*
> + * Entries per page directory level.  The PTE level must use a 64b record
> + * for each page table entry.  The PMD and PGD level use a 32b record for
> + * each entry by assuming that each entry is page aligned.
> + */

More clarity on this please
> +#define PTE_INDEX_SIZE  9
> +#define PMD_INDEX_SIZE  7
> +#define PUD_INDEX_SIZE  9
> +#define PGD_INDEX_SIZE  9
> +
We use 9+7+9+9+(12) bits?
> +#ifndef __ASSEMBLY__
> +#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
> +#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
> +#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
> +#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
> +#endif	/* __ASSEMBLY__ */
> +
> +#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
> +#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> +#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
> +#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
> +
> +/* PMD_SHIFT determines what a second-level page table entry can map */
> +#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
> +#define PMD_SIZE	(1UL << PMD_SHIFT)
> +#define PMD_MASK	(~(PMD_SIZE-1))
> +
> +/* With 4k base page size, hugepage PTEs go at the PMD level */
> +#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
> +
> +/* PUD_SHIFT determines what a third-level page table entry can map */
> +#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
> +#define PUD_SIZE	(1UL << PUD_SHIFT)
> +#define PUD_MASK	(~(PUD_SIZE-1))
> +
> +/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
> +#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
> +#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
> +#define PGDIR_MASK	(~(PGDIR_SIZE-1))
> +
> +/* Bits to mask out from a PMD to get to the PTE page */
> +#define PMD_MASKED_BITS		0
> +/* Bits to mask out from a PUD to get to the PMD page */
> +#define PUD_MASKED_BITS		0
> +/* Bits to mask out from a PGD to get to the PUD page */
> +#define PGD_MASKED_BITS		0
>  
Don't get why these are all 0?
>  /* PTE bits */
>  #define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
> @@ -15,3 +62,40 @@
>  /* shift to put page number into pte */
>  #define PTE_RPN_SHIFT	(17)
>  
> +#ifndef __ASSEMBLY__
> +/*
> + * 4-level page tables related bits
> + */
> +
> +#define pgd_none(pgd)		(!pgd_val(pgd))
> +#define pgd_bad(pgd)		(pgd_val(pgd) == 0)
> +#define pgd_present(pgd)	(pgd_val(pgd) != 0)
> +#define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
> +#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
> +
> +static inline pte_t pgd_pte(pgd_t pgd)
> +{
> +	return __pte(pgd_val(pgd));
> +}
> +
> +static inline pgd_t pte_pgd(pte_t pte)
> +{
> +	return __pgd(pte_val(pte));
> +}
> +extern struct page *pgd_page(pgd_t pgd);
> +
> +#define pud_offset(pgdp, addr)	\
> +  (((pud_t *) pgd_page_vaddr(*(pgdp))) + \
> +    (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
> +


> +#define pud_ERROR(e) \
> +	pr_err("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
> +
> +/*
> + * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range() */
> +#define remap_4k_pfn(vma, addr, pfn, prot)	\
> +	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 4f4ec2ab45c9..ee073822145d 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -1,4 +1,35 @@
> -/* To be include by pgtable-hash64.h only */
> +#ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
> +#define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
> +
> +#include <asm-generic/pgtable-nopud.h>
> +
> +#define PTE_INDEX_SIZE  8
> +#define PMD_INDEX_SIZE  10
> +#define PUD_INDEX_SIZE	0
> +#define PGD_INDEX_SIZE  12
> +

OK.. So there is PGD but no PUD?
> +#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
> +#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> +#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
> +
> +/* With 4k base page size, hugepage PTEs go at the PMD level */
> +#define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
> +

Typo, refers to 4k base page size.

> +/* PMD_SHIFT determines what a second-level page table entry can map */
> +#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
> +#define PMD_SIZE	(1UL << PMD_SHIFT)
> +#define PMD_MASK	(~(PMD_SIZE-1))
> +
> +/* PGDIR_SHIFT determines what a third-level page table entry can map */
> +#define PGDIR_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
> +#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
> +#define PGDIR_MASK	(~(PGDIR_SIZE-1))
> +
> +/* Bits to mask out from a PMD to get to the PTE page */
> +/* PMDs point to PTE table fragments which are 4K aligned.  */
> +#define PMD_MASKED_BITS		0xfff
> +/* Bits to mask out from a PGD/PUD to get to the PMD page */
> +#define PUD_MASKED_BITS		0x1ff
>  
>  /* Additional PTE bits (don't change without checking asm in hash_low.S) */
>  #define _PAGE_SPECIAL	0x00000400 /* software: special page */
> @@ -74,8 +105,8 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  #define __rpte_to_pte(r)	((r).pte)
>  #define __rpte_sub_valid(rpte, index) \
>  	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
> -
> -/* Trick: we set __end to va + 64k, which happens works for
> +/*
> + * Trick: we set __end to va + 64k, which happens works for
>   * a 16M page as well as we want only one iteration
>   */
>  #define pte_iterate_hashed_subpages(rpte, psize, vpn, index, shift)	\
> @@ -99,4 +130,13 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
>  			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
>  
> +#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
> +#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
> +#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
> +
> +#define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
> +#define pte_pgd(pte)	((pgd_t)pte_pud(pte))
> +
>  #endif	/* __ASSEMBLY__ */
> +
> +#endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index cdd5284d9eaa..2741ac6fbd3d 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -5,11 +5,7 @@
>   * the ppc64 hashed page table.
>   */
>  
> -#ifdef CONFIG_PPC_64K_PAGES
> -#include <asm/pgtable-ppc64-64k.h>
> -#else
> -#include <asm/pgtable-ppc64-4k.h>
> -#endif
> +#include <asm/book3s/64/hash.h>
>  #include <asm/barrier.h>
>  
>  #define FIRST_USER_ADDRESS	0UL
