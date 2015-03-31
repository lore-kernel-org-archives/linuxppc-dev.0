Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B2D91A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:56 +1100 (AEDT)
Received: by pddn5 with SMTP id n5so8496816pdd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:54 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 12/19] powerpc/pseries: Move controller ops from ppc_md to
 controller_ops
Date: Tue, 31 Mar 2015 16:00:50 +1100
Message-Id: <1427778057-9505-13-git-send-email-dja@axtens.net>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the pSeries platform to use the pci_controller_ops structure,
rather than ppc_md for PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/pseries/iommu.c   | 9 +++++----
 arch/powerpc/platforms/pseries/pseries.h | 2 ++
 arch/powerpc/platforms/pseries/setup.c   | 6 +++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7803a19..61d5a17 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -49,6 +49,7 @@
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
 
+#include "pseries.h"
 
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
 				      __be64 *startp, __be64 *endp)
@@ -1307,16 +1308,16 @@ void iommu_init_early_pSeries(void)
 			ppc_md.tce_free	 = tce_free_pSeriesLP;
 		}
 		ppc_md.tce_get   = tce_get_pSeriesLP;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
+		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
+		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
 		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
 		ppc_md.tce_free  = tce_free_pSeries;
 		ppc_md.tce_get   = tce_get_pseries;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeries;
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeries;
+		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
+		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
 	}
 
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1796c54..cd64672 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -65,6 +65,8 @@ extern int dlpar_detach_node(struct device_node *);
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
 
+extern struct pci_controller_ops pseries_pci_controller_ops;
+
 unsigned long pseries_memory_block_size(void);
 
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1a5f884..328e318 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -478,6 +478,7 @@ static void __init find_and_init_phbs(void)
 		rtas_setup_phb(phb);
 		pci_process_bridge_OF_ranges(phb, node, 0);
 		isa_bridge_find_early(phb);
+		phb->controller_ops = pseries_pci_controller_ops;
 	}
 
 	of_node_put(root);
@@ -840,6 +841,10 @@ static int pSeries_pci_probe_mode(struct pci_bus *bus)
 void pSeries_final_fixup(void) { }
 #endif
 
+struct pci_controller_ops pseries_pci_controller_ops = {
+	.probe_mode		= pSeries_pci_probe_mode,
+};
+
 define_machine(pseries) {
 	.name			= "pSeries",
 	.probe			= pSeries_probe,
@@ -848,7 +853,6 @@ define_machine(pseries) {
 	.show_cpuinfo		= pSeries_show_cpuinfo,
 	.log_error		= pSeries_log_error,
 	.pcibios_fixup		= pSeries_final_fixup,
-	.pci_probe_mode		= pSeries_pci_probe_mode,
 	.restart		= rtas_restart,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
-- 
2.1.4
