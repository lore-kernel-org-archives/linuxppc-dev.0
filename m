Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CA7251007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 18:46:12 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 10/13] powerpc/5200: LocalPlus driver: fix problem caused
	by unpredictable IRQ order
Date: Tue, 12 Jan 2010 08:43:16 +0100
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220809.09578.roman.fietze@telemotive.de>
	<fa686aa41001111219r23e0adc4gd6daf70096771f91@mail.gmail.com>
In-Reply-To: <fa686aa41001111219r23e0adc4gd6daf70096771f91@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001120843.17335.roman.fietze@telemotive.de>
Content-Type: multipart/signed; boundary="nextPart11617549.mUbPle4KdG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart11617549.mUbPle4KdG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Monday 11 January 2010 21:19:14 Grant Likely wrote:

> I'm really not convinced.

At least you made me think about that some more. And of course, you
are right, the order must be fixed, one way using TX, the other way
using RX.

I think delayed BCOM IRQs in TX direction, caused by a high FEC or ATA
BCOM load, could cause starting the next job with a not yet cleand up
BD ring.

Please give me another change to come up with a hopefully much cleaner
design, esp. after some tests under low and high load with alternating
transfer directions. Probably we can stay with the original design,
and only take some extra effort when the transfer directions changes.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

Amtsgericht Ulm                                HRB 541321
Vorstand:
Peter Kersten, Markus Fischer, Franz Diller, Markus Stolz

--nextPart11617549.mUbPle4KdG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAktMKBUACgkQp5XY/BK//MKcowCcC4+auv3+PYdkFURoq03XRaeK
jc8AniuvFtomLQWmFa0QmuuHs/anGwOs
=UzDz
-----END PGP SIGNATURE-----

--nextPart11617549.mUbPle4KdG--
