Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcZvX5DxnzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 23:58:32 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UDrlVB016233
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 09:58:24 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2arujcq4g8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 09:58:24 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 30 May 2017 14:58:23 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 benh@kernel.crashing.org, brking@linux.vnet.ibm.com,
 clsoto@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Enable PCI peer-to-peer
Date: Tue, 30 May 2017 15:58:18 +0200
Message-Id: <20170530135818.19291-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P9 has support for PCI peer-to-peer, enabling a device to write in the
mmio space of another device directly, without interrupting the CPU.

This patch adds support for it on powernv, by defining two APIs to
declare a pci_dev as either a p2p sender or receiver:

  int pnv_pci_set_p2p_sender(struct pci_dev *dev);
  int pnv_pci_set_p2p_receiver(struct pci_dev *dev);

It uses a new OPAL call, as the configuration magic is done on the
PHBs by skiboot.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Need skiboot patch:
http://patchwork.ozlabs.org/patch/768613/

 arch/powerpc/include/asm/opal-api.h            |  9 +++++-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/include/asm/pnv-pci.h             |  2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |  2 +-
 arch/powerpc/platforms/powernv/pci.c           | 43 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h           |  1 +
 7 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index cb3e6242a78c..031f5766b0dd 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -190,7 +190,8 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_PCI_SET_P2P			149
+#define OPAL_LAST				149
 
 /* Device tree flags */
 
@@ -1003,6 +1004,12 @@ enum {
 	XIVE_DUMP_EMU_STATE	= 5,
 };
 
+/* PCI p2p modes */
+enum {
+	OPAL_PCI_P2P_SENDER	= 0,
+	OPAL_PCI_P2P_RECEIVER	= 1,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..59c20b9da1c0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -267,6 +267,7 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
 int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
+int64_t opal_pci_set_p2p(uint64_t phb_id, uint64_t mode);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index de9681034353..1b67c6afd29a 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -26,6 +26,8 @@ extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
 extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
 extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 				   struct opal_msg *msg);
+extern int pnv_pci_set_p2p_sender(struct pci_dev *dev);
+extern int pnv_pci_set_p2p_receiver(struct pci_dev *dev);
 
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f620572f891f..cf629d2d89d9 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -310,3 +310,4 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 283caf1070c9..63263696f2b6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2280,7 +2280,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	return 0;
 }
 
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
+void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 935ccb249a8a..15d087d5749f 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -901,6 +901,49 @@ void pnv_pci_dma_bus_setup(struct pci_bus *bus)
 	}
 }
 
+int pnv_pci_set_p2p_sender(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pnv_ioda_pe *pe;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_P2P))
+		return -ENXIO;
+
+	pe = pnv_ioda_get_pe(dev);
+	if (!pe)
+		return -ENODEV;
+
+	rc = opal_pci_set_p2p(phb->opal_id, OPAL_PCI_P2P_SENDER);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+	/*
+	 * Redefine the TVT entry in bypass mode for the device.
+	 * Now that the PHB is marked as a p2p sender, it disables
+	 * range checking.
+	 */
+	pnv_pci_ioda2_set_bypass(pe, true);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_p2p_sender);
+
+int pnv_pci_set_p2p_receiver(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_P2P))
+		return -ENXIO;
+
+	rc = opal_pci_set_p2p(phb->opal_id, OPAL_PCI_P2P_RECEIVER);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_p2p_receiver);
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 18c8a2fa03b8..6cd95c1a2b8b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -230,6 +230,7 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
+extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
-- 
2.11.0
