Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0734B7223
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:50 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/7] powerpc/pseries: Use pr_devel() in pseries LPAR HPTE
	routines
Date: Thu, 18 Jun 2009 14:13:50 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

In particular, pSeries_lpar_hpte_insert() goes from 185 instructions
to 77 instructions as a result of this patch. Luckily that code
isn't called very often ...

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   7284    1552     296    9132    23ac platforms/pseries/lpar.o

size after:
   text    data     bss     dec     hex filename
   5806    1096     296    7198    1c1e platforms/pseries/lpar.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index e3139fa..903eb9e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -286,7 +286,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	unsigned long hpte_v, hpte_r;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		pr_debug("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+		pr_devel("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
 			 "rflags=%lx, vflags=%lx, psize=%d)\n",
 			 hpte_group, va, pa, rflags, vflags, psize);
 
@@ -294,7 +294,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		pr_debug(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+		pr_devel(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	/* Now fill in the actual HPTE */
 	/* Set CEC cookie to 0         */
@@ -311,7 +311,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			pr_debug(" full\n");
+			pr_devel(" full\n");
 		return -1;
 	}
 
@@ -322,11 +322,11 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			pr_debug(" lpar err %lu\n", lpar_rc);
+			pr_devel(" lpar err %lu\n", lpar_rc);
 		return -2;
 	}
 	if (!(vflags & HPTE_V_BOLTED))
-		pr_debug(" -> slot: %lu\n", slot & 7);
+		pr_devel(" -> slot: %lu\n", slot & 7);
 
 	/* Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
@@ -418,17 +418,17 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 
-	pr_debug("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
+	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
-		pr_debug("not found !\n");
+		pr_devel("not found !\n");
 		return -1;
 	}
 
-	pr_debug("ok\n");
+	pr_devel("ok\n");
 
 	BUG_ON(lpar_rc != H_SUCCESS);
 
@@ -503,7 +503,7 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	pr_debug("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+	pr_devel("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
 		 slot, va, psize, local);
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
-- 
1.6.2.1
