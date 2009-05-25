Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id C3939DE0C4
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 03:41:26 +1000 (EST)
Received: from antares (xdsl-78-34-109-91.netcologne.de [78.34.109.91])
	by smtp4.netcologne.de (Postfix) with ESMTP id 5E2EFDA62F
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 19:41:24 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 22CC6BA042
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 19:41:24 +0200 (CEST)
Date: Mon, 25 May 2009 19:41:14 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090520200135.GB13287@pengutronix.de> (from
	w.sang@pengutronix.de on Wed May 20 22:01:35 2009)
Message-Id: <1243273283.3328.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-Ou84vrHEXDM8Kz+/Nipv"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-Ou84vrHEXDM8Kz+/Nipv
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gary & Wolfram:

Thanks for youre help, and sorry for the late reply - I've been on =20
vacation...

Am 20.05.09 21:59 schrieb(en) Gary Thomas:
> Try to access this without using the cache.

Unfortunately, this is not cache related - I switched the dcache off =20
completely - same results.

Am 20.05.09 22:01 schrieb(en) Wolfram Sang:
> Does it work with byte, word and long accesses?

A word or long copy of 0x0055aaff with U-Boot works fine, but a byte =20
copy filled the whole ram with 0x0000aaaa.  The reason is apparently =20
that the chip is attached to the local bus in 16-bit mode, which is =20
incompatible with byte accesses.  However, the Local Bus doesn't =20
provide "low byte" or "high byte" indicators in non-muxed mode.  How is =20
this supposed to work then?

For the mtd driver, I tracked down the problem via mapram_write() (in =20
drivers/mtd/chips/map_ram.c) down to the call of map_copy_to() which is =20
actually inline_map_copy_to(), which in turn calls memcpy_toio().  I =20
*think* this is _memcpy_toio() in arch/powerpc/kernel/io.c, which =20
copies all data in long (4-byte) moves, except for the last 4 bytes.  I =20
guess I have to write my own copy function which respects the fact that =20
byte writes actually must be a read word - modify - write word =20
sequence, right?

Thanks, Albrecht.

--=-Ou84vrHEXDM8Kz+/Nipv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKGthDn/9unNAn/9ERAhZuAKDJP2iyqvhOLDcs3JXV1XxTMdoldQCgloii
m1UiP1Qte4r7L0FV0DTwG9g=
=5TBa
-----END PGP SIGNATURE-----

--=-Ou84vrHEXDM8Kz+/Nipv--
