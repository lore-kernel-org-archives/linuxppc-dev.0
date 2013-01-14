Return-Path: <B29397@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DC832C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 23:56:49 +1100 (EST)
Date: Mon, 14 Jan 2013 20:56:33 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114125632.GA30157@nchen-desktop>
References: <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20130114110600.GI10874@arwen.pp.htv.fi>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
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

On Mon, Jan 14, 2013 at 01:06:00PM +0200, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 12:03:04PM +0100, Marc Kleine-Budde wrote:
> > On 01/14/2013 11:53 AM, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Mon, Jan 14, 2013 at 11:50:41AM +0100, Marc Kleine-Budde wrote:
> > >> On 01/14/2013 11:39 AM, Felipe Balbi wrote:
> > >>> On Mon, Jan 14, 2013 at 11:34:05AM +0100, Marc Kleine-Budde wrote=
:
> > >>>> On 01/14/2013 11:24 AM, Felipe Balbi wrote:
> > >>>>> On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wro=
te:
> > >>>>>> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> > >>>>>>>> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct=
 device *dev)
> > >>>>>>>> =20
> > >>>>>>>>  	return fsl_udc_resume(NULL);
> > >>>>>>>>  }
> > >>>>>>>> -
> > >>>>>>>>  /*---------------------------------------------------------=
----------------
> > >>>>>>>>  	Register entry point for the peripheral controller driver
> > >>>>>>>>  -----------------------------------------------------------=
---------------*/
> > >>>>>>>> -
> > >>>>>>>> +static const struct platform_device_id fsl_udc_devtype[] =3D=
 {
> > >>>>>>>> +	{
> > >>>>>>>> +		.name =3D "imx-udc-mx25",
> > >>>>>>>> +		.driver_data =3D IMX25_UDC,
> > >>>>>>>> +	}, {
> > >>>>>>>> +		.name =3D "imx-udc-mx27",
> > >>>>>>>> +		.driver_data =3D IMX27_UDC,
> > >>>>>>>> +	}, {
> > >>>>>>>> +		.name =3D "imx-udc-mx31",
> > >>>>>>>> +		.driver_data =3D IMX31_UDC,
> > >>>>>>>> +	}, {
> > >>>>>>>> +		.name =3D "imx-udc-mx35",
> > >>>>>>>> +		.driver_data =3D IMX35_UDC,
> > >>>>>>>> +	}, {
> > >>>>>>>> +		.name =3D "imx-udc-mx51",
> > >>>>>>>> +		.driver_data =3D IMX51_UDC,
> > >>>>>>>> +	}
> > >>>>>>>> +};
> > >>>>>>>
> > >>>>>>> I wonder if your driver-data is actually needed since you can=
 use string
> > >>>>>>> comparisson to achieve the exact same outcome.
> > >>>>>>
> > >>>>>> Why use a string compare, if the kernel infrastructure already=
 does this
> > >>>>>> for you?
> > >>>>>
> > >>>>> what do you mean ? What kernel infrastructure is doing waht for=
 me ?
> > >>>>
> > >>>> The kernel infrastructure is doing the string compare for you to=
 match
> > >>>> the device against the driver (via platform_device_id->name). Yo=
u get
> > >>>> the a pointer to the driver_data for free. So you don't need any=
 string
> > >>>> compare in the driver later.
> > >>>
> > >>> but current driver data is just duplicating name with an integer,=
 it's
> > >>> pretty useless driver data.
> > >>
> > >> I don't think so - another argument:
> > >> Less code. As struct platform_device_id is a static array the spac=
e is
> > >> allocated anyway. So it doesn't make any difference if driver_data=
 is
> > >> NULL or not. Later you just need to make an integer comparison ins=
tead
> > >> of a call to a strcmp(), if you have a switch/case and IMX*_UDC is=
 an
> > >> enum, the compiler will warn you if you've missed an IMX variant.
> > >=20
> > > fair enough, but then don't create a different enum value for each =
imx
> > > instance if they're mostly the same. Differentiate only what's actu=
ally
> > > different.
> >=20
> > Usually there isn't any Changelog between IP cores used in the differ=
ent
> > fsl processors (at least available outside of fsl), that makes it qui=
te
> > difficult to say if something found on one imx is really the same as =
on
> > the other one. And they (usually) don't provide any versioning
> > information in a register or the documentation.
> >=20
> > just my 2=A2
>=20
> $SUBJECT is trying to differentiate a single feature (or maybe two) to
> replace cpu_is_xxx(), then expose that on driver_data without creating
> one enum value for each release from fsl.

Felipe, every one or two SoCs may have their special operations for
integrate PHY interface, clk operation, or workaround for IC limitation.

Maybe, it will add more future or SoCs (maybe not for this driver)
in the future, using enum is easier than string comparison for expanding =
something.
>=20
> --=20
> balbi



--=20

Best Regards,
Peter Chen
