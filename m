Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt4Sn6TF4zF1qk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 20:56:25 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w229suqH142848
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Mar 2018 04:56:23 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2geyajtysn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Mar 2018 04:56:23 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 2 Mar 2018 09:56:19 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com, benh@au1.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v10 1/2] powerpc/powernv: Enable tunneled operations
Date: Fri,  2 Mar 2018 10:56:11 +0100
Message-Id: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P9 supports PCI tunneled operations (atomics and as_notify). This
patch adds support for tunneled operations on powernv, with a new
API, to be called by device drivers:

pnv_pci_enable_tunnel()
   Enable tunnel operations, tell driver the 16-bit ASN indication
   used by kernel.

pnv_pci_disable_tunnel()
   Disable tunnel operations.

pnv_pci_set_tunnel_bar()
   Tell kernel the Tunnel BAR Response address used by driver.
   This function uses two new OPAL calls, as the PBCQ Tunnel BAR
   register is configured by skiboot.

pnv_pci_get_as_notify_info()
   Return the ASN info of the thread to be woken up.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changelog:

v2: Do not set the ASN indication. Get it from the device tree.

v3: Make pnv_pci_get_phb_node() available when compiling without cxl.

v4: Add pnv_pci_get_as_notify_info().
    Rebase opal call numbers on skiboot 5.9.6.

v5: pnv_pci_get_tunnel_ind():
      - fix node reference count
    pnv_pci_get_as_notify_info():
      - fail if task == NULL
      - read pid from mm->context.id
      - explain that thread.tidr require CONFIG_PPC64

v6: pnv_pci_get_tunnel_ind():
      - check if radix is enabled, or else return an error
    pnv_pci_get_as_notify_info():
      - remove a capi-specific comment, irrelevant for pci

v7: pnv_pci_set_tunnel_bar():
      - setting the tunnel bar more than once with the same value
        is not an error

v8: No change

v9: Rename pnv_pci_get_tunnel_ind() into pnv_pci_enable_tunnel():
      - Increase real window size to accept as_notify messages.
    New api pnv_pci_disable_tunnel():
      - Restore real window size to its default value.
    Adjust opal call numbers.

v10: Adjust opal call numbers to their final values.
---
 arch/powerpc/include/asm/opal-api.h            |   4 +-
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/include/asm/pnv-pci.h             |   6 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/pci-cxl.c       |   8 --
 arch/powerpc/platforms/powernv/pci.c           | 135 +++++++++++++++++++++++++
 6 files changed, 148 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 94bd1bf2c873..d886a5b7ff21 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -204,7 +204,9 @@
 #define OPAL_NPU_SPA_SETUP			159
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
-#define OPAL_LAST				161
+#define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
+#define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
+#define OPAL_LAST				165
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 12e70fb58700..dde60089d0d4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -204,6 +204,8 @@ int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
 int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_pci_get_pbcq_tunnel_bar(uint64_t phb_id, uint64_t *addr);
+int64_t opal_pci_set_pbcq_tunnel_bar(uint64_t phb_id, uint64_t addr);
 int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
 int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 3e5cf251ad9a..d2d8c28db336 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -29,6 +29,12 @@ extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
 			   u64 desc);
 
+extern int pnv_pci_enable_tunnel(struct pci_dev *dev, uint64_t *asnind);
+extern int pnv_pci_disable_tunnel(struct pci_dev *dev);
+extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
+				  int enable);
+extern int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid,
+				      u32 *pid, u32 *tid);
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 1b2936ba6040..3da30c2f26b4 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -323,3 +323,5 @@ OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
 OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
 OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
+OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 94498a04558b..cee003de63af 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -16,14 +16,6 @@
 
 #include "pci.h"
 
-struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	return of_node_get(hose->dn);
-}
-EXPORT_SYMBOL(pnv_pci_get_phb_node);
-
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 69d102cbf48f..b265ecc0836a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/iommu.h>
+#include <linux/sched/mm.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -38,6 +39,7 @@
 #include "pci.h"
 
 static DEFINE_MUTEX(p2p_mutex);
