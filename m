Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CE619DDE18
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 15:27:18 +1100 (EST)
Date: Sun, 4 Nov 2007 15:27:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v2 10/12] [POWERPC] Motion-PRO: Add LED support.
Message-Id: <20071104152716.a38dc9f7.sfr@canb.auug.org.au>
In-Reply-To: <20071103235311.31906.23754.stgit@hekate.izotz.org>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235311.31906.23754.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__4_Nov_2007_15_27_16_+1100_hv33tocqA28QVsIH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__4_Nov_2007_15_27_16_+1100_hv33tocqA28QVsIH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Sun, 04 Nov 2007 00:53:11 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/drivers/leds/leds-motionpro.c
> @@ -0,0 +1,240 @@
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/mpc52xx.h>
> +#include <asm/io.h>
> +#include <asm/of_platform.h>

You want <linux/of_platform.h> instead of <asm/..> and probably not
<linux/platform_device.h> above.

> +static void mpled_timer_toggle(unsigned long data)
> +{
> +	struct motionpro_led *mpled =3D (struct motionpro_led *) data;
                                                              ^
Unnecessary space.

> +static int __devinit mpled_probe(struct of_device *op, const struct of_d=
evice_id *match)

Split this line.

> +{
> +	struct motionpro_led *mpled;
> +	const unsigned int *of_blink_delay =3D NULL;

You don't need to initialise this as you assign it before you use it.

> +	int err =3D 0;

Same here.

> +	if ((err =3D led_classdev_register(NULL, &mpled->mpled_cdev))) {

We would normally do the assignment separately from the check, so:

	err =3D led_classdev_register(NULL, &mpled->mpled_cdev);
	if (err) {

> +static struct of_platform_driver mpled_driver =3D {
> +	.owner		=3D THIS_MODULE,
> +	.name		=3D "leds-motionpro",
> +	.match_table	=3D mpled_match,
> +	.probe		=3D mpled_probe,
> +	.remove		=3D mpled_remove,
> +};

You should now use the name and owner fields of the embedded struct
device_driver, so:

static struct of_platform_driver mpled_driver =3D {
	.match_table	=3D mpled_match,
	.probe		=3D mpled_probe,
	.remove		=3D mpled_remove,
	.driver		=3D {
		.owner		=3D THIS_MODULE,
		.name		=3D "leds-motionpro",
	},
};

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__4_Nov_2007_15_27_16_+1100_hv33tocqA28QVsIH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHLUopTgG2atn1QN8RAqEUAJoDitIY66EOa8qpzuX2aKL9ZpQsawCeLA+k
dVqKUvHNoADKwJ+E3twr+mc=
=5CdL
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Nov_2007_15_27_16_+1100_hv33tocqA28QVsIH--
