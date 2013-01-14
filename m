Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 13E712C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 04:54:39 +1100 (EST)
Message-ID: <50F4464E.7000605@pengutronix.de>
Date: Mon, 14 Jan 2013 18:54:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: balbi@ti.com
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
References: <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de> <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de> <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de> <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de> <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
 <20130114174054.GB12611@arwen.pp.htv.fi>
In-Reply-To: <20130114174054.GB12611@arwen.pp.htv.fi>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ILAQSGMKAGWJLOTHTXHF"
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
------enig2ILAQSGMKAGWJLOTHTXHF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/14/2013 06:40 PM, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:
>=20
> <snip>
>=20
>>>> Usually there isn't any Changelog between IP cores used in the diffe=
rent
>>>> fsl processors (at least available outside of fsl), that makes it qu=
ite
>>>> difficult to say if something found on one imx is really the same as=
 on
>>>> the other one. And they (usually) don't provide any versioning
>>>> information in a register or the documentation.
>>>>
>>>> just my 2=A2
>>>
>>> $SUBJECT is trying to differentiate a single feature (or maybe two) t=
o
>>> replace cpu_is_xxx(), then expose that on driver_data without creatin=
g
>>> one enum value for each release from fsl.
>>
>> Felipe, every one or two SoCs may have their special operations for
>> integrate PHY interface, clk operation, or workaround for IC
>> limitation.
>=20
> the particular PHY and clk used should be hidden by phy layer and clk
> API respectively. Workarounds, fair enough, we need to handle them; but=

> ideally those should be based on runtime revision detection, not some
> hackery using driver_data.

If this is actually possible, I'd love to do this. But IP vendor don't
include a version register in their cores. :(

>> Maybe, it will add more future or SoCs (maybe not for this driver) in
>> the future, using enum is easier than string comparison for expanding
>> something.
>=20
> a) I never told you to *not* use enum. I said that creating DEVICE_A,
> DEVICE_B, DEVICE_C, DEVICE_D and DEVICE_E values when DEVICE_B,
> DEVICE_C and DEVICE_E behave exactly the same is unnecessary.
>=20
> b) you can't be expecting to add future SoCs support to fsl udc, I have=

> already said and will repeat for the last time: move to chipidea ASAP.
>=20
> New SoCs cannot be added to fsl udc, you *must* use chipidea for
> anything new and move the legacy to chipidea eventually. I will wait fo=
r
> a full year for you to do that, but after that I will have to start
> deleting drivers for the sake of avoid duplication of effort.

+1

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2ILAQSGMKAGWJLOTHTXHF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlD0RlEACgkQjTAFq1RaXHPWKQCXfDbAUtRNEIZcqA2QIlglMWoB
uwCgkFrK5MypYQKGziqawvboYUIxfqE=
=x7B9
-----END PGP SIGNATURE-----

------enig2ILAQSGMKAGWJLOTHTXHF--
