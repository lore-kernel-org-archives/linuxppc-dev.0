Return-Path: <balbi@ti.com>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
 [74.125.149.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94C6DB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 01:01:13 +1000 (EST)
Received: by laai10 with SMTP id i10so3293353laa.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2012 08:01:05 -0700 (PDT)
Date: Mon, 4 Jun 2012 17:59:18 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
Message-ID: <20120604145917.GM8002@arwen.pp.htv.fi>
References: <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com> <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>
 <1338809424.3371.20.camel@mars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
In-Reply-To: <1338809424.3371.20.camel@mars>
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Fabio Estevam <festevam@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Oliver Neukum <oneukum@suse.de>, Eric Miao <eric.y.miao@gmail.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2012 at 01:30:24PM +0200, Christoph Fritz wrote:
> Hi,
>=20
> On Mon, 2012-05-21 at 22:04 +0300, Felipe Balbi wrote:
> > On Mon, May 21, 2012 at 08:57:22AM +0200, Christoph Fritz wrote:
> > > USB controller may access a wrong address for the dTD (endpoint trans=
fer
> > > descriptor) and then hang. This happens a lot when doing tests with
> > > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > > bandwidth.
> > >=20
> > > This hardware bug is explained in detail by errata number 2858 for i.=
MX23:
> > > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > >=20
> > > All (?) SOCs with an IP from chipidea suffer from this problem.
> > > mv_udc_core fixes this bug by commit daec765.  There still may be
> > > unfixed drivers.
> > >=20
> > > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > > Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> > > ---
> > >  drivers/usb/gadget/fsl_udc_core.c |   15 ++++++++++++++-
> > >  1 files changed, 14 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/f=
sl_udc_core.c
> > > index 55abfb6..72f2139 100644
> > > --- a/drivers/usb/gadget/fsl_udc_core.c
> > > +++ b/drivers/usb/gadget/fsl_udc_core.c
> > > @@ -65,6 +65,8 @@ static struct usb_sys_interface *usb_sys_regs;
> > >  /* it is initialized in probe()  */
> > >  static struct fsl_udc *udc_controller =3D NULL;
> > > =20
> > > +static struct ep_td_struct *last_free_td;
> >=20
> > I don't want to see global variables anymore. In fact, please convert
> > this to the new udc_start()/udc_stop() calls and use the generic
> > map/unmap routines.
> >=20
> > That'll help you get rid of a bunch of useless code on the driver. After
> > that you should remove all <asm/*> header includes and drop the ARCH
> > dependency.
> >=20
> > You can also drop the big-/little-endian helpers as you can make use of
> > generic writel()/readl() routines.
> >=20
> > Please make sure these series comes in with enough time to reach v3.6
> > merge window in about 3 months.
> >=20
> > You can put this fix together on that series after you drop the global.
>=20
> Before I came to do the proposed changes, I stumbled upon this:
>=20
> In file included from drivers/usb/gadget/fsl_udc_core.c:49:
> drivers/usb/gadget/fsl_usb2_udc.h: In function =E2=80=98get_qh_by_ep=E2=
=80=99:
> drivers/usb/gadget/fsl_usb2_udc.h:585: error: =E2=80=98struct fsl_ep=E2=
=80=99 has no member named =E2=80=98desc=E2=80=99
> drivers/usb/gadget/fsl_udc_core.c: In function =E2=80=98done=E2=80=99:
> drivers/usb/gadget/fsl_udc_core.c:187: error: =E2=80=98struct fsl_ep=E2=
=80=99 has no member named =E2=80=98desc=E2=80=99
> drivers/usb/gadget/fsl_udc_core.c:187: error: =E2=80=98struct fsl_ep=E2=
=80=99 has no member named =E2=80=98desc=E2=80=99
> <snip>
>=20
> my proposed regression patch:
> ---
> From: Christoph Fritz <chf.fritz@googlemail.com>
> Date: Mon, 4 Jun 2012 12:58:21 +0200
> Subject: [PATCH] usb: gadget: regression fix - useage of usb_ep
>=20
> This patch removes redundant pointer to struct usb_endpoint_descriptor wh=
ich
> were missed in commit 79149b8:
>=20
>  usb: gadget: Update fsl_udc_core to use usb_endpoint_descriptor inside t=
he
>  struct usb_ep
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |    2 +-
>  drivers/usb/gadget/fsl_usb2_udc.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 2831685..678ec4d 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -2575,7 +2575,7 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  	/* for ep0: the desc defined here;
>  	 * for other eps, gadget layer called ep_enable with defined desc
>  	 */
> -	udc_controller->eps[0].desc =3D &fsl_ep0_desc;
> +	udc_controller->eps[0].ep.desc =3D &fsl_ep0_desc;
>  	udc_controller->eps[0].ep.maxpacket =3D USB_MAX_CTRL_PAYLOAD;
> =20
>  	/* setup the udc->eps[] for non-control endpoints and link
> diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_u=
sb2_udc.h
> index 5cd7b7e..f61a967 100644
> --- a/drivers/usb/gadget/fsl_usb2_udc.h
> +++ b/drivers/usb/gadget/fsl_usb2_udc.h
> @@ -568,10 +568,10 @@ static void dump_msg(const char *label, const u8 * =
buf, unsigned int length)
>  /*
>   * ### internal used help routines.
>   */
> -#define ep_index(EP)		((EP)->desc->bEndpointAddress&0xF)
> +#define ep_index(EP)		((EP)->ep.desc->bEndpointAddress&0xF)
>  #define ep_maxpacket(EP)	((EP)->ep.maxpacket)
>  #define ep_is_in(EP)	( (ep_index(EP) =3D=3D 0) ? (EP->udc->ep0_dir =3D=
=3D \
> -			USB_DIR_IN ):((EP)->desc->bEndpointAddress \
> +			USB_DIR_IN) : ((EP)->ep.desc->bEndpointAddress \
>  			& USB_DIR_IN)=3D=3DUSB_DIR_IN)
>  #define get_ep_by_pipe(udc, pipe)	((pipe =3D=3D 1)? &udc->eps[0]: \
>  					&udc->eps[pipe])
> --=20
> 1.7.2.5

