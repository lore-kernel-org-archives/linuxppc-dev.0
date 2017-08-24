Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdN1J3kSPzDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 21:51:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/12] powerpc/vas: Define vas_init() and vas_exit()
In-Reply-To: <1503556688-15412-4-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-4-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 21:51:31 +1000
Message-ID: <87pobluqt8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suka,

Comments inline ...

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> diff --git a/Documentation/devicetree/bindings/powerpc/ibm,vas.txt b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
> new file mode 100644
> index 0000000..0e3111d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
> @@ -0,0 +1,24 @@
> +* IBM Powerpc Virtual Accelerator Switchboard (VAS)
> +
> +VAS is a hardware mechanism that allows kernel subsystems and user processes
> +to directly submit compression and other requests to Nest accelerators (NX)
> +or other coprocessors functions.
> +
> +Required properties:
> +- compatible : should be "ibm,vas" or "ibm,power9-vas"

The driver doesn't look for the latter.

> +- ibm,vas-id : A unique identifier for each instance of VAS in the system

What is this?

> +- reg : Should contain 4 pairs of 64-bit fields specifying the Hypervisor
> +  window context start and length, OS/User window context start and length,
> +  "Paste address" start and length, "Paste window id" start bit and number
> +  of bits)
> +- name : "vas"

I don't think the name is normally included in the binding, and in fact
there's no reason why the name is important, so I'd be inclined to drop that.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c41902..abc235f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6425,6 +6425,14 @@ F:	drivers/crypto/nx/nx.*
>  F:	drivers/crypto/nx/nx_csbcpb.h
>  F:	drivers/crypto/nx/nx_debugfs.h
>  
> +IBM Power Virtual Accelerator Switchboard
> +M:	Sukadev Bhattiprolu
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	arch/powerpc/platforms/powernv/vas*
> +F:	arch/powerpc/include/asm/vas.h
> +F:	arch/powerpc/include/uapi/asm/vas.h

That's not in the right place, the file is sorted alphabetically.

V comes after L.

> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 6a6f4ef..f565454 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -30,3 +30,17 @@ config OPAL_PRD
>  	help
>  	  This enables the opal-prd driver, a facility to run processor
>  	  recovery diagnostics on OpenPower machines
> +
> +config PPC_VAS
> +	bool "IBM Virtual Accelerator Switchboard (VAS)"

^ bool, so never a module.

> +	depends on PPC_POWERNV && PPC_64K_PAGES
> +	default n

It should be default y.

I know the usual advice is to make things 'default n', but this has
fairly tight depends already, so y is OK IMO.

> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> new file mode 100644
> index 0000000..556156b
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/vas.c
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright 2016 IBM Corp.

2016-2017.

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

#define pr_fmt(fmt) "vas: " fmt

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +
> +#include "vas.h"
> +
> +static bool init_done;
> +LIST_HEAD(vas_instances);

Can be static.

> +
> +static int init_vas_instance(struct platform_device *pdev)
> +{
> +	int rc, vasid;
> +	struct vas_instance *vinst;
> +	struct device_node *dn = pdev->dev.of_node;
> +	struct resource *res;

	struct device_node *dn = pdev->dev.of_node;
	struct vas_instance *vinst;
	struct resource *res;
	int rc, vasid;

Petty I know, but much prettier :)

> +
> +	rc = of_property_read_u32(dn, "ibm,vas-id", &vasid);
> +	if (rc) {
> +		pr_err("VAS: No ibm,vas-id property for %s?\n", pdev->name);

With the pr_fmt() above you don't need VAS: on the front of all these.

> +		return -ENODEV;
> +	}
> +
> +	if (pdev->num_resources != 4) {
> +		pr_err("VAS: Unexpected DT configuration for [%s, %d]\n",
> +				pdev->name, vasid);
> +		return -ENODEV;
> +	}
> +
> +	vinst = kcalloc(1, sizeof(*vinst), GFP_KERNEL);

kzalloc() would be more normal given there's only 1.

> +	if (!vinst)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&vinst->node);
> +	ida_init(&vinst->ida);
> +	mutex_init(&vinst->mutex);
> +	vinst->vas_id = vasid;
> +	vinst->pdev = pdev;
> +
> +	res = &pdev->resource[0];
> +	vinst->hvwc_bar_start = res->start;
> +	vinst->hvwc_bar_len = res->end - res->start + 1;
> +
> +	res = &pdev->resource[1];
> +	vinst->uwc_bar_start = res->start;
> +	vinst->uwc_bar_len = res->end - res->start + 1;

You have vinst->pdev, why do you need to copy all those?

I don't see the lens even used.

> +	res = &pdev->resource[2];
> +	vinst->paste_base_addr = res->start;
> +
> +	res = &pdev->resource[3];
> +	vinst->paste_win_id_shift = 63 - res->end;

