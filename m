Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8BF4CDDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:59:05 +1000 (EST)
Date: Mon, 28 Apr 2008 10:58:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-Id: <20080428105859.daef4d71.sfr@canb.auug.org.au>
In-Reply-To: <20080427152546.1e26b145@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__28_Apr_2008_10_58_59_+1000_ZXYvZopi8iXU7oyn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__28_Apr_2008_10_58_59_+1000_ZXYvZopi8iXU7oyn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Sun, 27 Apr 2008 15:25:46 -0400 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> +++ b/arch/powerpc/platforms/44x/warp-nand.c
> @@ -11,8 +11,10 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/ndfc.h>
> +#include <linux/of_platform.h>

You really want linux.of.h (unless there was some preexisting reason to
require of_platform.h).

> +static void pika_setup_critical_temp(struct i2c_client *client)
> +{
> +	struct device_node *np;
> +	int irq, rc;
> +
> +	/* Setup power LEDS for possible critical temp */
> +	np =3D of_find_compatible_node(NULL, NULL, "ibm,gpio-440EP");
> +	if (np)
> +		np =3D of_find_compatible_node(np, NULL, "ibm,gpio-440EP");

Did you really mean to test if (!np) above instead?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__28_Apr_2008_10_58_59_+1000_ZXYvZopi8iXU7oyn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFSFXTgG2atn1QN8RAphbAJ9ggVntIYj55N3vTIjBx4LN+4nyiACfTz0Q
4nh08+7GnYEalswZ1XVCG6Q=
=QY41
-----END PGP SIGNATURE-----

--Signature=_Mon__28_Apr_2008_10_58_59_+1000_ZXYvZopi8iXU7oyn--
