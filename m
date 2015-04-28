Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D29BE1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:12:31 +1000 (AEST)
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2537C140083
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:12:31 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so152040213pdb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 22:12:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/powernv: Specialise pci_controller_ops for each
 controller type
Date: Tue, 28 Apr 2015 15:12:05 +1000
Message-Id: <1430197927-24814-2-git-send-email-dja@axtens.net>
In-Reply-To: <1430197927-24814-1-git-send-email-dja@axtens.net>
References: <1430197927-24814-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove powernv generic PCI controller operations. Replace it with
controller ops for each of the two supported PHBs.

As an added bonus, make the two new structs const, which will help
guard against bugs such as the one introduced in 65ebf4b63
("powerpc/powernv: Move controller ops from ppc_md to controller_ops")

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   | 18 ++++++++++++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 12 +++++++++++-
 arch/powerpc/platforms/powernv/pci.c        | 13 +++----------
 arch/powerpc/platforms/powernv/pci.h        |  6 ++++++
 arch/powerpc/platforms/powernv/powernv.h    |  2 --
 5 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6ed76c6..c853b62 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -44,6 +44,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+static const struct pci_controller_ops pnv_pci_ioda_controller_ops;
+
 /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
 #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
 
@@ -2808,10 +2810,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
-	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
-	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
-	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
-	hose->controller_ops = pnv_pci_controller_ops;
+	hose->controller_ops = pnv_pci_ioda_controller_ops;
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
@@ -2868,3 +2867,14 @@ void __init pnv_pci_init_ioda_hub(struct device_node *np)
 			pnv_pci_init_ioda_phb(phbn, hub_id, PNV_PHB_IODA1);
 	}
 }
+
+static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
+       .dma_dev_setup = pnv_pci_dma_dev_setup,
+#ifdef CONFIG_PCI_MSI
+       .setup_msi_irqs = pnv_setup_msi_irqs,
+       .teardown_msi_irqs = pnv_teardown_msi_irqs,
+#endif
+       .enable_device_hook = pnv_pci_enable_device_hook,
+       .window_alignment = pnv_pci_window_alignment,
+       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
+};
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 4729ca7..a83951b 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -35,6 +35,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+static const struct pci_controller_ops pnv_pci_p5ioc2_controller_ops;
+
 /* For now, use a fixed amount of TCE memory for each p5ioc2
  * hub, 16M will do
  */
@@ -133,7 +135,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	phb->hose->first_busno = 0;
 	phb->hose->last_busno = 0xff;
 	phb->hose->private_data = phb;
-	phb->hose->controller_ops = pnv_pci_controller_ops;
+	phb->hose->controller_ops = pnv_pci_p5ioc2_controller_ops;
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_P5IOC2;
@@ -234,3 +236,11 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
 		}
 	}
 }
+
+static const struct pci_controller_ops pnv_pci_p5ioc2_controller_ops = {
+	.dma_dev_setup = pnv_pci_dma_dev_setup,
+#ifdef CONFIG_PCI_MSI
+       .setup_msi_irqs = pnv_setup_msi_irqs,
+       .teardown_msi_irqs = pnv_teardown_msi_irqs,
+#endif
+};
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 0f04940..d7e37d8 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -45,7 +45,7 @@
 //#define cfg_dbg(fmt...)	printk(fmt)
 
 #ifdef CONFIG_PCI_MSI
-static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -94,7 +94,7 @@ static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	return 0;
 }
 
-static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
+void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -662,7 +662,7 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
-static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
+void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -772,10 +772,3 @@ void __init pnv_pci_init(void)
 
 machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
 
-struct pci_controller_ops pnv_pci_controller_ops = {
-	.dma_dev_setup = pnv_pci_dma_dev_setup,
-#ifdef CONFIG_PCI_MSI
-	.setup_msi_irqs = pnv_setup_msi_irqs,
-	.teardown_msi_irqs = pnv_teardown_msi_irqs,
-#endif
-};
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 070ee88..b6d1290 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -218,4 +218,10 @@ extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
+extern void pnv_pci_dma_dev_setup(struct pci_dev *pdev);
+#ifdef CONFIG_PCI_MSI
+extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
+extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
+#endif
+
 #endif /* __POWERNV_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 826d2c9..604c48e 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -29,8 +29,6 @@ static inline u64 pnv_pci_dma_get_required_mask(struct pci_dev *pdev)
 }
 #endif
 
-extern struct pci_controller_ops pnv_pci_controller_ops;
-
 extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
-- 
2.1.4
