Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 9C599B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 11:01:15 +1100 (EST)
Date: Sat, 31 Mar 2012 11:01:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: [PATCH] powerpc: fix fallout from system.h split up
Message-Id: <20120331110107.e68ea07da4552a4b5547eea2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__31_Mar_2012_11_01_07_+1100_pVdI0Sc/OMTag78Z"
Cc: David Howells <dhowells@redhat.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__31_Mar_2012_11_01_07_+1100_pVdI0Sc/OMTag78Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/fadump.c |    2 ++
 arch/powerpc/kernel/kgdb.c   |    1 +
 2 files changed, 3 insertions(+)

Just a resend of what I sent yesterday - this is what I am using in
linux-next.  Linus, please apply.

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index cfe7a38..18bdf74 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -40,6 +40,8 @@
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/fadump.h>
+#include <asm/debug.h>
+#include <asm/setup.h>
=20
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 76a6e40..782bd0a 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -24,6 +24,7 @@
 #include <asm/current.h>
 #include <asm/processor.h>
 #include <asm/machdep.h>
+#include <asm/debug.h>
=20
 /*
  * This table contains the mapping between PowerPC hardware trap types, and
--=20
1.7.9.5

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__31_Mar_2012_11_01_07_+1100_pVdI0Sc/OMTag78Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPdklDAAoJEECxmPOUX5FEoD0QAJI9KNT2d+3OjmCqPtGKYj3n
Uwxo9slhTKQOnuT489dLMkIw1ddRWQx9dwGP6INkCSxUEvIcbo/qU5occG1RfxvC
6vi7JywjbaXyYR2euuQ31p81NfsvaWDFpIzTjEarfSNeVUD3eLPkooIK9aSnypUv
PUFjtISnjByh03x3BHDTHNeMFK9mdp9UzBiaS70iQ3aoM976ipwHuuZO34Ux6RGh
R6RilwBaFzd4vva89QaE8XZifyllkKECX2skj1GRoyvqAHazNGP9qe2Qk8CVX8Uf
tcS30cVmxbMx/raxG3lLvgEatJnDH735IgIltqoJLpvVd0QqeNWXhja25XM3joKi
3YZwmkFPW//2L/jK8V5V1V9HzyuibfNmtRapABKDg8TmX1ZfGPvCEuzePHaMM0G5
CsP/ZNDHYSlQ2gsm1NQy4CGhgiKYFlXYqf4TZ9ubKPM6Vd6mKyliSLSsPNg10jsR
+FLrG4sVVUmVa3zlXG+VP+cuFC1q8eUJngHBnryRK00OOUqVL9SwW8c1dOENYbaZ
bHXaOzz8D2gmKNy6Hio2yGhsLFYSM5pK9d7fBvJ+Qnxaw7CSlHl0v3OIDbflOz3T
k5R0nptyBkwzNtVHOwcDUShleoeY2csxPSjPgdzyhX5TC9FWqdBTKf3rK1xAlOvR
515ntR9aoaWqmnlX/Jy9
=BuF4
-----END PGP SIGNATURE-----

--Signature=_Sat__31_Mar_2012_11_01_07_+1100_pVdI0Sc/OMTag78Z--
