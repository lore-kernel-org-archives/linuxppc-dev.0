Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B11D31A0947
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 97E903578064
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hQQm32243742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h11T005461
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 33/42] powerpc/powernv: Functions to get/reset PCI slot
 status
Date: Thu,  4 Jun 2015 16:42:02 +1000
Message-Id: <1433400131-18429-34-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

   pnv_pci_get_overlay_dt()       opal_get_overlay_dt()
   pnv_pci_get_presence_status()  opal_pci_get_presence_status()
   pnv_pci_get_power_status()     opal_pci_get_power_status()
   pnv_pci_set_power_status()     opal_pci_set_power_status()

Besides, the patch also exports pnv_pci_hotplug_notifier_{register,
unregister}() to allow registration and unregistration of PCI hotplug
notifier, which will be used to receive PCI hotplug message from skiboot
firmware.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 14/21]
  * No polling required for pnv_pci_get_presence_status()
  * Separate functions for registration and unregistration of PCI
    hotplug notifier
  * int64_t for value returned from OPAL API
---
 arch/powerpc/include/asm/opal-api.h            |  8 +++-
 arch/powerpc/include/asm/opal.h                |  4 ++
 arch/powerpc/include/asm/pnv-pci.h             |  7 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
 arch/powerpc/platforms/powernv/pci.c           | 66 ++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..c534dd8 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -153,7 +153,11 @@
 #define OPAL_FLASH_READ				110
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
-#define OPAL_LAST				112
+#define OPAL_GET_OVERLAY_DT			116
+#define OPAL_PCI_GET_PRESENCE_STATUS		117
+#define OPAL_PCI_GET_POWER_STATUS		118
+#define OPAL_PCI_SET_POWER_STATUS		119
+#define OPAL_LAST				119
 
 /* Device tree flags */
 
@@ -352,6 +356,8 @@ enum opal_msg_type {
 	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
+	OPAL_MSG_PRD,
+	OPAL_MSG_PCI_HOTPLUG,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6d467df..2d1c825 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -200,6 +200,10 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_get_overlay_dt(uint64_t *counter, void *buf, uint64_t len);
+int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_set_power_status(uint64_t id, uint8_t status);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f9b4982..9f63375 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,6 +13,13 @@
 #include <linux/pci.h>
 #include <misc/cxl.h>
 
+extern int pnv_pci_get_overlay_dt(uint64_t *counter, void *buf, uint64_t len);
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
index a7ade94..1d87c30 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -295,3 +295,7 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_get_overlay_dt,			OPAL_GET_OVERLAY_DT);
+OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
+OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
+OPAL_CALL(opal_pci_set_power_status,		OPAL_PCI_SET_POWER_STATUS);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index bf5df04..c332ea7 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -65,6 +65,72 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
 	return rval ? -EIO : 0;
 }
 
+int pnv_pci_get_overlay_dt(uint64_t *counter, void *buf, uint64_t len)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_GET_OVERLAY_DT))
+		return -ENXIO;
+
+	rc = opal_get_overlay_dt(counter, buf, len);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_overlay_dt);
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
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0
