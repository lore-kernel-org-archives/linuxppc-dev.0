Return-Path: <wangbj@lzu.edu.cn>
Received: from lzu.edu.cn (mail.lzu.edu.cn [202.201.0.136])
	by ozlabs.org (Postfix) with SMTP id DFA08DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 15:19:51 +1000 (EST)
Message-ID: <376700739.05606@lzu.edu.cn>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.6.20.6 build failed for ppc board chestnut(ibm ppc
	750GX/FX)
Date: Mon, 16 Apr 2007 13:13:01 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13853269.86UVt1nuoB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200704161313.04359.wangbj@lzu.edu.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart13853269.86UVt1nuoB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

PROBLEM: linux kernel 2.6.20.6 build failed for ppc board chestnut(ibm ppc=
=20
750GX/FX)

STEPS I followed:
1) make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- chestnut_defconfig # toolchain =
from=20
eldk 4.1

2) make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- V=3D1

=2E..

make -f scripts/Makefile.build obj=3Darch/ppc/platforms
 =20
ppc_4xx-gcc -m32 -Wp,-MD,arch/ppc/platforms/.chestnut.o.d  -nostdinc -isyst=
em /opt/eldk/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -D__KERNEL__ -I=
include  -include=20
include/linux/autoconf.h -Iarch/ppc -Iarch/ppc/include -Wall -Wundef -Wstri=
ct-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -Iarch/pp=
c -msoft-float -pipe -ffixed-r2 -mmultiple  -mno-altivec -mstring -Wa,-malt=
ivec -fomit-frame-pointer  -Wdeclaration-after-statement -Wno-pointer-sign =
   -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DKBUILD_STR(chestnut)"  -D"KB=
UILD_MODNAME=3DKBUILD_STR(chestnut)" -c -o=20
arch/ppc/platforms/chestnut.o arch/ppc/platforms/chestnut.c
arch/ppc/platforms/chestnut.c: In function 'chestnut_setup_mtd':
arch/ppc/platforms/chestnut.c:435: error: 'physmap_map' undeclared (first u=
se=20
in this function)
arch/ppc/platforms/chestnut.c:435: error: (Each undeclared identifier is=20
reported only once
arch/ppc/platforms/chestnut.c:435: error: for each function it appears in.)
make[1]: *** [arch/ppc/platforms/chestnut.o] Error 1
make: *** [arch/ppc/platforms] Error 2


This PROBLEM should also affect these boards:
find -name '*.[chS]' -exec grep physmap_map {} \; -print
        physmap_map.size =3D CHESTNUT_32BIT_SIZE;
=2E/arch/ppc/platforms/chestnut.c
        physmap_map.size =3D size;
=2E/arch/ppc/platforms/ev64360.c
        physmap_map.size =3D size;
=2E/arch/ppc/platforms/katana.c

I've veryfied 2.6.15, 2.6.19.2 2.6.20.1 2.6.20.6

ONLY 2.6.15 can build successfully. sounds like the problem is caused by th=
e=20
interface change of mtd.


this brute force patch sould solve the problem:

diff -Nru /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c \ =20
linux-2.6.20.6/arch/ppc/platforms/chestnut.c

=2D-- /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c   2007-04-07=20
04:02:48.000000000 +0800
+++ linux-2.6.20.6/arch/ppc/platforms/chestnut.c        2007-04-13=20
17:09:03.000000000 +0800
@@ -432,7 +432,9 @@
        ptbl.name =3D "User FS";
        ptbl.size =3D CHESTNUT_32BIT_SIZE;

=2D       physmap_map.size =3D CHESTNUT_32BIT_SIZE;
+       // physmap_map.size =3D CHESTNUT_32BIT_SIZE;
+       physmap_configure(CHESTNUT_32BIT_BASE, CHESTNUT_32BIT_SIZE,=20
CONFIG_MTD_PHYSMAP_BANKWIDTH, NULL);
+
        physmap_set_partitions(&ptbl, 1);
        return 0;
 }

=2D-=20
Wang, Baojun                                        Lanzhou University
Distributed & Embedded System Lab              http://dslab.lzu.edu.cn
School of Information Science and Engeneering        wangbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000                     .P.R.China
Tel:+86-931-8912025                                Fax:+86-931-8912022

--nextPart13853269.86UVt1nuoB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGIwXgIuIOr7tpgg0RAkuGAKCteU6aea5bRgJsi5NQx7cDDNrtKQCePddU
ySeKP0O9tginWZW+fY5G9Xg=
=Xfst
-----END PGP SIGNATURE-----

--nextPart13853269.86UVt1nuoB--
