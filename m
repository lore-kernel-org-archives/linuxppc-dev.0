Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2DBADE06C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 16:51:52 +1000 (EST)
Subject: Re: [PATCH] powerpc: Introduce local (non-broadcast) forms of tlb
	invalidates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0807151627020.29665@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807151627020.29665@blarg.am.freescale.net>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 16:48:11 +1000
Message-Id: <1216277292.7740.318.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 16:27 -0500, Kumar Gala wrote:
> Introduced a new set of low level tlb invalidate functions that do not
> broadcast invalidates on the bus:
> 
> _tlbil_all - invalidate all
> _tlbil_pid - invalidate based on process id (or mm context)
> _tlbil_va  - invalidate based on virtual address (ea + pid)
> 
> On non-SMP configs _tlbil_all should be functionally equivalent to _tlbia and
> _tlbil_va should be functionally equivalent to _tlbie.
> 
> The intent of this change is to handle SMP based invalidates via IPIs instead
> of broadcasts as the mechanism scales better for larger number of cores.
> 
> On e500 (fsl-booke mmu) based cores move to using MMUCSR for invalidate alls
> and tlbsx/tlbwe for invalidate virtual address.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Any reason why we have to continue doing those in asm .S files ?

mfspr/mtspr in C work fine and inline asm statements for the
tlbilx instructions proper too :-)

Cheers,
Ben.

