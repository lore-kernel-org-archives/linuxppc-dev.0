Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8AF40474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:24:28 +1100 (EST)
Date: Thu, 29 Jan 2009 22:24:24 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/8] powerpc/5200: Don't specify IRQF_SHARED in PSC
	UART driver
Message-ID: <20090129212424.GD1406@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205529.31232.64801.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
In-Reply-To: <20090121205529.31232.64801.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2009 at 01:55:29PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> The MPC5200 PSC device is wired up to a dedicated interrupt line
> which is never shared.  This patch removes the IRQF_SHARED flag
> from the request_irq() call which eliminates the "IRQF_DISABLED
> is not guaranteed on shared IRQs" warning message from the console
> output.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

What do I give here? Acked-by? Reviewed? Tested? :D I'll make a guess:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
>  drivers/serial/mpc52xx_uart.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
>=20
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index d73d7da..7f72f8c 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -522,7 +522,7 @@ mpc52xx_uart_startup(struct uart_port *port)
> =20
>  	/* Request IRQ */
>  	ret =3D request_irq(port->irq, mpc52xx_uart_int,
> -		IRQF_DISABLED | IRQF_SAMPLE_RANDOM | IRQF_SHARED,
> +		IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
>  		"mpc52xx_psc_uart", port);
>  	if (ret)
>  		return ret;
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCHogACgkQD27XaX1/VRvXggCgwz7tQDUxrEg6vwB6cHer5H8y
ChMAoKEa/kXz74CgKFD6d3zU6uvMMVOE
=ThcP
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
