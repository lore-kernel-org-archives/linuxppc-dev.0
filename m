Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 574DAB7C59
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 11:09:50 +1100 (EST)
Date: Thu, 25 Feb 2010 18:09:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] perf_event: e500 support
Message-ID: <20100226000945.GA17094@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implements perf_event support for the Freescale embedded performance
monitor, based on the existing perf_event.c that supports server/classic
chips.

Some limitations:
- Performance monitor interrupts are regular EE interrupts, and thus you
  can't profile places with interrupts disabled.  We may want to implement
  soft IRQ-disabling, with perfmon interrupts exempted and treated as NMIs.
- When trying to schedule multiple event groups at once, and using
  restricted events, situations could arise where scheduling fails even
  though it would be possible.  Consider three groups, each with two events.
  One group has restricted events, the others don't.  The two non-restricted
  groups are scheduled, then one is removed, which happens to occupy the two
  counters that can't do restricted events.  The remaining non-restricted
  group will not be moved to the non-restricted-capable counters to make
  room if the restricted group tries to be scheduled.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Changes from previous version:
- Factored out callchain makefile patch
- Split up header files
- Renamed pmu struct
- Added threshold support

 arch/powerpc/include/asm/perf_event.h              |  133 +----
 arch/powerpc/include/asm/perf_event_fsl_emb.h      |   50 ++
 .../asm/{perf_event.h => perf_event_server.h}      |    4 +-
 arch/powerpc/include/asm/reg_fsl_emb.h             |    2 +-
 arch/powerpc/kernel/Makefile                       |    4 +
 arch/powerpc/kernel/cputable.c                     |    2 +-
 arch/powerpc/kernel/e500-pmu.c                     |  129 ++++
 arch/powerpc/kernel/perf_event_fsl_emb.c           |  654 ++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype             |   10 +
 9 files changed, 874 insertions(+), 114 deletions(-)
 rewrite arch/powerpc/include/asm/perf_event.h (92%)
 create mode 100644 arch/powerpc/include/asm/perf_event_fsl_emb.h
 rename arch/powerpc/include/asm/{perf_event.h => perf_event_server.h} (98%)
 create mode 100644 arch/powerpc/kernel/e500-pmu.c
 create mode 100644 arch/powerpc/kernel/perf_event_fsl_emb.c

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
dissimilarity index 92%
index 3288ce3..e6d4ce6 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -1,110 +1,23 @@
-/*
- * Performance event support - PowerPC-specific definitions.
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/types.h>
-
-#include <asm/hw_irq.h>
-
-#define MAX_HWEVENTS		8
-#define MAX_EVENT_ALTERNATIVES	8
-#define MAX_LIMITED_HWCOUNTERS	2
-
-/*
- * This struct provides the constants and functions needed to
- * describe the PMU on a particular POWER-family CPU.
- */
-struct power_pmu {
-	const char	*name;
-	int		n_counter;
-	int		max_alternatives;
-	unsigned long	add_fields;
-	unsigned long	test_adder;
-	int		(*compute_mmcr)(u64 events[], int n_ev,
-				unsigned int hwc[], unsigned long mmcr[]);
-	int		(*get_constraint)(u64 event_id, unsigned long *mskp,
-				unsigned long *valp);
-	int		(*get_alternatives)(u64 event_id, unsigned int flags,
-				u64 alt[]);
-	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
-	int		(*limited_pmc_event)(u64 event_id);
-	u32		flags;
-	int		n_generic;
-	int		*generic_events;
-	int		(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
-			       [PERF_COUNT_HW_CACHE_OP_MAX]
-			       [PERF_COUNT_HW_CACHE_RESULT_MAX];
-};
-
-/*
- * Values for power_pmu.flags
- */
-#define PPMU_LIMITED_PMC5_6	1	/* PMC5/6 have limited function */
-#define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
-
-/*
- * Values for flags to get_alternatives()
- */
-#define PPMU_LIMITED_PMC_OK	1	/* can put this on a limited PMC */
-#define PPMU_LIMITED_PMC_REQD	2	/* have to put this on a limited PMC */
-#define PPMU_ONLY_COUNT_RUN	4	/* only counting in run state */
-
-extern int register_power_pmu(struct power_pmu *);
-
-struct pt_regs;
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-
-#define PERF_EVENT_INDEX_OFFSET	1
-
-/*
- * Only override the default definitions in include/linux/perf_event.h
- * if we have hardware PMU support.
- */
-#ifdef CONFIG_PPC_PERF_CTRS
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
-/*
- * The power_pmu.get_constraint function returns a 32/64-bit value and
- * a 32/64-bit mask that express the constraints between this event_id and
- * other events.
- *
- * The value and mask are divided up into (non-overlapping) bitfields
- * of three different types:
- *
- * Select field: this expresses the constraint that some set of bits
- * in MMCR* needs to be set to a specific value for this event_id.  For a
- * select field, the mask contains 1s in every bit of the field, and
- * the value contains a unique value for each possible setting of the
- * MMCR* bits.  The constraint checking code will ensure that two events
- * that set the same field in their masks have the same value in their
- * value dwords.
- *
- * Add field: this expresses the constraint that there can be at most
- * N events in a particular class.  A field of k bits can be used for
- * N <= 2^(k-1) - 1.  The mask has the most significant bit of the field
- * set (and the other bits 0), and the value has only the least significant
- * bit of the field set.  In addition, the 'add_fields' and 'test_adder'
- * in the struct power_pmu for this processor come into play.  The
- * add_fields value contains 1 in the LSB of the field, and the
- * test_adder contains 2^(k-1) - 1 - N in the field.
- *
- * NAND field: this expresses the constraint that you may not have events
- * in all of a set of classes.  (For example, on PPC970, you can't select
- * events from the FPU, ISU and IDU simultaneously, although any two are
- * possible.)  For N classes, the field is N+1 bits wide, and each class
- * is assigned one bit from the least-significant N bits.  The mask has
- * only the most-significant bit set, and the value has only the bit
- * for the event_id's class set.  The test_adder has the least significant
- * bit set in the field.
- *
- * If an event_id is not subject to the constraint expressed by a particular
- * field, then it will have 0 in both the mask and value for that field.
- */
+/*
+ * Performance event support - hardware-specific disambiguation
+ *
+ * For now this is a compile-time decision, but eventually it should be
+ * runtime.  This would allow multiplatform perf event support for e300 (fsl
+ * embedded perf counters) plus server/classic, and would accommodate
+ * devices other than the core which provide their own performance counters.
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef CONFIG_PPC_PERF_CTRS
+#include <asm/perf_event_server.h>
+#endif
+
+#ifdef CONFIG_FSL_EMB_PERF_EVENT
+#include <asm/perf_event_fsl_emb.h>
+#endif
diff --git a/arch/powerpc/include/asm/perf_event_fsl_emb.h b/arch/powerpc/include/asm/perf_event_fsl_emb.h
new file mode 100644
index 0000000..718a9fa
--- /dev/null
+++ b/arch/powerpc/include/asm/perf_event_fsl_emb.h
@@ -0,0 +1,50 @@
+/*
+ * Performance event support - Freescale embedded specific definitions.
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <asm/hw_irq.h>
+
+#define MAX_HWEVENTS 4
+
+/* event flags */
+#define FSL_EMB_EVENT_VALID      1
+#define FSL_EMB_EVENT_RESTRICTED 2
+
+/* upper half of event flags is PMLCb */
+#define FSL_EMB_EVENT_THRESHMUL  0x0000070000000000ULL
+#define FSL_EMB_EVENT_THRESH     0x0000003f00000000ULL
+
+struct fsl_emb_pmu {
+	const char	*name;
+	int		n_counter; /* total number of counters */
+
+	/*
+	 * The number of contiguous counters starting at zero that
+	 * can hold restricted events, or zero if there are no
+	 * restricted events.
+	 *
+	 * This isn't a very flexible method of expressing constraints,
+	 * but it's very simple and is adequate for existing chips.
+	 */
+	int		n_restricted;
+
+	/* Returns event flags and PMLCb (FSL_EMB_EVENT_*) */
+	u64		(*xlate_event)(u64 event_id);
+
+	int		n_generic;
+	int		*generic_events;
+	int		(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
+			       [PERF_COUNT_HW_CACHE_OP_MAX]
+			       [PERF_COUNT_HW_CACHE_RESULT_MAX];
+};
+
+int register_fsl_emb_pmu(struct fsl_emb_pmu *);
diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event_server.h
similarity index 98%
rename from arch/powerpc/include/asm/perf_event.h
rename to arch/powerpc/include/asm/perf_event_server.h
index 3288ce3..8f1df12 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -1,5 +1,5 @@
 /*
- * Performance event support - PowerPC-specific definitions.
+ * Performance event support - PowerPC classic/server specific definitions.
  *
  * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
  *
@@ -8,8 +8,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <linux/types.h>
 
+#include <linux/types.h>
 #include <asm/hw_irq.h>
 
 #define MAX_HWEVENTS		8
diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index 0de404d..77bb71c 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -31,7 +31,7 @@
 #define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
 #define PMLCA_CE	0x04000000	/* Condition Enable */
 
-#define PMLCA_EVENT_MASK 0x007f0000	/* Event field */
+#define PMLCA_EVENT_MASK 0x00ff0000	/* Event field */
 #define PMLCA_EVENT_SHIFT	16
 
 #define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 93fd162..8773263 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -99,11 +99,15 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
+
 obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
+obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
+obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
+
 obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
 
 ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2fc82ba..8af4949 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1808,7 +1808,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
-		.oprofile_cpu_type	= "ppc/e500", /* xxx - galak, e500mc? */
+		.oprofile_cpu_type	= "ppc/e500mc",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.cpu_setup		= __setup_cpu_e500mc,
 		.machine_check		= machine_check_e500,
diff --git a/arch/powerpc/kernel/e500-pmu.c b/arch/powerpc/kernel/e500-pmu.c
new file mode 100644
index 0000000..7c07de0
--- /dev/null
+++ b/arch/powerpc/kernel/e500-pmu.c
@@ -0,0 +1,129 @@
+/*
+ * Performance counter support for e500 family processors.
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/string.h>
+#include <linux/perf_event.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Map of generic hardware event types to hardware events
+ * Zero if unsupported
+ */
+static int e500_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = 1,
+	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
+	[PERF_COUNT_HW_CACHE_MISSES] = 41, /* Data L1 cache reloads */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 12,
+	[PERF_COUNT_HW_BRANCH_MISSES] = 15,
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int e500_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	/*
+	 * D-cache misses are not split into read/write/prefetch;
+	 * use raw event 41.
+	 */
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	27,		0	},
+		[C(OP_WRITE)] = {	28,		0	},
+		[C(OP_PREFETCH)] = {	29,		0	},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	2,		60	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	/*
+	 * Assuming LL means L2, it's not a good match for this model.
+	 * It allocates only on L1 castout or explicit prefetch, and
+	 * does not have separate read/write events (but it does have
+	 * separate instruction/data events).
+	 */
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	/*
+	 * There are data/instruction MMU misses, but that's a miss on
+	 * the chip's internal level-one TLB which is probably not
+	 * what the user wants.  Instead, unified level-two TLB misses
+	 * are reported here.
+	 */
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	26,		66	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	12,		15 	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+static int num_events = 128;
+
+/* Upper half of event id is PMLCb, for threshold events */
+static u64 e500_xlate_event(u64 event_id)
+{
+	u32 event_low = (u32)event_id;
+	u64 ret;
+
+	if (event_low >= num_events)
+		return 0;
+
+	ret = FSL_EMB_EVENT_VALID;
+
+	if (event_low >= 76 && event_low <= 81) {
+		ret |= FSL_EMB_EVENT_RESTRICTED;
+		ret |= event_id &
+		       (FSL_EMB_EVENT_THRESHMUL | FSL_EMB_EVENT_THRESH);
+	} else if (event_id &
+	           (FSL_EMB_EVENT_THRESHMUL | FSL_EMB_EVENT_THRESH)) {
+		/* Threshold requested on non-threshold event */
+		return 0;
+	}
+
+	return ret;
+}
+
+static struct fsl_emb_pmu e500_pmu = {
+	.name			= "e500 family",
+	.n_counter		= 4,
+	.n_restricted		= 2,
+	.xlate_event		= e500_xlate_event,
+	.n_generic		= ARRAY_SIZE(e500_generic_events),
+	.generic_events		= e500_generic_events,
+	.cache_events		= &e500_cache_events,
+};
+
+static int init_e500_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type)
+		return -ENODEV;
+
+	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500mc"))
+		num_events = 256;
+	else if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500"))
+		return -ENODEV;
+
+	return register_fsl_emb_pmu(&e500_pmu);
+}
+
+arch_initcall(init_e500_pmu);
diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/kernel/perf_event_fsl_emb.c
new file mode 100644
index 0000000..369872f
--- /dev/null
+++ b/arch/powerpc/kernel/perf_event_fsl_emb.c
@@ -0,0 +1,654 @@
+/*
+ * Performance event support - Freescale Embedded Performance Monitor
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <asm/reg_fsl_emb.h>
+#include <asm/pmc.h>
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/ptrace.h>
+
+struct cpu_hw_events {
+	int n_events;
+	int disabled;
+	u8  pmcs_enabled;
+	struct perf_event *event[MAX_HWEVENTS];
+};
+static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+
+static struct fsl_emb_pmu *ppmu;
+
+/* Number of perf_events counting hardware events */
+static atomic_t num_events;
+/* Used to avoid races in calling reserve/release_pmc_hardware */
+static DEFINE_MUTEX(pmc_reserve_mutex);
+
+/*
+ * If interrupts were soft-disabled when a PMU interrupt occurs, treat
+ * it as an NMI.
+ */
+static inline int perf_intr_is_nmi(struct pt_regs *regs)
+{
+#ifdef __powerpc64__
+	return !regs->softe;
+#else
+	return 0;
+#endif
+}
+
+static void perf_event_interrupt(struct pt_regs *regs);
+
+/*
+ * Read one performance monitor counter (PMC).
+ */
+static unsigned long read_pmc(int idx)
+{
+	unsigned long val;
+
+	switch (idx) {
+	case 0:
+		val = mfpmr(PMRN_PMC0);
+		break;
+	case 1:
+		val = mfpmr(PMRN_PMC1);
+		break;
+	case 2:
+		val = mfpmr(PMRN_PMC2);
+		break;
+	case 3:
+		val = mfpmr(PMRN_PMC3);
+		break;
+	default:
+		printk(KERN_ERR "oops trying to read PMC%d\n", idx);
+		val = 0;
+	}
+	return val;
+}
+
+/*
+ * Write one PMC.
+ */
+static void write_pmc(int idx, unsigned long val)
+{
+	switch (idx) {
+	case 0:
+		mtpmr(PMRN_PMC0, val);
+		break;
+	case 1:
+		mtpmr(PMRN_PMC1, val);
+		break;
+	case 2:
+		mtpmr(PMRN_PMC2, val);
+		break;
+	case 3:
+		mtpmr(PMRN_PMC3, val);
+		break;
+	default:
+		printk(KERN_ERR "oops trying to write PMC%d\n", idx);
+	}
+
+	isync();
+}
+
+/*
+ * Write one local control A register
+ */
+static void write_pmlca(int idx, unsigned long val)
+{
+	switch (idx) {
+	case 0:
+		mtpmr(PMRN_PMLCA0, val);
+		break;
+	case 1:
+		mtpmr(PMRN_PMLCA1, val);
+		break;
+	case 2:
+		mtpmr(PMRN_PMLCA2, val);
+		break;
+	case 3:
+		mtpmr(PMRN_PMLCA3, val);
+		break;
+	default:
+		printk(KERN_ERR "oops trying to write PMLCA%d\n", idx);
+	}
+
+	isync();
+}
+
+/*
+ * Write one local control B register
+ */
+static void write_pmlcb(int idx, unsigned long val)
+{
+	switch (idx) {
+	case 0:
+		mtpmr(PMRN_PMLCB0, val);
+		break;
+	case 1:
+		mtpmr(PMRN_PMLCB1, val);
+		break;
+	case 2:
+		mtpmr(PMRN_PMLCB2, val);
+		break;
+	case 3:
+		mtpmr(PMRN_PMLCB3, val);
+		break;
+	default:
+		printk(KERN_ERR "oops trying to write PMLCB%d\n", idx);
+	}
+
+	isync();
+}
+
+static void fsl_emb_pmu_read(struct perf_event *event)
+{
+	s64 val, delta, prev;
+
+	/*
+	 * Performance monitor interrupts come even when interrupts
+	 * are soft-disabled, as long as interrupts are hard-enabled.
+	 * Therefore we treat them like NMIs.
+	 */
+	do {
+		prev = atomic64_read(&event->hw.prev_count);
+		barrier();
+		val = read_pmc(event->hw.idx);
+	} while (atomic64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
+
+	/* The counters are only 32 bits wide */
+	delta = (val - prev) & 0xfffffffful;
+	atomic64_add(delta, &event->count);
+	atomic64_sub(delta, &event->hw.period_left);
+}
+
+/*
+ * Disable all events to prevent PMU interrupts and to allow
+ * events to be added or removed.
+ */
+void hw_perf_disable(void)
+{
+	struct cpu_hw_events *cpuhw;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	if (!cpuhw->disabled) {
+		cpuhw->disabled = 1;
+
+		/*
+		 * Check if we ever enabled the PMU on this cpu.
+		 */
+		if (!cpuhw->pmcs_enabled) {
+			ppc_enable_pmcs();
+			cpuhw->pmcs_enabled = 1;
+		}
+
+		if (atomic_read(&num_events)) {
+			/*
+			 * Set the 'freeze all counters' bit, and disable
+			 * interrupts.  The barrier is to make sure the
+			 * mtpmr has been executed and the PMU has frozen
+			 * the events before we return.
+			 */
+
+			mtpmr(PMRN_PMGC0, PMGC0_FAC);
+			isync();
+		}
+	}
+	local_irq_restore(flags);
+}
+
+/*
+ * Re-enable all events if disable == 0.
+ * If we were previously disabled and events were added, then
+ * put the new config on the PMU.
+ */
+void hw_perf_enable(void)
+{
+	struct cpu_hw_events *cpuhw;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+	if (!cpuhw->disabled)
+		goto out;
+
+	cpuhw->disabled = 0;
+	ppc_set_pmu_inuse(cpuhw->n_events != 0);
+
+	if (cpuhw->n_events > 0) {
+		mtpmr(PMRN_PMGC0, PMGC0_PMIE | PMGC0_FCECE);
+		isync();
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+
+static int collect_events(struct perf_event *group, int max_count,
+			  struct perf_event *ctrs[])
+{
+	int n = 0;
+	struct perf_event *event;
+
+	if (!is_software_event(group)) {
+		if (n >= max_count)
+			return -1;
+		ctrs[n] = group;
+		n++;
+	}
+	list_for_each_entry(event, &group->sibling_list, group_entry) {
+		if (!is_software_event(event) &&
+		    event->state != PERF_EVENT_STATE_OFF) {
+			if (n >= max_count)
+				return -1;
+			ctrs[n] = event;
+			n++;
+		}
+	}
+	return n;
+}
+
+/* perf must be disabled, context locked on entry */
+static int fsl_emb_pmu_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuhw;
+	int ret = -EAGAIN;
+	int num_counters = ppmu->n_counter;
+	u64 val;
+	int i;
+
+	cpuhw = &get_cpu_var(cpu_hw_events);
+
+	if (event->hw.config & FSL_EMB_EVENT_RESTRICTED)
+		num_counters = ppmu->n_restricted;
+
+	/*
+	 * Allocate counters from top-down, so that restricted-capable
+	 * counters are kept free as long as possible.
+	 */
+	for (i = num_counters - 1; i >= 0; i--) {
+		if (cpuhw->event[i])
+			continue;
+
+		break;
+	}
+
+	if (i < 0)
+		goto out;
+
+	event->hw.idx = i;
+	cpuhw->event[i] = event;
+	++cpuhw->n_events;
+
+	val = 0;
+	if (event->hw.sample_period) {
+		s64 left = atomic64_read(&event->hw.period_left);
+		if (left < 0x80000000L)
+			val = 0x80000000L - left;
+	}
+	atomic64_set(&event->hw.prev_count, val);
+	write_pmc(i, val);
+	perf_event_update_userpage(event);
+
+	write_pmlcb(i, event->hw.config >> 32);
+	write_pmlca(i, event->hw.config_base);
+
+	ret = 0;
+ out:
+	put_cpu_var(cpu_hw_events);
+	return ret;
+}
+
+/* perf must be disabled, context locked on entry */
+static void fsl_emb_pmu_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuhw;
+	int i = event->hw.idx;
+
+	if (i < 0)
+		goto out;
+
+	fsl_emb_pmu_read(event);
+
+	cpuhw = &get_cpu_var(cpu_hw_events);
+
+	WARN_ON(event != cpuhw->event[event->hw.idx]);
+
+	write_pmlca(i, 0);
+	write_pmlcb(i, 0);
+	write_pmc(i, 0);
+
+	cpuhw->event[i] = NULL;
+	event->hw.idx = -1;
+
+	/*
+	 * TODO: if at least one restricted event exists, and we
+	 * just freed up a non-restricted-capable counter, and
+	 * there is a restricted-capable counter occupied by
+	 * a non-restricted event, migrate that event to the
+	 * vacated counter.
+	 */
+
+	cpuhw->n_events--;
+
+ out:
+	put_cpu_var(cpu_hw_events);
+}
+
+/*
+ * Re-enable interrupts on a event after they were throttled
+ * because they were coming too fast.
+ *
+ * Context is locked on entry, but perf is not disabled.
+ */
+static void fsl_emb_pmu_unthrottle(struct perf_event *event)
+{
+	s64 val, left;
+	unsigned long flags;
+
+	if (event->hw.idx < 0 || !event->hw.sample_period)
+		return;
+	local_irq_save(flags);
+	perf_disable();
+	fsl_emb_pmu_read(event);
+	left = event->hw.sample_period;
+	event->hw.last_period = left;
+	val = 0;
+	if (left < 0x80000000L)
+		val = 0x80000000L - left;
+	write_pmc(event->hw.idx, val);
+	atomic64_set(&event->hw.prev_count, val);
+	atomic64_set(&event->hw.period_left, left);
+	perf_event_update_userpage(event);
+	perf_enable();
+	local_irq_restore(flags);
+}
+
+static struct pmu fsl_emb_pmu = {
+	.enable		= fsl_emb_pmu_enable,
+	.disable	= fsl_emb_pmu_disable,
+	.read		= fsl_emb_pmu_read,
+	.unthrottle	= fsl_emb_pmu_unthrottle,
+};
+
+/*
+ * Release the PMU if this is the last perf_event.
+ */
+static void hw_perf_event_destroy(struct perf_event *event)
+{
+	if (!atomic_add_unless(&num_events, -1, 1)) {
+		mutex_lock(&pmc_reserve_mutex);
+		if (atomic_dec_return(&num_events) == 0)
+			release_pmc_hardware();
+		mutex_unlock(&pmc_reserve_mutex);
+	}
+}
+
+/*
+ * Translate a generic cache event_id config to a raw event_id code.
+ */
+static int hw_perf_cache_event(u64 config, u64 *eventp)
+{
+	unsigned long type, op, result;
+	int ev;
+
+	if (!ppmu->cache_events)
+		return -EINVAL;
+
+	/* unpack config */
+	type = config & 0xff;
+	op = (config >> 8) & 0xff;
+	result = (config >> 16) & 0xff;
+
+	if (type >= PERF_COUNT_HW_CACHE_MAX ||
+	    op >= PERF_COUNT_HW_CACHE_OP_MAX ||
+	    result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return -EINVAL;
+
+	ev = (*ppmu->cache_events)[type][op][result];
+	if (ev == 0)
+		return -EOPNOTSUPP;
+	if (ev == -1)
+		return -EINVAL;
+	*eventp = ev;
+	return 0;
+}
+
+const struct pmu *hw_perf_event_init(struct perf_event *event)
+{
+	u64 ev;
+	struct perf_event *events[MAX_HWEVENTS];
+	int n;
+	int err;
+	int num_restricted;
+	int i;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		ev = event->attr.config;
+		if (ev >= ppmu->n_generic || ppmu->generic_events[ev] == 0)
+			return ERR_PTR(-EOPNOTSUPP);
+		ev = ppmu->generic_events[ev];
+		break;
+
+	case PERF_TYPE_HW_CACHE:
+		err = hw_perf_cache_event(event->attr.config, &ev);
+		if (err)
+			return ERR_PTR(err);
+		break;
+
+	case PERF_TYPE_RAW:
+		ev = event->attr.config;
+		break;
+
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	event->hw.config = ppmu->xlate_event(ev);
+	if (!(event->hw.config & FSL_EMB_EVENT_VALID))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * If this is in a group, check if it can go on with all the
+	 * other hardware events in the group.  We assume the event
+	 * hasn't been linked into its leader's sibling list at this point.
+	 */
+	n = 0;
+	if (event->group_leader != event) {
+		n = collect_events(event->group_leader,
+		                   ppmu->n_counter - 1, events);
+		if (n < 0)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (event->hw.config & FSL_EMB_EVENT_RESTRICTED) {
+		num_restricted = 0;
+		for (i = 0; i < n; i++) {
+			if (events[i]->hw.config & FSL_EMB_EVENT_RESTRICTED)
+				num_restricted++;
+		}
+
+		if (num_restricted >= ppmu->n_restricted)
+			return ERR_PTR(-EINVAL);
+	}
+
+	event->hw.idx = -1;
+
+	event->hw.config_base = PMLCA_CE | PMLCA_FCM1 |
+	                        (u32)((ev << 16) & PMLCA_EVENT_MASK);
+
+	if (event->attr.exclude_user)
+		event->hw.config_base |= PMLCA_FCU;
+	if (event->attr.exclude_kernel)
+		event->hw.config_base |= PMLCA_FCS;
+	if (event->attr.exclude_idle)
+		return ERR_PTR(-ENOTSUPP);
+
+	event->hw.last_period = event->hw.sample_period;
+	atomic64_set(&event->hw.period_left, event->hw.last_period);
+
+	/*
+	 * See if we need to reserve the PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * reserve_pmc_hardware or release_pmc_hardware.
+	 */
+	err = 0;
+	if (!atomic_inc_not_zero(&num_events)) {
+		mutex_lock(&pmc_reserve_mutex);
+		if (atomic_read(&num_events) == 0 &&
+		    reserve_pmc_hardware(perf_event_interrupt))
+			err = -EBUSY;
+		else
+			atomic_inc(&num_events);
+		mutex_unlock(&pmc_reserve_mutex);
+
+		mtpmr(PMRN_PMGC0, PMGC0_FAC);
+		isync();
+	}
+	event->destroy = hw_perf_event_destroy;
+
+	if (err)
+		return ERR_PTR(err);
+	return &fsl_emb_pmu;
+}
+
+/*
+ * A counter has overflowed; update its count and record
+ * things if requested.  Note that interrupts are hard-disabled
+ * here so there is no possibility of being interrupted.
+ */
+static void record_and_restart(struct perf_event *event, unsigned long val,
+			       struct pt_regs *regs, int nmi)
+{
+	u64 period = event->hw.sample_period;
+	s64 prev, delta, left;
+	int record = 0;
+
+	/* we don't have to worry about interrupts here */
+	prev = atomic64_read(&event->hw.prev_count);
+	delta = (val - prev) & 0xfffffffful;
+	atomic64_add(delta, &event->count);
+
+	/*
+	 * See if the total period for this event has expired,
+	 * and update for the next period.
+	 */
+	val = 0;
+	left = atomic64_read(&event->hw.period_left) - delta;
+	if (period) {
+		if (left <= 0) {
+			left += period;
+			if (left <= 0)
+				left = period;
+			record = 1;
+		}
+		if (left < 0x80000000LL)
+			val = 0x80000000LL - left;
+	}
+
+	/*
+	 * Finally record data if requested.
+	 */
+	if (record) {
+		struct perf_sample_data data = {
+			.period	= event->hw.last_period,
+		};
+
+		if (perf_event_overflow(event, nmi, &data, regs)) {
+			/*
+			 * Interrupts are coming too fast - throttle them
+			 * by setting the event to 0, so it will be
+			 * at least 2^30 cycles until the next interrupt
+			 * (assuming each event counts at most 2 counts
+			 * per cycle).
+			 */
+			val = 0;
+			left = ~0ULL >> 1;
+		}
+	}
+
+	write_pmc(event->hw.idx, val);
+	atomic64_set(&event->hw.prev_count, val);
+	atomic64_set(&event->hw.period_left, left);
+	perf_event_update_userpage(event);
+}
+
+static void perf_event_interrupt(struct pt_regs *regs)
+{
+	int i;
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+	struct perf_event *event;
+	unsigned long val;
+	int found = 0;
+	int nmi;
+
+	nmi = perf_intr_is_nmi(regs);
+	if (nmi)
+		nmi_enter();
+	else
+		irq_enter();
+
+	for (i = 0; i < ppmu->n_counter; ++i) {
+		event = cpuhw->event[i];
+
+		val = read_pmc(i);
+		if ((int)val < 0) {
+			if (event) {
+				/* event has overflowed */
+				found = 1;
+				record_and_restart(event, val, regs, nmi);
+			} else {
+				/*
+				 * Disabled counter is negative,
+				 * reset it just in case.
+				 */
+				write_pmc(i, 0);
+			}
+		}
+	}
+
+	/* PMM will keep counters frozen until we return from the interrupt. */
+	mtmsr(mfmsr() | MSR_PMM);
+	mtpmr(PMRN_PMGC0, PMGC0_PMIE | PMGC0_FCECE);
+	isync();
+
+	if (nmi)
+		nmi_exit();
+	else
+		irq_exit();
+}
+
+void hw_perf_event_setup(int cpu)
+{
+	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
+
+	memset(cpuhw, 0, sizeof(*cpuhw));
+}
+
+int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
+{
+	if (ppmu)
+		return -EBUSY;		/* something's already registered */
+
+	ppmu = pmu;
+	pr_info("%s performance monitor hardware support registered\n",
+		pmu->name);
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index fa0f690..a8aae0b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -144,6 +144,16 @@ config FSL_EMB_PERFMON
 	  and some e300 cores (c3 and c4).  Select this only if your
 	  core supports the Embedded Performance Monitor APU
 
+config FSL_EMB_PERF_EVENT
+	bool
+	depends on FSL_EMB_PERFMON && PERF_EVENTS && !PPC_PERF_CTRS
+	default y
+
+config FSL_EMB_PERF_EVENT_E500
+	bool
+	depends on FSL_EMB_PERF_EVENT && E500
+	default y
+
 config 4xx
 	bool
 	depends on 40x || 44x
-- 
1.6.4.4