> ---
>  arch/powerpc/kernel/misc_32.S   |   53 +++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/ppc_ksyms.c |    1 +
>  include/asm-powerpc/reg_booke.h |    7 +++++
>  include/asm-powerpc/tlbflush.h  |   13 ++++++---
>  4 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index 6321ae3..9245b75 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -274,6 +274,9 @@ _GLOBAL(real_writeb)
>  /*
>   * Flush MMU TLB
>   */
> +#ifndef CONFIG_FSL_BOOKE
> +_GLOBAL(_tlbil_all)
> +#endif
>  _GLOBAL(_tlbia)
>  #if defined(CONFIG_40x)
>  	sync			/* Flush to memory before changing mapping */
> @@ -344,6 +347,9 @@ _GLOBAL(_tlbia)
>  /*
>   * Flush MMU TLB for a particular address
>   */
> +#ifndef CONFIG_FSL_BOOKE
> +_GLOBAL(_tlbil_va)
> +#endif
>  _GLOBAL(_tlbie)
>  #if defined(CONFIG_40x)
>  	/* We run the search with interrupts disabled because we have to change
> @@ -436,6 +442,53 @@ _GLOBAL(_tlbie)
>  #endif /* ! CONFIG_40x */
>  	blr
> 
> +#if defined(CONFIG_FSL_BOOKE)
> +/*
> + * Flush MMU TLB, but only on the local processor (no broadcast)
> + */
> +_GLOBAL(_tlbil_all)
> +#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
> +			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
> +	li	r3,(MMUCSR0_TLBFI)@l
> +	mtspr	SPRN_MMUCSR0, r3
> +1:
> +	mfspr	r3,SPRN_MMUCSR0
> +	andi.	r3,r3,MMUCSR0_TLBFI@l
> +	bne	1b
> +	blr
> +
> +/*
> + * Flush MMU TLB for a particular process id, but only on the local processor
> + * (no broadcast)
> + */
> +_GLOBAL(_tlbil_pid)
> +	li	r3,(MMUCSR0_TLBFI)@l
> +	mtspr	SPRN_MMUCSR0, r3
> +1:
> +	mfspr	r3,SPRN_MMUCSR0
> +	andi.	r1,r2,MMUCSR0_TLBFI@l
> +	bne	1b
> +	blr
> +
> +/*
> + * Flush MMU TLB for a particular address, but only on the local processor
> + * (no broadcast)
> + */
> +_GLOBAL(_tlbil_va)
> +	slwi	r4,r4,16
> +	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
> +	tlbsx	0,r3
> +	mfspr	r4,SPRN_MAS1		/* check valid */
> +	andis.	r3,r4,MAS1_VALID@h
> +	beq	1f
> +	rlwinm	r4,r4,0,1,31
> +	mtspr	SPRN_MAS1,r4
> +	tlbwe
> +1:
> +	blr
> +#endif /* CONFIG_FSL_BOOKE */
> +
> +
>  /*
>   * Flush instruction cache.
>   * This is a no-op on the 601.
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
> index 958ecb9..b7e4ff0 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -114,6 +114,7 @@ EXPORT_SYMBOL(flush_instruction_cache);
>  EXPORT_SYMBOL(flush_tlb_kernel_range);
>  EXPORT_SYMBOL(flush_tlb_page);
>  EXPORT_SYMBOL(_tlbie);
> +EXPORT_SYMBOL(_tlbil_va);
>  #endif
>  EXPORT_SYMBOL(__flush_icache_range);
>  EXPORT_SYMBOL(flush_dcache_range);
> diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
> index be980f4..6745376 100644
> --- a/include/asm-powerpc/reg_booke.h
> +++ b/include/asm-powerpc/reg_booke.h
> @@ -109,6 +109,7 @@
>  #define SPRN_EVPR	0x3D6	/* Exception Vector Prefix Register */
>  #define SPRN_L1CSR0	0x3F2	/* L1 Cache Control and Status Register 0 */
>  #define SPRN_L1CSR1	0x3F3	/* L1 Cache Control and Status Register 1 */
> +#define SPRN_MMUCSR0	0x3F4	/* MMU Control and Status Register 0 */
>  #define SPRN_PIT	0x3DB	/* Programmable Interval Timer */
>  #define SPRN_BUCSR	0x3F5	/* Branch Unit Control and Status */
>  #define SPRN_L2CSR0	0x3F9	/* L2 Data Cache Control and Status Register 0 */
> @@ -410,6 +411,12 @@
>  #define L2CSR0_L2LOA	0x00000080	/* L2 Cache Lock Overflow Allocate */
>  #define L2CSR0_L2LO	0x00000020	/* L2 Cache Lock Overflow */
> 
> +/* Bit definitions for MMUCSR0 */
> +#define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
> +#define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
> +#define MMUCSR0_TLB2FI	0x00000040	/* TLB2 Flash invalidate */
> +#define MMUCSR0_TLB3FI	0x00000020	/* TLB3 Flash invalidate */
> +
>  /* Bit definitions for SGR. */
>  #define SGR_NORMAL	0		/* Speculative fetching allowed. */
>  #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
> diff --git a/include/asm-powerpc/tlbflush.h b/include/asm-powerpc/tlbflush.h
> index 5c91081..29da561 100644
> --- a/include/asm-powerpc/tlbflush.h
> +++ b/include/asm-powerpc/tlbflush.h
> @@ -29,6 +29,9 @@
>  #include <linux/mm.h>
> 
>  extern void _tlbie(unsigned long address, unsigned int pid);
> +extern void _tlbil_all(void);
> +extern void _tlbil_pid(unsigned int pid);
> +extern void _tlbil_va(unsigned long address, unsigned int pid);
> 
>  #if defined(CONFIG_40x) || defined(CONFIG_8xx)
>  #define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
> @@ -38,31 +41,31 @@ extern void _tlbia(void);
> 
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }
> 
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>  				  unsigned long vmaddr)
>  {
> -	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
> +	_tlbil_va(vmaddr, vma ? vma->vm_mm->context.id : 0);
>  }
> 
>  static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
>  					 unsigned long vmaddr)
>  {
> -	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
> +	flush_tlb_page(vma, vmaddr);
>  }
> 
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }
> 
>  static inline void flush_tlb_kernel_range(unsigned long start,
>  					  unsigned long end)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }
> 
>  #elif defined(CONFIG_PPC32)
