Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1fN3mbXzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:37:00 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id e128so5648773pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 03:37:00 -0700 (PDT)
Subject: Re: [PATCH v8 45/45] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Alistair Popple <alistair@popple.id.au>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-46-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57160A40.3020406@ozlabs.ru>
Date: Tue, 19 Apr 2016 20:36:48 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-46-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> This adds standalone driver to support PCI hotplug for PowerPC PowerNV
> platform that runs on top of skiboot firmware. The firmware identifies
> hotpluggable slots and marked their device tree node with proper
> "ibm,slot-pluggable" and "ibm,reset-by-firmware". The driver scans
> device tree nodes to create/register PCI hotplug slot accordingly.
>
> The PCI slots are organized in fashion of tree, which means one
> PCI slot might have parent PCI slot and parent PCI slot possibly
> contains multiple child PCI slots. At the plugging time, the parent
> PCI slot is populated before its children. The child PCI slots are
> removed before their parent PCI slot can be removed from the system.
>
> If the skiboot firmware doesn't support slot status retrieval, the PCI
> slot device node shouldn't have property "ibm,reset-by-firmware". In
> that case, none of valid PCI slots will be detected from device tree.
> The skiboot firmware doesn't export the capability to access attention
> LEDs yet and it's something for TBD.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/hotplug/Kconfig   |  12 +
>   drivers/pci/hotplug/Makefile  |   3 +
>   drivers/pci/hotplug/pnv_php.c | 870 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 885 insertions(+)
>   create mode 100644 drivers/pci/hotplug/pnv_php.c
>
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index df8caec..167c8ce 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -113,6 +113,18 @@ config HOTPLUG_PCI_SHPC
>
>   	  When in doubt, say N.
>
> +config HOTPLUG_PCI_POWERNV
> +	tristate "PowerPC PowerNV PCI Hotplug driver"
> +	depends on PPC_POWERNV && EEH
> +	help
> +	  Say Y here if you run PowerPC PowerNV platform that supports
> +	  PCI Hotplug
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pnv-php.
> +
> +	  When in doubt, say N.
> +
>   config HOTPLUG_PCI_RPA
>   	tristate "RPA PCI Hotplug driver"
>   	depends on PPC_PSERIES && EEH
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index b616e75..e33cdda 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
>   obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
> +obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= pnv-php.o
>   obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>   obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>   obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
> @@ -50,6 +51,8 @@ ibmphp-objs		:=	ibmphp_core.o	\
>   acpiphp-objs		:=	acpiphp_core.o	\
>   				acpiphp_glue.o
>
> +pnv-php-objs		:=	pnv_php.o
> +
>   rpaphp-objs		:=	rpaphp_core.o	\
>   				rpaphp_pci.o	\
>   				rpaphp_slot.o
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> new file mode 100644
> index 0000000..364ec36
> --- /dev/null
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -0,0 +1,870 @@
> +/*
> + * PCI Hotplug Driver for PowerPC PowerNV platform.
> + *
> + * Copyright Gavin Shan, IBM Corporation 2015.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/libfdt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +
> +#include <asm/opal.h>
> +#include <asm/pnv-pci.h>
> +#include <asm/ppc-pci.h>
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
> +#define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
> +
> +struct pnv_php_slot {
> +	struct hotplug_slot		slot;
> +	struct hotplug_slot_info	slot_info;
> +	uint64_t			id;
> +	char				*name;
> +	int				slot_no;
> +	struct kref			kref;
> +#define PNV_PHP_STATE_INITIALIZED	0
> +#define PNV_PHP_STATE_REGISTERED	1
> +#define PNV_PHP_STATE_POPULATED		2
> +	int				state;
> +	struct device_node		*dn;
> +	struct pci_dev			*pdev;
> +	struct pci_bus			*bus;
> +	bool				power_state_check;
> +	int				power_state_confirmed;
> +#define PNV_PHP_POWER_CONFIRMED_INVALID	0
> +#define PNV_PHP_POWER_CONFIRMED_SUCCESS	1
> +#define PNV_PHP_POWER_CONFIRMED_FAIL	2
> +	struct opal_msg			*msg;
> +	void				*fdt;
> +	void				*dt;
> +	struct of_changeset		ocs;
> +	struct work_struct		work;
> +	wait_queue_head_t		queue;
> +	struct pnv_php_slot		*parent;
> +	struct list_head		children;
> +	struct list_head		link;
> +};
> +
> +static LIST_HEAD(pnv_php_slot_list);
> +static DEFINE_SPINLOCK(pnv_php_lock);
> +
> +static void pnv_php_register(struct device_node *dn);
> +static void pnv_php_unregister_one(struct device_node *dn);
> +static void pnv_php_unregister(struct device_node *dn);


The names confused me. I'd suggest pnv_php_scan(), pnv_php_unregister(), 
pnv_php_unregister_children() instead.


Alistair, what do you reckon?


> +
> +static void pnv_php_free_slot(struct kref *kref)
> +{
> +	struct pnv_php_slot *php_slot = container_of(kref,
> +						     struct pnv_php_slot,
> +						     kref);
> +
> +	WARN_ON(!list_empty(&php_slot->children));
> +	kfree(php_slot->name);
> +	kfree(php_slot);
> +}
> +
> +static inline void pnv_php_put_slot(struct pnv_php_slot *php_slot)
> +{
> +	if (!php_slot)


BUG_ON()?

> +		return;
> +
> +	kref_put(&php_slot->kref, pnv_php_free_slot);
> +}
> +
> +static struct pnv_php_slot *pnv_php_match(struct device_node *dn,
> +					  struct pnv_php_slot *php_slot)
> +{
> +	struct pnv_php_slot *target, *tmp;
> +
> +	if (php_slot->dn == dn) {
> +		kref_get(&php_slot->kref);
> +		return php_slot;
> +	}
> +
> +	list_for_each_entry(tmp, &php_slot->children, link) {
> +		target = pnv_php_match(dn, tmp);
> +		if (target)
> +			return target;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
> +{
> +	struct pnv_php_slot *php_slot, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pnv_php_lock, flags);
> +	list_for_each_entry(tmp, &pnv_php_slot_list, link) {
> +		php_slot = pnv_php_match(dn, tmp);
> +		if (php_slot) {
> +			spin_unlock_irqrestore(&pnv_php_lock, flags);
> +			return php_slot;
> +		}
> +	}
> +	spin_unlock_irqrestore(&pnv_php_lock, flags);
> +
> +	return NULL;
> +}
> +
> +/*
> + * Remove pdn for all children of the indicated device node.
> + * The function should remove pdn in a depth-first manner.
> + */
> +static void pnv_php_rmv_pdns(struct device_node *dn)
> +{
> +	struct device_node *child;
> +
> +	for_each_child_of_node(dn, child) {
> +		pnv_php_rmv_pdns(child);
> +
> +		pci_remove_device_node_info(child);
> +	}
> +}
> +
> +/*
> + * Remove all child nodes of the indicated device nodes. The
> + * function should remove device nodes in depth-first manner.
> + */
> +static int pnv_php_rmv_device_nodes(struct device_node *parent)
> +{
> +	struct device_node *dn, *child;
> +	int ret = 0;
> +
> +	for_each_child_of_node(parent, dn) {
> +		ret = pnv_php_rmv_device_nodes(dn);
> +		if (ret)
> +			return ret;
> +
> +		child = of_get_next_child(dn, NULL);
> +		if (child) {
> +			of_node_put(child);
> +			of_node_put(dn);
> +			pr_err("%s: Alive children of node <%s>\n",
> +			       __func__, of_node_full_name(dn));
> +			return -EBUSY;
> +		}
> +
> +		of_detach_node(dn);
> +		of_node_put(dn);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The function processes the message sent by firmware
> + * to remove all device tree nodes beneath the slot's
> + * nodes and the associated auxiliary data.
> + */
> +static void pnv_php_handle_poweroff(struct pnv_php_slot *php_slot)
> +{
> +	int ret;
> +
> +	pnv_php_rmv_pdns(php_slot->dn);
> +
> +	/*
> +	 * If the device sub-tree was created from OF changeset, simply
> +	 * to revert that. Otherwise, the device nodes in the sub-tree
> +	 * need to be iterated and detached.
> +	 */
> +	if (php_slot->fdt) {
> +		of_changeset_destroy(&php_slot->ocs);
> +		kfree(php_slot->dt);
> +		kfree(php_slot->fdt);
> +		php_slot->dt        = NULL;
> +		php_slot->dn->child = NULL;
> +		php_slot->fdt       = NULL;
> +		php_slot->power_state_confirmed =
> +			PNV_PHP_POWER_CONFIRMED_SUCCESS;
> +		wake_up_interruptible(&php_slot->queue);
> +		return;
> +	}
> +
> +	ret = pnv_php_rmv_device_nodes(php_slot->dn);
> +	if (!ret) {
> +		php_slot->power_state_confirmed =
> +			PNV_PHP_POWER_CONFIRMED_SUCCESS;
> +	} else {
> +		php_slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_FAIL;
> +		dev_warn(&php_slot->pdev->dev, "Error %d freeing nodes\n", ret);
> +	}
> +
> +	wake_up_interruptible(&php_slot->queue);


I liked one wake_up_interruptible() better...



> +}
> +
> +static int pnv_php_populate_changeset(struct of_changeset *ocs,
> +				      struct device_node *dn)
> +{
> +	struct device_node *child;
> +	int ret = 0;
> +
> +	for_each_child_of_node(dn, child) {
> +		ret = of_changeset_attach_node(ocs, child);
> +		if (ret)
> +			break;
> +
> +		ret = pnv_php_populate_changeset(ocs, child);


I asked in v7 - may be to add here "if (ret) break;"?


> +	}
> +
> +	return ret;
> +}
> +
> +static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
> +{
> +	struct pci_controller *hose = (struct pci_controller *)data;
> +	struct pci_dn *pdn;
> +
> +	pdn = pci_add_device_node_info(hose, dn);
> +	if (!pdn)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return NULL;
> +}
> +
> +static void pnv_php_add_pdns(struct pnv_php_slot *slot)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(slot->bus);
> +
> +	pci_traverse_device_nodes(slot->dn, pnv_php_add_one_pdn, hose);
> +}
> +
> +static void pnv_php_handle_poweron(struct pnv_php_slot *php_slot)
> +{
> +	void *fdt, *fdt1, *dt;
> +	int confirm = PNV_PHP_POWER_CONFIRMED_SUCCESS;
> +	int ret;
> +
> +	/* We don't know the FDT blob size. We try to get it through
> +	 * maximal memory chunk and then copy it to another chunk that
> +	 * fits the real size.
> +	 */
> +	fdt1 = kzalloc(0x10000, GFP_KERNEL);
> +	if (!fdt1)
> +		goto error;
> +
> +	ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
> +	if (ret)
> +		goto free_fdt1;
> +
> +	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
> +	if (!fdt)
> +		goto free_fdt1;
> +
> +	/* Unflatten device tree blob */
> +	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
> +	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
> +	if (!dt) {
> +		dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
> +		goto free_fdt;
> +	}
> +
> +	/* Initialize and apply the changeset */
> +	of_changeset_init(&php_slot->ocs);
> +	ret = pnv_php_populate_changeset(&php_slot->ocs, php_slot->dn);
> +	if (ret) {
> +		dev_warn(&php_slot->pdev->dev, "Error %d populating changeset\n",
> +			 ret);
> +		goto free_dt;
> +	}
> +
> +	php_slot->dn->child = NULL;
> +	ret = of_changeset_apply(&php_slot->ocs);
> +	if (ret) {
> +		dev_warn(&php_slot->pdev->dev, "Error %d applying changeset\n",
> +			 ret);
> +		goto destroy_changeset;
> +	}
> +
> +	/* Add device node firmware data */
> +	pnv_php_add_pdns(php_slot);
> +	php_slot->fdt = fdt;
> +	php_slot->dt  = dt;
> +	goto out;
> +
> +destroy_changeset:
> +	of_changeset_destroy(&php_slot->ocs);
> +free_dt:
> +	kfree(dt);
> +	php_slot->dn->child = NULL;
> +free_fdt:
> +	kfree(fdt);
> +free_fdt1:
> +	kfree(fdt1);
> +error:
> +	confirm = PNV_PHP_POWER_CONFIRMED_FAIL;
> +out:
> +	/* Confirm status change */
> +	php_slot->power_state_confirmed = confirm;
> +	wake_up_interruptible(&php_slot->queue);
> +}
> +
> +static void pnv_php_work(struct work_struct *data)
> +{
> +	struct pnv_php_slot *php_slot = container_of(data,
> +						     struct pnv_php_slot,
> +						     work);
> +	uint64_t event = be64_to_cpu(php_slot->msg->params[0]);
> +
> +	if (event == OPAL_PCI_SLOT_POWER_OFF)
> +		pnv_php_handle_poweroff(php_slot);
> +	else
> +		pnv_php_handle_poweron(php_slot);
> +
> +	pnv_php_put_slot(php_slot);
> +}
> +
> +static int pnv_php_handle_msg(struct notifier_block *nb,
> +			      unsigned long type,
> +			      void *message)
> +{
> +	phandle h;
> +	struct device_node *dn;
> +	struct pnv_php_slot *php_slot;
> +	struct opal_msg *msg = message;
> +
> +	if (type != OPAL_MSG_PCI_HOTPLUG) {
> +		pr_warn("%s: Invalid message %ld received!\n",
> +			__func__, type);
> +		return NOTIFY_DONE;
> +	}
> +
> +	h = (phandle)be64_to_cpu(msg->params[1]);
> +	dn = of_find_node_by_phandle(h);
> +	if (!dn) {
> +		pr_warn("%s: No device node for phandle 0x%x\n",
> +			__func__, h);
> +		return NOTIFY_DONE;
> +	}
> +
> +	php_slot = pnv_php_find_slot(dn);
> +	if (!php_slot) {
> +		pr_warn("%s: No slot found for node <%s>\n",
> +			__func__, of_node_full_name(dn));
> +		of_node_put(dn);
> +		return NOTIFY_DONE;
> +	}
> +
> +	of_node_put(dn);
> +	php_slot->msg = msg;
> +	schedule_work(&php_slot->work);
> +	return NOTIFY_OK;
> +}
> +
> +static int pnv_php_set_power_state(struct hotplug_slot *slot, u8 state)
> +{
> +	struct pnv_php_slot *php_slot = slot->private;
> +	int ret;
> +
> +	php_slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_INVALID;
> +	ret = pnv_pci_set_power_state(php_slot->id, state);
> +	if (ret) {
> +		dev_warn(&php_slot->pdev->dev, "Error %d powering %s slot\n",
> +			 ret, state ? "on" : "off");
> +		return ret;
> +	}
> +
> +	/* Continue to PCI probing after finalized device-tree. The
> +	 * device-tree might have been updated completely at this
> +	 * point. Thus we don't have to wait forever.
> +	 */
> +	if (php_slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_SUCCESS)
> +		return 0;
> +
> +	if (php_slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_FAIL)
> +		return -EBUSY;
> +
> +	/* Wait for firmware to add or remove device sub-tree. When it's done,
> +	 * one signal is received from firmware.
> +	 */
> +	ret = wait_event_timeout(php_slot->queue,
> +				 php_slot->power_state_confirmed, 10 * HZ);
> +	if (!ret) {
> +		dev_warn(&php_slot->pdev->dev, "Error %d waiting for power-%s\n",
> +			 ret, state ? "on" : "off");
> +		return -EBUSY;
> +	}
> +
> +	if (php_slot->power_state_confirmed == PNV_PHP_POWER_CONFIRMED_SUCCESS)
> +		return 0;
> +
> +	dev_warn(&php_slot->pdev->dev, "Error status %d for power-%s\n",
> +		 php_slot->power_state_confirmed, state ? "on" : "off");
> +	return -EBUSY;
> +}
> +
> +static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
> +{
> +	struct pnv_php_slot *php_slot = slot->private;
> +	uint8_t power_state;


Uninitialized variable.


> +	int ret;
> +
> +	/*
> +	 * Retrieve power status from firmware. If we fail
> +	 * getting that, the power status fails back to
> +	 * be on.
> +	 */
> +	ret = pnv_pci_get_power_state(php_slot->id, &power_state);
> +	if (ret) {
> +		*state = OPAL_PCI_SLOT_POWER_ON;
> +		dev_warn(&php_slot->pdev->dev, "Error %d getting power status\n",
> +			 ret);
> +	} else {
> +		*state = power_state;
> +		slot->info->power_status = power_state;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
> +{
> +	struct pnv_php_slot *php_slot = slot->private;
> +	uint8_t presence;

Uninitialized variable.


> +	int ret;
> +
> +	/*
> +	 * Retrieve presence status from firmware. If we can't
> +	 * get that, it will fail back to be empty.
> +	 */
> +	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
> +	if (ret >= 0) {
> +		*state = presence;
> +		slot->info->adapter_status = presence;
> +		ret = 0;
> +	} else {
> +		*state = OPAL_PCI_SLOT_EMPTY;
> +		dev_warn(&php_slot->pdev->dev, "Error %d getting presence\n",
> +			 ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
> +{
> +	/* FIXME: Make it real once firmware supports it */

It still does not?


> +	slot->info->attention_status = state;
> +
> +	return 0;
> +}
> +
> +static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
> +{
> +	struct hotplug_slot *slot = &php_slot->slot;
> +	uint8_t presence, power_status;


Uninitialized variables.


> +	int ret;
> +
> +	/* Check if the slot has been configured */
> +	if (php_slot->state != PNV_PHP_STATE_REGISTERED)
> +		return 0;
> +
> +	/* Retrieve slot presence status */
> +	ret = pnv_php_get_adapter_state(slot, &presence);
> +	if (ret)
> +		return ret;
> +
> +	/* Proceed if there have nothing behind the slot */
> +	if (presence == OPAL_PCI_SLOT_EMPTY)
> +		goto scan;
> +
> +	/*
> +	 * If the power suply to the slot is off, we can't detect

s/suply/supply/


> +	 * adapter presence state. That means we have to turn the
> +	 * slot on before going to probe slot's presence state.
> +	 *
> +	 * On the first time, we don't change the power status to
> +	 * boost system boot with assumption that the firmware
> +	 * supplies consistent slot power status: empty slot always
> +	 * has its power off and non-empty slot has its power on.
> +	 */
> +	if (!php_slot->power_state_check) {
> +		php_slot->power_state_check = true;
> +
> +		ret = pnv_php_get_power_state(slot, &power_status);
> +		if (ret)
> +			return ret;
> +
> +		if (power_status != OPAL_PCI_SLOT_POWER_ON)
> +			return 0;
> +	}
> +
> +	/* Check the power status. Scan the slot if that's already on */


s/that's/it is/


> +	ret = pnv_php_get_power_state(slot, &power_status);
> +	if (ret)
> +		return ret;
> +
> +	if (power_status == OPAL_PCI_SLOT_POWER_ON)
> +		goto scan;
> +
> +	/* Power is off, turn it on and then scan the slot */
> +	ret = pnv_php_set_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
> +	if (ret)
> +		return ret;
> +
> +scan:
> +	if (presence == OPAL_PCI_SLOT_PRESENT) {
> +		if (rescan) {
> +			pci_lock_rescan_remove();
> +			pci_add_pci_devices(php_slot->bus);
> +			pci_unlock_rescan_remove();
> +		}
> +
> +		/* Rescan for child hotpluggable slots */
> +		php_slot->state = PNV_PHP_STATE_POPULATED;
> +		if (rescan)
> +			pnv_php_register(php_slot->dn);
> +	} else {
> +		php_slot->state = PNV_PHP_STATE_POPULATED;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pnv_php_enable_slot(struct hotplug_slot *slot)
> +{
> +	struct pnv_php_slot *php_slot = container_of(slot,
> +						     struct pnv_php_slot, slot);
> +
> +	return pnv_php_enable(php_slot, true);
> +}
> +
> +static int pnv_php_disable_slot(struct hotplug_slot *slot)
> +{
> +	struct pnv_php_slot *php_slot = slot->private;
> +	uint8_t power_state;
> +	int ret;
> +
> +	if (php_slot->state != PNV_PHP_STATE_POPULATED)
> +		return 0;
> +
> +	/* Remove all devices behind the slot */
> +	pci_lock_rescan_remove();
> +	pci_remove_pci_devices(php_slot->bus);
> +	pci_unlock_rescan_remove();
> +
> +	/* Detach the child hotpluggable slots */
> +	pnv_php_unregister(php_slot->dn);
> +
> +	/*
> +	 * Check the power status and turn it off if necessary. If we
> +	 * fail to get the power status, the power will be forced to
> +	 * be off.
> +	 */
> +	ret = pnv_php_get_power_state(slot, &power_state);
> +	if (ret || power_state == OPAL_PCI_SLOT_POWER_ON) {
> +		ret = pnv_php_set_power_state(slot, OPAL_PCI_SLOT_POWER_OFF);
> +		if (ret)
> +			dev_warn(&php_slot->pdev->dev, "Error %d powering off\n",


Long line, checkpatch.pl should have warned :)


> +				 ret);
> +	}
> +
> +	/* Update slot state */
> +	php_slot->state = PNV_PHP_STATE_REGISTERED;
> +	return 0;
> +}
> +
> +static struct hotplug_slot_ops php_slot_ops = {
> +	.get_power_status	= pnv_php_get_power_state,
> +	.get_adapter_status	= pnv_php_get_adapter_state,
> +	.set_attention_status	= pnv_php_set_attention_state,
> +	.enable_slot		= pnv_php_enable_slot,
> +	.disable_slot		= pnv_php_disable_slot,
> +};
> +
> +static void pnv_php_release(struct hotplug_slot *slot)
> +{
> +	struct pnv_php_slot *php_slot = slot->private;
> +	unsigned long flags;
> +
> +	/* Remove from global or child list */
> +	spin_lock_irqsave(&pnv_php_lock, flags);
> +	list_del(&php_slot->link);
> +	spin_unlock_irqrestore(&pnv_php_lock, flags);
> +
> +	/* Detach from parent */
> +	pnv_php_put_slot(php_slot);
> +	pnv_php_put_slot(php_slot->parent);
> +}
> +
> +static int pnv_php_get_slot_id(struct device_node *dn, uint64_t *id)
> +{
> +	struct device_node *parent = dn;
> +	const __be64 *prop64;
> +	const __be32 *prop32;
> +
> +	/*
> +	 * The hotpluggable slot always has a compound Id, which
> +	 * consists of 16-bits PHB Id, 16 bits bus/slot/function
> +	 * number, and compound indicator
> +	 */
> +	*id = (0x1ul << 63);


Is this bit from the same space as 1<<60 as in pnv_eeh_bridge_reset()? If 
so, it would be great to have all these id bits defined in one place.


> +
> +	/* Bus/Slot/Function number */
> +	prop32 = of_get_property(dn, "reg", NULL);
> +	if (!prop32)
> +		return -ENXIO;
> +	*id |= ((of_read_number(prop32, 1) & 0x00ffff00) << 8);
> +
> +	/* PHB Id */
> +	while ((parent = of_get_parent(parent))) {
> +		if (!PCI_DN(parent)) {
> +			of_node_put(parent);
> +			break;
> +		}
> +
> +		if (!of_device_is_compatible(parent, "ibm,ioda2-phb") &&
> +		    !of_device_is_compatible(parent, "ibm,ioda-phb")) {
> +			of_node_put(parent);
> +			continue;
> +		}
> +
> +		prop64 = of_get_property(parent, "ibm,opal-phbid", NULL);
> +		if (!prop64) {
> +			of_node_put(parent);
> +			return -ENXIO;
> +		}
> +
> +		*id |= be64_to_cpup(prop64);
> +		of_node_put(parent);
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
> +{
> +	struct pnv_php_slot *php_slot;
> +	struct pci_bus *bus;
> +	const char *label;
> +	uint64_t id;
> +
> +	label = of_get_property(dn, "ibm,slot-label", NULL);
> +	if (!label)
> +		return NULL;
> +
> +	if (pnv_php_get_slot_id(dn, &id))
> +		return NULL;
> +
> +	bus = pci_find_bus_by_node(dn);
> +	if (!bus)
> +		return NULL;
> +
> +	php_slot = kzalloc(sizeof(*php_slot), GFP_KERNEL);
> +	if (!php_slot)
> +		return NULL;
> +
> +	php_slot->name = kstrdup(label, GFP_KERNEL);
> +	if (!php_slot->name) {
> +		kfree(php_slot);
> +		return NULL;
> +	}
> +
> +	if (dn->child && PCI_DN(dn->child))
> +		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
> +	else
> +		php_slot->slot_no = -1;   /* Placeholder slot */
> +
> +	kref_init(&php_slot->kref);
> +	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
> +	php_slot->dn	                = dn;
> +	php_slot->pdev	                = bus->self;
> +	php_slot->bus	                = bus;
> +	php_slot->id	                = id;
> +	php_slot->power_state_check     = false;
> +	php_slot->power_state_confirmed = PNV_PHP_POWER_CONFIRMED_INVALID;
> +	php_slot->slot.ops              = &php_slot_ops;
> +	php_slot->slot.info             = &php_slot->slot_info;
> +	php_slot->slot.release          = pnv_php_release;
> +	php_slot->slot.private          = php_slot;
> +
> +	INIT_WORK(&php_slot->work, pnv_php_work);
> +	init_waitqueue_head(&php_slot->queue);
> +	INIT_LIST_HEAD(&php_slot->children);
> +	INIT_LIST_HEAD(&php_slot->link);
> +
> +	return php_slot;
> +}
> +
> +static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
> +{
> +	struct pnv_php_slot *parent;
> +	struct device_node *dn = php_slot->dn;
> +	unsigned long flags;
> +	int ret;
> +
> +	/* Check if the slot is registered or not */
> +	parent = pnv_php_find_slot(php_slot->dn);
> +	if (parent) {
> +		pnv_php_put_slot(parent);
> +		return -EEXIST;
> +	}
> +
> +	/* Register PCI slot */
> +	ret = pci_hp_register(&php_slot->slot, php_slot->bus,
> +			      php_slot->slot_no, php_slot->name);
> +	if (ret) {
> +		dev_warn(&php_slot->pdev->dev, "Error %d registering slot\n",
> +			 ret);
> +		return ret;
> +	}
> +
> +	/* Attach to the parent's child list or global list */
> +	while ((dn = of_get_parent(dn))) {
> +		if (!PCI_DN(dn)) {
> +			of_node_put(dn);
> +			break;
> +		}
> +
> +		parent = pnv_php_find_slot(dn);
> +		if (parent) {
> +			of_node_put(dn);
> +			break;
> +		}
> +
> +		of_node_put(dn);
> +	}
> +
> +	spin_lock_irqsave(&pnv_php_lock, flags);
> +	php_slot->parent = parent;
> +	if (parent)
> +		list_add_tail(&php_slot->link, &parent->children);
> +	else
> +		list_add_tail(&php_slot->link, &pnv_php_slot_list);
> +	spin_unlock_irqrestore(&pnv_php_lock, flags);
> +
> +	php_slot->state = PNV_PHP_STATE_REGISTERED;
> +	return 0;
> +}
> +
> +static int pnv_php_register_one(struct device_node *dn)
> +{
> +	struct pnv_php_slot *php_slot;
> +	const __be32 *prop32;
> +	int ret;
> +
> +	/* Check if it's hotpluggable slot */
> +	prop32 = of_get_property(dn, "ibm,slot-pluggable", NULL);
> +	if (!prop32 || !of_read_number(prop32, 1))
> +		return -ENXIO;
> +
> +	prop32 = of_get_property(dn, "ibm,reset-by-firmware", NULL);
> +	if (!prop32 || !of_read_number(prop32, 1))
> +		return -ENXIO;
> +
> +	php_slot = pnv_php_alloc_slot(dn);
> +	if (!php_slot)
> +		return -ENODEV;
> +
> +	ret = pnv_php_register_slot(php_slot);
> +	if (ret)
> +		goto free_slot;
> +
> +	ret = pnv_php_enable(php_slot, false);
> +	if (ret)
> +		goto unregister_slot;
> +
> +	return 0;
> +
> +unregister_slot:
> +	pnv_php_unregister_one(php_slot->dn);
> +free_slot:
> +	pnv_php_put_slot(php_slot);
> +	return ret;
> +}
> +
> +static void pnv_php_register(struct device_node *dn)
> +{
> +	struct device_node *child;
> +
> +	/*
> +	 * The parent slots should be registered before their
> +	 * child slots.
> +	 */
> +	for_each_child_of_node(dn, child) {
> +		pnv_php_register_one(child);
> +		pnv_php_register(child);
> +	}
> +}
> +
> +static void pnv_php_unregister_one(struct device_node *dn)
> +{
> +	struct pnv_php_slot *php_slot;
> +
> +	php_slot = pnv_php_find_slot(dn);
> +	if (!php_slot)
> +		return;
> +
> +	pnv_php_put_slot(php_slot);
> +	pci_hp_deregister(&php_slot->slot);
> +}
> +
> +static void pnv_php_unregister(struct device_node *dn)
> +{
> +	struct device_node *child;
> +
> +	/* The child slots should go before their parent slots */
> +	for_each_child_of_node(dn, child) {
> +		pnv_php_unregister(child);
> +		pnv_php_unregister_one(child);
> +	}
> +}
> +
> +static struct notifier_block php_msg_nb = {
> +	.notifier_call	= pnv_php_handle_msg,
> +	.next		= NULL,
> +	.priority	= 0,
> +};
> +
> +static int __init pnv_php_init(void)
> +{
> +	struct device_node *dn;
> +	int ret;
> +
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	/* Register hotplug message handler */
> +	ret = pnv_pci_hotplug_notifier_register(&php_msg_nb);
> +	if (ret) {
> +		pr_warn("%s: Error %d registering hotplug notifier\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	/* Scan PHB nodes and their children */
> +	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
> +		pnv_php_register(dn);
> +	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
> +		pnv_php_register(dn);
> +
> +	return 0;
> +}
> +
> +static void __exit pnv_php_exit(void)
> +{
> +	struct device_node *dn;
> +
> +	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
> +		pnv_php_unregister(dn);
> +	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
> +		pnv_php_unregister(dn);
> +
> +	pnv_pci_hotplug_notifier_unregister(&php_msg_nb);
> +}
> +
> +module_init(pnv_php_init);
> +module_exit(pnv_php_exit);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
>


-- 
Alexey
