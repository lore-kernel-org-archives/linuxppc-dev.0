Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50C61DE29A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 02:18:39 +1000 (EST)
Message-Id: <95881B3C-FE43-4D24-AAFD-BE205754BE54@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 1/4] powerpc: Introduce local (non-broadcast) forms of
	tlb invalidates
Date: Fri, 29 Aug 2008 10:20:37 -0500
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 29, 2008, at 8:56 AM, Kumar Gala wrote:

> Introduced a new set of low level tlb invalidate functions that do not
> broadcast invalidates on the bus:
>
> _tlbil_all - invalidate all
> _tlbil_pid - invalidate based on process id (or mm context)
> _tlbil_va  - invalidate based on virtual address (ea + pid)
>
> On non-SMP configs _tlbil_all should be functionally equivalent to  
> _tlbia and
> _tlbil_va should be functionally equivalent to _tlbie.
>
> The intent of this change is to handle SMP based invalidates via  
> IPIs instead
> of broadcasts as the mechanism scales better for larger number of  
> cores.
>
> On e500 (fsl-booke mmu) based cores move to using MMUCSR for  
> invalidate alls
> and tlbsx/tlbwe for invalidate virtual address.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/reg_booke.h |    7 ++++
> arch/powerpc/include/asm/tlbflush.h  |   13 +++++---
> arch/powerpc/kernel/misc_32.S        |   52 +++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/kernel/ppc_ksyms.c      |    3 ++
> 4 files changed, 70 insertions(+), 5 deletions(-)
>
>

<...snip....>

>
> #elif defined(CONFIG_PPC32)
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/ 
> misc_32.S
> index 7a6dfbc..4923ae4 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -274,6 +274,9 @@ _GLOBAL(real_writeb)
> /*
>  * Flush MMU TLB
>  */
> +#ifndef CONFIG_FSL_BOOKE
> +_GLOBAL(_tlbil_all)
> +#endif
> _GLOBAL(_tlbia)
> #if defined(CONFIG_40x)
> 	sync			/* Flush to memory before changing mapping */
> @@ -344,6 +347,9 @@ _GLOBAL(_tlbia)
> /*
>  * Flush MMU TLB for a particular address
>  */
> +#ifndef CONFIG_FSL_BOOKE
> +_GLOBAL(_tlbil_va)
> +#endif
> _GLOBAL(_tlbie)
> #if defined(CONFIG_40x)
> 	/* We run the search with interrupts disabled because we have to  
> change
> @@ -436,6 +442,52 @@ _GLOBAL(_tlbie)
> #endif /* ! CONFIG_40x */
> 	blr
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
> + * Flush MMU TLB for a particular process id, but only on the local  
> processor
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

Not sure how much it actually matters, but I think mtspr of MMUCSR0 on  
E500 requires CSI.

Otherwise, LGTM.

-B
