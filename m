Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMRmh0nxCzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:52:35 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9PAmfYZ054258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 06:52:32 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dtqyb45hk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 06:52:32 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 25 Oct 2017 11:52:30 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Enable tunneled operations
Date: Wed, 25 Oct 2017 12:52:15 +0200
Message-Id: <20171025105215.19547-1-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P9 supports PCI tunneled operations (atomics and as_notify).

This patch adds support for tunneled operations on powernv, by adding a
new API to be called by drivers:

pnv_pci_get_tunnel_ind() -- tell driver the 16-bit ASN indication set by
kernel.

pnv_pci_set_tunnel_bar() -- tell kernel the Tunnel BAR address mask used
by driver.

These functions use four new OPAL calls, as PBCQ and PHB configurations
are done by skiboot.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
This patch depends on the following skiboot prerequisites:

  https://patchwork.ozlabs.org/patch/829294/
  [1/2] phb4: set PHB CMPM registers for tunneled operations

  https://patchwork.ozlabs.org/patch/829293/
  [2/2] phb4: set PBCQ Tunnel BAR for tunneled operations

 arch/powerpc/include/asm/opal-api.h            | 13 +++-
 arch/powerpc/include/asm/opal.h                |  4 ++
 arch/powerpc/include/asm/pnv-pci.h             |  3 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
 arch/powerpc/platforms/powernv/pci.c           | 92 ++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 450a60b81d2a..607d94d8d863 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -200,7 +200,11 @@
 #define OPAL_SET_POWER_SHIFT_RATIO		155
 #define OPAL_SENSOR_GROUP_CLEAR			156
 #define OPAL_PCI_SET_P2P			157
-#define OPAL_LAST				157
+#define OPAL_PCI_GET_PHB_CMPM			158
+#define OPAL_PCI_SET_PHB_CMPM			159
+#define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		160
+#define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		161
+#define OPAL_LAST				161
 
 /* Device tree flags */
 
@@ -1106,6 +1110,13 @@ enum {
 #define OPAL_PCI_P2P_LOAD		0x2
 #define OPAL_PCI_P2P_STORE		0x4
 
+/* PHB Compare/Mask registers */
+enum {
+	OPAL_PHB_ASN_CMPM	= 0,
+	OPAL_PHB_CAPI_CMPM	= 1,
+	OPAL_PHB_PBL_NBW_CMPM	= 2,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 726c23304a57..556c16d60930 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -198,6 +198,10 @@ int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
 int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_pci_get_phb_cmpm(uint64_t phb_id, uint64_t phb_reg, uint64_t *ind);
+int64_t opal_pci_set_phb_cmpm(uint64_t phb_id, uint64_t phb_reg, uint64_t ind);
+int64_t opal_pci_get_pbcq_tunnel_bar(uint64_t phb_id, uint64_t *addr);
+int64_t opal_pci_set_pbcq_tunnel_bar(uint64_t phb_id, uint64_t addr);
 int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
 int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 3e5cf251ad9a..73b320732fff 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -28,6 +28,9 @@ extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 				   struct opal_msg *msg);
 extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
 			   u64 desc);
+extern int pnv_pci_get_tunnel_ind(struct pci_dev *dev, uint64_t *ind);
+extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
+				  int enable);
 
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8c1ede2d3f7e..9de8cd43380f 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -319,3 +319,7 @@ OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
+OPAL_CALL(opal_pci_get_phb_cmpm,		OPAL_PCI_GET_PHB_CMPM);
+OPAL_CALL(opal_pci_set_phb_cmpm,		OPAL_PCI_SET_PHB_CMPM);
+OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 5422f4a6317c..26230a45e24e 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -38,6 +38,7 @@
 #include "pci.h"
 
 static DEFINE_MUTEX(p2p_mutex);
+static DEFINE_MUTEX(tunnel_mutex);
 
 int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
 {
@@ -1092,6 +1093,97 @@ int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target, u64 desc)
 }
 EXPORT_SYMBOL_GPL(pnv_pci_set_p2p);
 
+int pnv_pci_get_tunnel_ind(struct pci_dev *dev, u64 *ind)
+{
+	__be64 val;
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	u64 asnind;
+	int rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PHB_CMPM))
+		return -ENXIO;
+	if (!opal_check_token(OPAL_PCI_SET_PHB_CMPM))
+		return -ENXIO;
+
+	hose = pci_bus_to_host(dev->bus);
+	phb = hose->private_data;
+
+	mutex_lock(&tunnel_mutex);
+	rc = opal_pci_get_phb_cmpm(phb->opal_id, OPAL_PHB_ASN_CMPM, &val);
+	if (rc != OPAL_SUCCESS) {
+		rc = -EIO;
+		goto out;
+	}
+	asnind = be64_to_cpu(val);
+	if (asnind)
+		goto done;
+
+	/* Hard-coded value for now */
+	asnind = 0x0400;
+	rc = opal_pci_set_phb_cmpm(phb->opal_id, OPAL_PHB_ASN_CMPM, asnind);
+	rc = opal_error_code(rc);
+	if (rc)
+		goto out;
+done:
+	*ind = asnind;
+out:
+	mutex_unlock(&tunnel_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_tunnel_ind);
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
+		 * Only one device per PHB can use atomics.
+		 * Our policy is first-come, first-served.
+		 */
+		if (tunnel_bar) {
+			rc = -EBUSY;
+			goto out;
+		}
+	} else {
+		/*
+		 * The device that owns atomics and wants to release them
+		 * must reuse the same address, and reset the enable bit.
+		 */
+		if (tunnel_bar != addr) {
+			rc = -EPERM;
+			goto out;
+		}
+		addr = 0x0ull;
+	}
+	rc = opal_pci_set_pbcq_tunnel_bar(phb->opal_id, addr);
+	rc = opal_error_code(rc);
+out:
+	mutex_unlock(&tunnel_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
-- 
2.14.2
