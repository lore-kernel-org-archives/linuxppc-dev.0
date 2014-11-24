Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C75101A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:49:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8073A2BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMnSZE29163746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnRE3025610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 8/8] PCI/hotplug/rpa: Support OPAL firmware
Date: Tue, 25 Nov 2014 09:49:25 +1100
Message-Id: <1416869365-7671-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds support for OPAL firmware. All hotpluggable PCI
slots are recognized by device node property "ibm,slot-pluggable".
The slot name (label) is derived from property "ibm,slot-label".

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/Kconfig       |   4 +-
 drivers/pci/hotplug/Makefile      |   3 +-
 drivers/pci/hotplug/rpaphp.h      |   5 +
 drivers/pci/hotplug/rpaphp_core.c |  12 +-
 drivers/pci/hotplug/rpaphp_opal.c | 241 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/rpaphp_rtas.c |  10 ++
 6 files changed, 268 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/hotplug/rpaphp_opal.c

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index df8caec..44859e0 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -115,7 +115,7 @@ config HOTPLUG_PCI_SHPC
 
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
-	depends on PPC_PSERIES && EEH
+	depends on (PPC_PSERIES || PPC_POWERNV) && EEH
 	help
 	  Say Y here if you have a RPA system that supports PCI Hotplug.
 
@@ -126,7 +126,7 @@ config HOTPLUG_PCI_RPA
 
 config HOTPLUG_PCI_RPA_DLPAR
 	tristate "RPA Dynamic Logical Partitioning for I/O slots"
-	depends on HOTPLUG_PCI_RPA
+	depends on HOTPLUG_PCI_RPA && PPC_PSERIES
 	help
 	  Say Y here if your system supports Dynamic Logical Partitioning
 	  for I/O slots.
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 630313da..c216e40 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -51,7 +51,8 @@ acpiphp-objs		:=	acpiphp_core.o	\
 				acpiphp_glue.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
-				rpaphp_rtas.o
+				rpaphp_rtas.o	\
+				rpaphp_opal.o
 
 rpadlpar_io-objs	:=	rpadlpar_core.o \
 				rpadlpar_sysfs.o
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 0354572..e52ff1b 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -86,8 +86,13 @@ int rpaphp_deregister_slot(struct rpa_php_slot *slot);
 int rpaphp_add_slot(struct device_node *dn);
 
 /* rpaphp_rtas.c */
+int rpaphp_rtas_init(void);
 int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 			 char **drc_name, char **drc_type, int *drc_power);
 struct rpa_php_slot *rpaphp_rtas_add_slot(struct device_node *dn);
 
+/* rpaphp_opal.c */
+int rpaphp_opal_init(void);
+struct rpa_php_slot *rpaphp_opal_add_slot(struct device_node *dn);
+
 #endif				/* _PPC64PHP_H */
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index ba28212..84daa2a 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -216,6 +216,8 @@ int rpaphp_add_slot(struct device_node *dn)
 	/* Create slot */
 	if (machine_is(pseries))
 		slot = rpaphp_rtas_add_slot(dn);
