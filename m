Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNlcl3l96zDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 17:49:43 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4B7ccu7106058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 03:49:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ac5r6ae69-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 03:49:40 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 11 May 2017 03:49:40 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v8 02/10] powerpc/powernv: Autoload IMC device driver
 module
In-Reply-To: <1493907596-11425-3-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-3-git-send-email-anju@linux.vnet.ibm.com>
Date: Thu, 11 May 2017 17:49:21 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp9nj0ji.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> This patch does three things :
>  - Enables "opal.c" to create a platform device for the IMC interface
>    according to the appropriate compatibility string.
>  - Find the reserved-memory region details from the system device tree
>    and get the base address of HOMER (Reserved memory) region address for each chip.
>  - We also get the Nest PMU counter data offsets (in the HOMER region)
>    and their sizes. The offsets for the counters' data are fixed and
>    won't change from chip to chip.
>
> The device tree parsing logic is separated from the PMU creation
> functions (which is done in subsequent patches).
>
> Patch also adds a CONFIG_HV_PERF_IMC_CTRS for the IMC driver.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/Kconfig    |  10 +++
>  arch/powerpc/platforms/powernv/Makefile   |   1 +
>  arch/powerpc/platforms/powernv/opal-imc.c | 140 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c     |  18 ++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c
>
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 3a07e4d..1b90a98 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -27,3 +27,13 @@ config OPAL_PRD
>  	help
>  	  This enables the opal-prd driver, a facility to run processor
>  	  recovery diagnostics on OpenPower machines
> +
> +config HV_PERF_IMC_CTRS
> +       bool "Hypervisor supplied In Memory Collection PMU events (Nest & Core)"
> +       default y
> +       depends on PERF_EVENTS && PPC_POWERNV
> +       help
> +	  Enable access to hypervisor supplied in-memory collection counters
> +	  in perf. IMC counters are available from Power9 systems.
> +
> +          If unsure, select Y.
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..715e531 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
>  obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>  obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
>  obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
> +obj-$(CONFIG_HV_PERF_IMC_CTRS) += opal-imc.o
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> new file mode 100644
> index 0000000..3a87000
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -0,0 +1,140 @@
> +/*
> + * OPAL IMC interface detection driver
> + * Supported on POWERNV platform
> + *
> + * Copyright	(C) 2017 Madhavan Srinivasan, IBM Corporation.
> + *		(C) 2017 Anju T Sudhakar, IBM Corporation.
> + *		(C) 2017 Hemant K Shaw, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
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
> +struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
> +
> +/*
> + * imc_pmu_setup : Setup the IMC PMUs (children of "parent").
> + */
> +static void __init imc_pmu_setup(struct device_node *parent)
> +{
> +	if (!parent)
> +		return;
> +}
> +
> +static int opal_imc_counters_probe(struct platform_device *pdev)
> +{
> +	struct device_node *imc_dev, *dn, *rm_node = NULL;
> +	struct perchip_nest_info *pcni;
> +	u32 pages, nest_offset, nest_size, chip_id;
> +	int i = 0;
> +	const __be32 *addrp;
> +	u64 reg_addr, reg_size;
> +
> +	if (!pdev || !pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	/*
> +	 * Check whether this is kdump kernel. If yes, just return.
> +	 */
> +	if (is_kdump_kernel())
> +		return -ENODEV;
> +
> +	imc_dev = pdev->dev.of_node;
> +
> +	/*
> +	 * Nest counter data are saved in a reserved memory called HOMER.
> +	 * "imc-nest-offset" identifies the counter data location within HOMER.
> +	 * size : size of the entire nest-counters region
> +	 */
> +	if (of_property_read_u32(imc_dev, "imc-nest-offset", &nest_offset))
> +		goto err;
> +
> +	if (of_property_read_u32(imc_dev, "imc-nest-size", &nest_size))
> +		goto err;
> +
> +	/* Sanity check */
> +	if ((nest_size/PAGE_SIZE) > IMC_NEST_MAX_PAGES)
> +		goto err;
> +
> +	/* Find the "HOMER region" for each chip */
> +	rm_node = of_find_node_by_path("/reserved-memory");
> +	if (!rm_node)
> +		goto err;
> +
> +	/*
> +	 * We need to look for the "ibm,homer-image" node in the
> +	 * "/reserved-memory" node.
> +	 */
> +	for (dn = of_find_node_by_name(rm_node, "ibm,homer-image"); dn;
> +			dn = of_find_node_by_name(dn, "ibm,homer-image")) {
> +
> +		/* Get the chip id to which the above homer region belongs to */
> +		if (of_property_read_u32(dn, "ibm,chip-id", &chip_id))
> +			goto err;

So, I was thinking on this (and should probably comment on the firmware
side as well).

I'd prefer an OPAL interface where instead of looking up where
ibm,homer-image is, we provide the kernel with a base address and then
have offsets into it.

That way, we don't tie the kernel code to counters that are only in the
HOMER region.


-- 
Stewart Smith
OPAL Architect, IBM.
