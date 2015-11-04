Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E1381A0C67
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D6CEB2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDj7q35651592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:53 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDI4o030339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:19 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 42/50] powerpc/powernv: Functions to get/set PCI slot status
Date: Thu,  5 Nov 2015 00:12:42 +1100
Message-Id: <1446642770-4681-43-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports 4 functins, which base on the corresponding OPAL
APIs to get/set PCI slot status. Those functions are going to
be used by PowerNV PCI hotplug driver:

   pnv_pci_get_device_tree()    opal_get_device_tree()
   pnv_pci_get_presence_state() opal_pci_get_presence_state()
   pnv_pci_get_power_state()    opal_pci_get_power_state()
   pnv_pci_set_power_state()    opal_pci_set_power_state()

Besides, the patch also exports pnv_pci_hotplug_notifier_{register,
unregister}() to allow registration and unregistration of PCI hotplug
notifier, which will be used to receive PCI hotplug message from
skiboot firmware in PowerNV PCI hotplug driver.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            | 17 ++++++-
 arch/powerpc/include/asm/opal.h                |  4 ++
 arch/powerpc/include/asm/pnv-pci.h             |  7 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
 arch/powerpc/platforms/powernv/pci.c           | 66 ++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 8374afe..fe3e458 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -157,7 +157,11 @@
 #define OPAL_LEDS_GET_INDICATOR			114
 #define OPAL_LEDS_SET_INDICATOR			115
 #define OPAL_CEC_REBOOT2			116
-#define OPAL_LAST				116
+#define OPAL_GET_DEVICE_TREE			117
+#define OPAL_PCI_GET_PRESENCE_STATE		118
+#define OPAL_PCI_GET_POWER_STATE		119
+#define OPAL_PCI_SET_POWER_STATE		120
+#define OPAL_LAST				120
 
 /* Device tree flags */
 
@@ -343,6 +347,16 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET   = 1
 };
 
+enum OpalPciSlotPresentenceState {
+	OPAL_PCI_SLOT_EMPTY	= 0,
+	OPAL_PCI_SLOT_PRESENT	= 1
+};
+
+enum OpalPciSlotPowerState {
+	OPAL_PCI_SLOT_POWER_OFF	= 0,
+	OPAL_PCI_SLOT_POWER_ON	= 1
+};
+
 enum OpalSlotLedType {
 	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
 	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
@@ -377,6 +391,7 @@ enum opal_msg_type {
 	OPAL_MSG_DPO,
 	OPAL_MSG_PRD,
 	OPAL_MSG_OCC,
+	OPAL_MSG_PCI_HOTPLUG,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 11ee20e..47f200e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -208,6 +208,10 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_get_device_tree(uint32_t phandle, uint64_t buf, uint64_t len);
+int64_t opal_pci_get_presence_state(uint64_t id, uint8_t *state);
+int64_t opal_pci_get_power_state(uint64_t id, uint8_t *state);
+int64_t opal_pci_set_power_state(uint64_t id, uint8_t state);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 6f77f71..d9d095b 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,6 +13,13 @@
 #include <linux/pci.h>
 #include <misc/cxl-base.h>
 
+extern int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len);
+extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
+extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
+extern int pnv_pci_set_power_state(uint64_t id, uint8_t state);
+extern int pnv_pci_hotplug_notifier_register(struct notifier_block *nb);
+extern int pnv_pci_hotplug_notifier_unregister(struct notifier_block *nb);
+
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b7a464f..55f1fd4 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -301,3 +301,7 @@ OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
 OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
 OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
 OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
+OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
+OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
+OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
+OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index ae0f0c1..71c648e 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -65,6 +65,72 @@ int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state)
 	return (rval == OPAL_SUCCESS) ? 0 : -EIO;
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
+int pnv_pci_get_presence_state(uint64_t id, uint8_t *state)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATE))
+		return -ENXIO;
+
+	rc = opal_pci_get_presence_state(id, state);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_presence_state);
+
+int pnv_pci_get_power_state(uint64_t id, uint8_t *state)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_POWER_STATE))
+		return -ENXIO;
+
+	rc = opal_pci_get_power_state(id, state);
+	return pnv_pci_poll(id, rc, state);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_power_state);
+
+int pnv_pci_set_power_state(uint64_t id, uint8_t state)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_POWER_STATE))
+		return -ENXIO;
+
+	rc = opal_pci_set_power_state(id, state);
+	return pnv_pci_poll(id, rc, NULL);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_power_state);
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
