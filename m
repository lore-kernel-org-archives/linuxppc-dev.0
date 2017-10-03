Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5ytP2k3mzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 23:25:48 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93CPMK9131430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 08:25:46 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dc993m1kd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 08:25:42 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 22:25:37 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93CPYHm38994072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 23:25:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v93CPPm2019159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 23:25:25 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/perf: Add compact mode pmu support for powernv
Date: Tue,  3 Oct 2017 17:55:15 +0530
Message-Id: <1507033515-13871-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of the power processor generation performance monitoring
unit (PMU) driver code is bundled in the kernel and one of those
is enabled/registered based on the oprofile_cpu_type check at
the boot.

But things get little tricky incase of "compact" mode boot.
IBM POWER System Server based processors has a compactibility
mode feature, which simpily put is, Nth generation processor
(lets say POWER8) will act and appear in a mode consistent
with an earlier generation (N-1) processor (that is POWER7).
And in this "compact" mode boot, kernel modify the
"oprofile_cpu_type" to be Nth generation (POWER8). If Nth
generation pmu driver is bundled (POWER8), it gets registered.

Key dependency here is to have distro support for latest
processor performance monitoring support. Patch here adds
a generic "compact-mode" performance monitoring driver to
be register in absence of powernv platform specific pmu driver.

Driver supports only "cycles" and "instruction" events.
"0x0001e" used as event code for "cycles" and "0x00002"
used as event code for "instruction" events. New file
called "compact-pmu.c" is created to contain the driver
specific code. And base raw event code format modeled
on power9. Currently patch checks for "oprofile_cpu_type"
in the cpufeatures_setup_finished() to identify platform
specific driver initialization.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c |  33 +++++
 arch/powerpc/perf/Makefile        |   3 +-
 arch/powerpc/perf/compact-pmu.c   | 247 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/compact-pmu.c

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 1df770e8cbe0..c283b6cc5132 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -474,6 +474,34 @@ static int __init feat_enable_pmu_power9(struct dt_cpu_feature *f)
 	return 1;
 }
 
