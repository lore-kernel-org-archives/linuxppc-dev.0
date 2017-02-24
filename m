Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTzvQ0C3tzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 16:20:18 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 1so1716372pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 21:20:17 -0800 (PST)
Message-ID: <1487913611.23895.38.camel@gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: add hdat attribute to sysfs
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Feb 2017 16:20:11 +1100
In-Reply-To: <20170224042828.5268-1-matthew.brown.dev@gmail.com>
References: <20170224042828.5268-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 15:28 +1100, Matt Brown wrote:
> The HDAT data area is consumed by skiboot and turned into a device-
> tree.
> In some cases we would like to look directly at the HDAT, so this
> patch
> adds a sysfs node to allow it to be viewed.  This is not possible
> through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem
> filter.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
Your first patch, nice work! :)

See below.
> ---
> 
> Between v1 and v2 of the patch the following changes were made.
> Changelog:
> 	- moved hdat code into opal-hdat.c
> 	- added opal-hdat to the makefile
> 	- changed struct and variable names from camelcase
> ---
>  arch/powerpc/include/asm/opal.h            |  1 +
>  arch/powerpc/platforms/powernv/Makefile    |  1 +
>  arch/powerpc/platforms/powernv/opal-hdat.c | 63
> ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c      |  2 +
>  4 files changed, 67 insertions(+)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-hdat.c
> 
> diff --git a/arch/powerpc/include/asm/opal.h
> b/arch/powerpc/include/asm/opal.h
> index 5c7db0f..b26944e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
>  extern int opal_sensor_init(void);
>  extern int opal_hmi_handler_init(void);
>  extern int opal_event_init(void);
> +extern void opal_hdat_sysfs_init(void);
>  
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/Makefile
> b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..9a0c9d6 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -3,6 +3,7 @@ obj-y			+= opal-rtc.o opal-
> nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-
> sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-
> power.o opal-irqchip.o
>  obj-y			+= opal-kmsg.o
> +obj-y			+= opal-hdat.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c
> b/arch/powerpc/platforms/powernv/opal-hdat.c
> new file mode 100644
> index 0000000..bd305e0
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
> @@ -0,0 +1,63 @@
> +/*
> + * PowerNV OPAL in-memory console interface
> + *
> + * Copyright 2014 IBM Corp.
2014?
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
Check with someone maybe, but I thought we had to use V2.
> + */
> +
> +#include <asm/io.h>
> +#include <asm/opal.h>
> +#include <linux/of.h>
> +#include <linux/types.h>
> +
> +struct hdat_info {
> +	char *base;
> +	u64 size;
> +};
> +
> +static struct hdat_info hdat_inf;
> +
> +/* Read function for HDAT attribute in sysfs */
> +static ssize_t hdat_read(struct file *file, struct kobject *kobj,
I assume this is just misaligned in my mail client...
> +			 struct bin_attribute *bin_attr, char *to,
> +			 loff_t pos, size_t count)
> +{
> +	if (!hdat_inf.base)
> +		return -ENODEV;
> +
> +	return memory_read_from_buffer(to, count, &pos,
> hdat_inf.base,
> +					hdat_inf.size);
> +}
> +
> +
> +/* HDAT attribute for sysfs */
> +static struct bin_attribute hdat_attr = {
> +	.attr = {.name = "hdat", .mode = 0444},
> +	.read = hdat_read
> +};
> +
> +void __init opal_hdat_sysfs_init(void)
> +{
> +	u64 hdat_addr[2];
> +
> +	/* Check for the hdat-map prop in device-tree */
> +	if (of_property_read_u64_array(opal_node, "hdat-map",
> hdat_addr, 2)) {
> +		pr_debug("OPAL: Property hdat-map not found.\n");
> +		return;
> +	}
> +
> +	/* Print out hdat-map values. [0]: base, [1]: size */
> +	pr_debug("OPAL: HDAT Base address: %#llx\n", hdat_addr[0]);
> +	pr_debug("OPAL: HDAT Size: %#llx\n", hdat_addr[1]);
> +
> +	hdat_inf.base = phys_to_virt(hdat_addr[0]);
> +	hdat_inf.size = hdat_addr[1];
> +
> +	if (sysfs_create_bin_file(opal_kobj, &hdat_attr) != 0)
							 ^^^^
							Not Required
This can be replaced with:
"if (sysfs_create_bin_file(opal_kobj, &hdat_attr))"
> +		pr_debug("OPAL: sysfs file creation for HDAT
> failed");
> +
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal.c
> b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..cae3745 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -740,6 +740,8 @@ static int __init opal_init(void)
>  		opal_sys_param_init();
>  		/* Setup message log sysfs interface. */
>  		opal_msglog_sysfs_init();
> +		/* Create hdat object under sys/firmware/opal */
> +		opal_hdat_sysfs_init();
>  	}
>  
>  	/* Initialize platform devices: IPMI backend, PRD & flash
> interface */

Suraj
