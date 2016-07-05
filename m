Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk7785c5szDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 12:26:44 +1000 (AEST)
Message-ID: <1467680437.30027.32.camel@neuling.org>
Subject: Re: [PATCH 5/6] powerpc/perf: Power9 PMU support
From: Michael Neuling <mikey@neuling.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 05 Jul 2016 11:00:37 +1000
In-Reply-To: <1466962629-30692-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1466962629-30692-5-git-send-email-maddy@linux.vnet.ibm.com>
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

On Sun, 2016-06-26 at 23:07 +0530, Madhavan Srinivasan wrote:
>=20


There is still identical code here between power8 and power9. Any reason
you can't merge these too? =C2=A0The two bhrb functions seem to be the same=
.

Mikey

> This patch adds base enablement for the power9 PMU.
>=20
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
> =C2=A0arch/powerpc/perf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A02 +-
> =C2=A0arch/powerpc/perf/power9-pmu.c | 271 ++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A02 files changed, 272 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 arch/powerpc/perf/power9-pmu.c
>=20
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index 92f8ea46238b..f102d5370101 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_PERF_EVENTS)	+=3D callchain.o perf_regs.o
> =C2=A0obj-$(CONFIG_PPC_PERF_CTRS)	+=3D core-book3s.o bhrb.o
> =C2=A0obj64-$(CONFIG_PPC_PERF_CTRS)	+=3D power4-pmu.o ppc970-pmu.o power5=
-pmu.o \
> =C2=A0				=C2=A0=C2=A0=C2=A0power5+-pmu.o power6-pmu.o power7-pmu.o \
> -				=C2=A0=C2=A0=C2=A0isa207-common.o power8-pmu.o
> +				=C2=A0=C2=A0=C2=A0isa207-common.o power8-pmu.o power9-pmu.o
> =C2=A0obj32-$(CONFIG_PPC_PERF_CTRS)	+=3D mpc7450-pmu.o
> =C2=A0
> =C2=A0obj-$(CONFIG_FSL_EMB_PERF_EVENT) +=3D core-fsl-emb.o
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pm=
u.c
> new file mode 100644
> index 000000000000..a2798b5915b9
> --- /dev/null
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -0,0 +1,271 @@
> +/*
> + * Performance counter support for POWER9 processors.
> + *
> + * Copyright 2009 Paul Mackerras, IBM Corporation.
> + * Copyright 2013 Michael Ellerman, IBM Corporation.
> + * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or later version.
> + */
> +
> +#define pr_fmt(fmt)	"power9-pmu: " fmt
> +
> +#include "isa207-common.h"
> +
> +/*
> + * Some power9 event codes.
> + */
> +#define EVENT(_name, _code)	_name =3D _code,
> +
> +enum {
> +#include "power9-events-list.h"
> +};
> +
> +#undef EVENT
> +
> +/* MMCRA IFM bits - POWER9 */
> +#define POWER9_MMCRA_IFM1		0x0000000040000000UL
> +#define POWER9_MMCRA_IFM2		0x0000000080000000UL
> +#define POWER9_MMCRA_IFM3		0x00000000C0000000UL
> +
> +
> +PMU_FORMAT_ATTR(event,		"config:0-49");
> +PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
> +PMU_FORMAT_ATTR(mark,		"config:8");
> +PMU_FORMAT_ATTR(combine,	"config:11");
> +PMU_FORMAT_ATTR(unit,		"config:12-15");
> +PMU_FORMAT_ATTR(pmc,		"config:16-19");
> +PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
> +PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
> +PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
> +PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
> +PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
> +PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
> +
> +static struct attribute *power9_pmu_format_attr[] =3D {
> +	&format_attr_event.attr,
> +	&format_attr_pmcxsel.attr,
> +	&format_attr_mark.attr,
> +	&format_attr_combine.attr,
> +	&format_attr_unit.attr,
> +	&format_attr_pmc.attr,
> +	&format_attr_cache_sel.attr,
> +	&format_attr_sample_mode.attr,
> +	&format_attr_thresh_sel.attr,
> +	&format_attr_thresh_stop.attr,
> +	&format_attr_thresh_start.attr,
> +	&format_attr_thresh_cmp.attr,
> +	NULL,
> +};
> +
> +struct attribute_group power9_pmu_format_group =3D {
> +	.name =3D "format",
> +	.attrs =3D power9_pmu_format_attr,
> +};
> +
> +static const struct attribute_group *power9_pmu_attr_groups[] =3D {
> +	&power9_pmu_format_group,
> +	NULL,
> +};
> +
> +static int power9_generic_events[] =3D {
> +	[PERF_COUNT_HW_CPU_CYCLES] =3D			PM_CYC,
> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D	PM_ICT_NOSLOT_CYC,
> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =3D	PM_CMPLU_STALL,
> +	[PERF_COUNT_HW_INSTRUCTIONS] =3D			PM_INST_CMPL,
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =3D		PM_BRU_CMPL,
> +	[PERF_COUNT_HW_BRANCH_MISSES] =3D			PM_BR_MPRED_CMPL,
> +	[PERF_COUNT_HW_CACHE_REFERENCES] =3D		PM_LD_REF_L1,
> +	[PERF_COUNT_HW_CACHE_MISSES] =3D			PM_LD_MISS_L1_FIN,
> +};
> +
> +static u64 power9_bhrb_filter_map(u64 branch_sample_type)
> +{
> +	u64 pmu_bhrb_filter =3D 0;
> +
> +	/* BHRB and regular PMU events share the same privilege state
> +	=C2=A0* filter configuration. BHRB is always recorded along with a
> +	=C2=A0* regular PMU event. As the privilege state filter is handled
> +	=C2=A0* in the basic PMC configuration of the accompanying regular
> +	=C2=A0* PMU event, we ignore any separate BHRB specific request.
> +	=C2=A0*/
> +
> +	/* No branch filter requested */
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> +		return pmu_bhrb_filter;
> +
> +	/* Invalid branch filter options - HW does not support */
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
> +		return -1;
> +
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
> +		pmu_bhrb_filter |=3D POWER9_MMCRA_IFM1;
> +		return pmu_bhrb_filter;
> +	}
> +
> +	/* Every thing else is unsupported */
> +	return -1;
> +}

