Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 0F78CDDE1D
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 22:49:12 +1100 (EST)
Date: Sun, 25 Nov 2007 03:49:19 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071125114919.GC14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
In-Reply-To: <20071125111535.GB14557@curie-int.orbis-terrarum.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 03:15:35AM -0800, Robin H. Johnson wrote:
> I started in there from that, and ended up in pci-sysfs.c...
> The ROM memcpy in drivers/pci/pci-sysfs.c:pci_read_rom() is never running.
=2E..
> [  306.396743] drivers/pci/pci-sysfs.c:577:pci_read_rom: size=3D0x0 rom=
=3D0xd000080082580000 off=3D0x0
> [  306.396764] drivers/pci/pci-sysfs.c:579:pci_read_rom: off >=3D size!
=2E..
> So next, why is it failing to decode the ROM size correctly?
> pci_get_rom_size(), here I come.
Instead of the expected value of 0x55, 0xAA at the start of the ROM
size decode in pci_get_rom_size(), the first two readb() calls both
return either 0xFF or 0x00 so the size check fails right away.

The two cards with x86 firmware return 0xFF for those two readb()
instructions, while the X1900 with OF returns 0x00 for the readb().

Could one of the more knowledgeable folk for PPC intricacies suggest why
those readb calls are returning the wrong data?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSWE/PpIsIjIzwiwRAtAjAKC1ekgVzExuw+W4/FCbnv22ajlVTACfdUgl
2kFF/o+kmDgNVvLqpXG23YY=
=+UZg
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
