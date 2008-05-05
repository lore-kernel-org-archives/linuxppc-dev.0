Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07D2DDDEC6
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:55:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m45IqEFb006977
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 14:52:14 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m45It7of220782
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 12:55:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m45It6rb016545
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 12:55:06 -0600
Date: Mon, 5 May 2008 13:54:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Giuseppe Coviello" <cjg@cruxppc.org>
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080505135404.5c57720e@zod.rchland.ibm.com>
In-Reply-To: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 May 2008 20:23:29 +0200
"Giuseppe Coviello" <cjg@cruxppc.org> wrote:

> This patch adds the support for the sam440ep board.

Urgh.  Could you split this into a number of smaller patches, each with
a proper commit message that doesn't break the build on its own?

See some initial comments below.

> diff --git a/arch/powerpc/boot/cuboot-sam440ep.c
> b/arch/powerpc/boot/cuboot-sam440ep.c
> new file mode 100644
> index 0000000..200b35b
> --- /dev/null
> +++ b/arch/powerpc/boot/cuboot-sam440ep.c
> @@ -0,0 +1,35 @@
> +/*
> + * Old U-boot compatibility for Sam440ep based off bamboo.c code
> + * original copyrights below
> + *
> + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * Copyright 2007 IBM Corporation
> + *
> + * Based on cuboot-ebony.c
> + *
> + * Modified from cuboot-bamboo.c for sam440ep:
> + * Copyright 2008 Giuseppe Coviello <cjg@cruxppc.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "44x.h"
> +#include "cuboot.h"
> +
> +#define TARGET_4xx
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +		unsigned long r6, unsigned long r7)
> +{
> +	CUBOOT_INIT();
> +	sam440ep_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
> +}

I don't see a reason to split out the bootwrapper support into two
separate files.  You should be able to have a single file for it.

> diff --git a/arch/powerpc/platforms/44x/sam440ep.c
> b/arch/powerpc/platforms/44x/sam440ep.c
> new file mode 100644
> index 0000000..a95eb80
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/sam440ep.c
> @@ -0,0 +1,66 @@
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/ppc4xx.h>
> +
> +static __initdata struct of_device_id sam440ep_of_bus[] = {
> +	{ .compatible = "ibm,plb4", },
> +	{ .compatible = "ibm,opb", },
> +	{ .compatible = "ibm,ebc", },
> +	{},
> +};
> +
> +static int __init sam440ep_device_probe(void)
> +{
> +	of_platform_bus_probe(NULL, sam440ep_of_bus, NULL);
> +
> +	return 0;
> +}
> +machine_device_initcall(sam440ep, sam440ep_device_probe);
> +
> +static int __init sam440ep_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "acube,sam440ep"))
> +		return 0;
> +
> +	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
> +
> +	return 1;
> +}
> +
> +define_machine(sam440ep) {
> +	.name 			= "Sam440ep",
> +	.probe 			= sam440ep_probe,
> +	.progress 		= udbg_progress,
> +	.init_IRQ 		= uic_init_tree,
> +	.get_irq 		= uic_get_irq,
> +	.restart		= ppc4xx_reset_system,
> +	.calibrate_decr 	= generic_calibrate_decr,
> +};

You don't do anything platform specific at all in this file.  You
should be able to just reuse the bamboo.c file.  Look at Yosemite for
how that is done.

> +static int __init sam440ep_i2c_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i = 0;
> +	struct platform_device *i2c_dev;
> +	int ret;
> +
> +	for_each_compatible_node(np, NULL, "ibm,iic") {
> +		struct resource r[2];
> +
> +		memset(&r, 0, sizeof(r));
> +
> +		ret = of_address_to_resource(np, 0, &r[0]);
> +		if (ret)
> +			goto err;
> +
> +		of_irq_to_resource(np, 0, &r[1]);
> +
> +		i2c_dev = platform_device_register_simple("ibm,iic", i, r, 2);
> +		if (IS_ERR(i2c_dev)) {
> +			ret = PTR_ERR(i2c_dev);
> +			goto err;
> +		}
> +
> +		of_register_i2c_devices(np, i++);
> +	}
> +
> +	return 0;
> +
> +err:
> +	return ret;
> +}
> +
> +arch_initcall(sam440ep_i2c_of_init);

Ok, now I'm confused as to why you aren't doing this in your platform
file (which would make it specific, and therefore justify its existence.

> diff --git a/include/asm-powerpc/dma-mapping.h
> b/include/asm-powerpc/dma-mapping.h
> index bbefb69..3a6235a 100644
> --- a/include/asm-powerpc/dma-mapping.h
> +++ b/include/asm-powerpc/dma-mapping.h

You definitely need to explain what you're doing here with a commit log.

> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
> index 23b7bc0..e7c64ac 100644
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c

This needs to be sent to the sound maintainer.  And I'm sure they
probably won't like the ifdefs.

josh
