Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4FB91007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Jan 2010 01:05:29 +1100 (EST)
Date: Sat, 2 Jan 2010 15:05:23 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next 3/3] powerpc/mpc5xxx: add OF platform binding
	doc for FSL MSCAN devices
Message-ID: <20100102140523.GD2239@pengutronix.de>
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>
	<1262420274-16586-2-git-send-email-wg@grandegger.com>
	<1262420274-16586-3-git-send-email-wg@grandegger.com>
	<1262420274-16586-4-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
In-Reply-To: <1262420274-16586-4-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Netdev@vger.kernel.org,
	Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 02, 2010 at 09:17:54AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> This patch adds documentation for the MSCAN OF device bindings for
> the MPC512x and moves the one for the MPC5200 to the new common file
> "Documentation/powerpc/dts-bindings/fsl/can.txt".
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Looks good to me (except for the typos ;))

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  Documentation/powerpc/dts-bindings/fsl/can.txt     |   53 ++++++++++++++=
++++++
>  Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |    9 +---
>  2 files changed, 54 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/fsl/can.txt
>=20
> diff --git a/Documentation/powerpc/dts-bindings/fsl/can.txt b/Documentati=
on/powerpc/dts-bindings/fsl/can.txt
> new file mode 100644
> index 0000000..44cfb61
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/fsl/can.txt
> @@ -0,0 +1,53 @@
> +CAN Device Tree Bindings
> +------------------------
> +
> +(c) 2006-2009 Secret Lab Technologies Ltd
> +Grant Likely <grant.likely@secretlab.ca>
> +
> +fsl,mpc5200-mscan nodes
> +-----------------------
> +In addition to the required compatible-, reg- and interrupt-properites, =
you can

properties.

> +also specify which clock source shall be used for the controller:
> +
> +- fsl,mscan-clock-source : a string describing the clock source. Valid v=
alues
> +			   are:	"ip" for ip bus clock
> +				 "ref" for reference clock (XTAL)
> +			   "ref" is default in case this property is not
> +			   present.
> +
> +fsl,mpc5121-mscan nodes
> +-----------------------
> +In addition to the required compatible-, reg- and interrupt-properites, =
you can

properties.

> +also specify which clock source shall be used for the controller:
> +
> +- fsl,mscan-clock-source : a string describing the clock source. Valid v=
alues
> +			   are:	"ip" for ip bus clock
> +				"ref" for reference clock
> +				"sys" for system clock
> +			   If this property is not present, an optimal CAN
> +			   clock source and frequency based on the system
> +			   will be selected. If this is not possible, the
> +			   reference clock will be used.
> +
> +- fsl,mscan-clock-divider: for the reference and system clock an additio=
nal
> +			   clock divider can be specified. By default a

I wonder if there should be a comma after 'default'. Maybe a native speaker=
 can
help?

> +			   value of 1 is used.
> +
> +Examples:
> +	can@1300 {
> +		compatible =3D "fsl,mpc5121-mscan";
> +		cell-index =3D <0>;
> +		interrupts =3D <12 0x8>;
> +		interrupt-parent =3D < &ipic >;
> +		reg =3D <0x1300 0x80>;
> +	};
> +
> +	can@1380 {
> +		compatible =3D "fsl,mpc5121-mscan";
> +		cell-index =3D <1>;
> +		interrupts =3D <13 0x8>;
> +		interrupt-parent =3D < &ipic >;
> +		reg =3D <0x1380 0x80>;
> +		fsl,mscan-clock-source =3D "ref";
> +		fsl,mscan-clock-divider =3D <3>;
> +	};
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documen=
tation/powerpc/dts-bindings/fsl/mpc5200.txt
> index 5c6602d..4ccb2cd 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> @@ -195,11 +195,4 @@ External interrupts:
> =20
>  fsl,mpc5200-mscan nodes
>  -----------------------
> -In addition to the required compatible-, reg- and interrupt-properites, =
you can
> -also specify which clock source shall be used for the controller:
> -
> -- fsl,mscan-clock-source- a string describing the clock source. Valid va=
lues
> -			  are:	"ip" for ip bus clock
> -				"ref" for reference clock (XTAL)
> -			  "ref" is default in case this property is not
> -			  present.
> +See file can.txt in this directory.
> --=20
> 1.6.2.5
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks/UqMACgkQD27XaX1/VRs+yQCfewSViQxaNvPNF/wB3IZZtp0M
h94Anih0tjDpCYwEYgjnbFDIKdOYnwAj
=BIsB
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
