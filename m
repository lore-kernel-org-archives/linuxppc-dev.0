Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (cdma-44-175.msk.skylink.ru
	[83.217.44.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA77567CD1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:21:07 +1100 (EST)
Date: Tue, 12 Dec 2006 01:11:25 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] update MTD OF implementation
Message-ID: <20061212011125.323d4003@localhost.localdomain>
In-Reply-To: <457DD485.9010501@ru.mvista.com>
References: <20061206153627.43fdc59c.vitalywool@gmail.com>
	<457DD485.9010501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_W=1=MtfwX=B8M4Yoj1QtaPE";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org, dwmw2@redhat.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_W=1=MtfwX=B8M4Yoj1QtaPE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2006 00:58:29 +0300
Sergei Shtylyov wrote:

> Hello.
>=20
> Vitaly Wool wrote:
>=20
> > the patch below updates the powerpc part of the MTD OF
> > implementation with the new field probe-type and also fixes the
> > typos/build warning for rom.c. So therefore it in a way supersedes
> > the patch from Geoff which can be seen at
> > http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028831.html.
> >=20
> >  Documentation/powerpc/booting-without-of.txt |   19
> > +++++++++++-------- arch/powerpc/sysdev/rom.c
> > |    1 + 2 files changed, 12 insertions(+), 8 deletions(-)
> >=20
> > Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
>=20
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>


>=20
> > diff --git a/Documentation/powerpc/booting-without-of.txt
> > b/Documentation/powerpc/booting-without-of.txt index
> > b3bd366..3399427 100644 ---
> > a/Documentation/powerpc/booting-without-of.txt +++
> > b/Documentation/powerpc/booting-without-of.txt @@ -1703,29 +1703,32
> > @@ platforms are moved over to use the flat Required properties:
> > =20
> >       - device_type : has to be "rom"
> > -     - compatible : Should specify what this ROM device is
> > compatible with
> > -       (i.e. "onenand"). Currently, this is most likely to be
> > "direct-mapped"
> > -       (which corresponds to the MTD physmap mapping driver).
> > -     - regs : Offset and length of the register set (or memory
> > mapping) for
> > +     - compatible : Should specify what this flash device is
> > compatible with.
> > +       Currently, this is most likely to be "direct-mapped" (which
> > +       corresponds to the MTD physmap mapping driver).
> > +     - reg : Offset and length of the register set (or memory
> > mapping) for the device.
> > +     - bank-width : Width of the flash data bus in bytes. Required
> > +       for the NOR flashes (compatible =3D=3D "direct-mapped" and
> > others) ONLY.=20
> >      Recommended properties :
> > =20
> > -     - bank-width : Width of the flash data bus in bytes. Required
> > -       for the NOR flashes (compatible =3D=3D "direct-mapped" and
> > others) ONLY.
> >       - partitions : Several pairs of 32-bit values where the first
> > value is partition's offset from the start of the device and the
> > second one is partition size in bytes with LSB used to signify a
> > read only
> > -       partititon (so, the parition size should always be an even
> > number).
> > +       partition (so, the parition size should always be an even
> > number).
> >       - partition-names : The list of concatenated zero terminated
> > strings representing the partition names.
> > +     - probe-type : The type of probe which should be done for the
> > chip
> > +       (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
> > =20
> >     Example:
> > =20
> >   	flash@ff000000 {
> >   		device_type =3D "rom";
> >   		compatible =3D "direct-mapped";
> > - 		regs =3D <ff000000 01000000>;
> > + 		probe-type =3D "CFI";
> > + 		reg =3D <ff000000 01000000>;
> >   		bank-width =3D <4>;
> >   		partitions =3D <00000000 00f80000
> >   			      00f80000 00080001>;
> > diff --git a/arch/powerpc/sysdev/Makefile
> > b/arch/powerpc/sysdev/Makefile diff --git
> > a/arch/powerpc/sysdev/rom.c b/arch/powerpc/sysdev/rom.c index
> > bf5b3f1..c855a3b 100644 --- a/arch/powerpc/sysdev/rom.c
> > +++ b/arch/powerpc/sysdev/rom.c
> > @@ -9,6 +9,7 @@
> > =20
> >  #include <linux/kernel.h>
> >  #include <asm/of_device.h>
> > +#include <asm/of_platform.h>
> > =20
> >  static int __init powerpc_flash_init(void)
> >  {
>=20
> WBR, Sergei
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


--=20
Sincerely, Vitaly


--Sig_W=1=MtfwX=B8M4Yoj1QtaPE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQFFfdeO+5fX0XX0D7ERAlsDAKCNtpXV6JfV/1/aZZwiBZMRSX95ggCY3/rD
B6k6ZUJZRlimWEfk4KLF5w==
=n7pE
-----END PGP SIGNATURE-----

--Sig_W=1=MtfwX=B8M4Yoj1QtaPE--
