Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8096B6FCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 08:25:48 +1100 (EST)
Date: Thu, 17 Mar 2011 22:25:42 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Vladimir Ermakov <vooon341@gmail.com>
Subject: Re: [PATCH 1/4] powerpc/mpc512x: Add initial support for TWR-MPC5125
Message-ID: <20110317212542.GB29231@pengutronix.de>
References: <1300318163.12970.66.camel@desinto>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
In-Reply-To: <1300318163.12970.66.camel@desinto>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

(if possible, please provide a diffstat with the patches)

> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms=
/512x/clock.c
> index 3dc2a8d..962c0ba 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -669,6 +669,13 @@ static void psc_calc_rate(struct clk *clk, int pscnu=
m, struct device_node *np)
>  	clk->rate =3D mclk_src / mclk_div;
>  }
> =20
> +
> +#ifdef CONFIG_PPC_MPC5125
> +#define PSC_PREFIX "mpc5125"
> +#else
> +#define PSC_PREFIX "mpc5121"
> +#endif
> +
>  /*
>   * Find all psc nodes in device tree and assign a clock
>   * with name "psc%d_mclk" and dev pointing at the device
> @@ -680,7 +687,7 @@ static void psc_clks_init(void)
>  	const u32 *cell_index;
>  	struct platform_device *ofdev;
> =20
> -	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
> +	for_each_compatible_node(np, NULL, "fsl," PSC_PREFIX "-psc") {

Uh, that makes it impossible to have one kernel for mpc5121/5.

> -void __init mpc512x_psc_fifo_init(void)
> +void __init mpc512x_psc_fifo_init(char *psc_name)
>  {
>  	struct device_node *np;
>  	void __iomem *psc;
>  	unsigned int tx_fifo_size;
>  	unsigned int rx_fifo_size;
> +	char *default_psc =3D "fsl,mpc5121-psc";
>  	int fifobase =3D 0; /* current fifo address in 32 bit words */
> =20
> -	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
> +	if (!psc_name)
> +		psc_name =3D default_psc;
> +
> +	for_each_compatible_node(np, NULL, psc_name) {

I think this goes more to the right direction, although you passed the
non-default string for mpc5125 in the board-config, which is the wrong plac=
e,
because it is a platform thing.

What about something like:

	if of_find_compatible_node(startpoint, NULL, "fsl,mpc5121-psc")
		psc_compat =3D "fsl,mpc5121-psc";
	else if of_find_compatible_node(startpoint, NULL, "fsl,mpc5125-psc")
		psc_compat =3D "fsl,mpc5125-psc";
	else if
		/* Problem handling */

Dunno, might be worth to put it into a function as it could be used here an=
d in
the block above.

Also, I noticed quite a number of magic values (e.g. 0x76). I guess those a=
re
register and bit names, which should be used instead.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2CfFYACgkQD27XaX1/VRsmcwCfdqwIn6V6VDwm7wZXm1PDHXmx
0mcAnirFHcCmZ4TqqNXbXfOOWsDPFauA
=U2sn
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
