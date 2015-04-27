Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 098B11A0A96
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A26F52CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6d8rx5439522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6cgik013052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:38:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 15/21] powerpc/powernv: Functions to get/reset PCI slot
 status
Date: Mon, 27 Apr 2015 16:37:47 +1000
Message-Id: <1430116673-22500-16-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exports 3 functions, which base on corresponding OPAL
APIs to get or set PCI slot status. Those functions are going to
be used by PCI hotplug module in subsequent patches:

   pnv_pci_get_presence_status()  opal_pci_get_presence_status()
   pnv_pci_get_power_status()     opal_pci_get_power_status()
   pnv_pci_set_power_status()     opal_pci_set_power_status()

Besides, the patch also exports pnv_pci_hotplug_notifier() to allow
registering PCI hotplug notifier, which will be used to receive PCI
hotplug message from skiboot firmware.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  7 +++-
 arch/powerpc/include/asm/opal.h                |  3 ++
 arch/powerpc/include/asm/pnv-pci.h             |  5 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  3 ++
 arch/powerpc/platforms/powernv/pci.c           | 45 ++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..29b407d 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -153,7 +153,10 @@
 #define OPAL_FLASH_READ				110
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
-#define OPAL_LAST				112
+#define OPAL_PCI_GET_PRESENCE_STATUS		116
+#define OPAL_PCI_GET_POWER_STATUS		117
+#define OPAL_PCI_SET_POWER_STATUS		118
+#define OPAL_LAST				118
 
 /* Device tree flags */
 
@@ -352,6 +355,8 @@ enum opal_msg_type {
 	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
+	OPAL_MSG_PRD,
+	OPAL_MSG_PCI_HOTPLUG,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6d467df..a0eb206 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -200,6 +200,9 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_pci_get_presence_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_get_power_status(uint64_t id, uint8_t *status);
+int64_t opal_pci_set_power_status(uint64_t id, uint8_t status);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f9b4982..50d92a4 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,6 +13,11 @@
 #include <linux/pci.h>
 #include <misc/cxl.h>
 
+extern int pnv_pci_get_presence_status(uint64_t id, uint8_t *status);
+extern int pnv_pci_get_power_status(uint64_t id, uint8_t *status);
+extern int pnv_pci_set_power_status(uint64_t id, uint8_t status);
+extern int pnv_pci_hotplug_notifier(struct notifier_block *nb, bool enable);
+
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a7ade94..aa95dcb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -295,3 +295,6 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_pci_get_presence_status,		OPAL_PCI_GET_PRESENCE_STATUS);
+OPAL_CALL(opal_pci_get_power_status,		OPAL_PCI_GET_POWER_STATUS);
+OPAL_CALL(opal_pci_set_power_status,		OPAL_PCI_SET_POWER_STATUS);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a2da9a3..60e6d65 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -60,6 +60,51 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
 	return rval ? -EIO : 0;
 }
 
+int pnv_pci_get_presence_status(uint64_t id, uint8_t *status)
+{
+	long rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_get_presence_status(id, status);
+	return pnv_pci_poll(id, rc, status);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_presence_status);
+
+int pnv_pci_get_power_status(uint64_t id, uint8_t *status)
+{
+	long rc;
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
+	long rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_POWER_STATUS))
+		return -ENXIO;
+
+	rc = opal_pci_set_power_status(id, status);
+	return pnv_pci_poll(id, rc, NULL);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_power_status);
+
+int pnv_pci_hotplug_notifier(struct notifier_block *nb, bool enable)
+{
+	if (enable)
+		return opal_message_notifier_register(OPAL_MSG_PCI_HOTPLUG, nb);
+
+	return opal_message_notifier_unregister(OPAL_MSG_PCI_HOTPLUG, nb);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_hotplug_notifier);
+
 #ifdef CONFIG_PCI_MSI
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0
