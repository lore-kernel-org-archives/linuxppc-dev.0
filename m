Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 02A412C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 02:51:22 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Corenet: Add QE platform support for Corenet
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1393577309-41445-1-git-send-email-B45475@freescale.com>
Date: Mon, 3 Mar 2014 09:51:08 -0600
Message-Id: <62FC0C4F-26FD-44B4-BC07-BDF1904AE637@kernel.crashing.org>
References: <1393577309-41445-1-git-send-email-B45475@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 28, 2014, at 2:48 AM, Zhao Qiang <B45475@freescale.com> wrote:

> There is QE on platform T104x, add support.
> Call funcs qe_ic_init and qe_init if CONFIG_QUICC_ENGINE is defined.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> arch/powerpc/platforms/85xx/corenet_generic.c | 32 =
+++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Can you use mpc85xx_qe_init() instead?

>=20
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c =
b/arch/powerpc/platforms/85xx/corenet_generic.c
> index fbd871e..f8c8e0c 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -26,6 +26,8 @@
> #include <asm/udbg.h>
> #include <asm/mpic.h>
> #include <asm/ehv_pic.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
>=20
> #include <linux/of_platform.h>
> #include <sysdev/fsl_soc.h>
> @@ -38,6 +40,10 @@ void __init corenet_gen_pic_init(void)
> 	unsigned int flags =3D MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
> 		MPIC_NO_RESET;
>=20
> +#ifdef CONFIG_QUICC_ENGINE
> +	struct device_node *np;
> +#endif
> +
> 	if (ppc_md.get_irq =3D=3D mpic_get_coreint_irq)
> 		flags |=3D MPIC_ENABLE_COREINT;
>=20
> @@ -45,6 +51,16 @@ void __init corenet_gen_pic_init(void)
> 	BUG_ON(mpic =3D=3D NULL);
>=20
> 	mpic_init(mpic);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (np) {
> +		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +				qe_ic_cascade_high_mpic);
> +		of_node_put(np);
> +	}
> +#endif
> +
> }
>=20
> /*
> @@ -52,11 +68,24 @@ void __init corenet_gen_pic_init(void)
>  */
> void __init corenet_gen_setup_arch(void)
> {
> +#ifdef CONFIG_QUICC_ENGINE
> +	struct device_node *np;
> +#endif
> 	mpc85xx_smp_init();
>=20
> 	swiotlb_detect_4g();
>=20
> 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!np) {
> +		pr_err("%s: Could not find Quicc Engine node\n", =
__func__);
> +		return;

This doesn=92t seem like an reasonable error message for common corenet =
platform.  It seems reasonable to build QE support but boot on a chip =
w/o QE.

> +	}
> +	qe_reset();
> +	of_node_put(np);
> +#endif
> }
>=20
> static const struct of_device_id of_device_ids[] =3D {
> @@ -81,6 +110,9 @@ static const struct of_device_id of_device_ids[] =3D =
{
> 	{
> 		.compatible	=3D "fsl,qoriq-pcie-v3.0",
> 	},
> +	{
> +		.compatible	=3D "fsl,qe",
> +	},
> 	/* The following two are for the Freescale hypervisor */
> 	{
> 		.name		=3D "hypervisor",
> --=20
> 1.8.5
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
