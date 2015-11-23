Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DB0F1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:17:27 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 09:17:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D90402BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:17:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANNHF1w55377952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:17:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANNGos1004995
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:16:51 +1100
Date: Tue, 24 Nov 2015 10:16:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 50/50] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
Message-ID: <20151123231626.GA13689@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-51-git-send-email-gwshan@linux.vnet.ibm.com>
 <564C29B4.3060906@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564C29B4.3060906@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2015 at 06:33:08PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>This adds standalone driver to support PCI hotplug for PowerPC PowerNV
>>platform that runs on top of skiboot firmware. The firmware identifies
>>hotpluggable slots and marked their device tree node with proper
>>"ibm,slot-pluggable" and "ibm,reset-by-firmware". The driver scans device
>>tree nodes to create/register PCI hotplug slot accordingly.
>>
>>If the skiboot firmware doesn't support slot status retrieval, the PCI
>>slot device node shouldn't have property "ibm,reset-by-firmware". In
>>that case, none of valid PCI slots will be detected from device tree.
>>The skiboot firmware doesn't export the capability to access attention
>>LEDs yet and it's something for TBD.
>
>
>Few words what we are actually dealing with and how children slots can be
>hotplugged to parent slots?
>

Sure, will do. All comments you gave will be reflected in next revision.
Please let me know if you finish the review and I can start the respin
for next revision.

