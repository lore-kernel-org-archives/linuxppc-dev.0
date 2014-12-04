Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1EA51A010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:54:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 15:54:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D1E552BB0071
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:54:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45sjwH38142058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 16:54:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45sp7u015071
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 16:54:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 5/5] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
Date: Thu,  4 Dec 2014 16:54:48 +1100
Message-Id: <1417672488-27341-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to add standalone driver to support PCI hotplug
for PowerPC PowerNV platform, which runs on top of skiboot firmware.
The firmware identified hotpluggable slots and marked their device
tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
The driver simply scans device-tree to create/register PCI hotplug slot
accordingly.

If the skiboot firmware doesn't support slot status retrieval, the PCI
slot device node shouldn't have property "ibm,reset-by-firmware". In
that case, none of valid PCI slots will be detected from device tree.
The skiboot firmware doesn't export the capability to access attention
LEDs yet and it's something for TBD.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/Kconfig            |  12 ++
 drivers/pci/hotplug/Makefile           |   4 +
 drivers/pci/hotplug/powernv_php.c      | 126 +++++++++++
 drivers/pci/hotplug/powernv_php.h      |  70 ++++++
 drivers/pci/hotplug/powernv_php_slot.c | 382 +++++++++++++++++++++++++++++++++
 5 files changed, 594 insertions(+)
 create mode 100644 drivers/pci/hotplug/powernv_php.c
 create mode 100644 drivers/pci/hotplug/powernv_php.h
 create mode 100644 drivers/pci/hotplug/powernv_php_slot.c

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index df8caec..ef55dae 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -113,6 +113,18 @@ config HOTPLUG_PCI_SHPC
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_POWERNV
+	tristate "PowerPC PowerNV PCI Hotplug driver"
+	depends on PPC_POWERNV && EEH
+	help
+	  Say Y here if you run PowerPC PowerNV platform that supports
+          PCI Hotplug
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called powernv-php.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
 	depends on PPC_PSERIES && EEH
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 4a9aa08..a69665e 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
+obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= powernv-php.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
@@ -50,6 +51,9 @@ ibmphp-objs		:=	ibmphp_core.o	\
 acpiphp-objs		:=	acpiphp_core.o	\
 				acpiphp_glue.o
 
+powernv-php-objs	:=	powernv_php.o	\
+				powernv_php_slot.o
+
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	\
 				rpaphp_slot.o
