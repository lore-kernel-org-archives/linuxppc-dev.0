Return-Path: <kumar.gala@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE304100973
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 18:17:17 +1100 (EST)
Received: from mail82-db3 (localhost.localdomain [127.0.0.1])	by
	mail82-db3-R.bigfish.com (Postfix) with ESMTP id 95B12B682E3	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jan 2011 07:02:05 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.252])	by
	mail82-db3.bigfish.com (Postfix) with ESMTP id 0DED7109007C	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jan 2011 07:01:28 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id p0P71NnT004348	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 00:01:23 -0700 (MST)
Subject: Re: [PATCH] e500: Erratum cpu a005 workaround
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1295935333-13045-1-git-send-email-yu.liu@freescale.com>
Date: Tue, 25 Jan 2011 01:01:23 -0600
Message-ID: <5DA54AEE-B8AC-452B-A56C-65B35391A97C@freescale.com>
References: <1295935333-13045-1-git-send-email-yu.liu@freescale.com>
To: Liu Yu <yu.liu@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 25, 2011, at 12:02 AM, Liu Yu wrote:

> This errata can occur if a single-precision floating-point, =
double-precision
> floating-point or vector floating-point instruction on a mispredicted =
branch
> path signals one of the floating-point data interrupts which are =
enabled by the
> SPEFSCR (FINVE, FDBZE, FUNFE or FOVFE bits).  This interrupt must be =
recorded
> in a one-cycle window when the misprediction is resolved.  If this =
extremely
> rare event should occur, the result could be:
>=20
> The SPE Data Exception from the mispredicted path may be reported
> erroneously if a single-precision floating-point, double-precision
> floating-point or vector floating-point instruction is the second =
instruction
> on the correct branch path.
>=20
> According to errata description, some efp instructions
> which are not supposed to trigger SPE exceptions
> can trigger the exceptions in this case.
> However, as we haven't emulated these instructions here,
> a signal will send to userspace, and userspace application would exit.
>=20
> This patch re-issue the efp instruction that we haven't emulated,
> so that hardware can properly execute it again if this case happen.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> This is an erratum workaround patch.
> It would be better if the patch can go into 2.6.38.
>=20
> arch/powerpc/include/asm/reg.h   |    2 +
> arch/powerpc/math-emu/math_efp.c |   53 =
+++++++++++++++++++++++++++++++++++++-
> 2 files changed, 54 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h =
b/arch/powerpc/include/asm/reg.h
> index 6315edc..0abfd91 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -833,6 +833,8 @@
> #define PVR_7450	0x80000000
> #define PVR_8540	0x80200000
> #define PVR_8560	0x80200000
> +#define PVR_VER_E500V1	0x8020
> +#define PVR_VER_E500V2	0x8021
> /*
>  * For the 8xx processors, all of them report the same PVR family for
>  * the PowerPC core. The various versions of these processors must be
> diff --git a/arch/powerpc/math-emu/math_efp.c =
b/arch/powerpc/math-emu/math_efp.c
> index 41f4ef3..634830b 100644
> --- a/arch/powerpc/math-emu/math_efp.c
> +++ b/arch/powerpc/math-emu/math_efp.c
> @@ -1,7 +1,7 @@
> /*
>  * arch/powerpc/math-emu/math_efp.c
>  *
> - * Copyright (C) 2006-2008 Freescale Semiconductor, Inc. All rights =
reserved.
> + * Copyright (C) 2006-2008, 2010 Freescale Semiconductor, Inc.
>  *
>  * Author: Ebony Zhu,	<ebony.zhu@freescale.com>
>  *         Yu Liu,	<yu.liu@freescale.com>
> @@ -104,6 +104,8 @@
> #define FP_EX_MASK	(FP_EX_INEXACT | FP_EX_INVALID | FP_EX_DIVZERO | =
\
> 			FP_EX_UNDERFLOW | FP_EX_OVERFLOW)
>=20
> +static int have_e500_cpu_a005_erratum;
> +
> union dw_union {
> 	u64 dp[1];
> 	u32 wp[2];
> @@ -652,6 +654,15 @@ update_regs:
> 	return 0;
>=20
> illegal:
> +	if (have_e500_cpu_a005_erratum) {
> +		/* according to e500 cpu a005 erratum, reissue efp inst =
*/
> +		regs->nip -=3D 4;
> +#ifdef DEBUG
> +		printk(KERN_DEBUG "re-issue efp inst: %08lx\n", =
speinsn);
> +#endif
> +		return 0;
> +	}
> +
> 	printk(KERN_ERR "\nOoops! IEEE-754 compliance handler =
encountered un-supported instruction.\ninst code: %08lx\n", speinsn);
> 	return -ENOSYS;
> }
> @@ -718,3 +729,43 @@ int speround_handler(struct pt_regs *regs)
>=20
> 	return 0;
> }
> +
> +int __init spe_mathemu_init(void)
> +{
> +	u32 pvr, maj, min;
> +
> +	pvr =3D mfspr(SPRN_PVR);
> +
> +	if ((PVR_VER(pvr) =3D=3D PVR_VER_E500V1) ||
> +	    (PVR_VER(pvr) =3D=3D PVR_VER_E500V2)) {
> +		maj =3D PVR_MAJ(pvr);
> +		min =3D PVR_MIN(pvr);
> +
> +		/*
> +		 * E500 revision below 1.1, 2.3, 3.1, 4.1, 5.1
> +		 * need cpu a005 errata workaround
> +		 */

This isn't the way to do this.  We normally add entries in cputable.c an =
add a new cpu_feature_bit for the errata.

Than above we'd do:

if (cur_cpu_spec->cpu_features & CPU_FTR_E500_A005_ERRATUM)


> +		switch (maj) {
> +		case 1:
> +			if (min < 1)
> +				have_e500_cpu_a005_erratum =3D 1;
> +			break;
> +		case 2:
> +			if (min < 3)
> +				have_e500_cpu_a005_erratum =3D 1;
> +			break;
> +		case 3:
> +		case 4:
> +		case 5:
> +			if (min < 1)
> +				have_e500_cpu_a005_erratum =3D 1;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(spe_mathemu_init);
> --=20
> 1.6.4
