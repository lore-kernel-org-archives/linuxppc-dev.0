Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 019981007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 16:44:39 +1100 (EST)
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111208160227.2ef2d526@kryten>
Date: Wed, 7 Dec 2011 23:44:40 -0600
Message-Id: <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
References: <20111208160227.2ef2d526@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: mikey@neuling.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2011, at 11:02 PM, Anton Blanchard wrote:

> Index: linux-build/arch/powerpc/include/asm/cputable.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-build.orig/arch/powerpc/include/asm/cputable.h	=
2011-09-07 15:15:49.096458526 +1000
> +++ linux-build/arch/powerpc/include/asm/cputable.h	2011-12-08 =
15:38:46.627313507 +1100
> @@ -201,6 +201,7 @@ extern const char *powerpc_base_platform
> #define CPU_FTR_POPCNTB			=
LONG_ASM_CONST(0x0400000000000000)
> #define CPU_FTR_POPCNTD			=
LONG_ASM_CONST(0x0800000000000000)
> #define CPU_FTR_ICSWX			=
LONG_ASM_CONST(0x1000000000000000)
> +#define CPU_FTR_POWER7			=
LONG_ASM_CONST(0x2000000000000000)
>=20
> #ifndef __ASSEMBLY__
>=20
> @@ -425,7 +426,7 @@ extern const char *powerpc_base_platform
> 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | =
CPU_FTR_POPCNTD | \
> -	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE)
> +	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | =
CPU_FTR_POWER7)
> #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> Index: linux-build/arch/powerpc/lib/copyuser_64.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-build.orig/arch/powerpc/lib/copyuser_64.S	2011-09-07 =
15:15:49.146459439 +1000
> +++ linux-build/arch/powerpc/lib/copyuser_64.S	2011-12-08 =
15:38:42.491238635 +1100
> @@ -11,6 +11,12 @@
>=20
> 	.align	7
> _GLOBAL(__copy_tofrom_user)
> +BEGIN_FTR_SECTION
> +	nop
> +FTR_SECTION_ELSE
> +	b	__copy_tofrom_user_power7
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER7)
> +_GLOBAL(__copy_tofrom_user_base)
> 	/* first check for a whole page copy on a page boundary */
> 	cmpldi	cr1,r5,16
> 	cmpdi	cr6,r5,4096

Can we find a means to do the fixup that does NOT require a FTR bit?  I =
have the feeling FSL will want to have various optimized copy functions =
for our different cores and I hate to blow features bits just for this.

- k=
