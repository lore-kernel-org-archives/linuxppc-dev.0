Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1712DDDE9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 18:37:34 +1100 (EST)
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <200802021047.32055.yur@emcraft.com>
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
	<200802021047.32055.yur@emcraft.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 18:37:07 +1100
Message-Id: <1202197027.7079.57.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-02-02 at 10:47 +0300, Yuri Tikhonov wrote:
> Hello,
> 
>  Here is the patch which makes Linux-2.6 swap routines operate correctly on
> the ppc-8xx-based machines.

Best is to just remove writeback completely and let the generic
code handle it.

Ben.

> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> --
> diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
> index eb8d26f..321bda2 100644
> --- a/arch/ppc/kernel/head_8xx.S
> +++ b/arch/ppc/kernel/head_8xx.S
> @@ -329,8 +329,18 @@ InstructionTLBMiss:
>  	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
>  	lwz	r10, 0(r11)	/* Get the pte */
>  
> +#ifdef CONFIG_SWAP
> +	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> +	andi.	r11, r10, _PAGE_PRESENT
> +	beq	4f
> +	ori	r10, r10, _PAGE_ACCESSED
> +	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
> +	stw	r10, 0(r11)
> +4:
> +#else
>  	ori	r10, r10, _PAGE_ACCESSED
>  	stw	r10, 0(r11)
> +#endif
>  
>  	/* The Linux PTE won't go exactly into the MMU TLB.
>  	 * Software indicator bits 21, 22 and 28 must be clear.
> @@ -395,8 +405,17 @@ DataStoreTLBMiss:
>  	DO_8xx_CPU6(0x3b80, r3)
>  	mtspr	SPRN_MD_TWC, r11
>  
> -	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
> +#ifdef CONFIG_SWAP
> +	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> +	andi.	r11, r10, _PAGE_PRESENT
> +	beq	4f
> +	ori	r10, r10, _PAGE_ACCESSED
> +4:
> +	/* and update pte in table */
> +#else
>  	ori	r10, r10, _PAGE_ACCESSED
> +#endif
> +	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
>  	stw	r10, 0(r11)
>  
>  	/* The Linux PTE won't go exactly into the MMU TLB.
> @@ -575,7 +594,16 @@ DataTLBError:
>  
>  	/* Update 'changed', among others.
>  	*/
> +#ifdef CONFIG_SWAP
> +	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
> +	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> +	andi.	r11, r10, _PAGE_PRESENT
> +	beq	4f
> +	ori	r10, r10, _PAGE_ACCESSED
> +4:
> +#else
>  	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
> +#endif
>  	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
>  	stw	r10, 0(r11)		/* and update pte in table */
>  
> diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
> index c159315..76717ff 100644
> --- a/include/asm-ppc/pgtable.h
> +++ b/include/asm-ppc/pgtable.h
> @@ -341,14 +341,6 @@ extern unsigned long ioremap_bot, ioremap_base;
>  #define _PMD_PAGE_MASK	0x000c
>  #define _PMD_PAGE_8M	0x000c
>  
> -/*
> - * The 8xx TLB miss handler allegedly sets _PAGE_ACCESSED in the PTE
> - * for an address even if _PAGE_PRESENT is not set, as a performance
> - * optimization.  This is a bug if you ever want to use swap unless
> - * _PAGE_ACCESSED is 2, which it isn't, or unless you have 8xx-specific
> - * definitions for __swp_entry etc. below, which would be gross.
> - *  -- paulus
> - */
>  #define _PTE_NONE_MASK _PAGE_ACCESSED
>  
>  #else /* CONFIG_6xx */
> 