+static DEFINE_MUTEX(tunnel_mutex);
 
 int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
 {
@@ -1092,6 +1094,139 @@ int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target, u64 desc)
 }
 EXPORT_SYMBOL_GPL(pnv_pci_set_p2p);
 
+struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	return of_node_get(hose->dn);
+}
+EXPORT_SYMBOL(pnv_pci_get_phb_node);
+
+int pnv_pci_enable_tunnel(struct pci_dev *dev, u64 *asnind)
+{
+	struct device_node *np;
+	const __be32 *prop;
+	struct pnv_ioda_pe *pe;
+	uint16_t window_id;
+	int rc;
+
+	if (!radix_enabled())
+		return -ENXIO;
+
+	if (!(np = pnv_pci_get_phb_node(dev)))
+		return -ENXIO;
+
+	prop = of_get_property(np, "ibm,phb-indications", NULL);
+	of_node_put(np);
+
+	if (!prop || !prop[1])
+		return -ENXIO;
+
+	*asnind = (u64)be32_to_cpu(prop[1]);
+	pe = pnv_ioda_get_pe(dev);
+	if (!pe)
+		return -ENODEV;
+
+	/* Increase real window size to accept as_notify messages. */
+	window_id = (pe->pe_number << 1 ) + 1;
+	rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id, pe->pe_number,
+					     window_id, pe->tce_bypass_base,
+					     (uint64_t)1 << 48);
+	return opal_error_code(rc);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_enable_tunnel);
+
+int pnv_pci_disable_tunnel(struct pci_dev *dev)
+{
+	struct pnv_ioda_pe *pe;
+
+	pe = pnv_ioda_get_pe(dev);
+	if (!pe)
+		return -ENODEV;
+
+	/* Restore default real window size. */
+	pnv_pci_ioda2_set_bypass(pe, true);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_disable_tunnel);
+
+int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
+{
+	__be64 val;
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	u64 tunnel_bar;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PBCQ_TUNNEL_BAR))
+		return -ENXIO;
+	if (!opal_check_token(OPAL_PCI_SET_PBCQ_TUNNEL_BAR))
+		return -ENXIO;
+
+	hose = pci_bus_to_host(dev->bus);
+	phb = hose->private_data;
+
+	mutex_lock(&tunnel_mutex);
+	rc = opal_pci_get_pbcq_tunnel_bar(phb->opal_id, &val);
+	if (rc != OPAL_SUCCESS) {
+		rc = -EIO;
+		goto out;
+	}
+	tunnel_bar = be64_to_cpu(val);
+	if (enable) {
+		/*
+		* Only one device per PHB can use atomics.
+		* Our policy is first-come, first-served.
+		*/
+		if (tunnel_bar) {
+			if (tunnel_bar != addr)
+				rc = -EBUSY;
+			else
+				rc = 0;	/* Setting same address twice is ok */
+			goto out;
+		}
+	} else {
+		/*
+		* The device that owns atomics and wants to release
+		* them must pass the same address with enable == 0.
+		*/
+		if (tunnel_bar != addr) {
+			rc = -EPERM;
+			goto out;
+		}
+		addr = 0x0ULL;
+	}
+	rc = opal_pci_set_pbcq_tunnel_bar(phb->opal_id, addr);
+	rc = opal_error_code(rc);
+out:
+	mutex_unlock(&tunnel_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
+
+#ifdef CONFIG_PPC64	/* for thread.tidr */
+int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
+			       u32 *tid)
+{
+	struct mm_struct *mm = NULL;
+
+	if (task == NULL)
+		return -EINVAL;
+
+	mm = get_task_mm(task);
+	if (mm == NULL)
+		return -EINVAL;
+
+	*pid = mm->context.id;
+	mmput(mm);
+
+	*tid = task->thread.tidr;
+	*lpid = mfspr(SPRN_LPID);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_as_notify_info);
+#endif
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
-- 
2.16.1
