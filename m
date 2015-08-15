Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CCC1A04C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 13:13:30 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so70988137pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 20:13:28 -0700 (PDT)
Subject: Re: [PATCH v6 42/42] pci/hotplug: PowerPC PowerNV PCI hotplug driver
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-43-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55CEAE51.8070300@ozlabs.ru>
Date: Sat, 15 Aug 2015 13:13:21 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-43-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The patch intends to add standalone driver to support PCI hotplug
> for PowerPC PowerNV platform, which runs on top of skiboot firmware.
> The firmware identified hotpluggable slots and marked their device
> tree node with proper "ibm,slot-pluggable" and "ibm,reset-by-firmware".
> The driver simply scans device-tree to create/register PCI hotplug slot
> accordingly.
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
>   MAINTAINERS                            |   6 +
>   drivers/pci/hotplug/Kconfig            |  12 +
>   drivers/pci/hotplug/Makefile           |   4 +
>   drivers/pci/hotplug/powernv_php.c      | 140 +++++++
>   drivers/pci/hotplug/powernv_php.h      |  92 +++++
>   drivers/pci/hotplug/powernv_php_slot.c | 722 +++++++++++++++++++++++++++++++++
>   6 files changed, 976 insertions(+)
>   create mode 100644 drivers/pci/hotplug/powernv_php.c
>   create mode 100644 drivers/pci/hotplug/powernv_php.h
>   create mode 100644 drivers/pci/hotplug/powernv_php_slot.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd60784..3b75c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7747,6 +7747,12 @@ L:	linux-pci@vger.kernel.org
>   S:	Supported
>   F:	Documentation/PCI/pci-error-recovery.txt
>
> +PCI HOTPLUG DRIVER FOR POWERNV PLATFORM
> +M:	Gavin Shan <gwshan@linux.vnet.ibm.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	drivers/pci/hotplug/powernv_php*
> +
>   PCI SUBSYSTEM
>   M:	Bjorn Helgaas <bhelgaas@google.com>
>   L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index df8caec..ef55dae 100644
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
> +          PCI Hotplug
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called powernv-php.
> +
> +	  When in doubt, say N.
> +
>   config HOTPLUG_PCI_RPA
>   	tristate "RPA PCI Hotplug driver"
>   	depends on PPC_PSERIES && EEH
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index b616e75..fd51d65 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
>   obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
> +obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= powernv-php.o
>   obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>   obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>   obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
> @@ -50,6 +51,9 @@ ibmphp-objs		:=	ibmphp_core.o	\
>   acpiphp-objs		:=	acpiphp_core.o	\
>   				acpiphp_glue.o
>
> +powernv-php-objs	:=	powernv_php.o	\
> +				powernv_php_slot.o
> +
>   rpaphp-objs		:=	rpaphp_core.o	\
>   				rpaphp_pci.o	\
>   				rpaphp_slot.o
> diff --git a/drivers/pci/hotplug/powernv_php.c b/drivers/pci/hotplug/powernv_php.c
> new file mode 100644
> index 0000000..4cbff7a
> --- /dev/null
> +++ b/drivers/pci/hotplug/powernv_php.c
> @@ -0,0 +1,140 @@
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
> +#include <linux/module.h>
> +
> +#include <asm/opal.h>
> +#include <asm/pnv-pci.h>
> +
> +#include "powernv_php.h"
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
> +#define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"


Align all or none.


> +
> +static struct notifier_block php_msg_nb = {
> +	.notifier_call	= powernv_php_msg_handler,
> +	.next		= NULL,
> +	.priority	= 0,
> +};
> +
> +static int powernv_php_register_one(struct device_node *dn)
> +{
> +	struct powernv_php_slot *slot;
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
> +	/* Allocate slot */
> +	slot = powernv_php_slot_alloc(dn);
> +	if (!slot)
> +		return -ENODEV;
> +
> +	/* Register it */
> +	ret = powernv_php_slot_register(slot);
> +	if (ret) {
> +		powernv_php_slot_put(slot);
> +		return ret;
> +	}
> +
> +	return powernv_php_slot_enable(slot->php_slot, false);


And if it fails, no unregister and cleanup is needed?


> +}
> +
> +int powernv_php_register(struct device_node *dn)
> +{
> +	struct device_node *child;
> +	int ret = 0;

@ret is not used below.

> +
> +	/*
> +	 * The parent slots should be registered before their
> +	 * child slots.
> +	 */
> +	for_each_child_of_node(dn, child) {
> +		powernv_php_register_one(child);
> +		powernv_php_register(child);
> +	}
> +
> +	return ret;
> +}
> +
> +static void powernv_php_unregister_one(struct device_node *dn)
> +{
> +	struct powernv_php_slot *slot;
> +
> +	slot = powernv_php_slot_find(dn);
> +	if (!slot)
> +		return;
> +
> +	pci_hp_deregister(slot->php_slot);
> +}
> +
> +void powernv_php_unregister(struct device_node *dn)
> +{
> +	struct device_node *child;
> +
> +	/* The child slots should go before their parent slots */
> +	for_each_child_of_node(dn, child) {
> +		powernv_php_unregister(child);
> +		powernv_php_unregister_one(child);
> +	}
> +}
> +
> +static int __init powernv_php_init(void)
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
> +		powernv_php_register(dn);
> +	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
> +		powernv_php_register(dn);