>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>---
>>  MAINTAINERS                   |   6 +
>>  drivers/pci/hotplug/Kconfig   |  12 +
>>  drivers/pci/hotplug/Makefile  |   3 +
>>  drivers/pci/hotplug/pnv_php.c | 866 ++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 887 insertions(+)
>>  create mode 100644 drivers/pci/hotplug/pnv_php.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 9f6685f..10088f1 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -7931,6 +7931,12 @@ L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/PCI/pci-error-recovery.txt
>>
>>+PCI HOTPLUG DRIVER FOR POWERNV PLATFORM
>>+M:	Gavin Shan <gwshan@linux.vnet.ibm.com>
>>+L:	linux-pci@vger.kernel.org
>>+S:	Supported
>>+F:	drivers/pci/hotplug/pnv_php.c
>>+
>>  PCI SUBSYSTEM
>>  M:	Bjorn Helgaas <bhelgaas@google.com>
>>  L:	linux-pci@vger.kernel.org
>>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>>index df8caec..167c8ce 100644
>>--- a/drivers/pci/hotplug/Kconfig
>>+++ b/drivers/pci/hotplug/Kconfig
>>@@ -113,6 +113,18 @@ config HOTPLUG_PCI_SHPC
>>
>>  	  When in doubt, say N.
>>
>>+config HOTPLUG_PCI_POWERNV
>>+	tristate "PowerPC PowerNV PCI Hotplug driver"
>>+	depends on PPC_POWERNV && EEH
>>+	help
>>+	  Say Y here if you run PowerPC PowerNV platform that supports
>>+	  PCI Hotplug
>>+
>>+	  To compile this driver as a module, choose M here: the
>>+	  module will be called pnv-php.
>>+
>>+	  When in doubt, say N.
>>+
>>  config HOTPLUG_PCI_RPA
>>  	tristate "RPA PCI Hotplug driver"
>>  	depends on PPC_PSERIES && EEH
>>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>index b616e75..e33cdda 100644
>>--- a/drivers/pci/hotplug/Makefile
>>+++ b/drivers/pci/hotplug/Makefile
>>@@ -14,6 +14,7 @@ obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
>>  obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
>>  obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
>>+obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= pnv-php.o
>>  obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>>  obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
>>@@ -50,6 +51,8 @@ ibmphp-objs		:=	ibmphp_core.o	\
>>  acpiphp-objs		:=	acpiphp_core.o	\
>>  				acpiphp_glue.o
>>
>>+pnv-php-objs		:=	pnv_php.o
>>+
>>  rpaphp-objs		:=	rpaphp_core.o	\
>>  				rpaphp_pci.o	\
>>  				rpaphp_slot.o
>>diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>>new file mode 100644
>>index 0000000..415e9b9
>>--- /dev/null
>>+++ b/drivers/pci/hotplug/pnv_php.c
>>@@ -0,0 +1,866 @@
>>+/*
>>+ * PCI Hotplug Driver for PowerPC PowerNV platform.
>>+ *
>>+ * Copyright Gavin Shan, IBM Corporation 2015.
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License as published by
>>+ * the Free Software Foundation; either version 2 of the License, or
>>+ * (at your option) any later version.
>>+ */
>>+
>>+#include <linux/pci.h>
>>+#include <linux/pci_hotplug.h>
>>+#include <linux/module.h>
>>+
>>+#include <asm/opal.h>
>>+#include <asm/pnv-pci.h>
>>+#include <asm/ppc-pci.h>
>>+
>>+#define DRIVER_VERSION	"0.1"
>>+#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
>>+#define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
>>+
>>+struct pnv_php_slot {
>>+	struct hotplug_slot		php_slot;
>>+	struct hotplug_slot_info	php_slot_info;
>>+	uint64_t			id;
>>+	char				*name;
>>+	int				slot_no;
>>+	struct kref			kref;
>>+	int				state;
>>+#define PNV_PHP_STATE_INIT		0
>
>INITIALIZED
>
>>+#define PNV_PHP_STATE_REGISTER		1
>
>REGISTERED
>
>
>>+#define PNV_PHP_STATE_POPULATED		2
>
>This one has "ed" already :)
>
>And usually definitions go before the variable which uses them.
>
>>+	struct device_node		*dn;
>>+	struct pci_dev			*pdev;
>>+	struct pci_bus			*bus;
>>+	bool				power_state_check;
>>+	int				power_state_confirmed;
>>+#define PNV_PHP_POWER_CONFIRMED_INVALID	0
>>+#define PNV_PHP_POWER_CONFIRMED_SUCCESS	1
>>+#define PNV_PHP_POWER_CONFIRMED_FAIL	2
>>+	struct opal_msg			*msg;
>>+	void				*fdt;
>>+	void				*dt;
>>+	struct of_changeset		ocs;
>>+	struct work_struct		work;
>>+	wait_queue_head_t		queue;
>>+	struct pnv_php_slot		*parent;
>>+	struct list_head		children;
>>+	struct list_head		link;
>>+};
>>+
>>+static LIST_HEAD(pnv_php_slot_list);
>>+static DEFINE_SPINLOCK(pnv_php_lock);
>>+
>>+static void pnv_php_register(struct device_node *dn);
>>+static void pnv_php_unregister_one(struct device_node *dn);
>>+static void pnv_php_unregister(struct device_node *dn);
>>+
>>+static inline struct pnv_php_slot *pnv_php_get_slot(struct pnv_php_slot *slot)
>>+{
>>+	if (slot) {
>>+		kref_get(&slot->kref);
>>+		return slot;
>>+	}
>>+
>>+	return NULL;
>>+}
>>+
>>+static void pnv_php_free_slot(struct kref *kref)
>>+{
>>+	struct pnv_php_slot *slot = container_of(kref,
>>+						 struct pnv_php_slot,
>>+						 kref);
>>+
>>+	WARN_ON(!list_empty(&slot->children));
>>+	kfree(slot->name);
>>+	kfree(slot);
>>+}
>>+
>>+static inline void pnv_php_put_slot(struct pnv_php_slot *slot)
>>+{
>>+	if (!slot)
>>+		return;
>>+
>>+	kref_put(&slot->kref, pnv_php_free_slot);
>>+}
>>+
>>+static struct pnv_php_slot *pnv_php_match(struct device_node *dn,
>>+					  struct pnv_php_slot *slot)
>>+{
>>+	struct pnv_php_slot *target, *tmp;
>>+
>>+	if (slot->dn == dn)
>>+		return pnv_php_get_slot(slot);
>>+
>>+	list_for_each_entry(tmp, &slot->children, link) {
>>+		target = pnv_php_match(dn, tmp);
>>+		if (target)
>>+			return target;
>>+	}
>>+
>>+	return NULL;
>>+}
>>+
>>+static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
>>+{
>>+	struct pnv_php_slot *slot, *tmp;
>>+	unsigned long flags;
>>+
>>+	spin_lock_irqsave(&pnv_php_lock, flags);
>>+	list_for_each_entry(tmp, &pnv_php_slot_list, link) {
>>+		slot = pnv_php_match(dn, tmp);
>>+		if (slot) {
>>+			spin_unlock_irqrestore(&pnv_php_lock, flags);
>>+			return slot;
>>+		}
>>+	}
>>+	spin_unlock_irqrestore(&pnv_php_lock, flags);
>>+
>>+	return NULL;
>>+}
>>+
>>+/*
>>+ * Remove pdn for all children of the indicated device node.
>>+ * The function should remove pdn in a depth-first manner.
>>+ */
>>+static void pnv_php_rmv_pdns(struct device_node *dn)
>>+{
>>+	struct device_node *child;
>>+
>>+	for_each_child_of_node(dn, child) {
>>+		pnv_php_rmv_pdns(child);
>>+
>>+		pci_remove_device_node_info(child);
>>+	}
>>+}
>>+
>>+/*
>>+ * Remove all child nodes of the indicated device nodes. The
>>+ * function should remove device nodes in depth-first manner.
>>+ */
>>+static int pnv_php_rmv_device_nodes(struct device_node *parent)
>>+{
>>+	struct device_node *dn, *child;
>>+	int ret = 0;
>>+
>>+	for_each_child_of_node(parent, dn) {
>>+		ret = pnv_php_rmv_device_nodes(dn);
>>+		if (ret)
>>+			return ret;
>>+
>>+		child = of_get_next_child(dn, NULL);
>>+		if (child) {
>>+			of_node_put(child);
>>+			of_node_put(dn);
>>+			pr_err("%s: Alive children of node <%s>\n",
>>+			       __func__, of_node_full_name(dn));
>>+			return -EBUSY;
>>+		}
>>+
>>+		of_detach_node(dn);
>>+		of_node_put(dn);
>>+	}
>
>
>This loop iterates just once, is this correct? If so, then a loop is not
>needed here...
>
>
>>+
>>+	return 0;
>>+}
>>+
>>+/*
>>+ * The function processes the message sent by firmware
>>+ * to remove all device tree nodes beneath the slot's
>>+ * nodes and the associated auxiliary data.
>>+ */
>>+static void pnv_php_handle_poweroff(struct pnv_php_slot *slot)
>>+{
>>+	int ret;
>>+
>>+	pnv_php_rmv_pdns(slot->dn);
>>+
>>+	/*
>>+	 * If the device sub-tree was created from OF changeset, simply
>>+	 * to revert that. Otherwise, the device nodes in the sub-tree
>>+	 * need to be iterated and detached.
>>+	 */
>>+	if (slot->fdt) {
>>+		of_changeset_destroy(&slot->ocs);
>>+		kfree(slot->dt);
>>+		kfree(slot->fdt);
>>+		slot->dt = NULL;
>>+		slot->dn->child = NULL;
>>+		slot->fdt = NULL;
>>+		slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_SUCCESS;
>>+		goto confirm;
>>+	}
>
>} else {
>
>>+
>>+	ret = pnv_php_rmv_device_nodes(slot->dn);
>>+	if (!ret) {
>>+		slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_SUCCESS;
>>+	} else {
>>+		slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_FAIL;
>>+		dev_warn(&slot->pdev->dev, "Error %d freeing nodes\n",
>>+			 ret);
>
>Could be one line :)
>
>
>>+	}
>>+
>
>}
>and remove the label below?
>
>
>>+confirm:
>
>
>>+	wake_up_interruptible(&slot->queue);
>>+}
>>+
>>+static int pnv_php_populate_changeset(struct of_changeset *ocs,
>>+				      struct device_node *dn)
>>+{
>>+	struct device_node *child;
>>+	int ret = 0;
>>+
>>+	for_each_child_of_node(dn, child) {
>>+		ret = of_changeset_attach_node(ocs, child);
>>+		if (ret)
>>+			return ret;
>>+
>>+		ret = pnv_php_populate_changeset(ocs, child);
>
>if (ret) break; may be?
>
>
>>+	}
>>+
>>+	return ret;
>>+}
>>+
>>+static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
>>+{
>>+	struct pci_controller *hose = (struct pci_controller *)data;
>>+	struct pci_dn *pdn;
>>+
>>+	pdn = pci_add_device_node_info(hose, dn);
>>+	if (!pdn)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	return NULL;
>>+}
>>+
>>+static void pnv_php_add_pdns(struct pnv_php_slot *slot)
>>+{
>>+	struct pci_controller *hose = pci_bus_to_host(slot->bus);
>>+
>>+	pci_traverse_device_nodes(slot->dn, pnv_php_add_one_pdn, hose);
>>+}
>>+
>>+static void pnv_php_handle_poweron(struct pnv_php_slot *slot)
>>+{
>>+	void *fdt, *dt;
>>+	uint64_t len;
>>+	int confirm = PNV_PHP_POWER_CONFIRMED_SUCCESS;
>>+	int ret;
>>+
>>+	/* We don't know the FDT blob size. It tries with incremental
>>+	 * sized memory chunk.
>>+	 */
>>+	for (len = 0x2000; len <= 0x10000; len += 0x2000) {
>>+		fdt = kzalloc(len, GFP_KERNEL);
>>+		if (!fdt)
>>+			break;
>>+
>>+		ret = pnv_pci_get_device_tree(slot->dn->phandle, fdt, len);
>>+		if (!ret)
>>+			break;
>>+
>>+		kfree(fdt);
>>+	}
>>+
>>+	if (len > 0x10000) {
>>+		dev_warn(&slot->pdev->dev, "Cannot alloc FDT blob\n");
>>+		goto out;
>
>This seems like an error but slot->power_state_confirmed will be set to
>PNV_PHP_POWER_CONFIRMED_SUCCESS anyway, is that correct?
>
>
>>+	}
>
>I'd redo the chunk above like this:
>
>fdt1 = kzalloc(0x10000);
>if (!fdt1)
>	goto out;
>ret = pnv_pci_get_device_tree(slot->dn->phandle, fdt1, 0x10000);
>if (!ret)
>	goto out;
>fdt = kzalloc(fdt_totalsize(fdt1));
>if (!fdt)
>	goto out;
>memcpy(fdt, fdt1, fdt_totalsize(fdt1));
>kfree(fdt1);
>
>
>This way you end up using less memory after setup has completed.
>
>And what is an usual size of the returned blob?
>
>
>>+
>>+	/* Unflatten device tree blob */
>>+	dt = of_fdt_unflatten_tree(fdt, slot->dn, NULL);
>>+	if (!dt) {
>>+		dev_warn(&slot->pdev->dev, "Cannot unflatten FDT\n");
>>+		goto free_fdt;
>>+	}
>>+
>>+	/* Initialize and apply the changeset */
>>+	of_changeset_init(&slot->ocs);
>>+	ret = pnv_php_populate_changeset(&slot->ocs, slot->dn);
>>+	if (ret) {
>>+		dev_warn(&slot->pdev->dev, "Error %d populating changeset\n",
>>+			 ret);
>>+		goto free_dt;
>>+	}
>>+
>>+	slot->dn->child = NULL;
>>+	ret = of_changeset_apply(&slot->ocs);
>>+	if (ret) {
>>+		dev_warn(&slot->pdev->dev, "Error %d applying changeset\n",
>>+			 ret);
>>+		goto destroy_changeset;
>>+	}
>>+
>>+	/* Add device node firmware data */
>>+	pnv_php_add_pdns(slot);
>>+	slot->fdt = fdt;
>>+	slot->dt = dt;
>>+	goto out;
>>+
>>+destroy_changeset:
>>+	of_changeset_destroy(&slot->ocs);
>>+free_dt:
>>+	kfree(dt);
>>+	slot->dn->child = NULL;
>>+free_fdt:
>>+	kfree(fdt);
>>+	confirm = PNV_PHP_POWER_CONFIRMED_FAIL;
>>+out:
>>+	/* Confirm status change */
>>+	slot->power_state_confirmed = confirm;
>>+	wake_up_interruptible(&slot->queue);
>>+}
>>+
>>+static void pnv_php_work(struct work_struct *data)
>>+{
>>+	struct pnv_php_slot *slot = container_of(data,
>>+						 struct pnv_php_slot, work);
>>+	uint64_t event = be64_to_cpu(slot->msg->params[0]);
>>+
>>+	if (event == OPAL_PCI_SLOT_POWER_OFF)
>>+		pnv_php_handle_poweroff(slot);
>>+	else
>>+		pnv_php_handle_poweron(slot);
>>+
>>+	pnv_php_put_slot(slot);
>>+}
>>+
>>+static int pnv_php_handle_msg(struct notifier_block *nb,
>>+			      unsigned long type,
>>+			      void *message)
>>+{
>>+	phandle h;
>>+	struct device_node *dn;
>>+	struct pnv_php_slot *slot;
>>+	struct opal_msg *msg = message;
>>+
>>+	if (type != OPAL_MSG_PCI_HOTPLUG) {
>>+		pr_warn("%s: Invalid message %ld received!\n",
>>+			__func__, type);
>>+		return NOTIFY_DONE;
>>+	}
>>+
>>+	h = (phandle)be64_to_cpu(msg->params[1]);
>>+	dn = of_find_node_by_phandle(h);
>>+	if (!dn) {
>>+		pr_warn("%s: No device node for phandle 0x%x\n",
>>+			__func__, h);
>>+		return NOTIFY_DONE;
>>+	}
>>+
>>+	slot = pnv_php_find_slot(dn);
>>+	of_node_put(dn);
>>+	if (!slot) {
>>+		pr_warn("%s: No slot found for node <%s>\n",
>>+			__func__, of_node_full_name(dn));
>>+		of_node_put(dn);
>
>You already put the node 5 lines above, is this correct?
>
>>+		return NOTIFY_DONE;
>>+	}
>>+
>>+	slot->msg = msg;
>>+	schedule_work(&slot->work);
>>+	return NOTIFY_OK;
>>+}
>>+
>>+static int pnv_php_set_power_state(struct hotplug_slot *php_slot, u8 state)
>>+{
>>+	struct pnv_php_slot *slot = php_slot->private;
>
>
>Most instances of "struct pnv_php_slot" are called "slot".
>Most instances of "struct hotplug_slot" are called "php_slot".
>
>When I read this code, I have to remind myself that a "php_slot" variable
>(which has "php" in it) is NOT of the type with "php" (i.e. NOT
>"pnv_php_slot").
>
>I would suggest swapping slot <-> php_slot.
>
>
>>+	int ret;
>>+
>>+	slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_INVALID;
>>+	ret = pnv_pci_set_power_state(slot->id, state);
>>+	if (ret) {
>>+		dev_warn(&slot->pdev->dev, "Error %d powering %s slot\n",
>>+			 ret, state ? "on" : "off");
>>+		return ret;
>>+	}
>>+
>>+	/* Continue to PCI probing after finalized device-tree. The
>>+	 * device-tree might have been updated completely at this
>>+	 * point. Thus we don't have to always waiting for that.
>
>s/always waiting/wait forever/ ?
>
>>+	 */
>>+	if (slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_SUCCESS)
>>+		return 0;
>>+	else if (slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_FAIL)
>
>
>No need in "else" here.
>
>
>>+		return -EBUSY;
>>+
>>+	ret = wait_event_timeout(slot->queue,
>>+				 slot->power_state_confirmed, 10 * HZ);
>
>The code flow is unclear in this case.
>
>The queue is signaled from pnv_php_handle_poweron() which is "work" and
>scheduled by pnv_php_handle_msg() and it is not obvious what code calls
>pnv_php_handle_msg().
>
>
>
>>+	if (!ret) {
>>+		dev_warn(&slot->pdev->dev, "Error %d waiting for power-%s\n",
>>+			 ret, state ? "on" : "off");
>>+		return -EBUSY;
>>+	}
>>+
>>+	if (slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_SUCCESS)
>>+		return 0;
>>+
>>+	dev_warn(&slot->pdev->dev, "Error status %d for power-%s\n",
>>+		 slot->power_state_confirmed, state ? "on" : "off");
>>+	return -EBUSY;
>>+}
>>+
>>+static int pnv_php_get_power_state(struct hotplug_slot *php_slot, u8 *state)
>>+{
>>+	struct pnv_php_slot *slot = php_slot->private;
>>+	uint8_t power_state;
>>+	int ret;
>>+
>>+	/*
>>+	 * Retrieve power status from firmware. If we fail
>>+	 * getting that, the power status fails back to
>>+	 * be on.
>>+	 */
>>+	ret = pnv_pci_get_power_state(slot->id, &power_state);
>>+	if (ret) {
>>+		*state = OPAL_PCI_SLOT_POWER_ON;
>>+		dev_warn(&slot->pdev->dev, "Error %d getting power status\n",
>>+			 ret);
>>+	} else {
>>+		*state = power_state;
>>+		php_slot->info->power_status = power_state;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int pnv_php_get_adapter_state(struct hotplug_slot *php_slot, u8 *state)
>>+{
>>+	struct pnv_php_slot *slot = php_slot->private;
>>+	uint8_t presence;
>>+	int ret;
>>+
>>+	/*
>>+	 * Retrieve presence status from firmware. If we can't
>>+	 * get that, it will fail back to be empty.
>>+	 */
>>+	ret = pnv_pci_get_presence_state(slot->id, &presence);
>>+	if (ret >= 0) {
>>+		*state = presence;
>>+		php_slot->info->adapter_status = presence;
>>+		ret = 0;
>>+	} else {
>>+		*state = OPAL_PCI_SLOT_EMPTY;
>>+		dev_warn(&slot->pdev->dev, "Error %d getting presence\n",
>>+			 ret);
>>+	}
>>+
>>+	return ret;
>>+}
>>+
>>+static int pnv_php_set_attention_state(struct hotplug_slot *php_slot, u8 state)
>>+{
>>+	/* FIXME: Make it real once firmware supports it */
>>+	php_slot->info->attention_status = state;
>>+
>>+	return 0;
>>+}
>>+
>>+static int pnv_php_enable(struct pnv_php_slot *slot, bool rescan)
>>+{
>>+	struct hotplug_slot *php_slot = &slot->php_slot;
>>+	uint8_t presence, power_status;
>>+	int ret;
>>+
>>+	/* Check if the slot has been configured */
>>+	if (slot->state != PNV_PHP_STATE_REGISTER)
>>+		return 0;
>>+
>>+	/* Retrieve slot presence status */
>>+	ret = php_slot->ops->get_adapter_status(php_slot, &presence);
>
>
>Here and in other places there is no point in dereferencing ops, just call
>pnv_php_get_adapter_state() here directly as you decided not to have a
>separate source file for pnv_php_slot.
>
>
>>+	if (ret)
>>+		return ret;
>>+
>>+	/* Proceed if there have nothing behind the slot */
>>+	if (presence == OPAL_PCI_SLOT_EMPTY)
>>+		goto scan;
>>+
>>+	/*
>>+	 * If we don't detect something behind the slot, we need
>>+	 * make sure the power suply to the slot is on.
>
>Is this correct - "don't detect" -> "make sure it is on"?
>
>
>>Otherwise,
>>+	 * the slot downstream PCIe linkturn should be down.
>>+	 *
>>+	 * On the first time, we don't change the power status to
>>+	 * boost system boot with assumption that the firmware
>
>Out of curiosity - does it really boost booting? :)
>
>
>>+	 * supplies consistent slot power status: empty slot always
>>+	 * has its power off and non-empty slot has its power on.
>>+	 */
>>+	if (!slot->power_state_check) {
>>+		slot->power_state_check = true;
>>+		goto scan;
>>+	}
>>+
>>+	/* Check the power status. Scan the slot if that's already on */
>>+	ret = php_slot->ops->get_power_status(php_slot, &power_status);
>>+	if (ret)
>>+		return ret;
>>+
>>+	if (power_status == OPAL_PCI_SLOT_POWER_ON)
>>+		goto scan;
>>+
>>+	/* Power is off, turn it on and then scan the slot */
>>+	ret = pnv_php_set_power_state(php_slot, OPAL_PCI_SLOT_POWER_ON);
>>+	if (ret)
>>+		return ret;
>>+
>>+scan:
>>+	if (presence == OPAL_PCI_SLOT_PRESENT) {
>>+		if (rescan) {
>>+			pci_lock_rescan_remove();
>>+			pci_add_pci_devices(slot->bus);
>>+			pci_unlock_rescan_remove();
>>+		}
>>+
>>+		/* Rescan for child hotpluggable slots */
>>+		slot->state = PNV_PHP_STATE_POPULATED;
>>+		if (rescan)
>>+			pnv_php_register(slot->dn);
>
>
>The chunk above adds a parent slot (a physical slot) and then scans for
>children slots (a mighty extended with extra physical slots)? :)
>
>
>>+	} else {
>>+		slot->state = PNV_PHP_STATE_POPULATED;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int pnv_php_enable_slot(struct hotplug_slot *php_slot)
>>+{
>>+	struct pnv_php_slot *slot = container_of(php_slot,
>>+						 struct pnv_php_slot,
>>+						 php_slot);
>>+
>>+	return pnv_php_enable(slot, true);
>>+}
>>+
>>+static int pnv_php_disable_slot(struct hotplug_slot *php_slot)
>>+{
>>+	struct pnv_php_slot *slot = php_slot->private;
>>+	uint8_t power_state;
>>+	int ret;
>>+
>>+	if (slot->state != PNV_PHP_STATE_POPULATED)
>>+		return 0;
>>+
>>+	/* Remove all devices behind the slot */
>>+	pci_lock_rescan_remove();
>>+	pci_remove_pci_devices(slot->bus);
>>+	pci_unlock_rescan_remove();
>>+
>>+	/* Detach the child hotpluggable slots */
>>+	pnv_php_unregister(slot->dn);
>>+
>>+	/*
>>+	 * Check the power status and turn it off if necessary. If we
>>+	 * fail to get the power status, the power will be forced to
>>+	 * be off.
>>+	 */
>>+	ret = php_slot->ops->get_power_status(php_slot, &power_state);
>>+	if (ret || power_state == OPAL_PCI_SLOT_POWER_ON) {
>>+		ret = pnv_php_set_power_state(php_slot,
>>+					      OPAL_PCI_SLOT_POWER_OFF);
>>+		if (ret)
>>+			dev_warn(&slot->pdev->dev, "Error %d powering off\n",
>>+				 ret);
>>+	}
>>+
>>+	/* Update slot state */
>>+	slot->state = PNV_PHP_STATE_REGISTER;
>>+	return 0;
>>+}
>>+
>>+static struct hotplug_slot_ops php_slot_ops = {
>>+	.get_power_status	= pnv_php_get_power_state,
>>+	.get_adapter_status	= pnv_php_get_adapter_state,
>>+	.set_attention_status	= pnv_php_set_attention_state,
>>+	.enable_slot		= pnv_php_enable_slot,
>>+	.disable_slot		= pnv_php_disable_slot,
>>+};
>>+
>>+static void pnv_php_release(struct hotplug_slot *hp_slot)
>>+{
>>+	struct pnv_php_slot *slot = hp_slot->private;
>>+	unsigned long flags;
>>+
>>+	/* Remove from global or child list */
>>+	spin_lock_irqsave(&pnv_php_lock, flags);
>>+	list_del(&slot->link);
>>+	spin_unlock_irqrestore(&pnv_php_lock, flags);
>>+
>>+	/* Detach from parent */
>>+	pnv_php_put_slot(slot);
>>+	pnv_php_put_slot(slot->parent);
>>+}
>>+
>>+static int pnv_php_get_slot_id(struct device_node *dn, uint64_t *id)
>>+{
>>+	struct device_node *parent = dn;
>>+	const __be64 *prop64;
>>+	const __be32 *prop32;
>>+
>>+	/*
>>+	 * The hotpluggable slot always has a compound Id, which
>>+	 * consists of 16-bits PHB Id, 16 bits bus/slot/function
>>+	 * number, and compound indicator
>>+	 */
>>+	*id = (0x1ul << 63);
>>+
>>+	/* Bus/Slot/Function number */
>>+	prop32 = of_get_property(dn, "reg", NULL);
>>+	if (!prop32)
>>+		return -ENXIO;
>>+	*id |= ((of_read_number(prop32, 1) & 0x00ffff00) << 8);
>>+
>>+	/* PHB Id */
>>+	while ((parent = of_get_parent(parent))) {
>>+		if (!PCI_DN(parent)) {
>>+			of_node_put(parent);
>>+			break;
>>+		}
>>+
>>+		if (!of_device_is_compatible(parent, "ibm,ioda2-phb") &&
>>+		    !of_device_is_compatible(parent, "ibm,ioda-phb")) {
>>+			of_node_put(parent);
>>+			continue;
>>+		}
>>+
>>+		prop64 = of_get_property(parent, "ibm,opal-phbid", NULL);
>>+		if (!prop64) {
>>+			of_node_put(parent);
>>+			return -ENXIO;
>>+		}
>>+
>>+		*id |= be64_to_cpup(prop64);
>>+		of_node_put(parent);
>>+		return 0;
>>+	}
>>+
>>+	return -ENODEV;
>>+}
>>+
>>+static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>>+{
>>+	struct pnv_php_slot *slot;
>>+	struct pci_bus *bus;
>>+	const char *label;
>>+	uint64_t id;
>>+
>>+	label = of_get_property(dn, "ibm,slot-label", NULL);
>>+	if (!label)
>>+		return NULL;
>>+
>>+	if (pnv_php_get_slot_id(dn, &id))
>>+		return NULL;
>>+
>>+	bus = pci_find_bus_by_node(dn);
>>+	if (!bus)
>>+		return NULL;
>>+
>>+	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
>>+	if (!slot)
>>+		return NULL;
>>+
>>+	slot->name = kstrdup(label, GFP_KERNEL);
>>+	if (!slot->name) {
>>+		kfree(slot);
>>+		return NULL;
>>+	}
>>+
>>+	if (dn->child && PCI_DN(dn->child))
>>+		slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
>>+	else
>>+		slot->slot_no = -1;   /* Placeholder slot */
>>+
>>+	kref_init(&slot->kref);
>>+	slot->state	            = PNV_PHP_STATE_INIT;
>>+	slot->dn	            = dn;
>>+	slot->pdev	            = bus->self;
>>+	slot->bus	            = bus;
>>+	slot->id	            = id;
>>+	slot->power_state_check     = false;
>>+	slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_INVALID;
>>+	slot->php_slot.ops          = &php_slot_ops;
>>+	slot->php_slot.info         = &slot->php_slot_info;
>>+	slot->php_slot.release      = pnv_php_release;
>>+	slot->php_slot.private      = slot;
>>+
>>+	INIT_WORK(&slot->work, pnv_php_work);
>>+	init_waitqueue_head(&slot->queue);
>>+	INIT_LIST_HEAD(&slot->children);
>>+	INIT_LIST_HEAD(&slot->link);
>>+
>>+	return slot;
>>+}
>>+
>>+static int pnv_php_register_slot(struct pnv_php_slot *slot)
>>+{
>>+	struct pnv_php_slot *parent;
>>+	struct device_node *dn = slot->dn;
>>+	unsigned long flags;
>>+	int ret;
>>+
>>+	/* Check if the slot exists or not */
>
>s/exists/is registered/
>
>
>>+	parent = pnv_php_find_slot(slot->dn);
>>+	if (parent) {
>>+		pnv_php_put_slot(parent);
>>+		return -EEXIST;
>>+	}
>>+
>>+	/* Register PCI slot */
>>+	ret = pci_hp_register(&slot->php_slot, slot->bus,
>>+			      slot->slot_no, slot->name);
>>+	if (ret) {
>>+		dev_warn(&slot->pdev->dev, "Error %d registering slot\n",
>>+			 ret);
>>+		return ret;
>>+	}
>>+
>>+	/* Attach to the parent's child list or global list */
>>+	while ((dn = of_get_parent(dn))) {
>>+		if (!PCI_DN(dn)) {
>>+			of_node_put(dn);
>>+			break;
>>+		}
>>+
>>+		parent = pnv_php_find_slot(dn);
>>+		if (parent) {
>>+			of_node_put(dn);
>>+			break;
>>+		}
>
>This is missing here:
>
>of_node_put(dn);
>
>
>>+	}
>>+
>>+	spin_lock_irqsave(&pnv_php_lock, flags);
>>+	slot->parent = parent;
>>+	if (parent)
>>+		list_add_tail(&slot->link, &parent->children);
>>+	else
>>+		list_add_tail(&slot->link, &pnv_php_slot_list);
>>+	spin_unlock_irqrestore(&pnv_php_lock, flags);
>>+
>>+	slot->state = PNV_PHP_STATE_REGISTER;
>>+	return 0;
>>+}
>>+
>>+static int pnv_php_register_one(struct device_node *dn)
>>+{
>>+	struct pnv_php_slot *slot;
>>+	const __be32 *prop32;
>>+	int ret;
>>+
>>+	/* Check if it's hotpluggable slot */
>>+	prop32 = of_get_property(dn, "ibm,slot-pluggable", NULL);
>>+	if (!prop32 || !of_read_number(prop32, 1))
>>+		return -ENXIO;
>>+
>>+	prop32 = of_get_property(dn, "ibm,reset-by-firmware", NULL);
>>+	if (!prop32 || !of_read_number(prop32, 1))
>>+		return -ENXIO;
>>+
>>+	slot = pnv_php_alloc_slot(dn);
>>+	if (!slot)
>>+		return -ENODEV;
>>+
>>+	ret = pnv_php_register_slot(slot);
>>+	if (ret)
>>+		goto free_slot;
>>+
>>+	ret = pnv_php_enable(slot, false);
>>+	if (ret)
>>+		goto unregister_slot;
>>+
>>+	return 0;
>>+
>>+unregister_slot:
>>+	pnv_php_unregister_one(slot->dn);
>>+free_slot:
>>+	pnv_php_put_slot(slot);
>>+	return ret;
>>+}
>>+
>>+static void pnv_php_register(struct device_node *dn)
>>+{
>>+	struct device_node *child;
>>+
>>+	/*
>>+	 * The parent slots should be registered before their
>>+	 * child slots.
>>+	 */
>>+	for_each_child_of_node(dn, child) {
>>+		pnv_php_register_one(child);
>>+		pnv_php_register(child);
>>+	}
>>+}
>>+
>>+static void pnv_php_unregister_one(struct device_node *dn)
>>+{
>>+	struct pnv_php_slot *slot;
>>+
>>+	slot = pnv_php_find_slot(dn);
>>+	if (!slot)
>>+		return;
>>+
>>+	pnv_php_put_slot(slot);
>>+	pci_hp_deregister(&slot->php_slot);
>>+}
>>+
>>+static void pnv_php_unregister(struct device_node *dn)
>>+{
>>+	struct device_node *child;
>>+
>>+	/* The child slots should go before their parent slots */
>>+	for_each_child_of_node(dn, child) {
>>+		pnv_php_unregister(child);
>>+		pnv_php_unregister_one(child);
>>+	}
>>+}
>>+
>>+static struct notifier_block php_msg_nb = {
>>+	.notifier_call	= pnv_php_handle_msg,
>>+	.next		= NULL,
>>+	.priority	= 0,
>>+};
>>+
>>+static int __init pnv_php_init(void)
>>+{
>>+	struct device_node *dn;
>>+	int ret;
>>+
>>+	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>>+
>>+	/* Register hotplug message handler */
>>+	ret = pnv_pci_hotplug_notifier_register(&php_msg_nb);
>>+	if (ret) {
>>+		pr_warn("%s: Error %d registering hotplug notifier\n",
>>+			__func__, ret);
>>+		return ret;
>>+	}
>>+
>>+	/* Scan PHB nodes and their children */
>>+	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
>>+		pnv_php_register(dn);
>>+	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
>>+		pnv_php_register(dn);
>>+
>>+	return 0;
>>+}
>>+
>>+static void __exit pnv_php_exit(void)
>>+{
>>+	struct device_node *dn;
>>+
>>+	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
>>+		pnv_php_unregister(dn);
>>+	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
>>+		pnv_php_unregister(dn);
>>+
>>+	pnv_pci_hotplug_notifier_unregister(&php_msg_nb);
>>+}
>>+
>>+module_init(pnv_php_init);
>>+module_exit(pnv_php_exit);
>>+
>>+MODULE_VERSION(DRIVER_VERSION);
>>+MODULE_LICENSE("GPL v2");
>>+MODULE_AUTHOR(DRIVER_AUTHOR);
>>+MODULE_DESCRIPTION(DRIVER_DESC);
>>
>
>
>-- 
>Alexey
>
