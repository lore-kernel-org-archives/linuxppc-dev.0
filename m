Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F28D2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:54:10 +1100 (EST)
Date: Mon, 14 Jan 2013 12:53:57 +0200
From: Felipe Balbi <balbi@ti.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114105357.GH10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
In-Reply-To: <50F3E301.7040509@pengutronix.de>
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

--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 11:50:41AM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 11:39 AM, Felipe Balbi wrote:
> > On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote:
> >> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
> >>> On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
> >>>> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> >>>>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct devic=
e *dev)
> >>>>>> =20
> >>>>>>  	return fsl_udc_resume(NULL);
> >>>>>>  }
> >>>>>> -
> >>>>>>  /*---------------------------------------------------------------=
----------
> >>>>>>  	Register entry point for the peripheral controller driver
> >>>>>>  -----------------------------------------------------------------=
---------*/
> >>>>>> -
> >>>>>> +static const struct platform_device_id fsl_udc_devtype[] =3D {
> >>>>>> +	{
> >>>>>> +		.name =3D "imx-udc-mx25",
> >>>>>> +		.driver_data =3D IMX25_UDC,
> >>>>>> +	}, {
> >>>>>> +		.name =3D "imx-udc-mx27",
> >>>>>> +		.driver_data =3D IMX27_UDC,
> >>>>>> +	}, {
> >>>>>> +		.name =3D "imx-udc-mx31",
> >>>>>> +		.driver_data =3D IMX31_UDC,
> >>>>>> +	}, {
> >>>>>> +		.name =3D "imx-udc-mx35",
> >>>>>> +		.driver_data =3D IMX35_UDC,
> >>>>>> +	}, {
> >>>>>> +		.name =3D "imx-udc-mx51",
> >>>>>> +		.driver_data =3D IMX51_UDC,
> >>>>>> +	}
> >>>>>> +};
> >>>>>
> >>>>> I wonder if your driver-data is actually needed since you can use s=
tring
> >>>>> comparisson to achieve the exact same outcome.
> >>>>
> >>>> Why use a string compare, if the kernel infrastructure already does =
this
> >>>> for you?
> >>>
> >>> what do you mean ? What kernel infrastructure is doing waht for me ?
> >>
> >> The kernel infrastructure is doing the string compare for you to match
> >> the device against the driver (via platform_device_id->name). You get
> >> the a pointer to the driver_data for free. So you don't need any string
> >> compare in the driver later.
> >=20
> > but current driver data is just duplicating name with an integer, it's
> > pretty useless driver data.
>=20
> I don't think so - another argument:
> Less code. As struct platform_device_id is a static array the space is
> allocated anyway. So it doesn't make any difference if driver_data is
> NULL or not. Later you just need to make an integer comparison instead
> of a call to a strcmp(), if you have a switch/case and IMX*_UDC is an
> enum, the compiler will warn you if you've missed an IMX variant.

fair enough, but then don't create a different enum value for each imx
instance if they're mostly the same. Differentiate only what's actually
different.

--=20
balbi

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8+PFAAoJEIaOsuA1yqRE0dMP/33jx5LEqYRohRmS7/LOUrU7
+YtGJagmEvwTiGQIf+T+6aq94Kn9vlRdmq9g9CpqJ9bJUQSnzkhJgj+9SXRKy3ZU
COlziaKkoHexbnBPNBtGMHrHZXKQZ7eg5HOae0ErAUnfk/VOks8eV+0k2C2osB0F
JJp3MirnbJxCuwoyEaRx5T1urJDn252G65nJy9ak0ImsLhqWuE5Im/cP8TIxMuB+
NOcVXr+IHoOLXCa1Hm3iFdmqEST4wPgAWmuR0ibeOoIsoC43M/vd4hh9/wCQE31Y
eoLR6wzfLiZqYTxM7/Dr9g+VDMMVQwKNwV+bN6O4Pb5i7fK1kJnpzIh7hlo+UoKT
2UEURRURvygxP74g+wF/LKGLyKmFuisUOn6Z1muxV6EVivReimcPfl+Cy5vCYBax
8SgbfqDLvRCU55e8TToEkd28253yk4ll30kFnhICxzL/jZKt6+goHIDDQY5vHbpn
O+pVMEITq2qtDvuLvFZG+uyvS3mj4zL4kK/DXBE4SiYXYlrd/s96+UkOedrrv0j8
kDhK/YHWiHVtTpvA80ZP8Rdn2b2Hfuz/w31yvXiDpPeEgV51nkej7VofnD/E527V
APjJWqk+IjDT9YKAFF3pxYMEvX+nrYaxJkhq6MWIWcyFzGDRoLlBq1o1wOMNfCcd
U94U1D5xgiPrnRAlRmoy
=L95Z
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
