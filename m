Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8057E474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:15:10 +1100 (EST)
Date: Thu, 29 Jan 2009 22:15:05 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/8] powerpc/5200: Stop using device_type and
	port-number properties
Message-ID: <20090129211505.GB1406@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205512.31232.99373.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
In-Reply-To: <20090121205512.31232.99373.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2009 at 01:55:13PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> There is no reason for the PSC UART driver or the Ethernet driver
> to require a device_type property.  The compatible value is sufficient
> to uniquely identify the device.  Remove it from the driver.
>=20
> The whole 'port-number' scheme for assigning numbers to PSC uarts was
> always rather half baked and just adds complexity.  Remove it from the
> driver.  After this patch is applied, PSC UART numbers are simply
> assigned from the order they are found in the device tree (just like
> all the other devices).  Userspace can query sysfs to determine what
> ttyPSC number is assigned to each PSC instance.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Wolfram Sang <w.sang@pengutronix.de>

I like it. One more optimization below, but it's also good for now...

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
>  drivers/net/fec_mpc52xx.c     |    6 +++---
>  drivers/serial/mpc52xx_uart.c |   38 ++++++++++-------------------------=
---
>  2 files changed, 13 insertions(+), 31 deletions(-)
>=20
>=20
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index cd8e98b..049b0a7 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -1123,9 +1123,9 @@ static int mpc52xx_fec_of_resume(struct of_device *=
op)
>  #endif
> =20
>  static struct of_device_id mpc52xx_fec_match[] =3D {
> -	{ .type =3D "network", .compatible =3D "fsl,mpc5200b-fec", },
> -	{ .type =3D "network", .compatible =3D "fsl,mpc5200-fec", },
> -	{ .type =3D "network", .compatible =3D "mpc5200-fec", },
> +	{ .compatible =3D "fsl,mpc5200b-fec", },
> +	{ .compatible =3D "fsl,mpc5200-fec", },
> +	{ .compatible =3D "mpc5200-fec", },
>  	{ }
>  };
> =20
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
> index 0c3a2ab..d73d7da 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -50,8 +50,8 @@
>  /* OF Platform device Usage :
>   *
>   * This driver is only used for PSCs configured in uart mode.  The device
> - * tree will have a node for each PSC in uart mode w/ device_type =3D "s=
erial"
> - * and "mpc52xx-psc-uart" in the compatible string
> + * tree will have a node for each PSC with "mpc52xx-psc-uart" in the com=
patible
> + * list.
>   *
>   * By default, PSC devices are enumerated in the order they are found.  =
However
>   * a particular PSC number can be forces by adding 'device_no =3D <port#=
>'
> @@ -1212,30 +1212,18 @@ mpc52xx_uart_of_resume(struct of_device *op)
>  #endif
> =20
>  static void
> -mpc52xx_uart_of_assign(struct device_node *np, int idx)
> +mpc52xx_uart_of_assign(struct device_node *np)
>  {
> -	int free_idx =3D -1;
>  	int i;
> =20
> -	/* Find the first free node */
> +	/* Find the first free PSC number */
>  	for (i =3D 0; i < MPC52xx_PSC_MAXNUM; i++) {
>  		if (mpc52xx_uart_nodes[i] =3D=3D NULL) {
> -			free_idx =3D i;
> -			break;
> +			of_node_get(np);
> +			mpc52xx_uart_nodes[i] =3D np;
> +			return;
>  		}
>  	}
> -
> -	if ((idx < 0) || (idx >=3D MPC52xx_PSC_MAXNUM))
> -		idx =3D free_idx;
> -
> -	if (idx < 0)
> -		return; /* No free slot; abort */
> -
> -	of_node_get(np);
> -	/* If the slot is already occupied, then swap slots */
> -	if (mpc52xx_uart_nodes[idx] && (free_idx !=3D -1))
> -		mpc52xx_uart_nodes[free_idx] =3D mpc52xx_uart_nodes[idx];
> -	mpc52xx_uart_nodes[idx] =3D np;
>  }
> =20
>  static void
> @@ -1243,23 +1231,17 @@ mpc52xx_uart_of_enumerate(void)
>  {
>  	static int enum_done;
>  	struct device_node *np;
> -	const unsigned int *devno;
>  	const struct  of_device_id *match;
>  	int i;
> =20
>  	if (enum_done)
>  		return;
> =20
> -	for_each_node_by_type(np, "serial") {
> +	/* Assign index to each PSC in device tree */
> +	for_each_matching_node(np, mpc52xx_uart_of_match) {
>  		match =3D of_match_node(mpc52xx_uart_of_match, np);
> -		if (!match)
> -			continue;
> -
>  		psc_ops =3D match->data;
> -
> -		/* Is a particular device number requested? */
> -		devno =3D of_get_property(np, "port-number", NULL);
> -		mpc52xx_uart_of_assign(np, devno ? *devno : -1);
> +		mpc52xx_uart_of_assign(np);
>  	}
> =20
>  	enum_done =3D 1;
>=20

You could drop the for-loop which follows here and put its dev_dbg into
uart_of_assign when a node was found. Would also get rid of 'i' here.

Regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCHFkACgkQD27XaX1/VRvB5ACgvS/FJCxmGIFvftnee2YGtaYs
i58An3HKIxZ1MKT8qenToq8Ynvpw9/lD
=IeKz
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
