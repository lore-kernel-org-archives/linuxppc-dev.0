Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94DC9B6FDA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 23:36:46 +1100 (EST)
Date: Fri, 18 Mar 2011 13:36:37 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: "vooon341@gmail.com" <vooon341@gmail.com>
Subject: Re: [PATCH 1/4] powerpc/mpc512x: Add initial support for TWR-MPC5125
Message-ID: <20110318123637.GB2155@pengutronix.de>
References: <1300318163.12970.66.camel@desinto>
	<20110317212542.GB29231@pengutronix.de>
	<AANLkTimy3Qu=KiPp8mhAiuL=GzqUHuNLTZ3cwmNKkrF7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
In-Reply-To: <AANLkTimy3Qu=KiPp8mhAiuL=GzqUHuNLTZ3cwmNKkrF7@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2011 at 02:35:24PM +0300, vooon341@gmail.com wrote:

> diff --git a/arch/powerpc/platforms/512x/clock.c
> b/arch/powerpc/platforms/512x/clock.c
> index 3dc2a8d..5cadf8e 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -606,6 +606,21 @@ static void rate_clks_init(void)
>   */
>  struct clk dev_clks[2][32];
>=20
> +char *mpc512x_select_psc_compat(void)
> +{
> +	char *psc_compats[] =3D {
> +		"fsl,mpc5121-psc",
> +		"fsl,mpc5125-psc"
> +	};
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(psc_compats); i++)
> +		if (of_find_compatible_node(NULL, NULL, psc_compats[i]))
> +			return psc_compats[i];
> +
> +	return NULL;
> +}

Function looks good to me. Shouldn't that rather be in mpc512x_shared?

> +// IOCTL registers for USB1/FEC2

No c++-style comments, please (here and later).

> +static void mpc5125_psc_iopad_init(void __iomem *ioctl, char *name)
> +{
> +	struct device_node *np;
> +	const u32 *cell_index;
> +	char *default_psc =3D "fsl,mpc5125-psc";
> +	char *psc_name;
> +
> +	if (name)
> +		psc_name =3D name;
> +	else
> +		psc_name =3D default_psc;

Caller sets name to NULL. Is this really used?

> +
> +	for_each_compatible_node(np, NULL, psc_name) {
> +		cell_index =3D of_get_property(np, "cell-index", NULL);

I seem to recall 'cell-index' is deprecated. Grant?

> +		if (cell_index) {
> +			u8 __iomem *pscioctl;
> +			int psc_num =3D *cell_index;
> +			if (psc_num > 1)
> +				continue;
> +
> +			pscioctl =3D ioctl + PSC_TO_IOCTL_OFFSET(psc_num);
> +			out_8(pscioctl + IOCTL_PSCx_0, IOCTL_PSCx_0_MODE); // NOTE maybe wrong

Why is it 'maybe wrong'? Can it be improved somehow?

> +			out_8(pscioctl + IOCTL_PSCx_1, IOCTL_DEFAULT_MODE);
> +			out_8(pscioctl + IOCTL_PSCx_2, IOCTL_DEFAULT_MODE);
> +			out_8(pscioctl + IOCTL_PSCx_3, IOCTL_DEFAULT_MODE);
> +			out_8(pscioctl + IOCTL_PSCx_4, IOCTL_DEFAULT_MODE);

The defines make it much more readable, thanks.

> +		}
> +	}
> +}

Is this function really board-specific or platform specific?


> +static void mpc5125_fec2_usb_io_init(void __iomem *ioctl, int isusb)
> +{
> +	int i;
> +	const u8 offset[12] =3D {
> +		IOCTL_USB1_DATA0, IOCTL_USB1_DATA1,
> +		IOCTL_USB1_DATA2, IOCTL_USB1_DATA3,
> +		IOCTL_USB1_DATA4, IOCTL_USB1_DATA5,
> +		IOCTL_USB1_DATA6, IOCTL_USB1_DATA7,
> +		IOCTL_USB1_STOP, IOCTL_USB1_CLK,
> +		IOCTL_USB1_NEXT, IOCTL_USB1_DIR
> +	};
> +	u8 mode;
> +
> +	mode =3D (isusb) ? IOCTL_DEFAULT_MODE : IOCTL_FEC2_MODE;
> +	for (i =3D 0; i < ARRAY_SIZE(offset); i++)
> +		out_8(ioctl + offset[i], mode);
> +}

Same question here and later. If it is board specific, the function name sh=
ould
have something like 'twr' in it; but a few things seem mpc5125-generic
to me, if I am not mistaken?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2DUdUACgkQD27XaX1/VRtRhwCfU5saH7ThSl1WsdlSseySqvbF
BFEAoKskDlkkz53myb4FpvOBlMdAtUS1
=554E
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
