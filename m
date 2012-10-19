Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F9A92C03F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:31:16 +1100 (EST)
Date: Fri, 19 Oct 2012 13:25:26 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 2/7] usb: gadget: fsl_udc: protect fsl_pullup() with
 spin_lock
Message-ID: <20121019102526.GC11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-2-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
In-Reply-To: <1350642285-8145-2-git-send-email-chf.fritz@googlemail.com>
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

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 12:24:40PM +0200, Christoph Fritz wrote:
> This patch reworks fsl_pullup() against the background of switching over
> to udc_start()/udc_stop() style:
>=20
> Protect function fsl_pullup() with a spin_lock. Also set vbus_active as
> default to true. This prevents disabling USB controller if there is no

the vbus_active part should be in a separate patch as it has no relation
with $SUBJECT

> driver support for an external transceiver (or GPIO) that detects a VBUS
> power session starting.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 340451d..0a0d6a6 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -1242,8 +1242,10 @@ static int fsl_vbus_draw(struct usb_gadget *gadget=
, unsigned mA)
>  static int fsl_pullup(struct usb_gadget *gadget, int is_on)
>  {
>  	struct fsl_udc *udc;
> +	unsigned long flags;
> =20
>  	udc =3D container_of(gadget, struct fsl_udc, gadget);
> +	spin_lock_irqsave(&udc->lock, flags);
>  	udc->softconnect =3D (is_on !=3D 0);
>  	if (can_pullup(udc))
>  		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
> @@ -1251,6 +1253,7 @@ static int fsl_pullup(struct usb_gadget *gadget, in=
t is_on)
>  	else
>  		fsl_writel((fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
>  				&dr_regs->usbcmd);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> =20
>  	return 0;
>  }
> @@ -2557,6 +2560,7 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  	INIT_LIST_HEAD(&udc_controller->gadget.ep_list);
>  	udc_controller->gadget.speed =3D USB_SPEED_UNKNOWN;
>  	udc_controller->gadget.name =3D driver_name;
> +	udc->vbus_active =3D true;
> =20
>  	/* Setup gadget.dev and register with kernel */
>  	dev_set_name(&udc_controller->gadget.dev, "gadget");
> --=20
> 1.7.2.5
>=20

--=20
balbi

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgSqWAAoJEIaOsuA1yqREtKcP/2AQQqEjj6WeB6KgwB6ut0Ia
Qr/fo8K9D+lCMjMuHNleJdRZbdfaoR0pcpYbkYy3W6DlHfqHKy3vrGgAMKKpSIEJ
I2304zuBO+rLXZtYsxE681VsmmAuUHvD8Dd20UOeS3I82SsZiHCRyqaAxwcqiP1p
IzUVQIuU8Jw+QGH0IY3CfxT5QFgp1DsJatnWZA/vumFRlg9c27Sv+CnZd1jstMza
smIJTCiPNGMguVSKYXrkx++G6aILWU3JrkQuV/dk2vgOQcBFmUZ63pOChIM2C0p3
KYroHcP17rthD93hkHZsMFe5x1QLuGvMzDqYiX43dBa7h72S03TEQN6hZXCp9/JF
Mw0vvmGu+9YaqVfjN/FOhezouUzxnkC/cortlA/JtdzASblDkrXMWskLepoKUlhh
U3/fztBGSybAQ68qCUQh3Mqu+jOqeiqnIfNrEoX6MeDqcXL0v9F2elQ6dUW0Lk+B
XmaFpsu8c8lJj8iwmyORNX6xwjmvZpbxVdeezeI+hWuAHY0yXMg6k2cd+lSCgOnm
PQZfKikT9wUT5jVy1Rp+1D/23mVOoon2eppzGM9MCCw19kzkgjywW5WgVhc1d77Q
GledCaJ1nKgq7DpE18tWOnh8vhvDX8vCCsx2TwytrphdKirj2UAXZLcAdy5ckaFR
k3NDRK258lqTKietD4IC
=34lp
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
