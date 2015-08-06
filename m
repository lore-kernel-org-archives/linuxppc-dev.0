Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D98C1A1CF9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F0F262BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764DR9o52887574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:35 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764D2xJ027156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 33/42] powerpc/powernv: Functions to get/reset PCI slot
 status
Date: Thu,  6 Aug 2015 14:11:38 +1000
Message-Id: <1438834307-26960-34-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exports 4 functions, which base on corresponding OPAL
APIs to get or set PCI slot status. Those functions are going to
be used by PCI hotplug module in subsequent patches:

   pnv_pci_get_device_tree()      opal_get_device_tree()
   pnv_pci_get_presence_status()  opal_pci_get_presence_status()
   pnv_pci_get_power_status()     opal_pci_get_power_status()
   pnv_pci_set_power_status()     opal_pci_set_power_status()

Besides, the patch also exports pnv_pci_hotplug_notifier_{register,
unregister}() to allow registration and unregistration of PCI hotplug
notifier, which will be used to receive PCI hotplug message from skiboot
firmware.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  8 +++-
 arch/powerpc/include/asm/opal.h                |  5 ++
 arch/powerpc/include/asm/pnv-pci.h             |  7 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
 arch/powerpc/platforms/powernv/pci.c           | 66 ++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 442995b..33c67ee 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -154,7 +154,11 @@
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
 #define OPAL_PRD_MSG				113
-#define OPAL_LAST				113
+#define OPAL_GET_DEVICE_TREE			117
+#define OPAL_PCI_GET_PRESENCE_STATUS		118
+#define OPAL_PCI_GET_POWER_STATUS		119
+#define OPAL_PCI_SET_POWER_STATUS		120
+#define OPAL_LAST				120
 
 /* Device tree flags */
 
@@ -361,6 +365,8 @@ enum opal_msg_type {
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
 	OPAL_MSG_PRD,
+	OPAL_MSG_OCC,
+	OPAL_MSG_PCI_HOTPLUG,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index bbb3aa6..53b8528 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -203,6 +203,11 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_get_device_tree(uint32_t phandle, uint64_t buf, uint64_t len);
+int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_set_power_status(uint64_t id, uint8_t status);
+
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 6f77f71..7efa87f 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,6 +13,13 @@
 #include <linux/pci.h>
 #include <misc/cxl-base.h>
 
+extern int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len);
+extern int pnv_pci_get_presence_status(uint64_t id, uint8_t *status);
+extern int pnv_pci_get_power_status(uint64_t id, uint8_t *status);
+extern int pnv_pci_set_power_status(uint64_t id, uint8_t status);
+extern int pnv_pci_hotplug_notifier_register(struct notifier_block *nb);
+extern int pnv_pci_hotplug_notifier_unregister(struct notifier_block *nb);
+
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 88e4333..804f8cc 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -298,3 +298,7 @@ OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
 OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
+OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
+OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
+OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
+OPAL_CALL(opal_pci_set_power_status,		OPAL_PCI_SET_POWER_STATUS);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 801e3e8..5982110 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -65,6 +65,72 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
 	return rval ? -EIO : 0;
 }
 
+int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_GET_DEVICE_TREE))
+		return -ENXIO;
+
+	rc = opal_get_device_tree(phandle, (uint64_t)buf, len);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_device_tree);
+
+int pnv_pci_get_presence_status(uint64_t id, uint8_t *status)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_get_presence_status(id, status);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_presence_status);
+
+int pnv_pci_get_power_status(uint64_t id, uint8_t *status)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_POWER_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_get_power_status(id, status);
+	return pnv_pci_poll(id, rc, status);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_power_status);
+
+int pnv_pci_set_power_status(uint64_t id, uint8_t status)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_POWER_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_set_power_status(id, status);
+	return pnv_pci_poll(id, rc, NULL);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_power_status);
+
+int pnv_pci_hotplug_notifier_register(struct notifier_block *nb)
+{
+	return opal_message_notifier_register(OPAL_MSG_PCI_HOTPLUG, nb);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier_register);
+
+int pnv_pci_hotplug_notifier_unregister(struct notifier_block *nb)
+{
+	return opal_message_notifier_unregister(OPAL_MSG_PCI_HOTPLUG, nb);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier_unregister);
+
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0
