Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95E602C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 20:14:37 +1100 (EST)
Date: Thu, 17 Jan 2013 11:14:22 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v5 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130117091422.GF10814@arwen.pp.htv.fi>
References: <1358216975-1404-1-git-send-email-peter.chen@freescale.com>
 <1358216975-1404-2-git-send-email-peter.chen@freescale.com>
 <20130115140344.GB6574@S2101-09.ap.freescale.net>
 <20130116014824.GD16514@nchen-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
In-Reply-To: <20130116014824.GD16514@nchen-desktop>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
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

--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2013 at 09:48:25AM +0800, Peter Chen wrote:
> On Tue, Jan 15, 2013 at 10:03:46PM +0800, Shawn Guo wrote:
> > On Tue, Jan 15, 2013 at 10:29:33AM +0800, Peter Chen wrote:
> > > As mach/hardware.h is deleted, we need to use platform_device_id to
> > > differentiate SoCs. Besides, one cpu_is_mx35 is useless as it has
> > > already used pdata to differentiate runtime
> > >=20
> > > Meanwhile we update the platform code accordingly.
> > >=20
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > ---
> > >  arch/arm/mach-imx/devices/devices-common.h        |    1 +
> > >  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 ++++---
> > >  drivers/usb/gadget/fsl_mxc_udc.c                  |   24 +++++-------
> > >  drivers/usb/gadget/fsl_udc_core.c                 |   42 +++++++++++=
++--------
> > >  4 files changed, 45 insertions(+), 37 deletions(-)
> >=20
> > Since we are splitting the original patch anyway, it's a bit strange
> > to me that you are mixing arch/arm/mach-imx and drivers/usb/gadget
> > in this patch.  I'm fine with it, since I assume all the patches to
> > go via USB tree anyway.
> >=20
> > >=20
> > > diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/ma=
ch-imx/devices/devices-common.h
> > > index 6277baf..9bd5777 100644
> > > --- a/arch/arm/mach-imx/devices/devices-common.h
> > > +++ b/arch/arm/mach-imx/devices/devices-common.h
> > > @@ -63,6 +63,7 @@ struct platform_device *__init imx_add_flexcan(
> > > =20
> > >  #include <linux/fsl_devices.h>
> > >  struct imx_fsl_usb2_udc_data {
> > > +	const char *devid;
> > >  	resource_size_t iobase;
> > >  	resource_size_t irq;
> > >  };
> > > diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch=
/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > index 37e4439..fb527c7 100644
> > > --- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > +++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > @@ -11,35 +11,36 @@
> > >  #include "../hardware.h"
> > >  #include "devices-common.h"
> > > =20
> > > -#define imx_fsl_usb2_udc_data_entry_single(soc)				\
> > > +#define imx_fsl_usb2_udc_data_entry_single(soc, _devid)			\
> > >  	{								\
> > > +		.devid =3D _devid,					\
> > >  		.iobase =3D soc ## _USB_OTG_BASE_ADDR,			\
> > >  		.irq =3D soc ## _INT_USB_OTG,				\
> > >  	}
> > > =20
> > >  #ifdef CONFIG_SOC_IMX25
> > >  const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initcon=
st =3D
> > > -	imx_fsl_usb2_udc_data_entry_single(MX25);
> > > +	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx25");
> > >  #endif /* ifdef CONFIG_SOC_IMX25 */
> > > =20
> > >  #ifdef CONFIG_SOC_IMX27
> > >  const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initcon=
st =3D
> > > -	imx_fsl_usb2_udc_data_entry_single(MX27);
> > > +	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
> > >  #endif /* ifdef CONFIG_SOC_IMX27 */
> > > =20
> > >  #ifdef CONFIG_SOC_IMX31
> > >  const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initcon=
st =3D
> > > -	imx_fsl_usb2_udc_data_entry_single(MX31);
> > > +	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx31");
> > >  #endif /* ifdef CONFIG_SOC_IMX31 */
> > > =20
> > >  #ifdef CONFIG_SOC_IMX35
> > >  const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initcon=
st =3D
> > > -	imx_fsl_usb2_udc_data_entry_single(MX35);
> > > +	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx35");
> > >  #endif /* ifdef CONFIG_SOC_IMX35 */
> > > =20
> > >  #ifdef CONFIG_SOC_IMX51
> > >  const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data __initcon=
st =3D
> > > -	imx_fsl_usb2_udc_data_entry_single(MX51);
> > > +	imx_fsl_usb2_udc_data_entry_single(MX51, "imx-udc-mx51");
> > >  #endif
> > > =20
> > >  struct platform_device *__init imx_add_fsl_usb2_udc(
> > > @@ -57,7 +58,7 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
> > >  			.flags =3D IORESOURCE_IRQ,
> > >  		},
> > >  	};
> > > -	return imx_add_platform_device_dmamask("fsl-usb2-udc", -1,
> > > +	return imx_add_platform_device_dmamask(data->devid, -1,
> > >  			res, ARRAY_SIZE(res),
> > >  			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
> > >  }
> >=20
> > <snip>
> >=20
> > > +static const struct platform_device_id fsl_udc_devtype[] =3D {
> > > +	{
> > > +		.name =3D "imx-udc-mx25",
> > > +	}, {
> > > +		.name =3D "imx-udc-mx27",
> > > +	}, {
> > > +		.name =3D "imx-udc-mx31",
> > > +	}, {
> > > +		.name =3D "imx-udc-mx35",
> > > +	}, {
> > > +		.name =3D "imx-udc-mx51",
> > > +	}
> > > +};
> >=20
> > From what I understand balbi's comment, he dislikes this full list of
> > device id.  Instead, he prefers to something like below.
> >=20
> > static const struct platform_device_id fsl_udc_devtype[] =3D {
> > 	{
> > 		.name =3D "imx-udc-mx27",
> > 	}, {
> > 		.name =3D "imx-udc-mx51",
> > 	}
> > };
> >=20
> > It basically tells that we are handling two type of devices here, one
> > is imx-udc-mx27 type and the other is imx-udc-mx51 type, with mx25/31/35
> > completely compatible with mx27 type.  We choose mx27 instead of mx25
> > to define the type because mx27 Si came out earlier than mx25.  That
> > said, we generally choose the earlies SoC name to define a particular
> > version of IP block, since hardware version is mostly unavailable or
> > unreliable.
> >=20
> > But that also means in platform code which create the platform_device,
> > you will need to use name "imx-udc-mx27" for even mx25/31/35.
> >=20
> > 	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
> > 	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx27");
> > 	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx27");
> >=20
> > Considering this is a piece of code we will not use for any new
> > hardware, I'm fine with either way.
> >=20
> > So, balbi, it's all your call to accept the series as it is or ask for
> > another iteration.

right :-)

