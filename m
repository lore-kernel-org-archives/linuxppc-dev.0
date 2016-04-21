Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr51b62XzzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 14:12:19 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id y69so8763345pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 21:12:19 -0700 (PDT)
Subject: Re: [PATCH V2 26/68] powerpc/mm/radix: Add radix pte defines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718531C.80903@gmail.com>
Date: Thu, 21 Apr 2016 14:12:12 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> This add PowerISA 3.0 specific pte defines. We share most of the
> details with hash linux page table format. This patch indicate only
> things where we differ
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h   |   1 +
>  arch/powerpc/include/asm/book3s/64/radix-4k.h  |  12 +++
>  arch/powerpc/include/asm/book3s/64/radix-64k.h |  12 +++
>  arch/powerpc/include/asm/book3s/64/radix.h     | 128 +++++++++++++++++++++++++
>  4 files changed, 153 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/radix-4k.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/radix-64k.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/radix.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 2643487affac..c47c3f7fc4e0 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -205,6 +205,7 @@ extern unsigned long __pgd_table_size;
>  #endif /* __ASSEMBLY__ */
>  
>  #include <asm/book3s/64/hash.h>
> +#include <asm/book3s/64/radix.h>
>  #include <asm/barrier.h>
>  
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
> new file mode 100644
> index 000000000000..1966ee977206
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
> @@ -0,0 +1,12 @@
> +#ifndef _ASM_POWERPC_PGTABLE_RADIX_4K_H
> +#define _ASM_POWERPC_PGTABLE_RADIX_4K_H
> +
> +/*
> + * For 4K page size supported index is 13/9/9/9
> + */
> +#define R_PTE_INDEX_SIZE  9  /* 2MB huge page */
> +#define R_PMD_INDEX_SIZE  9  /* 1G huge page */
> +#define R_PUD_INDEX_SIZE	 9
> +#define R_PGD_INDEX_SIZE  13
> +
> +#endif /* _ASM_POWERPC_PGTABLE_RADIX_4K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> new file mode 100644
> index 000000000000..fe1cebe55e01
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> @@ -0,0 +1,12 @@
> +#ifndef _ASM_POWERPC_PGTABLE_RADIX_64K_H
> +#define _ASM_POWERPC_PGTABLE_RADIX_64K_H
> +
> +/*
> + * For 64K page size supported index is 13/9/9/5
> + */
> +#define R_PTE_INDEX_SIZE  5  /* 2MB huge page */
> +#define R_PMD_INDEX_SIZE  9  /* 1G huge page */
> +#define R_PUD_INDEX_SIZE	 9
> +#define R_PGD_INDEX_SIZE  13
> +
> +#endif /* _ASM_POWERPC_PGTABLE_RADIX_64K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> new file mode 100644
> index 000000000000..72e18d5c96b4
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -0,0 +1,128 @@
> +#ifndef _ASM_POWERPC_PGTABLE_RADIX_H
> +#define _ASM_POWERPC_PGTABLE_RADIX_H
> +
> +#ifndef __ASSEMBLY__
> +#include <asm/cmpxchg.h>
> +#endif
> +
> +#ifdef CONFIG_PPC_64K_PAGES
> +#include <asm/book3s/64/radix-64k.h>
> +#else
> +#include <asm/book3s/64/radix-4k.h>
> +#endif
> +
> +/* An empty PTE can still have a R or C writeback */
> +#define R_PTE_NONE_MASK		(_PAGE_DIRTY | _PAGE_ACCESSED)
> +
> +/* Bits to set in a RPMD/RPUD/RPGD */
> +#define R_PMD_VAL_BITS		(0x8000000000000000UL | R_PTE_INDEX_SIZE)
> +#define R_PUD_VAL_BITS		(0x8000000000000000UL | R_PMD_INDEX_SIZE)
> +#define R_PGD_VAL_BITS		(0x8000000000000000UL | R_PUD_INDEX_SIZE)
> +
> +/* Don't have anything in the reserved bits and leaf bits */
> +#define R_PMD_BAD_BITS		0x60000000000000e0UL
> +#define R_PUD_BAD_BITS		0x60000000000000e0UL
> +#define R_PGD_BAD_BITS		0x60000000000000e0UL
> +
> +/*
> + * Size of EA range mapped by our pagetables.
> + */
> +#define R_PGTABLE_EADDR_SIZE (R_PTE_INDEX_SIZE + R_PMD_INDEX_SIZE +	\
> +			      R_PUD_INDEX_SIZE + R_PGD_INDEX_SIZE + PAGE_SHIFT)
> +#define R_PGTABLE_RANGE (ASM_CONST(1) << R_PGTABLE_EADDR_SIZE)
> +
> +#ifndef __ASSEMBLY__
> +#define R_PTE_TABLE_SIZE	(sizeof(pte_t) << R_PTE_INDEX_SIZE)
> +#define R_PMD_TABLE_SIZE	(sizeof(pmd_t) << R_PMD_INDEX_SIZE)
> +#define R_PUD_TABLE_SIZE	(sizeof(pud_t) << R_PUD_INDEX_SIZE)
> +#define R_PGD_TABLE_SIZE	(sizeof(pgd_t) << R_PGD_INDEX_SIZE)
> +
> +static inline unsigned long rpte_update(struct mm_struct *mm,
> +					unsigned long addr,
> +					pte_t *ptep, unsigned long clr,
> +					unsigned long set,
> +					int huge)
> +{
> +
> +	pte_t pte;
> +	unsigned long old_pte, new_pte;
> +
> +	do {
> +		pte = READ_ONCE(*ptep);
> +		old_pte = pte_val(pte);
> +		new_pte = (old_pte | set) & ~clr;
> +
> +	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
> +						       cpu_to_be64(old_pte),
> +						       cpu_to_be64(new_pte)));
> +	/* We already do a sync in cmpxchg, is ptesync needed ?*/
> +	asm volatile("ptesync" : : : "memory");

