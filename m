Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80959B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 17:39:15 +1000 (EST)
Subject: Re: 2.6.31-rc7 : kernel BUG at drivers/rtc/rtc-ps3.c:36!
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A923AD3.1020507@in.ibm.com>
References: <4A923AD3.1020507@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-GqcUfOwnSUSmZcU93szG"
Date: Mon, 24 Aug 2009 17:39:12 +1000
Message-Id: <1251099552.19818.4.camel@concordia>
Mime-Version: 1.0
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-GqcUfOwnSUSmZcU93szG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-08-24 at 12:31 +0530, Sachin Sant wrote:
> While trying to boot 2.6.31-rc7 on a power6 machine came
> across the following Bug.=20
>=20
> Starting udev: ------------[ cut here ]------------
> kernel BUG at drivers/rtc/rtc-ps3.c:36!
> cpu 0x0: Vector: 700 (Program Check) at [c0000000f70f3570]
>     pc: c00000000059a020: .ps3_get_time+0x3c/0x84
>     lr: c00000000059a018: .ps3_get_time+0x34/0x84
>     sp: c0000000f70f37f0
>    msr: 8000000000029032
>   current =3D 0xc0000000f8d14ee0
>   paca    =3D 0xc0000000012cc300
>     pid   =3D 159, comm =3D hwclock
> kernel BUG at drivers/rtc/rtc-ps3.c:36!

> static u64 read_rtc(void)
> {
> ....
> result =3D lv1_get_rtc(&rtc_val, &tb_val);
> BUG_ON(result);
>=20
> I had never tried enabling CONFIG_RTC_DRV_PS3 option before
> so not sure if this is a new problem or an old one.=20

Looks like an old one, or at least as long as the driver has existed.

The code needs to cope with being called on something other than a PS3.
Either the platform driver is only registered if the machine is a PS3,
or ps3_rtc_probe() actually does something to check it's on a PS3 before
registering the rtc_device.

cheers

--=-GqcUfOwnSUSmZcU93szG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqSQ50ACgkQdSjSd0sB4dJ4yACeOVr/03JplXE4BywOwAZ8A+Yc
I8gAnjq6Z0/0Rcu7GQ/06KUloZ2dM0aj
=Vu5w
-----END PGP SIGNATURE-----

--=-GqcUfOwnSUSmZcU93szG--
