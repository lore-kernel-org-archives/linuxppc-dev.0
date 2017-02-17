Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPZPN0XWbzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 11:57:28 +1100 (AEDT)
Message-ID: <1487293046.32732.3.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Detect POWER9 architected mode
From: Michael Neuling <mikey@neuling.org>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 17 Feb 2017 11:57:26 +1100
In-Reply-To: <20170216235900.15629-1-ruscur@russell.cc>
References: <20170216235900.15629-1-ruscur@russell.cc>
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

Can you make the comment/title a bit more descriptive...  Have a look at
c674e703cb1028e468527163074810b4a17bf379 where we added the p8.


> Signed-off-by: Russell Currey <ruscur@russell.cc>

Other than that, the code looks good..

Acked-By: Michael Neuling <mikey@neuling.org>



> ---
> =C2=A0arch/powerpc/kernel/cputable.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 6a82ef039c50..d23a54b09436 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
> =C2=A0		.machine_check_early	=3D
> __machine_check_early_realmode_p8,
> =C2=A0		.platform		=3D "power8",
> =C2=A0	},
> +	{	/* 3.00-compliant processor, i.e. Power9 "architected" mode
> */
> +		.pvr_mask		=3D 0xffffffff,
> +		.pvr_value		=3D 0x0f000005,
> +		.cpu_name		=3D "POWER9 (architected)",
> +		.cpu_features		=3D CPU_FTRS_POWER9,
> +		.cpu_user_features	=3D COMMON_USER_POWER9,
> +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> +		.mmu_features		=3D MMU_FTRS_POWER9,
> +		.icache_bsize		=3D 128,
> +		.dcache_bsize		=3D 128,
> +		.num_pmcs		=3D 6,
> +		.pmc_type		=3D PPC_PMC_IBM,
> +		.oprofile_cpu_type	=3D "ppc64/ibm-compat-v1",
> +		.oprofile_type		=3D PPC_OPROFILE_INVALID,
> +		.cpu_setup		=3D __setup_cpu_power9,
> +		.cpu_restore		=3D __restore_cpu_power9,
> +		.flush_tlb		=3D __flush_tlb_power9,
> +		.platform		=3D "power9",
> +	},
> =C2=A0	{	/* Power7 */
> =C2=A0		.pvr_mask		=3D 0xffff0000,
> =C2=A0		.pvr_value		=3D 0x003f0000,
