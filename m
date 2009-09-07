Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1CD05B7B96
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 18:13:48 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 5F389DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 18:13:45 +1000 (EST)
Date: Mon, 7 Sep 2009 10:13:35 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Damien Dusha <d.dusha@gmail.com>
Subject: Re: [PATCH] mpc512x: Reset module
Message-ID: <20090907081335.GA3190@pengutronix.de>
References: <c788c1220909061706i3c1c2c52rc1284e0ad416cb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <c788c1220909061706i3c1c2c52rc1284e0ad416cb7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 07, 2009 at 10:06:01AM +1000, Damien Dusha wrote:
> Dear all,
>=20
> I have written a small patch to get the software reset working on the
> mpc5121.=A0 It is similar to the reset driver found in
> arch/powerpc/platforms/83xx/misc.c except it has been modified to look
> for the reset node in the device tree before writing to the reset
> module.

Heh, my patch looks quite similar :)

=46rom: Wolfram Sang <w.sang@pengutronix.de>
Subject: mpc5121: add restart capability

Hack? Not intended for upstream yet.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/platforms/512x/mpc5121_generic.c |   32 +++++++++++++++++++++=
+++++
 1 file changed, 32 insertions(+)

Index: arch/powerpc/platforms/512x/mpc5121_generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/512x/mpc5121_generic.c.orig
+++ arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -20,6 +20,7 @@
 #include <asm/ipic.h>
 #include <asm/prom.h>
 #include <asm/time.h>
+#include <asm/mpc512x.h>
=20
 #include "mpc512x.h"
=20
@@ -49,6 +50,36 @@ static int __init mpc5121_generic_probe(
 	return board[i] !=3D NULL;
 }
=20
+static void mpc5121_restart(char *cmd) {
+
+	struct mpc512x_reset_module *rm;
+	struct device_node *rmnode;
+
+	/* HACK: Proably not good from IRQ context */
+
+	rmnode =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
+	if (!rmnode) {
+		printk(KERN_ERR "Missing 'fsl,mpc5121-reset' "
+						"node in device tree!\n");
+		goto out;
+	}
+
+	rm =3D of_iomap(rmnode, 0);
+	if (!rm) {
+		printk(KERN_ERR	"Error mapping reset module node!\n");
+		goto out;
+	}
+
+	local_irq_disable();
+
+	/* Unlock register first, then reset */
+	out_be32(&rm->rpr, 0x52535445);
+	out_be32(&rm->rcr, 0x00000002);
+out:
+	while (1) ;
+}
+
 define_machine(mpc5121_generic) {
 	.name			=3D "MPC5121 generic",
 	.probe			=3D mpc5121_generic_probe,
@@ -56,4 +89,5 @@ define_machine(mpc5121_generic) {
 	.init_IRQ		=3D mpc512x_init_IRQ,
 	.get_irq		=3D ipic_get_irq,
 	.calibrate_decr		=3D generic_calibrate_decr,
+	.restart		=3D mpc5121_restart,
 };



There is one reason which I wanted to check before submitting this (alas, no
time :( ). From mpc52xx_common.c:

=2E..
/*
 * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restart=
().
 * Permanent mapping is required because mpc52xx_restart() can be called
 * from interrupt context while node mapping (which calls ioremap())
 * cannot be used at such point.
 */
static DEFINE_SPINLOCK(mpc52xx_lock);
static struct mpc52xx_gpt __iomem *mpc52xx_wdt;
=2E..

I think this may be needed here also...

>=20
> Comments are welcome.  It's my first patch to the mailing list, so
> I'll apologise in advance for any problems with the submission
> procedure.
>=20
> Damien.

> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index a8976b4..16ca250 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -70,4 +70,5 @@ define_machine(mpc5121_ads) {
>  	.init_IRQ		=3D mpc5121_ads_init_IRQ,
>  	.get_irq		=3D ipic_get_irq,
>  	.calibrate_decr		=3D generic_calibrate_decr,
> +    .restart        =3D mpc512x_restart,

Please use tabs and not spaces (See CodingStyle).

>  };
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index f4db8a7..d77f0ab 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -14,5 +14,6 @@
>  extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
>  extern void __init mpc512x_init_IRQ(void);
>  extern void __init mpc512x_init_i2c(void);
> +extern void mpc512x_restart(char *cmd);

Um, do we need that?

>  void __init mpc512x_declare_of_platform_devices(void);
>  #endif				/* __MPC512X_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 135fd6b..deddafc 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -22,6 +22,7 @@
>  #include <asm/prom.h>
>  #include <asm/time.h>
> =20
> +#include <asm/mpc512x.h>
>  #include "mpc512x.h"
> =20
>  unsigned long
> @@ -89,6 +90,33 @@ void __init mpc512x_init_i2c(void)
>  	}
>  }
> =20
> +void mpc512x_restart(char *cmd)
> +{
> +    struct device_node *np;

Again spaces instead of a tab.

> +    struct mpc512x_reset_module *rm;
> +
> +    local_irq_disable();
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
> +
> +	if (np) {
> +
> +        rm =3D of_iomap(np, 0);
> +		if (rm) {

Here you used tabs :)

> +
> +            /* Enable software reset "RSTE" (in hex) */
> +            out_be32( &(rm->rpr) , 0x52535445);
> +
> +            /* Set the software hard reset */
> +            out_be32( &(rm->rcr), 0x2);
> +        }
> +	}

While one probably won't see that because the reset comes immediately, the =
flow
of code may lead to the false assumption that the following error message g=
ets
printed if somebody doesn't have knowledge about this controller.

> +
> +    printk (KERN_EMERG "Error: Unable to map reset module, spinning fore=
ver!\n");

KERN_ERR should be enough, I think.

> +    for(;;);
> +}
> +
> +
>  /*
>   * Nodes to do bus probe on, soc and localbus
>   */

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqkwK8ACgkQD27XaX1/VRvA6gCfZPwx4l4Kx5stFNxw6vJXndBd
ItcAoKVsxdZDvK0gr1akRlr9AL5OMXjY
=bqMt
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
