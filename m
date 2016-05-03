Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzMrB1dcfzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 10:44:26 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id gh9so282863pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 May 2016 17:44:26 -0700 (PDT)
Subject: Re: [PATCH v8 45/45] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alistair Popple <alistair@popple.id.au>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <57160A40.3020406@ozlabs.ru> <5044520.n8NHsZUD6Y@new-mexico>
 <20160502234123.GB5908@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, grant.likely@linaro.org, robherring2@gmail.com,
 bhelgaas@google.com, dja@axtens.net
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <75f3eeb2-24cd-fca2-3c14-d29b31e08330@ozlabs.ru>
Date: Tue, 3 May 2016 10:44:17 +1000
MIME-Version: 1.0
In-Reply-To: <20160502234123.GB5908@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 09:41 AM, Gavin Shan wrote:
> On Wed, Apr 20, 2016 at 11:55:56AM +1000, Alistair Popple wrote:
>> On Tue, 19 Apr 2016 20:36:48 Alexey Kardashevskiy wrote:
>>> On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>>> This adds standalone driver to support PCI hotplug for PowerPC PowerNV
>>>> platform that runs on top of skiboot firmware. The firmware identifies
>>>> hotpluggable slots and marked their device tree node with proper
>>>> "ibm,slot-pluggable" and "ibm,reset-by-firmware". The driver scans
>>>> device tree nodes to create/register PCI hotplug slot accordingly.
>>>>
>>>> The PCI slots are organized in fashion of tree, which means one
>>>> PCI slot might have parent PCI slot and parent PCI slot possibly
>>>> contains multiple child PCI slots. At the plugging time, the parent
>>>> PCI slot is populated before its children. The child PCI slots are
>>>> removed before their parent PCI slot can be removed from the system.
>>>>
>>>> If the skiboot firmware doesn't support slot status retrieval, the PCI
>>>> slot device node shouldn't have property "ibm,reset-by-firmware". In
>>>> that case, none of valid PCI slots will be detected from device tree.
>>>> The skiboot firmware doesn't export the capability to access attention
>>>> LEDs yet and it's something for TBD.
>>>>
>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>   drivers/pci/hotplug/Kconfig   |  12 +
>>>>   drivers/pci/hotplug/Makefile  |   3 +
>>>>   drivers/pci/hotplug/pnv_php.c | 870 ++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 885 insertions(+)
>>>>   create mode 100644 drivers/pci/hotplug/pnv_php.c
>>>>
>>>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>>>> index df8caec..167c8ce 100644
>>>> --- a/drivers/pci/hotplug/Kconfig
>>>> +++ b/drivers/pci/hotplug/Kconfig
>>>> @@ -113,6 +113,18 @@ config HOTPLUG_PCI_SHPC
>>>>
>>>>   	  When in doubt, say N.
>>>>
>>>> +config HOTPLUG_PCI_POWERNV
>>>> +	tristate "PowerPC PowerNV PCI Hotplug driver"
>>>> +	depends on PPC_POWERNV && EEH
>>>> +	help
>>>> +	  Say Y here if you run PowerPC PowerNV platform that supports
>>>> +	  PCI Hotplug
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the
>>>> +	  module will be called pnv-php.
>>>> +
>>>> +	  When in doubt, say N.
>>>> +
>>>>   config HOTPLUG_PCI_RPA
>>>>   	tristate "RPA PCI Hotplug driver"
>>>>   	depends on PPC_PSERIES && EEH
>>>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>>> index b616e75..e33cdda 100644
>>>> --- a/drivers/pci/hotplug/Makefile
>>>> +++ b/drivers/pci/hotplug/Makefile
>>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
>>>> +obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= pnv-php.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>>>>   obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
>>>> @@ -50,6 +51,8 @@ ibmphp-objs		:=	ibmphp_core.o	\
>>>>   acpiphp-objs		:=	acpiphp_core.o	\
>>>>   				acpiphp_glue.o
>>>>
>>>> +pnv-php-objs		:=	pnv_php.o
>>>> +
>>>>   rpaphp-objs		:=	rpaphp_core.o	\
>>>>   				rpaphp_pci.o	\
>>>>   				rpaphp_slot.o
>>>> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>>>> new file mode 100644
>>>> index 0000000..364ec36
>>>> --- /dev/null
>>>> +++ b/drivers/pci/hotplug/pnv_php.c
>>>> @@ -0,0 +1,870 @@
>>>> +/*
>>>> + * PCI Hotplug Driver for PowerPC PowerNV platform.
>>>> + *
>>>> + * Copyright Gavin Shan, IBM Corporation 2015.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> + */
>>>> +
>>>> +#include <linux/libfdt.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/pci_hotplug.h>
>>>> +
>>>> +#include <asm/opal.h>
>>>> +#include <asm/pnv-pci.h>
>>>> +#include <asm/ppc-pci.h>
>>>> +
>>>> +#define DRIVER_VERSION	"0.1"
>>>> +#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
>>>> +#define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
>>>> +
>>>> +struct pnv_php_slot {
>>>> +	struct hotplug_slot		slot;
>>>> +	struct hotplug_slot_info	slot_info;
>>>> +	uint64_t			id;
>>>> +	char				*name;
>>>> +	int				slot_no;
>>>> +	struct kref			kref;
>>>> +#define PNV_PHP_STATE_INITIALIZED	0
>>>> +#define PNV_PHP_STATE_REGISTERED	1
>>>> +#define PNV_PHP_STATE_POPULATED		2
>>>> +	int				state;
>>>> +	struct device_node		*dn;
>>>> +	struct pci_dev			*pdev;
>>>> +	struct pci_bus			*bus;
>>>> +	bool				power_state_check;
>>>> +	int				power_state_confirmed;
>>>> +#define PNV_PHP_POWER_CONFIRMED_INVALID	0
>>>> +#define PNV_PHP_POWER_CONFIRMED_SUCCESS	1
>>>> +#define PNV_PHP_POWER_CONFIRMED_FAIL	2
>>>> +	struct opal_msg			*msg;
>>>> +	void				*fdt;
>>>> +	void				*dt;
>>>> +	struct of_changeset		ocs;
>>>> +	struct work_struct		work;
>>>> +	wait_queue_head_t		queue;
>>>> +	struct pnv_php_slot		*parent;
>>>> +	struct list_head		children;
>>>> +	struct list_head		link;
>>>> +};
>>>> +
>>>> +static LIST_HEAD(pnv_php_slot_list);
>>>> +static DEFINE_SPINLOCK(pnv_php_lock);
>>>> +
>>>> +static void pnv_php_register(struct device_node *dn);
>>>> +static void pnv_php_unregister_one(struct device_node *dn);
>>>> +static void pnv_php_unregister(struct device_node *dn);
>>>
>>>
>>> The names confused me. I'd suggest pnv_php_scan(), pnv_php_unregister(),
>>> pnv_php_unregister_children() instead.
>>>
>>>
>>> Alistair, what do you reckon?
>>
>> To be honest I'm not sure the new names are necessarily any less confusing. I
>> will admit to having to read that code twice though so perhaps a short comment
>> describing what each of those functions does would be the best method for
>> reducing confusion.
>
> Alexey, Please confirm if I need rename those functions though I
> don't understand the confusion caused the function names.

Just add the comments.

I got confused because:

pnv_php_register() walks through nodes to find "ibm,slot-pluggable" - this 
is rather "scan" than "register" (which may not happen if the property is 
not there).

pnv_php_register_one() registers one what? slot? From the name I conclude 
that not a slot as there is pnv_php_register_slot() which does register one 
slot. So I suppose pnv_php_register_one() registers one _node_ (which may 
have multiple slots? there should be reason why it is a separate function). 
I do not know...



> [unrelated content removed]



-- 
Alexey
