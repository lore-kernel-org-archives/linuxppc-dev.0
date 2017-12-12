Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywpb50rq4zDrT9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 16:41:05 +1100 (AEDT)
Date: Tue, 12 Dec 2017 14:55:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc: Add a CPU feature bit for TM bug
 workarounds on POWER9 DD2.2
Message-ID: <20171212035544.GL2226@umbus.fritz.box>
References: <20171208060803.relvzabipgl2lub6@rohan>
 <20171208060924.fthehkna7bsnjowx@rohan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4e5ZDkbgLEOfWmLx"
In-Reply-To: <20171208060924.fthehkna7bsnjowx@rohan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4e5ZDkbgLEOfWmLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 05:09:24PM +1100, Paul Mackerras wrote:
> This adds a CPU feature bit which is set for POWER9 DD2.2 processors
> which will be used to enable software emulation for some transactional
> memory instructions, in order to work around hardware bugs.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/cputable.h |  5 ++++-
>  arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index 53b31c2bcdf4..70cee46c046c 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -215,6 +215,7 @@ enum {
>  #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
>  #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
>  #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> +#define CPU_FTR_P9_TM_EMUL		LONG_ASM_CONST(0x2000000000000000)
>  #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
> =20
>  #ifndef __ASSEMBLY__
> @@ -478,6 +479,7 @@ enum {
>  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
>  #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
>  			     (~CPU_FTR_SAO))
> +#define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_P9_TM_EMUL)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> @@ -496,7 +498,8 @@ enum {
>  	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
>  	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
>  	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
> -	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD=
1)
> +	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
> +	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_2)
>  #endif
>  #else
>  enum {
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 760872916013..bb94bb6d9e4d 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -547,6 +547,26 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
>  		.machine_check_early	=3D __machine_check_early_realmode_p9,
>  		.platform		=3D "power9",
>  	},
> +	{	/* Power9 DD2.2 */
> +		.pvr_mask		=3D 0xffffffff,
> +		.pvr_value		=3D 0x004e1202,
> +		.cpu_name		=3D "POWER9 (raw)",
> +		.cpu_features		=3D CPU_FTRS_POWER9_DD2_2,
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
> +		.machine_check_early	=3D __machine_check_early_realmode_p9,
> +		.platform		=3D "power9",
> +	},
>  	{	/* Power9 */
>  		.pvr_mask		=3D 0xffff0000,
>  		.pvr_value		=3D 0x004e0000,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4e5ZDkbgLEOfWmLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlovUz4ACgkQbDjKyiDZ
s5JH3g/8DeakQuXnHqLsBGawy9ac2f/fIBmHNKx4AQwPcQFSSogcebQCQZ9G2RIY
JeLq2+hD11HQyXuBmWOksnmKZjt4ijreBHUEeFM/hGM6nPC/sKtfKG4+gkTOWbf2
+mNxBMr85KtMQ4xplQW/M6KrOdgLxVBZMSYhykC1TeNwHF4l6zunROm1ttFAGIxO
ETWpiKRSCp0YKj2ea7S16sgIy29gr20IdLNHdzLeOL1Q8w/mbszNFCwmoU2cKYO/
wgcKkQSsqX51omSBmlVX7WQUulGL9OZcZ7fPqUBkgrk12ge7safOmpuFEemcKom0
AwLwUTWtUGSHDoOIhIh88KXCFUQNShi5oNDSTl0RRJDFnOGUpQoKEtDPzDmdzC00
UjBillThmmaa9VeTn91GB0B98aTim1fSGtw66sWNAHSahtwEr9AzcRUieu4Lg5pI
MCrGYrhBUmoNzUTE7DRAg/pxoEkKpmKfvZWKFaHSO5l9VBVEscEUNg9eq68i/hp3
ftqJCUHAV+4sB4gID9bCxhucBk8MQbj04kv7Ahxgw8NZoMc8MOAROP4y4r3c6P4J
sD17yi6WYhVWR56emd+sbWEoYl6y4GzRfEoASyzuJieehVhyOtddw/U1pFlzoJT8
DcyWxULe4Mvoioyx3ZH6Tha7/8WKh53PCL3qGyKJocX48wspxgY=
=ELdm
-----END PGP SIGNATURE-----

--4e5ZDkbgLEOfWmLx--
