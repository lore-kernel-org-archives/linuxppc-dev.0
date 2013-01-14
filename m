Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CB392C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:40:18 +1100 (EST)
Date: Mon, 14 Jan 2013 12:39:52 +0200
From: Felipe Balbi <balbi@ti.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114103952.GF10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
In-Reply-To: <50F3DF1D.3040706@pengutronix.de>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, Peter Chen <peter.chen@freescale.com>, kernel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
> > On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
> >> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> >>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device =
*dev)
> >>>> =20
> >>>>  	return fsl_udc_resume(NULL);
> >>>>  }
> >>>> -
> >>>>  /*-----------------------------------------------------------------=
--------
> >>>>  	Register entry point for the peripheral controller driver
> >>>>  -------------------------------------------------------------------=
-------*/
> >>>> -
> >>>> +static const struct platform_device_id fsl_udc_devtype[] =3D {
> >>>> +	{
> >>>> +		.name =3D "imx-udc-mx25",
> >>>> +		.driver_data =3D IMX25_UDC,
> >>>> +	}, {
> >>>> +		.name =3D "imx-udc-mx27",
> >>>> +		.driver_data =3D IMX27_UDC,
> >>>> +	}, {
> >>>> +		.name =3D "imx-udc-mx31",
> >>>> +		.driver_data =3D IMX31_UDC,
> >>>> +	}, {
> >>>> +		.name =3D "imx-udc-mx35",
> >>>> +		.driver_data =3D IMX35_UDC,
> >>>> +	}, {
> >>>> +		.name =3D "imx-udc-mx51",
> >>>> +		.driver_data =3D IMX51_UDC,
> >>>> +	}
> >>>> +};
> >>>
> >>> I wonder if your driver-data is actually needed since you can use str=
ing
> >>> comparisson to achieve the exact same outcome.
> >>
> >> Why use a string compare, if the kernel infrastructure already does th=
is
> >> for you?
> >=20
> > what do you mean ? What kernel infrastructure is doing waht for me ?
>=20
> The kernel infrastructure is doing the string compare for you to match
> the device against the driver (via platform_device_id->name). You get
> the a pointer to the driver_data for free. So you don't need any string
> compare in the driver later.

but current driver data is just duplicating name with an integer, it's
pretty useless driver data.

--=20
balbi

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8+B3AAoJEIaOsuA1yqREJx4P/2OKvrv58EPOfEheAF4Ovw5B
3vjsSpyx/df0bNGjuOamrehoU820IcEohV3SUQezr2pIRUek9dksU1k40VqUCOhR
WaUMBUy/HzuZ2RIYnGzZGLAE+SC5CixxoFIrOWfD6ZyixLi9ncwt90mM/GWMNOAg
mIupt1+V96h9qcoFZnw5VztBRAjJElg/dQdkS/jSnOrGN1ffOWSLMYBe2Y4SUxOZ
PYeDy0hbKBiVgy7p2KwxXaxjeXTRjoCl6Q5Y4O5pofnuAJ66dxSYcEAE8U0CwIhf
nwb9LbyQk+Bis5O7t4iqIgOISJyh9dPYhhsSMQelv6sfkC8Zgv+laNI2t6FzY+/9
/WrXiNxrZLLoIUrJEsN8XDFLcm/ApqT38rn54OCw2e3tfvS9mfJL1sQFRyRGF8r4
C8TOvNUDx4NL3C452Q7RFSJkttzUAgk//M2bJngTMq58s2b0SriPF5/xQ1FPURyU
3TJgnkru8fTCjAEHV8Kp6uR574Wfu0SBa7Iynb74ZDvqMhkNDpRrhclCHob6sO6e
5cHc2vydogk8pn3/jv3Ma/dfnXqqxolom9bAlIaPB03joYqsnRTwcP92T5vftdw+
qyV2U3tBje06uXUJ6ThniRF6CGFcWoGuxT+cXkdcTc9HMo7sDTVlW27SozeiwUoC
oomrkAYnMef4d1u1VNGe
=VCKr
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
