Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2NX4hXtzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 19:55:24 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v749renI040176
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 05:55:22 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4m6x87uq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 05:55:21 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 10:55:20 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 benh@kernel.crashing.org, brking@linux.vnet.ibm.com,
 clsoto@linux.vnet.ibm.com
Subject: [PATCH v4] powerpc/powernv: Enable PCI peer-to-peer
Date: Fri,  4 Aug 2017 11:55:14 +0200
Message-Id: <20170804095514.11224-1-fbarrat@linux.vnet.ibm.com>
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

This patch adds support for it on powernv, by adding a new API to be
called by drivers. The pnv_pci_set_p2p(...) call configures an
'initiator', i.e the device which will issue the mmio operation, and a
'target', i.e. the device on the receiving side.

P9 really only supports mmio stores for the time being but that's
expected to change in the future, so the API allows to define both
load and store operations.

    /* PCI p2p descriptor */
    #define OPAL_PCI_P2P_ENABLE		0x1
    #define OPAL_PCI_P2P_LOAD		0x2
    #define OPAL_PCI_P2P_STORE		0x4

    int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
    			   uint64_t desc)

It uses a new OPAL call, as the configuration magic is done on the
PHBs by skiboot.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Requires skiboot patch:
700611a48025c5a556bb0aa011ac81bb5d1bcbc1

Changelog:
v4:
  - resubmit with correct opal call IDs, now that the skiboot portion is merged
v3:
  - move target reference count from skiboot to linux
v2:
  - change of API
  - allow disabling of p2p setting

 arch/powerpc/include/asm/opal-api.h            | 13 ++++-
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/include/asm/pnv-pci.h             |  2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |  3 +-
 arch/powerpc/platforms/powernv/pci.c           | 71 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h           |  5 ++
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 7df005965634..2f52182a4c63 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -193,7 +193,13 @@
 #define OPAL_IMC_COUNTERS_INIT			149
 #define OPAL_IMC_COUNTERS_START			150
 #define OPAL_IMC_COUNTERS_STOP			151
-#define OPAL_LAST				151
+#define OPAL_GET_POWERCAP                       152
+#define OPAL_SET_POWERCAP                       153
+#define OPAL_GET_POWER_SHIFT_RATIO              154
+#define OPAL_SET_POWER_SHIFT_RATIO              155
+#define OPAL_SENSOR_GROUP_CLEAR                 156
+#define OPAL_PCI_SET_P2P                        157
+#define OPAL_LAST                               157
 
 /* Device tree flags */
 
@@ -1094,6 +1100,11 @@ enum {
 };
 
 
+/* PCI p2p descriptor */
+#define OPAL_PCI_P2P_ENABLE		0x1
+#define OPAL_PCI_P2P_LOAD		0x2
+#define OPAL_PCI_P2P_STORE		0x4
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6b8513c3ad40..5a715e66f910 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -267,6 +267,8 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
 int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
+int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
+			uint64_t desc, uint16_t pe_number);
 
 int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 							uint64_t cpu_pir);
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index de9681034353..59a548909d0b 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -26,6 +26,8 @@ extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
 extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
 extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 				   struct opal_msg *msg);
+extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
+			uint64_t desc);
 
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b77f52ee8263..3369a6f2b2f1 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -313,3 +313,4 @@ OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
 OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
 OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
 OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
+OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 437613588df1..026a06c51458 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1408,7 +1408,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 
 static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 		int num);
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
 
 static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
 {
@@ -2394,7 +2393,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	return 0;
 }
 
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
+void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 7905d179d036..d53d4f3d7671 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -37,6 +37,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+static DEFINE_MUTEX(p2p_mutex);
+
 int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
 {
 	struct device_node *parent = np;
@@ -1017,6 +1019,75 @@ void pnv_pci_dma_bus_setup(struct pci_bus *bus)
 	}
 }
 
+int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
+		uint64_t desc)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb_init, *phb_target;
+	struct pnv_ioda_pe *pe_init;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_P2P))
+		return -ENXIO;
+
+	hose = pci_bus_to_host(initiator->bus);
+	phb_init = hose->private_data;
+
+	hose = pci_bus_to_host(target->bus);
+	phb_target = hose->private_data;
+
+	pe_init = pnv_ioda_get_pe(initiator);
+	if (!pe_init)
+		return -ENODEV;
+	/*
+	 * Configuring the initiator's PHB requires to adjust its
+	 * TVE#1 setting. Since the same device can be an initiator
+	 * several times for different target devices, we need to keep
+	 * a reference count to know when we can restore the default
+	 * bypass setting on its TVE#1 when disabling. Opal is not
+	 * tracking PE states, so we add a reference count on the PE
+	 * in linux.
+	 *
+	 * For the target, the configuration is per PHB, so we keep a
+	 * target reference count on the PHB.
+	 */
+	mutex_lock(&p2p_mutex);
+
+	if (desc & OPAL_PCI_P2P_ENABLE) {
+		/* always go to opal to validate the configuration */
+		rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
+				desc, pe_init->pe_number);
+		if (rc != OPAL_SUCCESS) {
+			rc = -EIO;
+			goto out;
+		}
+		pe_init->p2p_initiator_count++;
+		phb_target->p2p_target_count++;
+	} else {
+		if (!pe_init->p2p_initiator_count ||
+			!phb_target->p2p_target_count) {
+			rc = -EINVAL;
+			goto out;
+		}
+		if (--pe_init->p2p_initiator_count == 0)
+			pnv_pci_ioda2_set_bypass(pe_init, true);
+		if (--phb_target->p2p_target_count == 0) {
+			rc = opal_pci_set_p2p(phb_init->opal_id,
+					phb_target->opal_id,
+					desc, pe_init->pe_number);
+			if (rc != OPAL_SUCCESS) {
+				rc = -EIO;
+				goto out;
+			}
+		}
+	}
+	rc = 0;
+out:
+	mutex_unlock(&p2p_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_p2p);
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f16bc403ec03..a95273c524f6 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,6 +78,9 @@ struct pnv_ioda_pe {
 	struct pnv_ioda_pe	*master;
 	struct list_head	slaves;
 
+	/* PCI peer-to-peer*/
+	int			p2p_initiator_count;
+
 	/* Link in list of PE#s */
 	struct list_head	list;
 };
@@ -189,6 +192,7 @@ struct pnv_phb {
 #ifdef CONFIG_CXL_BASE
 	struct cxl_afu *cxl_afu;
 #endif
+	int p2p_target_count;
 };
 
 extern struct pci_ops pnv_pci_ops;
@@ -229,6 +233,7 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
+extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
-- 
2.11.0