+	else if (machine_is(powernv))
+		slot = rpaphp_opal_add_slot(dn);
 
 	if (slot) {
 		/* Enable slot */
@@ -259,14 +261,16 @@ static void __exit cleanup_slots(void)
 
 static int __init rpaphp_init(void)
 {
-	struct device_node *dn;
+	int ret = 0;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	for_each_node_by_name(dn, "pci")
-		rpaphp_add_slot(dn);
+	if (machine_is(pseries))
+		ret = rpaphp_rtas_init();
+	else if (machine_is(powernv))
+		ret = rpaphp_opal_init();
 
-	return 0;
+	return ret;
 }
 
 static void __exit rpaphp_exit(void)
diff --git a/drivers/pci/hotplug/rpaphp_opal.c b/drivers/pci/hotplug/rpaphp_opal.c
new file mode 100644
index 0000000..1040767
--- /dev/null
+++ b/drivers/pci/hotplug/rpaphp_opal.c
@@ -0,0 +1,241 @@
+/*
+ * OPAL backend for RPA-compliant PP64 platform.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2014
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <asm/eeh.h>
+#include <asm/pci-bridge.h>
+#include <asm/opal.h>
+#include <asm/pnv-pci.h>
+
+#include "../pci.h"
+#include "rpaphp.h"
+
+#ifdef CONFIG_PPC_POWERNV
+static int get_power_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	int ret;
+	uint8_t state;
+
+	/* By default, the power is on */
+	*val = RPA_PHP_SLOT_POWER_ON;
+
+	/* Retrieve power state from firmware, which might fail */
+	ret = pnv_pci_get_power_status(slot->index, &state);
+	if (!ret) {
+		if (state > 0)
+			hp_slot->info->power_status = RPA_PHP_SLOT_POWER_ON;
+		else
+			hp_slot->info->power_status = RPA_PHP_SLOT_POWER_OFF;
+		*val = hp_slot->info->power_status;
+	}
+
+	return 0;
+}
+
+static int get_adapter_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	uint8_t state;
+	int ret;
+
+	/* By default, the slot is empty */
+	*val = RPA_PHP_SLOT_EMPTY;
+
+	/* Retrieve presence state from firmware */
+	ret = pnv_pci_get_presence_status(slot->index, &state);
+	if (ret >= 0) {
+		if (state > 0)
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_PRESENT;
+		else
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_EMPTY;
+		*val = hp_slot->info->adapter_status;
+	}
+
+	return 0;
+}
+#else
+static int get_power_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	*val = RPA_PHP_SLOT_POWER_ON;
+
+	return 0;
+}
+
+static int get_adapter_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	*val = RPA_PHP_SLOT_EMPTY;
+
+	return 0;
+}
+#endif /* CONFIG_PPC_POWERNV */
+
+static int set_attention_status(struct hotplug_slot *hp_slot, u8 val)
+{
+	/*
+	 * The default operation would to turn on
+	 * the attention
+	 */
+	switch (val) {
+	case RPA_PHP_SLOT_ATTEN_OFF:
+	case RPA_PHP_SLOT_ATTEN_ON:
+	case RPA_PHP_SLOT_ATTEN_IND:
+	case RPA_PHP_SLOT_ATTEN_ACT:
+		break;
+	default:
+		val = RPA_PHP_SLOT_ATTEN_ON;
+	}
+
+	/* FIXME: Set it through firmware interface */
+	hp_slot->info->attention_status = val;
+
+	return 0;
+}
+
+static int enable_slot(struct hotplug_slot *hp_slot)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	uint8_t presence;
+	int ret;
+
+	/* Check if the slot has been configured */
+	if (slot->state == RPA_PHP_SLOT_CONFIGURED)
+		return 0;
+
+	/* Retrieve slot presence status */
+	ret = hp_slot->ops->get_adapter_status(hp_slot, &presence);
+	if (ret)
+		return ret;
+
+	switch (presence) {
+	case RPA_PHP_SLOT_PRESENT:
+		pci_lock_rescan_remove();
+		pcibios_add_pci_devices(slot->bus);
+		pci_unlock_rescan_remove();
+		slot->state = RPA_PHP_SLOT_CONFIGURED;
+		break;
+	case RPA_PHP_SLOT_EMPTY:
+		slot->state = RPA_PHP_SLOT_NOT_CONFIGURED;
+		break;
+	default:
+		slot->state = RPA_PHP_SLOT_NOT_VALID;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int disable_slot(struct hotplug_slot *hp_slot)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+
+	if (slot->state != RPA_PHP_SLOT_CONFIGURED)
+		return 0;
+
+	pci_lock_rescan_remove();
+	pcibios_remove_pci_devices(slot->bus);
+	pci_unlock_rescan_remove();
+	vm_unmap_aliases();
+
+	slot->state = RPA_PHP_SLOT_NOT_CONFIGURED;
+	return 0;
+}
+
+static struct hotplug_slot_ops rpaphp_opal_ops = {
+	.get_power_status	= get_power_status,
+	.get_adapter_status	= get_adapter_status,
+	.set_attention_status	= set_attention_status,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+};
+
+struct rpa_php_slot *rpaphp_opal_add_slot(struct device_node *dn)
+{
+	struct device_node *parent;
+	struct pci_bus *bus;
+	struct rpa_php_slot *slot;
+	const char *label;
+	uint64_t opal_id;
+	int hotplug, index, ret;
+
+	/* Not PCI device node ? */
+	if (!dn || !PCI_DN(dn))
+		return NULL;
+
+	/* Hotpluggable slot ? */
+	ret = of_property_read_u32(dn, "ibm,slot-pluggable", &hotplug);
+	if (ret || !hotplug)
+		return NULL;
+
+	/* Slot name missed ? */
+	ret = of_property_read_string(dn, "ibm,slot-label", &label);
+	if (ret)
+		return NULL;
+
+	/*
+	 * Check binding bus. The root port isn't hotpluggable always.
+	 * So we needn't consider root bus
+	 */
+	bus = pcibios_find_pci_bus(dn);
+	if (!bus && pci_is_root_bus(bus))
+		return NULL;
+
+	/* Retrieve PHB OPAL ID */
+	parent = of_node_get(dn);
+	while (parent) {
+		ret = of_property_read_u64(parent, "ibm,opal-phbid", &opal_id);
+		if (!ret) {
+			of_node_put(parent);
+			break;
+		}
+
+		of_node_put(parent);
+		parent = of_get_parent(parent);
+	}
+
+	/*
+	 * Allocate slot. We always have non-compound case as the root
+	 * port isn't hotpluggable always.
+	 */
+	index = (u32)(opal_id);
+	index = (index << 16) | (bus->number << 8) | bus->self->devfn;
+	slot = alloc_slot_struct(dn, index, (char *)label, -1);
+	if (!slot)
+		return NULL;
+
+	slot->type	= 0;
+	slot->bus	= bus;
+	slot->pci_devs	= &bus->devices;
+	slot->hotplug_slot->ops = &rpaphp_opal_ops;
+
+	return slot;
+}
+
+int rpaphp_opal_init(void)
+{
+	struct device_node *dn;
+
+	for_each_compatible_node(dn, "pciex", "ibm,ioda2-phb")
+		rpaphp_add_slot(dn);
+	for_each_compatible_node(dn, "pciex", "ibm,ioda-phb")
+		rpaphp_add_slot(dn);
+
+	return 0;
+}
diff --git a/drivers/pci/hotplug/rpaphp_rtas.c b/drivers/pci/hotplug/rpaphp_rtas.c
index 74f024a..86b1d4093 100644
--- a/drivers/pci/hotplug/rpaphp_rtas.c
+++ b/drivers/pci/hotplug/rpaphp_rtas.c
@@ -318,3 +318,13 @@ fail:
 	dealloc_slot_struct(slot);
 	return NULL;
 }
+
+int rpaphp_rtas_init(void)
+{
+	struct device_node *dn;
+
+	for_each_node_by_name(dn, "pci")
+		rpaphp_add_slot(dn);
+
+	return 0;
+}
-- 
1.8.3.2
