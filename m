Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxsMG1J1GzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 11:48:41 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 81so33585346pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 18:48:41 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 02/11] powerpc/powernv: Autoload IMC device driver
 module
In-Reply-To: <1491231308-15282-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-3-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 11:48:36 +1000
Message-ID: <87inmlkknf.fsf@possimpible.ozlabs.ibm.com>
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

Hi,

> +		do {
> +			pages = PAGE_SIZE * i;
> +			pcni->vbase[i++] = (u64)phys_to_virt(pcni->pbase +
> +							     pages);
> +		} while (i < (pcni->size / PAGE_SIZE));

I also just noticed that there's no check here against
IMC_NEST_MAX_PAGES: should that be inserted? (If for no other reason
than to stop every static analysis tool complaining!)

Daniel

> +	}
> +
> +	return 0;
> +err:
> +	return -ENODEV;
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
> +MODULE_DEVICE_TABLE(of, opal_imc_match);
> +module_platform_driver(opal_imc_driver);
> +MODULE_DESCRIPTION("PowerNV OPAL IMC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index e0f856bfbfe8..85ea1296f030 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -14,6 +14,7 @@
>  #include <linux/printk.h>
>  #include <linux/types.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
>  #include <linux/interrupt.h>
> @@ -30,6 +31,7 @@
>  #include <asm/opal.h>
>  #include <asm/firmware.h>
>  #include <asm/mce.h>
> +#include <asm/imc-pmu.h>
>  
>  #include "powernv.h"
>  
> @@ -631,6 +633,15 @@ static void opal_pdev_init(const char *compatible)
>  		of_platform_device_create(np, NULL, NULL);
>  }
>  
> +static void opal_imc_init_dev(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
> +	if (np)
> +		of_platform_device_create(np, NULL, NULL);
> +}
> +
>  static int kopald(void *unused)
>  {
>  	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
> @@ -704,6 +715,9 @@ static int __init opal_init(void)
>  	/* Setup a heatbeat thread if requested by OPAL */
>  	opal_init_heartbeat();
>  
> +	/* Detect IMC pmu counters support and create PMUs */
> +	opal_imc_init_dev();
> +
>  	/* Create leds platform devices */
>  	leds = of_find_node_by_path("/ibm,opal/leds");
>  	if (leds) {
> -- 
> 2.7.4
