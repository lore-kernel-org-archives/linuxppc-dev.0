Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B30CD1A048F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 15:58:32 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id e127so24260450pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:58:32 -0800 (PST)
Subject: Re: [PATCH V6 07/35] powerpc/mm: Don't have generic headers introduce
 functions touching pte bits
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, Denis Kirjanov <kda@linux-powerpc.org>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56C54F70.9050903@gmail.com>
Date: Thu, 18 Feb 2016 15:58:24 +1100
MIME-Version: 1.0
In-Reply-To: <1448941020-15168-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> We are going to drop pte_common.h in the later patch. The idea is to
> enable hash code not require to define all PTE bits. Having PTE bits
> defined in pte_common.h made the code unnecessarily complex.
>
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/pgtable.h          | 176 +++++++++++++++++++
>  .../include/asm/{pgtable.h => pgtable-book3e.h}    |  96 +----------
>  arch/powerpc/include/asm/pgtable.h                 | 192 +--------------------
>  3 files changed, 185 insertions(+), 279 deletions(-)
>  copy arch/powerpc/include/asm/{pgtable.h => pgtable-book3e.h} (70%)
>
> diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
> index 3818cc7bc9b7..fa270cfcf30a 100644
> --- a/arch/powerpc/include/asm/book3s/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/pgtable.h
> @@ -8,4 +8,180 @@
>  #endif
>  
>  #define FIRST_USER_ADDRESS	0UL
> +#ifndef __ASSEMBLY__
> +
> +/* Generic accessors to PTE bits */
> +static inline int pte_write(pte_t pte)
> +{
> +	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO;
> +}
> +static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
> +static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
> +static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
> +static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
> +static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +/*
> + * These work without NUMA balancing but the kernel does not care. See the
> + * comment in include/asm-generic/pgtable.h . On powerpc, this will only
> + * work for user pages and always return true for kernel pages.
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +	return (pte_val(pte) &
> +		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
> +}
> +
> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +	return pte_protnone(pmd_pte(pmd));
> +}
> +#endif /* CONFIG_NUMA_BALANCING */
> +
> +static inline int pte_present(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_PRESENT;
> +}
> +
> +/* Conversion functions: convert a page and protection to a page entry,
Typo.. comment style, comment starts on the same line for multi-block comments?
> + * and a page entry and page directory to the page they refer to.
> + *
> + * Even if PTEs can be unsigned long long, a PFN is always an unsigned
> + * long for now.
> + */
> +static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
> +	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
> +		     pgprot_val(pgprot)); }
> +static inline unsigned long pte_pfn(pte_t pte)	{
> +	return pte_val(pte) >> PTE_RPN_SHIFT; }
> +
> +/* Generic modifiers for PTE bits */
> +static inline pte_t pte_wrprotect(pte_t pte) {
> +	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE);
> +	pte_val(pte) |= _PAGE_RO; return pte; }
> +static inline pte_t pte_mkclean(pte_t pte) {
> +	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
> +static inline pte_t pte_mkold(pte_t pte) {
> +	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_mkwrite(pte_t pte) {
> +	pte_val(pte) &= ~_PAGE_RO;
> +	pte_val(pte) |= _PAGE_RW; return pte; }
> +static inline pte_t pte_mkdirty(pte_t pte) {
> +	pte_val(pte) |= _PAGE_DIRTY; return pte; }
> +static inline pte_t pte_mkyoung(pte_t pte) {
> +	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_mkspecial(pte_t pte) {
> +	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
> +static inline pte_t pte_mkhuge(pte_t pte) {
> +	return pte; }
> +static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> +{
> +	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
> +	return pte;
> +}
> +
> +
> +/* Insert a PTE, top-level function is out of line. It uses an inline
Comment style?
> + * low level function in the respective pgtable-* files
> + */
> +extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +		       pte_t pte);
> +
> +/* This low level function performs the actual PTE insertion
> + * Setting the PTE depends on the MMU type and other factors. It's
> + * an horrible mess that I'm not going to try to clean up now but
> + * I'm keeping it in one place rather than spread around
> + */
> +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte, int percpu)
> +{
> +#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
> +	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
> +	 * helper pte_update() which does an atomic update. We need to do that
> +	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
> +	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
> +	 * the hash bits instead (ie, same as the non-SMP case)
> +	 */
> +	if (percpu)
> +		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
> +			      | (pte_val(pte) & ~_PAGE_HASHPTE));
> +	else
> +		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
> +
> +#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
> +	/* Second case is 32-bit with 64-bit PTE.  In this case, we
> +	 * can just store as long as we do the two halves in the right order
> +	 * with a barrier in between. This is possible because we take care,
> +	 * in the hash code, to pre-invalidate if the PTE was already hashed,
> +	 * which synchronizes us with any concurrent invalidation.
> +	 * In the percpu case, we also fallback to the simple update preserving
> +	 * the hash bits
> +	 */
> +	if (percpu) {
> +		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
> +			      | (pte_val(pte) & ~_PAGE_HASHPTE));
> +		return;
> +	}
> +	if (pte_val(*ptep) & _PAGE_HASHPTE)
> +		flush_hash_entry(mm, ptep, addr);
> +	__asm__ __volatile__("\
> +		stw%U0%X0 %2,%0\n\
> +		eieio\n\
> +		stw%U0%X0 %L2,%1"
> +	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> +	: "r" (pte) : "memory");
> +
> +#elif defined(CONFIG_PPC_STD_MMU_32)
> +	/* Third case is 32-bit hash table in UP mode, we need to preserve
> +	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
> +	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
> +	 * and see we need to keep track that this PTE needs invalidating
> +	 */
> +	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
> +		      | (pte_val(pte) & ~_PAGE_HASHPTE));
> +
> +#else
> +	/* Anything else just stores the PTE normally. That covers all 64-bit
> +	 * cases, and 32-bit non-hash with 32-bit PTEs.
> +	 */
> +	*ptep = pte;
> +#endif
> +}
> +
> +
> +#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> +extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> +				 pte_t *ptep, pte_t entry, int dirty);
> +
> +/*
> + * Macro to mark a page protection value as "uncacheable".
> + */
> +
> +#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
> +			 _PAGE_WRITETHRU)
> +
> +#define pgprot_noncached(prot)	  (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
> +				            _PAGE_NO_CACHE | _PAGE_GUARDED))
> +
> +#define pgprot_noncached_wc(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
> +				            _PAGE_NO_CACHE))
> +
> +#define pgprot_cached(prot)       (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
> +				            _PAGE_COHERENT))
> +
> +#define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
> +				            _PAGE_COHERENT | _PAGE_WRITETHRU))
> +
> +#define pgprot_cached_noncoherent(prot) \
> +		(__pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL))
> +
> +#define pgprot_writecombine pgprot_noncached_wc
> +
> +struct file;
> +extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> +				     unsigned long size, pgprot_t vma_prot);
> +#define __HAVE_PHYS_MEM_ACCESS_PROT
> +
> +#endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable-book3e.h
> similarity index 70%
> copy from arch/powerpc/include/asm/pgtable.h
> copy to arch/powerpc/include/asm/pgtable-book3e.h
> index c304d0767919..a3221cff2e31 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable-book3e.h
> @@ -1,41 +1,19 @@
> -#ifndef _ASM_POWERPC_PGTABLE_H
> -#define _ASM_POWERPC_PGTABLE_H
> -#ifdef __KERNEL__
> +#ifndef _ASM_POWERPC_PGTABLE_BOOK3E_H
> +#define _ASM_POWERPC_PGTABLE_BOOK3E_H
>  
> -#ifndef __ASSEMBLY__
> -#include <linux/mmdebug.h>
> -#include <linux/mmzone.h>
> -#include <asm/processor.h>		/* For TASK_SIZE */
> -#include <asm/mmu.h>
> -#include <asm/page.h>
> -
> -struct mm_struct;
> -
> -#endif /* !__ASSEMBLY__ */
> -
> -#ifdef CONFIG_PPC_BOOK3S
> -#include <asm/book3s/pgtable.h>
> -#else
>  #if defined(CONFIG_PPC64)
> -#  include <asm/pgtable-ppc64.h>
> +#include <asm/pgtable-ppc64.h>
>  #else
> -#  include <asm/pgtable-ppc32.h>
> +#include <asm/pgtable-ppc32.h>
>  #endif
> -#endif /* !CONFIG_PPC_BOOK3S */
> -
> -/*
> - * We save the slot number & secondary bit in the second half of the
> - * PTE page. We use the 8 bytes per each pte entry.
> - */
> -#define PTE_PAGE_HIDX_OFFSET (PTRS_PER_PTE * 8)
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <asm/tlbflush.h>
> -
>  /* Generic accessors to PTE bits */
>  static inline int pte_write(pte_t pte)
> -{	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO; }
> +{
> +	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO;
> +}
>  static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
>  static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
>  static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
> @@ -77,10 +55,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
>  static inline unsigned long pte_pfn(pte_t pte)	{
>  	return pte_val(pte) >> PTE_RPN_SHIFT; }
>  
> -/* Keep these as a macros to avoid include dependency mess */
> -#define pte_page(x)		pfn_to_page(pte_pfn(x))
> -#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
> -
>  /* Generic modifiers for PTE bits */
>  static inline pte_t pte_wrprotect(pte_t pte) {
>  	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE);
> @@ -221,59 +195,5 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				     unsigned long size, pgprot_t vma_prot);
>  #define __HAVE_PHYS_MEM_ACCESS_PROT
>  
> -/*
> - * ZERO_PAGE is a global shared page that is always zero: used
> - * for zero-mapped memory areas etc..
> - */
> -extern unsigned long empty_zero_page[];
> -#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
> -
> -extern pgd_t swapper_pg_dir[];
> -
> -void limit_zone_pfn(enum zone_type zone, unsigned long max_pfn);
> -int dma_pfn_limit_to_zone(u64 pfn_limit);
> -extern void paging_init(void);
> -
> -/*
> - * kern_addr_valid is intended to indicate whether an address is a valid
> - * kernel address.  Most 32-bit archs define it as always true (like this)
> - * but most 64-bit archs actually perform a test.  What should we do here?
> - */
> -#define kern_addr_valid(addr)	(1)
> -
> -#include <asm-generic/pgtable.h>
> -
> -
> -/*
> - * This gets called at the end of handling a page fault, when
> - * the kernel has put a new PTE into the page table for the process.
> - * We use it to ensure coherency between the i-cache and d-cache
> - * for the page which has just been mapped in.
> - * On machines which use an MMU hash table, we use this to put a
> - * corresponding HPTE into the hash table ahead of time, instead of
> - * waiting for the inevitable extra hash-table miss exception.
> - */
> -extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
> -
> -extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> -		       unsigned long end, int write,
> -		       struct page **pages, int *nr);
> -#ifndef CONFIG_TRANSPARENT_HUGEPAGE
> -#define pmd_large(pmd)		0
> -#define has_transparent_hugepage() 0
> -#endif
> -pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> -				   bool *is_thp, unsigned *shift);
> -static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> -					       bool *is_thp, unsigned *shift)
> -{
> -	if (!arch_irqs_disabled()) {
> -		pr_info("%s called with irq enabled\n", __func__);
> -		dump_stack();
> -	}
> -	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
> -}
Where's this function gone?
>
<snip>

Balbir Singh
