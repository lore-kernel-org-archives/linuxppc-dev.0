Return-Path: <wolfi@mittelerde.physik.uni-konstanz.de>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43DC467B34
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Apr 2005 19:42:20 +1000 (EST)
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 9C2652BC46
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Apr 2005 11:19:40 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08855-04 for <linuxppc-dev@ozlabs.org>;
	Sun, 17 Apr 2005 11:19:36 +0200 (CEST)
Received: from halley.zuhause (B0cf5.b.pppool.de [213.7.12.245])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 6A5352BC41
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Apr 2005 11:19:35 +0200 (CEST)
Date: Sun, 17 Apr 2005 11:18:52 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050417091851.GE4981@halley.zuhause>
References: <1113184854.9567.522.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
In-Reply-To: <1113184854.9567.522.camel@gaston>
Subject: Status report for 2.6.12-rc2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I use debian on my Powerbook6,2 and recently upgraded from kernel 2.6.10
with the patch Guido G=FCnther provides at [1] to 2.6.12-rc2 with ben's
tumbler/snapper patches applied.
So far I've seen the following issues:
1. I tried the new nvidiafb - just because I'm curious and the help says=20
   "This driver supports graphics boards with the nVidia chips, TNT and
   newer. For very old chipsets, such as the RIVA128, then use the
   rivafb."
   The kernel crashed during boot when it tried to switch to nvidiafb. I
   could see the messages that appeared before this stage until I
   switched the computer off. Booting with video=3Dofonly went well and
   using the traditional rivafb works fine.
   This situation reminds me to crashes I had sometime ago when I was
   testing Guido's patches for rivafb when he tried to get proper
   support for NV30 into rivafb.
2. Sometimes the machine crashes on suspend to disk. It only happens when I=
 work
   in X and it seems to freeze in the process of switching to a virtual
   terminal. The screen shows a distorted image of the previous screen
   (as if I had 8Bit colour depth with oversized pixels).
   I never had such freezes with 2.6.10 and this is the issue which
   annoys me most ATM. I don't have a way to clearly reproduce the
   freeze. It happend in two out of perhaps 20 suspends. It only seems
   to happen on the first suspend after boot.
   The suspend itself is much much faster than with 2.6.10 however.
3. I configured sound to use snd-powermac. Before I used
   dmasound-{pmac,core} and it works mostly. After a
   suspend-resume-cycle I have to kill xfce4-panel, which accesses
   /dev/mixer0, rmmod snd-powermac, wait a second and reinsert the
   module.=20
4. Something that is quite annoying but harmless is that after wakeup
   the machine sometimes suspends again immediately. I had something
   like this before. On resume the PMU seems to be some kind of
   irritated and gives wrong information about remaining runtime.
   If this remaining time is 0 pbbuttonsd suspends the machine again.

Thanks,

Wolfi

  1. http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/2.6.11.6-agx0=
=2Ediff

--=20

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYin7H0o2mefAfsQRAjC/AKCS+oRsAcWLZBxJyX5VE/6Mhe+VNwCeOBJ5
n7uLevIOGZC/XGiqNesngpc=
=MVvD
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