May be move pnv_pci_hotplug_notifier_register() after 
powernv_php_register()? If not, then below (in powernv_php_exit()) move 
pnv_pci_hotplug_notifier_unregister() to the end?


> +
> +	return 0;
> +}
> +
> +static void __exit powernv_php_exit(void)
> +{
> +	struct device_node *dn;
> +
> +	pnv_pci_hotplug_notifier_unregister(&php_msg_nb);
> +
> +	for_each_compatible_node(dn, NULL, "ibm,ioda-phb")
> +		powernv_php_unregister(dn);
> +	for_each_compatible_node(dn, NULL, "ibm,ioda2-phb")
> +		powernv_php_unregister(dn);
> +}
> +
> +module_init(powernv_php_init);
> +module_exit(powernv_php_exit);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/drivers/pci/hotplug/powernv_php.h b/drivers/pci/hotplug/powernv_php.h
> new file mode 100644
> index 0000000..8034cc6
> --- /dev/null
> +++ b/drivers/pci/hotplug/powernv_php.h
> @@ -0,0 +1,92 @@
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
> +#ifndef _POWERNV_PHP_H
> +#define _POWERNV_PHP_H
> +
> +#include <linux/list.h>
> +#include <linux/kref.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/opal-api.h>
> +
> +/* Slot power status */
> +#define POWERNV_PHP_SLOT_POWER_OFF	0
> +#define POWERNV_PHP_SLOT_POWER_ON	1
> +
> +/* Slot presence status */
> +#define POWERNV_PHP_SLOT_EMPTY		0
> +#define POWERNV_PHP_SLOT_PRESENT	1

These two are also only used in drivers/pci/hotplug/powernv_php_slot.c,
move them there at least. It also seems your PHP driver is the only one 
which uses flags for an adapter status, others return plain 0 or 1 (which 
are c-style "false" and "true", pretty much, so it is not the case of magic 
constants). Since you return these values from the hotplug_slot_ops 
callbacks to external code, you should probably do the same.

And exactly the same comment about POWERNV_PHP_SLOT_POWER_ON/OFF few lines 
above.



> +
> +/* Slot attention status */
> +#define POWERNV_PHP_SLOT_ATTEN_OFF	0
> +#define POWERNV_PHP_SLOT_ATTEN_ON	1
> +#define POWERNV_PHP_SLOT_ATTEN_IND	2
> +#define POWERNV_PHP_SLOT_ATTEN_ACT	3


These should go to drivers/pci/hotplug/powernv_php_slot.c. Where are these 
flags defined? Looks to me like there is a way to pass some status from the 
userspace via sysfs to OPAL so only OPAL is supposed to recognize and 
handle these. If so, these macros are missing "OPAL" in their names. I have 
one more comment below about it.


> +
> +struct powernv_php_slot {
> +	char			*name;
> +	struct device_node	*dn;
> +	struct pci_dev		*pdev;
> +	struct pci_bus		*bus;
> +	uint64_t		id;
> +	int			slot_no;
> +	struct kref		kref;
> +#define POWERNV_PHP_SLOT_STATE_INIT		0
> +#define POWERNV_PHP_SLOT_STATE_REGISTER		1
> +#define POWERNV_PHP_SLOT_STATE_POPULATED	2
> +	int			state;
> +	int			check_power_status;
> +	int			status_confirmed;

s/status_confirmed/power_status_confirmed/

What is this status? It can be 0, 1, 2 which seems to be 
UNCONFIRMED/INPROGRESS/CONFIRMED (does not need PNV/IODA prefixes as it is 
local to the powernv_php_slot.c file).


> +	struct opal_msg		*msg;
> +	void			*fdt;
> +	void			*dt;
> +	struct of_changeset	ocs;
> +	struct work_struct	work;
> +	wait_queue_head_t	queue;
> +	struct hotplug_slot	*php_slot;
> +	struct powernv_php_slot	*parent;
> +	struct list_head	children;
> +	struct list_head	link;
> +};

