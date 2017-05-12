Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPHJZ5HLWzDqbm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 14:37:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C4YEOC131408
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 00:37:31 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2acrqhjh36-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 00:37:31 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 12 May 2017 14:37:28 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4C4bJMo61472994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 14:37:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4C4aq3x025042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 14:36:53 +1000
Subject: Re: [PATCH v8 02/10] powerpc/powernv: Autoload IMC device driver
 module
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-3-git-send-email-anju@linux.vnet.ibm.com>
 <87wp9nj0ji.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 10:06:26 +0530
MIME-Version: 1.0
In-Reply-To: <87wp9nj0ji.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <cf53fafa-4b5e-45e6-2104-8c580251467f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 11 May 2017 01:19 PM, Stewart Smith wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>> This patch does three things :
>>   - Enables "opal.c" to create a platform device for the IMC interface
>>     according to the appropriate compatibility string.
>>   - Find the reserved-memory region details from the system device tree
>>     and get the base address of HOMER (Reserved memory) region address for each chip.
>>   - We also get the Nest PMU counter data offsets (in the HOMER region)
>>     and their sizes. The offsets for the counters' data are fixed and
>>     won't change from chip to chip.
>>
>> The device tree parsing logic is separated from the PMU creation
>> functions (which is done in subsequent patches).
>>
>> Patch also adds a CONFIG_HV_PERF_IMC_CTRS for the IMC driver.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/Kconfig    |  10 +++
>>   arch/powerpc/platforms/powernv/Makefile   |   1 +
>>   arch/powerpc/platforms/powernv/opal-imc.c | 140 ++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/powernv/opal.c     |  18 ++++
>>   4 files changed, 169 insertions(+)
>>   create mode 100644 arch/powerpc/platforms/powernv/opal-imc.c
>>
>> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
>> index 3a07e4d..1b90a98 100644
>> --- a/arch/powerpc/platforms/powernv/Kconfig
>> +++ b/arch/powerpc/platforms/powernv/Kconfig
>> @@ -27,3 +27,13 @@ config OPAL_PRD
>>   	help
>>   	  This enables the opal-prd driver, a facility to run processor
>>   	  recovery diagnostics on OpenPower machines
>> +
>> +config HV_PERF_IMC_CTRS
>> +       bool "Hypervisor supplied In Memory Collection PMU events (Nest & Core)"
>> +       default y
>> +       depends on PERF_EVENTS && PPC_POWERNV
>> +       help
>> +	  Enable access to hypervisor supplied in-memory collection counters
>> +	  in perf. IMC counters are available from Power9 systems.
>> +
>> +          If unsure, select Y.
>> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
>> index b5d98cb..715e531 100644
>> --- a/arch/powerpc/platforms/powernv/Makefile
>> +++ b/arch/powerpc/platforms/powernv/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
>>   obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>>   obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
>>   obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
>> +obj-$(CONFIG_HV_PERF_IMC_CTRS) += opal-imc.o
>> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
>> new file mode 100644
>> index 0000000..3a87000
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>> @@ -0,0 +1,140 @@
>> +/*
>> + * OPAL IMC interface detection driver
>> + * Supported on POWERNV platform
>> + *
>> + * Copyright	(C) 2017 Madhavan Srinivasan, IBM Corporation.
>> + *		(C) 2017 Anju T Sudhakar, IBM Corporation.
>> + *		(C) 2017 Hemant K Shaw, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/fs.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/poll.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/crash_dump.h>
>> +#include <asm/opal.h>
>> +#include <asm/io.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/cputable.h>
>> +#include <asm/imc-pmu.h>
>> +
>> +struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>> +
>> +/*
>> + * imc_pmu_setup : Setup the IMC PMUs (children of "parent").
>> + */
>> +static void __init imc_pmu_setup(struct device_node *parent)
>> +{
>> +	if (!parent)
>> +		return;
>> +}
>> +
>> +static int opal_imc_counters_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *imc_dev, *dn, *rm_node = NULL;
>> +	struct perchip_nest_info *pcni;
>> +	u32 pages, nest_offset, nest_size, chip_id;
>> +	int i = 0;
>> +	const __be32 *addrp;
>> +	u64 reg_addr, reg_size;
>> +
>> +	if (!pdev || !pdev->dev.of_node)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * Check whether this is kdump kernel. If yes, just return.
>> +	 */
>> +	if (is_kdump_kernel())
>> +		return -ENODEV;
>> +
>> +	imc_dev = pdev->dev.of_node;
>> +
>> +	/*
>> +	 * Nest counter data are saved in a reserved memory called HOMER.
>> +	 * "imc-nest-offset" identifies the counter data location within HOMER.
>> +	 * size : size of the entire nest-counters region
>> +	 */
>> +	if (of_property_read_u32(imc_dev, "imc-nest-offset", &nest_offset))
>> +		goto err;
>> +
>> +	if (of_property_read_u32(imc_dev, "imc-nest-size", &nest_size))
>> +		goto err;
>> +
>> +	/* Sanity check */
>> +	if ((nest_size/PAGE_SIZE) > IMC_NEST_MAX_PAGES)
>> +		goto err;
>> +
>> +	/* Find the "HOMER region" for each chip */
>> +	rm_node = of_find_node_by_path("/reserved-memory");
>> +	if (!rm_node)
>> +		goto err;
>> +
>> +	/*
>> +	 * We need to look for the "ibm,homer-image" node in the
>> +	 * "/reserved-memory" node.
>> +	 */
>> +	for (dn = of_find_node_by_name(rm_node, "ibm,homer-image"); dn;
>> +			dn = of_find_node_by_name(dn, "ibm,homer-image")) {
>> +
>> +		/* Get the chip id to which the above homer region belongs to */
>> +		if (of_property_read_u32(dn, "ibm,chip-id", &chip_id))
>> +			goto err;
> So, I was thinking on this (and should probably comment on the firmware
> side as well).
>
> I'd prefer an OPAL interface where instead of looking up where
> ibm,homer-image is, we provide the kernel with a base address and then
> have offsets into it.
>
> That way, we don't tie the kernel code to counters that are only in the
> HOMER region.

Yes. This make sense. Adding something like this to IMC node
will be fine?

     chip@<id> {
         base_addr = < addr >;
         ibm,chip-id = < id>;
     };

Maddy

>
>
