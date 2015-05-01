Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07C621A0FE0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 16:04:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3B2D03578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4164Oan51904676
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4163wVX009614
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:03:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 21/21] pci/hotplug: PowerPC PowerNV PCI hotplug driver
Date: Fri,  1 May 2015 16:03:08 +1000
Message-Id: <1430460188-31343-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 drivers/pci/hotplug/Kconfig            |  12 +
 drivers/pci/hotplug/Makefile           |   4 +
 drivers/pci/hotplug/powernv_php.c      | 146 ++++++++
 drivers/pci/hotplug/powernv_php.h      |  78 ++++
 drivers/pci/hotplug/powernv_php_slot.c | 643 +++++++++++++++++++++++++++++++++
 5 files changed, 883 insertions(+)
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
index 0000000..5cf9e717
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php.c
@@ -0,0 +1,146 @@
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
+static struct notifier_block php_msg_nb = {
+	.notifier_call	= powernv_php_msg_handler,
+	.next		= NULL,
+	.priority	= 0,
+};
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
+	return powernv_php_slot_enable(slot->php_slot, false, false);
+}
+
+int powernv_php_register(struct device_node *dn)
+{
+	struct device_node *child;
+	int ret = 0;
+
+	/*
+	 * The parent slots should be registered before their
+	 * child slots.
+	 */
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
+	/* The child slots should go before their parent slots */
+	for_each_child_of_node(dn, child) {
+		powernv_php_unregister(child);
+		powernv_php_unregister_one(child);
+	}
+}
+
+static int __init powernv_php_init(void)
+{
+	struct device_node *dn;
+
+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	/* Register hotplug message handler */
+	if (pnv_pci_hotplug_notifier(&php_msg_nb, true)) {
+		pr_warn("%s: Cannot register hotplug message notifier\n",
+			__func__);
+		return -EIO;
+	}
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
+	pnv_pci_hotplug_notifier(&php_msg_nb, false);
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
index 0000000..87ba0d0
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php.h
@@ -0,0 +1,78 @@
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
+	int			check_power_status;
+	int			status_confirmed;
+	struct opal_msg		*msg;
+	struct work_struct	work;
+	wait_queue_head_t	queue;
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
+int powernv_php_msg_handler(struct notifier_block *nb,
+			    unsigned long type, void *message);
+struct powernv_php_slot *powernv_php_slot_find(struct device_node *dn);
+struct powernv_php_slot *powernv_php_slot_alloc(struct device_node *dn);
+int powernv_php_slot_register(struct powernv_php_slot *slot);
+int powernv_php_slot_enable(struct hotplug_slot *php_slot,
+			    bool rescan_bus, bool rescan_slot);
+int powernv_php_register(struct device_node *dn);
+void powernv_php_unregister(struct device_node *dn);
+
+#endif /* !_POWERNV_PHP_H */
diff --git a/drivers/pci/hotplug/powernv_php_slot.c b/drivers/pci/hotplug/powernv_php_slot.c
new file mode 100644
index 0000000..fc82355
--- /dev/null
+++ b/drivers/pci/hotplug/powernv_php_slot.c
@@ -0,0 +1,643 @@
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
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <asm/opal.h>
+#include <asm/pnv-pci.h>
+#include <asm/ppc-pci.h>
+
+#include "powernv_php.h"
+
+static LIST_HEAD(php_slot_list);
+static DEFINE_SPINLOCK(php_slot_lock);
+
+/*
+ * Release firmware data for all child device nodes of the
+ * indicated one.
+ */
+static void release_device_nodes_info(struct device_node *np)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(np, child) {
+		/* In depth first */
+		release_device_nodes_info(child);
+
+		remove_pci_device_node_info(child);
+	}
+}
+
+/*
+ * Release all subordinate device nodes of the indicated one.
+ * Those device nodes in deepest path should be released firstly.
+ */
+static int release_device_nodes(struct device_node *parent)
+{
+	struct device_node *np, *child;
+	int ret = 0;
+
+	/* If the device node has children, remove them firstly */
+	for_each_child_of_node(parent, np) {
+		ret = release_device_nodes(np);
+		if (ret)
+			return ret;
+
+		/* The device shouldn't have alive children */
+		child = of_get_next_child(np, NULL);
+		if (child) {
+			of_node_put(child);
+			of_node_put(np);
+			pr_err("%s: Alive children of node <%s>\n",
+			       __func__, of_node_full_name(np));
+			return -EBUSY;
+		}
+
+		/* Detach the device node */
+		of_detach_node(np);
+		of_node_put(np);
+	}
+
+	return 0;
+}
+
+/*
+ * The function processes the message sent by firmware
+ * to remove all device tree nodes beneath the slot's
+ * nodes, and the associated auxillary data.
+ */
+static void slot_power_off_handler(struct powernv_php_slot *slot)
+{
+	int ret;
+
+	/* Release the firmware data for the child device nodes */
+	release_device_nodes_info(slot->dn);
+
+	/* Release the child device nodes */
+	ret = release_device_nodes(slot->dn);
+	if (ret)
+		pr_warn("%s: Error %d releasing children of <%s>\n",
+			__func__, ret, of_node_full_name(slot->dn));
+
+	/* Confirm status change */
+	slot->status_confirmed = 1;
+	wake_up_interruptible(&slot->queue);
+}
+
+static void slot_power_on_handler(struct powernv_php_slot *slot)
+{
+	struct opal_msg *msg = slot->msg;
+	unsigned long phys = be64_to_cpu(msg->params[2]);
+	unsigned long len = be64_to_cpu(msg->params[3]);
+	void *blob = (phys && len > 0) ? __va(phys) : NULL;
+
+	/* There might have nothing behind the slot yet */
+	if (!blob || !len)
+		goto out;
+
+	/* Copy the FDT blob and parse it */
+	of_fdt_add_subtree(slot->dn, blob);
+
+	/* Add device node firmware data */
+	traverse_pci_device_nodes(slot->dn,
+				  add_pci_device_node_info,
+				  pci_bus_to_host(slot->bus));
+
+out:
+	/* Confirm status change */
+	slot->status_confirmed = 1;
+	wake_up_interruptible(&slot->queue);
+}
+
+static void powernv_php_slot_work(struct work_struct *data)
+{
+	struct powernv_php_slot *slot = container_of(data,
+						     struct powernv_php_slot,
+						     work);
+	uint64_t php_event = be64_to_cpu(slot->msg->params[0]);
+
+	switch (php_event) {
+	case 0: /* Slot power off */
+		slot_power_off_handler(slot);
+		break;
+	case 1: /* Slot power on */
+		slot_power_on_handler(slot);
+		break;
+	default:
+		pr_warn("%s: Unsupported hotplug event %lld\n",
+			__func__, php_event);
+	}
+
+	of_node_put(slot->dn);
+}
+
+int powernv_php_msg_handler(struct notifier_block *nb,
+			    unsigned long type, void *message)
+{
+	phandle h;
+	struct device_node *np;
+	struct powernv_php_slot *slot;
+	struct opal_msg *msg = message;
+
+	/* Check the message type */
+	if (type != OPAL_MSG_PCI_HOTPLUG) {
+		pr_warn("%s: Wrong message type %ld received!\n",
+			__func__, type);
+		return 0;
+	}
+
+	/* Find the device node */
+	h = (phandle)be64_to_cpu(msg->params[1]);
+	np = of_find_node_by_phandle(h);
+	if (!np) {
+		pr_warn("%s: No device node for phandle 0x%08x\n",
+			__func__, h);
+		return 0;
+	}
+
+	/* Find the slot */
+	slot = powernv_php_slot_find(np);
+	if (!slot) {
+		pr_warn("%s: No slot found for node <%s>\n",
+			__func__, of_node_full_name(np));
+		of_node_put(np);
+		return 0;
+	}
+
+	/* Schedule the work */
+	slot->msg = msg;
+	schedule_work(&slot->work);
+	return 0;
+}
+
+static int set_power_status(struct hotplug_slot *php_slot, u8 val)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	int ret;
+
+	/* Set power status */
+	slot->status_confirmed = 0;
+	ret = pnv_pci_set_power_status(slot->id, val);
+	if (ret) {
+		pr_warn("%s: Error %d powering %s slot %016llx\n",
+			__func__, ret, val ? "on" : "off", slot->id);
+		return ret;
+	}
+
+	/* Waiting until the device tree is updated */
+	ret = wait_event_timeout(slot->queue,
+				 !slot->status_confirmed,
+				 10 * HZ);
+	if (ret) {
+		pr_warn("%s: Error %d completing power-%s slot %016llx\n",
+			__func__, ret, val ? "on" : "off", slot->id);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int get_power_status(struct hotplug_slot *php_slot, u8 *val)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t state;
+	int ret;
+
+	/*
+	 * Retrieve power status from firmware. If we fail
+	 * getting that, the power status fails back to
+	 * be on.
+	 */
+	ret = pnv_pci_get_power_status(slot->id, &state);
+	if (ret) {
+		*val = POWERNV_PHP_SLOT_POWER_ON;
+		pr_warn("%s: Error %d getting power status of slot %016llx\n",
+			__func__, ret, slot->id);
+	} else {
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
+	/*
+	 * Retrieve presence status from firmware. If we can't
+	 * get that, it will fail back to be empty.
+	 */
+	ret = pnv_pci_get_presence_status(slot->id, &state);
+	if (ret >= 0) {
+                *val = state ? POWERNV_PHP_SLOT_PRESENT :
+                               POWERNV_PHP_SLOT_EMPTY;
+                php_slot->info->adapter_status = *val;
+	} else {
+		*val = POWERNV_PHP_SLOT_EMPTY;
+		pr_warn("%s: Error %d getting presence of slot %016llx\n",
+			__func__, ret, slot->id);
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static int set_attention_status(struct hotplug_slot *php_slot, u8 val)
+{
+	/* The default operation would to turn on the attention */
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
+int powernv_php_slot_enable(struct hotplug_slot *php_slot,
+			    bool rescan_bus, bool rescan_slot)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t presence, power_status;
+	int ret;
+
+	/* Check if the slot has been configured */
+	if (slot->state != POWERNV_PHP_SLOT_STATE_REGISTER)
+		return 0;
+
+	/* Retrieve slot presence status */
+	ret = php_slot->ops->get_adapter_status(php_slot, &presence);
+	if (ret) {
+		pr_warn("%s: Error %d getting presence of slot %016llx\n",
+			__func__, ret, slot->id);
+		return ret;
+	}
+
+	/* Proceed if there have nothing behind the slot */
+	if (presence == POWERNV_PHP_SLOT_EMPTY)
+		goto scan;
+
+	/*
+	 * If we don't detect something behind the slot, we need
+	 * make sure the power suply to the slot is on. Otherwise,
+	 * the slot downstream PCIe linkturn should be down.
+	 *
+	 * On the first time, we don't change the power status to
+	 * boost system boot with assumption that the firmware
+	 * supplies consistent slot power status: empty slot always
+	 * has its power off and non-empty slot has its power on.
+	 */
+	if (!slot->check_power_status) {
+		slot->check_power_status = 1;
+		goto scan;
+	}
+
+	/* Check the power status. Scan the slot if that's already on */
+	ret = php_slot->ops->get_power_status(php_slot, &power_status);
+	if (ret) {
+		pr_warn("%s: Error %d getting power status of slot %016llx\n",
+			__func__, ret, slot->id);
+		return ret;
+	}
+	if (power_status == POWERNV_PHP_SLOT_POWER_ON)
+		goto scan;
+
+	/* Power is off, turn it on and then scan the slot */
+	ret = set_power_status(php_slot, POWERNV_PHP_SLOT_POWER_ON);
+	if (ret) {
+		pr_warn("%s: Error %d powering on slot %016llx\n",
+			__func__, ret, slot->id);
+		return ret;
+	}
+
+scan:
+	switch (presence) {
+	case POWERNV_PHP_SLOT_PRESENT:
+		if (rescan_bus) {
+			pci_lock_rescan_remove();
+			pcibios_add_pci_devices(slot->bus);
+			pci_unlock_rescan_remove();
+		}
+
+		/* Rescan for child hotpluggable slots */
+		slot->state = POWERNV_PHP_SLOT_STATE_POPULATED;
+		if (rescan_slot)
+			powernv_php_register(slot->dn);
+		break;
+	case POWERNV_PHP_SLOT_EMPTY:
+		slot->state = POWERNV_PHP_SLOT_STATE_POPULATED;
+		break;
+	default:
+		pr_warn("%s: Invalid presence status %d of slot %016llx\n",
+			__func__, presence, slot->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int enable_slot(struct hotplug_slot *php_slot)
+{
+	return powernv_php_slot_enable(php_slot, true, true);
+}
+
+static int disable_slot(struct hotplug_slot *php_slot)
+{
+	struct powernv_php_slot *slot = php_slot->private;
+	uint8_t power_status;
+	int ret;
+
+	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
+		return 0;
+
+	/* Remove all devices behind the slot */
+	pci_lock_rescan_remove();
+	pcibios_remove_pci_devices(slot->bus);
+	pci_unlock_rescan_remove();
+
+	/* Detach the child hotpluggable slots */
+	powernv_php_unregister(slot->dn);
+
+	/*
+	 * Check the power status and turn it off if necessary. If we
+	 * fail to get the power status, the power will be forced to
+	 * be off.
+	 */
+	ret = php_slot->ops->get_power_status(php_slot, &power_status);
+	if (ret || power_status == POWERNV_PHP_SLOT_POWER_ON) {
+		ret = set_power_status(php_slot, POWERNV_PHP_SLOT_POWER_OFF);
+		if (ret)
+			pr_warn("%s: Error %d powering off slot %016llx\n",
+				__func__, ret, slot->id);
+	}
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&php_slot_lock, flags);
+	list_for_each_entry(tmp, &php_slot_list, link) {
+		slot = php_slot_match(dn, tmp);
+		if (slot) {
+			spin_unlock_irqrestore(&php_slot_lock, flags);
+			return slot;
+		}
+	}
+	spin_unlock_irqrestore(&php_slot_lock, flags);
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
+	unsigned long flags;
+
+	/* Remove from global or child list */
+	spin_lock_irqsave(&php_slot_lock, flags);
+	list_del(&slot->link);
+	spin_unlock_irqrestore(&php_slot_lock, flags);
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
+	*id |= ((of_read_number(prop32, 1) & 0x00ffff00) << 8);
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
+	INIT_WORK(&slot->work, powernv_php_slot_work);
+	init_waitqueue_head(&slot->queue);
+	slot->check_power_status = 0;
+	slot->status_confirmed = 0;
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
+	unsigned long flags;
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
+	spin_lock_irqsave(&php_slot_lock, flags);
+	if (parent) {
+		powernv_php_slot_get(parent);
+		slot->parent = parent;
+		list_add_tail(&slot->link, &parent->children);
+	} else {
+		list_add_tail(&slot->link, &php_slot_list);
+	}
+	spin_unlock_irqrestore(&php_slot_lock, flags);
+
+	/* Update slot state */
+	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
+	return 0;
+}
-- 
2.1.0
