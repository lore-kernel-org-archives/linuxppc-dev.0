Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A0418DDF38
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 14:17:00 +1100 (EST)
Date: Wed, 9 Jan 2008 14:16:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 7/7] Add MPC512x PSC serial driver
Message-Id: <20080109141649.04a1783c.sfr@canb.auug.org.au>
In-Reply-To: <1199808093-15929-8-git-send-email-jrigby@freescale.com>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>
	<1199808093-15929-8-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_14_16_49_+1100_gswNDRYK/kay9iWZ"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_14_16_49_+1100_gswNDRYK/kay9iWZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue,  8 Jan 2008 09:01:33 -0700 John Rigby <jrigby@freescale.com> wrote:
>
> +++ b/drivers/serial/mpc512x_uart.c
>
> +#include <asm/of_platform.h>

Purely to avoid suggestions of favouritism, I will not the above. :-)

> +static struct of_device_id mpc512x_uart_of_match[] =3D {

Please make this const.

> +static void mpc512x_uart_of_enumerate(void)
> +{

> +	for_each_node_by_type(np, "serial") {
> +		if (!of_match_node(mpc512x_uart_of_match, np))
> +			continue;
> +
> +		/* Is a particular device number requested? */
> +		devno =3D of_get_property(np, "port-number", NULL);
> +		mpc512x_uart_of_assign(of_node_get(np), devno ? *devno : -1);

This of_node_get() should be in mpc512x_uart_of_assign() where the
reference is kept.

> +static struct of_platform_driver mpc512x_uart_of_driver =3D {
> +	.owner =3D THIS_MODULE,
> +	.name =3D "mpc52xx-psc-uart",

You don't need these two (we are removing them) but move the .owner
assignment to the .driver part below.

> +	.match_table =3D mpc512x_uart_of_match,
> +	.probe =3D mpc512x_uart_of_probe,
> +	.remove =3D mpc512x_uart_of_remove,
> +#ifdef CONFIG_PM
> +	.suspend =3D mpc512x_uart_of_suspend,
> +	.resume =3D mpc512x_uart_of_resume,
> +#endif
> +	.driver =3D {
> +		   .name =3D "mpc52xx-psc-uart",
> +		   },
> +};

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_14_16_49_+1100_gswNDRYK/kay9iWZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhDylTgG2atn1QN8RAsHIAJsHg9nyB5zxKZW/xyDL0UKNh2BuIgCdGoq6
iz1k89y2fnZbeTcDkZ+/8NA=
=1qpO
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_14_16_49_+1100_gswNDRYK/kay9iWZ--
