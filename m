Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A274C2C010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:17:19 +1100 (EST)
Date: Mon, 14 Jan 2013 12:17:08 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to
 ioremap
Message-ID: <20130114101708.GC10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
In-Reply-To: <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 06:12:40PM +0800, Peter Chen wrote:
> As mach/hardware.h is deleted, we can't visit platform code at driver.
> It has no phy driver to combine with this controller, so it has to use
> ioremap to map phy address as a workaround.
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/gadget/fsl_mxc_udc.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mx=
c_udc.c
> index 6df45f7..0e858e6 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -23,7 +23,8 @@ static struct clk *mxc_per_clk;
>  static struct clk *mxc_ipg_clk;
> =20
>  /* workaround ENGcm09152 for i.MX35 */
> -#define USBPHYCTRL_OTGBASE_OFFSET	0x608
> +#define MX35_USBPHYCTRL_OFFSET		0x600
> +#define USBPHYCTRL_OTGBASE_OFFSET	0x8
>  #define USBPHYCTRL_EVDO			(1 << 23)
> =20
>  int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *=
pdev)
> @@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
>  	struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform_data;
>  	if (devtype =3D=3D IMX35_UDC) {
>  		unsigned int v;
> +		void __iomem *phy_regs =3D ioremap((unsigned long)pdata->regs +
> +						MX35_USBPHYCTRL_OFFSET, 512);

as I said before, this should be passed via struct resource, not pdata.

--=20
balbi

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ89skAAoJEIaOsuA1yqREEXAP/2e+Ug671bgfQqSIyxXA4rkZ
2XdmJiGS/voZHrYabSW77FIIXl4bw9cAjOqE8bLBgyHAHNpOgxTwUAwq6Wl7EBs7
x9GwosOF52PQK3DqISXKen4mIkpsE0LVlqhEQrU6rlfq2YSaELRerzIex2hbm5my
NOa/G0o6nCZTj9t7bZpB88GhN3rl6wtHCbZXD1u6FtmP2JUaQDVuhVEuEIUXEDMw
fNqf2LMSTk3lyTytjkmS5o/9lnwm05Z8Ymidd4cT95avEnjLIWSjfYjfCO1wMCKK
ZOGwpihI7bDJkUBZBnC3q1umy5aWXUOwq+51Vh8lO7utMbStNcrtVliTRb5cOlO7
FNegd/3sRBHe+274xB/LlTsX5mr1bZFnzA0hEvHxlDWbvlUSmxi0gJKpVcPYSWFj
elCOTSiG5aLMFyrNh3EVhwE4k5bgxp5+6OYi0V1TQT4L9MULxj8kwiEKMGtRRT+X
BQ4E0KMMtkcHPYFkvDJKmdKueeG8TmIq7sUmU3wa+FDoiNjO4DtF/m8nABjHg5cK
87MRdX9PJX7MGjVQCut6sDAZuMjreSXrdFjXEb0Y2Drh99+2uTrEy/BFpLugnazI
Sa3EfURpG+f6c1DPkhgnV5ZRue/SagfL+q92F5alhTXAZgIdfZnNKL01odr19QCg
RprDCFA5dOkVZ0O7njBN
=p60c
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
