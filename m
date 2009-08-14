Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 40508B7BDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 08:39:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEAC9DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 08:39:49 +1000 (EST)
Message-Id: <FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248766373.30993.50.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH/RFC] powerpc/mm: Cleanup handling of execute permission
Date: Fri, 14 Aug 2009 17:39:42 -0500
References: <1248766373.30993.50.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

This breaks the boot on 8572.  I don't know why yet (and I'm probably  
not going to figure it out before I go home, because, frankly, it's  
late on a Friday afternoon and I need a glass of wine or, perhaps, a  
beer).

Kumar and I will poke into this more and let you know what we find out  
- in the meantime, if you have any brilliant flashes, pony up!

-Becky

On Jul 28, 2009, at 2:32 AM, Benjamin Herrenschmidt wrote:

> This is an attempt at cleaning up a bit the way we handle execute
> permission on powerpc (again !).
>
> _PAGE_HWEXEC is gone, _PAGE_EXEC is now only defined by CPUs that
> can do something with it, and the myriad of #ifdef's in the I$/D$
> coherency code is reduced to 2 cases that hopefully should cover
> everything.
>
> The logic on BookE is a little bit different than what it was though
> not by much. Since now, _PAGE_EXEC will be set by the generic code
> for executable pages, we need to filter out if they are unclean and
> recover it. However, I don't expect the code to be more bloated than
> it already was in that area due to that change.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> I could boast that this brings proper enforcing of per-page execute
> permissions to all BookE and 40x but in fact, we've had that now for
> some time as a side effect of my previous rework in that area (and
> I didn't even know it :-) We would only enable execute permission if
> the page was cache clean and we would only cache clean it if we took
> and exec fault. Since we now enforce that the later only work if
> VM_EXEC is part of the VMA flags, we de-fact already enforce per-page
> execute permissions... Unless I missed something
>
> Kumar, Becky, I could really use some review here :-) I tested on
> 440 and that's about it, I'll do more testing tomorrow. Basically, I
> _think_ we already enforce execute permission fully on all BookE today
> (test case welcome) but at least after that patch it becomes more
> obvious what is happening in the code.
>
> arch/powerpc/include/asm/pgtable-ppc32.h |    7 +-
> arch/powerpc/include/asm/pgtable-ppc64.h |    3 +-
> arch/powerpc/include/asm/pte-40x.h       |    2 +-
> arch/powerpc/include/asm/pte-44x.h       |    2 +-
> arch/powerpc/include/asm/pte-8xx.h       |    1 -
> arch/powerpc/include/asm/pte-book3e.h    |   13 ++-
> arch/powerpc/include/asm/pte-common.h    |   22 ++--
> arch/powerpc/include/asm/pte-fsl-booke.h |    2 +-
> arch/powerpc/include/asm/pte-hash32.h    |    1 -
> arch/powerpc/kernel/head_44x.S           |    2 +-
> arch/powerpc/kernel/head_fsl_booke.S     |    4 +-
> arch/powerpc/mm/40x_mmu.c                |    4 +-
> arch/powerpc/mm/pgtable.c                |  148 +++++++++++++++++++ 
> +----------
> arch/powerpc/mm/pgtable_32.c             |    2 +-
> arch/powerpc/mm/tlb_low_64e.S            |    4 +-
> 15 files changed, 132 insertions(+), 85 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/ 
> include/asm/pgtable-ppc32.h
> index c9ff9d7..f2c52e2 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> @@ -186,7 +186,7 @@ static inline unsigned long pte_update(pte_t *p,
> #endif /* !PTE_ATOMIC_UPDATES */
>
> #ifdef CONFIG_44x
> -	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
> +	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
> 		icache_44x_need_flush = 1;
> #endif
> 	return old;
> @@ -217,7 +217,7 @@ static inline unsigned long long  
> pte_update(pte_t *p,
> #endif /* !PTE_ATOMIC_UPDATES */
>
> #ifdef CONFIG_44x
> -	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
> +	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
> 		icache_44x_need_flush = 1;
> #endif
> 	return old;
> @@ -267,8 +267,7 @@ static inline void  
> huge_ptep_set_wrprotect(struct mm_struct *mm,
> static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> {
> 	unsigned long bits = pte_val(entry) &
> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
> -		 _PAGE_HWEXEC | _PAGE_EXEC);
> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> 	pte_update(ptep, 0, bits);
> }
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/ 
> include/asm/pgtable-ppc64.h
> index 200ec2d..806abe7 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -313,8 +313,7 @@ static inline void pte_clear(struct mm_struct  
> *mm, unsigned long addr,
> static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> {
> 	unsigned long bits = pte_val(entry) &
> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
> -		 _PAGE_EXEC | _PAGE_HWEXEC);
> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
>
> #ifdef PTE_ATOMIC_UPDATES
> 	unsigned long old, tmp;
> diff --git a/arch/powerpc/include/asm/pte-40x.h b/arch/powerpc/ 
> include/asm/pte-40x.h
> index 07630fa..6c3e1f4 100644
> --- a/arch/powerpc/include/asm/pte-40x.h
> +++ b/arch/powerpc/include/asm/pte-40x.h
> @@ -46,7 +46,7 @@
> #define	_PAGE_RW	0x040	/* software: Writes permitted */
> #define	_PAGE_DIRTY	0x080	/* software: dirty page */
> #define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in  
> exception */
> -#define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
> +#define _PAGE_EXEC	0x200	/* hardware: EX permission */
> #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
>
> #define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
> diff --git a/arch/powerpc/include/asm/pte-44x.h b/arch/powerpc/ 
> include/asm/pte-44x.h
> index 37e98bc..4192b9b 100644
> --- a/arch/powerpc/include/asm/pte-44x.h
> +++ b/arch/powerpc/include/asm/pte-44x.h
> @@ -78,7 +78,7 @@
> #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
> #define _PAGE_RW	0x00000002		/* S: Write permission */
> #define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
> -#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
> +#define _PAGE_EXEC	0x00000004		/* H: Execute permission */
> #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
> #define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
> #define _PAGE_SPECIAL	0x00000020		/* S: Special page */
> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/ 
> include/asm/pte-8xx.h
> index 8c6e312..94e9797 100644
> --- a/arch/powerpc/include/asm/pte-8xx.h
> +++ b/arch/powerpc/include/asm/pte-8xx.h
> @@ -36,7 +36,6 @@
> /* These five software bits must be masked out when the entry is  
> loaded
>  * into the TLB.
>  */
> -#define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
> #define _PAGE_GUARDED	0x0010	/* software: guarded access */
> #define _PAGE_DIRTY	0x0020	/* software: page changed */
> #define _PAGE_RW	0x0040	/* software: user write access allowed */
> diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/ 
> include/asm/pte-book3e.h
> index 1d27c77..9800565 100644
> --- a/arch/powerpc/include/asm/pte-book3e.h
> +++ b/arch/powerpc/include/asm/pte-book3e.h
> @@ -37,12 +37,13 @@
> #define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
>
> /* "Higher level" linux bit combinations */
> -#define _PAGE_EXEC	_PAGE_BAP_SX /* Can be executed from potentially  
> */
> -#define _PAGE_HWEXEC	_PAGE_BAP_UX /* .. and was cache cleaned */
> -#define _PAGE_RW	(_PAGE_BAP_SW | _PAGE_BAP_UW) /* User write  
> permission */
> -#define _PAGE_KERNEL_RW	(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY)
> -#define _PAGE_KERNEL_RO	(_PAGE_BAP_SR)
> -#define _PAGE_USER	(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
> +#define _PAGE_EXEC		_PAGE_BAP_UX /* .. and was cache cleaned */
> +#define _PAGE_RW		(_PAGE_BAP_SW | _PAGE_BAP_UW) /* User write  
> permission */
> +#define _PAGE_KERNEL_RW		(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY)
> +#define _PAGE_KERNEL_RO		(_PAGE_BAP_SR)
> +#define _PAGE_KERNEL_RWX	(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY  
> | _PAGE_BAP_SX)
> +#define _PAGE_KERNEL_ROX	(_PAGE_BAP_SR | _PAGE_BAP_SX)
> +#define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
>
> #define _PAGE_HASHPTE	0
> #define _PAGE_BUSY	0
> diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/ 
> include/asm/pte-common.h
> index 8bb6464..c3b6507 100644
> --- a/arch/powerpc/include/asm/pte-common.h
> +++ b/arch/powerpc/include/asm/pte-common.h
> @@ -13,9 +13,6 @@
> #ifndef _PAGE_HWWRITE
> #define _PAGE_HWWRITE	0
> #endif
> -#ifndef _PAGE_HWEXEC
> -#define _PAGE_HWEXEC	0
> -#endif
> #ifndef _PAGE_EXEC
> #define _PAGE_EXEC	0
> #endif
> @@ -48,10 +45,16 @@
> #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
> #endif
> #ifndef _PAGE_KERNEL_RO
> -#define _PAGE_KERNEL_RO	0
> +#define _PAGE_KERNEL_RO		0
> +#endif
> +#ifndef _PAGE_KERNEL_ROX
> +#define _PAGE_KERNEL_ROX	(_PAGE_EXEC)
> #endif
> #ifndef _PAGE_KERNEL_RW
> -#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
> +#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
> +#endif
> +#ifndef _PAGE_KERNEL_RWX
> +#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE |  
> _PAGE_EXEC)
> #endif
> #ifndef _PAGE_HPTEFLAGS
> #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
> @@ -96,8 +99,7 @@ extern unsigned long  
> bad_call_to_PMD_PAGE_SIZE(void);
> #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT |  
> _PAGE_NO_CACHE | \
> 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
> 			 _PAGE_USER | _PAGE_ACCESSED | \
> -			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
> -			 _PAGE_EXEC | _PAGE_HWEXEC)
> +			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
>
> /*
>  * We define 2 sets of base prot bits, one for basic pages (ie,
> @@ -154,11 +156,9 @@ extern unsigned long  
> bad_call_to_PMD_PAGE_SIZE(void);
> 				 _PAGE_NO_CACHE)
> #define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
> 				 _PAGE_NO_CACHE | _PAGE_GUARDED)
> -#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW |  
> _PAGE_EXEC | \
> -				 _PAGE_HWEXEC)
> +#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
> #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
> -#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO |  
> _PAGE_EXEC | \
> -				 _PAGE_HWEXEC)
> +#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
>
> /* Protection used for kernel text. We want the debuggers to be able  
> to
>  * set breakpoints anywhere, so don't write protect the kernel text
> diff --git a/arch/powerpc/include/asm/pte-fsl-booke.h b/arch/powerpc/ 
> include/asm/pte-fsl-booke.h
> index 10820f5..ce8a9e9 100644
> --- a/arch/powerpc/include/asm/pte-fsl-booke.h
> +++ b/arch/powerpc/include/asm/pte-fsl-booke.h
> @@ -23,7 +23,7 @@
> #define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file  
> mapping */
> #define _PAGE_RW	0x00004	/* S: Write permission (SW) */
> #define _PAGE_DIRTY	0x00008	/* S: Page dirty */
> -#define _PAGE_HWEXEC	0x00010	/* H: SX permission */
> +#define _PAGE_EXEC	0x00010	/* H: SX permission */
> #define _PAGE_ACCESSED	0x00020	/* S: Page referenced */
>
> #define _PAGE_ENDIAN	0x00040	/* H: E bit */
> diff --git a/arch/powerpc/include/asm/pte-hash32.h b/arch/powerpc/ 
> include/asm/pte-hash32.h
> index 16e571c..4aad413 100644
> --- a/arch/powerpc/include/asm/pte-hash32.h
> +++ b/arch/powerpc/include/asm/pte-hash32.h
> @@ -26,7 +26,6 @@
> #define _PAGE_WRITETHRU	0x040	/* W: cache write-through */
> #define _PAGE_DIRTY	0x080	/* C: page changed */
> #define _PAGE_ACCESSED	0x100	/* R: page referenced */
> -#define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
> #define _PAGE_RW	0x400	/* software: user write access allowed */
> #define _PAGE_SPECIAL	0x800	/* software: Special page */
>
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/ 
> head_44x.S
> index 656cfb2..711368b 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -497,7 +497,7 @@ tlb_44x_patch_hwater_D:
> 	mtspr	SPRN_MMUCR,r12
>
> 	/* Make up the required permissions */
> -	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
> +	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
>
> 	/* Compute pgdir/pmd offset */
> 	rlwinm 	r12, r10, PPC44x_PGD_OFF_SHIFT, PPC44x_PGD_OFF_MASK_BIT, 29
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/ 
> kernel/head_fsl_booke.S
> index eca8048..2c5af52 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -643,7 +643,7 @@ interrupt_base:
>
> 4:
> 	/* Make up the required permissions */
> -	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
> +	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
>
> 	FIND_PTE
> 	andc.	r13,r13,r11		/* Check permission */
> @@ -742,7 +742,7 @@ finish_tlb_load:
> #endif
> 	mtspr	SPRN_MAS2, r12
>
> -	li	r10, (_PAGE_HWEXEC | _PAGE_PRESENT)
> +	li	r10, (_PAGE_EXEC | _PAGE_PRESENT)
> 	rlwimi	r10, r11, 31, 29, 29	/* extract _PAGE_DIRTY into SW */
> 	and	r12, r11, r10
> 	andi.	r10, r11, _PAGE_USER	/* Test for _PAGE_USER */
> diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
> index 29954dc..f5e7b9c 100644
> --- a/arch/powerpc/mm/40x_mmu.c
> +++ b/arch/powerpc/mm/40x_mmu.c
> @@ -105,7 +105,7 @@ unsigned long __init mmu_mapin_ram(void)
>
> 	while (s >= LARGE_PAGE_SIZE_16M) {
> 		pmd_t *pmdp;
> -		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC |  
> _PAGE_HWWRITE;
> +		unsigned long val = p | _PMD_SIZE_16M | _PAGE_EXEC | _PAGE_HWWRITE;
>
> 		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> 		pmd_val(*pmdp++) = val;
> @@ -120,7 +120,7 @@ unsigned long __init mmu_mapin_ram(void)
>
> 	while (s >= LARGE_PAGE_SIZE_4M) {
> 		pmd_t *pmdp;
> -		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC |  
> _PAGE_HWWRITE;
> +		unsigned long val = p | _PMD_SIZE_4M | _PAGE_EXEC | _PAGE_HWWRITE;
>
> 		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> 		pmd_val(*pmdp) = val;
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index cafb2a2..d568d2c 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -128,73 +128,126 @@ void pte_free_finish(void)
>
> #endif /* CONFIG_SMP */
>
> +static inline int is_exec_fault(void)
> +{
> +	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
> +}
> +
> +/* We only try to do i/d cache coherency on stuff that looks like
> + * reasonably "normal" PTEs. We currently require a PTE to be present
> + * and we avoid _PAGE_SPECIAL and _PAGE_NO_CACHE. We also only do  
> that
> + * on userspace PTEs
> + */
> +static inline int pte_looks_normal(pte_t pte)
> +{
> +	return (pte_val(pte) &
> +		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
> +		(_PAGE_PRESENT | _PAGE_USER);
> +}
> +
> +
> /*
>  * Handle i/d cache flushing, called from set_pte_at() or  
> ptep_set_access_flags()
>  */
> -static pte_t do_dcache_icache_coherency(pte_t pte)
> +struct page * maybe_pte_to_page(pte_t pte)
> {
> 	unsigned long pfn = pte_pfn(pte);
> 	struct page *page;
>
> 	if (unlikely(!pfn_valid(pfn)))
> -		return pte;
> +		return NULL;
> 	page = pfn_to_page(pfn);
> -
> -	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)) {
> -		pr_devel("do_dcache_icache_coherency... flushing\n");
> -		flush_dcache_icache_page(page);
> -		set_bit(PG_arch_1, &page->flags);
> -	}
> -	else
> -		pr_devel("do_dcache_icache_coherency... already clean\n");
> -	return __pte(pte_val(pte) | _PAGE_HWEXEC);
> +	if (PageReserved(page))
> +		return NULL;
> +	return page;
> }
>
> -static inline int is_exec_fault(void)
> -{
> -	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
> -}
> +#if defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0
>
> -/* We only try to do i/d cache coherency on stuff that looks like
> - * reasonably "normal" PTEs. We currently require a PTE to be present
> - * and we avoid _PAGE_SPECIAL and _PAGE_NO_CACHE
> +/* Server-style MMU handles coherency when hashing if HW exec  
> permission
> + * is supposed per page (currently 64-bit only). If not, then, we  
> always
> + * flush the cache for valid PTEs in set_pte. Embedded CPU without  
> HW exec
> + * support falls into the same category.
>  */
> -static inline int pte_looks_normal(pte_t pte)
> +
> +static pte_t set_pte_filter(pte_t pte)
> {
> -	return (pte_val(pte) &
> -		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE)) ==
> -		(_PAGE_PRESENT);
> +	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
> +	if (pte_looks_normal(pte) && ! 
> (cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
> +				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
> +		struct page *pg = maybe_pte_to_page(pte);
> +		if (!pg)
> +			return pte;
> +		if (!test_bit(PG_arch_1, &pg->flags)) {
> +			flush_dcache_icache_page(pg);
> +			set_bit(PG_arch_1, &pg->flags);
> +		}
> +	}
> +	return pte;
> }
>
> -#if defined(CONFIG_PPC_STD_MMU)
> -/* Server-style MMU handles coherency when hashing if HW exec  
> permission
> - * is supposed per page (currently 64-bit only). Else, we always  
> flush
> - * valid PTEs in set_pte.
> - */
> -static inline int pte_need_exec_flush(pte_t pte, int set_pte)
> +static pte_t set_access_flags_filter(pte_t pte, struct  
> vm_area_struct *vma, int dirty)
> {
> -	return set_pte && pte_looks_normal(pte) &&
> -		!(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
> -		  cpu_has_feature(CPU_FTR_NOEXECUTE));
> +	return pte;
> }
> -#elif _PAGE_HWEXEC == 0
> -/* Embedded type MMU without HW exec support (8xx only so far), we  
> flush
> - * the cache for any present PTE
> +
> +#else /* defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0 */
> +
> +/* Embedded type MMU with HW exec support. This is a bit more  
> complicated
> + * as we don't have two bits to spare for _PAGE_EXEC and  
> _PAGE_HWEXEC so
> + * instead we "filter out" the exec permission for non clean pages.
>  */
> -static inline int pte_need_exec_flush(pte_t pte, int set_pte)
> +static pte_t set_pte_filter(pte_t pte)
> {
> -	return set_pte && pte_looks_normal(pte);
> +	struct page *pg;
> +
> +	/* No exec permission in the first place, move on */
> +	if (!(pte_val(pte) & _PAGE_EXEC) || !pte_looks_normal(pte))
> +		return pte;
> +
> +	/* If you set _PAGE_EXEC on weird pages you're on your own */
> +	pg = maybe_pte_to_page(pte);
> +	if (!pg)
> +		return pte;
> +
> +	/* If the page clean, we move on */
> +	if (test_bit(PG_arch_1, &pg->flags))
> +		return pte;
> +
> +	/* If it's an exec fault, we flush the cache and make it clean */
> +	if (is_exec_fault()) {
> +		flush_dcache_icache_page(pg);
> +		set_bit(PG_arch_1, &pg->flags);
> +		return pte;
> +	}
> +
> +	/* Else, we filter out _PAGE_EXEC */
> +	return __pte(pte_val(pte) & ~_PAGE_EXEC);
> }
> -#else
> -/* Other embedded CPUs with HW exec support per-page, we flush on  
> exec
> - * fault if HWEXEC is not set
> - */
> -static inline int pte_need_exec_flush(pte_t pte, int set_pte)
> +
> +static pte_t set_access_flags_filter(pte_t pte, struct  
> vm_area_struct *vma, int dirty)
> {
> -	return pte_looks_normal(pte) && is_exec_fault() &&
> -		!(pte_val(pte) & _PAGE_HWEXEC);
> +	/* So here, we only care about exec faults, as we use them
> +	 * to recover lost _PAGE_EXEC and perform I$/D$ coherency
> +	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
> +	 * we just bail out
> +	 */
> +	if (dirty || (pte_val(pte) & _PAGE_EXEC) || !is_exec_fault())
> +		return pte;
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/* So this is an exec fault, _PAGE_EXEC is not set. If it was
> +	 * an error we would have bailed out earlier in do_page_fault()
> +	 * but let's make sure of it
> +	 */
> +	if (WARN_ON(!(vma->vm_flags & VM_EXEC)))
> +		return pte;
> +#endif /* CONFIG_DEBUG_VM */
> +
> +	return __pte(pte_val(pte) | _PAGE_EXEC);
> }
> -#endif
> +
> +#endif /* !(defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0) */
>
> /*
>  * set_pte stores a linux PTE into the linux page table.
> @@ -208,9 +261,7 @@ void set_pte_at(struct mm_struct *mm, unsigned  
> long addr, pte_t *ptep, pte_t pte
> 	 * this context might not have been activated yet when this
> 	 * is called.
> 	 */
> -	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
> -	if (pte_need_exec_flush(pte, 1))
> -		pte = do_dcache_icache_coherency(pte);
> +	pte = set_pte_filter(pte);
>
> 	/* Perform the setting of the PTE */
> 	__set_pte_at(mm, addr, ptep, pte, 0);
> @@ -227,8 +278,7 @@ int ptep_set_access_flags(struct vm_area_struct  
> *vma, unsigned long address,
> 			  pte_t *ptep, pte_t entry, int dirty)
> {
> 	int changed;
> -	if (!dirty && pte_need_exec_flush(entry, 0))
> -		entry = do_dcache_icache_coherency(entry);
> +	entry = set_access_flags_filter(entry, vma, dirty);
> 	changed = !pte_same(*(ptep), entry);
> 	if (changed) {
> 		if (!(vma->vm_flags & VM_HUGETLB))
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/ 
> pgtable_32.c
> index 5422169..cb96cb2 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -142,7 +142,7 @@ ioremap_flags(phys_addr_t addr, unsigned long  
> size, unsigned long flags)
> 		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
>
> 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
> -	flags &= ~(_PAGE_USER | _PAGE_EXEC | _PAGE_HWEXEC);
> +	flags &= ~(_PAGE_USER | _PAGE_EXEC);
>
> 	return __ioremap_caller(addr, size, flags,  
> __builtin_return_address(0));
> }
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/ 
> tlb_low_64e.S
> index 10d524d..cd92f62 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -133,7 +133,7 @@
>
> 	/* We do the user/kernel test for the PID here along with the RW test
> 	 */
> -	li	r11,_PAGE_PRESENT|_PAGE_HWEXEC	/* Base perm */
> +	li	r11,_PAGE_PRESENT|_PAGE_EXEC	/* Base perm */
> 	oris	r11,r11,_PAGE_ACCESSED@h
>
> 	cmpldi	cr0,r15,0			/* Check for user region */
> @@ -256,7 +256,7 @@ normal_tlb_miss_done:
>
> normal_tlb_miss_access_fault:
> 	/* We need to check if it was an instruction miss */
> -	andi.	r10,r11,_PAGE_HWEXEC
> +	andi.	r10,r11,_PAGE_EXEC
> 	bne	1f
> 	ld	r14,EX_TLB_DEAR(r12)
> 	ld	r15,EX_TLB_ESR(r12)
> -- 
> 1.6.1.2.14.gf26b5
>
>
