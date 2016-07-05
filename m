Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk9KX6f5bzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 14:05:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6544fvV010242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 00:05:50 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x6hxc862-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 00:05:50 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 5 Jul 2016 09:35:46 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A485AE0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 09:39:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6545gZt29819024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 09:35:42 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6545gQM019063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 09:35:42 +0530
Subject: Re: [PATCH 5/6] powerpc/perf: Power9 PMU support
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1466962629-30692-5-git-send-email-maddy@linux.vnet.ibm.com>
 <1467680437.30027.32.camel@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 09:35:41 +0530
MIME-Version: 1.0
In-Reply-To: <1467680437.30027.32.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <615a0abb-faa2-d379-4d0c-f92911de21bc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 05 July 2016 06:30 AM, Michael Neuling wrote:
> On Sun, 2016-06-26 at 23:07 +0530, Madhavan Srinivasan wrote:
>
> There is still identical code here between power8 and power9. Any reason
> you can't merge these too?  The two bhrb functions seem to be the same.
In PowerISA v3.0, more bhrb filtering modes are added. And if made common,
we need to have checks for these new filtering mode which can be avoided.
Yes, right now its the same code, but will post the power9 bhrb filtering
mode patches soon.

Maddy

>
> Mikey
>
>> This patch adds base enablement for the power9 PMU.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/Makefile     |   2 +-
>>  arch/powerpc/perf/power9-pmu.c | 271 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 272 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/powerpc/perf/power9-pmu.c
>>
>> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
>> index 92f8ea46238b..f102d5370101 100644
>> --- a/arch/powerpc/perf/Makefile
>> +++ b/arch/powerpc/perf/Makefile
>> @@ -5,7 +5,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
>>  obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
>>  obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
>>  				   power5+-pmu.o power6-pmu.o power7-pmu.o \
>> -				   isa207-common.o power8-pmu.o
>> +				   isa207-common.o power8-pmu.o power9-pmu.o
>>  obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
>>  
>>  obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
>> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
>> new file mode 100644
>> index 000000000000..a2798b5915b9
>> --- /dev/null
>> +++ b/arch/powerpc/perf/power9-pmu.c
>> @@ -0,0 +1,271 @@
>> +/*
>> + * Performance counter support for POWER9 processors.
>> + *
>> + * Copyright 2009 Paul Mackerras, IBM Corporation.
>> + * Copyright 2013 Michael Ellerman, IBM Corporation.
>> + * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or later version.
>> + */
>> +
>> +#define pr_fmt(fmt)	"power9-pmu: " fmt
>> +
>> +#include "isa207-common.h"
>> +
>> +/*
>> + * Some power9 event codes.
>> + */
>> +#define EVENT(_name, _code)	_name = _code,
>> +
>> +enum {
>> +#include "power9-events-list.h"
>> +};
>> +
>> +#undef EVENT
>> +
>> +/* MMCRA IFM bits - POWER9 */
>> +#define POWER9_MMCRA_IFM1		0x0000000040000000UL
>> +#define POWER9_MMCRA_IFM2		0x0000000080000000UL
>> +#define POWER9_MMCRA_IFM3		0x00000000C0000000UL
>> +
>> +
>> +PMU_FORMAT_ATTR(event,		"config:0-49");
>> +PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
>> +PMU_FORMAT_ATTR(mark,		"config:8");
>> +PMU_FORMAT_ATTR(combine,	"config:11");
>> +PMU_FORMAT_ATTR(unit,		"config:12-15");
>> +PMU_FORMAT_ATTR(pmc,		"config:16-19");
>> +PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
>> +PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
>> +PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
>> +PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
>> +PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
>> +PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
>> +
>> +static struct attribute *power9_pmu_format_attr[] = {
>> +	&format_attr_event.attr,
>> +	&format_attr_pmcxsel.attr,
>> +	&format_attr_mark.attr,
>> +	&format_attr_combine.attr,
>> +	&format_attr_unit.attr,
>> +	&format_attr_pmc.attr,
>> +	&format_attr_cache_sel.attr,
>> +	&format_attr_sample_mode.attr,
>> +	&format_attr_thresh_sel.attr,
>> +	&format_attr_thresh_stop.attr,
>> +	&format_attr_thresh_start.attr,
>> +	&format_attr_thresh_cmp.attr,
>> +	NULL,
>> +};
>> +
>> +struct attribute_group power9_pmu_format_group = {
>> +	.name = "format",
>> +	.attrs = power9_pmu_format_attr,
>> +};
>> +
>> +static const struct attribute_group *power9_pmu_attr_groups[] = {
>> +	&power9_pmu_format_group,
>> +	NULL,
>> +};
>> +
>> +static int power9_generic_events[] = {
>> +	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
>> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
>> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
>> +	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
>> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
>> +	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
>> +	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
>> +	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
>> +};
>> +
>> +static u64 power9_bhrb_filter_map(u64 branch_sample_type)
>> +{
>> +	u64 pmu_bhrb_filter = 0;
>> +
>> +	/* BHRB and regular PMU events share the same privilege state
>> +	 * filter configuration. BHRB is always recorded along with a
>> +	 * regular PMU event. As the privilege state filter is handled
>> +	 * in the basic PMC configuration of the accompanying regular
>> +	 * PMU event, we ignore any separate BHRB specific request.
>> +	 */
>> +
>> +	/* No branch filter requested */
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
>> +		return pmu_bhrb_filter;
>> +
>> +	/* Invalid branch filter options - HW does not support */
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
>> +		return -1;
>> +
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
>> +		return -1;
>> +
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
>> +		return -1;
>> +
>> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
>> +		pmu_bhrb_filter |= POWER9_MMCRA_IFM1;
>> +		return pmu_bhrb_filter;
>> +	}
>> +
>> +	/* Every thing else is unsupported */
>> +	return -1;
>> +}
>> +static void power9_config_bhrb(u64 pmu_bhrb_filter)
>> +{
>> +	/* Enable BHRB filter in PMU */
>> +	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
>> +}
> Same here.
>
>> +#define C(x)	PERF_COUNT_HW_CACHE_##x
>> +
>> +/*
>> + * Table of generalized cache-related events.
>> + * 0 means not supported, -1 means nonsensical, other values
>> + * are event codes.
>> + */
>> +static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>> +	[ C(L1D) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_LD_REF_L1,
>> +			[ C(RESULT_MISS)   ] = PM_LD_MISS_L1_FIN,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = 0,
>> +			[ C(RESULT_MISS)   ] = PM_ST_MISS_L1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_L1_PREF,
>> +			[ C(RESULT_MISS)   ] = 0,
>> +		},
>> +	},
>> +	[ C(L1I) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_INST_FROM_L1,
>> +			[ C(RESULT_MISS)   ] = PM_L1_ICACHE_MISS,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_L1_DEMAND_WRITE,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_IC_PREF_WRITE,
>> +			[ C(RESULT_MISS)   ] = 0,
>> +		},
>> +	},
>> +	[ C(LL) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_DATA_FROM_L3,
>> +			[ C(RESULT_MISS)   ] = PM_DATA_FROM_L3MISS,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_L2_ST,
>> +			[ C(RESULT_MISS)   ] = PM_L2_ST_MISS,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_L3_PREF_ALL,
>> +			[ C(RESULT_MISS)   ] = 0,
>> +		},
>> +	},
>> +	[ C(DTLB) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = 0,
>> +			[ C(RESULT_MISS)   ] = PM_DTLB_MISS,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +	},
>> +	[ C(ITLB) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = 0,
>> +			[ C(RESULT_MISS)   ] = PM_ITLB_MISS,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +	},
>> +	[ C(BPU) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
>> +			[ C(RESULT_MISS)   ] = PM_BR_MPRED_CMPL,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +	},
>> +	[ C(NODE) ] = {
>> +		[ C(OP_READ) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_WRITE) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +		[ C(OP_PREFETCH) ] = {
>> +			[ C(RESULT_ACCESS) ] = -1,
>> +			[ C(RESULT_MISS)   ] = -1,
>> +		},
>> +	},
>> +};
>> +
>> +#undef C
>> +
>> +static struct power_pmu power9_pmu = {
>> +	.name			= "POWER9",
>> +	.n_counter		= MAX_PMU_COUNTERS,
>> +	.add_fields		= ISA207_ADD_FIELDS,
>> +	.test_adder		= ISA207_TEST_ADDER,
>> +	.compute_mmcr		= isa207_compute_mmcr,
>> +	.config_bhrb		= power9_config_bhrb,
>> +	.bhrb_filter_map	= power9_bhrb_filter_map,
>> +	.get_constraint		= isa207_get_constraint,
>> +	.disable_pmc		= isa207_disable_pmc,
>> +	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
>> +	.n_generic		= ARRAY_SIZE(power9_generic_events),
>> +	.generic_events		= power9_generic_events,
>> +	.cache_events		= &power9_cache_events,
>> +	.attr_groups		= power9_pmu_attr_groups,
>> +	.bhrb_nr		= 32,
>> +};
>> +
>> +static int __init init_power9_pmu(void)
>> +{
>> +	int rc;
>> +
>> +	/* Comes from cpu_specs[] */
>> +	if (!cur_cpu_spec->oprofile_cpu_type ||
>> +	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
>> +		return -ENODEV;
>> +
>> +	rc = register_power_pmu(&power9_pmu);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Tell userspace that EBB is supported */
>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
>> +
>> +	return 0;
>> +}
>> +early_initcall(init_power9_pmu);
