Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 550511A0793
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 15:38:35 +1000 (EST)
Message-ID: <1405660235.7952.5.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc: Add cputable definition for POWER8 DD1
From: Michael Neuling <mikey@neuling.org>
To: Joel Stanley <joel@jms.id.au>
Date: Fri, 18 Jul 2014 15:10:35 +1000
In-Reply-To: <1405649497-679-1-git-send-email-joel@jms.id.au>
References: <1405649497-679-1-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, anton@samba.org, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-07-18 at 11:41 +0930, Joel Stanley wrote:
> These processors do not currently support doorbell IPIs, so remove them
> from the feature list if we are at DD 1.xx for the 0x004d part.

We GAed with DD2.1 and generally we don't upstream anything that isn't
GAed.  Plus, if you wanna go down this path, you are going to have to
fix a lot more bugs than this one (not that our early chips had bugs or
anything). =20

I suggested you crush your crappy DD1 parts into cubes and ask for some
shiny new DD2.1 parts.

> This fixes a regression caused by d4e58e5928f8 (powerpc/powernv: Enable
> POWER8 doorbell IPIs). With that patch the kernel would hang at boot
> when calling smp_call_function_many, as the doorbell would not be
> received by the target CPUs:
>=20
>   .smp_call_function_many+0x2bc/0x3c0 (unreliable)
>   .on_each_cpu_mask+0x30/0x100
>   .cpuidle_register_driver+0x158/0x1a0
>   .cpuidle_register+0x2c/0x110
>   .powernv_processor_idle_init+0x23c/0x2c0
>   .do_one_initcall+0xd4/0x260
>   .kernel_init_freeable+0x25c/0x33c
>   .kernel_init+0x1c/0x120
>   .ret_from_kernel_thread+0x58/0x7c

Humm, well doorbells worked on DD1 so i'm not sure this is entirely your
problem.  There was an issue related to powersave that Ian posted a fix
for but we never needed it as the issue was fixed before GA.

http://patchwork.ozlabs.org/patch/240338/

So NAK again.

Mikey

> Fixes: d4e58e5928f8 (powerpc/powernv: Enable POWER8 doorbell IPIs)
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/include/asm/cputable.h |  1 +
>  arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index bc23477..0fdd7ee 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -447,6 +447,7 @@ extern const char *powerpc_base_platform;
>  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
>  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
>  #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
> +#define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 965291b..0c15764 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -527,6 +527,26 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
>  		.machine_check_early	=3D __machine_check_early_realmode_p8,
>  		.platform		=3D "power8",
>  	},
> +	{	/* Power8 DD1: Does not support doorbell IPIs */
> +		.pvr_mask		=3D 0xffffff00,
> +		.pvr_value		=3D 0x004d0100,
> +		.cpu_name		=3D "POWER8 (raw)",
> +		.cpu_features		=3D CPU_FTRS_POWER8_DD1,
> +		.cpu_user_features	=3D COMMON_USER_POWER8,
> +		.cpu_user_features2	=3D COMMON_USER2_POWER8,
> +		.mmu_features		=3D MMU_FTRS_POWER8,
> +		.icache_bsize		=3D 128,
> +		.dcache_bsize		=3D 128,
> +		.num_pmcs		=3D 6,
> +		.pmc_type		=3D PPC_PMC_IBM,
> +		.oprofile_cpu_type	=3D "ppc64/power8",
> +		.oprofile_type		=3D PPC_OPROFILE_INVALID,
> +		.cpu_setup		=3D __setup_cpu_power8,
> +		.cpu_restore		=3D __restore_cpu_power8,
> +		.flush_tlb		=3D __flush_tlb_power8,
> +		.machine_check_early	=3D __machine_check_early_realmode_p8,
> +		.platform		=3D "power8",
> +	},
>  	{	/* Power8 */
>  		.pvr_mask		=3D 0xffff0000,
>  		.pvr_value		=3D 0x004d0000,
