Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GjWB4zbjzF3PV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 15:55:34 +1000 (AEST)
Subject: Re: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180920180947.17893-1-aneesh.kumar@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <71b953af-5063-2440-62aa-9c3a7a738dc6@c-s.fr>
Date: Fri, 21 Sep 2018 07:55:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180920180947.17893-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/09/2018 à 20:09, Aneesh Kumar K.V a écrit :
> With this patch we use 0x8000000000000000UL (_PAGE_PRESENT) to indicate a valid
> pgd/pud/pmd entry. We also switch the p**_present() to look at this bit.
> 
> With pmd_present, we have a special case. We need to make sure we consider a
> pmd marked invalid during THP split as present. Right now we clear the
> _PAGE_PRESENT bit during a pmdp_invalidate. Inorder to consider this special
> case we add a new pte bit _PAGE_INVALID (mapped to _RPAGE_SW0). This bit is
> only used with _PAGE_PRESENT cleared. Hence we are not really losing a pte bit
> for this special case. pmd_present is also updated to look at _PAGE_INVALID.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/hash.h    |  5 +++++
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 14 +++++++++++---
>   arch/powerpc/mm/hash_utils_64.c              |  6 +++---
>   arch/powerpc/mm/pgtable-book3s64.c           |  8 ++++++--
>   arch/powerpc/mm/pgtable.c                    |  7 +++----
>   5 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index d52a51b2ce7b..fcf8b10a209f 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -18,6 +18,11 @@
>   #include <asm/book3s/64/hash-4k.h>
>   #endif
>   
> +/* Bits to set in a PMD/PUD/PGD entry valid bit*/
> +#define HASH_PMD_VAL_BITS		(0x8000000000000000UL)
> +#define HASH_PUD_VAL_BITS		(0x8000000000000000UL)
> +#define HASH_PGD_VAL_BITS		(0x8000000000000000UL)
> +
>   /*
>    * Size of EA range mapped by our pagetables.
>    */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 13a688fc8cd0..8feb4a3240d5 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -875,8 +875,16 @@ static inline int pmd_none(pmd_t pmd)
>   
>   static inline int pmd_present(pmd_t pmd)
>   {
> +	/*
> +	 * A pmd is considerent present if _PAGE_PRESENT is set.
> +	 * We also need to consider the pmd present which is marked
> +	 * invalid during a split. Hence we look for _PAGE_INVALID
> +	 * if we find _PAGE_PRESENT cleared.
> +	 */
> +	if (pmd_raw(pmd) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID))
> +		return true;
>   
> -	return !pmd_none(pmd);
> +	return false;
>   }
>   
>   static inline int pmd_bad(pmd_t pmd)
> @@ -903,7 +911,7 @@ static inline int pud_none(pud_t pud)
>   
>   static inline int pud_present(pud_t pud)
>   {
> -	return !pud_none(pud);
> +	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
>   }
>   
>   extern struct page *pud_page(pud_t pud);
> @@ -950,7 +958,7 @@ static inline int pgd_none(pgd_t pgd)
>   
>   static inline int pgd_present(pgd_t pgd)
>   {
> -	return !pgd_none(pgd);
> +	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>   }
>   
>   static inline pte_t pgd_pte(pgd_t pgd)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 88c95dc8b141..13ba718c9680 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1001,9 +1001,9 @@ void __init hash__early_init_mmu(void)
>   	 * 4k use hugepd format, so for hash set then to
>   	 * zero
>   	 */
> -	__pmd_val_bits = 0;
> -	__pud_val_bits = 0;
> -	__pgd_val_bits = 0;
> +	__pmd_val_bits = HASH_PMD_VAL_BITS;
> +	__pud_val_bits = HASH_PUD_VAL_BITS;
> +	__pgd_val_bits = HASH_PGD_VAL_BITS;
>   
>   	__kernel_virt_start = H_KERN_VIRT_START;
>   	__kernel_virt_size = H_KERN_VIRT_SIZE;
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 01d7c0f7c4f0..654000da8b15 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -69,7 +69,11 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>   		pmd_t *pmdp, pmd_t pmd)
>   {
>   #ifdef CONFIG_DEBUG_VM
> -	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
> +	/*
> +	 * Make sure hardware valid bit is not set. We don't do
> +	 * tlb flush for this update.
> +	 */
> +	WARN_ON(pte_val(pmd_pte(*pmdp)) & _PAGE_PRESENT);
>   	assert_spin_locked(pmd_lockptr(mm, pmdp));
>   	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
>   #endif
> @@ -106,7 +110,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>   {
>   	unsigned long old_pmd;
>   
> -	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
> +	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
>   	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>   	/*
>   	 * This ensures that generic code that rely on IRQ disabling
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index d71c7777669c..aee04b209b51 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -188,11 +188,10 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>   		pte_t pte)
>   {
>   	/*
> -	 * When handling numa faults, we already have the pte marked
> -	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
> -	 * Hence we can use set_pte_at for them.
> +	 * Make sure hardware valid bit is not set. We don't do
> +	 * tlb flush for this update.
>   	 */
> -	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
> +	VM_WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);

Why not using pte_present() anymore ?

Also, you are removing the pte_protnone() check, won't it change the 
behaviour ?

If we can't use pte_present(), can we create a new helper for that 
(allthough _PAGE_PRESENT exists on all platforms).

Christophe


>   
>   	/* Add the pte bit when trying to set a pte */
>   	pte = __pte(pte_val(pte) | _PAGE_PTE);
> 
