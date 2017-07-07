Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3lg354vvzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 16:53:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, stewart@linux.vnet.ibm.com,
 dja@axtens.net, eranian@google.com, hemant@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v12 02/10] powerpc/powernv: Autoload IMC device driver
 module
In-Reply-To: <1499074673-30576-3-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
 <1499074673-30576-3-git-send-email-anju@linux.vnet.ibm.com>
Date: Fri, 07 Jul 2017 16:53:00 +1000
Message-ID: <87k23k91rn.fsf@concordia.ellerman.id.au>
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

Hi Maddy/Anju,

Comments below :)

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> Code to create platform device for the IMC counters.
> Paltform devices are created based on the IMC compatibility
> string.
>
> New Config flag "CONFIG_HV_PERF_IMC_CTRS" add to contain the
> IMC counter changes.

I don't think we need a separate config, it can just use
CONFIG_PPC_POWERNV.

I don't think we'll ever want to turn it off for powernv, unless we're
trying to build a small kernel, in which case we'll turn of PERF
entirely.

> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> new file mode 100644
> index 000000000000..5b1045c81af4
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -0,0 +1,73 @@
> +/*
> + * OPAL IMC interface detection driver
> + * Supported on POWERNV platform
> + *
> + * Copyright	(C) 2017 Madhavan Srinivasan, IBM Corporation.
> + *		(C) 2017 Anju T Sudhakar, IBM Corporation.
> + *		(C) 2017 Hemant K Shaw, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

We usually don't include that part in every file.

> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/fs.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/poll.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/crash_dump.h>
> +#include <asm/opal.h>
> +#include <asm/io.h>
> +#include <asm/uaccess.h>
> +#include <asm/cputable.h>
> +#include <asm/imc-pmu.h>
> +
> +static int opal_imc_counters_probe(struct platform_device *pdev)
> +{
> +	struct device_node *imc_dev = NULL;
> +
> +	if (!pdev || !pdev->dev.of_node)
> +		return -ENODEV;

We don't need that level of paranoia :)

> +	/*
> +	 * Check whether this is kdump kernel. If yes, just return.
> +	 */
> +	if (is_kdump_kernel())
> +		return -ENODEV;

Hmm, that's a bit unusual. Is there any particular reason to do that for
this driver?

> +	imc_dev = pdev->dev.of_node;
> +	if (!imc_dev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id opal_imc_match[] = {
> +	{ .compatible = IMC_DTB_COMPAT },
> +	{},
> +};
> +
> +static struct platform_driver opal_imc_driver = {
> +	.driver = {
> +		.name = "opal-imc-counters",
> +		.of_match_table = opal_imc_match,
> +	},
> +	.probe = opal_imc_counters_probe,
> +};
> +

This can't be built as a module, so it should not be using MODULE macros.

> +MODULE_DEVICE_TABLE(of, opal_imc_match);

Drop that.

> +module_platform_driver(opal_imc_driver);

Use builtin_platform_driver().

> +MODULE_DESCRIPTION("PowerNV OPAL IMC driver");
> +MODULE_LICENSE("GPL");

Drop those.

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 59684b4af4d1..fbdca259ea76 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -705,6 +707,17 @@ static void opal_pdev_init(const char *compatible)
>  		of_platform_device_create(np, NULL, NULL);
>  }
>  
> +#ifdef CONFIG_HV_PERF_IMC_CTRS
> +static void __init opal_imc_init_dev(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
> +	if (np)
> +		of_platform_device_create(np, NULL, NULL);
> +}
> +#endif

That doesn't need the #ifdef.

>  static int kopald(void *unused)
>  {
>  	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
> @@ -778,6 +791,11 @@ static int __init opal_init(void)
>  	/* Setup a heatbeat thread if requested by OPAL */
>  	opal_init_heartbeat();
>  
> +#ifdef CONFIG_HV_PERF_IMC_CTRS
> +	/* Detect IMC pmu counters support and create PMUs */
> +	opal_imc_init_dev();
> +#endif
> +

Neither here.

>  	/* Create leds platform devices */
>  	leds = of_find_node_by_path("/ibm,opal/leds");
>  	if (leds) {
> -- 
> 2.11.0


cheers
