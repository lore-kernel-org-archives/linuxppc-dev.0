Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C2B42C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 04:41:06 +1100 (EST)
Date: Mon, 14 Jan 2013 19:40:54 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114174054.GB12611@arwen.pp.htv.fi>
References: <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
In-Reply-To: <20130114125632.GA30157@nchen-desktop>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
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

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:

<snip>

> > > Usually there isn't any Changelog between IP cores used in the differ=
ent
> > > fsl processors (at least available outside of fsl), that makes it qui=
te
> > > difficult to say if something found on one imx is really the same as =
on
> > > the other one. And they (usually) don't provide any versioning
> > > information in a register or the documentation.
> > >=20
> > > just my 2=A2
> >=20
> > $SUBJECT is trying to differentiate a single feature (or maybe two) to
> > replace cpu_is_xxx(), then expose that on driver_data without creating
> > one enum value for each release from fsl.
>=20
> Felipe, every one or two SoCs may have their special operations for
> integrate PHY interface, clk operation, or workaround for IC
> limitation.

the particular PHY and clk used should be hidden by phy layer and clk
API respectively. Workarounds, fair enough, we need to handle them; but
ideally those should be based on runtime revision detection, not some
hackery using driver_data.

> Maybe, it will add more future or SoCs (maybe not for this driver) in
> the future, using enum is easier than string comparison for expanding
> something.

a) I never told you to *not* use enum. I said that creating DEVICE_A,
DEVICE_B, DEVICE_C, DEVICE_D and DEVICE_E values when DEVICE_B,
DEVICE_C and DEVICE_E behave exactly the same is unnecessary.

b) you can't be expecting to add future SoCs support to fsl udc, I have
already said and will repeat for the last time: move to chipidea ASAP.

New SoCs cannot be added to fsl udc, you *must* use chipidea for
anything new and move the legacy to chipidea eventually. I will wait for
a full year for you to do that, but after that I will have to start
deleting drivers for the sake of avoid duplication of effort.

cheers

--=20
balbi

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9EMmAAoJEIaOsuA1yqREY34P/2oWZxsoCtrC58rAaTQHg25l
BWDotj23XQuAHtZt5u+yyR108KKyAXUTu8MAh3DD1xV6pXZnbu0CFw3sWe7a/sIJ
zq4G+QL3/TNMh4Tu7W6FT2FZ17ALc28LBlKMx0rJIX4yAER7qucTmCkwdncQtB64
tWLqcfGVtJtUSi9nsf1dUa2PYBnIf/OSqxFL0bCP3+jX9uNfPyrTLNqyXdk9wep4
m5rz5EqzhjHTa2gR9q7ScZl0nHV4CBzQtzOLxysdEd+toGYK6Cx9jEX07BDMO/rl
I6rT5gliBWSiMI9FEkeTAZ+9mJGxq4XY9CWkucHjpJsHXcyKvMHszBkDlBS0qMAq
aLzIxswiFLSfl8CmRt56cfso0yG/rJcUm9U7Nx0ARXtkVdCejB1G9gHAINyOq6SC
ruGxCfmzK/PWf8bBkg+VbkGYmtfLgmbuvjcYNVhpu7sFFbKimjmRnRRmzVa6vduz
lMdIb5uel3WNzhYyg8HjI+wk//6YxGBZ07fZcYSiK2BbWTrkGXiKuujsn91aZTnC
hTOtl/FLiNHlqrCvgFziVIsPtbUFyDb0fM2ZoL2WZLAut20VmqiHemOtqYQASgLX
lTu8uve7TGuaQYXmnc6T3VZEC26ZZulocCcESLyQLB0IGZT1eJT5OcfX2acku2I7
GJ+L2XqUG+WbDCpvl3Nk
=p8pE
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