> +static void power9_config_bhrb(u64 pmu_bhrb_filter)
> +{
> +	/* Enable BHRB filter in PMU */
> +	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
> +}

Same here.

> +#define C(x)	PERF_COUNT_HW_CACHE_##x
> +
> +/*
> + * Table of generalized cache-related events.
> + * 0 means not supported, -1 means nonsensical, other values
> + * are event codes.
> + */
> +static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] =3D {
> +	[ C(L1D) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_LD_REF_L1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_LD_MISS_L1_FIN,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D 0,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_ST_MISS_L1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_L1_PREF,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D 0,
> +		},
> +	},
> +	[ C(L1I) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_INST_FROM_L1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_L1_ICACHE_MISS,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_L1_DEMAND_WRITE,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_IC_PREF_WRITE,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D 0,
> +		},
> +	},
> +	[ C(LL) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_DATA_FROM_L3,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_DATA_FROM_L3MISS,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_L2_ST,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_L2_ST_MISS,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_L3_PREF_ALL,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D 0,
> +		},
> +	},
> +	[ C(DTLB) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D 0,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_DTLB_MISS,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +	},
> +	[ C(ITLB) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D 0,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_ITLB_MISS,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +	},
> +	[ C(BPU) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D PM_BRU_CMPL,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D PM_BR_MPRED_CMPL,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +	},
> +	[ C(NODE) ] =3D {
> +		[ C(OP_READ) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_WRITE) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +		[ C(OP_PREFETCH) ] =3D {
> +			[ C(RESULT_ACCESS) ] =3D -1,
> +			[ C(RESULT_MISS)=C2=A0=C2=A0=C2=A0] =3D -1,
> +		},
> +	},
> +};
> +
> +#undef C
> +
> +static struct power_pmu power9_pmu =3D {
> +	.name			=3D "POWER9",
> +	.n_counter		=3D MAX_PMU_COUNTERS,
> +	.add_fields		=3D ISA207_ADD_FIELDS,
> +	.test_adder		=3D ISA207_TEST_ADDER,
> +	.compute_mmcr		=3D isa207_compute_mmcr,
> +	.config_bhrb		=3D power9_config_bhrb,
> +	.bhrb_filter_map	=3D power9_bhrb_filter_map,
> +	.get_constraint		=3D isa207_get_constraint,
> +	.disable_pmc		=3D isa207_disable_pmc,
> +	.flags			=3D PPMU_HAS_SIER | PPMU_ARCH_207S,
> +	.n_generic		=3D ARRAY_SIZE(power9_generic_events),
> +	.generic_events		=3D power9_generic_events,
> +	.cache_events		=3D &power9_cache_events,
> +	.attr_groups		=3D power9_pmu_attr_groups,
> +	.bhrb_nr		=3D 32,
> +};
> +
> +static int __init init_power9_pmu(void)
> +{
> +	int rc;
> +
> +	/* Comes from cpu_specs[] */
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/=
power9"))
> +		return -ENODEV;
> +
> +	rc =3D register_power_pmu(&power9_pmu);
> +	if (rc)
> +		return rc;
> +
> +	/* Tell userspace that EBB is supported */
> +	cur_cpu_spec->cpu_user_features2 |=3D PPC_FEATURE2_EBB;
> +
> +	return 0;
> +}
> +early_initcall(init_power9_pmu);
