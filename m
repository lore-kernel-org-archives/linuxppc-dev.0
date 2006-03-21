Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:45:58 +1100
Subject: [PATCH 2/11] powerpc: Remove unused iommu_off logic from
	pSeries_init_early()
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094627.44FAC679F9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When iommu_init_early_pSeries() was added, ages ago, we forgot to remove
the code that checks /chosen/linux,iommu-off in pSeries_init_early(). We
do it now in iommu_init_early_pSeries().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -320,19 +320,14 @@ static int pseries_set_xdabr(unsigned lo
  */
 static void __init pSeries_init_early(void)
 {
-	int iommu_off = 0;
-
 	DBG(" -> pSeries_init_early()\n");
 
 	fw_feature_init();
 	
 	if (platform_is_lpar())
 		hpte_init_lpar();
-	else {
+	else
 		hpte_init_native();
-		iommu_off = (of_chosen &&
-			     get_property(of_chosen, "linux,iommu-off", NULL));
-	}
 
 	if (platform_is_lpar())
 		find_udbg_vterm();
