Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D9CF1DDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:10 +1100 (EST)
Message-Id: <20071218175104.219782000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:56 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 04/18] Set archdata.dma_data for direct DMA in
	cell_dma_dev_setup()
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Store a pointer to the direct_dma_offset in each device's dma_data
in the case where we're using the direct DMA ops.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/iommu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
@@ -496,9 +496,10 @@ static void cell_dma_dev_setup(struct de
 	struct cbe_iommu *iommu;
 	struct dev_archdata *archdata = &dev->archdata;
 
-	/* If we run without iommu, no need to do anything */
-	if (get_pci_dma_ops() == &dma_direct_ops)
+	if (get_pci_dma_ops() == &dma_direct_ops) {
+		archdata->dma_data = &dma_direct_offset;
 		return;
+	}
 
 	/* Current implementation uses the first window available in that
 	 * node's iommu. We -might- do something smarter later though it may

-- 
