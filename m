Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6112063f5eac0a820949415417d49a5376ad5ffd.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 04/11] Convert from DBG() to pr_debug() in
	platforms/pseries/setup.c
Date: Fri, 18 Apr 2008 17:54:36 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fccca89..5486bea 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -70,11 +70,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
@@ -310,7 +305,7 @@ static int pseries_set_xdabr(unsigned long dabr)
  */
 static void __init pSeries_init_early(void)
 {
-	DBG(" -> pSeries_init_early()\n");
+	pr_debug(" -> pSeries_init_early()\n");
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
@@ -322,7 +317,7 @@ static void __init pSeries_init_early(void)
 
 	iommu_init_early_pSeries();
 
-	DBG(" <- pSeries_init_early()\n");
+	pr_debug(" <- pSeries_init_early()\n");
 }
 
 /*
@@ -367,7 +362,7 @@ static int __init pSeries_probe(void)
 	    of_flat_dt_is_compatible(root, "IBM,CBEA"))
 		return 0;
 
-	DBG("pSeries detected, looking for LPAR capability...\n");
+	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
@@ -377,8 +372,8 @@ static int __init pSeries_probe(void)
 	else
 		hpte_init_native();
 
-	DBG("Machine is%s LPAR !\n",
-	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
+	pr_debug("Machine is%s LPAR !\n",
+	         (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
 	return 1;
 }
-- 
1.5.5
