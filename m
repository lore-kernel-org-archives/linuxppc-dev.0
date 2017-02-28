Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXrFq68QGzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 07:46:07 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1SKjgEp019395
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 15:46:05 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wdxxqa6g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 15:46:05 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 13:46:04 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v4] powerpc/powernv: add hdat attribute to sysfs
In-Reply-To: <20170228075503.20387-1-matthew.brown.dev@gmail.com>
References: <20170228075503.20387-1-matthew.brown.dev@gmail.com>
Date: Wed, 01 Mar 2017 07:45:53 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k28acada.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Brown <matthew.brown.dev@gmail.com> writes:
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> Changes between v3 and v4:
> 	- changed sysfs attribute permissions from 0444 to 0400
> 	- fixed makefile to be on same line
> 	- fixed authorship/copyright info
> 	- re-ordered includes
> 	- changed hdat_info struct to a static struct
>
> ---
>  arch/powerpc/include/asm/opal.h            |  1 +
>  arch/powerpc/platforms/powernv/Makefile    |  2 +-
>  arch/powerpc/platforms/powernv/opal-hdat.c | 60 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c      |  2 +
>  4 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-hdat.c
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 5c7db0f..b26944e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
>  extern int opal_sensor_init(void);
>  extern int opal_hmi_handler_init(void);
>  extern int opal_event_init(void);
> +extern void opal_hdat_sysfs_init(void);
>
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..3826b70 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> -obj-y			+= opal-kmsg.o
> +obj-y			+= opal-kmsg.o opal-hdat.o
>
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
> new file mode 100644
> index 0000000..19647fd
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
> @@ -0,0 +1,60 @@
> +/*
> + * PowerNV OPAL HDAT interface
> + *
> + * Copyright 2017, Matt Brown, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/types.h>
> +#include <asm/io.h>
> +#include <asm/opal.h>
> +
> +static struct {
> +	char *base;
> +	u64 size;
> +} hdat_info;
> +
> +/* Read function for HDAT attribute in sysfs */
> +static ssize_t hdat_read(struct file *file, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *to,
> +			 loff_t pos, size_t count)
> +{
> +	if (!hdat_info.base)
> +		return -ENODEV;
> +
> +	return memory_read_from_buffer(to, count, &pos, hdat_info.base,
> +					hdat_info.size);
> +}
> +
> +/* HDAT attribute for sysfs */
> +static struct bin_attribute hdat_attr = {
> +	.attr = {.name = "hdat", .mode = 0400},
> +	.read = hdat_read
> +};

Why not BIN_ATTR_RO (like opal_export_symmap() does) ?

(I have comments/thoughts on the OPAL side as well)

-- 
Stewart Smith
OPAL Architect, IBM.
