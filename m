Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 9077DDDED1
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 22:15:38 +1100 (EST)
Date: Sun, 25 Nov 2007 03:15:35 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071125111535.GB14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
In-Reply-To: <9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2007 at 09:13:40PM -0500, Jon Smirl wrote:
> The ROM is mapped in drivers/pci/rom.c
>=20
> You could add some printks and see if there is an error and if the ROM
> is accessible
>=20
>         rom =3D ioremap(start, *size);
>         if (!rom) {
>                 /* restore enable if ioremap fails */
>                 if (!(res->flags & (IORESOURCE_ROM_ENABLE |
>                                     IORESOURCE_ROM_SHADOW |
>                                     IORESOURCE_ROM_COPY)))
>                         pci_disable_rom(pdev);
>                 return NULL;
>         }
I started in there from that, and ended up in pci-sysfs.c...
The ROM memcpy in drivers/pci/pci-sysfs.c:pci_read_rom() is never running.

Relevant section of my debug output:
[  306.396743] drivers/pci/pci-sysfs.c:577:pci_read_rom: size=3D0x0 rom=3D0=
xd000080082580000 off=3D0x0
[  306.396764] drivers/pci/pci-sysfs.c:579:pci_read_rom: off >=3D size!
[  306.396768] drivers/pci/pci-sysfs.c:588pci_read_rom: unmapping

Relevant snippet of my debug patching:
-       if (off >=3D size)
+       printk(KERN_INFO "%s:%d:%s: size=3D0x%lx rom=3D0x%lx off=3D0x%lx\n"=
, __FILE__,__LINE__,__FUNCTION__,size,rom,off);
+       if (off >=3D size) {
+               printk(KERN_INFO "%s:%d:%s: off >=3D size!\n", __FILE__,__L=
INE__,__FUNCTION__);
                count =3D 0;
-       else {
+       } else {

So next, why is it failing to decode the ROM size correctly?
pci_get_rom_size(), here I come.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSVlXPpIsIjIzwiwRAqr4AKCUGUuw3Bg/PWG7NcbQHKpIAswhjwCeK2rS
b0jm42Y5cPv9gVr0fvr1LxI=
=RZdo
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
