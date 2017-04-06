Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzCpk3M89zDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 16:43:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v366ha0U082929
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 02:43:39 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29nbp0ue5x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 02:43:39 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 12:13:29 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v366hLvx16842818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 12:13:21 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v366hOUn023671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 12:13:26 +0530
Subject: Re: [PATCH v6 04/11] powerpc/perf: Add event attribute and group to
 IMC pmus
To: Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-5-git-send-email-maddy@linux.vnet.ibm.com>
 <87bmscly5u.fsf@possimpible.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 6 Apr 2017 12:13:23 +0530
MIME-Version: 1.0
In-Reply-To: <87bmscly5u.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c25cd134-9c53-5523-c4ad-faeef02e2af2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 April 2017 07:41 AM, Daniel Axtens wrote:
> Hi,
>
>> Device tree IMC driver code parses the IMC units and their events. It
>> passes the information to IMC pmu code which is placed in powerpc/perf
>> as "imc-pmu.c".
>>
>> This patch creates only event attributes and attribute groups for the
>> IMC pmus.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/Makefile                |  6 +-
>>   arch/powerpc/perf/imc-pmu.c               | 97 +++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/powernv/opal-imc.c | 12 +++-
>>   3 files changed, 112 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/powerpc/perf/imc-pmu.c
>>
>> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
>> index 4d606b99a5cb..d0d1f04203c7 100644
>> --- a/arch/powerpc/perf/Makefile
>> +++ b/arch/powerpc/perf/Makefile
>> @@ -2,10 +2,14 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>>   
>>   obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
>>   
>> +imc-$(CONFIG_PPC_POWERNV)       += imc-pmu.o
>> +
>>   obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
>>   obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
>>   				   power5+-pmu.o power6-pmu.o power7-pmu.o \
>> -				   isa207-common.o power8-pmu.o power9-pmu.o
>> +				   isa207-common.o power8-pmu.o power9-pmu.o \
>> +				   $(imc-y)
> Hmm, this seems... obtuse. Will the IMC stuff fail to compile on
> non-powerNV? Can we just link it in like we do with every other sort of
> performance counter and let runtime detection do its thing?
Yes. This is true. Also, in powernv_defconfig, we could
have perf_events config disabled. So will address this.

>
>> +
>>   obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
>>   
>>   obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> new file mode 100644
>> index 000000000000..ec464c76b749
>> --- /dev/null
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Nest Performance Monitor counter support.
>> + *
>> + * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
>> + *	     (C) 2016 Hemant K Shaw, IBM Corporation.
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation.
>> + */
>> +#include <linux/perf_event.h>
>> +#include <linux/slab.h>
>> +#include <asm/opal.h>
>> +#include <asm/imc-pmu.h>
>> +#include <asm/cputhreads.h>
>> +#include <asm/smp.h>
>> +#include <linux/string.h>
>> +
>> +struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>> +struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>> +
>> +/* dev_str_attr : Populate event "name" and string "str" in attribute */
>> +static struct attribute *dev_str_attr(const char *name, const char *str)
>> +{
>> +	struct perf_pmu_events_attr *attr;
>> +
>> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
>> +
>> +	sysfs_attr_init(&attr->attr.attr);
>> +
>> +	attr->event_str = str;
>> +	attr->attr.attr.name = name;
>> +	attr->attr.attr.mode = 0444;
>> +	attr->attr.show = perf_event_sysfs_show;
>> +
>> +	return &attr->attr.attr;
>> +}
>> +
>> +/*
>> + * update_events_in_group: Update the "events" information in an attr_group
>> + *                         and assign the attr_group to the pmu "pmu".
>> + */
>> +static int update_events_in_group(struct imc_events *events,
>> +				  int idx, struct imc_pmu *pmu)
> So I've probably missed a key point in the earlier patches, but for the
> life of me I cannot figure out what idx is supposed to represent.
Ok will add comment. Idea is to keep track of number of events
to update when we create the event_attribute.

