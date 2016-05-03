Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhgz53rQzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:27 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:26 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 68BC5E0062
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:56:21 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNQG314221634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:26 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNLa6032002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:25 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 15/22] powerpc/powernv: Functions to get/set PCI slot state
Date: Tue,  3 May 2016 23:22:46 +1000
Message-Id: <1462281773-26438-16-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports 4 functions, which base on the corresponding OPAL
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
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/opal-api.h            |  18 ++++-
 arch/powerpc/include/asm/opal.h                |   5 ++
 arch/powerpc/include/asm/pnv-pci.h             |   7 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   5 ++
 arch/powerpc/platforms/powernv/pci.c           | 102 +++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..728e04e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -158,7 +158,12 @@
 #define OPAL_LEDS_SET_INDICATOR			115
 #define OPAL_CEC_REBOOT2			116
 #define OPAL_CONSOLE_FLUSH			117
-#define OPAL_LAST				117
+#define OPAL_GET_DEVICE_TREE			118
+#define OPAL_PCI_GET_PRESENCE_STATE		119
+#define OPAL_PCI_GET_POWER_STATE		120
+#define OPAL_PCI_SET_POWER_STATE		121
+#define OPAL_PCI_POLL2				122
+#define OPAL_LAST				122
 
 /* Device tree flags */
 
@@ -344,6 +349,16 @@ enum OpalPciResetState {
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
@@ -378,6 +393,7 @@ enum opal_msg_type {
 	OPAL_MSG_DPO		= 5,
 	OPAL_MSG_PRD		= 6,
 	OPAL_MSG_OCC		= 7,
+	OPAL_MSG_PCI_HOTPLUG	= 8,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 348132c..1a83c80 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -209,6 +209,11 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_get_device_tree(uint32_t phandle, uint64_t buf, uint64_t len);
+int64_t opal_pci_get_presence_state(uint64_t id, uint64_t data);
+int64_t opal_pci_get_power_state(uint64_t id, uint64_t data);
+int64_t opal_pci_set_power_state(uint64_t id, uint64_t data);
+int64_t opal_pci_poll2(uint64_t id, uint64_t data);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index c607902..8db7439 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -17,6 +17,13 @@
 #define PCI_SLOT_ID(phb_id, bdfn)	\
 	(PCI_SLOT_ID_PREFIX | ((uint64_t)(bdfn) << 16) | (phb_id))
 
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
index e45b88a..60397d2 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -302,3 +302,8 @@ OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
 OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
 OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
 OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
+OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
+OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
+OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
+OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
+OPAL_CALL(opal_pci_poll2,			OPAL_PCI_POLL2);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 67a33e9..6e10ac4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -42,6 +42,108 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
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
+static int pnv_pci_poll2(uint64_t id, uint8_t *state)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_POLL2))
+		return -ENXIO;
+
+	while (1) {
+		rc = opal_pci_poll2(id, (uint64_t)state);
+		if (rc <= OPAL_SUCCESS)
+			break;
+
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rc);
+		else
+			msleep(rc);
+	}
+
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+int pnv_pci_get_presence_state(uint64_t id, uint8_t *state)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_GET_PRESENCE_STATE))
+		return -ENXIO;
+
+	rc = opal_pci_get_presence_state(id, (uint64_t)state);
+	if (rc == OPAL_SUCCESS)
+		return 0;
+	else if (rc < OPAL_SUCCESS)
+		return -EIO;
+
+	return pnv_pci_poll2(id, state);
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
+	rc = opal_pci_get_power_state(id, (uint64_t)state);
+	if (rc == OPAL_SUCCESS)
+		return 0;
+	else if (rc < OPAL_SUCCESS)
+		return -EIO;
+
+	return pnv_pci_poll2(id, state);
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
+	rc = opal_pci_set_power_state(id, (uint64_t)&state);
+	if (rc == OPAL_SUCCESS)
+		return 0;
+	else if (rc < OPAL_SUCCESS)
+		return -EIO;
+
+	return pnv_pci_poll2(id, &state);
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
