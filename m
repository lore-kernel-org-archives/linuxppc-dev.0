Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 5939DDDE43
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 19:58:51 +1100 (EST)
Date: Mon, 26 Nov 2007 00:59:28 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071126085928.GE14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<20071125194101.GD14557@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
In-Reply-To: <20071125194101.GD14557@curie-int.orbis-terrarum.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 11:41:01AM -0800, Robin H. Johnson wrote:
> I was looking around for a description of the ROM layout, and instead I
> found this: http://developer.apple.com/technotes/tn/tn2000.html
> It was relevant because it explicitly mentioned enabling the
> PCI_COMMAND_MEMORY bit in the PCI_COMMAND register, which is NOT present
> in any path of the sizing code.
=2E..
> By doing:
> # dev=3D"/sys/devices/pci0001:00/0001:00:03.0/0001:06:00.0/"
> # echo 1 >${dev}/enable
> # echo 1 >${dev}/rom
> # cat ${dev}/rom >rom
> The ROM is successfully returned for two of my 3 cards.
> Namely, both of the ones containing x86 BIOS (sata_sil24, ATI X700).
> The X1900 does still not return any ROM.
=2E..
> I broke my testing kernel temporarily, so I need a bit more testing to
> see why the X1900 did not return a ROM. More on that in a couple of
> hours.
(Part of this is from an IRC discussion with benh, summarized with
results here).

Thanks to some friends, I added some more PCIe cards to the test set:
The complete list is now:
x86-BIOS:
- Silicon Image, Inc. SiI 3132 Serial ATA Raid II (sata_sil24)
- ATI X700
OpenFirmware (all get relevant nodes in the device-tree after boot):
- ATI X1900
- Nvidia 6600
- Marvell SATA 7042 (sata_mv) [Sonnet Tempo SATA E4P]

For testing, I explicitly enable the device, and then try to read the
ROM. Additionally, I have some debug printk statements scattered about
rom.c and pci-sysfs.c, to detect various parts of the branching.
Additionaly per Jon's suggestion, I also have a bit of code at the end
of the sizing routine:
if (image =3D=3D rom) { printk(...); return size; }

On the G5, the results are as follows:
- sata_sil24, X700, sata_mv - ROMS readable and valid.
- Nvidia 6600 - Returns junk data, changes between boots.
  pci_get_rom_size fails the size decode, the first two readb() both
  return 0x33
- ATI X1900 - Returns nulls. pci_get_rom_size fails here, the readbs()
  return 0x00.

On an x86_64 (Core2 Duo), the results are as follows:
- sata_sil24 , X700 - ROMS readable and valid.
- sata_mv - appears in lspci, and works, but lspci does NOT show an 'Expans=
ion ROM' line.
- Nvidia 6600, ATI X1900 - do not show up the kernel at all, or in
  lspci. The PCIe Root port [8086:29a1] is entirely missing from the
  lspci output.

Regarding the sub-thread on x86 emulation, that is totally out of scope
for this. The 'AtomBIOS' of the ATI cards, consists of multiple parts (I
may have minor errors here, ask airlied if you need more
clarification):
a) Initialization code (I think arch-specific)
b) AtomBIOS script interpreter (I think arch-specific)
c) AtomBIOS scripts (card-specific, but not arch-specific)
d) Data tables (card-specific, but not arch-specific)

The AtomBIOS parts of the various drivers need data from c+d primarily,
and provide their own script interpreter, or not using the scripts, just
the data tables.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSorwPpIsIjIzwiwRAlnnAJ9pBKc26v1naLMkMhRXzCC44fwJsQCfdELc
WSsvsyZl5Kf9pKsCcuI8ges=
=ljcU
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
