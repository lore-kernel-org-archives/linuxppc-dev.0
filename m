Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0v26M5zDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:43 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 86D3F2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6hN9A2884068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gw8T000330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 17/18] powerpc/powernv: Functions to get/set PCI slot state
Date: Fri, 20 May 2016 16:41:41 +1000
Message-Id: <1463726502-14679-18-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/opal-api.h            | 19 +++++-
 arch/powerpc/include/asm/opal.h                |  6 ++
 arch/powerpc/include/asm/pnv-pci.h             |  6 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++
 arch/powerpc/platforms/powernv/pci.c           | 82 ++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..2417c86 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -158,7 +158,11 @@
 #define OPAL_LEDS_SET_INDICATOR			115
 #define OPAL_CEC_REBOOT2			116
 #define OPAL_CONSOLE_FLUSH			117
-#define OPAL_LAST				117
+#define OPAL_GET_DEVICE_TREE			118
+#define OPAL_PCI_GET_PRESENCE_STATE		119
+#define OPAL_PCI_GET_POWER_STATE		120
+#define OPAL_PCI_SET_POWER_STATE		121
+#define OPAL_LAST				121
 
 /* Device tree flags */
 
@@ -344,6 +348,18 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET   = 1
 };
 
+enum OpalPciSlotPresentenceState {
+	OPAL_PCI_SLOT_EMPTY	= 0,
+	OPAL_PCI_SLOT_PRESENT	= 1
+};
+
+enum OpalPciSlotPowerState {
+	OPAL_PCI_SLOT_POWER_OFF	= 0,
+	OPAL_PCI_SLOT_POWER_ON	= 1,
+	OPAL_PCI_SLOT_OFFLINE	= 2,
+	OPAL_PCI_SLOT_ONLINE	= 3
+};
+
 enum OpalSlotLedType {
 	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
 	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
@@ -378,6 +394,7 @@ enum opal_msg_type {
 	OPAL_MSG_DPO		= 5,
 	OPAL_MSG_PRD		= 6,
 	OPAL_MSG_OCC		= 7,
+	OPAL_MSG_PCI_HOTPLUG	= 8,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 348132c..fa71fea 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -209,6 +209,12 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
+int64_t opal_get_device_tree(uint32_t phandle, uint64_t buf, uint64_t len);
+int64_t opal_pci_get_presence_state(uint64_t id, uint64_t data);
+int64_t opal_pci_get_power_state(uint64_t id, uint64_t data);
+int64_t opal_pci_set_power_state(uint64_t async_token, uint64_t id,
+				 uint64_t data);
+int64_t opal_pci_poll2(uint64_t id, uint64_t data);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 810cc9a..791db1b 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -12,12 +12,18 @@
 
 #include <linux/pci.h>
 #include <misc/cxl-base.h>
+#include <asm/opal-api.h>
 
 #define PCI_SLOT_ID_PREFIX	0x8000000000000000
 #define PCI_SLOT_ID(phb_id, bdfn)	\
 	(PCI_SLOT_ID_PREFIX | ((uint64_t)(bdfn) << 16) | (phb_id))
 
 extern int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id);
+extern int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len);
+extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
+extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
+extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
+				   struct opal_msg *msg);
 
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e45b88a..3ea1a855 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -302,3 +302,7 @@ OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
 OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
 OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
 OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
+OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
+OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
+OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
+OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2607d29..62c7637 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -74,6 +74,88 @@ int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
 }
 EXPORT_SYMBOL_GPL(pnv_pci_get_slot_id);
 
+int pnv_pci_get_device_tree(uint32_t phandle, void *buf, uint64_t len)
+{
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_GET_DEVICE_TREE))
+		return -ENXIO;
+
+	rc = opal_get_device_tree(phandle, (uint64_t)buf, len);
+	if (rc < OPAL_SUCCESS)
+		return -EIO;
+
+	return rc;
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
+	rc = opal_pci_get_presence_state(id, (uint64_t)state);
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
+	rc = opal_pci_get_power_state(id, (uint64_t)state);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_power_state);
+
+int pnv_pci_set_power_state(uint64_t id, uint8_t state, struct opal_msg *msg)
+{
+	struct opal_msg m;
+	int token, ret;
+	int64_t rc;
+
+	if (!opal_check_token(OPAL_PCI_SET_POWER_STATE))
+		return -ENXIO;
+
+	token = opal_async_get_token_interruptible();
+	if (unlikely(token < 0))
+		return token;
+
+	rc = opal_pci_set_power_state(token, id, (uint64_t)&state);
+	if (rc == OPAL_SUCCESS) {
+		ret = 0;
+		goto exit;
+	} else if (rc != OPAL_ASYNC_COMPLETION) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	ret = opal_async_wait_response(token, &m);
+	if (ret < 0)
+		goto exit;
+
+	if (msg) {
+		ret = 1;
+		memcpy(msg, &m, sizeof(m));
+	}
+
+exit:
+	opal_async_release_token(token);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_set_power_state);
+
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0
