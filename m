Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 875CAB6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:16:51 +1000 (EST)
Message-ID: <1340748983.3732.32.camel@pasglop>
Subject: Re: [RFC PATCH 13/17] PowerPC: booke64: Use SPRG0/3 scratch for
 bolted TLB miss & crit int
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 27 Jun 2012 08:16:23 +1000
In-Reply-To: <1340627195-11544-14-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-14-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: qemu-ppc@nongnu.org, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-25 at 15:26 +0300, Mihai Caraman wrote:
> Embedded.Hypervisor category defines GSPRG0..3 physical registers for guests.
> Avoid SPRG4-7 usage as scratch in host exception handlers, otherwise guest
> SPRG4-7 registers will be clobbered.
> For bolted TLB miss exception handlers, which is the version currently
> supported by KVM, use SPRN_SPRG_GEN_SCRATCH (aka SPRG0) instead of
> SPRN_SPRG_TLB_SCRATCH (aka SPRG6) and replace TLB with GEN PACA slots to
> keep consitency.
> For critical exception handler use SPRG3 instead of SPRG7.

Beware with SPRG3 usage. It's user space visible and we plan to use it
for other things (see Anton's patch to stick topology information in
there for use by the vdso). If you clobber it, you may want to restore
it later.

I think Anton's patch should put the "proper" value we want in the PACA
anyway since we also need to restore it on exit from KVM, so you can
still use it as scratch, just restore the value before going to C.

Cheers,
Ben.

> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/include/asm/exception-64e.h |   14 +++++++-------
>  arch/powerpc/include/asm/reg.h           |    6 +++---
>  arch/powerpc/mm/tlb_low_64e.S            |   28 ++++++++++++++--------------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
> index ac13add..c90a9a4 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -38,8 +38,11 @@
>   */
>  
> 
> -/* We are out of SPRGs so we save some things in the PACA. The normal
> - * exception frame is smaller than the CRIT or MC one though
> +/* We are out of SPRGs so we save some things in the 8 slots available in PACA.
> + * The normal exception frame is smaller than the CRIT or MC one though
> + *
> + * Bolted TLB miss exception variant also uses these slots which in combination
> + * with pgd and kernel_pgd fits in one 64-byte cache line.
>   */
>  #define EX_R1		(0 * 8)
>  #define EX_CR		(1 * 8)
> @@ -47,13 +50,10 @@
>  #define EX_R11		(3 * 8)
>  #define EX_R14		(4 * 8)
>  #define EX_R15		(5 * 8)
> +#define EX_R16		(6 * 8)
>  
>  /*
> - * The TLB miss exception uses different slots.
> - *
> - * The bolted variant uses only the first six fields,
> - * which in combination with pgd and kernel_pgd fits in
> - * one 64-byte cache line.
> + * PACA slots offset for standard TLB miss exception.
>   */
>  
>  #define EX_TLB_R10	( 0 * 8)
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index f0cb7f4..51c14a7 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -760,10 +760,10 @@
>   * 64-bit embedded
>   *	- SPRG0 generic exception scratch
>   *	- SPRG2 TLB exception stack
> - *	- SPRG3 unused (user visible)
> + *	- SPRG3 critical exception scratch (user visible)
>   *	- SPRG4 unused (user visible)
>   *	- SPRG6 TLB miss scratch (user visible, sorry !)
> - *	- SPRG7 critical exception scratch
> + *	- SPRG7 unused (user visible)
>   *	- SPRG8 machine check exception scratch
>   *	- SPRG9 debug exception scratch
>   *
> @@ -857,7 +857,7 @@
>  
>  #ifdef CONFIG_PPC_BOOK3E_64
>  #define SPRN_SPRG_MC_SCRATCH	SPRN_SPRG8
> -#define SPRN_SPRG_CRIT_SCRATCH	SPRN_SPRG7
> +#define SPRN_SPRG_CRIT_SCRATCH	SPRN_SPRG3
>  #define SPRN_SPRG_DBG_SCRATCH	SPRN_SPRG9
>  #define SPRN_SPRG_TLB_EXFRAME	SPRN_SPRG2
>  #define SPRN_SPRG_TLB_SCRATCH	SPRN_SPRG6
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index 88feaaa..4192ade 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -40,36 +40,36 @@
>   **********************************************************************/
>  
>  .macro tlb_prolog_bolted intnum addr
> -	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> +	mtspr	SPRN_SPRG_GEN_SCRATCH,r13
>  	mfspr	r13,SPRN_SPRG_PACA
> -	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> +	std	r10,PACA_EXGEN+EX_R10(r13)
>  	mfcr	r10
> -	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> +	std	r11,PACA_EXGEN+EX_R11(r13)
>  #ifdef CONFIG_KVM_BOOKE_HV
>  BEGIN_FTR_SECTION
>  	mfspr	r11, SPRN_SRR1
>  END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  #endif
>  	DO_KVM	\intnum, SPRN_SRR1
> -	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
> +	std	r16,PACA_EXGEN+EX_R16(r13)
>  	mfspr	r16,\addr		/* get faulting address */
> -	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
> +	std	r14,PACA_EXGEN+EX_R14(r13)
>  	ld	r14,PACAPGD(r13)
> -	std	r15,PACA_EXTLB+EX_TLB_R15(r13)
> -	std	r10,PACA_EXTLB+EX_TLB_CR(r13)
> +	std	r15,PACA_EXGEN+EX_R15(r13)
> +	std	r10,PACA_EXGEN+EX_CR(r13)
>  	TLB_MISS_PROLOG_STATS_BOLTED
>  .endm
>  
>  .macro tlb_epilog_bolted
> -	ld	r14,PACA_EXTLB+EX_TLB_CR(r13)
> -	ld	r10,PACA_EXTLB+EX_TLB_R10(r13)
> -	ld	r11,PACA_EXTLB+EX_TLB_R11(r13)
> +	ld	r14,PACA_EXGEN+EX_CR(r13)
> +	ld	r10,PACA_EXGEN+EX_R10(r13)
> +	ld	r11,PACA_EXGEN+EX_R11(r13)
>  	mtcr	r14
> -	ld	r14,PACA_EXTLB+EX_TLB_R14(r13)
> -	ld	r15,PACA_EXTLB+EX_TLB_R15(r13)
> +	ld	r14,PACA_EXGEN+EX_R14(r13)
> +	ld	r15,PACA_EXGEN+EX_R15(r13)
>  	TLB_MISS_RESTORE_STATS_BOLTED
> -	ld	r16,PACA_EXTLB+EX_TLB_R16(r13)
> -	mfspr	r13,SPRN_SPRG_TLB_SCRATCH
> +	ld	r16,PACA_EXGEN+EX_R16(r13)
> +	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
>  .endm
>  
>  /* Data TLB miss */
