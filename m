Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 5E0BBB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 16:31:06 +1100 (EST)
Date: Fri, 17 Feb 2012 16:30:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: build failure after merge of the final tree (akpm tree
 related)
Message-Id: <20120217163057.8af53b853b36365b7fff203c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__17_Feb_2012_16_30_57_+1100_dcNCxK3e+SxyxTon"
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__17_Feb_2012_16_30_57_+1100_dcNCxK3e+SxyxTon
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the final tree, today's linux-next build (powerpc
allnoconfig) failed like this:

In file included from include/linux/posix_types.h:47:0,
                 from include/linux/types.h:17,
                 from include/linux/page-flags.h:8,
                 from kernel/bounds.c:9:
arch/powerpc/include/asm/posix_types.h:15:14: error: conflicting types for =
'__kernel_size_t'
arch/powerpc/include/asm/posix_types.h:14:22: note: previous declaration of=
 '__kernel_size_t' was here
In file included from include/linux/page-flags.h:8:0,
                 from kernel/bounds.c:9:
include/linux/types.h:68:1: error: unknown type name '__kernel_ssize_t'

Caused by commit a9dbe86e5995 ("powerpc: use generic posix_types.h").

This think was pointed out a couple of days ago, so maybe Andrew needs a
newer version of the patch.

I added this fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Feb 2012 16:25:48 +1100
Subject: [PATCH] powerpc: use generic posix_types.h fix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/posix_types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/posix_types.h b/arch/powerpc/include/=
asm/posix_types.h
index 1fbe027f..f139325 100644
--- a/arch/powerpc/include/asm/posix_types.h
+++ b/arch/powerpc/include/asm/posix_types.h
@@ -12,7 +12,7 @@ typedef unsigned long	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 #else
 typedef unsigned int	__kernel_size_t;
-typedef int		__kernel_size_t;
+typedef int		__kernel_ssize_t;
 typedef long		__kernel_ptrdiff_t;
 #define __kernel_size_t __kernel_size_t
=20
--=20
1.7.9

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__17_Feb_2012_16_30_57_+1100_dcNCxK3e+SxyxTon
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPPeYRAAoJEECxmPOUX5FEphcQAKWrh5laCcgFtW5AStztIa1s
hH1d0dEC0cQHs8vC49AC0eF1tM8QzNbCU18yd6uSJ93WI47gQnvX4ohT4BBP8l4F
oRfyp8fsjMQXodHfH2avb2l7UideeAfRpYxuismHm9HsQJ5YJTCHPOSYWBbsMCkV
pdiIE1E9tBQEnVChnsYYdXCkjmGuU7pLLep64DjuoaGUPiKauczjea/cRHEynkTe
bUC59DxUUtzwlOdf5qm6NL4plbAcefTZxIFvjoQUIHnfG5nC/apkqESbchqCNeRT
O8pFf5vLBc8pUGjWBi1IxRus2gu6iM5wySM9A4R/nppPBRNsLUSIfmjh06y/badI
Tt9NSzdv+hR6+8yBcgM1a2R6tN7hy/+jtUZcm8GWDf5JBnkXkA/3nsVsYH5qL6m1
WU8xUv7DsnYI3FByKBbZjnmD847BCwfp4uS8RePzoE8bqDuLA/rFjl2DAE/VXFsw
zv9l27IULJaDLxzf6vHOZAMfHnwL7XIus28tbcWWK02B4BuMM7kpEJDvTjJA9wE7
9oMm/VCyGgjwchurOmizCdBdHtpnE9CQItwWfEXWIzIRW3JN3pGxkYcK7nao5O4r
m7HCfdjsjIyYj0xxvuRpCGQGzukyywW/c8+0h1/HyRofiXzJRrpORc70iq1oZ6e8
alGQAEOQkwvuuTghVA3x
=Dz09
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Feb_2012_16_30_57_+1100_dcNCxK3e+SxyxTon--
