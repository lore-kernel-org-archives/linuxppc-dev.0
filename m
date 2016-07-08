Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YM1CtlzDrFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:43 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YL2g1Qz9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:41 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/14] powerpc/pseries/pci: Remove obsolete SW invalidate
Date: Fri,  8 Jul 2016 16:37:10 +1000
Message-Id: <1467959838-6900-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That was used by some old IBM internal bringup tools and is
no longer relevant.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 53 +---------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e8865b..770a753 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -120,35 +120,6 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 	kfree(table_group);
 }
 
-static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
-				      __be64 *startp, __be64 *endp)
-{
-	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
-	unsigned long start, end, inc;
-
-	start = __pa(startp);
-	end = __pa(endp);
-	inc = L1_CACHE_BYTES; /* invalidate a cacheline of TCEs at a time */
-
-	/* If this is non-zero, change the format.  We shift the
-	 * address and or in the magic from the device tree. */
-	if (tbl->it_busno) {
-		start <<= 12;
-		end <<= 12;
-		inc <<= 12;
-		start |= tbl->it_busno;
-		end |= tbl->it_busno;
-	}
-
-	end |= inc - 1; /* round up end to be different than start */
-
-	mb(); /* Make sure TCEs in memory are written */
-	while (start <= end) {
-		out_be64(invalidate, start);
-		start += inc;
-	}
-}
-
 static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction,
@@ -173,9 +144,6 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 		uaddr += TCE_PAGE_SIZE;
 		tcep++;
 	}
-
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 	return 0;
 }
 
@@ -188,9 +156,6 @@ static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 
 	while (npages--)
 		*(tcep++) = 0;
-
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 }
 
 static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
@@ -537,7 +502,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 				 struct iommu_table *tbl)
 {
 	struct device_node *node;
-	const unsigned long *basep, *sw_inval;
+	const unsigned long *basep;
 	const u32 *sizep;
 
 	node = phb->dn;
@@ -575,22 +540,6 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
 	tbl->it_type = TCE_PCI;
-
-	sw_inval = of_get_property(node, "linux,tce-sw-invalidate-info", NULL);
-	if (sw_inval) {
-		/*
-		 * This property contains information on how to
-		 * invalidate the TCE entry.  The first property is
-		 * the base MMIO address used to invalidate entries.
-		 * The second property tells us the format of the TCE
-		 * invalidate (whether it needs to be shifted) and
-		 * some magic routing info to add to our invalidate
-		 * command.
-		 */
-		tbl->it_index = (unsigned long) ioremap(sw_inval[0], 8);
-		tbl->it_busno = sw_inval[1]; /* overload this with magic */
-		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
-	}
 }
 
 /*
-- 
2.7.4