Yes, I think ptesync is required after PTE changes


> +	/* huge pages use the old page table lock */
> +	if (!huge)
> +		assert_pte_locked(mm, addr);

Are we passing huge, addr only for the assert? I think on most occasions huge is 0,
it is better to do it in the caller. It's probably worth refactoring at some point
for both types of *pte_update*

> +
> +	return old_pte;
> +}
> +
> +/*
> + * Set the dirty and/or accessed bits atomically in a linux PTE, this
> + * function doesn't need to invalidate tlb.
> + */
> +static inline void __rptep_set_access_flags(pte_t *ptep, pte_t entry)
> +{
> +	pte_t pte;
> +	unsigned long old_pte, new_pte;
> +	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
> +					      _PAGE_RW | _PAGE_EXEC);
> +	do {
> +		pte = READ_ONCE(*ptep);
> +		old_pte = pte_val(pte);
> +		new_pte = old_pte | set;
> +
> +	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
> +						       cpu_to_be64(old_pte),
> +						       cpu_to_be64(new_pte)));
> +	/* We already do a sync in cmpxchg, is ptesync needed ?*/
> +	asm volatile("ptesync" : : : "memory");

Can this be implemented as 
	rpte_update(ptep, 0, set) if we refactored the code to remove mm, addr and huge
Making the code more legible and will remove duplication of code.

> +}
> +
> +static inline int rpte_same(pte_t pte_a, pte_t pte_b)
> +{
> +	return ((pte_val(pte_a) == pte_val(pte_b)));
> +}
> +
> +static inline int rpte_none(pte_t pte)
> +{
> +	return (pte_val(pte) & ~R_PTE_NONE_MASK) == 0;
> +}
> +
> +static inline void __set_rpte_at(struct mm_struct *mm, unsigned long addr,
> +				 pte_t *ptep, pte_t pte, int percpu)
> +{
> +	*ptep = pte;

Do we need WRITE_ONCE? I guess not since we have ptesync below

> +	asm volatile("ptesync" : : : "memory");
> +}
> +
> +static inline int rpmd_bad(pmd_t pmd)
> +{
> +	return !!(pmd_val(pmd) & R_PMD_BAD_BITS);
> +}
> +
> +static inline int rpmd_same(pmd_t pmd_a, pmd_t pmd_b)
> +{
> +	return ((pmd_val(pmd_a) == pmd_val(pmd_b)));
> +}
> +
> +static inline int rpud_bad(pud_t pud)
> +{
> +	return !!(pud_val(pud) & R_PUD_BAD_BITS);
> +}
> +
> +
> +static inline int rpgd_bad(pgd_t pgd)
> +{
> +	return !!(pgd_val(pgd) & R_PGD_BAD_BITS);
> +}
> +
> +#endif /* __ASSEMBLY__ */
> +#endif
> 
