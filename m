Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B5ED2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 06:10:19 +1100 (EST)
Date: Thu, 24 Jan 2013 21:09:26 +0200
From: Felipe Balbi <balbi@ti.com>
To: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [RFC/PATCH 32/32] usb: gadget: drop now unnecessary flag
Message-ID: <20130124190926.GA31254@arwen.pp.htv.fi>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-33-git-send-email-balbi@ti.com>
 <2268214.yJrDJgELNj@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <2268214.yJrDJgELNj@flatron>
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 Linux USB Mailing List <linux-usb@vger.kernel.org>, nicolas.ferre@atmel.com,
 linux-geode@lists.infradead.org, Felipe Balbi <balbi@ti.com>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, haojian.zhuang@gmail.com,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
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

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 07:52:52PM +0100, Tomasz Figa wrote:
> Hi Felipe,
>=20
> On Thursday 24 of January 2013 17:46:10 Felipe Balbi wrote:
> > We don't need the ->register_my_device flag
> > anymore because all UDC drivers have been
> > properly converted.
> >=20
> > Let's remove every history of it.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/usb/chipidea/udc.c             | 1 -
> >  drivers/usb/dwc3/gadget.c              | 1 -
> >  drivers/usb/gadget/amd5536udc.c        | 1 -
> >  drivers/usb/gadget/at91_udc.c          | 1 -
> >  drivers/usb/gadget/atmel_usba_udc.c    | 1 -
> >  drivers/usb/gadget/bcm63xx_udc.c       | 1 -
> >  drivers/usb/gadget/dummy_hcd.c         | 1 -
> >  drivers/usb/gadget/fsl_qe_udc.c        | 1 -
> >  drivers/usb/gadget/fsl_udc_core.c      | 1 -
> >  drivers/usb/gadget/fusb300_udc.c       | 1 -
> >  drivers/usb/gadget/goku_udc.c          | 1 -
> >  drivers/usb/gadget/imx_udc.c           | 1 -
> >  drivers/usb/gadget/lpc32xx_udc.c       | 1 -
> >  drivers/usb/gadget/m66592-udc.c        | 1 -
> >  drivers/usb/gadget/mv_u3d_core.c       | 1 -
> >  drivers/usb/gadget/mv_udc_core.c       | 1 -
> >  drivers/usb/gadget/net2272.c           | 1 -
> >  drivers/usb/gadget/net2280.c           | 1 -
> >  drivers/usb/gadget/omap_udc.c          | 1 -
> >  drivers/usb/gadget/pch_udc.c           | 1 -
> >  drivers/usb/gadget/pxa25x_udc.c        | 1 -
> >  drivers/usb/gadget/pxa27x_udc.c        | 1 -
> >  drivers/usb/gadget/r8a66597-udc.c      | 1 -
> >  drivers/usb/gadget/s3c-hsotg.c         | 1 -
> >  drivers/usb/gadget/s3c-hsudc.c         | 1 -
> >  drivers/usb/gadget/s3c2410_udc.c       | 1 -
> >  drivers/usb/gadget/udc-core.c          | 3 ---
> >  drivers/usb/musb/musb_gadget.c         | 1 -
> >  drivers/usb/renesas_usbhs/mod_gadget.c | 1 -
> >  include/linux/usb/gadget.h             | 4 ----
> >  30 files changed, 35 deletions(-)
> >=20
> [snip]
> > diff --git a/drivers/usb/gadget/udc-core.c
> > b/drivers/usb/gadget/udc-core.c index 9195054..4ee0efc 100644
> > --- a/drivers/usb/gadget/udc-core.c
> > +++ b/drivers/usb/gadget/udc-core.c
> > @@ -173,7 +173,6 @@ int usb_add_gadget_udc(struct device *parent, struct
> > usb_gadget *gadget) if (!udc)
> >  		goto err1;
> >=20
> > -	if (gadget->register_my_device) {
> >  		dev_set_name(&gadget->dev, "gadget");
> >=20
> >  		ret =3D device_register(&gadget->dev);
> > @@ -211,7 +210,6 @@ err3:
> >  	put_device(&udc->dev);
> >=20
> >  err2:
> > -	if (gadget->register_my_device)
> >  		put_device(&gadget->dev);
> >  err1:
> >  	return ret;
> > @@ -267,7 +265,6 @@ found:
> >  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
> >  	device_unregister(&udc->dev);
> >=20
> > -	if (gadget->register_my_device)
> >  		device_unregister(&gadget->dev);
>=20
> Correct me if I am wrong, but doesn't this patch leave us with incorrect=
=20
> indentation?

right, I fixed it up on my branch, see [1]. That was me trusting my poor
sed skills and not verifying the result ;-)

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/balbi/usb.git;a=3Dcommitdif=
f;h=3Dd0bdf2970dd68677c65671be9bd56759593cfaf1

--=20
balbi

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAYbmAAoJEIaOsuA1yqRE3EsQAIRJ4cf9cxaxwgF6STF+90gs
jy+oxA1eMxpk1qtL8rJ5sfXB8/B90dO6lQzHx2KtcpXx5hlXgOfn1BZCoMwWocFj
4nI/HdgP4T4UXrtWXOpGhqdwSUWjID6vcvWaybCEUT3bhLZSNzTeZ3K1pzQAg54P
+S45/YsZkiqvNUfDIrbf0YLZ3/zJp4nE5ZH+jMLUV0LUy26YyXAmIU/LUS4brstF
RUqU2X7Z+9Oxd8eTgpuMZrNZrDo6Z0yYCKnamRpiYmzCndDOgFOY2lCxinkpZnE1
SyVqFi4Ckw2UaSJozPKJZydYhNOJ60VRgy+C1B0c1YTCYDzSt/kBKyCcBajQqm5g
q2QNaB40Rc95K2ZWRgf+BGYgStjsf6qxIBEm3nqWwO3/cerwxsf3gebm6g2XdMR3
afgW2/vfJMhIr0rILSVKjp8NTtDPiMgIKfzM+TTE+ITVi0ZsWGieHGIwQGHRRK8M
L87TsWv4kNKAMf4Soa5P4Cg+j09CNDeR99jI2ewEhZzXGoSVDyKK8pnnSZInXJeE
mLjScdKpKYTIBulBepbMeyaweRlgYNklLBvG3U5WAs0HG7nChQ13WDd7Snt5gCXw
NeP2LzaXHkDCRHy4nHZBGf9kLsz4ix+HA5JTzsgnwZxDgBwdHT0vY1DnYwmPPX8U
VEDUlmb/NcSOJmlBOGbR
=iJlK
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
