Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 84330DDEDC
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 06:40:50 +1100 (EST)
Date: Sun, 25 Nov 2007 11:41:01 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071125194101.GD14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
In-Reply-To: <9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 08:30:58AM -0500, Jon Smirl wrote:
> I don't know PPC at this low of level but it may be a problem with non
> word-aligned access to memory. I thought readb() was supposed to work
> on all archs and alignment issues are handled inside readb(). Also,
> the readw() may have an endian bug.
I was looking around for a description of the ROM layout, and instead I
found this: http://developer.apple.com/technotes/tn/tn2000.html
It was relevant because it explicitly mentioned enabling the
PCI_COMMAND_MEMORY bit in the PCI_COMMAND register, which is NOT present
in any path of the sizing code.

By doing:
# dev=3D"/sys/devices/pci0001:00/0001:00:03.0/0001:06:00.0/"
# echo 1 >${dev}/enable
# echo 1 >${dev}/rom
# cat ${dev}/rom >rom
The ROM is successfully returned for two of my 3 cards.
Namely, both of the ones containing x86 BIOS (sata_sil24, ATI X700).
The X1900 does still not return any ROM.

So the pci-sysfs.c/rom.c code path needs to change to enable the device
somewhere if it was not enabled before (and presumably disable
afterwards for suspend/resume?).

I broke my testing kernel temporarily, so I need a bit more testing to
see why the X1900 did not return a ROM. More on that in a couple of
hours.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSc/NPpIsIjIzwiwRAiNmAJ9lVNFfcFlaIBCn9ZOJjeoRoUM+GgCgxpMK
zpRSrViXrx/QvtM69QHLSAM=
=QGZI
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
