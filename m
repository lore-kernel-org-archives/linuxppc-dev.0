Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A97F61A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:44:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/pseries: Remove use of CONFIG_PCI
Date: Thu,  1 Oct 2015 16:44:32 +1000
Message-Id: <1443681874-28145-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
References: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we always have CONFIG_PCI=y for pseries, we can stop guarding
code with CONFIG_PCI ifdefs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c | 10 ----------
 arch/powerpc/platforms/pseries/setup.c |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0946b98d75d4..bd98ce2be17b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -532,7 +532,6 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
 	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
 }
 
-#ifdef CONFIG_PCI
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
 				 struct iommu_table *tbl)
@@ -1292,15 +1291,6 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 	return dma_iommu_ops.get_required_mask(dev);
 }
 
-#else  /* CONFIG_PCI */
-#define pci_dma_bus_setup_pSeries	NULL
-#define pci_dma_dev_setup_pSeries	NULL
-#define pci_dma_bus_setup_pSeriesLP	NULL
-#define pci_dma_dev_setup_pSeriesLP	NULL
-#define dma_set_mask_pSeriesLP		NULL
-#define dma_get_required_mask_pSeriesLP	NULL
-#endif /* !CONFIG_PCI */
-
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		void *data)
 {
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9a83eb71b030..9e524c26db14 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -837,10 +837,6 @@ static int pSeries_pci_probe_mode(struct pci_bus *bus)
 	return PCI_PROBE_NORMAL;
 }
 
-#ifndef CONFIG_PCI
-void pSeries_final_fixup(void) { }
-#endif
-
 struct pci_controller_ops pseries_pci_controller_ops = {
 	.probe_mode		= pSeries_pci_probe_mode,
 };
-- 
2.1.4