????

What if res->end is INT_MAX ?

> +	pr_devel("VAS: Initialized instance [%s, %d], paste_base 0x%llx, "
> +			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
> +			vinst->paste_base_addr, vinst->paste_win_id_shift);
> +
> +	vinst->ready = true;

I don't see ready used.

It also shouldn't be necessary, it's not ready unless it's in the list,
and if it's in the list then it's ready.

If you're actually concerned about concurrent usage then you need a
memory barrier here to order the stores to the vinst struct vs the
addition to the list. And you need a matching barrier on the read side.

> +	list_add(&vinst->node, &vas_instances);
> +
> +	dev_set_drvdata(&pdev->dev, vinst);
> +
> +	return 0;
> +}
> +
> +/*
> + * Although this is read/used multiple times, it is written to only
> + * during initialization.
> + */
> +struct vas_instance *find_vas_instance(int vasid)
> +{
> +	struct list_head *ent;
> +	struct vas_instance *vinst;
> +
> +	list_for_each(ent, &vas_instances) {
> +		vinst = list_entry(ent, struct vas_instance, node);
> +		if (vinst->vas_id == vasid)
> +			return vinst;
> +	}

There's no locking here, or any reference counting of the instances. see 

> +	pr_devel("VAS: Instance %d not found\n", vasid);
> +	return NULL;
> +}
> +
> +bool vas_initialized(void)
> +{
> +	return init_done;
> +}
> +
> +static int vas_probe(struct platform_device *pdev)
> +{
> +	if (!pdev || !pdev->dev.of_node)
> +		return -ENODEV;

Neither of those can happen, or if they did it would be a BUG.

> +	return init_vas_instance(pdev);
> +}
> +
> +static void free_inst(struct vas_instance *vinst)
> +{
> +	list_del(&vinst->node);
> +	kfree(vinst);

And here you just delete and the free the instance, even though you have
handed out pointers to the instance above in find_vas_instance().

So that needs work.

Is there any hardware cleanup required before we delete the instance? Or
do we just leave any windows there?

Seems like to begin with you should probably just not support remove.

> +static int vas_remove(struct platform_device *pdev)
> +{
> +	struct vas_instance *vinst;
> +
> +	vinst = dev_get_drvdata(&pdev->dev);
> +
> +	pr_devel("VAS: Removed instance [%s, %d]\n", pdev->name,
> +				vinst->vas_id);
> +	free_inst(vinst);
> +
> +	return 0;
> +}
> +static const struct of_device_id powernv_vas_match[] = {
> +	{ .compatible = "ibm,vas",},
> +	{},
> +};
> +
> +static struct platform_driver vas_driver = {
> +	.driver = {
> +		.name = "vas",
> +		.of_match_table = powernv_vas_match,
> +	},
> +	.probe = vas_probe,
> +	.remove = vas_remove,
> +};
> +
> +module_platform_driver(vas_driver);

Can't be a module.

> +
> +int vas_init(void)
> +{
> +	int found = 0;
> +	struct device_node *dn;
> +
> +	for_each_compatible_node(dn, NULL, "ibm,vas") {
> +		of_platform_device_create(dn, NULL, NULL);
> +		found++;
> +	}
> +
> +	if (!found)
> +		return -ENODEV;
> +
> +	pr_devel("VAS: Found %d instances\n", found);
> +	init_done = true;

What does init_done mean?

The way it's currently written it just means there were some ibm,vas
nodes in the device tree. But it doesn't say that we actually probed
them correctly and created vas instances for them.

So it doesn't really tell you much.

Two of the callers of vas_initialized() immediately do a
find_instance(), so they don't really need to call it at all, the lack
of any instances will suffice.

The other two callers are vas_copy_crb() and vas_paste_crb(). The only
use of the former is in nx which doesn't check the return code.

But both should never be called unless we allocated a window anyway.

In short it seems unecessary.

> +
> +	return 0;
> +}
> +
> +void vas_exit(void)
> +{
> +	struct list_head *ent;
> +	struct vas_instance *vinst;
> +
> +	list_for_each(ent, &vas_instances) {
> +		vinst = list_entry(ent, struct vas_instance, node);
> +		of_platform_depopulate(&vinst->pdev->dev);
> +	}
> +
> +	init_done = false;
> +}
> +
> +module_init(vas_init);
> +module_exit(vas_exit);
> +MODULE_DESCRIPTION("Bare metal IBM Virtual Accelerator Switchboard");
> +MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
> +MODULE_LICENSE("GPL");

Can't be a module.

Just a device_initcall() should work for init, you shouldn't need
vas_exit() or any of the other bits.

cheers
