Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb5hR5XYHzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 11:57:27 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id fe3so53254661pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 17:57:27 -0700 (PDT)
Subject: Re: [PATCH 02/65] powerpc/mm: use _PAGE_READ to indicate Read access
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FC75F0.9010500@gmail.com>
Date: Thu, 31 Mar 2016 11:57:20 +1100
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> This split _PAGE_RW bit to _PAGE_READ and _PAGE_WRITE. It also remove
> the dependency on _PAGE_USER for implying read only. Few things to note
> here is that, we have read implied with write and execute permission.
> Hence we should always find _PAGE_READ set on hash pte fault.
>
> We still can't switch PROT_NONE to !(_PAGE_RWX). Auto numa do depend
> on marking a prot none pte _PAGE_WRITE. (For more details look at
> b191f9b106ea "mm: numa: preserve PTE write permissions across a NUMA hinting fault")
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 +--
>  arch/powerpc/include/asm/book3s/64/hash.h     | 35 ++++++++++++++++-----------
>  arch/powerpc/include/asm/pte-common.h         |  5 ++++
>  arch/powerpc/mm/hash64_4k.c                   |  2 +-
>  arch/powerpc/mm/hash64_64k.c                  |  4 +--
>  arch/powerpc/mm/hash_utils_64.c               |  9 ++++---
>  arch/powerpc/mm/hugepage-hash64.c             |  2 +-
>  arch/powerpc/mm/hugetlbpage-hash64.c          |  2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |  4 +--
>  arch/powerpc/mm/pgtable.c                     |  4 +--
>  arch/powerpc/mm/pgtable_64.c                  |  5 ++--
>  arch/powerpc/platforms/cell/spu_base.c        |  2 +-
>  arch/powerpc/platforms/cell/spufs/fault.c     |  4 +--
>  drivers/misc/cxl/fault.c                      |  4 +--
>  14 files changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 0a7956a80a08..279ded72f1db 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -291,10 +291,10 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  				      pmd_t *pmdp)
>  {
>  
> -	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
> +	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
>  		return;
>  
> -	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
> +	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
>  }
>  
>  #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 2113de051824..f092d83fa623 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -16,8 +16,10 @@
>  #define _PAGE_BIT_SWAP_TYPE	0
>  
>  #define _PAGE_EXEC		0x00001 /* execute permission */
> -#define _PAGE_RW		0x00002 /* read & write access allowed */
> +#define _PAGE_WRITE		0x00002 /* write access allowed */
>  #define _PAGE_READ		0x00004	/* read access allowed */
> +#define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
> +#define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
>  #define _PAGE_USER		0x00008 /* page may be accessed by userspace */
>  #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
>  /* M (memory coherence) is always set in the HPTE, so we don't need it here */
> @@ -147,8 +149,8 @@
>   */
>  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>  			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
> -			 _PAGE_USER | _PAGE_ACCESSED |  \
> -			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
> +			 _PAGE_USER | _PAGE_ACCESSED |  _PAGE_READ |\
> +			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
>  			 _PAGE_SOFT_DIRTY)
>  /*
>   * We define 2 sets of base prot bits, one for basic pages (ie,
> @@ -173,10 +175,12 @@
>  #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
>  #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
>  				 _PAGE_EXEC)
> -#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER )
> -#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
> -#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER )
> -#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
> +#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
> +#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
> +				 _PAGE_EXEC)
> +#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
> +#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
> +				 _PAGE_EXEC)
>  
>  #define __P000	PAGE_NONE
>  #define __P001	PAGE_READONLY
> @@ -300,19 +304,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  				      pte_t *ptep)
>  {
>  
> -	if ((pte_val(*ptep) & _PAGE_RW) == 0)
> +	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
>  		return;
>  
> -	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
> +	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
>  }
>  
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> -	if ((pte_val(*ptep) & _PAGE_RW) == 0)
> +	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
>  		return;
>  
> -	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
> +	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
>  }
>  
>  /*
> @@ -352,7 +356,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
>  static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
>  {
>  	unsigned long bits = pte_val(entry) &
> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC |
>  		 _PAGE_SOFT_DIRTY);
>  
>  	unsigned long old, tmp;
> @@ -386,7 +390,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
>  
>  
>  /* Generic accessors to PTE bits */
> -static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
> +static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
>  static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
>  static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
>  static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
> @@ -447,7 +451,7 @@ static inline unsigned long pte_pfn(pte_t pte)
>  /* Generic modifiers for PTE bits */
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> -	return __pte(pte_val(pte) & ~_PAGE_RW);
> +	return __pte(pte_val(pte) & ~_PAGE_WRITE);
>  }
>  
>  static inline pte_t pte_mkclean(pte_t pte)
> @@ -462,6 +466,9 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_mkwrite(pte_t pte)
>  {
> +	/*
> +	 * write implies read, hence set both
> +	 */
>  	return __pte(pte_val(pte) | _PAGE_RW);
>  }
>  
> diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
> index 1ec67b043065..9f5dea58b0db 100644
> --- a/arch/powerpc/include/asm/pte-common.h
> +++ b/arch/powerpc/include/asm/pte-common.h
> @@ -198,3 +198,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
>  /* Advertise support for _PAGE_SPECIAL */
>  #define __HAVE_ARCH_PTE_SPECIAL
>  
> +#ifndef _PAGE_READ
> +/* if not defined, we should not find _PAGE_WRITE too */
> +#define _PAGE_READ 0
> +#define _PAGE_WRITE _PAGE_RW
> +#endif
> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> index 71abd4c44c27..7ebac279d38e 100644
> --- a/arch/powerpc/mm/hash64_4k.c
> +++ b/arch/powerpc/mm/hash64_4k.c
> @@ -46,7 +46,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * also add _PAGE_COMBO
>  		 */
>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> -		if (access & _PAGE_RW)
> +		if (access & _PAGE_WRITE)
>  			new_pte |= _PAGE_DIRTY;
>  
>  		opte = cpu_to_be64(old_pte);
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 6f9b3c34a5c0..83ac9f658733 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -78,7 +78,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * also add _PAGE_COMBO
>  		 */
>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
> -		if (access & _PAGE_RW)
> +		if (access & _PAGE_WRITE)
>  			new_pte |= _PAGE_DIRTY;
>  
>  		opte = cpu_to_be64(old_pte);
> @@ -255,7 +255,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  		 * a write access.
>  		 */
>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> -		if (access & _PAGE_RW)
> +		if (access & _PAGE_WRITE)
>  			new_pte |= _PAGE_DIRTY;
>  		opte = cpu_to_be64(old_pte);
>  		npte = cpu_to_be64(new_pte);
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 90dd9280894f..ea23403b3fc0 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -175,8 +175,9 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  	 * or PP=0x3 for read-only (including writeable but clean pages).
>  	 */
>  	if (pteflags & _PAGE_USER) {
> -		rflags |= 0x2;
> -		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
> +		if (pteflags & _PAGE_RWX)
Should this be pteflags & _PAGE_RW?
> +			rflags |= 0x2;
> +		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
>  			rflags |= 0x1;
if pteflags == _PAGE_USER | _PAGE_WRITE | _PAGE_DIRTY, what is rflags set to?



>  	}
>  	/*
> @@ -1205,7 +1206,7 @@ EXPORT_SYMBOL_GPL(hash_page);
>  int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
>  		unsigned long dsisr)
>  {
> -	unsigned long access = _PAGE_PRESENT;
> +	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
>  	unsigned long flags = 0;
>  	struct mm_struct *mm = current->mm;
>  
> @@ -1216,7 +1217,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
>  		flags |= HPTE_NOHPTE_UPDATE;
>  
>  	if (dsisr & DSISR_ISSTORE)
> -		access |= _PAGE_RW;
> +		access |= _PAGE_WRITE;
>  	/*
>  	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
>  	 * accessing a userspace segment (even from the kernel). We assume
> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
> index 98891139c044..39342638a498 100644
> --- a/arch/powerpc/mm/hugepage-hash64.c
> +++ b/arch/powerpc/mm/hugepage-hash64.c
> @@ -48,7 +48,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * a write access
>  		 */
>  		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
> -		if (access & _PAGE_RW)
> +		if (access & _PAGE_WRITE)
>  			new_pmd |= _PAGE_DIRTY;
>  		opmd = cpu_to_be64(old_pmd);
>  		npmd = cpu_to_be64(new_pmd);
> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 5bcb28606158..e6e54a04bd32 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -56,7 +56,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
>  		 * a write access */
>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> -		if (access & _PAGE_RW)
> +		if (access & _PAGE_WRITE)
>  			new_pte |= _PAGE_DIRTY;
>  		opte = cpu_to_be64(old_pte);
>  		npte = cpu_to_be64(new_pte);
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 6dd272b6196f..6e52e722d3f2 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -1003,9 +1003,9 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  		end = pte_end;
>  
>  	pte = READ_ONCE(*ptep);
> -	mask = _PAGE_PRESENT | _PAGE_USER;
> +	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
>  	if (write)
> -		mask |= _PAGE_RW;
> +		mask |= _PAGE_WRITE;
>  
>  	if ((pte_val(pte) & mask) != mask)
>  		return 0;
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 83dfd7925c72..98b5c03e344d 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -177,8 +177,8 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
>  	 * Hence we can use set_pte_at for them.
>  	 */
> -	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
> -		(_PAGE_PRESENT | _PAGE_USER));
> +	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
> +
What was wrong with the previous check? The compiler will optimize it, but the new
check uses two pte_val() calls on *ptep
>  	/*
>  	 * Add the pte bit when tryint set a pte
>  	 */
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index aa742aa35b64..00d8d985bba3 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -277,7 +277,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
>  	void *caller = __builtin_return_address(0);
>  
>  	/* writeable implies dirty for kernel addresses */
> -	if (flags & _PAGE_RW)
> +	if (flags & _PAGE_WRITE)
>  		flags |= _PAGE_DIRTY;
>  
>  	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
> @@ -681,8 +681,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  		pmd_t *pmdp, pmd_t pmd)
>  {
>  #ifdef CONFIG_DEBUG_VM
> -	WARN_ON((pmd_val(*pmdp) & (_PAGE_PRESENT | _PAGE_USER)) ==
> -		(_PAGE_PRESENT | _PAGE_USER));
> +	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
Same as above, plus I think we can move these to VM_WARN_ON just to be consistent

snip...
Balbir
