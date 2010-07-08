Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 7B1E7B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 04:47:29 +1000 (EST)
Date: Thu, 08 Jul 2010 20:40:13 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikP_ZrWddakihhslDHphEaDsW-IQY4C-lDoXEgm@mail.gmail.com>
	(from grant.likely@secretlab.ca on Thu Jul  8 17:22:03 2010)
Message-Id: <1278614421.1801.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-3rMaRKuDQ9uExQU+PJpA"
Cc: David Woodhouse <dwmw2@infradead.org>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-3rMaRKuDQ9uExQU+PJpA
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.07.10 17:22 schrieb(en) Grant Likely:
>> Just out of curiousity, what configuration might cause a byte-wise align=
ment not to work?
>=20
> Can't remember the register configuration, but I worked on one project wh=
ere this was the case.  In hindsight, it was probably a mis-configuration o=
f the localbus CS for the particular device.

Not sure if you're thinking of this configuration, but if you attach a devi=
ce in 16-bit mode (i.e. 16 data lines) to the LPB, byte writes simply don't=
 work.  I ran into that problem as I have a nvram attached this way to a 52=
00b.  Using the device as mtd-ram with a jffs2 file system on it I also som=
etimes saw corruption after a write.

I had a patch for that last year, but it was actually badly crafted (see <h=
ttp://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072903.html>).  I s=
till use the mpc52xx_memcpy2lpb16() function somewhere in my current code w=
hich is actually an ugly hack (but it works...).

Actually, this is something which might need closer attention - and maybe s=
ome support in the device tree indicating which read or write width a devic=
e can accept?

Best, Albrecht.

--=-3rMaRKuDQ9uExQU+PJpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBMNhuVn/9unNAn/9ERAi0RAKDENR7zwpsTxr9r1b0/ZxWGcGSDyACgn91T
rGZbuFw1ANNVz5VR0T7c/Sc=
=ISwg
-----END PGP SIGNATURE-----

--=-3rMaRKuDQ9uExQU+PJpA--
