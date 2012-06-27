Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/pseries: fix software invalidate TCE
Date: Wed, 27 Jun 2012 17:26:37 +1000
Message-ID: <17260.1340781997@neuling.org>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following added support for powernv but broke pseries/BML:
 1f1616e powerpc/powernv: Add TCE SW invalidation support

TCE_PCI_SW_INVAL was split into FREE and CREATE flags but the tests in
the pseries code were not updated to reflect this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org (v3.3-v3.4)
---

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0915b1a..2d311c0 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -106,7 +106,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 		tcep++;
 	}
 
-	if (tbl->it_type == TCE_PCI_SWINV_CREATE)
+	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
 		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 	return 0;
 }
@@ -121,7 +121,7 @@ static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 	while (npages--)
 		*(tcep++) = 0;
 
-	if (tbl->it_type == TCE_PCI_SWINV_FREE)
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
 		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 }
 