This should go to drivers/pci/hotplug/powernv_php_slot.c and this header 
should only have a forward declaration. After you move it there, you get 
better separation of the driver code from the slot code and only 2 changes 
will be needed:

1. powernv_php_slot_enable() should receive powernv_php_slot
2. add powernv_php_slot_unregister() (like powernv_php_slot_register()), 
this way you will have pairing pci_hp_register/pci_hp_deregister in the 
same file.


After you moved this struct to the source file, you could remove/shorten 
POWERNV_PHP_SLOT_STATE_ prefixes if you wished.

> +
> +int powernv_php_msg_handler(struct notifier_block *nb,
> +			    unsigned long type, void *message);
> +struct powernv_php_slot *powernv_php_slot_find(struct device_node *dn);
> +void powernv_php_slot_free(struct kref *kref);
> +struct powernv_php_slot *powernv_php_slot_alloc(struct device_node *dn);
> +int powernv_php_slot_register(struct powernv_php_slot *slot);
> +int powernv_php_slot_enable(struct hotplug_slot *php_slot, bool rescan);
> +int powernv_php_register(struct device_node *dn);
> +void powernv_php_unregister(struct device_node *dn);
> +
> +#define to_powernv_php_slot(kref) \
> +	container_of(kref, struct powernv_php_slot, kref)
> +
> +static inline void powernv_php_slot_get(struct powernv_php_slot *slot)
> +{
> +	if (slot)
> +		kref_get(&slot->kref);
> +}
> +
> +static inline int powernv_php_slot_put(struct powernv_php_slot *slot)
> +{
> +	if (slot)
> +		return kref_put(&slot->kref, powernv_php_slot_free);
> +
> +	return 0;
> +}

In these 2 helpers you do not have to check for @slof - it is checked in 
the callers pretty much always. Or it is not checked in php_slot_release() 
but dereferenced before you call powernv_php_slot_put(slot).

The only place you really want this check is 
powernv_php_slot_put(slot->parent) so just check it there. btw is it even 
possible for the slot not to have a parent?

So I'd ditch these helpers.


