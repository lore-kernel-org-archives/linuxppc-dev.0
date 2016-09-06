Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSpSB51SzzDrpg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 11:10:34 +1000 (AEST)
Message-ID: <1473124234.6491.36.camel@neuling.org>
Subject: Re: [PATCH 1/4] powerpc/book3s: Add a cpu table entry for different
 POWER9 revs
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Sep 2016 11:10:34 +1000
In-Reply-To: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Wed, 2016-08-24 at 15:03 +0530, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/cputable.h |=C2=A0=C2=A04 +++-
> =C2=A0arch/powerpc/kernel/cputable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
 19 +++++++++++++++++++
> =C2=A02 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index 82026b419341..f752e6f7cfbe 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -212,6 +212,7 @@ enum {
> =C2=A0#define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
> =C2=A0#define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> =C2=A0#define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
> +#define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
> =C2=A0
> =C2=A0#ifndef __ASSEMBLY__
> =C2=A0
> @@ -472,6 +473,7 @@ enum {
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVM=
ODE | CPU_FTR_VMX_COPY | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_=
DAWR | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_=
FTR_ARCH_300)
> +#define CPU_FTRS_POWER9_DD1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1)
> =C2=A0#define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU=
_FTR_SMT | \
> @@ -490,7 +492,7 @@ enum {
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0(CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_F=
TRS_POWER5 | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | =
CPU_FTRS_POWER8E | \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD=
1 | CPU_FTRS_CELL | \
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_PO=
WER9)
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_PO=
WER9 | CPU_FTRS_POWER9_DD1)
> =C2=A0#endif
> =C2=A0#else
> =C2=A0enum {
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 74248ab18e98..6c4646ac9234 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -506,6 +506,25 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
> =C2=A0		.machine_check_early	=3D __machine_check_early_realmode_p8,
> =C2=A0		.platform		=3D "power8",
> =C2=A0	},
> +	{	/* Power9 DD1*/
> +		.pvr_mask		=3D 0xffffff00,
> +		.pvr_value		=3D 0x004e0100,
> +		.cpu_name		=3D "POWER9 (raw)",
> +		.cpu_features		=3D CPU_FTRS_POWER9_DD1,
> +		.cpu_user_features	=3D COMMON_USER_POWER9,
> +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> +		.mmu_features		=3D MMU_FTRS_POWER9,
> +		.icache_bsize		=3D 128,
> +		.dcache_bsize		=3D 128,
> +		.num_pmcs		=3D 6,
> +		.pmc_type		=3D PPC_PMC_IBM,
> +		.oprofile_cpu_type	=3D "ppc64/power9",
> +		.oprofile_type		=3D PPC_OPROFILE_INVALID,
> +		.cpu_setup		=3D __setup_cpu_power9,
> +		.cpu_restore		=3D __restore_cpu_power9,
> +		.flush_tlb		=3D __flush_tlb_power9,
> +		.platform		=3D "power9",
> +	},
> =C2=A0	{	/* Power9 */
> =C2=A0		.pvr_mask		=3D 0xffff0000,
> =C2=A0		.pvr_value		=3D 0x004e0000,
