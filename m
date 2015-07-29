Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE851A0DA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 01:30:22 +1000 (AEST)
Date: Wed, 29 Jul 2015 10:20:29 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <balbi@ti.com>, <gregkh@linuxfoundation.org>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>, <stern@rowland.harvard.edu>, <petr.cvek@tul.cz>
Subject: Re: [PATCH v4 04/46] staging: emxx_udc: add ep capabilities support
Message-ID: <20150729152029.GB32418@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
 <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
In-Reply-To: <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 11:16:14AM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
>=20
> Fixed typo in "epc-nulk" to "epc-bulk".
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++-------------=
------
>  1 file changed, 29 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_u=
dc/emxx_udc.c
> index 3b7aa36..0d64bee 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadget_=
ops =3D {
>  	.ioctl			=3D nbu2ss_gad_ioctl,
>  };
> =20
> -static const char g_ep0_name[] =3D "ep0";
> -static const char g_ep1_name[] =3D "ep1-bulk";
> -static const char g_ep2_name[] =3D "ep2-bulk";
> -static const char g_ep3_name[] =3D "ep3in-int";
> -static const char g_ep4_name[] =3D "ep4-iso";
> -static const char g_ep5_name[] =3D "ep5-iso";
> -static const char g_ep6_name[] =3D "ep6-bulk";
> -static const char g_ep7_name[] =3D "ep7-bulk";
> -static const char g_ep8_name[] =3D "ep8in-int";
> -static const char g_ep9_name[] =3D "ep9-iso";
> -static const char g_epa_name[] =3D "epa-iso";
> -static const char g_epb_name[] =3D "epb-bulk";
> -static const char g_epc_name[] =3D "epc-nulk";
> -static const char g_epd_name[] =3D "epdin-int";
> -
> -static const char *gp_ep_name[NUM_ENDPOINTS] =3D {
> -	g_ep0_name,
> -	g_ep1_name,
> -	g_ep2_name,
> -	g_ep3_name,
> -	g_ep4_name,
> -	g_ep5_name,
> -	g_ep6_name,
> -	g_ep7_name,
> -	g_ep8_name,
> -	g_ep9_name,
> -	g_epa_name,
> -	g_epb_name,
> -	g_epc_name,
> -	g_epd_name,
> +static const struct {
> +	const char *name;
> +	const struct usb_ep_caps caps;
> +} ep_info[NUM_ENDPOINTS] =3D {
> +#define EP_INFO(_name, _type, _dir) \
> +	{ \
> +		.name =3D _name, \
> +		.caps =3D USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
> +				USB_EP_CAPS_DIR_ ## _dir), \
> +	}
> +
> +	EP_INFO("ep0",		CONTROL, ALL),
> +	EP_INFO("ep1-bulk",	BULK,	ALL),
> +	EP_INFO("ep2-bulk",	BULK,	ALL),
> +	EP_INFO("ep3in-int",	INT,	IN),
> +	EP_INFO("ep4-iso",	INT,	ALL),
> +	EP_INFO("ep5-iso",	ISO,	ALL),
> +	EP_INFO("ep6-bulk",	ISO,	ALL),
> +	EP_INFO("ep7-bulk",	BULK,	ALL),
> +	EP_INFO("ep8in-int",	INT,	IN),
> +	EP_INFO("ep9-iso",	ISO,	ALL),
> +	EP_INFO("epa-iso",	ISO,	ALL),
> +	EP_INFO("epb-bulk",	BULK,	ALL),
> +	EP_INFO("epc-bulk",	BULK,	ALL),
> +	EP_INFO("epdin-int",	INT,	IN),

IMO, this is pointless obfuscation. It just makes it a pain to grep
source around. Why don't you have UDC drivers initialize the 1-bit flags
directly ?

--=20
balbi

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuO89AAoJEIaOsuA1yqREpT4P/R+sN60ILX8zbe0pnFmypIqQ
ukpSQkN7DyrEJjSUFrsJ7h5YPRfmEDOg/cdZpqM05Z6+YjZ9n8Gex2JFbWDHPYb0
JYUYbI4nFpVDaGZxclnxkvr7wwtCyE1Lxma9l83klQJduzeS05tTKpitkc3cSPUn
7OwConNlw7lyRne9SjbGd/QfjEkTTaOLO1elQjvPDpqEfP46kmlXjvwlWn4ahqhG
UoiIy9ywxRNDv4KcwadS4h//8P1m2hUcmr22lsrfS9PAO+K7cpruiZU/S3ey0LgM
rlDMol6WN5ScuR415f9exa0RcSTEZjsi/QU8MLCLDC/1X4FFA+Z3tb/baLqLl7b5
XQ9ymYx+6w/xvdvk4JW+FzvSKzoP3Hs3WzfZOW+pUh+NN6/48UW224Hr9GhvdnI4
X+EFCW8W+yHody4ZxcCW4nHk50GoCq7THXg3YMuIxaGjFgKhAUNzuzfAs/HiuacM
abn/oCoW5+PjaDkp4FsdE4HUNIfKQAmpepCAE+/U2Z1A1wNnjbu9GW9HpYiTsjwJ
rBsb984z3lvRSWR/70Z9iB4Ps+NWuL+7EZfC72/Lqo64gxcnf5T1y9njC4obJdRf
4hpkKJpYrjWoahhctxJgtlUQi3qxkm7KIednSJDC62skRx4Ime9FATmoWkFnNFVX
9QnsJqP8SukwBw/eiWIH
=ejBE
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