Please send as a proper patch so I can apply.

--=20
balbi

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzM1FAAoJEIaOsuA1yqRE0IwP/i5Bhlcv3LgcGMhbM3qqSX3Q
+ji+PDX6PHlPtDNtQYFIrSvPfRfKMgHRGGAS4ceeNvePDcDMk1kfMKCErThpWnHH
fgyngttYZHTIFqxbjSSiH4MhU3A8aPJtkpcHd2XWbWnWpMCNhryQfk1jLenR3zmR
QNSvdCmkFjEoF9kzHC7yYLp2pVAs5exk4TP6GsF24JxarZvuAyHPoW+CITGHn2Kq
drRWy45n25ne94M59boa5z/bg6RVmMk79QS+jmK0cYQWImd0taett92GcdlKh5z2
7IS4B2kXlSiWL2AfZmWxdsa8C3/r6gGxx7gCzT1UcjrnxZH/XPMVHbgO3OXI/PyD
v1/Jrqn89gJV57fskschezwH2QyG0cvgmKPQzrtm/oUtMdS6Dh/hXHWMzhnS+2fZ
kSs7SatMEeTyaWipkJlr4Xu/6xJdFxg+/ROkPdg1IzxFtxDOEawVxyA+3isnNo6u
hx+F1IZDCf1ATo0qi9tu9+TIG9afF9fq+BdXziyyKdPy2Ihn3PMGBpFYhwFcwoeG
6W4dwIKIciD7CdviDEN7C/vMRSVrmVMe9T1qDqUMMSEjhzxtrinVvJKVBIujOydL
bKg5XB4I1SPlI2xQJEX4RAizvYCQnomutq2CEsbe0Q+SYxxQUNhQDAAfNw1+YelO
xZwezdVuIoyLiwY1oZU9
=38mW
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
