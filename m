Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWlKF0HvMzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 13:00:16 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1R1sm8J021426
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 21:00:14 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28u640hymj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 21:00:13 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 27 Feb 2017 12:00:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BAD482BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 13:00:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1R1xuPr53018698
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 13:00:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1R1xVwA013308
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 12:59:31 +1100
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 12:59:07 +1100
MIME-Version: 1.0
In-Reply-To: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ec7f0ed8-58b5-cdfb-63a9-d91a7cb8022e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/02/17 17:20, Matt Brown wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Changes look good, thanks for addressing the comments! Still a couple of 
minor points below, otherwise:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Stewart: this might need your ACK?

> ---
>
> Changes between v2 to v3:
> 	- fixed header comments
> 	- simplified if statement
>
> ---
>  arch/powerpc/include/asm/opal.h            |  1 +
>  arch/powerpc/platforms/powernv/Makefile    |  1 +
>  arch/powerpc/platforms/powernv/opal-hdat.c | 65 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c      |  2 +
>  4 files changed, 69 insertions(+)
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
> index b5d98cb..9a0c9d6 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -3,6 +3,7 @@ obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
>  obj-y			+= opal-kmsg.o
> +obj-y			+= opal-hdat.o

Normally we keep putting new object files on the same line until it gets 
long enough that we have to break it. This is very minor though :)

>
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
> new file mode 100644
> index 0000000..3315dd3
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
> @@ -0,0 +1,65 @@
> +/*
> + * PowerNV OPAL HDAT interface
> + *
> + * Author: Matt Brown <matthew.brown.dev@gmail.com>
> + *
> + * Copyright 2017 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
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

As Oliver pointed out, we could do with a better name than hdat_inf - 
it's only one character away from the name of the struct type. Hmm, 
perhaps "hdat_location", or maybe Oliver has a better suggestion.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
