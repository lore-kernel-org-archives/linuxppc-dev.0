Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BD4FB7CEC
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 22:28:48 +1100 (EST)
Date: Wed, 20 Jan 2010 12:28:43 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 03/11] powerpc/mpc5121: Add machine restart support
Message-ID: <20100120112843.GE5041@pengutronix.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-4-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
In-Reply-To: <1263932653-3634-4-git-send-email-agust@denx.de>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2010 at 09:24:05PM +0100, Anatolij Gustschin wrote:
> Add reset module registers representation and
> machine restart callback for mpc5121 platform.
>=20
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

Looks good to me. Minor nits below.

> ---
>  arch/powerpc/include/asm/mpc5xxx.h            |   14 +++++++++-
>  arch/powerpc/platforms/512x/mpc5121_ads.c     |    1 +
>  arch/powerpc/platforms/512x/mpc5121_generic.c |    1 +
>  arch/powerpc/platforms/512x/mpc512x.h         |    1 +
>  arch/powerpc/platforms/512x/mpc512x_shared.c  |   35 +++++++++++++++++++=
++++++
>  5 files changed, 51 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/as=
m/mpc5xxx.h
> index 5ce9c5f..0004986 100644
> --- a/arch/powerpc/include/asm/mpc5xxx.h
> +++ b/arch/powerpc/include/asm/mpc5xxx.h
> @@ -18,5 +18,17 @@
> =20
>  extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *node);
> =20
> -#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> +/* MPC512x Reset module registers */
> +struct mpc512x_reset_module {
> +	u32	rcwlr;	/* Reset Configuration Word Low Register */
> +	u32	rcwhr;	/* Reset Configuration Word High Register */
> +	u32	reserved1;
> +	u32	reserved2;
> +	u32	rsr;	/* Reset Status Register */
> +	u32	rmr;	/* Reset Mode Register */
> +	u32	rpr;	/* Reset Protection Register */
> +	u32	rcr;	/* Reset Control Register */
> +	u32	rcer;	/* Reset Control Enable Register */
> +};
> =20
> +#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index 441abc4..2f40404 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -68,4 +68,5 @@ define_machine(mpc5121_ads) {
>  	.init_IRQ		=3D mpc5121_ads_init_IRQ,
>  	.get_irq		=3D ipic_get_irq,
>  	.calibrate_decr		=3D generic_calibrate_decr,
> +	.restart		=3D mpc512x_restart,
>  };
> diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc=
/platforms/512x/mpc5121_generic.c
> index 2479de9..de4c3f7 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> @@ -55,4 +55,5 @@ define_machine(mpc5121_generic) {
>  	.init_IRQ		=3D mpc512x_init_IRQ,
>  	.get_irq		=3D ipic_get_irq,
>  	.calibrate_decr		=3D generic_calibrate_decr,
> +	.restart		=3D mpc512x_restart,
>  };
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index 22a5352..c38875c 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -12,5 +12,6 @@
>  #ifndef __MPC512X_H__
>  #define __MPC512X_H__
>  extern void __init mpc512x_init_IRQ(void);
> +extern void mpc512x_restart(char *cmd);
>  void __init mpc512x_declare_of_platform_devices(void);
>  #endif				/* __MPC512X_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 434d683..8a0d577 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -21,9 +21,44 @@
>  #include <asm/ipic.h>
>  #include <asm/prom.h>
>  #include <asm/time.h>
> +#include <asm/mpc5xxx.h>
> =20
>  #include "mpc512x.h"
> =20
> +static void __iomem *reset_module_base;

type here also?

> +
> +static int __init mpc512x_restart_init(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
> +	if (!np)
> +		return -1;
> +
> +	reset_module_base =3D of_iomap(np, 0);
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +

Drop this empty line?

> +arch_initcall(mpc512x_restart_init);
> +
> +void mpc512x_restart(char *cmd)
> +{
> +	struct mpc512x_reset_module *rm =3D reset_module_base;
> +
> +	if (rm) {
> +		/* Enable software reset "RSTE" */
> +		out_be32(&rm->rpr, 0x52535445);
> +		/* Set software hard reset */
> +		out_be32(&rm->rcr, 0x2);
> +	} else {
> +		printk(KERN_ERR ": Restart module not mapped.\n");

The colon is a leftover?

> +	}
> +	for (;;)
> +		;
> +}
> +
>  void __init mpc512x_init_IRQ(void)
>  {
>  	struct device_node *np;
> --=20
> 1.5.6.3
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktW6OsACgkQD27XaX1/VRvJMgCglLNGVQbO2wO0rSe2haiRZQ5t
PxsAn02B68+NO1BLQnfNtLHvmbYIOClD
=n91N
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
