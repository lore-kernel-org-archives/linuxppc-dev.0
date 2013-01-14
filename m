Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 535582C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 22:06:12 +1100 (EST)
Date: Mon, 14 Jan 2013 13:06:00 +0200
From: Felipe Balbi <balbi@ti.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114110600.GI10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
In-Reply-To: <50F3E5E8.2000905@pengutronix.de>
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

--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 12:03:04PM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 11:53 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 14, 2013 at 11:50:41AM +0100, Marc Kleine-Budde wrote:
> >> On 01/14/2013 11:39 AM, Felipe Balbi wrote:
> >>> On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote:
> >>>> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
> >>>>> On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
> >>>>>> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> >>>>>>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct dev=
ice *dev)
> >>>>>>>> =20
> >>>>>>>>  	return fsl_udc_resume(NULL);
> >>>>>>>>  }
> >>>>>>>> -
> >>>>>>>>  /*-------------------------------------------------------------=
------------
> >>>>>>>>  	Register entry point for the peripheral controller driver
> >>>>>>>>  ---------------------------------------------------------------=
-----------*/
> >>>>>>>> -
> >>>>>>>> +static const struct platform_device_id fsl_udc_devtype[] =3D {
> >>>>>>>> +	{
> >>>>>>>> +		.name =3D "imx-udc-mx25",
> >>>>>>>> +		.driver_data =3D IMX25_UDC,
> >>>>>>>> +	}, {
> >>>>>>>> +		.name =3D "imx-udc-mx27",
> >>>>>>>> +		.driver_data =3D IMX27_UDC,
> >>>>>>>> +	}, {
> >>>>>>>> +		.name =3D "imx-udc-mx31",
> >>>>>>>> +		.driver_data =3D IMX31_UDC,
> >>>>>>>> +	}, {
> >>>>>>>> +		.name =3D "imx-udc-mx35",
> >>>>>>>> +		.driver_data =3D IMX35_UDC,
> >>>>>>>> +	}, {
> >>>>>>>> +		.name =3D "imx-udc-mx51",
> >>>>>>>> +		.driver_data =3D IMX51_UDC,
> >>>>>>>> +	}
> >>>>>>>> +};
> >>>>>>>
> >>>>>>> I wonder if your driver-data is actually needed since you can use=
 string
> >>>>>>> comparisson to achieve the exact same outcome.
> >>>>>>
> >>>>>> Why use a string compare, if the kernel infrastructure already doe=
s this
> >>>>>> for you?
> >>>>>
> >>>>> what do you mean ? What kernel infrastructure is doing waht for me ?
> >>>>
> >>>> The kernel infrastructure is doing the string compare for you to mat=
ch
> >>>> the device against the driver (via platform_device_id->name). You get
> >>>> the a pointer to the driver_data for free. So you don't need any str=
ing
> >>>> compare in the driver later.
> >>>
> >>> but current driver data is just duplicating name with an integer, it's
> >>> pretty useless driver data.
> >>
> >> I don't think so - another argument:
> >> Less code. As struct platform_device_id is a static array the space is
> >> allocated anyway. So it doesn't make any difference if driver_data is
> >> NULL or not. Later you just need to make an integer comparison instead
> >> of a call to a strcmp(), if you have a switch/case and IMX*_UDC is an
> >> enum, the compiler will warn you if you've missed an IMX variant.
> >=20
> > fair enough, but then don't create a different enum value for each imx
> > instance if they're mostly the same. Differentiate only what's actually
> > different.
>=20
> Usually there isn't any Changelog between IP cores used in the different
> fsl processors (at least available outside of fsl), that makes it quite
> difficult to say if something found on one imx is really the same as on
> the other one. And they (usually) don't provide any versioning
> information in a register or the documentation.
>=20
> just my 2=A2

$SUBJECT is trying to differentiate a single feature (or maybe two) to
replace cpu_is_xxx(), then expose that on driver_data without creating
one enum value for each release from fsl.

--=20
balbi

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8+aYAAoJEIaOsuA1yqREC+YP/iclHQvALZGc2BbC9H1ofxNl
paVbLWT5Wuv0jBtIdz9sf1oWQ+B6lJpKWHgRlpueblPUl1Wq2yNpfqtBlCqFYTGU
WrhACG6artCSymyu68/HzafR1QAUHZnTCYvyaFceLsv/8UWM+Gb9LNSI6D4Ohyq7
LE8raPKubiQAhSlUwfRBnmrpDXKssVtc6kMaoF1oZfYSgoxXYRrY5iKVVs0StsOl
qE6jun4Hz9EIv5RxYhVcxNYjMlI90wsqwzBhGIh70XqxeNeiSaw7axCwJqRMmpu6
g490NjeI6HDxYdBOwYnMLVN8PnshSUqUNz27czKidenRpLGrZDGmrAg6/k4hWAD+
Y6YzJjbDr06GD5rCqCpYXQPwOR4ig5aI2RKlP/W1npuV9PzTFYDqIAHg1jPSBZk5
4paMjkO3n59ouzpeZF3XSt+yugdvdJxwDLBGv3V7InM3LcW6iNCZHTK/nd+n0xno
ALgfUZDrQX0azVzclIEHu+PltU8PNsZ77uWeKYEf+ro5dty3+MNoDpEEpyDsiW0s
wrbCJz4bzy3vr5aBf09sja91DHbEnnNV7m+P7ehNQwk6sEDgqQK1rtLUys+jiU+j
wbwBhWsy63e4i4GSMk7V/t7l4FC+zLOvRbZ1OehbM0vmpSHETcgzQrBzvSTC6AzO
XY2dj04mh5P1XIPfsvgq
=MyOv
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
