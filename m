Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GxVh1K48zF1XF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 09:55:39 +1000 (AEST)
Message-ID: <b07b7b340f0b9682e7622c7488a344b7234ac4e5.camel@kernel.crashing.org>
Subject: Re: [PATCH 65/65] powerpc/mm/radix: Cputable update for radix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, paulus@samba.org, distroguy@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 29 Jun 2018 09:55:12 +1000
In-Reply-To: <8760w165aj.fsf@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459491908.10334.8.camel@ellerman.id.au>
 <8760w165aj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-01 at 15:04 +0530, Aneesh Kumar K.V wrote:
> 
> commit 9c9d8b4f6a2c2210c90cbb3f5c6d33b2a642e8d2
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Mon Feb 15 13:44:01 2016 +0530
> 
>     powerpc/mm/radix: Cputable update for radix
>     
>     With P9 Radix we need to do
>     
>     * set UPRT = 1
>     * set different TLB set count
>     
>     In this patch we delay the UPRT=1 to early mmu init. We also update
>     other cpu_spec callback there. The restore cpu callback is used to
>     init secondary cpus and also during opal init. So we do a full
>     radix variant for that, even though the only difference is UPRT=1
>     
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

How are things working in absence of cputable/PVR match ?

Remember we have a requirement to be able to boot existing OSes on
future chips, so Nick's new cpu-features node needs to be what we
test against.

> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index b546e6f28d44..3400ed884f10 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -347,6 +347,10 @@
>  #define   LPCR_LPES_SH	2
>  #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
>  #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
> +/*
> + * Used in asm code, hence we don't want to use PPC_BITCOUNT
> + */
> +#define	  LPCR_UPRT	(ASM_CONST(0x1) << 22)
>  #ifndef SPRN_LPID
>  #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
>  #endif
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 584e119fa8b0..8d717954d0ca 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -117,6 +117,24 @@ _GLOBAL(__restore_cpu_power9)
>  	mtlr	r11
>  	blr
>  
> +_GLOBAL(__restore_cpu_power9_uprt)
> +	mflr	r11
> +	bl	__init_FSCR
> +	mfmsr	r3
> +	rldicl.	r0,r3,4,63
> +	mtlr	r11
> +	beqlr
> +	li	r0,0
> +	mtspr	SPRN_LPID,r0
> +	mfspr   r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
> +	oris	r3,r3,LPCR_UPRT@h
> +	bl	__init_LPCR
> +	bl	__init_HFSCR
> +	bl	__init_tlb_power7
> +	mtlr	r11
> +	blr
> +
>  __init_hvmode_206:
>  	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
>  	mfmsr	r3
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6c662b8de90d..e009722d5914 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -514,7 +514,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_features		= CPU_FTRS_POWER9,
>  		.cpu_user_features	= COMMON_USER_POWER9,
>  		.cpu_user_features2	= COMMON_USER2_POWER9,
> -		.mmu_features		= MMU_FTRS_POWER9,
> +		.mmu_features		= MMU_FTRS_POWER9 | MMU_FTR_RADIX,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.num_pmcs		= 6,
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index 92a66a2a9b85..f902ede263ab 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -75,6 +75,10 @@ void __flush_tlb_power9(unsigned int action)
>  	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
>  }
>  
> +void __flush_tlb_power9_radix(unsigned int action)
> +{
> +	flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
> +}
>  
>  /* flush SLBs and reload */
>  #ifdef CONFIG_PPC_MMU_STD_64
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index bb1eb7d0911c..6e56051bf825 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -294,8 +294,20 @@ found:
>  	return;
>  }
>  
> +extern void __restore_cpu_power9_uprt(void);
> +extern void __flush_tlb_power9_radix(unsigned int action);
>  void __init rearly_init_mmu(void)
>  {
> +	unsigned long lpcr;
> +	/*
> +	 * setup LPCR UPRT based on mmu_features
> +	 */
> +	lpcr = mfspr(SPRN_LPCR);
> +	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
> +	/* update cpu_spec to point to radix enabled callbacks */
> +	cur_cpu_spec->cpu_restore = __restore_cpu_power9_uprt;
> +	cur_cpu_spec->flush_tlb   = __flush_tlb_power9_radix;
> +
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* PAGE_SIZE mappings */
>  	mmu_virtual_psize = MMU_PAGE_64K;
