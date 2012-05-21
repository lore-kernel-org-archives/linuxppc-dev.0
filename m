Return-Path: <balbi@ti.com>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
 [74.125.149.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 81EBBB6F86
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 05:12:35 +1000 (EST)
Received: by lbgc1 with SMTP id c1so8582110lbg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 12:12:26 -0700 (PDT)
Date: Mon, 21 May 2012 22:04:51 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
Message-ID: <20120521190450.GA27492@arwen.pp.htv.fi>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com> <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <20120521065722.GA4363@mars>
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Fabio Estevam <festevam@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>, Oliver Neukum <oneukum@suse.de>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 21, 2012 at 08:57:22AM +0200, Christoph Fritz wrote:
> USB controller may access a wrong address for the dTD (endpoint transfer
> descriptor) and then hang. This happens a lot when doing tests with
> g_ether module and iperf, a tool for measuring maximum TCP and UDP
> bandwidth.
>=20
> This hardware bug is explained in detail by errata number 2858 for i.MX23:
> http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
>=20
> All (?) SOCs with an IP from chipidea suffer from this problem.
> mv_udc_core fixes this bug by commit daec765.  There still may be
> unfixed drivers.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 55abfb6..72f2139 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -65,6 +65,8 @@ static struct usb_sys_interface *usb_sys_regs;
>  /* it is initialized in probe()  */
>  static struct fsl_udc *udc_controller =3D NULL;
> =20
> +static struct ep_td_struct *last_free_td;

I don't want to see global variables anymore. In fact, please convert
this to the new udc_start()/udc_stop() calls and use the generic
map/unmap routines.

That'll help you get rid of a bunch of useless code on the driver. After
that you should remove all <asm/*> header includes and drop the ARCH
dependency.

You can also drop the big-/little-endian helpers as you can make use of
generic writel()/readl() routines.

Please make sure these series comes in with enough time to reach v3.6
merge window in about 3 months.

You can put this fix together on that series after you drop the global.

--=20
balbi

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPupHSAAoJEIaOsuA1yqRE5cAP/isbc5K+gOwwL/xwZBu/xuJb
frD8kE+zVXc+H2HOQZnd9NRbytpdob/iHVbHrLw2f3y48QdgasSvzkKpZN7EsJNL
mIGldf3nom5gWVPHqKRQAB84Zb7wMNZvPG4gQvjtW9RAwzUKKHIN+Ov+JVJtV7ha
BmQ8QnLx1yZkpfWyNNYMhjVzt8gkaACDjB6GJL8zny7IL5izF2W/LV5pUXcXv5ax
lsAwBTf2clQte5wfulL39fhv9t4vjhAysSKNRQA0hJBu7Hzb+w3yU9QdMSYtaxJE
QlO73LE6Nw/yHtNGPoNfvNtknqcHY9aHJhwV6w9Jf5O9e2qFHjlxS0GVccR3awRv
o27LAjNWzzcTSmozB64suMnV9dIvdSNhZ9rhmmmypoxOquysJQWyGJ/J7b4iuk+C
RZbV/xCLST707A2VRizBqbqiRnUeDOQp9ZBxMul65ZRbuV9d01FyznNp/T4BP6KU
XggKYe/pYwtDpm6WfR5KmWeC/YeaXCYCoRhF2iayQpBVRT9OAwKiTY1HJFxSzwfh
uDGc8wnXk9ItRdsutFE+APnhd9t3zkVBNB7NmBlYgW5+Q2fDTjOz/QcCrxdTragw
cOji9Y+oceTTxAV4nFY9Kc3qcs6hw+Mtt/ws/k414clNRzlLhJaErTDH0+UxG/h0
kUFyeDeF+QG3d7JTaosY
=r6Ah
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
