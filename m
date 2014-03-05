Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B681F2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 04:14:44 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCh v2 2/2] Corenet: Add QE platform support for Corenet
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1394004092-4622-2-git-send-email-B45475@freescale.com>
Date: Wed, 5 Mar 2014 11:14:35 -0600
Message-Id: <72DA70B0-15AF-4774-8179-20DC1B275ADB@kernel.crashing.org>
References: <1394004092-4622-1-git-send-email-B45475@freescale.com>
 <1394004092-4622-2-git-send-email-B45475@freescale.com>
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


On Mar 5, 2014, at 1:21 AM, Zhao Qiang <B45475@freescale.com> wrote:

> There is QE on platform T104x, add support.
> Call funcs qe_ic_init and qe_init if CONFIG_QUICC_ENGINE is defined.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use mpc85xx_qe_init() instead
> arch/powerpc/platforms/85xx/corenet_generic.c | 25 =
+++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c =
b/arch/powerpc/platforms/85xx/corenet_generic.c
> index fbd871e..f1f4575 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -26,11 +26,14 @@
> #include <asm/udbg.h>
> #include <asm/mpic.h>
> #include <asm/ehv_pic.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
>=20
> #include <linux/of_platform.h>
> #include <sysdev/fsl_soc.h>
> #include <sysdev/fsl_pci.h>
> #include "smp.h"
> +#include "mpc85xx.h"
>=20
> void __init corenet_gen_pic_init(void)
> {
> @@ -38,6 +41,10 @@ void __init corenet_gen_pic_init(void)
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
> @@ -45,6 +52,16 @@ void __init corenet_gen_pic_init(void)
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

remove the #ifdef, they aren=92t really needed.

> }
>=20
> /*
> @@ -57,6 +74,11 @@ void __init corenet_gen_setup_arch(void)
> 	swiotlb_detect_4g();
>=20
> 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	mpc85xx_qe_init();
> +#endif

ifdef not needed

> +
> }
>=20
> static const struct of_device_id of_device_ids[] =3D {
> @@ -81,6 +103,9 @@ static const struct of_device_id of_device_ids[] =3D =
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
