Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A525067A64
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 02:18:44 +1000 (EST)
Date: Sun, 2 Apr 2006 02:18:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: iSeries needs slb_initialize to be called
Message-Id: <20060402021840.4640dab7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__2_Apr_2006_02_18_40_+1000_VLONO+4XzFX=Ij2j"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__2_Apr_2006_02_18_40_+1000_VLONO+4XzFX=Ij2j
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since the "ppc64: support 64k pages" patch
(3c726f8dee6f55e96475574e9f645327e461884c) went in, systems that have SLBs
(like Power4 iSeries) needed to have slb_initialize called to set up some
variables for the SLB miss handler.  This was not being called on the boot
processor on iSeries, so on single cpu iSeries machines, we would get
apparent memory curruption as soon as we entered user mode.

This patch fixes that by calling slb_initialize on the boot cpu if the
processor has an SLB.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/setup_64.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

Please check I haven't missed anything, as I don't really understand the
SLB miss handler.

This has been booted on a 2 cpu Power4 iSeries partition with and without
maxcpus=3D1.  This needs to go into 2.6.17 and probably into 2.6.16.x

git bisect rocks! :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

b116f2eae79ee837fa5e5e55bf1d59329ecd7c93
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f96c49b..abd758f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -256,12 +256,10 @@ void __init early_setup(unsigned long dt
 	/*
 	 * Initialize stab / SLB management except on iSeries
 	 */
-	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (cpu_has_feature(CPU_FTR_SLB))
-			slb_initialize();
-		else
-			stab_initialize(lpaca->stab_real);
-	}
+	if (cpu_has_feature(CPU_FTR_SLB))
+		slb_initialize();
+	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		stab_initialize(lpaca->stab_real);
=20
 	DBG(" <- early_setup()\n");
 }
--=20
1.2.4


--Signature=_Sun__2_Apr_2006_02_18_40_+1000_VLONO+4XzFX=Ij2j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELqfgFdBgD/zoJvwRAiEpAJ9KyeoXjFYmw68jVjm7sSdARjcJHgCePa/G
rPDR73wFJsRsmL0NLPaL9JA=
=3xVE
-----END PGP SIGNATURE-----

--Signature=_Sun__2_Apr_2006_02_18_40_+1000_VLONO+4XzFX=Ij2j--