diff --git a/drivers/pci/hotplug/powernv_php.c b/drivers/pci/hotplug/powernv_php.c
new file mode 100644
index 0000000..e36eaf1
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php.c
@@ -0,0 +1,126 @@
+/*
+ * PCI Hotplug Driver for PowerPC PowerNV platform.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2015.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <asm/opal.h>
+#include <asm/pnv-pci.h>
+
+#include "powernv_php.h"
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
+#define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
+
+static int powernv_php_register_one(struct device_node *dn)
+{
+	struct powernv_php_slot *slot;
+	const __be32 *prop32;
+	int ret;
+
+	/* Check if it's hotpluggable slot */
+	prop32 = of_get_property(dn, "ibm,slot-pluggable", NULL);
+	if (!prop32 || !of_read_number(prop32, 1))
+		return 0;
+
+	prop32 = of_get_property(dn, "ibm,reset-by-firmware", NULL);
+	if (!prop32 || !of_read_number(prop32, 1))
+		return 0;
+
+	/* Allocate slot */
+	slot = powernv_php_slot_alloc(dn);
+	if (!slot)
+		return -ENODEV;
+
+	/* Register it */
+	ret = powernv_php_slot_register(slot);
+	if (ret) {
+		powernv_php_slot_put(slot);
+		return ret;
+	}
+
+	return powernv_php_slot_enable(slot->php_slot, false);
+}
+
+int powernv_php_register(struct device_node *dn)
+{
+	struct device_node *child;
+	int ret = 0;
+
+	for_each_child_of_node(dn, child) {
+		ret = powernv_php_register_one(child);
+		if (ret)
+			break;
+
+		powernv_php_register(child);
+	}
+
+	return ret;
+}
+
+static void powernv_php_unregister_one(struct device_node *dn)
+{
+	struct powernv_php_slot *slot;
+
+	slot = powernv_php_slot_find(dn);
+	if (!slot)
+		return;
+
+	pci_hp_deregister(slot->php_slot);
+}
+
+void powernv_php_unregister(struct device_node *dn)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(dn, child) {
+		powernv_php_unregister_one(child);
+		powernv_php_unregister(child);
+	}
+}
+
+static int __init powernv_php_init(void)
+{
+	struct device_node *dn;
+
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	/* Scan PHB nodes and their children */
+	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
+		powernv_php_register(dn);
+	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
+		powernv_php_register(dn);
+
+	return 0;
+}
+
+static void __exit powernv_php_exit(void)
+{
+	struct device_node *dn;
+
+	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
+		powernv_php_unregister(dn);
+	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
+		powernv_php_unregister(dn);
+}
+
+module_init(powernv_php_init);
+module_exit(powernv_php_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/pci/hotplug/powernv_php.h b/drivers/pci/hotplug/powernv_php.h
new file mode 100644
index 0000000..1c2b6f6
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php.h
@@ -0,0 +1,70 @@
+/*
+ * PCI Hotplug Driver for PowerPC PowerNV platform.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2015.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _POWERNV_PHP_H
+#define _POWERNV_PHP_H
+
+/* Slot power status */
+#define POWERNV_PHP_SLOT_POWER_OFF	0
+#define POWERNV_PHP_SLOT_POWER_ON	1
+
+/* Slot presence status */
+#define POWERNV_PHP_SLOT_EMPTY		0
+#define POWERNV_PHP_SLOT_PRESENT	1
+
+/* Slot attention status */
+#define POWERNV_PHP_SLOT_ATTEN_OFF	0
+#define POWERNV_PHP_SLOT_ATTEN_ON	1
+#define POWERNV_PHP_SLOT_ATTEN_IND	2
+#define POWERNV_PHP_SLOT_ATTEN_ACT	3
+
+struct powernv_php_slot {
+	struct kref		kref;
+	int			state;
+#define POWERNV_PHP_SLOT_STATE_INIT		0x0
+#define POWERNV_PHP_SLOT_STATE_REGISTER		0x1
+#define POWERNV_PHP_SLOT_STATE_POPULATED	0x2
+	char			*name;
+	struct device_node	*dn;
+	struct pci_bus		*bus;
+	uint64_t		id;
+	int			slot_no;
+	struct hotplug_slot	*php_slot;
+	struct powernv_php_slot	*parent;
+	void (*release)(struct kref *kref);
+	struct list_head	children;
+	struct list_head	link;
+};
+
+#define to_powernv_php_slot(kref) container_of(kref, struct powernv_php_slot, kref)
+
+static inline void powernv_php_slot_get(struct powernv_php_slot *slot)
+{
+	if (slot)
+		kref_get(&slot->kref);
+}
+
+static inline int powernv_php_slot_put(struct powernv_php_slot *slot)
+{
+	if (slot)
+		return kref_put(&slot->kref, slot->release);
+
+	return 0;
+}
+
+struct powernv_php_slot *powernv_php_slot_find(struct device_node *dn);
+struct powernv_php_slot *powernv_php_slot_alloc(struct device_node *dn);
+int powernv_php_slot_register(struct powernv_php_slot *slot);
+int powernv_php_slot_enable(struct hotplug_slot *php_slot, bool rescan);
+int powernv_php_register(struct device_node *dn);
+void powernv_php_unregister(struct device_node *dn);
+
+#endif /* !_POWERNV_PHP_H */
diff --git a/drivers/pci/hotplug/powernv_php_slot.c b/drivers/pci/hotplug/powernv_php_slot.c
new file mode 100644
index 0000000..84c5c6f
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php_slot.c
@@ -0,0 +1,382 @@
+/*
+ * PCI Hotplug Driver for PowerPC PowerNV platform.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2015.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <asm/opal.h>
+#include <asm/pnv-pci.h>
+
+#include "powernv_php.h"
+
+static LIST_HEAD(php_slot_list);
+static DEFINE_MUTEX(php_slot_mutex);
+
+static int get_power_status(struct hotplug_slot *php_slot, u8 *val)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t state;
+	int ret;
+
+	/* By default, the power is on */
+	*val = POWERNV_PHP_SLOT_POWER_ON;
+
+	/* Retrieve power status from firmware */
+	ret = pnv_pci_get_power_status(slot->id, &state);
+	if (!ret) {
+		*val = state ? POWERNV_PHP_SLOT_POWER_ON :
+			       POWERNV_PHP_SLOT_POWER_OFF;
+		php_slot->info->power_status = *val;
+	}
+
+	return 0;
+}
+
+static int get_adapter_status(struct hotplug_slot *php_slot, u8 *val)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t state;
+	int ret;
+
+	/* By default, the slot is empty */
+	*val = 0;
+
+	/* Retrieve presence status from firmware */
+	ret = pnv_pci_get_presence_status(slot->id, &state);
+	if (ret >= 0) {
+		*val = state ? POWERNV_PHP_SLOT_PRESENT :
+			       POWERNV_PHP_SLOT_EMPTY;
+		php_slot->info->adapter_status = *val;
+	}
+
+	return 0;
+}
+
+static int set_attention_status(struct hotplug_slot *php_slot, u8 val)
+{
+	/*
+	 * The default operation would to turn on
+	 * the attention
+	*/
+	switch (val) {
+	case POWERNV_PHP_SLOT_ATTEN_OFF:
+	case POWERNV_PHP_SLOT_ATTEN_ON:
+	case POWERNV_PHP_SLOT_ATTEN_IND:
+	case POWERNV_PHP_SLOT_ATTEN_ACT:
+		break;
+	default:
+		val = POWERNV_PHP_SLOT_ATTEN_ON;
+	}
+
+	/* FIXME: Make it real once firmware supports it */
+	php_slot->info->attention_status = val;
+
+	return 0;
+}
+
+int powernv_php_slot_enable(struct hotplug_slot *php_slot, bool rescan)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t presence;
+	int ret;
+
+	/* Check if the slot has been configured */
+	if (slot->state != POWERNV_PHP_SLOT_STATE_REGISTER)
+		return 0;
+
+	/* Retrieve slot presence status */
+	ret = php_slot->ops->get_adapter_status(php_slot, &presence);
+	if (ret)
+		return ret;
+
+	switch (presence) {
+	case POWERNV_PHP_SLOT_PRESENT:
+		pci_lock_rescan_remove();
+		pcibios_add_pci_devices(slot->bus);
+		pci_unlock_rescan_remove();
+		slot->state = POWERNV_PHP_SLOT_STATE_POPULATED;
+
+		/* Rescan for child hotpluggable slots */
+		if (rescan)
+			powernv_php_register(slot->dn);
+		break;
+	case POWERNV_PHP_SLOT_EMPTY:
+		break;
+	default:
+		pr_warn("%s: Invalid presence status %d on slot %s\n",
+			__func__, presence, slot->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int enable_slot(struct hotplug_slot *php_slot)
+{
+	return powernv_php_slot_enable(php_slot, true);
+}
+
+static int disable_slot(struct hotplug_slot *php_slot)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+
+	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
+		return 0;
+
+	pci_lock_rescan_remove();
+	pcibios_remove_pci_devices(slot->bus);
+	pci_unlock_rescan_remove();
+	vm_unmap_aliases();
+
+	/* Detach the child hotpluggable slots */
+	powernv_php_unregister(slot->dn);
+
+	/* Update slot state */
+	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
+	return 0;
+}
+
+static struct hotplug_slot_ops php_slot_ops = {
+	.get_power_status	= get_power_status,
+	.get_adapter_status	= get_adapter_status,
+	.set_attention_status	= set_attention_status,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+};
+
+static struct powernv_php_slot *php_slot_match(struct device_node *dn,
+					       struct powernv_php_slot *slot)
+{
+	struct powernv_php_slot *target, *tmp;
+
+	if (slot->dn == dn)
+		return slot;
+
+	list_for_each_entry(tmp, &slot->children, link) {
+		target = php_slot_match(dn, tmp);
+		if (target)
+			return target;
+	}
+
+	return NULL;
+}
+
+struct powernv_php_slot *powernv_php_slot_find(struct device_node *dn)
+{
+	struct powernv_php_slot *slot, *tmp;
+
+	mutex_lock(&php_slot_mutex);
+	list_for_each_entry(tmp, &php_slot_list, link) {
+		slot = php_slot_match(dn, tmp);
+		if (slot) {
+			mutex_unlock(&php_slot_mutex);
+			return slot;
+		}
+	}
+	mutex_unlock(&php_slot_mutex);
+
+	return NULL;
+}
+
+static void php_slot_free(struct kref *kref)
+{
+	struct powernv_php_slot *slot = to_powernv_php_slot(kref);
+
+	WARN_ON(!list_empty(&slot->children));
+	kfree(slot->name);
+	kfree(slot);
+}
+
+static void php_slot_release(struct hotplug_slot *hp_slot)
+{
+	struct powernv_php_slot *slot = hp_slot->private;
+
+	/* Remove from global or child list */
+	mutex_lock(&php_slot_mutex);
+	list_del(&slot->link);
+	mutex_unlock(&php_slot_mutex);
+
+	/* Detach from parent */
+	powernv_php_slot_put(slot);
+	powernv_php_slot_put(slot->parent);
+}
+
+static bool php_slot_get_id(struct device_node *dn,
+			    uint64_t *id)
+{
+	struct device_node *parent = dn;
+	const __be64 *prop64;
+	const __be32 *prop32;
+
+	/*
+	 * The hotpluggable slot always has a compound Id, which
+	 * consists of 16-bits PHB Id, 16 bits bus/slot/function
+	 * number, and compound indicator
+	 */
+	*id = (0x1ul << 63);
+
+	/* Bus/Slot/Function number */
+	prop32 = of_get_property(dn, "reg", NULL);
+	if (!prop32)
+		return false;
+	*id |= ((of_read_number(prop32, 1) & 0x00ffff00) << 16);
+
+	/* PHB Id */
+	while ((parent = of_get_parent(parent))) {
+		if (!PCI_DN(parent)) {
+			of_node_put(parent);
+			break;
+		}
+
+		if (!of_device_is_compatible(parent, "ibm,ioda2-phb") &&
+		    !of_device_is_compatible(parent, "ibm,ioda-phb")) {
+			of_node_put(parent);
+			continue;
+		}
+
+		prop64 = of_get_property(parent, "ibm,opal-phbid", NULL);
+		if (!prop64) {
+			of_node_put(parent);
+			return false;
+		}
+
+		*id |= be64_to_cpup(prop64);
+		of_node_put(parent);
+		return true;
+	}
+
+        return false;
+}
+
+struct powernv_php_slot *powernv_php_slot_alloc(struct device_node *dn)
+{
+	struct pci_bus *bus;
+	struct powernv_php_slot *slot;
+	const char *label;
+	uint64_t id;
+	int slot_no;
+	size_t size;
+	void *pmem;
+
+	/* Slot name */
+	label = of_get_property(dn, "ibm,slot-label", NULL);
+	if (!label)
+		return NULL;
+
+	/* Slot indentifier */
+	if (!php_slot_get_id(dn, &id))
+		return NULL;
+
+	/* PCI bus */
+	bus = pcibios_find_pci_bus(dn);
+	if (!bus)
+		return NULL;
+
+	/* Slot number */
+	if (dn->child && PCI_DN(dn->child))
+		slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
+	else
+		slot_no = -1;
+
+	/* Allocate slot */
+	size = sizeof(struct powernv_php_slot) +
+	       sizeof(struct hotplug_slot) +
+	       sizeof(struct hotplug_slot_info);
+	pmem = kzalloc(size, GFP_KERNEL);
+	if (!pmem) {
+		pr_warn("%s: Cannot allocate slot for node %s\n",
+			__func__, dn->full_name);
+		return NULL;
+	}
+
+	/* Assign memory blocks */
+	slot = pmem;
+	slot->php_slot = pmem + sizeof(struct powernv_php_slot);
+	slot->php_slot->info = pmem + sizeof(struct powernv_php_slot) +
+			      sizeof(struct hotplug_slot);
+	slot->name = kstrdup(label, GFP_KERNEL);
+	if (!slot->name) {
+		pr_warn("%s: Cannot populate name for node %s\n",
+			__func__, dn->full_name);
+		kfree(pmem);
+		return NULL;
+	}
+
+	/* Initialize slot */
+	kref_init(&slot->kref);
+	slot->state = POWERNV_PHP_SLOT_STATE_INIT;
+	slot->dn = dn;
+	slot->bus = bus;
+	slot->id = id;
+	slot->slot_no = slot_no;
+	slot->release = php_slot_free;
+	slot->php_slot->ops = &php_slot_ops;
+	slot->php_slot->release = php_slot_release;
+	slot->php_slot->private = slot;
+	INIT_LIST_HEAD(&slot->children);
+	INIT_LIST_HEAD(&slot->link);
+
+	return slot;
+}
+
+int powernv_php_slot_register(struct powernv_php_slot *slot)
+{
+	struct powernv_php_slot *parent;
+	struct device_node *dn = slot->dn;
+	int ret;
+
+	/* Avoid register same slot for twice */
+	if (powernv_php_slot_find(slot->dn))
+		return -EEXIST;
+
+	/* Register slot */
+	ret = pci_hp_register(slot->php_slot, slot->bus,
+			      slot->slot_no, slot->name);
+	if (ret) {
+		pr_warn("%s: Cannot register slot %s (%d)\n",
+			__func__, slot->name, ret);
+		return ret;
+	}
+
+	/* Put into global or parent list */
+	while ((dn = of_get_parent(dn))) {
+		if (!PCI_DN(dn)) {
+			of_node_put(dn);
+			break;
+		}
+
+		parent = powernv_php_slot_find(dn);
+		if (parent) {
+			of_node_put(dn);
+			break;
+		}
+	}
+
+	mutex_lock(&php_slot_mutex);
+	if (parent) {
+		powernv_php_slot_get(parent);
+		slot->parent = parent;
+		list_add_tail(&slot->link, &parent->children);
+	} else {
+		list_add_tail(&slot->link, &php_slot_list);
+	}
+	mutex_unlock(&php_slot_mutex);
+
+	/* Update slot state */
+	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
+	return 0;
+}
-- 
1.8.3.2
