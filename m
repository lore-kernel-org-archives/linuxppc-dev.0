Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AF4A2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 19:50:40 +1100 (EST)
Date: Mon, 14 Jan 2013 10:50:27 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114085027.GF10176@arwen.pp.htv.fi>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
 <20130114074858.GA10176@arwen.pp.htv.fi>
 <20130114081732.GA9039@nchen-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
In-Reply-To: <20130114081732.GA9039@nchen-desktop>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, kernel@pengutronix.de, shawn.guo@linaro.org,
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

--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 04:17:35PM +0800, Peter Chen wrote:
> On Mon, Jan 14, 2013 at 09:48:58AM +0200, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> > > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > > to determine the SoC type, and updates the platform code accordingly.
> > >=20
> > > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > > Tested at mx51 bbg board, it works ok after enable phy clock
> > > (Need another patch to fix this problem)
> > >=20
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> >=20
> > not good for -rc. You have to break this down as you're solving at least
> > three different problems with this patch.
>=20
> Felipe, all my changes are for this problem, these are fix build error and
> let it work.
>=20
>  arch/arm/mach-imx/clk-imx25.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx27.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx31.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx35.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
>=20
>  As we change the connection-id, we need to change clock file or
>  the devm_clk_get will be failed.

right right, that's ok.

>  arch/arm/mach-imx/devices/devices-common.h        |    1 +
>  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
>=20
>  We need to differentiate SoCs, so I use platform_device_id to
>  instead of cpu_ix_xxx(), this is for machine file change

fair enough.

>  drivers/usb/gadget/fsl_mxc_udc.c                  |   23 +++++----
>  drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++--=
-----
>  drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
>  include/linux/fsl_devices.h                       |    8 +++
>=20
>  Need to get platform_device_id at driver, and replace the cpu_is_xxx to
>  platform_device_id. Meanwhile, needs a solution for replace
>  MX35_IO_ADDRESS.

ok, here we go:

You just listed to me three different fixes and each fix should be on a
separate patch. Meaning that you should have one single patch to convert
MX35_IO_ADDRESS() into ioremap(), another patch should be removing
cpu_is_xxx() and the third one fixing connection-id.

As you might remember, we want patches to be self-contained logical
units and your patch contains 3 of such logical units.

> > Besides there are parts which are not related to the build break.
>=20
> I can split this patch to two patches, one is driver part, the other is
> machine part. It can also fix build break, but it needs two
> patches to let the udc work.

you will need as many patches as necessary, but they need to the broken
correclty, the way you suggested above is wrong.

--=20
balbi

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ88bTAAoJEIaOsuA1yqRE1DQP/2wJtFccx9AaQBNxXnwusOvD
uPcjPlvow1BTHS4Zs5rakCnOix9sUwHmmEJyh5iaq6iFHda5v6fPIJx+l/Hc8kZa
jSQI/qnmVeuAGtCYXRwsKyL0tvFfhYxvT37e8e4Pk5m7tqsjilVigIVScTJ74ibD
lRo8l9F81Q46tg5b90tNBvzIFLTC0uz+TZFoV0wlBkV0dfjqbtKcO0YXyt0hl+ix
MPNwcy8lFC6bshZ+h00ok5l770ZJfmiSYJH9L7Q91PlaRidUYEozRIM9u7Qt9gdf
Q8CLkndaAhikgtklhfBJ3j6IDFo7zVJlvYxm2hvQ7nioa1gTbNIuDS1G6zKd1EcJ
iEX6UjwduyFidaSGcpVzM4Gft6lremwBNOu7k060xEiU3eFrqrH8i3aKDH+KVU6d
zj1p3XzMQm7+gr/hqpJc19bayguRRE7suKr6b9D9u/XDf4Y3R28SHP14IyuROkBf
G6rKHizzjbrMepgPV8ilEL2+bbshCVEvPWIY2g02jhBTAyz28mr3w0HRuzU4jbSq
SsRGfjgRslpQ1Ady90c8T5bNeIwywC0gPvNAGFPjTeuk0tdXH55bIPh9JAjTCf5D
caI2uyeBqwHO8qSMVrqNtN5A3yETZHZX9r/KLZA+1rSxEaLjpHHOOamonNJp/DFD
XIzyU/k82mbQUGmjhUam
=5gH3
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