> +
> +#endif /* !_POWERNV_PHP_H */
> diff --git a/drivers/pci/hotplug/powernv_php_slot.c b/drivers/pci/hotplug/powernv_php_slot.c
> new file mode 100644
> index 0000000..73a93a2
> --- /dev/null
> +++ b/drivers/pci/hotplug/powernv_php_slot.c
> @@ -0,0 +1,722 @@
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
> +#include <linux/module.h>
> +
> +#include <asm/opal.h>
> +#include <asm/pnv-pci.h>
> +#include <asm/ppc-pci.h>
> +
> +#include "powernv_php.h"
> +
> +static LIST_HEAD(php_slot_list);
> +static DEFINE_SPINLOCK(php_slot_lock);
> +
> +/*
> + * Remove firmware data for all child device nodes of the
> + * indicated one.
> + */
> +static void remove_child_pdn(struct device_node *np)
> +{
> +	struct device_node *child;
> +
> +	for_each_child_of_node(np, child) {
> +		/* In depth first */
> +		remove_child_pdn(child);
> +
> +		remove_pci_device_node_info(child);
> +	}
> +}
> +
> +/*
> + * Remove all subordinate device nodes of the indicated one.
> + * Those device nodes in deepest path should be released firstly.
> + */
> +static int remove_child_device_nodes(struct device_node *parent)
> +{
> +	struct device_node *np, *child;
> +	int ret = 0;
> +
> +	/* If the device node has children, remove them firstly */
> +	for_each_child_of_node(parent, np) {
> +		ret = remove_child_device_nodes(np);
> +		if (ret)
> +			return ret;
> +
> +		/* The device shouldn't have alive children */
> +		child = of_get_next_child(np, NULL);
> +		if (child) {
> +			of_node_put(child);
> +			of_node_put(np);
> +			pr_err("%s: Alive children of node <%s>\n",
> +			       __func__, of_node_full_name(np));
> +			return -EBUSY;
> +		}
> +
> +		/* Detach the device node */
> +		of_detach_node(np);
> +		of_node_put(np);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The function processes the message sent by firmware
> + * to remove all device tree nodes beneath the slot's
> + * nodes, and the associated auxillary data.
> + */
> +static void slot_power_off_handler(struct powernv_php_slot *slot)
> +{
> +	int ret, status = 1;
> +
> +	/* Release the firmware data for the child device nodes */
> +	remove_child_pdn(slot->dn);
> +
> +	/*
> +	 * Release the child device nodes. If the sub-tree was
> +	 * built with the help of changeset, we just need destroy
> +	 * the changes.
> +	 */
> +	if (slot->fdt) {
> +		of_changeset_destroy(&slot->ocs);
> +		kfree(slot->dt);
> +		slot->dt = NULL;
> +		slot->dn->child = NULL;
> +		kfree(slot->fdt);
> +		slot->fdt = NULL;
> +	} else {
> +		ret = remove_child_device_nodes(slot->dn);
> +		if (ret) {
> +			status = 2;
> +			dev_warn(&slot->pdev->dev, "Error %d freeing nodes\n",
> +				 ret);
> +		}
> +	}
> +
> +	/* Confirm status change */
> +	slot->status_confirmed = status;
> +	wake_up_interruptible(&slot->queue);
> +}
> +
> +static int slot_populate_changeset(struct of_changeset *ocs,
> +				    struct device_node *dn)
> +{
> +	struct device_node *child;
> +	int ret = 0;
> +
> +	for_each_child_of_node(dn, child) {
> +		ret = of_changeset_attach_node(ocs, child);
> +		if (ret)
> +			return ret;
> +
> +		ret = slot_populate_changeset(ocs, child);
> +	}
> +
> +	return ret;
> +}
> +
> +static void slot_power_on_handler(struct powernv_php_slot *slot)
> +{
> +	void *fdt, *dt;
> +	uint64_t len;
> +	int ret, status = 1;
> +
> +	/* We don't know the FDT blob size. It tries with incremental
> +	 * sized memory chunk.
> +	 */


What is the real expected size? 0x10000 is just 64K, just allocate it and 
that's it.


> +	for (len = 0x2000; len <= 0x10000; len += 0x2000) {
> +		fdt = kzalloc(len, GFP_KERNEL);
> +		if (!fdt)
> +			break;
> +
> +		ret = pnv_pci_get_device_tree(slot->dn->phandle, fdt, len);
> +		if (!ret)
> +			break;
> +
> +		kfree(fdt);
> +	}
> +
> +	if (len > 0x10000) {
> +		dev_warn(&slot->pdev->dev, "Cannot alloc FDT blob\n");
> +		goto out;
> +	}
> +
> +	/* Unflatten device tree blob */
> +	dt = of_fdt_unflatten_tree(fdt, slot->dn, NULL);
> +	if (!dt) {
> +		dev_warn(&slot->pdev->dev, "Cannot unflatten FDT\n");
> +		goto free_fdt;
> +	}

Right here you could kfree(fdt) and not cache it in the slot struct at all. 
You do not use it later anyway.


> +
> +	/* Initialize and apply the changeset */
> +	of_changeset_init(&slot->ocs);
> +	ret = slot_populate_changeset(&slot->ocs, slot->dn);
> +	if (ret) {
> +		dev_warn(&slot->pdev->dev, "Error %d populating changeset\n",
> +			 ret);
> +		goto free_dt;
> +	}
> +
> +	slot->dn->child = NULL;
> +	ret = of_changeset_apply(&slot->ocs);
> +	if (ret) {
> +		dev_warn(&slot->pdev->dev, "Error %d applying changeset\n",
> +			 ret);
> +		goto destroy_changeset;
> +	}
> +
> +	/* Add device node firmware data */
> +	traverse_pci_device_nodes(slot->dn,
> +				  add_pci_device_node_info,
> +				  pci_bus_to_host(slot->bus));
> +	slot->fdt = fdt;
> +	slot->dt = dt;
> +	goto out;
> +
> +destroy_changeset:
> +	of_changeset_destroy(&slot->ocs);
> +free_dt:
> +	kfree(dt);
> +	slot->dn->child = NULL;

Can of_fdt_unflatten_tree() or of_changeset_init() or 
slot_populate_changeset() initialize dn->child? No kfree(slot->dn->child)?


> +free_fdt:
> +	kfree(fdt);
> +	status = 2;
> +out:
> +	/* Confirm status change */
> +	slot->status_confirmed = status;
> +	wake_up_interruptible(&slot->queue);
> +}
> +
> +static void powernv_php_slot_work(struct work_struct *data)
> +{
> +	struct powernv_php_slot *slot = container_of(data,
> +						     struct powernv_php_slot,
> +						     work);
> +	uint64_t php_event = be64_to_cpu(slot->msg->params[0]);
> +
> +	switch (php_event) {
> +	case 0: /* Slot power off */
> +		slot_power_off_handler(slot);
> +		break;
> +	case 1: /* Slot power on */
> +		slot_power_on_handler(slot);
> +		break;

These 0 and 1 are not the same 0 and 1 used for @val in get_power_status(), 
these are from OPAL so please define them.


> +	default:
> +		dev_warn(&slot->pdev->dev, "Unsupported hotplug event %lld\n",
> +			 php_event);
> +	}
> +
> +	of_node_put(slot->dn);
> +}
> +
> +int powernv_php_msg_handler(struct notifier_block *nb,
> +			    unsigned long type, void *message)
> +{
> +	phandle h;
> +	struct device_node *np;
> +	struct powernv_php_slot *slot;
> +	struct opal_msg *msg = message;
> +
> +	/* Check the message type */
> +	if (type != OPAL_MSG_PCI_HOTPLUG) {
> +		pr_warn("%s: Wrong message type %ld received!\n",
> +			__func__, type);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Find the device node */
> +	h = (phandle)be64_to_cpu(msg->params[1]);
> +	np = of_find_node_by_phandle(h);
> +	if (!np) {
> +		pr_warn("%s: No device node for phandle 0x%08x\n",
> +			__func__, h);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Find the slot */
> +	slot = powernv_php_slot_find(np);
> +	if (!slot) {
> +		pr_warn("%s: No slot found for node <%s>\n",
> +			__func__, of_node_full_name(np));
> +		of_node_put(np);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Schedule the work */
> +	slot->msg = msg;
> +	schedule_work(&slot->work);
> +	return NOTIFY_OK;
> +}

This function belongs to drivers/pci/hotplug/powernv_php.c (searching a 
slot is powernv_php.c's scope) except these lines:

 > +	/* Schedule the work */
 > +	slot->msg = msg;
 > +	schedule_work(&slot->work);

These 3 lines should be in helper in drivers/pci/hotplug/powernv_php_slot.c.


> +
> +static int set_power_status(struct hotplug_slot *php_slot, u8 val)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +	int ret;
> +
> +	/* Set power status */
> +	slot->status_confirmed = 0;
> +	ret = pnv_pci_set_power_status(slot->id, val);
> +	if (ret) {
> +		dev_warn(&slot->pdev->dev, "Error %d powering %s slot\n",
> +			 ret, val ? "on" : "off");
> +		return ret;
> +	}
> +
> +	/* Continue to PCI probing after finalized device-tree. The
> +	 * device-tree might have been updated completely at this
> +	 * point. Thus we don't have to always waiting for that.
> +	 */
> +	if (slot->status_confirmed == 1)
> +		return 0;
> +	else if (slot->status_confirmed > 0)
> +		return -EBUSY;
> +
> +	ret = wait_event_timeout(slot->queue, slot->status_confirmed, 10 * HZ);
> +	if (!ret) {
> +		dev_warn(&slot->pdev->dev, "Error %d waiting for power-%s\n",
> +			 ret, val ? "on" : "off");
> +		return -EBUSY;
> +	}
> +
> +	/* Check the result */
> +	if (slot->status_confirmed == 1)
> +		return 0;
> +
> +	dev_warn(&slot->pdev->dev, "Error status %d for power-%s\n",
> +		 slot->status_confirmed, val ? "on" : "off");
> +	return -EBUSY;
> +}
> +
> +static int get_power_status(struct hotplug_slot *php_slot, u8 *val)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +	uint8_t state;
> +	int ret;
> +
> +	/*
> +	 * Retrieve power status from firmware. If we fail
> +	 * getting that, the power status fails back to
> +	 * be on.
> +	 */
> +	ret = pnv_pci_get_power_status(slot->id, &state);
> +	if (ret) {
> +		*val = POWERNV_PHP_SLOT_POWER_ON;
> +		dev_warn(&slot->pdev->dev, "Error %d getting power status\n",
> +			 ret);
> +	} else {
> +		*val = state ? POWERNV_PHP_SLOT_POWER_ON :
> +			       POWERNV_PHP_SLOT_POWER_OFF;
> +		php_slot->info->power_status = *val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_adapter_status(struct hotplug_slot *php_slot, u8 *val)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +	uint8_t state;
> +	int ret;
> +
> +	/*
> +	 * Retrieve presence status from firmware. If we can't
> +	 * get that, it will fail back to be empty.
> +	 */
> +	ret = pnv_pci_get_presence_status(slot->id, &state);
> +	if (ret >= 0) {
> +		ret = 0;
> +		*val = state ? POWERNV_PHP_SLOT_PRESENT :
> +			       POWERNV_PHP_SLOT_EMPTY;
> +		php_slot->info->adapter_status = *val;
> +		ret = 0;
> +	} else {
> +		*val = POWERNV_PHP_SLOT_EMPTY;
> +		dev_warn(&slot->pdev->dev, "Error %d getting presence\n",
> +			 ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int set_attention_status(struct hotplug_slot *php_slot, u8 val)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +
> +	/* The default operation would to turn on the attention */
> +	switch (val) {
> +	case POWERNV_PHP_SLOT_ATTEN_OFF:
> +	case POWERNV_PHP_SLOT_ATTEN_ON:
> +	case POWERNV_PHP_SLOT_ATTEN_IND:
> +	case POWERNV_PHP_SLOT_ATTEN_ACT:
> +		break;
> +	default:
> +		dev_warn(&slot->pdev->dev, "Invalid attention %d\n", val);
> +		return -EINVAL;
> +	}
> +
> +	/* FIXME: Make it real once firmware supports it */
> +	php_slot->info->attention_status = val;

Since firmware does not have an idea about these 
POWERNV_PHP_SLOT_ATTEN_xxx, just remove them. Later when the firmware will 
know about them, we will have to change this code anyway and by that time, 
the set of states may have changed.


> +
> +	return 0;
> +}
> +
> +int powernv_php_slot_enable(struct hotplug_slot *php_slot, bool rescan)


This should receive powernv_php_slot as described above.


> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +	uint8_t presence, power_status;
> +	int ret;
> +
> +	/* Check if the slot has been configured */
> +	if (slot->state != POWERNV_PHP_SLOT_STATE_REGISTER)
> +		return 0;
> +
> +	/* Retrieve slot presence status */
> +	ret = php_slot->ops->get_adapter_status(php_slot, &presence);
> +	if (ret)
> +		return ret;
> +
> +	/* Proceed if there have nothing behind the slot */
> +	if (presence == POWERNV_PHP_SLOT_EMPTY)
> +		goto scan;
> +
> +	/*
> +	 * If we don't detect something behind the slot, we need
> +	 * make sure the power suply to the slot is on. Otherwise,
> +	 * the slot downstream PCIe linkturn should be down.
> +	 *
> +	 * On the first time, we don't change the power status to
> +	 * boost system boot with assumption that the firmware
> +	 * supplies consistent slot power status: empty slot always
> +	 * has its power off and non-empty slot has its power on.
> +	 */
> +	if (!slot->check_power_status) {
> +		slot->check_power_status = 1;
> +		goto scan;
> +	}
> +
> +	/* Check the power status. Scan the slot if that's already on */
> +	ret = php_slot->ops->get_power_status(php_slot, &power_status);
> +	if (ret)
> +		return ret;
> +
> +	if (power_status == POWERNV_PHP_SLOT_POWER_ON)
> +		goto scan;
> +
> +	/* Power is off, turn it on and then scan the slot */
> +	ret = set_power_status(php_slot, POWERNV_PHP_SLOT_POWER_ON);
> +	if (ret)
> +		return ret;
> +
> +scan:
> +	switch (presence) {
> +	case POWERNV_PHP_SLOT_PRESENT:
> +		if (rescan) {
> +			pci_lock_rescan_remove();
> +			pci_add_pci_devices(slot->bus);
> +			pci_unlock_rescan_remove();
> +		}
> +
> +		/* Rescan for child hotpluggable slots */
> +		slot->state = POWERNV_PHP_SLOT_STATE_POPULATED;
> +		if (rescan)
> +			powernv_php_register(slot->dn);
> +		break;
> +	case POWERNV_PHP_SLOT_EMPTY:
> +		slot->state = POWERNV_PHP_SLOT_STATE_POPULATED;
> +		break;
> +	default:
> +		dev_warn(&slot->pdev->dev, "Invalid presence status %d\n",
> +			 presence);
> +		return -EINVAL;

Neigher PHP driver will ever have presence other than 0 or 1. So this 
switch() is simple if(presence){}else{}.



> +	}
> +
> +	return 0;
> +}
> +
> +static int enable_slot(struct hotplug_slot *php_slot)
> +{
> +	return powernv_php_slot_enable(php_slot, true);
> +}
> +
> +static int disable_slot(struct hotplug_slot *php_slot)
> +{
> +	struct powernv_php_slot *slot = php_slot->private;
> +	uint8_t power_status;
> +	int ret;
> +
> +	if (slot->state != POWERNV_PHP_SLOT_STATE_POPULATED)
> +		return 0;
> +
> +	/* Remove all devices behind the slot */
> +	pci_lock_rescan_remove();
> +	pci_remove_pci_devices(slot->bus);
> +	pci_unlock_rescan_remove();
> +
> +	/* Detach the child hotpluggable slots */
> +	powernv_php_unregister(slot->dn);
> +
> +	/*
> +	 * Check the power status and turn it off if necessary. If we
> +	 * fail to get the power status, the power will be forced to
> +	 * be off.
> +	 */
> +	ret = php_slot->ops->get_power_status(php_slot, &power_status);
> +	if (ret || power_status == POWERNV_PHP_SLOT_POWER_ON) {
> +		ret = set_power_status(php_slot, POWERNV_PHP_SLOT_POWER_OFF);
> +		if (ret)
> +			dev_warn(&slot->pdev->dev, "Error %d powering off\n",
> +				 ret);
> +	}
> +
> +	/* Update slot state */
> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
> +	return 0;
> +}
> +
> +static struct hotplug_slot_ops php_slot_ops = {
> +	.get_power_status	= get_power_status,
> +	.get_adapter_status	= get_adapter_status,
> +	.set_attention_status	= set_attention_status,
> +	.enable_slot		= enable_slot,
> +	.disable_slot		= disable_slot,
> +};
> +
> +static struct powernv_php_slot *php_slot_match(struct device_node *dn,
> +					       struct powernv_php_slot *slot)
> +{
> +	struct powernv_php_slot *target, *tmp;
> +
> +	if (slot->dn == dn)
> +		return slot;
> +
> +	list_for_each_entry(tmp, &slot->children, link) {
> +		target = php_slot_match(dn, tmp);
> +		if (target)
> +			return target;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct powernv_php_slot *powernv_php_slot_find(struct device_node *dn)
> +{
> +	struct powernv_php_slot *slot, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&php_slot_lock, flags);
> +	list_for_each_entry(tmp, &php_slot_list, link) {
> +		slot = php_slot_match(dn, tmp);
> +		if (slot) {
> +			spin_unlock_irqrestore(&php_slot_lock, flags);
> +			return slot;
> +		}
> +	}
> +	spin_unlock_irqrestore(&php_slot_lock, flags);
> +
> +	return NULL;
> +}
> +
> +void powernv_php_slot_free(struct kref *kref)
> +{
> +	struct powernv_php_slot *slot = to_powernv_php_slot(kref);
> +
> +	WARN_ON(!list_empty(&slot->children));
> +	kfree(slot->name);
> +	kfree(slot);
> +}
> +
> +static void php_slot_release(struct hotplug_slot *hp_slot)
> +{
> +	struct powernv_php_slot *slot = hp_slot->private;
> +	unsigned long flags;
> +
> +	/* Remove from global or child list */
> +	spin_lock_irqsave(&php_slot_lock, flags);
> +	list_del(&slot->link);
> +	spin_unlock_irqrestore(&php_slot_lock, flags);


This is a good example where RCU rules. powernv_php_slot_find() returns 
slot pointer and its use is not protected by spin_lock -> dangerous.

Remove spin_lock(), s/list_del/list_del_rcu/, and move bits below to 
call_rcu(), and s/list_for_each_entry/list_for_each_entry_rcu/.


> +
> +	/* Detach from parent */
> +	powernv_php_slot_put(slot);
> +	powernv_php_slot_put(slot->parent);
> +}
> +
> +static bool php_slot_get_id(struct device_node *dn,
> +			    uint64_t *id)
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
> +
> +	/* Bus/Slot/Function number */
> +	prop32 = of_get_property(dn, "reg", NULL);
> +	if (!prop32)
> +		return false;
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
> +			return false;
> +		}
> +
> +		*id |= be64_to_cpup(prop64);
> +		of_node_put(parent);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +struct powernv_php_slot *powernv_php_slot_alloc(struct device_node *dn)
> +{
> +	struct eeh_dev *edev = pdn_to_eeh_dev(PCI_DN(dn));
> +	struct pci_bus *bus;
> +	struct powernv_php_slot *slot;
> +	const char *label;
> +	uint64_t id;
> +	int slot_no;
> +	size_t size;
> +	void *pmem;
> +
> +	/* Slot name */
> +	label = of_get_property(dn, "ibm,slot-label", NULL);
> +	if (!label)
> +		return NULL;
> +
> +	/* Slot identifier */
> +	if (!php_slot_get_id(dn, &id))
> +		return NULL;
> +
> +	/* PCI bus */
> +	bus = of_node_to_pci_bus(dn);
> +	if (!bus)
> +		return NULL;
> +
> +	/* Slot number */
> +	if (dn->child && PCI_DN(dn->child))
> +		slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
> +	else
> +		slot_no = -1;

Not INVALID_SLOT and
#define INVALID_SLOT -1
? :)


> +
> +	/* Allocate slot */
> +	size = sizeof(struct powernv_php_slot) +
> +	       sizeof(struct hotplug_slot) +
> +	       sizeof(struct hotplug_slot_info);
> +	pmem = kzalloc(size, GFP_KERNEL);
> +	if (!pmem) {
> +		pr_warn("%s: Cannot allocate slot for node %s\n",
> +			__func__, dn->full_name);
> +		return NULL;
> +	}
> +
> +	/* Assign memory blocks */
> +	slot = pmem;
> +	slot->php_slot = pmem + sizeof(struct powernv_php_slot);
> +	slot->php_slot->info = pmem + sizeof(struct powernv_php_slot) +
> +			      sizeof(struct hotplug_slot);
> +	slot->name = kstrdup(label, GFP_KERNEL);
> +	if (!slot->name) {
> +		pr_warn("%s: Cannot populate name for node %s\n",
> +			__func__, dn->full_name);
> +		kfree(pmem);
> +		return NULL;
> +	}

Why not just embed structs one to another?

> +
> +	/* Initialize slot */
> +	kref_init(&slot->kref);
> +	slot->state = POWERNV_PHP_SLOT_STATE_INIT;
> +	slot->dn = dn;
> +	slot->pdev = eeh_dev_to_pci_dev(edev);
> +	slot->bus = bus;
> +	slot->id = id;
> +	slot->slot_no = slot_no;
> +	INIT_WORK(&slot->work, powernv_php_slot_work);
> +	init_waitqueue_head(&slot->queue);
> +	slot->check_power_status = 0;
> +	slot->status_confirmed = 0;
> +	slot->php_slot->ops = &php_slot_ops;
> +	slot->php_slot->release = php_slot_release;
> +	slot->php_slot->private = slot;
> +	INIT_LIST_HEAD(&slot->children);
> +	INIT_LIST_HEAD(&slot->link);
> +
> +	return slot;
> +}
> +
> +int powernv_php_slot_register(struct powernv_php_slot *slot)
> +{
> +	struct powernv_php_slot *parent;
> +	struct device_node *dn = slot->dn;
> +	unsigned long flags;
> +	int ret;
> +
> +	/* Avoid register same slot for twice */
> +	if (powernv_php_slot_find(slot->dn))
> +		return -EEXIST;
> +
> +	/* Register slot */
> +	ret = pci_hp_register(slot->php_slot, slot->bus,
> +			      slot->slot_no, slot->name);
> +	if (ret) {
> +		dev_warn(&slot->pdev->dev, "Error %d registering slot\n",
> +			 ret);
> +		return ret;
> +	}
> +
> +	/* Put into global or parent list */
> +	while ((dn = of_get_parent(dn))) {
> +		if (!PCI_DN(dn)) {
> +			of_node_put(dn);
> +			break;
> +		}
> +
> +		parent = powernv_php_slot_find(dn);
> +		if (parent) {
> +			of_node_put(dn);
> +			break;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&php_slot_lock, flags);
> +	if (parent) {
> +		powernv_php_slot_get(parent);
> +		slot->parent = parent;
> +		list_add_tail(&slot->link, &parent->children);
> +	} else {
> +		list_add_tail(&slot->link, &php_slot_list);
> +	}
> +	spin_unlock_irqrestore(&php_slot_lock, flags);
> +
> +	/* Update slot state */
> +	slot->state = POWERNV_PHP_SLOT_STATE_REGISTER;
> +	return 0;
> +}
>


Now I finished with this patchset respin :)


-- 
Alexey
