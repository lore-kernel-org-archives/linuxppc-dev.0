Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405Tbh07KCzF1XB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 10:26:56 +1100 (AEDT)
Date: Wed, 21 Mar 2018 10:26:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Arnd
 Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Matt Brown
 <matthew.brown.dev@gmail.com>
Subject: linux-next: manual merge of the powerpc tree with the asm-generic tree
Message-ID: <20180321102618.4b46f1b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TFT4Q.A+2o0jDHqMgMsW+KA"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/TFT4Q.A+2o0jDHqMgMsW+KA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  lib/raid6/test/Makefile

between commit:

  fa523d54a7eb ("raid: remove tile specific raid6 implementation")

from the asm-generic tree and commit:

  751ba79cc552 ("lib/raid6/altivec: Add vpermxor implementation for raid6 Q=
 syndrome")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/raid6/test/Makefile
index fabc477b1417,5050e270c06b..000000000000
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@@ -45,12 -45,17 +45,14 @@@ else ifeq ($(HAS_NEON),yes
          CFLAGS +=3D -DCONFIG_KERNEL_MODE_NEON=3D1
  else
          HAS_ALTIVEC :=3D $(shell printf '\#include <altivec.h>\nvector in=
t a;\n' |\
-                          gcc -c -x c - >&/dev/null && \
-                          rm ./-.o && echo yes)
+                          gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
          ifeq ($(HAS_ALTIVEC),yes)
-                 OBJS +=3D altivec1.o altivec2.o altivec4.o altivec8.o
+                 CFLAGS +=3D -I../../../arch/powerpc/include
+                 CFLAGS +=3D -DCONFIG_ALTIVEC
+                 OBJS +=3D altivec1.o altivec2.o altivec4.o altivec8.o \
+                         vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
          endif
  endif
 -ifeq ($(ARCH),tilegx)
 -OBJS +=3D tilegx8.o
 -endif
 =20
  .c.o:
  	$(CC) $(CFLAGS) -c -o $@ $<
@@@ -117,7 -137,8 +131,7 @@@ tables.c: mktable
  	./mktables > tables.c
 =20
  clean:
- 	rm -f *.o *.a mktables mktables.c *.uc int*.c altivec*.c neon*.c tables.=
c raid6test
+ 	rm -f *.o *.a mktables mktables.c *.uc int*.c altivec*.c vpermxor*.c neo=
n*.c tables.c raid6test
 -	rm -f tilegx*.c
 =20
  spotless: clean
  	rm -f *~

--Sig_/TFT4Q.A+2o0jDHqMgMsW+KA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqxmJoACgkQAVBC80lX
0GychAf8DhcRUr84maMuU87eiGD0vPno6tdlBjG5Ssr9udvsirhDssuRzktRxRXN
AFz8v3wQlm8HRVprTHrXNfsxAhApAtN6TejsslV0UeNDtIsG7dFrPX/OGo9UvNh3
BnIc1s1dYyjh/jJlA+aZC5bCjlk7JVtEIEwqnxYjUBL7dgnraYVMUkKseiD/BmhZ
N2bSnFSJIb3OJUqqQnC+/QEM0WMb0OWWGmDY23+GF4Y2Psnkz3oLJzmvNJkMQ574
oAyCc5L7vwGzCMW2hpW0QVZW2IwvDkXri13fu4frVsJPCYRW1jDwdF5Nl3uIQbxY
2HGBG6pO07KD0LCknZfj7TZGPekhpQ==
=gxRa
-----END PGP SIGNATURE-----

--Sig_/TFT4Q.A+2o0jDHqMgMsW+KA--
