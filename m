Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7B6F5DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 02:04:12 +1000 (EST)
Date: Fri, 1 May 2009 18:04:03 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Using archaic I2C with OF
Message-ID: <20090501160403.GA7943@pengutronix.de>
References: <49FAF351.4010409@mlbassoc.com>
	<9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>
	<9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>
	<49FB0C3B.3000209@mlbassoc.com>
	<9e4733910905010755g595d686fmf075a40d6012e3fc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <9e4733910905010755g595d686fmf075a40d6012e3fc@mail.gmail.com>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Post this on the i2c list. Jean has made an effort to convert all
> drivers. He must have missed that one.

What Jean did was converting all drivers who used the legacy i2c-binding to=
 use
the new binding which is a lot better suited to the driver model. The above
mentioned driver already uses the new binding.

The problem coming up here is another issue and also long standing and not =
yet
solved. There are drivers which require platform_data with function pointer=
s.
You cannot encode function pointers to the device tree.

One solution is to create a custom driver for your board with the needed
specific function and create a platform device from there. Sometimes it
works to add a bit more info to the device tree (e.g. some gpios) and
parse it via an of_wrapper around the platform driver.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkn7HXMACgkQD27XaX1/VRu/wgCXYfg1T71KOqZ+3OU5sjHWENeg
jACfSQFPpm5KmHuRY9nICsVWdwX47RU=
=uIjC
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
