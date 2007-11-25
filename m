Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 9B445DDE47
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 13:03:25 +1100 (EST)
Date: Sat, 24 Nov 2007 17:57:07 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Access to PCI Expansion ROMs on PPC
Message-ID: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Following up from initial conversation with benh in #ppc64, I did a bit
of testing (and then a bit more).

Two PCIe cards for my testing:
a) sata_sil24 eSATA (x86 BIOS)
b) ATI X700 graphics (x86 BIOS)

I put the card into an amd64 box, found the relevant 'rom' node ($ROM) under
/sys/device/pci*, and dumped it as follows:
# echo 1>$ROM
# cat $ROM >/tmp/dump
# echo 0>$ROM
On amd64, this produced the ROM for the cards fine (contained
recognizable strings).

I then repeated the same on my G5 (PM11,2), while the $ROM files have a
non-zero size in sysfs (that corresponds to the size shown by lspci
-vv), reading them always results in a 0-byte output.

Is the PPC kernel broken? Does something in the PPC architecture forbid
this? Instructions to muck with PCI code welcome.

This was under 2.6.24_rc3-git1, kernel .config available if needed.

Why am I trying to access the PCI ROM? To make my newer X1900 card work
under at least one of the newer (ati,radeonhd,avivo) drivers, that all
try to access the ATI AtomBIOS for varying data.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSNZzPpIsIjIzwiwRArFbAJ9UiYKp01bQgtTfGuIUGnCBJvRpgACg0Zx4
se0GnyPgN1tklzBlOpas2aY=
=cED7
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
