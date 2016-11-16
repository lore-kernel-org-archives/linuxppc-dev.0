Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJtWk6tJNzDvmt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 05:46:26 +1100 (AEDT)
Date: Wed, 16 Nov 2016 18:27:56 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Cc: stable <stable@vger.kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20161116182756.GE2697@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Subject: [PATCH] powerpc/boot: Fix build failure in 32-bit boot wrapper
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

OPAL is not callable from 32-bit mode and the assembly code for it
may not even build (depending on how binutils was configured).

References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dp=
owerpcspe&ver=3D4.8.7-1&stamp=3D1479203712
Fixes: 656ad58ef19e ("powerpc/boot: Add OPAL console to epapr wrappers")
Cc: stable <stable@vger.kernel.org> # 4.8
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I build-tested this (only) with minimal configurations for:

- 32-bit big-endian, CONFIG_PPC_85xx
- 64-bit big-endian, CONFIG_PPC_BOOK3S_64
- 64-bit little-endian, CONFIG_PPC_BOOK3S_64

Ben.

 arch/powerpc/boot/Makefile | 3 ++-
 arch/powerpc/boot/opal.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8bc218..9d47f2efa830 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -100,7 +100,8 @@ src-wlib-y :=3D string.S crt0.S crtsavres.S stdio.c dec=
ompress.c main.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
-		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
+		uartlite.c mpc52xx-psc.c opal.c
+src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) +=3D  opal-calls.S
 src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) +=3D 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_8xx) +=3D mpc8xx.c planetcore.c fsl-soc.c
diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 1f37e1c1d6d8..c2659978ef0c 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -13,7 +13,7 @@
 #include <libfdt.h>
 #include "../include/asm/opal-api.h"
=20
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
=20
 /* Global OPAL struct used by opal-call.S */
 struct opal {

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWCylLOe/yOyVhhEJAQpfIA//XQD41QpGyW/0x5c1c42PkT7u4w5cHcqR
3PGx/by/EkeDFJRdxJeuBDkQ71OsnJtrhS80Jn7ENDX02iZhNdM11R0z/30R0gDe
2lvJ36GFccC9qnrqvuX/V+cUUN1d/X20+zwTJbWuA1LoVYbhLlyhosYrqSCYBENk
oJe2S30bawY+4ssRbU2+n4kIdwKpH0WZgjLp2tS/HlMoqFyyOPyvhAG5xUF4dH/U
lO0WyVjHHitt8fk9EUQsi8pkKsGW1mROiBw4/BLYSI1X9OX0hhVX9/+Ez9y7sq0r
KKpN9EFa0yRiuvzBR9HOPTo5uryyNpSso12UAkVn2vsi8Quy9jJ+vydiyYeeCQL3
a5/zMrolXs4gOMpDpGGA+TQNT+Oj8qYzcd8nqj4s+dzOqFXwLwz2+hOqcV3CmhVg
mnKi+lBYq3Xde+eR8kRkyTLgN0m2DuXqhq9hQtHkizwLu1Maogsdwte81tovjGuc
subaOBmRw1JYCIeBCHA8NryuAA86LDrIb+CP6HeBnMMLzUjucXTcYuBFzoAjEd4J
HOrMIde9KDZ31SavQqmRhXAGbsC/n3CH1Ojq8ByW3pHq7dLkVxAobcVi9ZdJne+4
Mq4iu83x2U2SCLFdWqLzJqBJJHD2OUbha0ltlf7uHLMNY2KWc5YMj6//2BhfRw7E
9Ou2q1GniFw=
=EUGh
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
