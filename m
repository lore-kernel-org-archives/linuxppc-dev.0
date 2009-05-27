Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 297E6DDFD2
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 05:55:00 +1000 (EST)
Received: from antares (xdsl-84-44-237-107.netcologne.de [84.44.237.107])
	by smtp4.netcologne.de (Postfix) with ESMTP id 9EC18DA752
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 21:54:57 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 6F111BA03E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 21:54:57 +0200 (CEST)
Date: Wed, 27 May 2009 21:54:49 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [Solved/Patch Question] Weird 5200/mtd-ram problem
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090525214718.GA8152@pengutronix.de> (from
	w.sang@pengutronix.de on Mon May 25 23:47:18 2009)
Message-Id: <1243454097.3489.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-/U3OJm+uYOaVSqUGEEmE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-/U3OJm+uYOaVSqUGEEmE
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all:

Am 25.05.09 23:47 schrieb(en) Wolfram Sang:
>> A word or long copy of 0x0055aaff with U-Boot works fine, but a byte =20
>> copy filled the whole ram with 0x0000aaaa.  The reason is apparently =20
>> that the chip is attached to the local bus in 16-bit mode, which is =20
>> incompatible with byte accesses.  However, the Local Bus doesn't =20
>> provide "low byte" or "high byte" indicators in non-muxed mode.  How =20
>> is this supposed to work then?
>=20
> Hmm, as I feared... we were bitten by this, too:
>=20
> http://thread.gmane.org/gmane.linux.drivers.mtd/21521
>=20
> There is no generic solution yet :(

At least for my case, I could completely (afaict) solve the problem, =20
i.e. I can now access the 16-bit nv ram as mtd char and block device, =20
the latter with jffs2.  I would like to submit a patch, but I actually =20
don't know exactly how...

The solution itself is quite simple: add a new method which works like =20
memcpy_toio, but respects the fact that no single bytes may be written =20
(reading through memcpy_fromio works painlessly).  I think this =20
function should go into arch/powerpc/kernel/io.c, depending upon =20
CONFIG_PPC_MPC52xx, and the prototype into =20
arch/powerpc/include/asm/io.h, right?

The harder part is to actually call this function properly.  I now call =20
it in include/linux/mtd/map.h, function inline_map_copy_to(), if =20
CONFIG_PPC_MPC52xx is defined and if map->bankwidth is 2.  However, is =20
it acceptable to have a processor-type dependency in a top-level =20
include file?  Or what would be the proper way to implement it?

Thanks, Albrecht.

--=-/U3OJm+uYOaVSqUGEEmE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKHZqRn/9unNAn/9ERAqu6AKDEmMSBFggGjYYsN8N6DLWv6u1KXgCfcMj3
K8bx0/OcsA2J6sAHIx52k04=
=SNLF
-----END PGP SIGNATURE-----

--=-/U3OJm+uYOaVSqUGEEmE--
