Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E50C31A0955
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 10:10:53 +1000 (EST)
Message-ID: <1406333436.29414.151.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
From: Scott Wood <scottwood@freescale.com>
To: Caraman Mihai Claudiu-B02008 <mihai.caraman@freescale.com>
Date: Fri, 25 Jul 2014 19:10:36 -0500
In-Reply-To: <3807e749871d460f90a57ad47ad2654d@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
 <53B54AAD.4040609@suse.de>
 <767ce3456f6f40809a1488b4df90498d@BLUPR03MB503.namprd03.prod.outlook.com>
 <3807e749871d460f90a57ad47ad2654d@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-24 at 04:16 -0500, Caraman Mihai Claudiu-B02008 wrote:
> Scott, Alex's request to define SPE handlers only for e500v2 implies changes
> in 32-bit FSL kernel to have exclusive configurations for e200/e500v2 and
> e500mc/e5500. We would probably need something like this, what's your take on it?

That is already a compile-time decision.
        
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index b497188..9d41015 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -613,6 +613,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>         mfspr   r10, SPRN_SPRG_RSCRATCH0
>         b       InstructionStorage
>  
> +/* Define SPE handlers only for e500v2 and e200 */
> +#ifndef CONFIG_PPC_E500MC
>  #ifdef CONFIG_SPE
>         /* SPE Unavailable */
>         START_EXCEPTION(SPEUnavailable)
> @@ -626,7 +628,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>         EXCEPTION(0x2020, SPE_ALTIVEC_UNAVAIL, SPEUnavailable, \
>                   unknown_exception, EXC_XFER_EE)
>  #endif /* CONFIG_SPE */
> +#endif

This is redundant:

        config SPE
                bool "SPE Support"
                depends on E200 || (E500 && !PPC_E500MC)
                default y 

> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index c1faade..3ab65c2 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2030,6 +2030,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  #endif /* CONFIG_PPC32 */
>  #ifdef CONFIG_E500
>  #ifdef CONFIG_PPC32
> +#ifndef CONFIG_PPC_E500MC
>         {       /* e500 */
>                 .pvr_mask               = 0xffff0000,
>                 .pvr_value              = 0x80200000,
> @@ -2069,6 +2070,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>                 .machine_check          = machine_check_e500,
>                 .platform               = "ppc8548",
>         },
> +#endif /* !CONFIG_PPC_E500MC */
>         {       /* e500mc */
>                 .pvr_mask               = 0xffff0000,
>                 .pvr_value              = 0x80230000,
> 

This looks a bit strange -- e500v2 gets excluded if PPC_E500MC, but
e500mc gets included in !PPC_E500MC?

-Scott