>
>> +{
>> +	struct attribute_group *attr_group;
>> +	struct attribute **attrs;
>> +	int i;
>> +
>> +	/* Allocate memory for attribute group */
>> +	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
>> +	if (!attr_group)
>> +		return -ENOMEM;
>> +
>> +	/* Allocate memory for attributes */
>> +	attrs = kzalloc((sizeof(struct attribute *) * (idx + 1)), GFP_KERNEL);
> Also, idx is an int, so:
>   - things will go wrong if idx is -1
>   - things will go very wrong if idx is -2
>   - do you need to do some sort of validation to make sure it's within
>     bounds? If not in this function, what function ensures the necessary
>     'sanity check' preconditions for idx?

Yes, valid point. Should add sanity check for this variable.


>
>> +	if (!attrs) {
>> +		kfree(attr_group);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	attr_group->name = "events";
>> +	attr_group->attrs = attrs;
>> +	for (i = 0; i < idx; i++, events++) {
>> +		attrs[i] = dev_str_attr((char *)events->ev_name,
>> +					(char *)events->ev_value);
>> +	}
>> +
>> +	pmu->attr_groups[0] = attr_group;
> Again, I may have missed something, but what's special about group 0?
> Patch 1 lets you have up to 4 groups - are they used elsewhere?

Each entry in the group is a specific attribute for the PMU unit.
So we use group 0 as event and group 1/2 as format and cpumask
attributes.

Will add comment to explain that.

>
>> +	return 0;
>> +}
>> +
>> +/*
>> + * init_imc_pmu : Setup the IMC pmu device in "pmu_ptr" and its events
>> + *                "events".
>> + * Setup the cpu mask information for these pmus and setup the state machine
>> + * hotplug notifiers as well.
> I cannot figure out how this function sets cpu mask information or sets
> up hotplug notifiers. Is this done in a later patch? (looking at the
> subject lines - perhaps patch 6?)

Yes. Its done in patch6, Will remove that text since it confusing here.

>
>> + */
>> +int init_imc_pmu(struct imc_events *events, int idx,
>> +		 struct imc_pmu *pmu_ptr)
> Should this be marked __init, or can it be called in a hotplug path?

Yes. I will.
>
>> +{
>> +	int ret = -ENODEV;
>> +
>> +	ret = update_events_in_group(events, idx, pmu_ptr);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	/* Only free the attr_groups which are dynamically allocated  */
>> +	if (pmu_ptr->attr_groups[0]) {
>> +		kfree(pmu_ptr->attr_groups[0]->attrs);
>> +		kfree(pmu_ptr->attr_groups[0]);
>> +	}
>> +
>> +	return ret;
>> +}
>> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
>> index ba0203e669c0..73c46703c2af 100644
>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>> @@ -32,8 +32,11 @@
>>   #include <asm/cputable.h>
>>   #include <asm/imc-pmu.h>
>>   
>> -struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>> -struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>> +extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>> +extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
> Why are these definitions being moved?
> If they're still needed in this file, should the extern lines live in a
> header file?
We primarily use these values in the pmu functions. But will add
the extern to the header file.

Thanks for review

Maddy
>
>> +
>> +extern int init_imc_pmu(struct imc_events *events,
>> +			int idx, struct imc_pmu *pmu_ptr);
>>   
>>   static int imc_event_info(char *name, struct imc_events *events)
>>   {
>> @@ -379,6 +382,11 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
>>   		idx += ret;
>>   	}
>>   
>> +	ret = init_imc_pmu(events, idx, pmu_ptr);
>> +	if (ret) {
>> +		pr_err("IMC PMU %s Register failed\n", pmu_ptr->pmu.name);
>> +		goto free_events;
>> +	}
>>   	return 0;
>>   
>>   free_events:
>> -- 
>> 2.7.4
> Regards,
> Daniel
>
