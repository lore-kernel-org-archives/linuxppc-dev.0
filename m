Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0fa00a5773c47fb34aefa308efb94206ec5601a1.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 08/11] Convert from DBG() to pr_debug() in
	platforms/pseries/lpar.c
Date: Fri, 18 Apr 2008 17:54:41 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While we're there, fix some printf specifier mismatches, and add a
newline to one printk.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c |   34 ++++++++++++++------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 450c237..0ce8c85 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -19,7 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#undef DEBUG_LOW
+/* Enables debugging of low-level hash table routines - careful! */
+#undef DEBUG
 
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
@@ -42,11 +43,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG_LOW
-#define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
-#else
-#define DBG_LOW(fmt...) do { } while(0)
-#endif
 
 /* in hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
@@ -291,15 +287,15 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	unsigned long hpte_v, hpte_r;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			"rflags=%lx, vflags=%lx, psize=%d)\n",
-		hpte_group, va, pa, rflags, vflags, psize);
+		pr_debug("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
+			 "rflags=%lx, vflags=%lx, psize=%d)\n",
+			 hpte_group, va, pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
+		pr_debug(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
 
 	/* Now fill in the actual HPTE */
 	/* Set CEC cookie to 0         */
@@ -316,7 +312,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" full\n");
+			pr_debug(" full\n");
 		return -1;
 	}
 
@@ -327,11 +323,11 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			DBG_LOW(" lpar err %d\n", lpar_rc);
+			pr_debug(" lpar err %lu\n", lpar_rc);
 		return -2;
 	}
 	if (!(vflags & HPTE_V_BOLTED))
-		DBG_LOW(" -> slot: %d\n", slot & 7);
+		pr_debug(" -> slot: %lu\n", slot & 7);
 
 	/* Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
@@ -423,17 +419,17 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 
-	DBG_LOW("    update: avpnv=%016lx, hash=%016lx, f=%x, psize: %d ... ",
-		want_v, slot, flags, psize);
+	pr_debug("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
+		 want_v, slot, flags, psize);
 
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
-		DBG_LOW("not found !\n");
+		pr_debug("not found !\n");
 		return -1;
 	}
 
-	DBG_LOW("ok\n");
+	pr_debug("ok\n");
 
 	BUG_ON(lpar_rc != H_SUCCESS);
 
@@ -508,8 +504,8 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d",
-		slot, va, psize, local);
+	pr_debug("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
+		 slot, va, psize, local);
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
-- 
1.5.5
