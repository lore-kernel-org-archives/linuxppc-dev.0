Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF0E62C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:30:42 +1100 (EST)
Date: Fri, 19 Oct 2012 13:24:36 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 1/7] usb: gadget: fsl_udc: simplify driver init
Message-ID: <20121019102436.GB11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-1-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
In-Reply-To: <1350642285-8145-1-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 linuxppc-dev@lists.ozlabs.org, Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 12:24:39PM +0200, Christoph Fritz wrote:
> To initialize this driver use 'module_platform_driver' instead
> of '__init' and '__exit'.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |   37 +++++++++++--------------------=
------
>  1 files changed, 11 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 6ae70cb..340451d 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -49,13 +49,14 @@
> =20
>  #include "fsl_usb2_udc.h"
> =20
> +#define	DRIVER_NAME	"fsl-usb2-udc"
>  #define	DRIVER_DESC	"Freescale High-Speed USB SOC Device Controller driv=
er"
>  #define	DRIVER_AUTHOR	"Li Yang/Jiang Bo"
>  #define	DRIVER_VERSION	"Apr 20, 2007"
> =20
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
> =20
> -static const char driver_name[] =3D "fsl-usb2-udc";
> +static const char driver_name[] =3D DRIVER_NAME;
>  static const char driver_desc[] =3D DRIVER_DESC;
> =20
>  static struct usb_dr_device *dr_regs;
> @@ -2761,35 +2762,19 @@ static int fsl_udc_otg_resume(struct device *dev)
>  	Register entry point for the peripheral controller driver
>  ------------------------------------------------------------------------=
--*/
> =20
> -static struct platform_driver udc_driver =3D {
> -	.remove  =3D __exit_p(fsl_udc_remove),
> -	/* these suspend and resume are not usb suspend and resume */
> -	.suspend =3D fsl_udc_suspend,
> -	.resume  =3D fsl_udc_resume,
> -	.driver  =3D {
> -		.name =3D (char *)driver_name,
> -		.owner =3D THIS_MODULE,
> -		/* udc suspend/resume called from OTG driver */
> +static struct platform_driver fsl_udc_driver =3D {
> +	.probe		=3D fsl_udc_probe,

NAK, probe() lies in .init.text section. You need to change __init to
__devinit. Likewise for all functions which are only called during
probe() and for remove() which needs s/__exit/__devexit.

--=20
balbi

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgSpkAAoJEIaOsuA1yqREMWMP/2fGbYLJqqMQTtdqKHI/xB6W
kgP7+dr5GoKPRF/nwW1ubih7WUDt6e6qMJSnpMrDe8hYbfetyWchmhL/69wxGATM
IiucDEUrdJuaFTiv2/9FECObRs/TKJCRngh/7psz7dH+EHDW2du65vWjuNXlSG5W
X7vuF/A4uj/SvaGN8WOFl2EHi0cgXk6xNbFLFWzJKfIEzLZvIzeGErpk1c1vpZA9
Jcg/hZy5mLN4owDlT3XcAl3ZXPphd38sOZCcoWvA9t4g3JvOf4QV6ZPWFSlpNQYu
XJhhCeUh3Xz1QeleEoTp6JKtJoY9AZgFkby99q0OtMfvbA92CuaMJ0f60rOcFZCA
f9qS73rlt63Dru16x+9CdafEwyOEsTVIJPd79h09q4ueUqKzfTRXJZbMdFpc5LhF
9ieU9c9ZA2fdGownnO8ZJ4EN6m+xvH6p8DrxJVwaZaie6hs14m0TxzI6ZIaLKZS3
7iSJyxSDW46z3Wghrii3ymDjV5r53A1pXJEkkyg2Viy70VEkpmfMNekRRMnDr20S
xl1I/ZdlYH+hYOlbTFfM+hqeG5DGheHZZUYMxASM9u8VYCfiU2PnLPjGnXoERNUm
BAC5oULrvw5gp3u18b1tp1sPTBzJvjo93Ilw1HpZw9aj5BgYfejA6BCC75fe4Ykp
9mcbTjTP0+ABMI3ZyfpC
=Cpx7
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
