Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C74732C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:51:00 +1100 (EST)
Message-ID: <50F3E301.7040509@pengutronix.de>
Date: Mon, 14 Jan 2013 11:50:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: balbi@ti.com
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi> <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi> <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
In-Reply-To: <20130114103952.GF10874@arwen.pp.htv.fi>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XNNJXETSHDRPSRQWXVNL"
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Peter Chen <peter.chen@freescale.com>, kernel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XNNJXETSHDRPSRQWXVNL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/14/2013 11:39 AM, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote:
>> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
>>> On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
>>>> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
>>>>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct devic=
e *dev)
>>>>>> =20
>>>>>>  	return fsl_udc_resume(NULL);
>>>>>>  }
>>>>>> -
>>>>>>  /*---------------------------------------------------------------=
----------
>>>>>>  	Register entry point for the peripheral controller driver
>>>>>>  -----------------------------------------------------------------=
---------*/
>>>>>> -
>>>>>> +static const struct platform_device_id fsl_udc_devtype[] =3D {
>>>>>> +	{
>>>>>> +		.name =3D "imx-udc-mx25",
>>>>>> +		.driver_data =3D IMX25_UDC,
>>>>>> +	}, {
>>>>>> +		.name =3D "imx-udc-mx27",
>>>>>> +		.driver_data =3D IMX27_UDC,
>>>>>> +	}, {
>>>>>> +		.name =3D "imx-udc-mx31",
>>>>>> +		.driver_data =3D IMX31_UDC,
>>>>>> +	}, {
>>>>>> +		.name =3D "imx-udc-mx35",
>>>>>> +		.driver_data =3D IMX35_UDC,
>>>>>> +	}, {
>>>>>> +		.name =3D "imx-udc-mx51",
>>>>>> +		.driver_data =3D IMX51_UDC,
>>>>>> +	}
>>>>>> +};
>>>>>
>>>>> I wonder if your driver-data is actually needed since you can use s=
tring
>>>>> comparisson to achieve the exact same outcome.
>>>>
>>>> Why use a string compare, if the kernel infrastructure already does =
this
>>>> for you?
>>>
>>> what do you mean ? What kernel infrastructure is doing waht for me ?
>>
>> The kernel infrastructure is doing the string compare for you to match=

>> the device against the driver (via platform_device_id->name). You get
>> the a pointer to the driver_data for free. So you don't need any strin=
g
>> compare in the driver later.
>=20
> but current driver data is just duplicating name with an integer, it's
> pretty useless driver data.

I don't think so - another argument:
Less code. As struct platform_device_id is a static array the space is
allocated anyway. So it doesn't make any difference if driver_data is
NULL or not. Later you just need to make an integer comparison instead
of a call to a strcmp(), if you have a switch/case and IMX*_UDC is an
enum, the compiler will warn you if you've missed an IMX variant.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XNNJXETSHDRPSRQWXVNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlDz4wQACgkQjTAFq1RaXHNQsQCgiT8zmP2w+OqAmI437ClFjpHP
3IwAnAo5Pevgi1m6TzRmmpPMECgq4omI
=rUKP
-----END PGP SIGNATURE-----

------enig2XNNJXETSHDRPSRQWXVNL--
