Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnkt6l5XzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:23:02 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIeQj006226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:23:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa4c5ce7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:23:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:22:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2D1333578057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DMtos63963304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DMsjC018102
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:55 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 12/14] PCI/hotplug: pnv_php: export symbols and move struct
 types needed by cxl
Date: Mon,  4 Jul 2016 23:22:10 +1000
In-Reply-To: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467638532-9250-13-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

The cxl driver will use infrastructure from pnv_php to handle device tree
updates when switching bi-modal CAPI cards into CAPI mode.

To enable this, export pnv_php_find_slot() and
pnv_php_set_slot_power_state(), and add corresponding declarations, as well
as the definition of struct pnv_php_slot, to asm/pnv-pci.h.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-pci.h | 28 ++++++++++++++++++++++++++++
 drivers/pci/hotplug/Kconfig        |  1 +
 drivers/pci/hotplug/pnv_php.c      | 32 +++++---------------------------
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index c47097f..0cbd813 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -11,6 +11,7 @@
 #define _ASM_PNV_PCI_H
 
 #include <linux/pci.h>
+#include <linux/pci_hotplug.h>
 #include <misc/cxl-base.h>
 #include <asm/opal-api.h>
 
@@ -47,4 +48,31 @@ void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu);
 
 #endif
 
+struct pnv_php_slot {
+	struct hotplug_slot		slot;
+	struct hotplug_slot_info	slot_info;
+	uint64_t			id;
+	char				*name;
+	int				slot_no;
+	struct kref			kref;
+#define PNV_PHP_STATE_INITIALIZED	0
+#define PNV_PHP_STATE_REGISTERED	1
+#define PNV_PHP_STATE_POPULATED		2
+#define PNV_PHP_STATE_OFFLINE		3
+	int				state;
+	struct device_node		*dn;
+	struct pci_dev			*pdev;
+	struct pci_bus			*bus;
+	bool				power_state_check;
+	void				*fdt;
+	void				*dt;
+	struct of_changeset		ocs;
+	struct pnv_php_slot		*parent;
+	struct list_head		children;
+	struct list_head		link;
+};
+extern struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn);
+extern int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
+					uint8_t state);
+
 #endif
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index aadce45..b719a72 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -117,6 +117,7 @@ config HOTPLUG_PCI_POWERNV
 	tristate "PowerPC PowerNV PCI Hotplug driver"
 	depends on PPC_POWERNV && EEH
 	select OF_DYNAMIC
+	select HOTPLUG_PCI_POWERNV_BASE
 	help
 	  Say Y here if you run PowerPC PowerNV platform that supports
 	  PCI Hotplug
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 6086db6..2d2f704 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -22,30 +22,6 @@
 #define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
 #define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
 
-struct pnv_php_slot {
-	struct hotplug_slot		slot;
-	struct hotplug_slot_info	slot_info;
-	uint64_t			id;
-	char				*name;
-	int				slot_no;
-	struct kref			kref;
-#define PNV_PHP_STATE_INITIALIZED	0
-#define PNV_PHP_STATE_REGISTERED	1
-#define PNV_PHP_STATE_POPULATED		2
-#define PNV_PHP_STATE_OFFLINE		3
-	int				state;
-	struct device_node		*dn;
-	struct pci_dev			*pdev;
-	struct pci_bus			*bus;
-	bool				power_state_check;
-	void				*fdt;
-	void				*dt;
-	struct of_changeset		ocs;
-	struct pnv_php_slot		*parent;
-	struct list_head		children;
-	struct list_head		link;
-};
-
 static LIST_HEAD(pnv_php_slot_list);
 static DEFINE_SPINLOCK(pnv_php_lock);
 
@@ -91,7 +67,7 @@ static struct pnv_php_slot *pnv_php_match(struct device_node *dn,
 	return NULL;
 }
 
-static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
+struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot, *tmp;
 	unsigned long flags;
@@ -108,6 +84,7 @@ static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(pnv_php_find_slot);
 
 /*
  * Remove pdn for all children of the indicated device node.
@@ -316,8 +293,8 @@ out:
 	return ret;
 }
 
-static int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
-					uint8_t state)
+int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
+				 uint8_t state)
 {
 	struct pnv_php_slot *php_slot = slot->private;
 	struct opal_msg msg;
@@ -347,6 +324,7 @@ static int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pnv_php_set_slot_power_state);
 
 static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 {
-- 
2.8.1
