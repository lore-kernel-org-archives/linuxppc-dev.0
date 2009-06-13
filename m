Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A6797B720C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 02:45:57 +1000 (EST)
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id 43F89DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 02:45:56 +1000 (EST)
Date: Sat, 13 Jun 2009 18:45:44 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit
	Local Plus Bus
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
	(from grant.likely@secretlab.ca on Thu Jun 11 18:27:53 2009)
Message-Id: <1244911551.3423.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-DeDYjMhpDed7oLavi10C"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-DeDYjMhpDed7oLavi10C
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.06.09 18:27 schrieb(en) Grant Likely:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u16 *)buf =3D *((volatile u16 *)(vdest -=
 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] =3D *((u8 *)src);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((volatile u16 *)(vdest - 1)) =3D *(u16 *=
)buf;
>=20
> what is the purpose of volatile here?  If you need io barriers, then =20
> use the in_/out_be16 macros.

Yes, you're right - should be completely superfluous here.  A result of =20
copy & paste without thinking... :-(

> Blech.  ugly #ifdef and not really multiplatform safe (yeah, I know =20
> it shouldn't break non-5200 platforms, but it does have an =20
> undesirable impact).  There's got to be a better way.

Ouch, yes - I completely forgot the possibility of multi-platform =20
builds.

Am 11.06.09 19:28 schrieb(en) Grant Likely:
> So; the solution to me seems to be on an MPC5200 platform replace the =20
> offending hooks with MPC5200 specific variants at runtime.

Will re-work the patch that way!  BTW, a dumb question: what is the =20
proper way to determine which cpu the system is running on?  Check the =20
CPU node of the of tree?

Thanks, Albrecht.

--=-DeDYjMhpDed7oLavi10C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKM9e/n/9unNAn/9ERAsJXAJ0bonlT621dYvWLYrRz/5SMuRsX2QCgv94T
D2rNTgS7PWvmC61eA6MHtpo=
=HuiX
-----END PGP SIGNATURE-----

--=-DeDYjMhpDed7oLavi10C--
