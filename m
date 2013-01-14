Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63DA72C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 20:18:38 +1100 (EST)
Date: Mon, 14 Jan 2013 11:18:27 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v2 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114091827.GG10176@arwen.pp.htv.fi>
References: <1358147897-8599-1-git-send-email-peter.chen@freescale.com>
 <20130114074858.GA10176@arwen.pp.htv.fi>
 <20130114081732.GA9039@nchen-desktop>
 <20130114085027.GF10176@arwen.pp.htv.fi>
 <20130114091343.GB9039@nchen-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
In-Reply-To: <20130114091343.GB9039@nchen-desktop>
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

--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 05:13:44PM +0800, Peter Chen wrote:
> On Mon, Jan 14, 2013 at 10:50:27AM +0200, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 14, 2013 at 04:17:35PM +0800, Peter Chen wrote:
> > > On Mon, Jan 14, 2013 at 09:48:58AM +0200, Felipe Balbi wrote:
> > > > Hi,
> > > >=20
> > > > On Mon, Jan 14, 2013 at 03:18:17PM +0800, Peter Chen wrote:
> > > > > It changes the driver to use platform_device_id rather than cpu_i=
s_xxx
> > > > > to determine the SoC type, and updates the platform code accordin=
gly.
> > > > >=20
> > > > > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > > > > Tested at mx51 bbg board, it works ok after enable phy clock
> > > > > (Need another patch to fix this problem)
> > > > >=20
> > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > >=20
> > > > not good for -rc. You have to break this down as you're solving at =
least
> > > > three different problems with this patch.
> > >=20
> > > Felipe, all my changes are for this problem, these are fix build erro=
r and
> > > let it work.
> > >=20
> > >  arch/arm/mach-imx/clk-imx25.c                     |    6 +-
> > >  arch/arm/mach-imx/clk-imx27.c                     |    6 +-
> > >  arch/arm/mach-imx/clk-imx31.c                     |    6 +-
> > >  arch/arm/mach-imx/clk-imx35.c                     |    6 +-
> > >  arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
> > >=20
> > >  As we change the connection-id, we need to change clock file or
> > >  the devm_clk_get will be failed.
> >=20
> > right right, that's ok.
> >=20
> > >  arch/arm/mach-imx/devices/devices-common.h        |    1 +
> > >  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
> > >=20
> > >  We need to differentiate SoCs, so I use platform_device_id to
> > >  instead of cpu_ix_xxx(), this is for machine file change
> >=20
> > fair enough.
> >=20
> > >  drivers/usb/gadget/fsl_mxc_udc.c                  |   23 +++++----
> > >  drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++=
++-------
> > >  drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
> > >  include/linux/fsl_devices.h                       |    8 +++
> > >=20
> > >  Need to get platform_device_id at driver, and replace the cpu_is_xxx=
 to
> > >  platform_device_id. Meanwhile, needs a solution for replace
> > >  MX35_IO_ADDRESS.
> >=20
> > ok, here we go:
> >=20
> > You just listed to me three different fixes and each fix should be on a
> > separate patch. Meaning that you should have one single patch to convert
> > MX35_IO_ADDRESS() into ioremap(), another patch should be removing
> > cpu_is_xxx() and the third one fixing connection-id.
> >=20
> > As you might remember, we want patches to be self-contained logical
> > units and your patch contains 3 of such logical units.
> >=20
>=20
> OK, three patches. Thanks.
>=20
> The reason I thought two patches is this build break contains two problem=
s,
> (MX35_IO_ADDRESS & cpu_is_xxx()).
> I would like fix it together, in that case, the git bisect will only
> show one build error at most.

right, still those are two different problems, so they should be fixed
in two separate patches, I'm sorry.

--=20
balbi

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ881iAAoJEIaOsuA1yqREuYoP/1sJn7g7hBcU7U8n4C7bCQ/n
LwD4KOfy9vDVn9HvHktYmQ9ONtx7aPpflS03ySjbN55q0tyPZ7I4JIHm4Lkqthiy
LkDktKPbLpY+h/BsiP1/iGU5pi0mfsntHDnPHSnsqys5ObeV2UigGDgQqBe46PMd
Nrv4Ao78stohgicA3y4AUiCXHvv6pIV2K/vQQc80AvRXYjB4rBo4ghnzztUCn8AM
ta/zYbL4LanoDX4ygY7T2MHQBob0xzFLyaIV4xCDhrVTNAieMJv2BSQ2g312axp6
fTUy8X37n91s5kMC6nyK9SdBznUoW/0CpL8QnbNqaz1szYcXm3fsU7HxbQjaRUVA
1p4yKZ5nxwWJm8SRr/AxdvyoM1P4Au7oz3HcJ+QdFIZ470TprySoipZh0jJPAno/
h6RXE4oA+eCZOoSpwyMeQTQT0n1sVGjbsmwE/GIWylGi/euqWv4Zld8XxnPQGYMj
YeflYzLjlsZCzJetIpiQ24uRWuTNJGZuOPHdYKjVaQN3qzmTBKELkLxADs+In9Z5
y2DmZji0DfX7e2EOvjrLwkjhvJd5hSAoc1UEORxU7kk57XWFzjRs+S7KX+O/hbJ6
qgydSVgmDOZn9r3RycFtdAjY8z/wK//PtMewXUnviRxXLVI86B02B7m32VJ6hsdd
76FzPpWq9gER+RhejYE8
=IGRP
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
