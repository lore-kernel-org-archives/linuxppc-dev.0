Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id 40B44DE127
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 05:36:56 +1000 (EST)
Received: from antares (xdsl-87-79-52-42.netcologne.de [87.79.52.42])
	by smtp3.netcologne.de (Postfix) with ESMTP id C92AA6784E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 21:36:53 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 8AD94BA042
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 21:36:53 +0200 (CEST)
Date: Wed, 20 May 2009 21:36:45 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
To: linuxppc-dev@ozlabs.org
In-Reply-To: <4A14124D.4090200@mlbassoc.com> (from gary@mlbassoc.com on Wed
	May 20 16:23:09 2009)
Message-Id: <1242848213.3432.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-vLJRioaKkz4AacN/fvFJ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-vLJRioaKkz4AacN/fvFJ
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.05.09 16:23 schrieb(en) Gary Thomas:
> > In Linux, when I write the file to /dev/mtdx, the last dword of =20
> each block is broken, e.g. when running "dd if=3Dpattern of=3D/dev/mtd5 =20
> bs=3D512" the dword's at offset 0x1fc, 0x3fc, ... are 0x0000aaaa =20
> (instead of 0x0055aaff), if I use bs=3D1024 the dwords at 0x3fc, 0x7fc, =20
> ... show this value, if I use bs=3D4096 the dword at 0xffc shows this =20
> value, etc.  I looked at the CS/WR lines with a scope, and I couldn't =20
> see anything special.  The timing should be fine, as u-boot uses the =20
> same as Linux.
> >
> > Any idea what goes wrong here?  I guessed I missed something in the =20
> LPB setup...
>=20
> Check your cache setup - the BDI is most certainly not accessing this =20
> via the Data cache whereas Linux probably will be.

Hmm, yes - I didn't touch the vanilla Lite5200B Linux setup there, =20
which has a flash chip at cs1...

If it is really a cache problem (I'm away now from my test board) - =20
isn't a sync sufficient after doing the copy to the external ram =20
(lpb/cs1)?  What is the proper approach for devices attached to the =20
localbus?

Thanks, Albrecht.

--=-vLJRioaKkz4AacN/fvFJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKFFvVn/9unNAn/9ERAjbuAJ9BW1iO/azfXip7+hEOIEcUv039YgCfRJwU
POwXJ3G464MzoJPLOi66K1o=
=x0gF
-----END PGP SIGNATURE-----

--=-vLJRioaKkz4AacN/fvFJ--