+static void check_pmu_setup(void)
+{
+	/*
+	 * Both "oprofile_cpu_type" and CPU_FTR_ARCH_300 checked
+	 * for enabling compact mode pmu. Compact mode pmu is a
+	 * basic pmu driver that will be installed in absence of
+	 * platform specific pmu driver.
+	 */
+	if ((cur_cpu_spec->cpu_features & CPU_FTR_ARCH_300) &&
+		!cur_cpu_spec->oprofile_cpu_type) {
+
+		hfscr_pmu_enable();
+
+		/* Use power9 setup function since CPU_FTR_ARCH_300 enabled */
+		init_pmu_power9();
+		init_pmu_registers = init_pmu_power9;
+
+		cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+
+		cur_cpu_spec->num_pmcs		= 6;
+		cur_cpu_spec->pmc_type		= PPC_PMC_IBM;
+		cur_cpu_spec->oprofile_cpu_type = "ppc64/compact-mode";
+
+		pr_debug("Enabling compact mode pmu\n");
+	}
+}
+
 static int __init feat_enable_tm(struct dt_cpu_feature *f)
 {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -750,6 +778,11 @@ static void __init cpufeatures_setup_finished(void)
 	system_registers.hfscr = mfspr(SPRN_HFSCR);
 	system_registers.fscr = mfspr(SPRN_FSCR);
 
+	/*
+	 * If no pmu driver loaded, load a default basic pmu driver 
+	 */
+	check_pmu_setup();
+
 	cpufeatures_flush_tlb();
 
 	pr_info("final cpu/mmu features = 0x%016lx 0x%08x\n",
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 3f3a5ce66495..311144929b6d 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -5,7 +5,8 @@ obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   isa207-common.o power8-pmu.o power9-pmu.o
+				   isa207-common.o power8-pmu.o power9-pmu.o\
+				   compact-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
diff --git a/arch/powerpc/perf/compact-pmu.c b/arch/powerpc/perf/compact-pmu.c
new file mode 100644
index 000000000000..67fec7706fef
--- /dev/null
+++ b/arch/powerpc/perf/compact-pmu.c
@@ -0,0 +1,247 @@
+/*
+ * Performance counter support.
+ *
+ * Copyright 2017 Madhavan Srinivasan, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or later version.
+ */
+
+#define pr_fmt(fmt)	"compact-pmu: " fmt
+
+#include "isa207-common.h"
+
+/*
+ * Raw event encoding for Power9:
+ *
+ *        60        56        52        48        44        40        36        32
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *
+ *        28        24        20        16        12         8         4         0
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *                                 [ pmc ]   [unit ]   [ ]   m   [    pmcxsel    ]
+ *                                                     |     |
+ *                                                     |     *- mark
+ *                                                     |
+ *                                                     |
+ *                                                     *- combine
+ *
+ * Below uses IBM bit numbering.
+ *
+ * MMCR1[x:y] = unit    (PMCxUNIT)
+ * MMCR1[24]   = pmc1combine[0]
+ * MMCR1[25]   = pmc1combine[1]
+ * MMCR1[26]   = pmc2combine[0]
+ * MMCR1[27]   = pmc2combine[1]
+ * MMCR1[28]   = pmc3combine[0]
+ * MMCR1[29]   = pmc3combine[1]
+ * MMCR1[30]   = pmc4combine[0]
+ * MMCR1[31]   = pmc4combine[1]
+ *
+ */
+
+/*
+ * Some power9 event codes.
+ */
+#define EVENT(_name, _code)	_name = _code,
+
+enum {
+EVENT(PM_CYC,					0x0001e)
+EVENT(PM_INST_CMPL,				0x00002)
+};
+
+#undef EVENT
+
+GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
+GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
+
+static struct attribute *compact_events_attr[] = {
+	GENERIC_EVENT_PTR(PM_CYC),
+	GENERIC_EVENT_PTR(PM_INST_CMPL),
+	NULL
+};
+
+static struct attribute_group compact_pmu_events_group = {
+	.name = "events",
+	.attrs = compact_events_attr,
+};
+
+PMU_FORMAT_ATTR(event,		"config:0-19");
+PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
+PMU_FORMAT_ATTR(mark,		"config:8");
+PMU_FORMAT_ATTR(combine,	"config:10-11");
+PMU_FORMAT_ATTR(unit,		"config:12-15");
+PMU_FORMAT_ATTR(pmc,		"config:16-19");
+
+static struct attribute *compact_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcxsel.attr,
+	&format_attr_mark.attr,
+	&format_attr_combine.attr,
+	&format_attr_unit.attr,
+	&format_attr_pmc.attr,
+	NULL,
+};
+
+static struct attribute_group compact_pmu_format_group = {
+	.name = "format",
+	.attrs = compact_pmu_format_attr,
+};
+
+static const struct attribute_group *compact_pmu_attr_groups[] = {
+	&compact_pmu_format_group,
+	&compact_pmu_events_group,
+	NULL,
+};
+
+static int compact_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int compact_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[ C(L1D) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+	},
+	[ C(L1I) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+	},
+	[ C(LL) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+	},
+	[ C(DTLB) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+	},
+	[ C(ITLB) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+	},
+	[ C(BPU) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+	},
+	[ C(NODE) ] = {
+		[ C(OP_READ) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_WRITE) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+		[ C(OP_PREFETCH) ] = {
+			[ C(RESULT_ACCESS) ] = -1,
+			[ C(RESULT_MISS)   ] = -1,
+		},
+	},
+};
+
+#undef C
+
+static struct power_pmu compact_pmu = {
+	.name			= "COMPACT-MODE",
+	.n_counter		= MAX_PMU_COUNTERS,
+	.add_fields		= ISA207_ADD_FIELDS,
+	.test_adder		= ISA207_TEST_ADDER,
+	.compute_mmcr		= isa207_compute_mmcr,
+	.get_constraint		= isa207_get_constraint,
+	.disable_pmc		= isa207_disable_pmc,
+	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
+	.n_generic		= ARRAY_SIZE(compact_generic_events),
+	.generic_events		= compact_generic_events,
+	.cache_events		= &compact_cache_events,
+	.attr_groups		= compact_pmu_attr_groups,
+};
+
+static int __init init_compact_pmu(void)
+{
+	int rc = 0;
+
+	/* Comes from cpu_specs[] */
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/compact-mode"))
+		return -ENODEV;
+
+	rc = register_power_pmu(&compact_pmu);
+	if (rc)
+		return rc;
+
+	/* Tell userspace that EBB is supported */
+	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
+
+	return 0;
+}
+early_initcall(init_compact_pmu);
-- 
2.7.4
