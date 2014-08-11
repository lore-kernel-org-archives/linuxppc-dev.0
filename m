Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B27C1A0732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 08:53:15 +1000 (EST)
Message-ID: <1407797573.7427.103.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/booke: Restrict SPE exception handlers to
 e200/e500 cores
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Mon, 11 Aug 2014 17:52:53 -0500
In-Reply-To: <1407314358-17653-1-git-send-email-mihai.caraman@freescale.com>
References: <1407314358-17653-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 11:39 +0300, Mihai Caraman wrote:
> SPE exception handlers are now defined for 32-bit e500mc cores even though
> SPE unit is not present and CONFIG_SPE is undefined.
> 
> Restrict SPE exception handlers to e200/e500 cores adding CONFIG_SPE_POSSIBLE
> and consequently guard __stup_ivors and __setup_cpu functions.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S | 12 +++++++++++-
>  arch/powerpc/kernel/cputable.c            |  5 +++++
>  arch/powerpc/kernel/head_fsl_booke.S      | 18 +++++++++++++-----
>  arch/powerpc/platforms/Kconfig.cputype    |  6 +++++-
>  4 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index 4f1393d..44bb2c9 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -91,6 +91,7 @@ _GLOBAL(setup_altivec_idle)
>  
>  	blr
>  
> +#if defined(CONFIG_E500) && defined(CONFIG_PPC_E500MC)

When would you ever have CONFIG_PPC_E500MC without CONFIG_E500?

> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index b497188..4f8930f 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -613,6 +613,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  	mfspr	r10, SPRN_SPRG_RSCRATCH0
>  	b	InstructionStorage
>  
> +/* Define SPE handlers for e200 and e500v2 */
>  #ifdef CONFIG_SPE
>  	/* SPE Unavailable */
>  	START_EXCEPTION(SPEUnavailable)
> @@ -622,10 +623,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  	b	fast_exception_return
>  1:	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	EXC_XFER_EE_LITE(0x2010, KernelSPE)
> -#else
> +#elif CONFIG_SPE_POSSIBLE

#elif defined(CONFIG_SPE_POSSIBLE)

Likewise elsewhere

-Scott