> Thanks Shawn. Let's see Felipe's comment, nevertheless, I will send v6 pa=
tch
> due to a compile error at mx25

Shawn is right.

--=20
balbi

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ98DuAAoJEIaOsuA1yqREx+UP/1xEEWbOwlGxuksWwv3nadt/
dFTXADK8JFq6q0rD0oec0T8MX7QZKKq/PC4BHXfNdISlo+y5slgRduBnBHOSCqPh
29EpLsu9ipxlMAYGRSCcMHi2tVFxV2ORg4DFfqcIlU8jw5wUSs2y7tk5BVrX9/8j
6c1Mb/ZoxSVK4ccjY8YmioWJewaPucFVWTVDmnRkoYUtRbnN0fUNmQLNOR8rVxOG
LHiLBs1I8FcYOyuwiK/ON6vGX8K0i8gujV3J3sUtDECBnji5yvnNYSsKc3khLYfQ
5vnqhCsXoosk9btdn3fau8ZpcnyYM0UM7b8FWvBzfLqG4S9yUI0e8u0D2iEI+cJc
BuPRRdVIf8avL+NBlzfwTAcxffj8q9iI5r+AHdxBbFO24Xika4Y3c9hWsRbCSBoM
Kt9GuAPgfLHGzZhPNo0ZuUzY76BTAP1w7ZUBLw3lepifPiCLEBZR2yDdPk99OpcS
12vbekW6m0iGbXBQItT9GrVLtmcb3T8pdzbFtcHS9kMZHl8927Z58CnPoQD2M6Q3
Rj2qXj5Y8plhMf3Rs9SWzPWUtLXSFQV21dCASCaJ32f0A25pad6A0tT6f6rMrNg3
j1B6pYosgcEoKDgRSfVCSUnExtrAPaeSuORY0BjEsHXtY5VMe3Kh120IUUp/MhnD
dDUh4/aOAQuTXaLMeVzG
=DPSD
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
