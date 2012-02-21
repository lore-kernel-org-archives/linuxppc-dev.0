Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: =?UTF-8?q?=5BPATCH=5D=20powerpc/perf=3A=20Move=20perf=20core=20=26=20PMU=20code=20into=20a=20subdirectory?=
Date: Tue, 21 Feb 2012 13:19:02 +1100
Message-Id: <1329790742-19308-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf code has grown a lot since it started, and is big enough to
warrant its own subdirectory. For reference it's ~60% bigger than the
oprofile code. It declutters the kernel directory, makes it simpler to
grep for "just perf stuff", and allows us to shorten some filenames.

While we're at it, make it more obvious that we have two implementations
of the core perf logic. One for (roughly) Book3S CPUs, which was the
original implementation, and the other for Freescale embedded CPUs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Makefile                    |    1 +
 arch/powerpc/kernel/Makefile             |    9 -
 arch/powerpc/kernel/e500-pmu.c           |  134 ---
 arch/powerpc/kernel/mpc7450-pmu.c        |  422 ---------
 arch/powerpc/kernel/perf_callchain.c     |  492 ----------
 arch/powerpc/kernel/perf_event.c         | 1438 ------------------------------
 arch/powerpc/kernel/perf_event_fsl_emb.c |  688 --------------
 arch/powerpc/kernel/power4-pmu.c         |  621 -------------
 arch/powerpc/kernel/power5+-pmu.c        |  690 --------------
 arch/powerpc/kernel/power5-pmu.c         |  629 -------------
 arch/powerpc/kernel/power6-pmu.c         |  552 ------------
 arch/powerpc/kernel/power7-pmu.c         |  379 --------
 arch/powerpc/kernel/ppc970-pmu.c         |  502 -----------
 arch/powerpc/perf/Makefile               |   14 +
 arch/powerpc/perf/callchain.c            |  492 ++++++++++
 arch/powerpc/perf/core-book3s.c          | 1438 ++++++++++++++++++++++++++++++
 arch/powerpc/perf/core-fsl-emb.c         |  688 ++++++++++++++
 arch/powerpc/perf/e500-pmu.c             |  134 +++
 arch/powerpc/perf/mpc7450-pmu.c          |  422 +++++++++
 arch/powerpc/perf/power4-pmu.c           |  621 +++++++++++++
 arch/powerpc/perf/power5+-pmu.c          |  690 ++++++++++++++
 arch/powerpc/perf/power5-pmu.c           |  629 +++++++++++++
 arch/powerpc/perf/power6-pmu.c           |  552 ++++++++++++
 arch/powerpc/perf/power7-pmu.c           |  379 ++++++++
 arch/powerpc/perf/ppc970-pmu.c           |  502 +++++++++++
 25 files changed, 6562 insertions(+), 6556 deletions(-)
 delete mode 100644 arch/powerpc/kernel/e500-pmu.c
 delete mode 100644 arch/powerpc/kernel/mpc7450-pmu.c
 delete mode 100644 arch/powerpc/kernel/perf_callchain.c
 delete mode 100644 arch/powerpc/kernel/perf_event.c
 delete mode 100644 arch/powerpc/kernel/perf_event_fsl_emb.c
 delete mode 100644 arch/powerpc/kernel/power4-pmu.c
 delete mode 100644 arch/powerpc/kernel/power5+-pmu.c
 delete mode 100644 arch/powerpc/kernel/power5-pmu.c
 delete mode 100644 arch/powerpc/kernel/power6-pmu.c
 delete mode 100644 arch/powerpc/kernel/power7-pmu.c
 delete mode 100644 arch/powerpc/kernel/ppc970-pmu.c
 create mode 100644 arch/powerpc/perf/Makefile
 create mode 100644 arch/powerpc/perf/callchain.c
 create mode 100644 arch/powerpc/perf/core-book3s.c
 create mode 100644 arch/powerpc/perf/core-fsl-emb.c
 create mode 100644 arch/powerpc/perf/e500-pmu.c
 create mode 100644 arch/powerpc/perf/mpc7450-pmu.c
 create mode 100644 arch/powerpc/perf/power4-pmu.c
 create mode 100644 arch/powerpc/perf/power5+-pmu.c
 create mode 100644 arch/powerpc/perf/power5-pmu.c
 create mode 100644 arch/powerpc/perf/power6-pmu.c
 create mode 100644 arch/powerpc/perf/power7-pmu.c
 create mode 100644 arch/powerpc/perf/ppc970-pmu.c

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b8b105c..6524c6e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -157,6 +157,7 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/net/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
+core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ee728e4..e373ce3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -113,15 +113,6 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
-obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
-
-obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
-obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
-				   power5+-pmu.o power6-pmu.o power7-pmu.o
-obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
-
-obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
-obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
 
 obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
 
diff --git a/arch/powerpc/kernel/e500-pmu.c b/arch/powerpc/kernel/e500-pmu.c
deleted file mode 100644
index cb2e294..0000000
--- a/arch/powerpc/kernel/e500-pmu.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * Performance counter support for e500 family processors.
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/string.h>
-#include <linux/perf_event.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Map of generic hardware event types to hardware events
- * Zero if unsupported
- */
-static int e500_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = 1,
-	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
-	[PERF_COUNT_HW_CACHE_MISSES] = 41, /* Data L1 cache reloads */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 12,
-	[PERF_COUNT_HW_BRANCH_MISSES] = 15,
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int e500_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	/*
-	 * D-cache misses are not split into read/write/prefetch;
-	 * use raw event 41.
-	 */
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	27,		0	},
-		[C(OP_WRITE)] = {	28,		0	},
-		[C(OP_PREFETCH)] = {	29,		0	},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	2,		60	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	/*
-	 * Assuming LL means L2, it's not a good match for this model.
-	 * It allocates only on L1 castout or explicit prefetch, and
-	 * does not have separate read/write events (but it does have
-	 * separate instruction/data events).
-	 */
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	/*
-	 * There are data/instruction MMU misses, but that's a miss on
-	 * the chip's internal level-one TLB which is probably not
-	 * what the user wants.  Instead, unified level-two TLB misses
-	 * are reported here.
-	 */
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	26,		66	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	12,		15 	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1 	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-};
-
-static int num_events = 128;
-
-/* Upper half of event id is PMLCb, for threshold events */
-static u64 e500_xlate_event(u64 event_id)
-{
-	u32 event_low = (u32)event_id;
-	u64 ret;
-
-	if (event_low >= num_events)
-		return 0;
-
-	ret = FSL_EMB_EVENT_VALID;
-
-	if (event_low >= 76 && event_low <= 81) {
-		ret |= FSL_EMB_EVENT_RESTRICTED;
-		ret |= event_id &
-		       (FSL_EMB_EVENT_THRESHMUL | FSL_EMB_EVENT_THRESH);
-	} else if (event_id &
-	           (FSL_EMB_EVENT_THRESHMUL | FSL_EMB_EVENT_THRESH)) {
-		/* Threshold requested on non-threshold event */
-		return 0;
-	}
-
-	return ret;
-}
-
-static struct fsl_emb_pmu e500_pmu = {
-	.name			= "e500 family",
-	.n_counter		= 4,
-	.n_restricted		= 2,
-	.xlate_event		= e500_xlate_event,
-	.n_generic		= ARRAY_SIZE(e500_generic_events),
-	.generic_events		= e500_generic_events,
-	.cache_events		= &e500_cache_events,
-};
-
-static int init_e500_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
-
-	if (!strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500mc"))
-		num_events = 256;
-	else if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e500"))
-		return -ENODEV;
-
-	return register_fsl_emb_pmu(&e500_pmu);
-}
-
-early_initcall(init_e500_pmu);
diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
deleted file mode 100644
index fe21b51..0000000
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ /dev/null
@@ -1,422 +0,0 @@
-/*
- * Performance counter support for MPC7450-family processors.
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/string.h>
-#include <linux/perf_event.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-#define N_COUNTER	6	/* Number of hardware counters */
-#define MAX_ALT		3	/* Maximum number of event alternative codes */
-
-/*
- * Bits in event code for MPC7450 family
- */
-#define PM_THRMULT_MSKS	0x40000
-#define PM_THRESH_SH	12
-#define PM_THRESH_MSK	0x3f
-#define PM_PMC_SH	8
-#define PM_PMC_MSK	7
-#define PM_PMCSEL_MSK	0x7f
-
-/*
- * Classify events according to how specific their PMC requirements are.
- * Result is:
- *	0: can go on any PMC
- *	1: can go on PMCs 1-4
- *	2: can go on PMCs 1,2,4
- *	3: can go on PMCs 1 or 2
- *	4: can only go on one PMC
- *	-1: event code is invalid
- */
-#define N_CLASSES	5
-
-static int mpc7450_classify_event(u32 event)
-{
-	int pmc;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > N_COUNTER)
-			return -1;
-		return 4;
-	}
-	event &= PM_PMCSEL_MSK;
-	if (event <= 1)
-		return 0;
-	if (event <= 7)
-		return 1;
-	if (event <= 13)
-		return 2;
-	if (event <= 22)
-		return 3;
-	return -1;
-}
-
-/*
- * Events using threshold and possible threshold scale:
- *	code	scale?	name
- *	11e	N	PM_INSTQ_EXCEED_CYC
- *	11f	N	PM_ALTV_IQ_EXCEED_CYC
- *	128	Y	PM_DTLB_SEARCH_EXCEED_CYC
- *	12b	Y	PM_LD_MISS_EXCEED_L1_CYC
- *	220	N	PM_CQ_EXCEED_CYC
- *	30c	N	PM_GPR_RB_EXCEED_CYC
- *	30d	?	PM_FPR_IQ_EXCEED_CYC ?
- *	311	Y	PM_ITLB_SEARCH_EXCEED
- *	410	N	PM_GPR_IQ_EXCEED_CYC
- */
-
-/*
- * Return use of threshold and threshold scale bits:
- * 0 = uses neither, 1 = uses threshold, 2 = uses both
- */
-static int mpc7450_threshold_use(u32 event)
-{
-	int pmc, sel;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	sel = event & PM_PMCSEL_MSK;
-	switch (pmc) {
-	case 1:
-		if (sel == 0x1e || sel == 0x1f)
-			return 1;
-		if (sel == 0x28 || sel == 0x2b)
-			return 2;
-		break;
-	case 2:
-		if (sel == 0x20)
-			return 1;
-		break;
-	case 3:
-		if (sel == 0xc || sel == 0xd)
-			return 1;
-		if (sel == 0x11)
-			return 2;
-		break;
-	case 4:
-		if (sel == 0x10)
-			return 1;
-		break;
-	}
-	return 0;
-}
-
-/*
- * Layout of constraint bits:
- * 33222222222211111111110000000000
- * 10987654321098765432109876543210
- *  |<    ><  > < > < ><><><><><><>
- *  TS TV   G4   G3  G2P6P5P4P3P2P1
- *
- * P1 - P6
- *	0 - 11: Count of events needing PMC1 .. PMC6
- *
- * G2
- *	12 - 14: Count of events needing PMC1 or PMC2
- *
- * G3
- *	16 - 18: Count of events needing PMC1, PMC2 or PMC4
- *
- * G4
- *	20 - 23: Count of events needing PMC1, PMC2, PMC3 or PMC4
- *
- * TV
- *	24 - 29: Threshold value requested
- *
- * TS
- *	30: Threshold scale value requested
- */
-
-static u32 pmcbits[N_COUNTER][2] = {
-	{ 0x00844002, 0x00111001 },	/* PMC1 mask, value: P1,G2,G3,G4 */
-	{ 0x00844008, 0x00111004 },	/* PMC2: P2,G2,G3,G4 */
-	{ 0x00800020, 0x00100010 },	/* PMC3: P3,G4 */
-	{ 0x00840080, 0x00110040 },	/* PMC4: P4,G3,G4 */
-	{ 0x00000200, 0x00000100 },	/* PMC5: P5 */
-	{ 0x00000800, 0x00000400 }	/* PMC6: P6 */
-};
-
-static u32 classbits[N_CLASSES - 1][2] = {
-	{ 0x00000000, 0x00000000 },	/* class 0: no constraint */
-	{ 0x00800000, 0x00100000 },	/* class 1: G4 */
-	{ 0x00040000, 0x00010000 },	/* class 2: G3 */
-	{ 0x00004000, 0x00001000 },	/* class 3: G2 */
-};
-
-static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
-				  unsigned long *valp)
-{
-	int pmc, class;
-	u32 mask, value;
-	int thresh, tuse;
-
-	class = mpc7450_classify_event(event);
-	if (class < 0)
-		return -1;
-	if (class == 4) {
-		pmc = ((unsigned int)event >> PM_PMC_SH) & PM_PMC_MSK;
-		mask  = pmcbits[pmc - 1][0];
-		value = pmcbits[pmc - 1][1];
-	} else {
-		mask  = classbits[class][0];
-		value = classbits[class][1];
-	}
-
-	tuse = mpc7450_threshold_use(event);
-	if (tuse) {
-		thresh = ((unsigned int)event >> PM_THRESH_SH) & PM_THRESH_MSK;
-		mask  |= 0x3f << 24;
-		value |= thresh << 24;
-		if (tuse == 2) {
-			mask |= 0x40000000;
-			if ((unsigned int)event & PM_THRMULT_MSKS)
-				value |= 0x40000000;
-		}
-	}
-
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
-	{ 0x418, 0x50f, 0x60f },	/* PM_SNOOP_RETRY */
-	{ 0x502, 0x602 },		/* PM_L2_HIT */
-	{ 0x503, 0x603 },		/* PM_L3_HIT */
-	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */
-	{ 0x505, 0x605 },		/* PM_L3_ICACHE_MISS */
-	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
-	{ 0x507, 0x607 },		/* PM_L3_DCACHE_MISS */
-	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
-	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
-	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
-	{ 0x50e, 0x60e },		/* PM_L3_TOUCH_HIT */
-	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
-	{ 0x513, 0x61d },		/* PM_L2_MISS */
-	{ 0x514, 0x61e },		/* PM_L3_MISS */
-};
-
-/*
- * Scan the alternatives table for a match and return the
- * index into the alternatives table if found, else -1.
- */
-static int find_alternative(u32 event)
-{
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			break;
-		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
-			if (event == event_alternatives[i][j])
-				return i;
-	}
-	return -1;
-}
-
-static int mpc7450_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, nalt = 1;
-	u32 ae;
-
-	alt[0] = event;
-	nalt = 1;
-	i = find_alternative((u32)event);
-	if (i >= 0) {
-		for (j = 0; j < MAX_ALT; ++j) {
-			ae = event_alternatives[i][j];
-			if (ae && ae != (u32)event)
-				alt[nalt++] = ae;
-		}
-	}
-	return nalt;
-}
-
-/*
- * Bitmaps of which PMCs each class can use for classes 0 - 3.
- * Bit i is set if PMC i+1 is usable.
- */
-static const u8 classmap[N_CLASSES] = {
-	0x3f, 0x0f, 0x0b, 0x03, 0
-};
-
-/* Bit position and width of each PMCSEL field */
-static const int pmcsel_shift[N_COUNTER] = {
-	6,	0,	27,	22,	17,	11
-};
-static const u32 pmcsel_mask[N_COUNTER] = {
-	0x7f,	0x3f,	0x1f,	0x1f,	0x1f,	0x3f
-};
-
-/*
- * Compute MMCR0/1/2 values for a set of events.
- */
-static int mpc7450_compute_mmcr(u64 event[], int n_ev,
-				unsigned int hwc[], unsigned long mmcr[])
-{
-	u8 event_index[N_CLASSES][N_COUNTER];
-	int n_classevent[N_CLASSES];
-	int i, j, class, tuse;
-	u32 pmc_inuse = 0, pmc_avail;
-	u32 mmcr0 = 0, mmcr1 = 0, mmcr2 = 0;
-	u32 ev, pmc, thresh;
-
-	if (n_ev > N_COUNTER)
-		return -1;
-
-	/* First pass: count usage in each class */
-	for (i = 0; i < N_CLASSES; ++i)
-		n_classevent[i] = 0;
-	for (i = 0; i < n_ev; ++i) {
-		class = mpc7450_classify_event(event[i]);
-		if (class < 0)
-			return -1;
-		j = n_classevent[class]++;
-		event_index[class][j] = i;
-	}
-
-	/* Second pass: allocate PMCs from most specific event to least */
-	for (class = N_CLASSES - 1; class >= 0; --class) {
-		for (i = 0; i < n_classevent[class]; ++i) {
-			ev = event[event_index[class][i]];
-			if (class == 4) {
-				pmc = (ev >> PM_PMC_SH) & PM_PMC_MSK;
-				if (pmc_inuse & (1 << (pmc - 1)))
-					return -1;
-			} else {
-				/* Find a suitable PMC */
-				pmc_avail = classmap[class] & ~pmc_inuse;
-				if (!pmc_avail)
-					return -1;
-				pmc = ffs(pmc_avail);
-			}
-			pmc_inuse |= 1 << (pmc - 1);
-
-			tuse = mpc7450_threshold_use(ev);
-			if (tuse) {
-				thresh = (ev >> PM_THRESH_SH) & PM_THRESH_MSK;
-				mmcr0 |= thresh << 16;
-				if (tuse == 2 && (ev & PM_THRMULT_MSKS))
-					mmcr2 = 0x80000000;
-			}
-			ev &= pmcsel_mask[pmc - 1];
-			ev <<= pmcsel_shift[pmc - 1];
-			if (pmc <= 2)
-				mmcr0 |= ev;
-			else
-				mmcr1 |= ev;
-			hwc[event_index[class][i]] = pmc - 1;
-		}
-	}
-
-	if (pmc_inuse & 1)
-		mmcr0 |= MMCR0_PMC1CE;
-	if (pmc_inuse & 0x3e)
-		mmcr0 |= MMCR0_PMCnCE;
-
-	/* Return MMCRx values */
-	mmcr[0] = mmcr0;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcr2;
-	return 0;
-}
-
-/*
- * Disable counting by a PMC.
- * Note that the pmc argument is 0-based here, not 1-based.
- */
-static void mpc7450_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	if (pmc <= 1)
-		mmcr[0] &= ~(pmcsel_mask[pmc] << pmcsel_shift[pmc]);
-	else
-		mmcr[1] &= ~(pmcsel_mask[pmc] << pmcsel_shift[pmc]);
-}
-
-static int mpc7450_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 1,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 2,
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x217, /* PM_L1_DCACHE_MISS */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x122, /* PM_BR_CMPL */
-	[PERF_COUNT_HW_BRANCH_MISSES] 		= 0x41c, /* PM_BR_MPRED */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x225	},
-		[C(OP_WRITE)] = {	0,		0x227	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x129,		0x115	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0x634,		0	},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x312	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x223	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x122,		0x41c	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-};
-
-struct power_pmu mpc7450_pmu = {
-	.name			= "MPC7450 family",
-	.n_counter		= N_COUNTER,
-	.max_alternatives	= MAX_ALT,
-	.add_fields		= 0x00111555ul,
-	.test_adder		= 0x00301000ul,
-	.compute_mmcr		= mpc7450_compute_mmcr,
-	.get_constraint		= mpc7450_get_constraint,
-	.get_alternatives	= mpc7450_get_alternatives,
-	.disable_pmc		= mpc7450_disable_pmc,
-	.n_generic		= ARRAY_SIZE(mpc7450_generic_events),
-	.generic_events		= mpc7450_generic_events,
-	.cache_events		= &mpc7450_cache_events,
-};
-
-static int __init init_mpc7450_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
-		return -ENODEV;
-
-	return register_power_pmu(&mpc7450_pmu);
-}
-
-early_initcall(init_mpc7450_pmu);
diff --git a/arch/powerpc/kernel/perf_callchain.c b/arch/powerpc/kernel/perf_callchain.c
deleted file mode 100644
index 564c1d8..0000000
--- a/arch/powerpc/kernel/perf_callchain.c
+++ /dev/null
@@ -1,492 +0,0 @@
-/*
- * Performance counter callchain support - powerpc architecture code
- *
- * Copyright © 2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/perf_event.h>
-#include <linux/percpu.h>
-#include <linux/uaccess.h>
-#include <linux/mm.h>
-#include <asm/ptrace.h>
-#include <asm/pgtable.h>
-#include <asm/sigcontext.h>
-#include <asm/ucontext.h>
-#include <asm/vdso.h>
-#ifdef CONFIG_PPC64
-#include "ppc32.h"
-#endif
-
-
-/*
- * Is sp valid as the address of the next kernel stack frame after prev_sp?
- * The next frame may be in a different stack area but should not go
- * back down in the same stack area.
- */
-static int valid_next_sp(unsigned long sp, unsigned long prev_sp)
-{
-	if (sp & 0xf)
-		return 0;		/* must be 16-byte aligned */
-	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
-		return 0;
-	if (sp >= prev_sp + STACK_FRAME_OVERHEAD)
-		return 1;
-	/*
-	 * sp could decrease when we jump off an interrupt stack
-	 * back to the regular process stack.
-	 */
-	if ((sp & ~(THREAD_SIZE - 1)) != (prev_sp & ~(THREAD_SIZE - 1)))
-		return 1;
-	return 0;
-}
-
-void
-perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
-{
-	unsigned long sp, next_sp;
-	unsigned long next_ip;
-	unsigned long lr;
-	long level = 0;
-	unsigned long *fp;
-
-	lr = regs->link;
-	sp = regs->gpr[1];
-	perf_callchain_store(entry, regs->nip);
-
-	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
-		return;
-
-	for (;;) {
-		fp = (unsigned long *) sp;
-		next_sp = fp[0];
-
-		if (next_sp == sp + STACK_INT_FRAME_SIZE &&
-		    fp[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
-			/*
-			 * This looks like an interrupt frame for an
-			 * interrupt that occurred in the kernel
-			 */
-			regs = (struct pt_regs *)(sp + STACK_FRAME_OVERHEAD);
-			next_ip = regs->nip;
-			lr = regs->link;
-			level = 0;
-			perf_callchain_store(entry, PERF_CONTEXT_KERNEL);
-
-		} else {
-			if (level == 0)
-				next_ip = lr;
-			else
-				next_ip = fp[STACK_FRAME_LR_SAVE];
-
-			/*
-			 * We can't tell which of the first two addresses
-			 * we get are valid, but we can filter out the
-			 * obviously bogus ones here.  We replace them
-			 * with 0 rather than removing them entirely so
-			 * that userspace can tell which is which.
-			 */
-			if ((level == 1 && next_ip == lr) ||
-			    (level <= 1 && !kernel_text_address(next_ip)))
-				next_ip = 0;
-
-			++level;
-		}
-
-		perf_callchain_store(entry, next_ip);
-		if (!valid_next_sp(next_sp, sp))
-			return;
-		sp = next_sp;
-	}
-}
-
-#ifdef CONFIG_PPC64
-/*
- * On 64-bit we don't want to invoke hash_page on user addresses from
- * interrupt context, so if the access faults, we read the page tables
- * to find which page (if any) is mapped and access it directly.
- */
-static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
-{
-	pgd_t *pgdir;
-	pte_t *ptep, pte;
-	unsigned shift;
-	unsigned long addr = (unsigned long) ptr;
-	unsigned long offset;
-	unsigned long pfn;
-	void *kaddr;
-
-	pgdir = current->mm->pgd;
-	if (!pgdir)
-		return -EFAULT;
-
-	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
-	if (!shift)
-		shift = PAGE_SHIFT;
-
-	/* align address to page boundary */
-	offset = addr & ((1UL << shift) - 1);
-	addr -= offset;
-
-	if (ptep == NULL)
-		return -EFAULT;
-	pte = *ptep;
-	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
-		return -EFAULT;
-	pfn = pte_pfn(pte);
-	if (!page_is_ram(pfn))
-		return -EFAULT;
-
-	/* no highmem to worry about here */
-	kaddr = pfn_to_kaddr(pfn);
-	memcpy(ret, kaddr + offset, nb);
-	return 0;
-}
-
-static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
-{
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
-	    ((unsigned long)ptr & 7))
-		return -EFAULT;
-
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
-		return 0;
-	}
-	pagefault_enable();
-
-	return read_user_stack_slow(ptr, ret, 8);
-}
-
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
-		return 0;
-	}
-	pagefault_enable();
-
-	return read_user_stack_slow(ptr, ret, 4);
-}
-
-static inline int valid_user_sp(unsigned long sp, int is_64)
-{
-	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
-		return 0;
-	return 1;
-}
-
-/*
- * 64-bit user processes use the same stack frame for RT and non-RT signals.
- */
-struct signal_frame_64 {
-	char		dummy[__SIGNAL_FRAMESIZE];
-	struct ucontext	uc;
-	unsigned long	unused[2];
-	unsigned int	tramp[6];
-	struct siginfo	*pinfo;
-	void		*puc;
-	struct siginfo	info;
-	char		abigap[288];
-};
-
-static int is_sigreturn_64_address(unsigned long nip, unsigned long fp)
-{
-	if (nip == fp + offsetof(struct signal_frame_64, tramp))
-		return 1;
-	if (vdso64_rt_sigtramp && current->mm->context.vdso_base &&
-	    nip == current->mm->context.vdso_base + vdso64_rt_sigtramp)
-		return 1;
-	return 0;
-}
-
-/*
- * Do some sanity checking on the signal frame pointed to by sp.
- * We check the pinfo and puc pointers in the frame.
- */
-static int sane_signal_64_frame(unsigned long sp)
-{
-	struct signal_frame_64 __user *sf;
-	unsigned long pinfo, puc;
-
-	sf = (struct signal_frame_64 __user *) sp;
-	if (read_user_stack_64((unsigned long __user *) &sf->pinfo, &pinfo) ||
-	    read_user_stack_64((unsigned long __user *) &sf->puc, &puc))
-		return 0;
-	return pinfo == (unsigned long) &sf->info &&
-		puc == (unsigned long) &sf->uc;
-}
-
-static void perf_callchain_user_64(struct perf_callchain_entry *entry,
-				   struct pt_regs *regs)
-{
-	unsigned long sp, next_sp;
-	unsigned long next_ip;
-	unsigned long lr;
-	long level = 0;
-	struct signal_frame_64 __user *sigframe;
-	unsigned long __user *fp, *uregs;
-
-	next_ip = regs->nip;
-	lr = regs->link;
-	sp = regs->gpr[1];
-	perf_callchain_store(entry, next_ip);
-
-	for (;;) {
-		fp = (unsigned long __user *) sp;
-		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
-			return;
-		if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
-			return;
-
-		/*
-		 * Note: the next_sp - sp >= signal frame size check
-		 * is true when next_sp < sp, which can happen when
-		 * transitioning from an alternate signal stack to the
-		 * normal stack.
-		 */
-		if (next_sp - sp >= sizeof(struct signal_frame_64) &&
-		    (is_sigreturn_64_address(next_ip, sp) ||
-		     (level <= 1 && is_sigreturn_64_address(lr, sp))) &&
-		    sane_signal_64_frame(sp)) {
-			/*
-			 * This looks like an signal frame
-			 */
-			sigframe = (struct signal_frame_64 __user *) sp;
-			uregs = sigframe->uc.uc_mcontext.gp_regs;
-			if (read_user_stack_64(&uregs[PT_NIP], &next_ip) ||
-			    read_user_stack_64(&uregs[PT_LNK], &lr) ||
-			    read_user_stack_64(&uregs[PT_R1], &sp))
-				return;
-			level = 0;
-			perf_callchain_store(entry, PERF_CONTEXT_USER);
-			perf_callchain_store(entry, next_ip);
-			continue;
-		}
-
-		if (level == 0)
-			next_ip = lr;
-		perf_callchain_store(entry, next_ip);
-		++level;
-		sp = next_sp;
-	}
-}
-
-static inline int current_is_64bit(void)
-{
-	/*
-	 * We can't use test_thread_flag() here because we may be on an
-	 * interrupt stack, and the thread flags don't get copied over
-	 * from the thread_info on the main stack to the interrupt stack.
-	 */
-	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
-}
-
-#else  /* CONFIG_PPC64 */
-/*
- * On 32-bit we just access the address and let hash_page create a
- * HPTE if necessary, so there is no need to fall back to reading
- * the page tables.  Since this is called at interrupt level,
- * do_page_fault() won't treat a DSI as a page fault.
- */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	int rc;
-
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	rc = __get_user_inatomic(*ret, ptr);
-	pagefault_enable();
-
-	return rc;
-}
-
-static inline void perf_callchain_user_64(struct perf_callchain_entry *entry,
-					  struct pt_regs *regs)
-{
-}
-
-static inline int current_is_64bit(void)
-{
-	return 0;
-}
-
-static inline int valid_user_sp(unsigned long sp, int is_64)
-{
-	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
-		return 0;
-	return 1;
-}
-
-#define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
-#define sigcontext32		sigcontext
-#define mcontext32		mcontext
-#define ucontext32		ucontext
-#define compat_siginfo_t	struct siginfo
-
-#endif /* CONFIG_PPC64 */
-
-/*
- * Layout for non-RT signal frames
- */
-struct signal_frame_32 {
-	char			dummy[__SIGNAL_FRAMESIZE32];
-	struct sigcontext32	sctx;
-	struct mcontext32	mctx;
-	int			abigap[56];
-};
-
-/*
- * Layout for RT signal frames
- */
-struct rt_signal_frame_32 {
-	char			dummy[__SIGNAL_FRAMESIZE32 + 16];
-	compat_siginfo_t	info;
-	struct ucontext32	uc;
-	int			abigap[56];
-};
-
-static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
-{
-	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
-		return 1;
-	if (vdso32_sigtramp && current->mm->context.vdso_base &&
-	    nip == current->mm->context.vdso_base + vdso32_sigtramp)
-		return 1;
-	return 0;
-}
-
-static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
-{
-	if (nip == fp + offsetof(struct rt_signal_frame_32,
-				 uc.uc_mcontext.mc_pad))
-		return 1;
-	if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
-	    nip == current->mm->context.vdso_base + vdso32_rt_sigtramp)
-		return 1;
-	return 0;
-}
-
-static int sane_signal_32_frame(unsigned int sp)
-{
-	struct signal_frame_32 __user *sf;
-	unsigned int regs;
-
-	sf = (struct signal_frame_32 __user *) (unsigned long) sp;
-	if (read_user_stack_32((unsigned int __user *) &sf->sctx.regs, &regs))
-		return 0;
-	return regs == (unsigned long) &sf->mctx;
-}
-
-static int sane_rt_signal_32_frame(unsigned int sp)
-{
-	struct rt_signal_frame_32 __user *sf;
-	unsigned int regs;
-
-	sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
-	if (read_user_stack_32((unsigned int __user *) &sf->uc.uc_regs, &regs))
-		return 0;
-	return regs == (unsigned long) &sf->uc.uc_mcontext;
-}
-
-static unsigned int __user *signal_frame_32_regs(unsigned int sp,
-				unsigned int next_sp, unsigned int next_ip)
-{
-	struct mcontext32 __user *mctx = NULL;
-	struct signal_frame_32 __user *sf;
-	struct rt_signal_frame_32 __user *rt_sf;
-
-	/*
-	 * Note: the next_sp - sp >= signal frame size check
-	 * is true when next_sp < sp, for example, when
-	 * transitioning from an alternate signal stack to the
-	 * normal stack.
-	 */
-	if (next_sp - sp >= sizeof(struct signal_frame_32) &&
-	    is_sigreturn_32_address(next_ip, sp) &&
-	    sane_signal_32_frame(sp)) {
-		sf = (struct signal_frame_32 __user *) (unsigned long) sp;
-		mctx = &sf->mctx;
-	}
-
-	if (!mctx && next_sp - sp >= sizeof(struct rt_signal_frame_32) &&
-	    is_rt_sigreturn_32_address(next_ip, sp) &&
-	    sane_rt_signal_32_frame(sp)) {
-		rt_sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
-		mctx = &rt_sf->uc.uc_mcontext;
-	}
-
-	if (!mctx)
-		return NULL;
-	return mctx->mc_gregs;
-}
-
-static void perf_callchain_user_32(struct perf_callchain_entry *entry,
-				   struct pt_regs *regs)
-{
-	unsigned int sp, next_sp;
-	unsigned int next_ip;
-	unsigned int lr;
-	long level = 0;
-	unsigned int __user *fp, *uregs;
-
-	next_ip = regs->nip;
-	lr = regs->link;
-	sp = regs->gpr[1];
-	perf_callchain_store(entry, next_ip);
-
-	while (entry->nr < PERF_MAX_STACK_DEPTH) {
-		fp = (unsigned int __user *) (unsigned long) sp;
-		if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
-			return;
-		if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
-			return;
-
-		uregs = signal_frame_32_regs(sp, next_sp, next_ip);
-		if (!uregs && level <= 1)
-			uregs = signal_frame_32_regs(sp, next_sp, lr);
-		if (uregs) {
-			/*
-			 * This looks like an signal frame, so restart
-			 * the stack trace with the values in it.
-			 */
-			if (read_user_stack_32(&uregs[PT_NIP], &next_ip) ||
-			    read_user_stack_32(&uregs[PT_LNK], &lr) ||
-			    read_user_stack_32(&uregs[PT_R1], &sp))
-				return;
-			level = 0;
-			perf_callchain_store(entry, PERF_CONTEXT_USER);
-			perf_callchain_store(entry, next_ip);
-			continue;
-		}
-
-		if (level == 0)
-			next_ip = lr;
-		perf_callchain_store(entry, next_ip);
-		++level;
-		sp = next_sp;
-	}
-}
-
-void
-perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
-{
-	if (current_is_64bit())
-		perf_callchain_user_64(entry, regs);
-	else
-		perf_callchain_user_32(entry, regs);
-}
diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
deleted file mode 100644
index 64483fd..0000000
--- a/arch/powerpc/kernel/perf_event.c
+++ /dev/null
@@ -1,1438 +0,0 @@
-/*
- * Performance event support - powerpc architecture code
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/perf_event.h>
-#include <linux/percpu.h>
-#include <linux/hardirq.h>
-#include <asm/reg.h>
-#include <asm/pmc.h>
-#include <asm/machdep.h>
-#include <asm/firmware.h>
-#include <asm/ptrace.h>
-
-struct cpu_hw_events {
-	int n_events;
-	int n_percpu;
-	int disabled;
-	int n_added;
-	int n_limited;
-	u8  pmcs_enabled;
-	struct perf_event *event[MAX_HWEVENTS];
-	u64 events[MAX_HWEVENTS];
-	unsigned int flags[MAX_HWEVENTS];
-	unsigned long mmcr[3];
-	struct perf_event *limited_counter[MAX_LIMITED_HWCOUNTERS];
-	u8  limited_hwidx[MAX_LIMITED_HWCOUNTERS];
-	u64 alternatives[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
-	unsigned long amasks[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
-	unsigned long avalues[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
-
-	unsigned int group_flag;
-	int n_txn_start;
-};
-DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
-
-struct power_pmu *ppmu;
-
-/*
- * Normally, to ignore kernel events we set the FCS (freeze counters
- * in supervisor mode) bit in MMCR0, but if the kernel runs with the
- * hypervisor bit set in the MSR, or if we are running on a processor
- * where the hypervisor bit is forced to 1 (as on Apple G5 processors),
- * then we need to use the FCHV bit to ignore kernel events.
- */
-static unsigned int freeze_events_kernel = MMCR0_FCS;
-
-/*
- * 32-bit doesn't have MMCRA but does have an MMCR2,
- * and a few other names are different.
- */
-#ifdef CONFIG_PPC32
-
-#define MMCR0_FCHV		0
-#define MMCR0_PMCjCE		MMCR0_PMCnCE
-
-#define SPRN_MMCRA		SPRN_MMCR2
-#define MMCRA_SAMPLE_ENABLE	0
-
-static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
-{
-	return 0;
-}
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
-static inline u32 perf_get_misc_flags(struct pt_regs *regs)
-{
-	return 0;
-}
-static inline void perf_read_regs(struct pt_regs *regs) { }
-static inline int perf_intr_is_nmi(struct pt_regs *regs)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PPC32 */
-
-/*
- * Things that are specific to 64-bit implementations.
- */
-#ifdef CONFIG_PPC64
-
-static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
-{
-	unsigned long mmcra = regs->dsisr;
-
-	if ((mmcra & MMCRA_SAMPLE_ENABLE) && !(ppmu->flags & PPMU_ALT_SIPR)) {
-		unsigned long slot = (mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT;
-		if (slot > 1)
-			return 4 * (slot - 1);
-	}
-	return 0;
-}
-
-/*
- * The user wants a data address recorded.
- * If we're not doing instruction sampling, give them the SDAR
- * (sampled data address).  If we are doing instruction sampling, then
- * only give them the SDAR if it corresponds to the instruction
- * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC
- * bit in MMCRA.
- */
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
-{
-	unsigned long mmcra = regs->dsisr;
-	unsigned long sdsync = (ppmu->flags & PPMU_ALT_SIPR) ?
-		POWER6_MMCRA_SDSYNC : MMCRA_SDSYNC;
-
-	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || (mmcra & sdsync))
-		*addrp = mfspr(SPRN_SDAR);
-}
-
-static inline u32 perf_get_misc_flags(struct pt_regs *regs)
-{
-	unsigned long mmcra = regs->dsisr;
-	unsigned long sihv = MMCRA_SIHV;
-	unsigned long sipr = MMCRA_SIPR;
-
-	if (TRAP(regs) != 0xf00)
-		return 0;	/* not a PMU interrupt */
-
-	if (ppmu->flags & PPMU_ALT_SIPR) {
-		sihv = POWER6_MMCRA_SIHV;
-		sipr = POWER6_MMCRA_SIPR;
-	}
-
-	/* PR has priority over HV, so order below is important */
-	if (mmcra & sipr)
-		return PERF_RECORD_MISC_USER;
-	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
-		return PERF_RECORD_MISC_HYPERVISOR;
-	return PERF_RECORD_MISC_KERNEL;
-}
-
-/*
- * Overload regs->dsisr to store MMCRA so we only need to read it once
- * on each interrupt.
- */
-static inline void perf_read_regs(struct pt_regs *regs)
-{
-	regs->dsisr = mfspr(SPRN_MMCRA);
-}
-
-/*
- * If interrupts were soft-disabled when a PMU interrupt occurs, treat
- * it as an NMI.
- */
-static inline int perf_intr_is_nmi(struct pt_regs *regs)
-{
-	return !regs->softe;
-}
-
-#endif /* CONFIG_PPC64 */
-
-static void perf_event_interrupt(struct pt_regs *regs);
-
-void perf_event_print_debug(void)
-{
-}
-
-/*
- * Read one performance monitor counter (PMC).
- */
-static unsigned long read_pmc(int idx)
-{
-	unsigned long val;
-
-	switch (idx) {
-	case 1:
-		val = mfspr(SPRN_PMC1);
-		break;
-	case 2:
-		val = mfspr(SPRN_PMC2);
-		break;
-	case 3:
-		val = mfspr(SPRN_PMC3);
-		break;
-	case 4:
-		val = mfspr(SPRN_PMC4);
-		break;
-	case 5:
-		val = mfspr(SPRN_PMC5);
-		break;
-	case 6:
-		val = mfspr(SPRN_PMC6);
-		break;
-#ifdef CONFIG_PPC64
-	case 7:
-		val = mfspr(SPRN_PMC7);
-		break;
-	case 8:
-		val = mfspr(SPRN_PMC8);
-		break;
-#endif /* CONFIG_PPC64 */
-	default:
-		printk(KERN_ERR "oops trying to read PMC%d\n", idx);
-		val = 0;
-	}
-	return val;
-}
-
-/*
- * Write one PMC.
- */
-static void write_pmc(int idx, unsigned long val)
-{
-	switch (idx) {
-	case 1:
-		mtspr(SPRN_PMC1, val);
-		break;
-	case 2:
-		mtspr(SPRN_PMC2, val);
-		break;
-	case 3:
-		mtspr(SPRN_PMC3, val);
-		break;
-	case 4:
-		mtspr(SPRN_PMC4, val);
-		break;
-	case 5:
-		mtspr(SPRN_PMC5, val);
-		break;
-	case 6:
-		mtspr(SPRN_PMC6, val);
-		break;
-#ifdef CONFIG_PPC64
-	case 7:
-		mtspr(SPRN_PMC7, val);
-		break;
-	case 8:
-		mtspr(SPRN_PMC8, val);
-		break;
-#endif /* CONFIG_PPC64 */
-	default:
-		printk(KERN_ERR "oops trying to write PMC%d\n", idx);
-	}
-}
-
-/*
- * Check if a set of events can all go on the PMU at once.
- * If they can't, this will look at alternative codes for the events
- * and see if any combination of alternative codes is feasible.
- * The feasible set is returned in event_id[].
- */
-static int power_check_constraints(struct cpu_hw_events *cpuhw,
-				   u64 event_id[], unsigned int cflags[],
-				   int n_ev)
-{
-	unsigned long mask, value, nv;
-	unsigned long smasks[MAX_HWEVENTS], svalues[MAX_HWEVENTS];
-	int n_alt[MAX_HWEVENTS], choice[MAX_HWEVENTS];
-	int i, j;
-	unsigned long addf = ppmu->add_fields;
-	unsigned long tadd = ppmu->test_adder;
-
-	if (n_ev > ppmu->n_counter)
-		return -1;
-
-	/* First see if the events will go on as-is */
-	for (i = 0; i < n_ev; ++i) {
-		if ((cflags[i] & PPMU_LIMITED_PMC_REQD)
-		    && !ppmu->limited_pmc_event(event_id[i])) {
-			ppmu->get_alternatives(event_id[i], cflags[i],
-					       cpuhw->alternatives[i]);
-			event_id[i] = cpuhw->alternatives[i][0];
-		}
-		if (ppmu->get_constraint(event_id[i], &cpuhw->amasks[i][0],
-					 &cpuhw->avalues[i][0]))
-			return -1;
-	}
-	value = mask = 0;
-	for (i = 0; i < n_ev; ++i) {
-		nv = (value | cpuhw->avalues[i][0]) +
-			(value & cpuhw->avalues[i][0] & addf);
-		if ((((nv + tadd) ^ value) & mask) != 0 ||
-		    (((nv + tadd) ^ cpuhw->avalues[i][0]) &
-		     cpuhw->amasks[i][0]) != 0)
-			break;
-		value = nv;
-		mask |= cpuhw->amasks[i][0];
-	}
-	if (i == n_ev)
-		return 0;	/* all OK */
-
-	/* doesn't work, gather alternatives... */
-	if (!ppmu->get_alternatives)
-		return -1;
-	for (i = 0; i < n_ev; ++i) {
-		choice[i] = 0;
-		n_alt[i] = ppmu->get_alternatives(event_id[i], cflags[i],
-						  cpuhw->alternatives[i]);
-		for (j = 1; j < n_alt[i]; ++j)
-			ppmu->get_constraint(cpuhw->alternatives[i][j],
-					     &cpuhw->amasks[i][j],
-					     &cpuhw->avalues[i][j]);
-	}
-
-	/* enumerate all possibilities and see if any will work */
-	i = 0;
-	j = -1;
-	value = mask = nv = 0;
-	while (i < n_ev) {
-		if (j >= 0) {
-			/* we're backtracking, restore context */
-			value = svalues[i];
-			mask = smasks[i];
-			j = choice[i];
-		}
-		/*
-		 * See if any alternative k for event_id i,
-		 * where k > j, will satisfy the constraints.
-		 */
-		while (++j < n_alt[i]) {
-			nv = (value | cpuhw->avalues[i][j]) +
-				(value & cpuhw->avalues[i][j] & addf);
-			if ((((nv + tadd) ^ value) & mask) == 0 &&
-			    (((nv + tadd) ^ cpuhw->avalues[i][j])
-			     & cpuhw->amasks[i][j]) == 0)
-				break;
-		}
-		if (j >= n_alt[i]) {
-			/*
-			 * No feasible alternative, backtrack
-			 * to event_id i-1 and continue enumerating its
-			 * alternatives from where we got up to.
-			 */
-			if (--i < 0)
-				return -1;
-		} else {
-			/*
-			 * Found a feasible alternative for event_id i,
-			 * remember where we got up to with this event_id,
-			 * go on to the next event_id, and start with
-			 * the first alternative for it.
-			 */
-			choice[i] = j;
-			svalues[i] = value;
-			smasks[i] = mask;
-			value = nv;
-			mask |= cpuhw->amasks[i][j];
-			++i;
-			j = -1;
-		}
-	}
-
-	/* OK, we have a feasible combination, tell the caller the solution */
-	for (i = 0; i < n_ev; ++i)
-		event_id[i] = cpuhw->alternatives[i][choice[i]];
-	return 0;
-}
-
-/*
- * Check if newly-added events have consistent settings for
- * exclude_{user,kernel,hv} with each other and any previously
- * added events.
- */
-static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
-			  int n_prev, int n_new)
-{
-	int eu = 0, ek = 0, eh = 0;
-	int i, n, first;
-	struct perf_event *event;
-
-	n = n_prev + n_new;
-	if (n <= 1)
-		return 0;
-
-	first = 1;
-	for (i = 0; i < n; ++i) {
-		if (cflags[i] & PPMU_LIMITED_PMC_OK) {
-			cflags[i] &= ~PPMU_LIMITED_PMC_REQD;
-			continue;
-		}
-		event = ctrs[i];
-		if (first) {
-			eu = event->attr.exclude_user;
-			ek = event->attr.exclude_kernel;
-			eh = event->attr.exclude_hv;
-			first = 0;
-		} else if (event->attr.exclude_user != eu ||
-			   event->attr.exclude_kernel != ek ||
-			   event->attr.exclude_hv != eh) {
-			return -EAGAIN;
-		}
-	}
-
-	if (eu || ek || eh)
-		for (i = 0; i < n; ++i)
-			if (cflags[i] & PPMU_LIMITED_PMC_OK)
-				cflags[i] |= PPMU_LIMITED_PMC_REQD;
-
-	return 0;
-}
-
-static u64 check_and_compute_delta(u64 prev, u64 val)
-{
-	u64 delta = (val - prev) & 0xfffffffful;
-
-	/*
-	 * POWER7 can roll back counter values, if the new value is smaller
-	 * than the previous value it will cause the delta and the counter to
-	 * have bogus values unless we rolled a counter over.  If a coutner is
-	 * rolled back, it will be smaller, but within 256, which is the maximum
-	 * number of events to rollback at once.  If we dectect a rollback
-	 * return 0.  This can lead to a small lack of precision in the
-	 * counters.
-	 */
-	if (prev > val && (prev - val) < 256)
-		delta = 0;
-
-	return delta;
-}
-
-static void power_pmu_read(struct perf_event *event)
-{
-	s64 val, delta, prev;
-
-	if (event->hw.state & PERF_HES_STOPPED)
-		return;
-
-	if (!event->hw.idx)
-		return;
-	/*
-	 * Performance monitor interrupts come even when interrupts
-	 * are soft-disabled, as long as interrupts are hard-enabled.
-	 * Therefore we treat them like NMIs.
-	 */
-	do {
-		prev = local64_read(&event->hw.prev_count);
-		barrier();
-		val = read_pmc(event->hw.idx);
-		delta = check_and_compute_delta(prev, val);
-		if (!delta)
-			return;
-	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
-
-	local64_add(delta, &event->count);
-	local64_sub(delta, &event->hw.period_left);
-}
-
-/*
- * On some machines, PMC5 and PMC6 can't be written, don't respect
- * the freeze conditions, and don't generate interrupts.  This tells
- * us if `event' is using such a PMC.
- */
-static int is_limited_pmc(int pmcnum)
-{
-	return (ppmu->flags & PPMU_LIMITED_PMC5_6)
-		&& (pmcnum == 5 || pmcnum == 6);
-}
-
-static void freeze_limited_counters(struct cpu_hw_events *cpuhw,
-				    unsigned long pmc5, unsigned long pmc6)
-{
-	struct perf_event *event;
-	u64 val, prev, delta;
-	int i;
-
-	for (i = 0; i < cpuhw->n_limited; ++i) {
-		event = cpuhw->limited_counter[i];
-		if (!event->hw.idx)
-			continue;
-		val = (event->hw.idx == 5) ? pmc5 : pmc6;
-		prev = local64_read(&event->hw.prev_count);
-		event->hw.idx = 0;
-		delta = check_and_compute_delta(prev, val);
-		if (delta)
-			local64_add(delta, &event->count);
-	}
-}
-
-static void thaw_limited_counters(struct cpu_hw_events *cpuhw,
-				  unsigned long pmc5, unsigned long pmc6)
-{
-	struct perf_event *event;
-	u64 val, prev;
-	int i;
-
-	for (i = 0; i < cpuhw->n_limited; ++i) {
-		event = cpuhw->limited_counter[i];
-		event->hw.idx = cpuhw->limited_hwidx[i];
-		val = (event->hw.idx == 5) ? pmc5 : pmc6;
-		prev = local64_read(&event->hw.prev_count);
-		if (check_and_compute_delta(prev, val))
-			local64_set(&event->hw.prev_count, val);
-		perf_event_update_userpage(event);
-	}
-}
-
-/*
- * Since limited events don't respect the freeze conditions, we
- * have to read them immediately after freezing or unfreezing the
- * other events.  We try to keep the values from the limited
- * events as consistent as possible by keeping the delay (in
- * cycles and instructions) between freezing/unfreezing and reading
- * the limited events as small and consistent as possible.
- * Therefore, if any limited events are in use, we read them
- * both, and always in the same order, to minimize variability,
- * and do it inside the same asm that writes MMCR0.
- */
-static void write_mmcr0(struct cpu_hw_events *cpuhw, unsigned long mmcr0)
-{
-	unsigned long pmc5, pmc6;
-
-	if (!cpuhw->n_limited) {
-		mtspr(SPRN_MMCR0, mmcr0);
-		return;
-	}
-
-	/*
-	 * Write MMCR0, then read PMC5 and PMC6 immediately.
-	 * To ensure we don't get a performance monitor interrupt
-	 * between writing MMCR0 and freezing/thawing the limited
-	 * events, we first write MMCR0 with the event overflow
-	 * interrupt enable bits turned off.
-	 */
-	asm volatile("mtspr %3,%2; mfspr %0,%4; mfspr %1,%5"
-		     : "=&r" (pmc5), "=&r" (pmc6)
-		     : "r" (mmcr0 & ~(MMCR0_PMC1CE | MMCR0_PMCjCE)),
-		       "i" (SPRN_MMCR0),
-		       "i" (SPRN_PMC5), "i" (SPRN_PMC6));
-
-	if (mmcr0 & MMCR0_FC)
-		freeze_limited_counters(cpuhw, pmc5, pmc6);
-	else
-		thaw_limited_counters(cpuhw, pmc5, pmc6);
-
-	/*
-	 * Write the full MMCR0 including the event overflow interrupt
-	 * enable bits, if necessary.
-	 */
-	if (mmcr0 & (MMCR0_PMC1CE | MMCR0_PMCjCE))
-		mtspr(SPRN_MMCR0, mmcr0);
-}
-
-/*
- * Disable all events to prevent PMU interrupts and to allow
- * events to be added or removed.
- */
-static void power_pmu_disable(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
-
-	if (!ppmu)
-		return;
-	local_irq_save(flags);
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	if (!cpuhw->disabled) {
-		cpuhw->disabled = 1;
-		cpuhw->n_added = 0;
-
-		/*
-		 * Check if we ever enabled the PMU on this cpu.
-		 */
-		if (!cpuhw->pmcs_enabled) {
-			ppc_enable_pmcs();
-			cpuhw->pmcs_enabled = 1;
-		}
-
-		/*
-		 * Disable instruction sampling if it was enabled
-		 */
-		if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
-			mtspr(SPRN_MMCRA,
-			      cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
-			mb();
-		}
-
-		/*
-		 * Set the 'freeze counters' bit.
-		 * The barrier is to make sure the mtspr has been
-		 * executed and the PMU has frozen the events
-		 * before we return.
-		 */
-		write_mmcr0(cpuhw, mfspr(SPRN_MMCR0) | MMCR0_FC);
-		mb();
-	}
-	local_irq_restore(flags);
-}
-
-/*
- * Re-enable all events if disable == 0.
- * If we were previously disabled and events were added, then
- * put the new config on the PMU.
- */
-static void power_pmu_enable(struct pmu *pmu)
-{
-	struct perf_event *event;
-	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
-	long i;
-	unsigned long val;
-	s64 left;
-	unsigned int hwc_index[MAX_HWEVENTS];
-	int n_lim;
-	int idx;
-
-	if (!ppmu)
-		return;
-	local_irq_save(flags);
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-	if (!cpuhw->disabled) {
-		local_irq_restore(flags);
-		return;
-	}
-	cpuhw->disabled = 0;
-
-	/*
-	 * If we didn't change anything, or only removed events,
-	 * no need to recalculate MMCR* settings and reset the PMCs.
-	 * Just reenable the PMU with the current MMCR* settings
-	 * (possibly updated for removal of events).
-	 */
-	if (!cpuhw->n_added) {
-		mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
-		mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
-		if (cpuhw->n_events == 0)
-			ppc_set_pmu_inuse(0);
-		goto out_enable;
-	}
-
-	/*
-	 * Compute MMCR* values for the new set of events
-	 */
-	if (ppmu->compute_mmcr(cpuhw->events, cpuhw->n_events, hwc_index,
-			       cpuhw->mmcr)) {
-		/* shouldn't ever get here */
-		printk(KERN_ERR "oops compute_mmcr failed\n");
-		goto out;
-	}
-
-	/*
-	 * Add in MMCR0 freeze bits corresponding to the
-	 * attr.exclude_* bits for the first event.
-	 * We have already checked that all events have the
-	 * same values for these bits as the first event.
-	 */
-	event = cpuhw->event[0];
-	if (event->attr.exclude_user)
-		cpuhw->mmcr[0] |= MMCR0_FCP;
-	if (event->attr.exclude_kernel)
-		cpuhw->mmcr[0] |= freeze_events_kernel;
-	if (event->attr.exclude_hv)
-		cpuhw->mmcr[0] |= MMCR0_FCHV;
-
-	/*
-	 * Write the new configuration to MMCR* with the freeze
-	 * bit set and set the hardware events to their initial values.
-	 * Then unfreeze the events.
-	 */
-	ppc_set_pmu_inuse(1);
-	mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
-	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
-	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
-				| MMCR0_FC);
-
-	/*
-	 * Read off any pre-existing events that need to move
-	 * to another PMC.
-	 */
-	for (i = 0; i < cpuhw->n_events; ++i) {
-		event = cpuhw->event[i];
-		if (event->hw.idx && event->hw.idx != hwc_index[i] + 1) {
-			power_pmu_read(event);
-			write_pmc(event->hw.idx, 0);
-			event->hw.idx = 0;
-		}
-	}
-
-	/*
-	 * Initialize the PMCs for all the new and moved events.
-	 */
-	cpuhw->n_limited = n_lim = 0;
-	for (i = 0; i < cpuhw->n_events; ++i) {
-		event = cpuhw->event[i];
-		if (event->hw.idx)
-			continue;
-		idx = hwc_index[i] + 1;
-		if (is_limited_pmc(idx)) {
-			cpuhw->limited_counter[n_lim] = event;
-			cpuhw->limited_hwidx[n_lim] = idx;
-			++n_lim;
-			continue;
-		}
-		val = 0;
-		if (event->hw.sample_period) {
-			left = local64_read(&event->hw.period_left);
-			if (left < 0x80000000L)
-				val = 0x80000000L - left;
-		}
-		local64_set(&event->hw.prev_count, val);
-		event->hw.idx = idx;
-		if (event->hw.state & PERF_HES_STOPPED)
-			val = 0;
-		write_pmc(idx, val);
-		perf_event_update_userpage(event);
-	}
-	cpuhw->n_limited = n_lim;
-	cpuhw->mmcr[0] |= MMCR0_PMXE | MMCR0_FCECE;
-
- out_enable:
-	mb();
-	write_mmcr0(cpuhw, cpuhw->mmcr[0]);
-
-	/*
-	 * Enable instruction sampling if necessary
-	 */
-	if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
-		mb();
-		mtspr(SPRN_MMCRA, cpuhw->mmcr[2]);
-	}
-
- out:
-	local_irq_restore(flags);
-}
-
-static int collect_events(struct perf_event *group, int max_count,
-			  struct perf_event *ctrs[], u64 *events,
-			  unsigned int *flags)
-{
-	int n = 0;
-	struct perf_event *event;
-
-	if (!is_software_event(group)) {
-		if (n >= max_count)
-			return -1;
-		ctrs[n] = group;
-		flags[n] = group->hw.event_base;
-		events[n++] = group->hw.config;
-	}
-	list_for_each_entry(event, &group->sibling_list, group_entry) {
-		if (!is_software_event(event) &&
-		    event->state != PERF_EVENT_STATE_OFF) {
-			if (n >= max_count)
-				return -1;
-			ctrs[n] = event;
-			flags[n] = event->hw.event_base;
-			events[n++] = event->hw.config;
-		}
-	}
-	return n;
-}
-
-/*
- * Add a event to the PMU.
- * If all events are not already frozen, then we disable and
- * re-enable the PMU in order to get hw_perf_enable to do the
- * actual work of reconfiguring the PMU.
- */
-static int power_pmu_add(struct perf_event *event, int ef_flags)
-{
-	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
-	int n0;
-	int ret = -EAGAIN;
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	/*
-	 * Add the event to the list (if there is room)
-	 * and check whether the total set is still feasible.
-	 */
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-	n0 = cpuhw->n_events;
-	if (n0 >= ppmu->n_counter)
-		goto out;
-	cpuhw->event[n0] = event;
-	cpuhw->events[n0] = event->hw.config;
-	cpuhw->flags[n0] = event->hw.event_base;
-
-	if (!(ef_flags & PERF_EF_START))
-		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-
-	/*
-	 * If group events scheduling transaction was started,
-	 * skip the schedulability test here, it will be performed
-	 * at commit time(->commit_txn) as a whole
-	 */
-	if (cpuhw->group_flag & PERF_EVENT_TXN)
-		goto nocheck;
-
-	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
-		goto out;
-	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
-		goto out;
-	event->hw.config = cpuhw->events[n0];
-
-nocheck:
-	++cpuhw->n_events;
-	++cpuhw->n_added;
-
-	ret = 0;
- out:
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-	return ret;
-}
-
-/*
- * Remove a event from the PMU.
- */
-static void power_pmu_del(struct perf_event *event, int ef_flags)
-{
-	struct cpu_hw_events *cpuhw;
-	long i;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	power_pmu_read(event);
-
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-	for (i = 0; i < cpuhw->n_events; ++i) {
-		if (event == cpuhw->event[i]) {
-			while (++i < cpuhw->n_events) {
-				cpuhw->event[i-1] = cpuhw->event[i];
-				cpuhw->events[i-1] = cpuhw->events[i];
-				cpuhw->flags[i-1] = cpuhw->flags[i];
-			}
-			--cpuhw->n_events;
-			ppmu->disable_pmc(event->hw.idx - 1, cpuhw->mmcr);
-			if (event->hw.idx) {
-				write_pmc(event->hw.idx, 0);
-				event->hw.idx = 0;
-			}
-			perf_event_update_userpage(event);
-			break;
-		}
-	}
-	for (i = 0; i < cpuhw->n_limited; ++i)
-		if (event == cpuhw->limited_counter[i])
-			break;
-	if (i < cpuhw->n_limited) {
-		while (++i < cpuhw->n_limited) {
-			cpuhw->limited_counter[i-1] = cpuhw->limited_counter[i];
-			cpuhw->limited_hwidx[i-1] = cpuhw->limited_hwidx[i];
-		}
-		--cpuhw->n_limited;
-	}
-	if (cpuhw->n_events == 0) {
-		/* disable exceptions if no events are running */
-		cpuhw->mmcr[0] &= ~(MMCR0_PMXE | MMCR0_FCECE);
-	}
-
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-}
-
-/*
- * POWER-PMU does not support disabling individual counters, hence
- * program their cycle counter to their max value and ignore the interrupts.
- */
-
-static void power_pmu_start(struct perf_event *event, int ef_flags)
-{
-	unsigned long flags;
-	s64 left;
-	unsigned long val;
-
-	if (!event->hw.idx || !event->hw.sample_period)
-		return;
-
-	if (!(event->hw.state & PERF_HES_STOPPED))
-		return;
-
-	if (ef_flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	event->hw.state = 0;
-	left = local64_read(&event->hw.period_left);
-
-	val = 0;
-	if (left < 0x80000000L)
-		val = 0x80000000L - left;
-
-	write_pmc(event->hw.idx, val);
-
-	perf_event_update_userpage(event);
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-}
-
-static void power_pmu_stop(struct perf_event *event, int ef_flags)
-{
-	unsigned long flags;
-
-	if (!event->hw.idx || !event->hw.sample_period)
-		return;
-
-	if (event->hw.state & PERF_HES_STOPPED)
-		return;
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	power_pmu_read(event);
-	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	write_pmc(event->hw.idx, 0);
-
-	perf_event_update_userpage(event);
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-}
-
-/*
- * Start group events scheduling transaction
- * Set the flag to make pmu::enable() not perform the
- * schedulability test, it will be performed at commit time
- */
-void power_pmu_start_txn(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	perf_pmu_disable(pmu);
-	cpuhw->group_flag |= PERF_EVENT_TXN;
-	cpuhw->n_txn_start = cpuhw->n_events;
-}
-
-/*
- * Stop group events scheduling transaction
- * Clear the flag and pmu::enable() will perform the
- * schedulability test.
- */
-void power_pmu_cancel_txn(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
-	perf_pmu_enable(pmu);
-}
-
-/*
- * Commit group events scheduling transaction
- * Perform the group schedulability test as a whole
- * Return 0 if success
- */
-int power_pmu_commit_txn(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw;
-	long i, n;
-
-	if (!ppmu)
-		return -EAGAIN;
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-	n = cpuhw->n_events;
-	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
-		return -EAGAIN;
-	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
-	if (i < 0)
-		return -EAGAIN;
-
-	for (i = cpuhw->n_txn_start; i < n; ++i)
-		cpuhw->event[i]->hw.config = cpuhw->events[i];
-
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
-	perf_pmu_enable(pmu);
-	return 0;
-}
-
-/*
- * Return 1 if we might be able to put event on a limited PMC,
- * or 0 if not.
- * A event can only go on a limited PMC if it counts something
- * that a limited PMC can count, doesn't require interrupts, and
- * doesn't exclude any processor mode.
- */
-static int can_go_on_limited_pmc(struct perf_event *event, u64 ev,
-				 unsigned int flags)
-{
-	int n;
-	u64 alt[MAX_EVENT_ALTERNATIVES];
-
-	if (event->attr.exclude_user
-	    || event->attr.exclude_kernel
-	    || event->attr.exclude_hv
-	    || event->attr.sample_period)
-		return 0;
-
-	if (ppmu->limited_pmc_event(ev))
-		return 1;
-
-	/*
-	 * The requested event_id isn't on a limited PMC already;
-	 * see if any alternative code goes on a limited PMC.
-	 */
-	if (!ppmu->get_alternatives)
-		return 0;
-
-	flags |= PPMU_LIMITED_PMC_OK | PPMU_LIMITED_PMC_REQD;
-	n = ppmu->get_alternatives(ev, flags, alt);
-
-	return n > 0;
-}
-
-/*
- * Find an alternative event_id that goes on a normal PMC, if possible,
- * and return the event_id code, or 0 if there is no such alternative.
- * (Note: event_id code 0 is "don't count" on all machines.)
- */
-static u64 normal_pmc_alternative(u64 ev, unsigned long flags)
-{
-	u64 alt[MAX_EVENT_ALTERNATIVES];
-	int n;
-
-	flags &= ~(PPMU_LIMITED_PMC_OK | PPMU_LIMITED_PMC_REQD);
-	n = ppmu->get_alternatives(ev, flags, alt);
-	if (!n)
-		return 0;
-	return alt[0];
-}
-
-/* Number of perf_events counting hardware events */
-static atomic_t num_events;
-/* Used to avoid races in calling reserve/release_pmc_hardware */
-static DEFINE_MUTEX(pmc_reserve_mutex);
-
-/*
- * Release the PMU if this is the last perf_event.
- */
-static void hw_perf_event_destroy(struct perf_event *event)
-{
-	if (!atomic_add_unless(&num_events, -1, 1)) {
-		mutex_lock(&pmc_reserve_mutex);
-		if (atomic_dec_return(&num_events) == 0)
-			release_pmc_hardware();
-		mutex_unlock(&pmc_reserve_mutex);
-	}
-}
-
-/*
- * Translate a generic cache event_id config to a raw event_id code.
- */
-static int hw_perf_cache_event(u64 config, u64 *eventp)
-{
-	unsigned long type, op, result;
-	int ev;
-
-	if (!ppmu->cache_events)
-		return -EINVAL;
-
-	/* unpack config */
-	type = config & 0xff;
-	op = (config >> 8) & 0xff;
-	result = (config >> 16) & 0xff;
-
-	if (type >= PERF_COUNT_HW_CACHE_MAX ||
-	    op >= PERF_COUNT_HW_CACHE_OP_MAX ||
-	    result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
-		return -EINVAL;
-
-	ev = (*ppmu->cache_events)[type][op][result];
-	if (ev == 0)
-		return -EOPNOTSUPP;
-	if (ev == -1)
-		return -EINVAL;
-	*eventp = ev;
-	return 0;
-}
-
-static int power_pmu_event_init(struct perf_event *event)
-{
-	u64 ev;
-	unsigned long flags;
-	struct perf_event *ctrs[MAX_HWEVENTS];
-	u64 events[MAX_HWEVENTS];
-	unsigned int cflags[MAX_HWEVENTS];
-	int n;
-	int err;
-	struct cpu_hw_events *cpuhw;
-
-	if (!ppmu)
-		return -ENOENT;
-
-	switch (event->attr.type) {
-	case PERF_TYPE_HARDWARE:
-		ev = event->attr.config;
-		if (ev >= ppmu->n_generic || ppmu->generic_events[ev] == 0)
-			return -EOPNOTSUPP;
-		ev = ppmu->generic_events[ev];
-		break;
-	case PERF_TYPE_HW_CACHE:
-		err = hw_perf_cache_event(event->attr.config, &ev);
-		if (err)
-			return err;
-		break;
-	case PERF_TYPE_RAW:
-		ev = event->attr.config;
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	event->hw.config_base = ev;
-	event->hw.idx = 0;
-
-	/*
-	 * If we are not running on a hypervisor, force the
-	 * exclude_hv bit to 0 so that we don't care what
-	 * the user set it to.
-	 */
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		event->attr.exclude_hv = 0;
-
-	/*
-	 * If this is a per-task event, then we can use
-	 * PM_RUN_* events interchangeably with their non RUN_*
-	 * equivalents, e.g. PM_RUN_CYC instead of PM_CYC.
-	 * XXX we should check if the task is an idle task.
-	 */
-	flags = 0;
-	if (event->attach_state & PERF_ATTACH_TASK)
-		flags |= PPMU_ONLY_COUNT_RUN;
-
-	/*
-	 * If this machine has limited events, check whether this
-	 * event_id could go on a limited event.
-	 */
-	if (ppmu->flags & PPMU_LIMITED_PMC5_6) {
-		if (can_go_on_limited_pmc(event, ev, flags)) {
-			flags |= PPMU_LIMITED_PMC_OK;
-		} else if (ppmu->limited_pmc_event(ev)) {
-			/*
-			 * The requested event_id is on a limited PMC,
-			 * but we can't use a limited PMC; see if any
-			 * alternative goes on a normal PMC.
-			 */
-			ev = normal_pmc_alternative(ev, flags);
-			if (!ev)
-				return -EINVAL;
-		}
-	}
-
-	/*
-	 * If this is in a group, check if it can go on with all the
-	 * other hardware events in the group.  We assume the event
-	 * hasn't been linked into its leader's sibling list at this point.
-	 */
-	n = 0;
-	if (event->group_leader != event) {
-		n = collect_events(event->group_leader, ppmu->n_counter - 1,
-				   ctrs, events, cflags);
-		if (n < 0)
-			return -EINVAL;
-	}
-	events[n] = ev;
-	ctrs[n] = event;
-	cflags[n] = flags;
-	if (check_excludes(ctrs, cflags, n, 1))
-		return -EINVAL;
-
-	cpuhw = &get_cpu_var(cpu_hw_events);
-	err = power_check_constraints(cpuhw, events, cflags, n + 1);
-	put_cpu_var(cpu_hw_events);
-	if (err)
-		return -EINVAL;
-
-	event->hw.config = events[n];
-	event->hw.event_base = cflags[n];
-	event->hw.last_period = event->hw.sample_period;
-	local64_set(&event->hw.period_left, event->hw.last_period);
-
-	/*
-	 * See if we need to reserve the PMU.
-	 * If no events are currently in use, then we have to take a
-	 * mutex to ensure that we don't race with another task doing
-	 * reserve_pmc_hardware or release_pmc_hardware.
-	 */
-	err = 0;
-	if (!atomic_inc_not_zero(&num_events)) {
-		mutex_lock(&pmc_reserve_mutex);
-		if (atomic_read(&num_events) == 0 &&
-		    reserve_pmc_hardware(perf_event_interrupt))
-			err = -EBUSY;
-		else
-			atomic_inc(&num_events);
-		mutex_unlock(&pmc_reserve_mutex);
-	}
-	event->destroy = hw_perf_event_destroy;
-
-	return err;
-}
-
-struct pmu power_pmu = {
-	.pmu_enable	= power_pmu_enable,
-	.pmu_disable	= power_pmu_disable,
-	.event_init	= power_pmu_event_init,
-	.add		= power_pmu_add,
-	.del		= power_pmu_del,
-	.start		= power_pmu_start,
-	.stop		= power_pmu_stop,
-	.read		= power_pmu_read,
-	.start_txn	= power_pmu_start_txn,
-	.cancel_txn	= power_pmu_cancel_txn,
-	.commit_txn	= power_pmu_commit_txn,
-};
-
-/*
- * A counter has overflowed; update its count and record
- * things if requested.  Note that interrupts are hard-disabled
- * here so there is no possibility of being interrupted.
- */
-static void record_and_restart(struct perf_event *event, unsigned long val,
-			       struct pt_regs *regs)
-{
-	u64 period = event->hw.sample_period;
-	s64 prev, delta, left;
-	int record = 0;
-
-	if (event->hw.state & PERF_HES_STOPPED) {
-		write_pmc(event->hw.idx, 0);
-		return;
-	}
-
-	/* we don't have to worry about interrupts here */
-	prev = local64_read(&event->hw.prev_count);
-	delta = check_and_compute_delta(prev, val);
-	local64_add(delta, &event->count);
-
-	/*
-	 * See if the total period for this event has expired,
-	 * and update for the next period.
-	 */
-	val = 0;
-	left = local64_read(&event->hw.period_left) - delta;
-	if (period) {
-		if (left <= 0) {
-			left += period;
-			if (left <= 0)
-				left = period;
-			record = 1;
-			event->hw.last_period = event->hw.sample_period;
-		}
-		if (left < 0x80000000LL)
-			val = 0x80000000LL - left;
-	}
-
-	write_pmc(event->hw.idx, val);
-	local64_set(&event->hw.prev_count, val);
-	local64_set(&event->hw.period_left, left);
-	perf_event_update_userpage(event);
-
-	/*
-	 * Finally record data if requested.
-	 */
-	if (record) {
-		struct perf_sample_data data;
-
-		perf_sample_data_init(&data, ~0ULL);
-		data.period = event->hw.last_period;
-
-		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
-			perf_get_data_addr(regs, &data.addr);
-
-		if (perf_event_overflow(event, &data, regs))
-			power_pmu_stop(event, 0);
-	}
-}
-
-/*
- * Called from generic code to get the misc flags (i.e. processor mode)
- * for an event_id.
- */
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	u32 flags = perf_get_misc_flags(regs);
-
-	if (flags)
-		return flags;
-	return user_mode(regs) ? PERF_RECORD_MISC_USER :
-		PERF_RECORD_MISC_KERNEL;
-}
-
-/*
- * Called from generic code to get the instruction pointer
- * for an event_id.
- */
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	unsigned long ip;
-
-	if (TRAP(regs) != 0xf00)
-		return regs->nip;	/* not a PMU interrupt */
-
-	ip = mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
-	return ip;
-}
-
-static bool pmc_overflow(unsigned long val)
-{
-	if ((int)val < 0)
-		return true;
-
-	/*
-	 * Events on POWER7 can roll back if a speculative event doesn't
-	 * eventually complete. Unfortunately in some rare cases they will
-	 * raise a performance monitor exception. We need to catch this to
-	 * ensure we reset the PMC. In all cases the PMC will be 256 or less
-	 * cycles from overflow.
-	 *
-	 * We only do this if the first pass fails to find any overflowing
-	 * PMCs because a user might set a period of less than 256 and we
-	 * don't want to mistakenly reset them.
-	 */
-	if (__is_processor(PV_POWER7) && ((0x80000000 - val) <= 256))
-		return true;
-
-	return false;
-}
-
-/*
- * Performance monitor interrupt stuff
- */
-static void perf_event_interrupt(struct pt_regs *regs)
-{
-	int i;
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-	struct perf_event *event;
-	unsigned long val;
-	int found = 0;
-	int nmi;
-
-	if (cpuhw->n_limited)
-		freeze_limited_counters(cpuhw, mfspr(SPRN_PMC5),
-					mfspr(SPRN_PMC6));
-
-	perf_read_regs(regs);
-
-	nmi = perf_intr_is_nmi(regs);
-	if (nmi)
-		nmi_enter();
-	else
-		irq_enter();
-
-	for (i = 0; i < cpuhw->n_events; ++i) {
-		event = cpuhw->event[i];
-		if (!event->hw.idx || is_limited_pmc(event->hw.idx))
-			continue;
-		val = read_pmc(event->hw.idx);
-		if ((int)val < 0) {
-			/* event has overflowed */
-			found = 1;
-			record_and_restart(event, val, regs);
-		}
-	}
-
-	/*
-	 * In case we didn't find and reset the event that caused
-	 * the interrupt, scan all events and reset any that are
-	 * negative, to avoid getting continual interrupts.
-	 * Any that we processed in the previous loop will not be negative.
-	 */
-	if (!found) {
-		for (i = 0; i < ppmu->n_counter; ++i) {
-			if (is_limited_pmc(i + 1))
-				continue;
-			val = read_pmc(i + 1);
-			if (pmc_overflow(val))
-				write_pmc(i + 1, 0);
-		}
-	}
-
-	/*
-	 * Reset MMCR0 to its normal value.  This will set PMXE and
-	 * clear FC (freeze counters) and PMAO (perf mon alert occurred)
-	 * and thus allow interrupts to occur again.
-	 * XXX might want to use MSR.PM to keep the events frozen until
-	 * we get back out of this interrupt.
-	 */
-	write_mmcr0(cpuhw, cpuhw->mmcr[0]);
-
-	if (nmi)
-		nmi_exit();
-	else
-		irq_exit();
-}
-
-static void power_pmu_setup(int cpu)
-{
-	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
-
-	if (!ppmu)
-		return;
-	memset(cpuhw, 0, sizeof(*cpuhw));
-	cpuhw->mmcr[0] = MMCR0_FC;
-}
-
-static int __cpuinit
-power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-		power_pmu_setup(cpu);
-		break;
-
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-int __cpuinit register_power_pmu(struct power_pmu *pmu)
-{
-	if (ppmu)
-		return -EBUSY;		/* something's already registered */
-
-	ppmu = pmu;
-	pr_info("%s performance monitor hardware support registered\n",
-		pmu->name);
-
-#ifdef MSR_HV
-	/*
-	 * Use FCHV to ignore kernel events if MSR.HV is set.
-	 */
-	if (mfmsr() & MSR_HV)
-		freeze_events_kernel = MMCR0_FCHV;
-#endif /* CONFIG_PPC64 */
-
-	perf_pmu_register(&power_pmu, "cpu", PERF_TYPE_RAW);
-	perf_cpu_notifier(power_pmu_notifier);
-
-	return 0;
-}
diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/kernel/perf_event_fsl_emb.c
deleted file mode 100644
index 0a6d2a9..0000000
--- a/arch/powerpc/kernel/perf_event_fsl_emb.c
+++ /dev/null
@@ -1,688 +0,0 @@
-/*
- * Performance event support - Freescale Embedded Performance Monitor
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/perf_event.h>
-#include <linux/percpu.h>
-#include <linux/hardirq.h>
-#include <asm/reg_fsl_emb.h>
-#include <asm/pmc.h>
-#include <asm/machdep.h>
-#include <asm/firmware.h>
-#include <asm/ptrace.h>
-
-struct cpu_hw_events {
-	int n_events;
-	int disabled;
-	u8  pmcs_enabled;
-	struct perf_event *event[MAX_HWEVENTS];
-};
-static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
-
-static struct fsl_emb_pmu *ppmu;
-
-/* Number of perf_events counting hardware events */
-static atomic_t num_events;
-/* Used to avoid races in calling reserve/release_pmc_hardware */
-static DEFINE_MUTEX(pmc_reserve_mutex);
-
-/*
- * If interrupts were soft-disabled when a PMU interrupt occurs, treat
- * it as an NMI.
- */
-static inline int perf_intr_is_nmi(struct pt_regs *regs)
-{
-#ifdef __powerpc64__
-	return !regs->softe;
-#else
-	return 0;
-#endif
-}
-
-static void perf_event_interrupt(struct pt_regs *regs);
-
-/*
- * Read one performance monitor counter (PMC).
- */
-static unsigned long read_pmc(int idx)
-{
-	unsigned long val;
-
-	switch (idx) {
-	case 0:
-		val = mfpmr(PMRN_PMC0);
-		break;
-	case 1:
-		val = mfpmr(PMRN_PMC1);
-		break;
-	case 2:
-		val = mfpmr(PMRN_PMC2);
-		break;
-	case 3:
-		val = mfpmr(PMRN_PMC3);
-		break;
-	default:
-		printk(KERN_ERR "oops trying to read PMC%d\n", idx);
-		val = 0;
-	}
-	return val;
-}
-
-/*
- * Write one PMC.
- */
-static void write_pmc(int idx, unsigned long val)
-{
-	switch (idx) {
-	case 0:
-		mtpmr(PMRN_PMC0, val);
-		break;
-	case 1:
-		mtpmr(PMRN_PMC1, val);
-		break;
-	case 2:
-		mtpmr(PMRN_PMC2, val);
-		break;
-	case 3:
-		mtpmr(PMRN_PMC3, val);
-		break;
-	default:
-		printk(KERN_ERR "oops trying to write PMC%d\n", idx);
-	}
-
-	isync();
-}
-
-/*
- * Write one local control A register
- */
-static void write_pmlca(int idx, unsigned long val)
-{
-	switch (idx) {
-	case 0:
-		mtpmr(PMRN_PMLCA0, val);
-		break;
-	case 1:
-		mtpmr(PMRN_PMLCA1, val);
-		break;
-	case 2:
-		mtpmr(PMRN_PMLCA2, val);
-		break;
-	case 3:
-		mtpmr(PMRN_PMLCA3, val);
-		break;
-	default:
-		printk(KERN_ERR "oops trying to write PMLCA%d\n", idx);
-	}
-
-	isync();
-}
-
-/*
- * Write one local control B register
- */
-static void write_pmlcb(int idx, unsigned long val)
-{
-	switch (idx) {
-	case 0:
-		mtpmr(PMRN_PMLCB0, val);
-		break;
-	case 1:
-		mtpmr(PMRN_PMLCB1, val);
-		break;
-	case 2:
-		mtpmr(PMRN_PMLCB2, val);
-		break;
-	case 3:
-		mtpmr(PMRN_PMLCB3, val);
-		break;
-	default:
-		printk(KERN_ERR "oops trying to write PMLCB%d\n", idx);
-	}
-
-	isync();
-}
-
-static void fsl_emb_pmu_read(struct perf_event *event)
-{
-	s64 val, delta, prev;
-
-	if (event->hw.state & PERF_HES_STOPPED)
-		return;
-
-	/*
-	 * Performance monitor interrupts come even when interrupts
-	 * are soft-disabled, as long as interrupts are hard-enabled.
-	 * Therefore we treat them like NMIs.
-	 */
-	do {
-		prev = local64_read(&event->hw.prev_count);
-		barrier();
-		val = read_pmc(event->hw.idx);
-	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
-
-	/* The counters are only 32 bits wide */
-	delta = (val - prev) & 0xfffffffful;
-	local64_add(delta, &event->count);
-	local64_sub(delta, &event->hw.period_left);
-}
-
-/*
- * Disable all events to prevent PMU interrupts and to allow
- * events to be added or removed.
- */
-static void fsl_emb_pmu_disable(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	if (!cpuhw->disabled) {
-		cpuhw->disabled = 1;
-
-		/*
-		 * Check if we ever enabled the PMU on this cpu.
-		 */
-		if (!cpuhw->pmcs_enabled) {
-			ppc_enable_pmcs();
-			cpuhw->pmcs_enabled = 1;
-		}
-
-		if (atomic_read(&num_events)) {
-			/*
-			 * Set the 'freeze all counters' bit, and disable
-			 * interrupts.  The barrier is to make sure the
-			 * mtpmr has been executed and the PMU has frozen
-			 * the events before we return.
-			 */
-
-			mtpmr(PMRN_PMGC0, PMGC0_FAC);
-			isync();
-		}
-	}
-	local_irq_restore(flags);
-}
-
-/*
- * Re-enable all events if disable == 0.
- * If we were previously disabled and events were added, then
- * put the new config on the PMU.
- */
-static void fsl_emb_pmu_enable(struct pmu *pmu)
-{
-	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cpuhw = &__get_cpu_var(cpu_hw_events);
-	if (!cpuhw->disabled)
-		goto out;
-
-	cpuhw->disabled = 0;
-	ppc_set_pmu_inuse(cpuhw->n_events != 0);
-
-	if (cpuhw->n_events > 0) {
-		mtpmr(PMRN_PMGC0, PMGC0_PMIE | PMGC0_FCECE);
-		isync();
-	}
-
- out:
-	local_irq_restore(flags);
-}
-
-static int collect_events(struct perf_event *group, int max_count,
-			  struct perf_event *ctrs[])
-{
-	int n = 0;
-	struct perf_event *event;
-
-	if (!is_software_event(group)) {
-		if (n >= max_count)
-			return -1;
-		ctrs[n] = group;
-		n++;
-	}
-	list_for_each_entry(event, &group->sibling_list, group_entry) {
-		if (!is_software_event(event) &&
-		    event->state != PERF_EVENT_STATE_OFF) {
-			if (n >= max_count)
-				return -1;
-			ctrs[n] = event;
-			n++;
-		}
-	}
-	return n;
-}
-
-/* context locked on entry */
-static int fsl_emb_pmu_add(struct perf_event *event, int flags)
-{
-	struct cpu_hw_events *cpuhw;
-	int ret = -EAGAIN;
-	int num_counters = ppmu->n_counter;
-	u64 val;
-	int i;
-
-	perf_pmu_disable(event->pmu);
-	cpuhw = &get_cpu_var(cpu_hw_events);
-
-	if (event->hw.config & FSL_EMB_EVENT_RESTRICTED)
-		num_counters = ppmu->n_restricted;
-
-	/*
-	 * Allocate counters from top-down, so that restricted-capable
-	 * counters are kept free as long as possible.
-	 */
-	for (i = num_counters - 1; i >= 0; i--) {
-		if (cpuhw->event[i])
-			continue;
-
-		break;
-	}
-
-	if (i < 0)
-		goto out;
-
-	event->hw.idx = i;
-	cpuhw->event[i] = event;
-	++cpuhw->n_events;
-
-	val = 0;
-	if (event->hw.sample_period) {
-		s64 left = local64_read(&event->hw.period_left);
-		if (left < 0x80000000L)
-			val = 0x80000000L - left;
-	}
-	local64_set(&event->hw.prev_count, val);
-
-	if (!(flags & PERF_EF_START)) {
-		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-		val = 0;
-	}
-
-	write_pmc(i, val);
-	perf_event_update_userpage(event);
-
-	write_pmlcb(i, event->hw.config >> 32);
-	write_pmlca(i, event->hw.config_base);
-
-	ret = 0;
- out:
-	put_cpu_var(cpu_hw_events);
-	perf_pmu_enable(event->pmu);
-	return ret;
-}
-
-/* context locked on entry */
-static void fsl_emb_pmu_del(struct perf_event *event, int flags)
-{
-	struct cpu_hw_events *cpuhw;
-	int i = event->hw.idx;
-
-	perf_pmu_disable(event->pmu);
-	if (i < 0)
-		goto out;
-
-	fsl_emb_pmu_read(event);
-
-	cpuhw = &get_cpu_var(cpu_hw_events);
-
-	WARN_ON(event != cpuhw->event[event->hw.idx]);
-
-	write_pmlca(i, 0);
-	write_pmlcb(i, 0);
-	write_pmc(i, 0);
-
-	cpuhw->event[i] = NULL;
-	event->hw.idx = -1;
-
-	/*
-	 * TODO: if at least one restricted event exists, and we
-	 * just freed up a non-restricted-capable counter, and
-	 * there is a restricted-capable counter occupied by
-	 * a non-restricted event, migrate that event to the
-	 * vacated counter.
-	 */
-
-	cpuhw->n_events--;
-
- out:
-	perf_pmu_enable(event->pmu);
-	put_cpu_var(cpu_hw_events);
-}
-
-static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)
-{
-	unsigned long flags;
-	s64 left;
-
-	if (event->hw.idx < 0 || !event->hw.sample_period)
-		return;
-
-	if (!(event->hw.state & PERF_HES_STOPPED))
-		return;
-
-	if (ef_flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	event->hw.state = 0;
-	left = local64_read(&event->hw.period_left);
-	write_pmc(event->hw.idx, left);
-
-	perf_event_update_userpage(event);
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-}
-
-static void fsl_emb_pmu_stop(struct perf_event *event, int ef_flags)
-{
-	unsigned long flags;
-
-	if (event->hw.idx < 0 || !event->hw.sample_period)
-		return;
-
-	if (event->hw.state & PERF_HES_STOPPED)
-		return;
-
-	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
-
-	fsl_emb_pmu_read(event);
-	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	write_pmc(event->hw.idx, 0);
-
-	perf_event_update_userpage(event);
-	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
-}
-
-/*
- * Release the PMU if this is the last perf_event.
- */
-static void hw_perf_event_destroy(struct perf_event *event)
-{
-	if (!atomic_add_unless(&num_events, -1, 1)) {
-		mutex_lock(&pmc_reserve_mutex);
-		if (atomic_dec_return(&num_events) == 0)
-			release_pmc_hardware();
-		mutex_unlock(&pmc_reserve_mutex);
-	}
-}
-
-/*
- * Translate a generic cache event_id config to a raw event_id code.
- */
-static int hw_perf_cache_event(u64 config, u64 *eventp)
-{
-	unsigned long type, op, result;
-	int ev;
-
-	if (!ppmu->cache_events)
-		return -EINVAL;
-
-	/* unpack config */
-	type = config & 0xff;
-	op = (config >> 8) & 0xff;
-	result = (config >> 16) & 0xff;
-
-	if (type >= PERF_COUNT_HW_CACHE_MAX ||
-	    op >= PERF_COUNT_HW_CACHE_OP_MAX ||
-	    result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
-		return -EINVAL;
-
-	ev = (*ppmu->cache_events)[type][op][result];
-	if (ev == 0)
-		return -EOPNOTSUPP;
-	if (ev == -1)
-		return -EINVAL;
-	*eventp = ev;
-	return 0;
-}
-
-static int fsl_emb_pmu_event_init(struct perf_event *event)
-{
-	u64 ev;
-	struct perf_event *events[MAX_HWEVENTS];
-	int n;
-	int err;
-	int num_restricted;
-	int i;
-
-	switch (event->attr.type) {
-	case PERF_TYPE_HARDWARE:
-		ev = event->attr.config;
-		if (ev >= ppmu->n_generic || ppmu->generic_events[ev] == 0)
-			return -EOPNOTSUPP;
-		ev = ppmu->generic_events[ev];
-		break;
-
-	case PERF_TYPE_HW_CACHE:
-		err = hw_perf_cache_event(event->attr.config, &ev);
-		if (err)
-			return err;
-		break;
-
-	case PERF_TYPE_RAW:
-		ev = event->attr.config;
-		break;
-
-	default:
-		return -ENOENT;
-	}
-
-	event->hw.config = ppmu->xlate_event(ev);
-	if (!(event->hw.config & FSL_EMB_EVENT_VALID))
-		return -EINVAL;
-
-	/*
-	 * If this is in a group, check if it can go on with all the
-	 * other hardware events in the group.  We assume the event
-	 * hasn't been linked into its leader's sibling list at this point.
-	 */
-	n = 0;
-	if (event->group_leader != event) {
-		n = collect_events(event->group_leader,
-		                   ppmu->n_counter - 1, events);
-		if (n < 0)
-			return -EINVAL;
-	}
-
-	if (event->hw.config & FSL_EMB_EVENT_RESTRICTED) {
-		num_restricted = 0;
-		for (i = 0; i < n; i++) {
-			if (events[i]->hw.config & FSL_EMB_EVENT_RESTRICTED)
-				num_restricted++;
-		}
-
-		if (num_restricted >= ppmu->n_restricted)
-			return -EINVAL;
-	}
-
-	event->hw.idx = -1;
-
-	event->hw.config_base = PMLCA_CE | PMLCA_FCM1 |
-	                        (u32)((ev << 16) & PMLCA_EVENT_MASK);
-
-	if (event->attr.exclude_user)
-		event->hw.config_base |= PMLCA_FCU;
-	if (event->attr.exclude_kernel)
-		event->hw.config_base |= PMLCA_FCS;
-	if (event->attr.exclude_idle)
-		return -ENOTSUPP;
-
-	event->hw.last_period = event->hw.sample_period;
-	local64_set(&event->hw.period_left, event->hw.last_period);
-
-	/*
-	 * See if we need to reserve the PMU.
-	 * If no events are currently in use, then we have to take a
-	 * mutex to ensure that we don't race with another task doing
-	 * reserve_pmc_hardware or release_pmc_hardware.
-	 */
-	err = 0;
-	if (!atomic_inc_not_zero(&num_events)) {
-		mutex_lock(&pmc_reserve_mutex);
-		if (atomic_read(&num_events) == 0 &&
-		    reserve_pmc_hardware(perf_event_interrupt))
-			err = -EBUSY;
-		else
-			atomic_inc(&num_events);
-		mutex_unlock(&pmc_reserve_mutex);
-
-		mtpmr(PMRN_PMGC0, PMGC0_FAC);
-		isync();
-	}
-	event->destroy = hw_perf_event_destroy;
-
-	return err;
-}
-
-static struct pmu fsl_emb_pmu = {
-	.pmu_enable	= fsl_emb_pmu_enable,
-	.pmu_disable	= fsl_emb_pmu_disable,
-	.event_init	= fsl_emb_pmu_event_init,
-	.add		= fsl_emb_pmu_add,
-	.del		= fsl_emb_pmu_del,
-	.start		= fsl_emb_pmu_start,
-	.stop		= fsl_emb_pmu_stop,
-	.read		= fsl_emb_pmu_read,
-};
-
-/*
- * A counter has overflowed; update its count and record
- * things if requested.  Note that interrupts are hard-disabled
- * here so there is no possibility of being interrupted.
- */
-static void record_and_restart(struct perf_event *event, unsigned long val,
-			       struct pt_regs *regs)
-{
-	u64 period = event->hw.sample_period;
-	s64 prev, delta, left;
-	int record = 0;
-
-	if (event->hw.state & PERF_HES_STOPPED) {
-		write_pmc(event->hw.idx, 0);
-		return;
-	}
-
-	/* we don't have to worry about interrupts here */
-	prev = local64_read(&event->hw.prev_count);
-	delta = (val - prev) & 0xfffffffful;
-	local64_add(delta, &event->count);
-
-	/*
-	 * See if the total period for this event has expired,
-	 * and update for the next period.
-	 */
-	val = 0;
-	left = local64_read(&event->hw.period_left) - delta;
-	if (period) {
-		if (left <= 0) {
-			left += period;
-			if (left <= 0)
-				left = period;
-			record = 1;
-			event->hw.last_period = event->hw.sample_period;
-		}
-		if (left < 0x80000000LL)
-			val = 0x80000000LL - left;
-	}
-
-	write_pmc(event->hw.idx, val);
-	local64_set(&event->hw.prev_count, val);
-	local64_set(&event->hw.period_left, left);
-	perf_event_update_userpage(event);
-
-	/*
-	 * Finally record data if requested.
-	 */
-	if (record) {
-		struct perf_sample_data data;
-
-		perf_sample_data_init(&data, 0);
-		data.period = event->hw.last_period;
-
-		if (perf_event_overflow(event, &data, regs))
-			fsl_emb_pmu_stop(event, 0);
-	}
-}
-
-static void perf_event_interrupt(struct pt_regs *regs)
-{
-	int i;
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-	struct perf_event *event;
-	unsigned long val;
-	int found = 0;
-	int nmi;
-
-	nmi = perf_intr_is_nmi(regs);
-	if (nmi)
-		nmi_enter();
-	else
-		irq_enter();
-
-	for (i = 0; i < ppmu->n_counter; ++i) {
-		event = cpuhw->event[i];
-
-		val = read_pmc(i);
-		if ((int)val < 0) {
-			if (event) {
-				/* event has overflowed */
-				found = 1;
-				record_and_restart(event, val, regs);
-			} else {
-				/*
-				 * Disabled counter is negative,
-				 * reset it just in case.
-				 */
-				write_pmc(i, 0);
-			}
-		}
-	}
-
-	/* PMM will keep counters frozen until we return from the interrupt. */
-	mtmsr(mfmsr() | MSR_PMM);
-	mtpmr(PMRN_PMGC0, PMGC0_PMIE | PMGC0_FCECE);
-	isync();
-
-	if (nmi)
-		nmi_exit();
-	else
-		irq_exit();
-}
-
-void hw_perf_event_setup(int cpu)
-{
-	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
-
-	memset(cpuhw, 0, sizeof(*cpuhw));
-}
-
-int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
-{
-	if (ppmu)
-		return -EBUSY;		/* something's already registered */
-
-	ppmu = pmu;
-	pr_info("%s performance monitor hardware support registered\n",
-		pmu->name);
-
-	perf_pmu_register(&fsl_emb_pmu, "cpu", PERF_TYPE_RAW);
-
-	return 0;
-}
diff --git a/arch/powerpc/kernel/power4-pmu.c b/arch/powerpc/kernel/power4-pmu.c
deleted file mode 100644
index b4f1dda..0000000
--- a/arch/powerpc/kernel/power4-pmu.c
+++ /dev/null
@@ -1,621 +0,0 @@
-/*
- * Performance counter support for POWER4 (GP) and POWER4+ (GQ) processors.
- *
- * Copyright 2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/perf_event.h>
-#include <linux/string.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for POWER4
- */
-#define PM_PMC_SH	12	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0xf
-#define PM_UNIT_SH	8	/* TTMMUX number and setting - unit select */
-#define PM_UNIT_MSK	0xf
-#define PM_LOWER_SH	6
-#define PM_LOWER_MSK	1
-#define PM_LOWER_MSKS	0x40
-#define PM_BYTE_SH	4	/* Byte number of event bus to use */
-#define PM_BYTE_MSK	3
-#define PM_PMCSEL_MSK	7
-
-/*
- * Unit code values
- */
-#define PM_FPU		1
-#define PM_ISU1		2
-#define PM_IFU		3
-#define PM_IDU0		4
-#define PM_ISU1_ALT	6
-#define PM_ISU2		7
-#define PM_IFU_ALT	8
-#define PM_LSU0		9
-#define PM_LSU1		0xc
-#define PM_GPS		0xf
-
-/*
- * Bits in MMCR0 for POWER4
- */
-#define MMCR0_PMC1SEL_SH	8
-#define MMCR0_PMC2SEL_SH	1
-#define MMCR_PMCSEL_MSK		0x1f
-
-/*
- * Bits in MMCR1 for POWER4
- */
-#define MMCR1_TTM0SEL_SH	62
-#define MMCR1_TTC0SEL_SH	61
-#define MMCR1_TTM1SEL_SH	59
-#define MMCR1_TTC1SEL_SH	58
-#define MMCR1_TTM2SEL_SH	56
-#define MMCR1_TTC2SEL_SH	55
-#define MMCR1_TTM3SEL_SH	53
-#define MMCR1_TTC3SEL_SH	52
-#define MMCR1_TTMSEL_MSK	3
-#define MMCR1_TD_CP_DBG0SEL_SH	50
-#define MMCR1_TD_CP_DBG1SEL_SH	48
-#define MMCR1_TD_CP_DBG2SEL_SH	46
-#define MMCR1_TD_CP_DBG3SEL_SH	44
-#define MMCR1_DEBUG0SEL_SH	43
-#define MMCR1_DEBUG1SEL_SH	42
-#define MMCR1_DEBUG2SEL_SH	41
-#define MMCR1_DEBUG3SEL_SH	40
-#define MMCR1_PMC1_ADDER_SEL_SH	39
-#define MMCR1_PMC2_ADDER_SEL_SH	38
-#define MMCR1_PMC6_ADDER_SEL_SH	37
-#define MMCR1_PMC5_ADDER_SEL_SH	36
-#define MMCR1_PMC8_ADDER_SEL_SH	35
-#define MMCR1_PMC7_ADDER_SEL_SH	34
-#define MMCR1_PMC3_ADDER_SEL_SH	33
-#define MMCR1_PMC4_ADDER_SEL_SH	32
-#define MMCR1_PMC3SEL_SH	27
-#define MMCR1_PMC4SEL_SH	22
-#define MMCR1_PMC5SEL_SH	17
-#define MMCR1_PMC6SEL_SH	12
-#define MMCR1_PMC7SEL_SH	7
-#define MMCR1_PMC8SEL_SH	2	/* note bit 0 is in MMCRA for GP */
-
-static short mmcr1_adder_bits[8] = {
-	MMCR1_PMC1_ADDER_SEL_SH,
-	MMCR1_PMC2_ADDER_SEL_SH,
-	MMCR1_PMC3_ADDER_SEL_SH,
-	MMCR1_PMC4_ADDER_SEL_SH,
-	MMCR1_PMC5_ADDER_SEL_SH,
-	MMCR1_PMC6_ADDER_SEL_SH,
-	MMCR1_PMC7_ADDER_SEL_SH,
-	MMCR1_PMC8_ADDER_SEL_SH
-};
-
-/*
- * Bits in MMCRA
- */
-#define MMCRA_PMC8SEL0_SH	17	/* PMC8SEL bit 0 for GP */
-
-/*
- * Layout of constraint bits:
- * 6666555555555544444444443333333333222222222211111111110000000000
- * 3210987654321098765432109876543210987654321098765432109876543210
- *        |[  >[  >[   >|||[  >[  ><  ><  ><  ><  ><><><><><><><><>
- *        | UC1 UC2 UC3 ||| PS1 PS2 B0  B1  B2  B3 P1P2P3P4P5P6P7P8
- * 	  \SMPL	        ||\TTC3SEL
- * 		        |\TTC_IFU_SEL
- * 		        \TTM2SEL0
- *
- * SMPL - SAMPLE_ENABLE constraint
- *     56: SAMPLE_ENABLE value 0x0100_0000_0000_0000
- *
- * UC1 - unit constraint 1: can't have all three of FPU/ISU1/IDU0|ISU2
- *     55: UC1 error 0x0080_0000_0000_0000
- *     54: FPU events needed 0x0040_0000_0000_0000
- *     53: ISU1 events needed 0x0020_0000_0000_0000
- *     52: IDU0|ISU2 events needed 0x0010_0000_0000_0000
- *
- * UC2 - unit constraint 2: can't have all three of FPU/IFU/LSU0
- *     51: UC2 error 0x0008_0000_0000_0000
- *     50: FPU events needed 0x0004_0000_0000_0000
- *     49: IFU events needed 0x0002_0000_0000_0000
- *     48: LSU0 events needed 0x0001_0000_0000_0000
- *
- * UC3 - unit constraint 3: can't have all four of LSU0/IFU/IDU0|ISU2/ISU1
- *     47: UC3 error 0x8000_0000_0000
- *     46: LSU0 events needed 0x4000_0000_0000
- *     45: IFU events needed 0x2000_0000_0000
- *     44: IDU0|ISU2 events needed 0x1000_0000_0000
- *     43: ISU1 events needed 0x0800_0000_0000
- *
- * TTM2SEL0
- *     42: 0 = IDU0 events needed
- *     	   1 = ISU2 events needed 0x0400_0000_0000
- *
- * TTC_IFU_SEL
- *     41: 0 = IFU.U events needed
- *     	   1 = IFU.L events needed 0x0200_0000_0000
- *
- * TTC3SEL
- *     40: 0 = LSU1.U events needed
- *     	   1 = LSU1.L events needed 0x0100_0000_0000
- *
- * PS1
- *     39: PS1 error 0x0080_0000_0000
- *     36-38: count of events needing PMC1/2/5/6 0x0070_0000_0000
- *
- * PS2
- *     35: PS2 error 0x0008_0000_0000
- *     32-34: count of events needing PMC3/4/7/8 0x0007_0000_0000
- *
- * B0
- *     28-31: Byte 0 event source 0xf000_0000
- *     	   1 = FPU
- * 	   2 = ISU1
- * 	   3 = IFU
- * 	   4 = IDU0
- * 	   7 = ISU2
- * 	   9 = LSU0
- * 	   c = LSU1
- * 	   f = GPS
- *
- * B1, B2, B3
- *     24-27, 20-23, 16-19: Byte 1, 2, 3 event sources
- *
- * P8
- *     15: P8 error 0x8000
- *     14-15: Count of events needing PMC8
- *
- * P1..P7
- *     0-13: Count of events needing PMC1..PMC7
- *
- * Note: this doesn't allow events using IFU.U to be combined with events
- * using IFU.L, though that is feasible (using TTM0 and TTM2).  However
- * there are no listed events for IFU.L (they are debug events not
- * verified for performance monitoring) so this shouldn't cause a
- * problem.
- */
-
-static struct unitinfo {
-	unsigned long	value, mask;
-	int		unit;
-	int		lowerbit;
-} p4_unitinfo[16] = {
-	[PM_FPU]  = { 0x44000000000000ul, 0x88000000000000ul, PM_FPU, 0 },
-	[PM_ISU1] = { 0x20080000000000ul, 0x88000000000000ul, PM_ISU1, 0 },
-	[PM_ISU1_ALT] =
-		    { 0x20080000000000ul, 0x88000000000000ul, PM_ISU1, 0 },
-	[PM_IFU]  = { 0x02200000000000ul, 0x08820000000000ul, PM_IFU, 41 },
-	[PM_IFU_ALT] =
-		    { 0x02200000000000ul, 0x08820000000000ul, PM_IFU, 41 },
-	[PM_IDU0] = { 0x10100000000000ul, 0x80840000000000ul, PM_IDU0, 1 },
-	[PM_ISU2] = { 0x10140000000000ul, 0x80840000000000ul, PM_ISU2, 0 },
-	[PM_LSU0] = { 0x01400000000000ul, 0x08800000000000ul, PM_LSU0, 0 },
-	[PM_LSU1] = { 0x00000000000000ul, 0x00010000000000ul, PM_LSU1, 40 },
-	[PM_GPS]  = { 0x00000000000000ul, 0x00000000000000ul, PM_GPS, 0 }
-};
-
-static unsigned char direct_marked_event[8] = {
-	(1<<2) | (1<<3),	/* PMC1: PM_MRK_GRP_DISP, PM_MRK_ST_CMPL */
-	(1<<3) | (1<<5),	/* PMC2: PM_THRESH_TIMEO, PM_MRK_BRU_FIN */
-	(1<<3),			/* PMC3: PM_MRK_ST_CMPL_INT */
-	(1<<4) | (1<<5),	/* PMC4: PM_MRK_GRP_CMPL, PM_MRK_CRU_FIN */
-	(1<<4) | (1<<5),	/* PMC5: PM_MRK_GRP_TIMEO */
-	(1<<3) | (1<<4) | (1<<5),
-		/* PMC6: PM_MRK_ST_GPS, PM_MRK_FXU_FIN, PM_MRK_GRP_ISSUED */
-	(1<<4) | (1<<5),	/* PMC7: PM_MRK_FPU_FIN, PM_MRK_INST_FIN */
-	(1<<4),			/* PMC8: PM_MRK_LSU_FIN */
-};
-
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int p4_marked_instr_event(u64 event)
-{
-	int pmc, psel, unit, byte, bit;
-	unsigned int mask;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = event & PM_PMCSEL_MSK;
-	if (pmc) {
-		if (direct_marked_event[pmc - 1] & (1 << psel))
-			return 1;
-		if (psel == 0)		/* add events */
-			bit = (pmc <= 4)? pmc - 1: 8 - pmc;
-		else if (psel == 6)	/* decode events */
-			bit = 4;
-		else
-			return 0;
-	} else
-		bit = psel;
-
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	mask = 0;
-	switch (unit) {
-	case PM_LSU1:
-		if (event & PM_LOWER_MSKS)
-			mask = 1 << 28;		/* byte 7 bit 4 */
-		else
-			mask = 6 << 24;		/* byte 3 bits 1 and 2 */
-		break;
-	case PM_LSU0:
-		/* byte 3, bit 3; byte 2 bits 0,2,3,4,5; byte 1 */
-		mask = 0x083dff00;
-	}
-	return (mask >> (byte * 8 + bit)) & 1;
-}
-
-static int p4_get_constraint(u64 event, unsigned long *maskp,
-			     unsigned long *valp)
-{
-	int pmc, byte, unit, lower, sh;
-	unsigned long mask = 0, value = 0;
-	int grp = -1;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 8)
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-		grp = ((pmc - 1) >> 1) & 1;
-	}
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	if (unit) {
-		lower = (event >> PM_LOWER_SH) & PM_LOWER_MSK;
-
-		/*
-		 * Bus events on bytes 0 and 2 can be counted
-		 * on PMC1/2/5/6; bytes 1 and 3 on PMC3/4/7/8.
-		 */
-		if (!pmc)
-			grp = byte & 1;
-
-		if (!p4_unitinfo[unit].unit)
-			return -1;
-		mask  |= p4_unitinfo[unit].mask;
-		value |= p4_unitinfo[unit].value;
-		sh = p4_unitinfo[unit].lowerbit;
-		if (sh > 1)
-			value |= (unsigned long)lower << sh;
-		else if (lower != sh)
-			return -1;
-		unit = p4_unitinfo[unit].unit;
-
-		/* Set byte lane select field */
-		mask  |= 0xfULL << (28 - 4 * byte);
-		value |= (unsigned long)unit << (28 - 4 * byte);
-	}
-	if (grp == 0) {
-		/* increment PMC1/2/5/6 field */
-		mask  |= 0x8000000000ull;
-		value |= 0x1000000000ull;
-	} else {
-		/* increment PMC3/4/7/8 field */
-		mask  |= 0x800000000ull;
-		value |= 0x100000000ull;
-	}
-
-	/* Marked instruction events need sample_enable set */
-	if (p4_marked_instr_event(event)) {
-		mask  |= 1ull << 56;
-		value |= 1ull << 56;
-	}
-
-	/* PMCSEL=6 decode events on byte 2 need sample_enable clear */
-	if (pmc && (event & PM_PMCSEL_MSK) == 6 && byte == 2)
-		mask  |= 1ull << 56;
-
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-static unsigned int ppc_inst_cmpl[] = {
-	0x1001, 0x4001, 0x6001, 0x7001, 0x8001
-};
-
-static int p4_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, na;
-
-	alt[0] = event;
-	na = 1;
-
-	/* 2 possibilities for PM_GRP_DISP_REJECT */
-	if (event == 0x8003 || event == 0x0224) {
-		alt[1] = event ^ (0x8003 ^ 0x0224);
-		return 2;
-	}
-
-	/* 2 possibilities for PM_ST_MISS_L1 */
-	if (event == 0x0c13 || event == 0x0c23) {
-		alt[1] = event ^ (0x0c13 ^ 0x0c23);
-		return 2;
-	}
-
-	/* several possibilities for PM_INST_CMPL */
-	for (i = 0; i < ARRAY_SIZE(ppc_inst_cmpl); ++i) {
-		if (event == ppc_inst_cmpl[i]) {
-			for (j = 0; j < ARRAY_SIZE(ppc_inst_cmpl); ++j)
-				if (j != i)
-					alt[na++] = ppc_inst_cmpl[j];
-			break;
-		}
-	}
-
-	return na;
-}
-
-static int p4_compute_mmcr(u64 event[], int n_ev,
-			   unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
-	unsigned int pmc, unit, byte, psel, lower;
-	unsigned int ttm, grp;
-	unsigned int pmc_inuse = 0;
-	unsigned int pmc_grp_use[2];
-	unsigned char busbyte[4];
-	unsigned char unituse[16];
-	unsigned int unitlower = 0;
-	int i;
-
-	if (n_ev > 8)
-		return -1;
-
-	/* First pass to count resource use */
-	pmc_grp_use[0] = pmc_grp_use[1] = 0;
-	memset(busbyte, 0, sizeof(busbyte));
-	memset(unituse, 0, sizeof(unituse));
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;
-			pmc_inuse |= 1 << (pmc - 1);
-			/* count 1/2/5/6 vs 3/4/7/8 use */
-			++pmc_grp_use[((pmc - 1) >> 1) & 1];
-		}
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		lower = (event[i] >> PM_LOWER_SH) & PM_LOWER_MSK;
-		if (unit) {
-			if (!pmc)
-				++pmc_grp_use[byte & 1];
-			if (unit == 6 || unit == 8)
-				/* map alt ISU1/IFU codes: 6->2, 8->3 */
-				unit = (unit >> 1) - 1;
-			if (busbyte[byte] && busbyte[byte] != unit)
-				return -1;
-			busbyte[byte] = unit;
-			lower <<= unit;
-			if (unituse[unit] && lower != (unitlower & lower))
-				return -1;
-			unituse[unit] = 1;
-			unitlower |= lower;
-		}
-	}
-	if (pmc_grp_use[0] > 4 || pmc_grp_use[1] > 4)
-		return -1;
-
-	/*
-	 * Assign resources and set multiplexer selects.
-	 *
-	 * Units 1,2,3 are on TTM0, 4,6,7 on TTM1, 8,10 on TTM2.
-	 * Each TTMx can only select one unit, but since
-	 * units 2 and 6 are both ISU1, and 3 and 8 are both IFU,
-	 * we have some choices.
-	 */
-	if (unituse[2] & (unituse[1] | (unituse[3] & unituse[9]))) {
-		unituse[6] = 1;		/* Move 2 to 6 */
-		unituse[2] = 0;
-	}
-	if (unituse[3] & (unituse[1] | unituse[2])) {
-		unituse[8] = 1;		/* Move 3 to 8 */
-		unituse[3] = 0;
-		unitlower = (unitlower & ~8) | ((unitlower & 8) << 5);
-	}
-	/* Check only one unit per TTMx */
-	if (unituse[1] + unituse[2] + unituse[3] > 1 ||
-	    unituse[4] + unituse[6] + unituse[7] > 1 ||
-	    unituse[8] + unituse[9] > 1 ||
-	    (unituse[5] | unituse[10] | unituse[11] |
-	     unituse[13] | unituse[14]))
-		return -1;
-
-	/* Set TTMxSEL fields.  Note, units 1-3 => TTM0SEL codes 0-2 */
-	mmcr1 |= (unsigned long)(unituse[3] * 2 + unituse[2])
-		<< MMCR1_TTM0SEL_SH;
-	mmcr1 |= (unsigned long)(unituse[7] * 3 + unituse[6] * 2)
-		<< MMCR1_TTM1SEL_SH;
-	mmcr1 |= (unsigned long)unituse[9] << MMCR1_TTM2SEL_SH;
-
-	/* Set TTCxSEL fields. */
-	if (unitlower & 0xe)
-		mmcr1 |= 1ull << MMCR1_TTC0SEL_SH;
-	if (unitlower & 0xf0)
-		mmcr1 |= 1ull << MMCR1_TTC1SEL_SH;
-	if (unitlower & 0xf00)
-		mmcr1 |= 1ull << MMCR1_TTC2SEL_SH;
-	if (unitlower & 0x7000)
-		mmcr1 |= 1ull << MMCR1_TTC3SEL_SH;
-
-	/* Set byte lane select fields. */
-	for (byte = 0; byte < 4; ++byte) {
-		unit = busbyte[byte];
-		if (!unit)
-			continue;
-		if (unit == 0xf) {
-			/* special case for GPS */
-			mmcr1 |= 1ull << (MMCR1_DEBUG0SEL_SH - byte);
-		} else {
-			if (!unituse[unit])
-				ttm = unit - 1;		/* 2->1, 3->2 */
-			else
-				ttm = unit >> 2;
-			mmcr1 |= (unsigned long)ttm
-				<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
-		}
-	}
-
-	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		psel = event[i] & PM_PMCSEL_MSK;
-		if (!pmc) {
-			/* Bus event or 00xxx direct event (off or cycles) */
-			if (unit)
-				psel |= 0x10 | ((byte & 2) << 2);
-			for (pmc = 0; pmc < 8; ++pmc) {
-				if (pmc_inuse & (1 << pmc))
-					continue;
-				grp = (pmc >> 1) & 1;
-				if (unit) {
-					if (grp == (byte & 1))
-						break;
-				} else if (pmc_grp_use[grp] < 4) {
-					++pmc_grp_use[grp];
-					break;
-				}
-			}
-			pmc_inuse |= 1 << pmc;
-		} else {
-			/* Direct event */
-			--pmc;
-			if (psel == 0 && (byte & 2))
-				/* add events on higher-numbered bus */
-				mmcr1 |= 1ull << mmcr1_adder_bits[pmc];
-			else if (psel == 6 && byte == 3)
-				/* seem to need to set sample_enable here */
-				mmcra |= MMCRA_SAMPLE_ENABLE;
-			psel |= 8;
-		}
-		if (pmc <= 1)
-			mmcr0 |= psel << (MMCR0_PMC1SEL_SH - 7 * pmc);
-		else
-			mmcr1 |= psel << (MMCR1_PMC3SEL_SH - 5 * (pmc - 2));
-		if (pmc == 7)	/* PMC8 */
-			mmcra |= (psel & 1) << MMCRA_PMC8SEL0_SH;
-		hwc[i] = pmc;
-		if (p4_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-	}
-
-	if (pmc_inuse & 1)
-		mmcr0 |= MMCR0_PMC1CE;
-	if (pmc_inuse & 0xfe)
-		mmcr0 |= MMCR0_PMCjCE;
-
-	mmcra |= 0x2000;	/* mark only one IOP per PPC instruction */
-
-	/* Return MMCRx values */
-	mmcr[0] = mmcr0;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-static void p4_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	/*
-	 * Setting the PMCxSEL field to 0 disables PMC x.
-	 * (Note that pmc is 0-based here, not 1-based.)
-	 */
-	if (pmc <= 1) {
-		mmcr[0] &= ~(0x1fUL << (MMCR0_PMC1SEL_SH - 7 * pmc));
-	} else {
-		mmcr[1] &= ~(0x1fUL << (MMCR1_PMC3SEL_SH - 5 * (pmc - 2)));
-		if (pmc == 7)
-			mmcr[2] &= ~(1UL << MMCRA_PMC8SEL0_SH);
-	}
-}
-
-static int p4_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 7,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x1001,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x8c10, /* PM_LD_REF_L1 */
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c10, /* PM_LD_MISS_L1 */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x330,  /* PM_BR_ISSUED */
-	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x331,  /* PM_BR_MPRED_CR */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int power4_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x8c10,		0x3c10	},
-		[C(OP_WRITE)] = {	0x7c10,		0xc13	},
-		[C(OP_PREFETCH)] = {	0xc35,		0	},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0xc34,		0	},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x904	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x900	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x330,		0x331	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-};
-
-static struct power_pmu power4_pmu = {
-	.name			= "POWER4/4+",
-	.n_counter		= 8,
-	.max_alternatives	= 5,
-	.add_fields		= 0x0000001100005555ul,
-	.test_adder		= 0x0011083300000000ul,
-	.compute_mmcr		= p4_compute_mmcr,
-	.get_constraint		= p4_get_constraint,
-	.get_alternatives	= p4_get_alternatives,
-	.disable_pmc		= p4_disable_pmc,
-	.n_generic		= ARRAY_SIZE(p4_generic_events),
-	.generic_events		= p4_generic_events,
-	.cache_events		= &power4_cache_events,
-};
-
-static int __init init_power4_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power4"))
-		return -ENODEV;
-
-	return register_power_pmu(&power4_pmu);
-}
-
-early_initcall(init_power4_pmu);
diff --git a/arch/powerpc/kernel/power5+-pmu.c b/arch/powerpc/kernel/power5+-pmu.c
deleted file mode 100644
index a8757ba..0000000
--- a/arch/powerpc/kernel/power5+-pmu.c
+++ /dev/null
@@ -1,690 +0,0 @@
-/*
- * Performance counter support for POWER5+/++ (not POWER5) processors.
- *
- * Copyright 2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/perf_event.h>
-#include <linux/string.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for POWER5+ (POWER5 GS) and POWER5++ (POWER5 GS DD3)
- */
-#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0xf
-#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
-#define PM_UNIT_SH	16	/* TTMMUX number and setting - unit select */
-#define PM_UNIT_MSK	0xf
-#define PM_BYTE_SH	12	/* Byte number of event bus to use */
-#define PM_BYTE_MSK	7
-#define PM_GRS_SH	8	/* Storage subsystem mux select */
-#define PM_GRS_MSK	7
-#define PM_BUSEVENT_MSK	0x80	/* Set if event uses event bus */
-#define PM_PMCSEL_MSK	0x7f
-
-/* Values in PM_UNIT field */
-#define PM_FPU		0
-#define PM_ISU0		1
-#define PM_IFU		2
-#define PM_ISU1		3
-#define PM_IDU		4
-#define PM_ISU0_ALT	6
-#define PM_GRS		7
-#define PM_LSU0		8
-#define PM_LSU1		0xc
-#define PM_LASTUNIT	0xc
-
-/*
- * Bits in MMCR1 for POWER5+
- */
-#define MMCR1_TTM0SEL_SH	62
-#define MMCR1_TTM1SEL_SH	60
-#define MMCR1_TTM2SEL_SH	58
-#define MMCR1_TTM3SEL_SH	56
-#define MMCR1_TTMSEL_MSK	3
-#define MMCR1_TD_CP_DBG0SEL_SH	54
-#define MMCR1_TD_CP_DBG1SEL_SH	52
-#define MMCR1_TD_CP_DBG2SEL_SH	50
-#define MMCR1_TD_CP_DBG3SEL_SH	48
-#define MMCR1_GRS_L2SEL_SH	46
-#define MMCR1_GRS_L2SEL_MSK	3
-#define MMCR1_GRS_L3SEL_SH	44
-#define MMCR1_GRS_L3SEL_MSK	3
-#define MMCR1_GRS_MCSEL_SH	41
-#define MMCR1_GRS_MCSEL_MSK	7
-#define MMCR1_GRS_FABSEL_SH	39
-#define MMCR1_GRS_FABSEL_MSK	3
-#define MMCR1_PMC1_ADDER_SEL_SH	35
-#define MMCR1_PMC2_ADDER_SEL_SH	34
-#define MMCR1_PMC3_ADDER_SEL_SH	33
-#define MMCR1_PMC4_ADDER_SEL_SH	32
-#define MMCR1_PMC1SEL_SH	25
-#define MMCR1_PMC2SEL_SH	17
-#define MMCR1_PMC3SEL_SH	9
-#define MMCR1_PMC4SEL_SH	1
-#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
-#define MMCR1_PMCSEL_MSK	0x7f
-
-/*
- * Layout of constraint bits:
- * 6666555555555544444444443333333333222222222211111111110000000000
- * 3210987654321098765432109876543210987654321098765432109876543210
- *             [  ><><>< ><> <><>[  >  <  ><  ><  ><  ><><><><><><>
- *             NC  G0G1G2 G3 T0T1 UC    B0  B1  B2  B3 P6P5P4P3P2P1
- *
- * NC - number of counters
- *     51: NC error 0x0008_0000_0000_0000
- *     48-50: number of events needing PMC1-4 0x0007_0000_0000_0000
- *
- * G0..G3 - GRS mux constraints
- *     46-47: GRS_L2SEL value
- *     44-45: GRS_L3SEL value
- *     41-44: GRS_MCSEL value
- *     39-40: GRS_FABSEL value
- *	Note that these match up with their bit positions in MMCR1
- *
- * T0 - TTM0 constraint
- *     36-37: TTM0SEL value (0=FPU, 2=IFU, 3=ISU1) 0x30_0000_0000
- *
- * T1 - TTM1 constraint
- *     34-35: TTM1SEL value (0=IDU, 3=GRS) 0x0c_0000_0000
- *
- * UC - unit constraint: can't have all three of FPU|IFU|ISU1, ISU0, IDU|GRS
- *     33: UC3 error 0x02_0000_0000
- *     32: FPU|IFU|ISU1 events needed 0x01_0000_0000
- *     31: ISU0 events needed 0x01_8000_0000
- *     30: IDU|GRS events needed 0x00_4000_0000
- *
- * B0
- *     24-27: Byte 0 event source 0x0f00_0000
- *	      Encoding as for the event code
- *
- * B1, B2, B3
- *     20-23, 16-19, 12-15: Byte 1, 2, 3 event sources
- *
- * P6
- *     11: P6 error 0x800
- *     10-11: Count of events needing PMC6
- *
- * P1..P5
- *     0-9: Count of events needing PMC1..PMC5
- */
-
-static const int grsel_shift[8] = {
-	MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH,
-	MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH,
-	MMCR1_GRS_MCSEL_SH, MMCR1_GRS_FABSEL_SH
-};
-
-/* Masks and values for using events from the various units */
-static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
-	[PM_FPU] =   { 0x3200000000ul, 0x0100000000ul },
-	[PM_ISU0] =  { 0x0200000000ul, 0x0080000000ul },
-	[PM_ISU1] =  { 0x3200000000ul, 0x3100000000ul },
-	[PM_IFU] =   { 0x3200000000ul, 0x2100000000ul },
-	[PM_IDU] =   { 0x0e00000000ul, 0x0040000000ul },
-	[PM_GRS] =   { 0x0e00000000ul, 0x0c40000000ul },
-};
-
-static int power5p_get_constraint(u64 event, unsigned long *maskp,
-				  unsigned long *valp)
-{
-	int pmc, byte, unit, sh;
-	int bit, fmask;
-	unsigned long mask = 0, value = 0;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 6)
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-		if (pmc >= 5 && !(event == 0x500009 || event == 0x600005))
-			return -1;
-	}
-	if (event & PM_BUSEVENT_MSK) {
-		unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-		if (unit > PM_LASTUNIT)
-			return -1;
-		if (unit == PM_ISU0_ALT)
-			unit = PM_ISU0;
-		mask |= unit_cons[unit][0];
-		value |= unit_cons[unit][1];
-		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-		if (byte >= 4) {
-			if (unit != PM_LSU1)
-				return -1;
-			/* Map LSU1 low word (bytes 4-7) to unit LSU1+1 */
-			++unit;
-			byte &= 3;
-		}
-		if (unit == PM_GRS) {
-			bit = event & 7;
-			fmask = (bit == 6)? 7: 3;
-			sh = grsel_shift[bit];
-			mask |= (unsigned long)fmask << sh;
-			value |= (unsigned long)((event >> PM_GRS_SH) & fmask)
-				<< sh;
-		}
-		/* Set byte lane select field */
-		mask  |= 0xfUL << (24 - 4 * byte);
-		value |= (unsigned long)unit << (24 - 4 * byte);
-	}
-	if (pmc < 5) {
-		/* need a counter from PMC1-4 set */
-		mask  |= 0x8000000000000ul;
-		value |= 0x1000000000000ul;
-	}
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-static int power5p_limited_pmc_event(u64 event)
-{
-	int pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-
-	return pmc == 5 || pmc == 6;
-}
-
-#define MAX_ALT	3	/* at most 3 alternatives for any event */
-
-static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x100c0,  0x40001f },			/* PM_GCT_FULL_CYC */
-	{ 0x120e4,  0x400002 },			/* PM_GRP_DISP_REJECT */
-	{ 0x230e2,  0x323087 },			/* PM_BR_PRED_CR */
-	{ 0x230e3,  0x223087, 0x3230a0 },	/* PM_BR_PRED_TA */
-	{ 0x410c7,  0x441084 },			/* PM_THRD_L2MISS_BOTH_CYC */
-	{ 0x800c4,  0xc20e0 },			/* PM_DTLB_MISS */
-	{ 0xc50c6,  0xc60e0 },			/* PM_MRK_DTLB_MISS */
-	{ 0x100005, 0x600005 },			/* PM_RUN_CYC */
-	{ 0x100009, 0x200009 },			/* PM_INST_CMPL */
-	{ 0x200015, 0x300015 },			/* PM_LSU_LMQ_SRQ_EMPTY_CYC */
-	{ 0x300009, 0x400009 },			/* PM_INST_DISP */
-};
-
-/*
- * Scan the alternatives table for a match and return the
- * index into the alternatives table if found, else -1.
- */
-static int find_alternative(unsigned int event)
-{
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			break;
-		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
-			if (event == event_alternatives[i][j])
-				return i;
-	}
-	return -1;
-}
-
-static const unsigned char bytedecode_alternatives[4][4] = {
-	/* PMC 1 */	{ 0x21, 0x23, 0x25, 0x27 },
-	/* PMC 2 */	{ 0x07, 0x17, 0x0e, 0x1e },
-	/* PMC 3 */	{ 0x20, 0x22, 0x24, 0x26 },
-	/* PMC 4 */	{ 0x07, 0x17, 0x0e, 0x1e }
-};
-
-/*
- * Some direct events for decodes of event bus byte 3 have alternative
- * PMCSEL values on other counters.  This returns the alternative
- * event code for those that do, or -1 otherwise.  This also handles
- * alternative PCMSEL values for add events.
- */
-static s64 find_alternative_bdecode(u64 event)
-{
-	int pmc, altpmc, pp, j;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc == 0 || pmc > 4)
-		return -1;
-	altpmc = 5 - pmc;	/* 1 <-> 4, 2 <-> 3 */
-	pp = event & PM_PMCSEL_MSK;
-	for (j = 0; j < 4; ++j) {
-		if (bytedecode_alternatives[pmc - 1][j] == pp) {
-			return (event & ~(PM_PMC_MSKS | PM_PMCSEL_MSK)) |
-				(altpmc << PM_PMC_SH) |
-				bytedecode_alternatives[altpmc - 1][j];
-		}
-	}
-
-	/* new decode alternatives for power5+ */
-	if (pmc == 1 && (pp == 0x0d || pp == 0x0e))
-		return event + (2 << PM_PMC_SH) + (0x2e - 0x0d);
-	if (pmc == 3 && (pp == 0x2e || pp == 0x2f))
-		return event - (2 << PM_PMC_SH) - (0x2e - 0x0d);
-
-	/* alternative add event encodings */
-	if (pp == 0x10 || pp == 0x28)
-		return ((event ^ (0x10 ^ 0x28)) & ~PM_PMC_MSKS) |
-			(altpmc << PM_PMC_SH);
-
-	return -1;
-}
-
-static int power5p_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, nalt = 1;
-	int nlim;
-	s64 ae;
-
-	alt[0] = event;
-	nalt = 1;
-	nlim = power5p_limited_pmc_event(event);
-	i = find_alternative(event);
-	if (i >= 0) {
-		for (j = 0; j < MAX_ALT; ++j) {
-			ae = event_alternatives[i][j];
-			if (ae && ae != event)
-				alt[nalt++] = ae;
-			nlim += power5p_limited_pmc_event(ae);
-		}
-	} else {
-		ae = find_alternative_bdecode(event);
-		if (ae > 0)
-			alt[nalt++] = ae;
-	}
-
-	if (flags & PPMU_ONLY_COUNT_RUN) {
-		/*
-		 * We're only counting in RUN state,
-		 * so PM_CYC is equivalent to PM_RUN_CYC
-		 * and PM_INST_CMPL === PM_RUN_INST_CMPL.
-		 * This doesn't include alternatives that don't provide
-		 * any extra flexibility in assigning PMCs (e.g.
-		 * 0x100005 for PM_RUN_CYC vs. 0xf for PM_CYC).
-		 * Note that even with these additional alternatives
-		 * we never end up with more than 3 alternatives for any event.
-		 */
-		j = nalt;
-		for (i = 0; i < nalt; ++i) {
-			switch (alt[i]) {
-			case 0xf:	/* PM_CYC */
-				alt[j++] = 0x600005;	/* PM_RUN_CYC */
-				++nlim;
-				break;
-			case 0x600005:	/* PM_RUN_CYC */
-				alt[j++] = 0xf;
-				break;
-			case 0x100009:	/* PM_INST_CMPL */
-				alt[j++] = 0x500009;	/* PM_RUN_INST_CMPL */
-				++nlim;
-				break;
-			case 0x500009:	/* PM_RUN_INST_CMPL */
-				alt[j++] = 0x100009;	/* PM_INST_CMPL */
-				alt[j++] = 0x200009;
-				break;
-			}
-		}
-		nalt = j;
-	}
-
-	if (!(flags & PPMU_LIMITED_PMC_OK) && nlim) {
-		/* remove the limited PMC events */
-		j = 0;
-		for (i = 0; i < nalt; ++i) {
-			if (!power5p_limited_pmc_event(alt[i])) {
-				alt[j] = alt[i];
-				++j;
-			}
-		}
-		nalt = j;
-	} else if ((flags & PPMU_LIMITED_PMC_REQD) && nlim < nalt) {
-		/* remove all but the limited PMC events */
-		j = 0;
-		for (i = 0; i < nalt; ++i) {
-			if (power5p_limited_pmc_event(alt[i])) {
-				alt[j] = alt[i];
-				++j;
-			}
-		}
-		nalt = j;
-	}
-
-	return nalt;
-}
-
-/*
- * Map of which direct events on which PMCs are marked instruction events.
- * Indexed by PMCSEL value, bit i (LE) set if PMC i is a marked event.
- * Bit 0 is set if it is marked for all PMCs.
- * The 0x80 bit indicates a byte decode PMCSEL value.
- */
-static unsigned char direct_event_is_marked[0x28] = {
-	0,	/* 00 */
-	0x1f,	/* 01 PM_IOPS_CMPL */
-	0x2,	/* 02 PM_MRK_GRP_DISP */
-	0xe,	/* 03 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
-	0,	/* 04 */
-	0x1c,	/* 05 PM_MRK_BRU_FIN, PM_MRK_INST_FIN, PM_MRK_CRU_FIN */
-	0x80,	/* 06 */
-	0x80,	/* 07 */
-	0, 0, 0,/* 08 - 0a */
-	0x18,	/* 0b PM_THRESH_TIMEO, PM_MRK_GRP_TIMEO */
-	0,	/* 0c */
-	0x80,	/* 0d */
-	0x80,	/* 0e */
-	0,	/* 0f */
-	0,	/* 10 */
-	0x14,	/* 11 PM_MRK_GRP_BR_REDIR, PM_MRK_GRP_IC_MISS */
-	0,	/* 12 */
-	0x10,	/* 13 PM_MRK_GRP_CMPL */
-	0x1f,	/* 14 PM_GRP_MRK, PM_MRK_{FXU,FPU,LSU}_FIN */
-	0x2,	/* 15 PM_MRK_GRP_ISSUED */
-	0x80,	/* 16 */
-	0x80,	/* 17 */
-	0, 0, 0, 0, 0,
-	0x80,	/* 1d */
-	0x80,	/* 1e */
-	0,	/* 1f */
-	0x80,	/* 20 */
-	0x80,	/* 21 */
-	0x80,	/* 22 */
-	0x80,	/* 23 */
-	0x80,	/* 24 */
-	0x80,	/* 25 */
-	0x80,	/* 26 */
-	0x80,	/* 27 */
-};
-
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int power5p_marked_instr_event(u64 event)
-{
-	int pmc, psel;
-	int bit, byte, unit;
-	u32 mask;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = event & PM_PMCSEL_MSK;
-	if (pmc >= 5)
-		return 0;
-
-	bit = -1;
-	if (psel < sizeof(direct_event_is_marked)) {
-		if (direct_event_is_marked[psel] & (1 << pmc))
-			return 1;
-		if (direct_event_is_marked[psel] & 0x80)
-			bit = 4;
-		else if (psel == 0x08)
-			bit = pmc - 1;
-		else if (psel == 0x10)
-			bit = 4 - pmc;
-		else if (psel == 0x1b && (pmc == 1 || pmc == 3))
-			bit = 4;
-	} else if ((psel & 0x48) == 0x40) {
-		bit = psel & 7;
-	} else if (psel == 0x28) {
-		bit = pmc - 1;
-	} else if (pmc == 3 && (psel == 0x2e || psel == 0x2f)) {
-		bit = 4;
-	}
-
-	if (!(event & PM_BUSEVENT_MSK) || bit == -1)
-		return 0;
-
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	if (unit == PM_LSU0) {
-		/* byte 1 bits 0-7, byte 2 bits 0,2-4,6 */
-		mask = 0x5dff00;
-	} else if (unit == PM_LSU1 && byte >= 4) {
-		byte -= 4;
-		/* byte 5 bits 6-7, byte 6 bits 0,4, byte 7 bits 0-4,6 */
-		mask = 0x5f11c000;
-	} else
-		return 0;
-
-	return (mask >> (byte * 8 + bit)) & 1;
-}
-
-static int power5p_compute_mmcr(u64 event[], int n_ev,
-				unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
-	unsigned int pmc, unit, byte, psel;
-	unsigned int ttm;
-	int i, isbus, bit, grsel;
-	unsigned int pmc_inuse = 0;
-	unsigned char busbyte[4];
-	unsigned char unituse[16];
-	int ttmuse;
-
-	if (n_ev > 6)
-		return -1;
-
-	/* First pass to count resource use */
-	memset(busbyte, 0, sizeof(busbyte));
-	memset(unituse, 0, sizeof(unituse));
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc > 6)
-				return -1;
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;
-			pmc_inuse |= 1 << (pmc - 1);
-		}
-		if (event[i] & PM_BUSEVENT_MSK) {
-			unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-			byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-			if (unit > PM_LASTUNIT)
-				return -1;
-			if (unit == PM_ISU0_ALT)
-				unit = PM_ISU0;
-			if (byte >= 4) {
-				if (unit != PM_LSU1)
-					return -1;
-				++unit;
-				byte &= 3;
-			}
-			if (busbyte[byte] && busbyte[byte] != unit)
-				return -1;
-			busbyte[byte] = unit;
-			unituse[unit] = 1;
-		}
-	}
-
-	/*
-	 * Assign resources and set multiplexer selects.
-	 *
-	 * PM_ISU0 can go either on TTM0 or TTM1, but that's the only
-	 * choice we have to deal with.
-	 */
-	if (unituse[PM_ISU0] &
-	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_ISU1])) {
-		unituse[PM_ISU0_ALT] = 1;	/* move ISU to TTM1 */
-		unituse[PM_ISU0] = 0;
-	}
-	/* Set TTM[01]SEL fields. */
-	ttmuse = 0;
-	for (i = PM_FPU; i <= PM_ISU1; ++i) {
-		if (!unituse[i])
-			continue;
-		if (ttmuse++)
-			return -1;
-		mmcr1 |= (unsigned long)i << MMCR1_TTM0SEL_SH;
-	}
-	ttmuse = 0;
-	for (; i <= PM_GRS; ++i) {
-		if (!unituse[i])
-			continue;
-		if (ttmuse++)
-			return -1;
-		mmcr1 |= (unsigned long)(i & 3) << MMCR1_TTM1SEL_SH;
-	}
-	if (ttmuse > 1)
-		return -1;
-
-	/* Set byte lane select fields, TTM[23]SEL and GRS_*SEL. */
-	for (byte = 0; byte < 4; ++byte) {
-		unit = busbyte[byte];
-		if (!unit)
-			continue;
-		if (unit == PM_ISU0 && unituse[PM_ISU0_ALT]) {
-			/* get ISU0 through TTM1 rather than TTM0 */
-			unit = PM_ISU0_ALT;
-		} else if (unit == PM_LSU1 + 1) {
-			/* select lower word of LSU1 for this byte */
-			mmcr1 |= 1ul << (MMCR1_TTM3SEL_SH + 3 - byte);
-		}
-		ttm = unit >> 2;
-		mmcr1 |= (unsigned long)ttm
-			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
-	}
-
-	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		psel = event[i] & PM_PMCSEL_MSK;
-		isbus = event[i] & PM_BUSEVENT_MSK;
-		if (!pmc) {
-			/* Bus event or any-PMC direct event */
-			for (pmc = 0; pmc < 4; ++pmc) {
-				if (!(pmc_inuse & (1 << pmc)))
-					break;
-			}
-			if (pmc >= 4)
-				return -1;
-			pmc_inuse |= 1 << pmc;
-		} else if (pmc <= 4) {
-			/* Direct event */
-			--pmc;
-			if (isbus && (byte & 2) &&
-			    (psel == 8 || psel == 0x10 || psel == 0x28))
-				/* add events on higher-numbered bus */
-				mmcr1 |= 1ul << (MMCR1_PMC1_ADDER_SEL_SH - pmc);
-		} else {
-			/* Instructions or run cycles on PMC5/6 */
-			--pmc;
-		}
-		if (isbus && unit == PM_GRS) {
-			bit = psel & 7;
-			grsel = (event[i] >> PM_GRS_SH) & PM_GRS_MSK;
-			mmcr1 |= (unsigned long)grsel << grsel_shift[bit];
-		}
-		if (power5p_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-		if ((psel & 0x58) == 0x40 && (byte & 1) != ((pmc >> 1) & 1))
-			/* select alternate byte lane */
-			psel |= 0x10;
-		if (pmc <= 3)
-			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
-		hwc[i] = pmc;
-	}
-
-	/* Return MMCRx values */
-	mmcr[0] = 0;
-	if (pmc_inuse & 1)
-		mmcr[0] = MMCR0_PMC1CE;
-	if (pmc_inuse & 0x3e)
-		mmcr[0] |= MMCR0_PMCjCE;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-static void power5p_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	if (pmc <= 3)
-		mmcr[1] &= ~(0x7fUL << MMCR1_PMCSEL_SH(pmc));
-}
-
-static int power5p_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 0xf,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x100009,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x1c10a8, /* LD_REF_L1 */
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c1088, /* LD_MISS_L1 */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x230e4,  /* BR_ISSUED */
-	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x230e5,  /* BR_MPRED_CR */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int power5p_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x1c10a8,	0x3c1088	},
-		[C(OP_WRITE)] = {	0x2c10a8,	0xc10c3		},
-		[C(OP_PREFETCH)] = {	0xc70e7,	-1		},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	0,		0		},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0		},
-		[C(OP_WRITE)] = {	0,		0		},
-		[C(OP_PREFETCH)] = {	0xc50c3,	0		},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0xc20e4,	0x800c4		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x800c0		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x230e4,	0x230e5		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-};
-
-static struct power_pmu power5p_pmu = {
-	.name			= "POWER5+/++",
-	.n_counter		= 6,
-	.max_alternatives	= MAX_ALT,
-	.add_fields		= 0x7000000000055ul,
-	.test_adder		= 0x3000040000000ul,
-	.compute_mmcr		= power5p_compute_mmcr,
-	.get_constraint		= power5p_get_constraint,
-	.get_alternatives	= power5p_get_alternatives,
-	.disable_pmc		= power5p_disable_pmc,
-	.limited_pmc_event	= power5p_limited_pmc_event,
-	.flags			= PPMU_LIMITED_PMC5_6,
-	.n_generic		= ARRAY_SIZE(power5p_generic_events),
-	.generic_events		= power5p_generic_events,
-	.cache_events		= &power5p_cache_events,
-};
-
-static int __init init_power5p_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
-		return -ENODEV;
-
-	return register_power_pmu(&power5p_pmu);
-}
-
-early_initcall(init_power5p_pmu);
diff --git a/arch/powerpc/kernel/power5-pmu.c b/arch/powerpc/kernel/power5-pmu.c
deleted file mode 100644
index e7f06eb..0000000
--- a/arch/powerpc/kernel/power5-pmu.c
+++ /dev/null
@@ -1,629 +0,0 @@
-/*
- * Performance counter support for POWER5 (not POWER5++) processors.
- *
- * Copyright 2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/perf_event.h>
-#include <linux/string.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for POWER5 (not POWER5++)
- */
-#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0xf
-#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
-#define PM_UNIT_SH	16	/* TTMMUX number and setting - unit select */
-#define PM_UNIT_MSK	0xf
-#define PM_BYTE_SH	12	/* Byte number of event bus to use */
-#define PM_BYTE_MSK	7
-#define PM_GRS_SH	8	/* Storage subsystem mux select */
-#define PM_GRS_MSK	7
-#define PM_BUSEVENT_MSK	0x80	/* Set if event uses event bus */
-#define PM_PMCSEL_MSK	0x7f
-
-/* Values in PM_UNIT field */
-#define PM_FPU		0
-#define PM_ISU0		1
-#define PM_IFU		2
-#define PM_ISU1		3
-#define PM_IDU		4
-#define PM_ISU0_ALT	6
-#define PM_GRS		7
-#define PM_LSU0		8
-#define PM_LSU1		0xc
-#define PM_LASTUNIT	0xc
-
-/*
- * Bits in MMCR1 for POWER5
- */
-#define MMCR1_TTM0SEL_SH	62
-#define MMCR1_TTM1SEL_SH	60
-#define MMCR1_TTM2SEL_SH	58
-#define MMCR1_TTM3SEL_SH	56
-#define MMCR1_TTMSEL_MSK	3
-#define MMCR1_TD_CP_DBG0SEL_SH	54
-#define MMCR1_TD_CP_DBG1SEL_SH	52
-#define MMCR1_TD_CP_DBG2SEL_SH	50
-#define MMCR1_TD_CP_DBG3SEL_SH	48
-#define MMCR1_GRS_L2SEL_SH	46
-#define MMCR1_GRS_L2SEL_MSK	3
-#define MMCR1_GRS_L3SEL_SH	44
-#define MMCR1_GRS_L3SEL_MSK	3
-#define MMCR1_GRS_MCSEL_SH	41
-#define MMCR1_GRS_MCSEL_MSK	7
-#define MMCR1_GRS_FABSEL_SH	39
-#define MMCR1_GRS_FABSEL_MSK	3
-#define MMCR1_PMC1_ADDER_SEL_SH	35
-#define MMCR1_PMC2_ADDER_SEL_SH	34
-#define MMCR1_PMC3_ADDER_SEL_SH	33
-#define MMCR1_PMC4_ADDER_SEL_SH	32
-#define MMCR1_PMC1SEL_SH	25
-#define MMCR1_PMC2SEL_SH	17
-#define MMCR1_PMC3SEL_SH	9
-#define MMCR1_PMC4SEL_SH	1
-#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
-#define MMCR1_PMCSEL_MSK	0x7f
-
-/*
- * Layout of constraint bits:
- * 6666555555555544444444443333333333222222222211111111110000000000
- * 3210987654321098765432109876543210987654321098765432109876543210
- *         <><>[  ><><>< ><> [  >[ >[ ><  ><  ><  ><  ><><><><><><>
- *         T0T1 NC G0G1G2 G3  UC PS1PS2 B0  B1  B2  B3 P6P5P4P3P2P1
- *
- * T0 - TTM0 constraint
- *     54-55: TTM0SEL value (0=FPU, 2=IFU, 3=ISU1) 0xc0_0000_0000_0000
- *
- * T1 - TTM1 constraint
- *     52-53: TTM1SEL value (0=IDU, 3=GRS) 0x30_0000_0000_0000
- *
- * NC - number of counters
- *     51: NC error 0x0008_0000_0000_0000
- *     48-50: number of events needing PMC1-4 0x0007_0000_0000_0000
- *
- * G0..G3 - GRS mux constraints
- *     46-47: GRS_L2SEL value
- *     44-45: GRS_L3SEL value
- *     41-44: GRS_MCSEL value
- *     39-40: GRS_FABSEL value
- *	Note that these match up with their bit positions in MMCR1
- *
- * UC - unit constraint: can't have all three of FPU|IFU|ISU1, ISU0, IDU|GRS
- *     37: UC3 error 0x20_0000_0000
- *     36: FPU|IFU|ISU1 events needed 0x10_0000_0000
- *     35: ISU0 events needed 0x08_0000_0000
- *     34: IDU|GRS events needed 0x04_0000_0000
- *
- * PS1
- *     33: PS1 error 0x2_0000_0000
- *     31-32: count of events needing PMC1/2 0x1_8000_0000
- *
- * PS2
- *     30: PS2 error 0x4000_0000
- *     28-29: count of events needing PMC3/4 0x3000_0000
- *
- * B0
- *     24-27: Byte 0 event source 0x0f00_0000
- *	      Encoding as for the event code
- *
- * B1, B2, B3
- *     20-23, 16-19, 12-15: Byte 1, 2, 3 event sources
- *
- * P1..P6
- *     0-11: Count of events needing PMC1..PMC6
- */
-
-static const int grsel_shift[8] = {
-	MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH,
-	MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH,
-	MMCR1_GRS_MCSEL_SH, MMCR1_GRS_FABSEL_SH
-};
-
-/* Masks and values for using events from the various units */
-static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
-	[PM_FPU] =   { 0xc0002000000000ul, 0x00001000000000ul },
-	[PM_ISU0] =  { 0x00002000000000ul, 0x00000800000000ul },
-	[PM_ISU1] =  { 0xc0002000000000ul, 0xc0001000000000ul },
-	[PM_IFU] =   { 0xc0002000000000ul, 0x80001000000000ul },
-	[PM_IDU] =   { 0x30002000000000ul, 0x00000400000000ul },
-	[PM_GRS] =   { 0x30002000000000ul, 0x30000400000000ul },
-};
-
-static int power5_get_constraint(u64 event, unsigned long *maskp,
-				 unsigned long *valp)
-{
-	int pmc, byte, unit, sh;
-	int bit, fmask;
-	unsigned long mask = 0, value = 0;
-	int grp = -1;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 6)
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-		if (pmc <= 4)
-			grp = (pmc - 1) >> 1;
-		else if (event != 0x500009 && event != 0x600005)
-			return -1;
-	}
-	if (event & PM_BUSEVENT_MSK) {
-		unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-		if (unit > PM_LASTUNIT)
-			return -1;
-		if (unit == PM_ISU0_ALT)
-			unit = PM_ISU0;
-		mask |= unit_cons[unit][0];
-		value |= unit_cons[unit][1];
-		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-		if (byte >= 4) {
-			if (unit != PM_LSU1)
-				return -1;
-			/* Map LSU1 low word (bytes 4-7) to unit LSU1+1 */
-			++unit;
-			byte &= 3;
-		}
-		if (unit == PM_GRS) {
-			bit = event & 7;
-			fmask = (bit == 6)? 7: 3;
-			sh = grsel_shift[bit];
-			mask |= (unsigned long)fmask << sh;
-			value |= (unsigned long)((event >> PM_GRS_SH) & fmask)
-				<< sh;
-		}
-		/*
-		 * Bus events on bytes 0 and 2 can be counted
-		 * on PMC1/2; bytes 1 and 3 on PMC3/4.
-		 */
-		if (!pmc)
-			grp = byte & 1;
-		/* Set byte lane select field */
-		mask  |= 0xfUL << (24 - 4 * byte);
-		value |= (unsigned long)unit << (24 - 4 * byte);
-	}
-	if (grp == 0) {
-		/* increment PMC1/2 field */
-		mask  |= 0x200000000ul;
-		value |= 0x080000000ul;
-	} else if (grp == 1) {
-		/* increment PMC3/4 field */
-		mask  |= 0x40000000ul;
-		value |= 0x10000000ul;
-	}
-	if (pmc < 5) {
-		/* need a counter from PMC1-4 set */
-		mask  |= 0x8000000000000ul;
-		value |= 0x1000000000000ul;
-	}
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-#define MAX_ALT	3	/* at most 3 alternatives for any event */
-
-static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x120e4,  0x400002 },			/* PM_GRP_DISP_REJECT */
-	{ 0x410c7,  0x441084 },			/* PM_THRD_L2MISS_BOTH_CYC */
-	{ 0x100005, 0x600005 },			/* PM_RUN_CYC */
-	{ 0x100009, 0x200009, 0x500009 },	/* PM_INST_CMPL */
-	{ 0x300009, 0x400009 },			/* PM_INST_DISP */
-};
-
-/*
- * Scan the alternatives table for a match and return the
- * index into the alternatives table if found, else -1.
- */
-static int find_alternative(u64 event)
-{
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			break;
-		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
-			if (event == event_alternatives[i][j])
-				return i;
-	}
-	return -1;
-}
-
-static const unsigned char bytedecode_alternatives[4][4] = {
-	/* PMC 1 */	{ 0x21, 0x23, 0x25, 0x27 },
-	/* PMC 2 */	{ 0x07, 0x17, 0x0e, 0x1e },
-	/* PMC 3 */	{ 0x20, 0x22, 0x24, 0x26 },
-	/* PMC 4 */	{ 0x07, 0x17, 0x0e, 0x1e }
-};
-
-/*
- * Some direct events for decodes of event bus byte 3 have alternative
- * PMCSEL values on other counters.  This returns the alternative
- * event code for those that do, or -1 otherwise.
- */
-static s64 find_alternative_bdecode(u64 event)
-{
-	int pmc, altpmc, pp, j;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc == 0 || pmc > 4)
-		return -1;
-	altpmc = 5 - pmc;	/* 1 <-> 4, 2 <-> 3 */
-	pp = event & PM_PMCSEL_MSK;
-	for (j = 0; j < 4; ++j) {
-		if (bytedecode_alternatives[pmc - 1][j] == pp) {
-			return (event & ~(PM_PMC_MSKS | PM_PMCSEL_MSK)) |
-				(altpmc << PM_PMC_SH) |
-				bytedecode_alternatives[altpmc - 1][j];
-		}
-	}
-	return -1;
-}
-
-static int power5_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, nalt = 1;
-	s64 ae;
-
-	alt[0] = event;
-	nalt = 1;
-	i = find_alternative(event);
-	if (i >= 0) {
-		for (j = 0; j < MAX_ALT; ++j) {
-			ae = event_alternatives[i][j];
-			if (ae && ae != event)
-				alt[nalt++] = ae;
-		}
-	} else {
-		ae = find_alternative_bdecode(event);
-		if (ae > 0)
-			alt[nalt++] = ae;
-	}
-	return nalt;
-}
-
-/*
- * Map of which direct events on which PMCs are marked instruction events.
- * Indexed by PMCSEL value, bit i (LE) set if PMC i is a marked event.
- * Bit 0 is set if it is marked for all PMCs.
- * The 0x80 bit indicates a byte decode PMCSEL value.
- */
-static unsigned char direct_event_is_marked[0x28] = {
-	0,	/* 00 */
-	0x1f,	/* 01 PM_IOPS_CMPL */
-	0x2,	/* 02 PM_MRK_GRP_DISP */
-	0xe,	/* 03 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
-	0,	/* 04 */
-	0x1c,	/* 05 PM_MRK_BRU_FIN, PM_MRK_INST_FIN, PM_MRK_CRU_FIN */
-	0x80,	/* 06 */
-	0x80,	/* 07 */
-	0, 0, 0,/* 08 - 0a */
-	0x18,	/* 0b PM_THRESH_TIMEO, PM_MRK_GRP_TIMEO */
-	0,	/* 0c */
-	0x80,	/* 0d */
-	0x80,	/* 0e */
-	0,	/* 0f */
-	0,	/* 10 */
-	0x14,	/* 11 PM_MRK_GRP_BR_REDIR, PM_MRK_GRP_IC_MISS */
-	0,	/* 12 */
-	0x10,	/* 13 PM_MRK_GRP_CMPL */
-	0x1f,	/* 14 PM_GRP_MRK, PM_MRK_{FXU,FPU,LSU}_FIN */
-	0x2,	/* 15 PM_MRK_GRP_ISSUED */
-	0x80,	/* 16 */
-	0x80,	/* 17 */
-	0, 0, 0, 0, 0,
-	0x80,	/* 1d */
-	0x80,	/* 1e */
-	0,	/* 1f */
-	0x80,	/* 20 */
-	0x80,	/* 21 */
-	0x80,	/* 22 */
-	0x80,	/* 23 */
-	0x80,	/* 24 */
-	0x80,	/* 25 */
-	0x80,	/* 26 */
-	0x80,	/* 27 */
-};
-
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int power5_marked_instr_event(u64 event)
-{
-	int pmc, psel;
-	int bit, byte, unit;
-	u32 mask;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = event & PM_PMCSEL_MSK;
-	if (pmc >= 5)
-		return 0;
-
-	bit = -1;
-	if (psel < sizeof(direct_event_is_marked)) {
-		if (direct_event_is_marked[psel] & (1 << pmc))
-			return 1;
-		if (direct_event_is_marked[psel] & 0x80)
-			bit = 4;
-		else if (psel == 0x08)
-			bit = pmc - 1;
-		else if (psel == 0x10)
-			bit = 4 - pmc;
-		else if (psel == 0x1b && (pmc == 1 || pmc == 3))
-			bit = 4;
-	} else if ((psel & 0x58) == 0x40)
-		bit = psel & 7;
-
-	if (!(event & PM_BUSEVENT_MSK))
-		return 0;
-
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	if (unit == PM_LSU0) {
-		/* byte 1 bits 0-7, byte 2 bits 0,2-4,6 */
-		mask = 0x5dff00;
-	} else if (unit == PM_LSU1 && byte >= 4) {
-		byte -= 4;
-		/* byte 4 bits 1,3,5,7, byte 5 bits 6-7, byte 7 bits 0-4,6 */
-		mask = 0x5f00c0aa;
-	} else
-		return 0;
-
-	return (mask >> (byte * 8 + bit)) & 1;
-}
-
-static int power5_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr1 = 0;
-	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
-	unsigned int pmc, unit, byte, psel;
-	unsigned int ttm, grp;
-	int i, isbus, bit, grsel;
-	unsigned int pmc_inuse = 0;
-	unsigned int pmc_grp_use[2];
-	unsigned char busbyte[4];
-	unsigned char unituse[16];
-	int ttmuse;
-
-	if (n_ev > 6)
-		return -1;
-
-	/* First pass to count resource use */
-	pmc_grp_use[0] = pmc_grp_use[1] = 0;
-	memset(busbyte, 0, sizeof(busbyte));
-	memset(unituse, 0, sizeof(unituse));
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc > 6)
-				return -1;
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;
-			pmc_inuse |= 1 << (pmc - 1);
-			/* count 1/2 vs 3/4 use */
-			if (pmc <= 4)
-				++pmc_grp_use[(pmc - 1) >> 1];
-		}
-		if (event[i] & PM_BUSEVENT_MSK) {
-			unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-			byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-			if (unit > PM_LASTUNIT)
-				return -1;
-			if (unit == PM_ISU0_ALT)
-				unit = PM_ISU0;
-			if (byte >= 4) {
-				if (unit != PM_LSU1)
-					return -1;
-				++unit;
-				byte &= 3;
-			}
-			if (!pmc)
-				++pmc_grp_use[byte & 1];
-			if (busbyte[byte] && busbyte[byte] != unit)
-				return -1;
-			busbyte[byte] = unit;
-			unituse[unit] = 1;
-		}
-	}
-	if (pmc_grp_use[0] > 2 || pmc_grp_use[1] > 2)
-		return -1;
-
-	/*
-	 * Assign resources and set multiplexer selects.
-	 *
-	 * PM_ISU0 can go either on TTM0 or TTM1, but that's the only
-	 * choice we have to deal with.
-	 */
-	if (unituse[PM_ISU0] &
-	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_ISU1])) {
-		unituse[PM_ISU0_ALT] = 1;	/* move ISU to TTM1 */
-		unituse[PM_ISU0] = 0;
-	}
-	/* Set TTM[01]SEL fields. */
-	ttmuse = 0;
-	for (i = PM_FPU; i <= PM_ISU1; ++i) {
-		if (!unituse[i])
-			continue;
-		if (ttmuse++)
-			return -1;
-		mmcr1 |= (unsigned long)i << MMCR1_TTM0SEL_SH;
-	}
-	ttmuse = 0;
-	for (; i <= PM_GRS; ++i) {
-		if (!unituse[i])
-			continue;
-		if (ttmuse++)
-			return -1;
-		mmcr1 |= (unsigned long)(i & 3) << MMCR1_TTM1SEL_SH;
-	}
-	if (ttmuse > 1)
-		return -1;
-
-	/* Set byte lane select fields, TTM[23]SEL and GRS_*SEL. */
-	for (byte = 0; byte < 4; ++byte) {
-		unit = busbyte[byte];
-		if (!unit)
-			continue;
-		if (unit == PM_ISU0 && unituse[PM_ISU0_ALT]) {
-			/* get ISU0 through TTM1 rather than TTM0 */
-			unit = PM_ISU0_ALT;
-		} else if (unit == PM_LSU1 + 1) {
-			/* select lower word of LSU1 for this byte */
-			mmcr1 |= 1ul << (MMCR1_TTM3SEL_SH + 3 - byte);
-		}
-		ttm = unit >> 2;
-		mmcr1 |= (unsigned long)ttm
-			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
-	}
-
-	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		psel = event[i] & PM_PMCSEL_MSK;
-		isbus = event[i] & PM_BUSEVENT_MSK;
-		if (!pmc) {
-			/* Bus event or any-PMC direct event */
-			for (pmc = 0; pmc < 4; ++pmc) {
-				if (pmc_inuse & (1 << pmc))
-					continue;
-				grp = (pmc >> 1) & 1;
-				if (isbus) {
-					if (grp == (byte & 1))
-						break;
-				} else if (pmc_grp_use[grp] < 2) {
-					++pmc_grp_use[grp];
-					break;
-				}
-			}
-			pmc_inuse |= 1 << pmc;
-		} else if (pmc <= 4) {
-			/* Direct event */
-			--pmc;
-			if ((psel == 8 || psel == 0x10) && isbus && (byte & 2))
-				/* add events on higher-numbered bus */
-				mmcr1 |= 1ul << (MMCR1_PMC1_ADDER_SEL_SH - pmc);
-		} else {
-			/* Instructions or run cycles on PMC5/6 */
-			--pmc;
-		}
-		if (isbus && unit == PM_GRS) {
-			bit = psel & 7;
-			grsel = (event[i] >> PM_GRS_SH) & PM_GRS_MSK;
-			mmcr1 |= (unsigned long)grsel << grsel_shift[bit];
-		}
-		if (power5_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-		if (pmc <= 3)
-			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
-		hwc[i] = pmc;
-	}
-
-	/* Return MMCRx values */
-	mmcr[0] = 0;
-	if (pmc_inuse & 1)
-		mmcr[0] = MMCR0_PMC1CE;
-	if (pmc_inuse & 0x3e)
-		mmcr[0] |= MMCR0_PMCjCE;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-static void power5_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	if (pmc <= 3)
-		mmcr[1] &= ~(0x7fUL << MMCR1_PMCSEL_SH(pmc));
-}
-
-static int power5_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 0xf,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x100009,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x4c1090, /* LD_REF_L1 */
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c1088, /* LD_MISS_L1 */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x230e4,  /* BR_ISSUED */
-	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x230e5,  /* BR_MPRED_CR */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int power5_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x4c1090,	0x3c1088	},
-		[C(OP_WRITE)] = {	0x3c1090,	0xc10c3		},
-		[C(OP_PREFETCH)] = {	0xc70e7,	0		},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	0,		0		},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x3c309b	},
-		[C(OP_WRITE)] = {	0,		0		},
-		[C(OP_PREFETCH)] = {	0xc50c3,	0		},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x2c4090,	0x800c4		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x800c0		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x230e4,	0x230e5		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-};
-
-static struct power_pmu power5_pmu = {
-	.name			= "POWER5",
-	.n_counter		= 6,
-	.max_alternatives	= MAX_ALT,
-	.add_fields		= 0x7000090000555ul,
-	.test_adder		= 0x3000490000000ul,
-	.compute_mmcr		= power5_compute_mmcr,
-	.get_constraint		= power5_get_constraint,
-	.get_alternatives	= power5_get_alternatives,
-	.disable_pmc		= power5_disable_pmc,
-	.n_generic		= ARRAY_SIZE(power5_generic_events),
-	.generic_events		= power5_generic_events,
-	.cache_events		= &power5_cache_events,
-};
-
-static int __init init_power5_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
-		return -ENODEV;
-
-	return register_power_pmu(&power5_pmu);
-}
-
-early_initcall(init_power5_pmu);
diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/kernel/power6-pmu.c
deleted file mode 100644
index 0bbc901..0000000
--- a/arch/powerpc/kernel/power6-pmu.c
+++ /dev/null
@@ -1,552 +0,0 @@
-/*
- * Performance counter support for POWER6 processors.
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/perf_event.h>
-#include <linux/string.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for POWER6
- */
-#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0x7
-#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
-#define PM_UNIT_SH	16	/* Unit event comes (TTMxSEL encoding) */
-#define PM_UNIT_MSK	0xf
-#define PM_UNIT_MSKS	(PM_UNIT_MSK << PM_UNIT_SH)
-#define PM_LLAV		0x8000	/* Load lookahead match value */
-#define PM_LLA		0x4000	/* Load lookahead match enable */
-#define PM_BYTE_SH	12	/* Byte of event bus to use */
-#define PM_BYTE_MSK	3
-#define PM_SUBUNIT_SH	8	/* Subunit event comes from (NEST_SEL enc.) */
-#define PM_SUBUNIT_MSK	7
-#define PM_SUBUNIT_MSKS	(PM_SUBUNIT_MSK << PM_SUBUNIT_SH)
-#define PM_PMCSEL_MSK	0xff	/* PMCxSEL value */
-#define PM_BUSEVENT_MSK	0xf3700
-
-/*
- * Bits in MMCR1 for POWER6
- */
-#define MMCR1_TTM0SEL_SH	60
-#define MMCR1_TTMSEL_SH(n)	(MMCR1_TTM0SEL_SH - (n) * 4)
-#define MMCR1_TTMSEL_MSK	0xf
-#define MMCR1_TTMSEL(m, n)	(((m) >> MMCR1_TTMSEL_SH(n)) & MMCR1_TTMSEL_MSK)
-#define MMCR1_NESTSEL_SH	45
-#define MMCR1_NESTSEL_MSK	0x7
-#define MMCR1_NESTSEL(m)	(((m) >> MMCR1_NESTSEL_SH) & MMCR1_NESTSEL_MSK)
-#define MMCR1_PMC1_LLA		(1ul << 44)
-#define MMCR1_PMC1_LLA_VALUE	(1ul << 39)
-#define MMCR1_PMC1_ADDR_SEL	(1ul << 35)
-#define MMCR1_PMC1SEL_SH	24
-#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
-#define MMCR1_PMCSEL_MSK	0xff
-
-/*
- * Map of which direct events on which PMCs are marked instruction events.
- * Indexed by PMCSEL value >> 1.
- * Bottom 4 bits are a map of which PMCs are interesting,
- * top 4 bits say what sort of event:
- *   0 = direct marked event,
- *   1 = byte decode event,
- *   4 = add/and event (PMC1 -> bits 0 & 4),
- *   5 = add/and event (PMC1 -> bits 1 & 5),
- *   6 = add/and event (PMC1 -> bits 2 & 6),
- *   7 = add/and event (PMC1 -> bits 3 & 7).
- */
-static unsigned char direct_event_is_marked[0x60 >> 1] = {
-	0,	/* 00 */
-	0,	/* 02 */
-	0,	/* 04 */
-	0x07,	/* 06 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
-	0x04,	/* 08 PM_MRK_DFU_FIN */
-	0x06,	/* 0a PM_MRK_IFU_FIN, PM_MRK_INST_FIN */
-	0,	/* 0c */
-	0,	/* 0e */
-	0x02,	/* 10 PM_MRK_INST_DISP */
-	0x08,	/* 12 PM_MRK_LSU_DERAT_MISS */
-	0,	/* 14 */
-	0,	/* 16 */
-	0x0c,	/* 18 PM_THRESH_TIMEO, PM_MRK_INST_FIN */
-	0x0f,	/* 1a PM_MRK_INST_DISP, PM_MRK_{FXU,FPU,LSU}_FIN */
-	0x01,	/* 1c PM_MRK_INST_ISSUED */
-	0,	/* 1e */
-	0,	/* 20 */
-	0,	/* 22 */
-	0,	/* 24 */
-	0,	/* 26 */
-	0x15,	/* 28 PM_MRK_DATA_FROM_L2MISS, PM_MRK_DATA_FROM_L3MISS */
-	0,	/* 2a */
-	0,	/* 2c */
-	0,	/* 2e */
-	0x4f,	/* 30 */
-	0x7f,	/* 32 */
-	0x4f,	/* 34 */
-	0x5f,	/* 36 */
-	0x6f,	/* 38 */
-	0x4f,	/* 3a */
-	0,	/* 3c */
-	0x08,	/* 3e PM_MRK_INST_TIMEO */
-	0x1f,	/* 40 */
-	0x1f,	/* 42 */
-	0x1f,	/* 44 */
-	0x1f,	/* 46 */
-	0x1f,	/* 48 */
-	0x1f,	/* 4a */
-	0x1f,	/* 4c */
-	0x1f,	/* 4e */
-	0,	/* 50 */
-	0x05,	/* 52 PM_MRK_BR_TAKEN, PM_MRK_BR_MPRED */
-	0x1c,	/* 54 PM_MRK_PTEG_FROM_L3MISS, PM_MRK_PTEG_FROM_L2MISS */
-	0x02,	/* 56 PM_MRK_LD_MISS_L1 */
-	0,	/* 58 */
-	0,	/* 5a */
-	0,	/* 5c */
-	0,	/* 5e */
-};
-
-/*
- * Masks showing for each unit which bits are marked events.
- * These masks are in LE order, i.e. 0x00000001 is byte 0, bit 0.
- */
-static u32 marked_bus_events[16] = {
-	0x01000000,	/* direct events set 1: byte 3 bit 0 */
-	0x00010000,	/* direct events set 2: byte 2 bit 0 */
-	0, 0, 0, 0,	/* IDU, IFU, nest: nothing */
-	0x00000088,	/* VMX set 1: byte 0 bits 3, 7 */
-	0x000000c0,	/* VMX set 2: byte 0 bits 4-7 */
-	0x04010000,	/* LSU set 1: byte 2 bit 0, byte 3 bit 2 */
-	0xff010000u,	/* LSU set 2: byte 2 bit 0, all of byte 3 */
-	0,		/* LSU set 3 */
-	0x00000010,	/* VMX set 3: byte 0 bit 4 */
-	0,		/* BFP set 1 */
-	0x00000022,	/* BFP set 2: byte 0 bits 1, 5 */
-	0, 0
-};
-	
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int power6_marked_instr_event(u64 event)
-{
-	int pmc, psel, ptype;
-	int bit, byte, unit;
-	u32 mask;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = (event & PM_PMCSEL_MSK) >> 1;	/* drop edge/level bit */
-	if (pmc >= 5)
-		return 0;
-
-	bit = -1;
-	if (psel < sizeof(direct_event_is_marked)) {
-		ptype = direct_event_is_marked[psel];
-		if (pmc == 0 || !(ptype & (1 << (pmc - 1))))
-			return 0;
-		ptype >>= 4;
-		if (ptype == 0)
-			return 1;
-		if (ptype == 1)
-			bit = 0;
-		else
-			bit = ptype ^ (pmc - 1);
-	} else if ((psel & 0x48) == 0x40)
-		bit = psel & 7;
-
-	if (!(event & PM_BUSEVENT_MSK) || bit == -1)
-		return 0;
-
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	mask = marked_bus_events[unit];
-	return (mask >> (byte * 8 + bit)) & 1;
-}
-
-/*
- * Assign PMC numbers and compute MMCR1 value for a set of events
- */
-static int p6_compute_mmcr(u64 event[], int n_ev,
-			   unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr1 = 0;
-	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
-	int i;
-	unsigned int pmc, ev, b, u, s, psel;
-	unsigned int ttmset = 0;
-	unsigned int pmc_inuse = 0;
-
-	if (n_ev > 6)
-		return -1;
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;	/* collision! */
-			pmc_inuse |= 1 << (pmc - 1);
-		}
-	}
-	for (i = 0; i < n_ev; ++i) {
-		ev = event[i];
-		pmc = (ev >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			--pmc;
-		} else {
-			/* can go on any PMC; find a free one */
-			for (pmc = 0; pmc < 4; ++pmc)
-				if (!(pmc_inuse & (1 << pmc)))
-					break;
-			if (pmc >= 4)
-				return -1;
-			pmc_inuse |= 1 << pmc;
-		}
-		hwc[i] = pmc;
-		psel = ev & PM_PMCSEL_MSK;
-		if (ev & PM_BUSEVENT_MSK) {
-			/* this event uses the event bus */
-			b = (ev >> PM_BYTE_SH) & PM_BYTE_MSK;
-			u = (ev >> PM_UNIT_SH) & PM_UNIT_MSK;
-			/* check for conflict on this byte of event bus */
-			if ((ttmset & (1 << b)) && MMCR1_TTMSEL(mmcr1, b) != u)
-				return -1;
-			mmcr1 |= (unsigned long)u << MMCR1_TTMSEL_SH(b);
-			ttmset |= 1 << b;
-			if (u == 5) {
-				/* Nest events have a further mux */
-				s = (ev >> PM_SUBUNIT_SH) & PM_SUBUNIT_MSK;
-				if ((ttmset & 0x10) &&
-				    MMCR1_NESTSEL(mmcr1) != s)
-					return -1;
-				ttmset |= 0x10;
-				mmcr1 |= (unsigned long)s << MMCR1_NESTSEL_SH;
-			}
-			if (0x30 <= psel && psel <= 0x3d) {
-				/* these need the PMCx_ADDR_SEL bits */
-				if (b >= 2)
-					mmcr1 |= MMCR1_PMC1_ADDR_SEL >> pmc;
-			}
-			/* bus select values are different for PMC3/4 */
-			if (pmc >= 2 && (psel & 0x90) == 0x80)
-				psel ^= 0x20;
-		}
-		if (ev & PM_LLA) {
-			mmcr1 |= MMCR1_PMC1_LLA >> pmc;
-			if (ev & PM_LLAV)
-				mmcr1 |= MMCR1_PMC1_LLA_VALUE >> pmc;
-		}
-		if (power6_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-		if (pmc < 4)
-			mmcr1 |= (unsigned long)psel << MMCR1_PMCSEL_SH(pmc);
-	}
-	mmcr[0] = 0;
-	if (pmc_inuse & 1)
-		mmcr[0] = MMCR0_PMC1CE;
-	if (pmc_inuse & 0xe)
-		mmcr[0] |= MMCR0_PMCjCE;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-/*
- * Layout of constraint bits:
- *
- *	0-1	add field: number of uses of PMC1 (max 1)
- *	2-3, 4-5, 6-7, 8-9, 10-11: ditto for PMC2, 3, 4, 5, 6
- *	12-15	add field: number of uses of PMC1-4 (max 4)
- *	16-19	select field: unit on byte 0 of event bus
- *	20-23, 24-27, 28-31 ditto for bytes 1, 2, 3
- *	32-34	select field: nest (subunit) event selector
- */
-static int p6_get_constraint(u64 event, unsigned long *maskp,
-			     unsigned long *valp)
-{
-	int pmc, byte, sh, subunit;
-	unsigned long mask = 0, value = 0;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 4 && !(event == 0x500009 || event == 0x600005))
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-	}
-	if (event & PM_BUSEVENT_MSK) {
-		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-		sh = byte * 4 + (16 - PM_UNIT_SH);
-		mask |= PM_UNIT_MSKS << sh;
-		value |= (unsigned long)(event & PM_UNIT_MSKS) << sh;
-		if ((event & PM_UNIT_MSKS) == (5 << PM_UNIT_SH)) {
-			subunit = (event >> PM_SUBUNIT_SH) & PM_SUBUNIT_MSK;
-			mask  |= (unsigned long)PM_SUBUNIT_MSK << 32;
-			value |= (unsigned long)subunit << 32;
-		}
-	}
-	if (pmc <= 4) {
-		mask  |= 0x8000;	/* add field for count of PMC1-4 uses */
-		value |= 0x1000;
-	}
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-static int p6_limited_pmc_event(u64 event)
-{
-	int pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-
-	return pmc == 5 || pmc == 6;
-}
-
-#define MAX_ALT	4	/* at most 4 alternatives for any event */
-
-static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x0130e8, 0x2000f6, 0x3000fc },	/* PM_PTEG_RELOAD_VALID */
-	{ 0x080080, 0x10000d, 0x30000c, 0x4000f0 }, /* PM_LD_MISS_L1 */
-	{ 0x080088, 0x200054, 0x3000f0 },	/* PM_ST_MISS_L1 */
-	{ 0x10000a, 0x2000f4, 0x600005 },	/* PM_RUN_CYC */
-	{ 0x10000b, 0x2000f5 },			/* PM_RUN_COUNT */
-	{ 0x10000e, 0x400010 },			/* PM_PURR */
-	{ 0x100010, 0x4000f8 },			/* PM_FLUSH */
-	{ 0x10001a, 0x200010 },			/* PM_MRK_INST_DISP */
-	{ 0x100026, 0x3000f8 },			/* PM_TB_BIT_TRANS */
-	{ 0x100054, 0x2000f0 },			/* PM_ST_FIN */
-	{ 0x100056, 0x2000fc },			/* PM_L1_ICACHE_MISS */
-	{ 0x1000f0, 0x40000a },			/* PM_INST_IMC_MATCH_CMPL */
-	{ 0x1000f8, 0x200008 },			/* PM_GCT_EMPTY_CYC */
-	{ 0x1000fc, 0x400006 },			/* PM_LSU_DERAT_MISS_CYC */
-	{ 0x20000e, 0x400007 },			/* PM_LSU_DERAT_MISS */
-	{ 0x200012, 0x300012 },			/* PM_INST_DISP */
-	{ 0x2000f2, 0x3000f2 },			/* PM_INST_DISP */
-	{ 0x2000f8, 0x300010 },			/* PM_EXT_INT */
-	{ 0x2000fe, 0x300056 },			/* PM_DATA_FROM_L2MISS */
-	{ 0x2d0030, 0x30001a },			/* PM_MRK_FPU_FIN */
-	{ 0x30000a, 0x400018 },			/* PM_MRK_INST_FIN */
-	{ 0x3000f6, 0x40000e },			/* PM_L1_DCACHE_RELOAD_VALID */
-	{ 0x3000fe, 0x400056 },			/* PM_DATA_FROM_L3MISS */
-};
-
-/*
- * This could be made more efficient with a binary search on
- * a presorted list, if necessary
- */
-static int find_alternatives_list(u64 event)
-{
-	int i, j;
-	unsigned int alt;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			return -1;
-		for (j = 0; j < MAX_ALT; ++j) {
-			alt = event_alternatives[i][j];
-			if (!alt || event < alt)
-				break;
-			if (event == alt)
-				return i;
-		}
-	}
-	return -1;
-}
-
-static int p6_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, nlim;
-	unsigned int psel, pmc;
-	unsigned int nalt = 1;
-	u64 aevent;
-
-	alt[0] = event;
-	nlim = p6_limited_pmc_event(event);
-
-	/* check the alternatives table */
-	i = find_alternatives_list(event);
-	if (i >= 0) {
-		/* copy out alternatives from list */
-		for (j = 0; j < MAX_ALT; ++j) {
-			aevent = event_alternatives[i][j];
-			if (!aevent)
-				break;
-			if (aevent != event)
-				alt[nalt++] = aevent;
-			nlim += p6_limited_pmc_event(aevent);
-		}
-
-	} else {
-		/* Check for alternative ways of computing sum events */
-		/* PMCSEL 0x32 counter N == PMCSEL 0x34 counter 5-N */
-		psel = event & (PM_PMCSEL_MSK & ~1);	/* ignore edge bit */
-		pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc && (psel == 0x32 || psel == 0x34))
-			alt[nalt++] = ((event ^ 0x6) & ~PM_PMC_MSKS) |
-				((5 - pmc) << PM_PMC_SH);
-
-		/* PMCSEL 0x38 counter N == PMCSEL 0x3a counter N+/-2 */
-		if (pmc && (psel == 0x38 || psel == 0x3a))
-			alt[nalt++] = ((event ^ 0x2) & ~PM_PMC_MSKS) |
-				((pmc > 2? pmc - 2: pmc + 2) << PM_PMC_SH);
-	}
-
-	if (flags & PPMU_ONLY_COUNT_RUN) {
-		/*
-		 * We're only counting in RUN state,
-		 * so PM_CYC is equivalent to PM_RUN_CYC,
-		 * PM_INST_CMPL === PM_RUN_INST_CMPL, PM_PURR === PM_RUN_PURR.
-		 * This doesn't include alternatives that don't provide
-		 * any extra flexibility in assigning PMCs (e.g.
-		 * 0x10000a for PM_RUN_CYC vs. 0x1e for PM_CYC).
-		 * Note that even with these additional alternatives
-		 * we never end up with more than 4 alternatives for any event.
-		 */
-		j = nalt;
-		for (i = 0; i < nalt; ++i) {
-			switch (alt[i]) {
-			case 0x1e:	/* PM_CYC */
-				alt[j++] = 0x600005;	/* PM_RUN_CYC */
-				++nlim;
-				break;
-			case 0x10000a:	/* PM_RUN_CYC */
-				alt[j++] = 0x1e;	/* PM_CYC */
-				break;
-			case 2:		/* PM_INST_CMPL */
-				alt[j++] = 0x500009;	/* PM_RUN_INST_CMPL */
-				++nlim;
-				break;
-			case 0x500009:	/* PM_RUN_INST_CMPL */
-				alt[j++] = 2;		/* PM_INST_CMPL */
-				break;
-			case 0x10000e:	/* PM_PURR */
-				alt[j++] = 0x4000f4;	/* PM_RUN_PURR */
-				break;
-			case 0x4000f4:	/* PM_RUN_PURR */
-				alt[j++] = 0x10000e;	/* PM_PURR */
-				break;
-			}
-		}
-		nalt = j;
-	}
-
-	if (!(flags & PPMU_LIMITED_PMC_OK) && nlim) {
-		/* remove the limited PMC events */
-		j = 0;
-		for (i = 0; i < nalt; ++i) {
-			if (!p6_limited_pmc_event(alt[i])) {
-				alt[j] = alt[i];
-				++j;
-			}
-		}
-		nalt = j;
-	} else if ((flags & PPMU_LIMITED_PMC_REQD) && nlim < nalt) {
-		/* remove all but the limited PMC events */
-		j = 0;
-		for (i = 0; i < nalt; ++i) {
-			if (p6_limited_pmc_event(alt[i])) {
-				alt[j] = alt[i];
-				++j;
-			}
-		}
-		nalt = j;
-	}
-
-	return nalt;
-}
-
-static void p6_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	/* Set PMCxSEL to 0 to disable PMCx */
-	if (pmc <= 3)
-		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
-}
-
-static int power6_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 0x1e,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 2,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x280030, /* LD_REF_L1 */
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x30000c, /* LD_MISS_L1 */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x410a0,  /* BR_PRED */
-	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x400052, /* BR_MPRED */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- * The "DTLB" and "ITLB" events relate to the DERAT and IERAT.
- */
-static int power6_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x280030,	0x80080		},
-		[C(OP_WRITE)] = {	0x180032,	0x80088		},
-		[C(OP_PREFETCH)] = {	0x810a4,	0		},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x100056 	},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	0x4008c,	0		},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x150730,	0x250532	},
-		[C(OP_WRITE)] = {	0x250432,	0x150432	},
-		[C(OP_PREFETCH)] = {	0x810a6,	0		},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x20000e	},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x420ce		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x430e6,	0x400052	},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1		},
-		[C(OP_WRITE)] = {	-1,		-1		},
-		[C(OP_PREFETCH)] = {	-1,		-1		},
-	},
-};
-
-static struct power_pmu power6_pmu = {
-	.name			= "POWER6",
-	.n_counter		= 6,
-	.max_alternatives	= MAX_ALT,
-	.add_fields		= 0x1555,
-	.test_adder		= 0x3000,
-	.compute_mmcr		= p6_compute_mmcr,
-	.get_constraint		= p6_get_constraint,
-	.get_alternatives	= p6_get_alternatives,
-	.disable_pmc		= p6_disable_pmc,
-	.limited_pmc_event	= p6_limited_pmc_event,
-	.flags			= PPMU_LIMITED_PMC5_6 | PPMU_ALT_SIPR,
-	.n_generic		= ARRAY_SIZE(power6_generic_events),
-	.generic_events		= power6_generic_events,
-	.cache_events		= &power6_cache_events,
-};
-
-static int __init init_power6_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
-		return -ENODEV;
-
-	return register_power_pmu(&power6_pmu);
-}
-
-early_initcall(init_power6_pmu);
diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
deleted file mode 100644
index 1251e4d..0000000
--- a/arch/powerpc/kernel/power7-pmu.c
+++ /dev/null
@@ -1,379 +0,0 @@
-/*
- * Performance counter support for POWER7 processors.
- *
- * Copyright 2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/perf_event.h>
-#include <linux/string.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for POWER7
- */
-#define PM_PMC_SH	16	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0xf
-#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
-#define PM_UNIT_SH	12	/* TTMMUX number and setting - unit select */
-#define PM_UNIT_MSK	0xf
-#define PM_COMBINE_SH	11	/* Combined event bit */
-#define PM_COMBINE_MSK	1
-#define PM_COMBINE_MSKS	0x800
-#define PM_L2SEL_SH	8	/* L2 event select */
-#define PM_L2SEL_MSK	7
-#define PM_PMCSEL_MSK	0xff
-
-/*
- * Bits in MMCR1 for POWER7
- */
-#define MMCR1_TTM0SEL_SH	60
-#define MMCR1_TTM1SEL_SH	56
-#define MMCR1_TTM2SEL_SH	52
-#define MMCR1_TTM3SEL_SH	48
-#define MMCR1_TTMSEL_MSK	0xf
-#define MMCR1_L2SEL_SH		45
-#define MMCR1_L2SEL_MSK		7
-#define MMCR1_PMC1_COMBINE_SH	35
-#define MMCR1_PMC2_COMBINE_SH	34
-#define MMCR1_PMC3_COMBINE_SH	33
-#define MMCR1_PMC4_COMBINE_SH	32
-#define MMCR1_PMC1SEL_SH	24
-#define MMCR1_PMC2SEL_SH	16
-#define MMCR1_PMC3SEL_SH	8
-#define MMCR1_PMC4SEL_SH	0
-#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
-#define MMCR1_PMCSEL_MSK	0xff
-
-/*
- * Layout of constraint bits:
- * 6666555555555544444444443333333333222222222211111111110000000000
- * 3210987654321098765432109876543210987654321098765432109876543210
- *                                                 [  ><><><><><><>
- *                                                  NC P6P5P4P3P2P1
- *
- * NC - number of counters
- *     15: NC error 0x8000
- *     12-14: number of events needing PMC1-4 0x7000
- *
- * P6
- *     11: P6 error 0x800
- *     10-11: Count of events needing PMC6
- *
- * P1..P5
- *     0-9: Count of events needing PMC1..PMC5
- */
-
-static int power7_get_constraint(u64 event, unsigned long *maskp,
-				 unsigned long *valp)
-{
-	int pmc, sh;
-	unsigned long mask = 0, value = 0;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 6)
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-		if (pmc >= 5 && !(event == 0x500fa || event == 0x600f4))
-			return -1;
-	}
-	if (pmc < 5) {
-		/* need a counter from PMC1-4 set */
-		mask  |= 0x8000;
-		value |= 0x1000;
-	}
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-#define MAX_ALT	2	/* at most 2 alternatives for any event */
-
-static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x200f2, 0x300f2 },		/* PM_INST_DISP */
-	{ 0x200f4, 0x600f4 },		/* PM_RUN_CYC */
-	{ 0x400fa, 0x500fa },		/* PM_RUN_INST_CMPL */
-};
-
-/*
- * Scan the alternatives table for a match and return the
- * index into the alternatives table if found, else -1.
- */
-static int find_alternative(u64 event)
-{
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			break;
-		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
-			if (event == event_alternatives[i][j])
-				return i;
-	}
-	return -1;
-}
-
-static s64 find_alternative_decode(u64 event)
-{
-	int pmc, psel;
-
-	/* this only handles the 4x decode events */
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = event & PM_PMCSEL_MSK;
-	if ((pmc == 2 || pmc == 4) && (psel & ~7) == 0x40)
-		return event - (1 << PM_PMC_SH) + 8;
-	if ((pmc == 1 || pmc == 3) && (psel & ~7) == 0x48)
-		return event + (1 << PM_PMC_SH) - 8;
-	return -1;
-}
-
-static int power7_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	int i, j, nalt = 1;
-	s64 ae;
-
-	alt[0] = event;
-	nalt = 1;
-	i = find_alternative(event);
-	if (i >= 0) {
-		for (j = 0; j < MAX_ALT; ++j) {
-			ae = event_alternatives[i][j];
-			if (ae && ae != event)
-				alt[nalt++] = ae;
-		}
-	} else {
-		ae = find_alternative_decode(event);
-		if (ae > 0)
-			alt[nalt++] = ae;
-	}
-
-	if (flags & PPMU_ONLY_COUNT_RUN) {
-		/*
-		 * We're only counting in RUN state,
-		 * so PM_CYC is equivalent to PM_RUN_CYC
-		 * and PM_INST_CMPL === PM_RUN_INST_CMPL.
-		 * This doesn't include alternatives that don't provide
-		 * any extra flexibility in assigning PMCs.
-		 */
-		j = nalt;
-		for (i = 0; i < nalt; ++i) {
-			switch (alt[i]) {
-			case 0x1e:	/* PM_CYC */
-				alt[j++] = 0x600f4;	/* PM_RUN_CYC */
-				break;
-			case 0x600f4:	/* PM_RUN_CYC */
-				alt[j++] = 0x1e;
-				break;
-			case 0x2:	/* PM_PPC_CMPL */
-				alt[j++] = 0x500fa;	/* PM_RUN_INST_CMPL */
-				break;
-			case 0x500fa:	/* PM_RUN_INST_CMPL */
-				alt[j++] = 0x2;	/* PM_PPC_CMPL */
-				break;
-			}
-		}
-		nalt = j;
-	}
-
-	return nalt;
-}
-
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int power7_marked_instr_event(u64 event)
-{
-	int pmc, psel;
-	int unit;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	psel = event & PM_PMCSEL_MSK & ~1;	/* trim off edge/level bit */
-	if (pmc >= 5)
-		return 0;
-
-	switch (psel >> 4) {
-	case 2:
-		return pmc == 2 || pmc == 4;
-	case 3:
-		if (psel == 0x3c)
-			return pmc == 1;
-		if (psel == 0x3e)
-			return pmc != 2;
-		return 1;
-	case 4:
-	case 5:
-		return unit == 0xd;
-	case 6:
-		if (psel == 0x64)
-			return pmc >= 3;
-	case 8:
-		return unit == 0xd;
-	}
-	return 0;
-}
-
-static int power7_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr1 = 0;
-	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
-	unsigned int pmc, unit, combine, l2sel, psel;
-	unsigned int pmc_inuse = 0;
-	int i;
-
-	/* First pass to count resource use */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc > 6)
-				return -1;
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;
-			pmc_inuse |= 1 << (pmc - 1);
-		}
-	}
-
-	/* Second pass: assign PMCs, set all MMCR1 fields */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		combine = (event[i] >> PM_COMBINE_SH) & PM_COMBINE_MSK;
-		l2sel = (event[i] >> PM_L2SEL_SH) & PM_L2SEL_MSK;
-		psel = event[i] & PM_PMCSEL_MSK;
-		if (!pmc) {
-			/* Bus event or any-PMC direct event */
-			for (pmc = 0; pmc < 4; ++pmc) {
-				if (!(pmc_inuse & (1 << pmc)))
-					break;
-			}
-			if (pmc >= 4)
-				return -1;
-			pmc_inuse |= 1 << pmc;
-		} else {
-			/* Direct or decoded event */
-			--pmc;
-		}
-		if (pmc <= 3) {
-			mmcr1 |= (unsigned long) unit
-				<< (MMCR1_TTM0SEL_SH - 4 * pmc);
-			mmcr1 |= (unsigned long) combine
-				<< (MMCR1_PMC1_COMBINE_SH - pmc);
-			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
-			if (unit == 6)	/* L2 events */
-				mmcr1 |= (unsigned long) l2sel
-					<< MMCR1_L2SEL_SH;
-		}
-		if (power7_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-		hwc[i] = pmc;
-	}
-
-	/* Return MMCRx values */
-	mmcr[0] = 0;
-	if (pmc_inuse & 1)
-		mmcr[0] = MMCR0_PMC1CE;
-	if (pmc_inuse & 0x3e)
-		mmcr[0] |= MMCR0_PMCjCE;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	if (pmc <= 3)
-		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
-}
-
-static int power7_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
-	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
-	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
-	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x10068,	/* BRU_FIN	*/
-	[PERF_COUNT_HW_BRANCH_MISSES] = 0x400f6,	/* BR_MPRED	*/
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int power7_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0xc880,		0x400f0	},
-		[C(OP_WRITE)] = {	0,		0x300f0	},
-		[C(OP_PREFETCH)] = {	0xd8b8,		0	},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x200fc	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0x408a,		0	},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x16080,	0x26080	},
-		[C(OP_WRITE)] = {	0x16082,	0x26082	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x300fc	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x400fc	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x10068,	0x400f6	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-};
-
-static struct power_pmu power7_pmu = {
-	.name			= "POWER7",
-	.n_counter		= 6,
-	.max_alternatives	= MAX_ALT + 1,
-	.add_fields		= 0x1555ul,
-	.test_adder		= 0x3000ul,
-	.compute_mmcr		= power7_compute_mmcr,
-	.get_constraint		= power7_get_constraint,
-	.get_alternatives	= power7_get_alternatives,
-	.disable_pmc		= power7_disable_pmc,
-	.flags			= PPMU_ALT_SIPR,
-	.n_generic		= ARRAY_SIZE(power7_generic_events),
-	.generic_events		= power7_generic_events,
-	.cache_events		= &power7_cache_events,
-};
-
-static int __init init_power7_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
-		return -ENODEV;
-
-	return register_power_pmu(&power7_pmu);
-}
-
-early_initcall(init_power7_pmu);
diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/kernel/ppc970-pmu.c
deleted file mode 100644
index 8c21902..0000000
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ /dev/null
@@ -1,502 +0,0 @@
-/*
- * Performance counter support for PPC970-family processors.
- *
- * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/string.h>
-#include <linux/perf_event.h>
-#include <asm/reg.h>
-#include <asm/cputable.h>
-
-/*
- * Bits in event code for PPC970
- */
-#define PM_PMC_SH	12	/* PMC number (1-based) for direct events */
-#define PM_PMC_MSK	0xf
-#define PM_UNIT_SH	8	/* TTMMUX number and setting - unit select */
-#define PM_UNIT_MSK	0xf
-#define PM_SPCSEL_SH	6
-#define PM_SPCSEL_MSK	3
-#define PM_BYTE_SH	4	/* Byte number of event bus to use */
-#define PM_BYTE_MSK	3
-#define PM_PMCSEL_MSK	0xf
-
-/* Values in PM_UNIT field */
-#define PM_NONE		0
-#define PM_FPU		1
-#define PM_VPU		2
-#define PM_ISU		3
-#define PM_IFU		4
-#define PM_IDU		5
-#define PM_STS		6
-#define PM_LSU0		7
-#define PM_LSU1U	8
-#define PM_LSU1L	9
-#define PM_LASTUNIT	9
-
-/*
- * Bits in MMCR0 for PPC970
- */
-#define MMCR0_PMC1SEL_SH	8
-#define MMCR0_PMC2SEL_SH	1
-#define MMCR_PMCSEL_MSK		0x1f
-
-/*
- * Bits in MMCR1 for PPC970
- */
-#define MMCR1_TTM0SEL_SH	62
-#define MMCR1_TTM1SEL_SH	59
-#define MMCR1_TTM3SEL_SH	53
-#define MMCR1_TTMSEL_MSK	3
-#define MMCR1_TD_CP_DBG0SEL_SH	50
-#define MMCR1_TD_CP_DBG1SEL_SH	48
-#define MMCR1_TD_CP_DBG2SEL_SH	46
-#define MMCR1_TD_CP_DBG3SEL_SH	44
-#define MMCR1_PMC1_ADDER_SEL_SH	39
-#define MMCR1_PMC2_ADDER_SEL_SH	38
-#define MMCR1_PMC6_ADDER_SEL_SH	37
-#define MMCR1_PMC5_ADDER_SEL_SH	36
-#define MMCR1_PMC8_ADDER_SEL_SH	35
-#define MMCR1_PMC7_ADDER_SEL_SH	34
-#define MMCR1_PMC3_ADDER_SEL_SH	33
-#define MMCR1_PMC4_ADDER_SEL_SH	32
-#define MMCR1_PMC3SEL_SH	27
-#define MMCR1_PMC4SEL_SH	22
-#define MMCR1_PMC5SEL_SH	17
-#define MMCR1_PMC6SEL_SH	12
-#define MMCR1_PMC7SEL_SH	7
-#define MMCR1_PMC8SEL_SH	2
-
-static short mmcr1_adder_bits[8] = {
-	MMCR1_PMC1_ADDER_SEL_SH,
-	MMCR1_PMC2_ADDER_SEL_SH,
-	MMCR1_PMC3_ADDER_SEL_SH,
-	MMCR1_PMC4_ADDER_SEL_SH,
-	MMCR1_PMC5_ADDER_SEL_SH,
-	MMCR1_PMC6_ADDER_SEL_SH,
-	MMCR1_PMC7_ADDER_SEL_SH,
-	MMCR1_PMC8_ADDER_SEL_SH
-};
-
-/*
- * Layout of constraint bits:
- * 6666555555555544444444443333333333222222222211111111110000000000
- * 3210987654321098765432109876543210987654321098765432109876543210
- *               <><><>[  >[  >[  ><  ><  ><  ><  ><><><><><><><><>
- *               SPT0T1 UC  PS1 PS2 B0  B1  B2  B3 P1P2P3P4P5P6P7P8
- *
- * SP - SPCSEL constraint
- *     48-49: SPCSEL value 0x3_0000_0000_0000
- *
- * T0 - TTM0 constraint
- *     46-47: TTM0SEL value (0=FPU, 2=IFU, 3=VPU) 0xC000_0000_0000
- *
- * T1 - TTM1 constraint
- *     44-45: TTM1SEL value (0=IDU, 3=STS) 0x3000_0000_0000
- *
- * UC - unit constraint: can't have all three of FPU|IFU|VPU, ISU, IDU|STS
- *     43: UC3 error 0x0800_0000_0000
- *     42: FPU|IFU|VPU events needed 0x0400_0000_0000
- *     41: ISU events needed 0x0200_0000_0000
- *     40: IDU|STS events needed 0x0100_0000_0000
- *
- * PS1
- *     39: PS1 error 0x0080_0000_0000
- *     36-38: count of events needing PMC1/2/5/6 0x0070_0000_0000
- *
- * PS2
- *     35: PS2 error 0x0008_0000_0000
- *     32-34: count of events needing PMC3/4/7/8 0x0007_0000_0000
- *
- * B0
- *     28-31: Byte 0 event source 0xf000_0000
- *	      Encoding as for the event code
- *
- * B1, B2, B3
- *     24-27, 20-23, 16-19: Byte 1, 2, 3 event sources
- *
- * P1
- *     15: P1 error 0x8000
- *     14-15: Count of events needing PMC1
- *
- * P2..P8
- *     0-13: Count of events needing PMC2..PMC8
- */
-
-static unsigned char direct_marked_event[8] = {
-	(1<<2) | (1<<3),	/* PMC1: PM_MRK_GRP_DISP, PM_MRK_ST_CMPL */
-	(1<<3) | (1<<5),	/* PMC2: PM_THRESH_TIMEO, PM_MRK_BRU_FIN */
-	(1<<3) | (1<<5),	/* PMC3: PM_MRK_ST_CMPL_INT, PM_MRK_VMX_FIN */
-	(1<<4) | (1<<5),	/* PMC4: PM_MRK_GRP_CMPL, PM_MRK_CRU_FIN */
-	(1<<4) | (1<<5),	/* PMC5: PM_GRP_MRK, PM_MRK_GRP_TIMEO */
-	(1<<3) | (1<<4) | (1<<5),
-		/* PMC6: PM_MRK_ST_STS, PM_MRK_FXU_FIN, PM_MRK_GRP_ISSUED */
-	(1<<4) | (1<<5),	/* PMC7: PM_MRK_FPU_FIN, PM_MRK_INST_FIN */
-	(1<<4)			/* PMC8: PM_MRK_LSU_FIN */
-};
-
-/*
- * Returns 1 if event counts things relating to marked instructions
- * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
- */
-static int p970_marked_instr_event(u64 event)
-{
-	int pmc, psel, unit, byte, bit;
-	unsigned int mask;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	psel = event & PM_PMCSEL_MSK;
-	if (pmc) {
-		if (direct_marked_event[pmc - 1] & (1 << psel))
-			return 1;
-		if (psel == 0)		/* add events */
-			bit = (pmc <= 4)? pmc - 1: 8 - pmc;
-		else if (psel == 7 || psel == 13)	/* decode events */
-			bit = 4;
-		else
-			return 0;
-	} else
-		bit = psel;
-
-	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	mask = 0;
-	switch (unit) {
-	case PM_VPU:
-		mask = 0x4c;		/* byte 0 bits 2,3,6 */
-		break;
-	case PM_LSU0:
-		/* byte 2 bits 0,2,3,4,6; all of byte 1 */
-		mask = 0x085dff00;
-		break;
-	case PM_LSU1L:
-		mask = 0x50 << 24;	/* byte 3 bits 4,6 */
-		break;
-	}
-	return (mask >> (byte * 8 + bit)) & 1;
-}
-
-/* Masks and values for using events from the various units */
-static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
-	[PM_FPU] =   { 0xc80000000000ull, 0x040000000000ull },
-	[PM_VPU] =   { 0xc80000000000ull, 0xc40000000000ull },
-	[PM_ISU] =   { 0x080000000000ull, 0x020000000000ull },
-	[PM_IFU] =   { 0xc80000000000ull, 0x840000000000ull },
-	[PM_IDU] =   { 0x380000000000ull, 0x010000000000ull },
-	[PM_STS] =   { 0x380000000000ull, 0x310000000000ull },
-};
-
-static int p970_get_constraint(u64 event, unsigned long *maskp,
-			       unsigned long *valp)
-{
-	int pmc, byte, unit, sh, spcsel;
-	unsigned long mask = 0, value = 0;
-	int grp = -1;
-
-	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
-	if (pmc) {
-		if (pmc > 8)
-			return -1;
-		sh = (pmc - 1) * 2;
-		mask |= 2 << sh;
-		value |= 1 << sh;
-		grp = ((pmc - 1) >> 1) & 1;
-	}
-	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
-	if (unit) {
-		if (unit > PM_LASTUNIT)
-			return -1;
-		mask |= unit_cons[unit][0];
-		value |= unit_cons[unit][1];
-		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
-		/*
-		 * Bus events on bytes 0 and 2 can be counted
-		 * on PMC1/2/5/6; bytes 1 and 3 on PMC3/4/7/8.
-		 */
-		if (!pmc)
-			grp = byte & 1;
-		/* Set byte lane select field */
-		mask  |= 0xfULL << (28 - 4 * byte);
-		value |= (unsigned long)unit << (28 - 4 * byte);
-	}
-	if (grp == 0) {
-		/* increment PMC1/2/5/6 field */
-		mask  |= 0x8000000000ull;
-		value |= 0x1000000000ull;
-	} else if (grp == 1) {
-		/* increment PMC3/4/7/8 field */
-		mask  |= 0x800000000ull;
-		value |= 0x100000000ull;
-	}
-	spcsel = (event >> PM_SPCSEL_SH) & PM_SPCSEL_MSK;
-	if (spcsel) {
-		mask  |= 3ull << 48;
-		value |= (unsigned long)spcsel << 48;
-	}
-	*maskp = mask;
-	*valp = value;
-	return 0;
-}
-
-static int p970_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-{
-	alt[0] = event;
-
-	/* 2 alternatives for LSU empty */
-	if (event == 0x2002 || event == 0x3002) {
-		alt[1] = event ^ 0x1000;
-		return 2;
-	}
-		
-	return 1;
-}
-
-static int p970_compute_mmcr(u64 event[], int n_ev,
-			     unsigned int hwc[], unsigned long mmcr[])
-{
-	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
-	unsigned int pmc, unit, byte, psel;
-	unsigned int ttm, grp;
-	unsigned int pmc_inuse = 0;
-	unsigned int pmc_grp_use[2];
-	unsigned char busbyte[4];
-	unsigned char unituse[16];
-	unsigned char unitmap[] = { 0, 0<<3, 3<<3, 1<<3, 2<<3, 0|4, 3|4 };
-	unsigned char ttmuse[2];
-	unsigned char pmcsel[8];
-	int i;
-	int spcsel;
-
-	if (n_ev > 8)
-		return -1;
-
-	/* First pass to count resource use */
-	pmc_grp_use[0] = pmc_grp_use[1] = 0;
-	memset(busbyte, 0, sizeof(busbyte));
-	memset(unituse, 0, sizeof(unituse));
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		if (pmc) {
-			if (pmc_inuse & (1 << (pmc - 1)))
-				return -1;
-			pmc_inuse |= 1 << (pmc - 1);
-			/* count 1/2/5/6 vs 3/4/7/8 use */
-			++pmc_grp_use[((pmc - 1) >> 1) & 1];
-		}
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		if (unit) {
-			if (unit > PM_LASTUNIT)
-				return -1;
-			if (!pmc)
-				++pmc_grp_use[byte & 1];
-			if (busbyte[byte] && busbyte[byte] != unit)
-				return -1;
-			busbyte[byte] = unit;
-			unituse[unit] = 1;
-		}
-	}
-	if (pmc_grp_use[0] > 4 || pmc_grp_use[1] > 4)
-		return -1;
-
-	/*
-	 * Assign resources and set multiplexer selects.
-	 *
-	 * PM_ISU can go either on TTM0 or TTM1, but that's the only
-	 * choice we have to deal with.
-	 */
-	if (unituse[PM_ISU] &
-	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_VPU]))
-		unitmap[PM_ISU] = 2 | 4;	/* move ISU to TTM1 */
-	/* Set TTM[01]SEL fields. */
-	ttmuse[0] = ttmuse[1] = 0;
-	for (i = PM_FPU; i <= PM_STS; ++i) {
-		if (!unituse[i])
-			continue;
-		ttm = unitmap[i];
-		++ttmuse[(ttm >> 2) & 1];
-		mmcr1 |= (unsigned long)(ttm & ~4) << MMCR1_TTM1SEL_SH;
-	}
-	/* Check only one unit per TTMx */
-	if (ttmuse[0] > 1 || ttmuse[1] > 1)
-		return -1;
-
-	/* Set byte lane select fields and TTM3SEL. */
-	for (byte = 0; byte < 4; ++byte) {
-		unit = busbyte[byte];
-		if (!unit)
-			continue;
-		if (unit <= PM_STS)
-			ttm = (unitmap[unit] >> 2) & 1;
-		else if (unit == PM_LSU0)
-			ttm = 2;
-		else {
-			ttm = 3;
-			if (unit == PM_LSU1L && byte >= 2)
-				mmcr1 |= 1ull << (MMCR1_TTM3SEL_SH + 3 - byte);
-		}
-		mmcr1 |= (unsigned long)ttm
-			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
-	}
-
-	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
-	memset(pmcsel, 0x8, sizeof(pmcsel));	/* 8 means don't count */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
-		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
-		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
-		psel = event[i] & PM_PMCSEL_MSK;
-		if (!pmc) {
-			/* Bus event or any-PMC direct event */
-			if (unit)
-				psel |= 0x10 | ((byte & 2) << 2);
-			else
-				psel |= 8;
-			for (pmc = 0; pmc < 8; ++pmc) {
-				if (pmc_inuse & (1 << pmc))
-					continue;
-				grp = (pmc >> 1) & 1;
-				if (unit) {
-					if (grp == (byte & 1))
-						break;
-				} else if (pmc_grp_use[grp] < 4) {
-					++pmc_grp_use[grp];
-					break;
-				}
-			}
-			pmc_inuse |= 1 << pmc;
-		} else {
-			/* Direct event */
-			--pmc;
-			if (psel == 0 && (byte & 2))
-				/* add events on higher-numbered bus */
-				mmcr1 |= 1ull << mmcr1_adder_bits[pmc];
-		}
-		pmcsel[pmc] = psel;
-		hwc[i] = pmc;
-		spcsel = (event[i] >> PM_SPCSEL_SH) & PM_SPCSEL_MSK;
-		mmcr1 |= spcsel;
-		if (p970_marked_instr_event(event[i]))
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-	}
-	for (pmc = 0; pmc < 2; ++pmc)
-		mmcr0 |= pmcsel[pmc] << (MMCR0_PMC1SEL_SH - 7 * pmc);
-	for (; pmc < 8; ++pmc)
-		mmcr1 |= (unsigned long)pmcsel[pmc]
-			<< (MMCR1_PMC3SEL_SH - 5 * (pmc - 2));
-	if (pmc_inuse & 1)
-		mmcr0 |= MMCR0_PMC1CE;
-	if (pmc_inuse & 0xfe)
-		mmcr0 |= MMCR0_PMCjCE;
-
-	mmcra |= 0x2000;	/* mark only one IOP per PPC instruction */
-
-	/* Return MMCRx values */
-	mmcr[0] = mmcr0;
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	return 0;
-}
-
-static void p970_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	int shift, i;
-
-	if (pmc <= 1) {
-		shift = MMCR0_PMC1SEL_SH - 7 * pmc;
-		i = 0;
-	} else {
-		shift = MMCR1_PMC3SEL_SH - 5 * (pmc - 2);
-		i = 1;
-	}
-	/*
-	 * Setting the PMCxSEL field to 0x08 disables PMC x.
-	 */
-	mmcr[i] = (mmcr[i] & ~(0x1fUL << shift)) | (0x08UL << shift);
-}
-
-static int ppc970_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES]		= 7,
-	[PERF_COUNT_HW_INSTRUCTIONS]		= 1,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x8810, /* PM_LD_REF_L1 */
-	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3810, /* PM_LD_MISS_L1 */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x431,  /* PM_BR_ISSUED */
-	[PERF_COUNT_HW_BRANCH_MISSES] 		= 0x327,  /* PM_GRP_BR_MPRED */
-};
-
-#define C(x)	PERF_COUNT_HW_CACHE_##x
-
-/*
- * Table of generalized cache-related events.
- * 0 means not supported, -1 means nonsensical, other values
- * are event codes.
- */
-static int ppc970_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x8810,		0x3810	},
-		[C(OP_WRITE)] = {	0x7810,		0x813	},
-		[C(OP_PREFETCH)] = {	0x731,		0	},
-	},
-	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0,		0	},
-	},
-	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0	},
-		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0x733,		0	},
-	},
-	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x704	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x700	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0x431,		0x327	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	-1,		-1	},
-		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	-1,		-1	},
-	},
-};
-
-static struct power_pmu ppc970_pmu = {
-	.name			= "PPC970/FX/MP",
-	.n_counter		= 8,
-	.max_alternatives	= 2,
-	.add_fields		= 0x001100005555ull,
-	.test_adder		= 0x013300000000ull,
-	.compute_mmcr		= p970_compute_mmcr,
-	.get_constraint		= p970_get_constraint,
-	.get_alternatives	= p970_get_alternatives,
-	.disable_pmc		= p970_disable_pmc,
-	.n_generic		= ARRAY_SIZE(ppc970_generic_events),
-	.generic_events		= ppc970_generic_events,
-	.cache_events		= &ppc970_cache_events,
-};
-
-static int __init init_ppc970_pmu(void)
-{
-	if (!cur_cpu_spec->oprofile_cpu_type ||
-	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
-	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
-		return -ENODEV;
-
-	return register_power_pmu(&ppc970_pmu);
-}
-
-early_initcall(init_ppc970_pmu);
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
new file mode 100644
index 0000000..af3fac2
--- /dev/null
+++ b/arch/powerpc/perf/Makefile
@@ -0,0 +1,14 @@
+subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+
+obj-$(CONFIG_PERF_EVENTS)	+= callchain.o
+
+obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
+obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
+				   power5+-pmu.o power6-pmu.o power7-pmu.o
+obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
+
+obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
+obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
+
+obj-$(CONFIG_PPC64)		+= $(obj64-y)
+obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
new file mode 100644
index 0000000..e8a18d1
--- /dev/null
+++ b/arch/powerpc/perf/callchain.c
@@ -0,0 +1,492 @@
+/*
+ * Performance counter callchain support - powerpc architecture code
+ *
+ * Copyright © 2009 Paul Mackerras, IBM Corporation.
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
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <asm/pgtable.h>
+#include <asm/sigcontext.h>
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+#ifdef CONFIG_PPC64
+#include "../kernel/ppc32.h"
+#endif
+
+
+/*
+ * Is sp valid as the address of the next kernel stack frame after prev_sp?
+ * The next frame may be in a different stack area but should not go
+ * back down in the same stack area.
+ */
+static int valid_next_sp(unsigned long sp, unsigned long prev_sp)
+{
+	if (sp & 0xf)
+		return 0;		/* must be 16-byte aligned */
+	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+		return 0;
+	if (sp >= prev_sp + STACK_FRAME_OVERHEAD)
+		return 1;
+	/*
+	 * sp could decrease when we jump off an interrupt stack
+	 * back to the regular process stack.
+	 */
+	if ((sp & ~(THREAD_SIZE - 1)) != (prev_sp & ~(THREAD_SIZE - 1)))
+		return 1;
+	return 0;
+}
+
+void
+perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	unsigned long sp, next_sp;
+	unsigned long next_ip;
+	unsigned long lr;
+	long level = 0;
+	unsigned long *fp;
+
+	lr = regs->link;
+	sp = regs->gpr[1];
+	perf_callchain_store(entry, regs->nip);
+
+	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+		return;
+
+	for (;;) {
+		fp = (unsigned long *) sp;
+		next_sp = fp[0];
+
+		if (next_sp == sp + STACK_INT_FRAME_SIZE &&
+		    fp[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
+			/*
+			 * This looks like an interrupt frame for an
+			 * interrupt that occurred in the kernel
+			 */
+			regs = (struct pt_regs *)(sp + STACK_FRAME_OVERHEAD);
+			next_ip = regs->nip;
+			lr = regs->link;
+			level = 0;
+			perf_callchain_store(entry, PERF_CONTEXT_KERNEL);
+
+		} else {
+			if (level == 0)
+				next_ip = lr;
+			else
+				next_ip = fp[STACK_FRAME_LR_SAVE];
+
+			/*
+			 * We can't tell which of the first two addresses
+			 * we get are valid, but we can filter out the
+			 * obviously bogus ones here.  We replace them
+			 * with 0 rather than removing them entirely so
+			 * that userspace can tell which is which.
+			 */
+			if ((level == 1 && next_ip == lr) ||
+			    (level <= 1 && !kernel_text_address(next_ip)))
+				next_ip = 0;
+
+			++level;
+		}
+
+		perf_callchain_store(entry, next_ip);
+		if (!valid_next_sp(next_sp, sp))
+			return;
+		sp = next_sp;
+	}
+}
+
+#ifdef CONFIG_PPC64
+/*
+ * On 64-bit we don't want to invoke hash_page on user addresses from
+ * interrupt context, so if the access faults, we read the page tables
+ * to find which page (if any) is mapped and access it directly.
+ */
+static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
+{
+	pgd_t *pgdir;
+	pte_t *ptep, pte;
+	unsigned shift;
+	unsigned long addr = (unsigned long) ptr;
+	unsigned long offset;
+	unsigned long pfn;
+	void *kaddr;
+
+	pgdir = current->mm->pgd;
+	if (!pgdir)
+		return -EFAULT;
+
+	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
+	if (!shift)
+		shift = PAGE_SHIFT;
+
+	/* align address to page boundary */
+	offset = addr & ((1UL << shift) - 1);
+	addr -= offset;
+
+	if (ptep == NULL)
+		return -EFAULT;
+	pte = *ptep;
+	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+		return -EFAULT;
+	pfn = pte_pfn(pte);
+	if (!page_is_ram(pfn))
+		return -EFAULT;
+
+	/* no highmem to worry about here */
+	kaddr = pfn_to_kaddr(pfn);
+	memcpy(ret, kaddr + offset, nb);
+	return 0;
+}
+
+static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
+{
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
+	    ((unsigned long)ptr & 7))
+		return -EFAULT;
+
+	pagefault_disable();
+	if (!__get_user_inatomic(*ret, ptr)) {
+		pagefault_enable();
+		return 0;
+	}
+	pagefault_enable();
+
+	return read_user_stack_slow(ptr, ret, 8);
+}
+
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+	    ((unsigned long)ptr & 3))
+		return -EFAULT;
+
+	pagefault_disable();
+	if (!__get_user_inatomic(*ret, ptr)) {
+		pagefault_enable();
+		return 0;
+	}
+	pagefault_enable();
+
+	return read_user_stack_slow(ptr, ret, 4);
+}
+
+static inline int valid_user_sp(unsigned long sp, int is_64)
+{
+	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
+		return 0;
+	return 1;
+}
+
+/*
+ * 64-bit user processes use the same stack frame for RT and non-RT signals.
+ */
+struct signal_frame_64 {
+	char		dummy[__SIGNAL_FRAMESIZE];
+	struct ucontext	uc;
+	unsigned long	unused[2];
+	unsigned int	tramp[6];
+	struct siginfo	*pinfo;
+	void		*puc;
+	struct siginfo	info;
+	char		abigap[288];
+};
+
+static int is_sigreturn_64_address(unsigned long nip, unsigned long fp)
+{
+	if (nip == fp + offsetof(struct signal_frame_64, tramp))
+		return 1;
+	if (vdso64_rt_sigtramp && current->mm->context.vdso_base &&
+	    nip == current->mm->context.vdso_base + vdso64_rt_sigtramp)
+		return 1;
+	return 0;
+}
+
+/*
+ * Do some sanity checking on the signal frame pointed to by sp.
+ * We check the pinfo and puc pointers in the frame.
+ */
+static int sane_signal_64_frame(unsigned long sp)
+{
+	struct signal_frame_64 __user *sf;
+	unsigned long pinfo, puc;
+
+	sf = (struct signal_frame_64 __user *) sp;
+	if (read_user_stack_64((unsigned long __user *) &sf->pinfo, &pinfo) ||
+	    read_user_stack_64((unsigned long __user *) &sf->puc, &puc))
+		return 0;
+	return pinfo == (unsigned long) &sf->info &&
+		puc == (unsigned long) &sf->uc;
+}
+
+static void perf_callchain_user_64(struct perf_callchain_entry *entry,
+				   struct pt_regs *regs)
+{
+	unsigned long sp, next_sp;
+	unsigned long next_ip;
+	unsigned long lr;
+	long level = 0;
+	struct signal_frame_64 __user *sigframe;
+	unsigned long __user *fp, *uregs;
+
+	next_ip = regs->nip;
+	lr = regs->link;
+	sp = regs->gpr[1];
+	perf_callchain_store(entry, next_ip);
+
+	for (;;) {
+		fp = (unsigned long __user *) sp;
+		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
+			return;
+		if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
+			return;
+
+		/*
+		 * Note: the next_sp - sp >= signal frame size check
+		 * is true when next_sp < sp, which can happen when
+		 * transitioning from an alternate signal stack to the
+		 * normal stack.
+		 */
+		if (next_sp - sp >= sizeof(struct signal_frame_64) &&
+		    (is_sigreturn_64_address(next_ip, sp) ||
+		     (level <= 1 && is_sigreturn_64_address(lr, sp))) &&
+		    sane_signal_64_frame(sp)) {
+			/*
+			 * This looks like an signal frame
+			 */
+			sigframe = (struct signal_frame_64 __user *) sp;
+			uregs = sigframe->uc.uc_mcontext.gp_regs;
+			if (read_user_stack_64(&uregs[PT_NIP], &next_ip) ||
+			    read_user_stack_64(&uregs[PT_LNK], &lr) ||
+			    read_user_stack_64(&uregs[PT_R1], &sp))
+				return;
+			level = 0;
+			perf_callchain_store(entry, PERF_CONTEXT_USER);
+			perf_callchain_store(entry, next_ip);
+			continue;
+		}
+
+		if (level == 0)
+			next_ip = lr;
+		perf_callchain_store(entry, next_ip);
+		++level;
+		sp = next_sp;
+	}
+}
+
+static inline int current_is_64bit(void)
+{
+	/*
+	 * We can't use test_thread_flag() here because we may be on an
+	 * interrupt stack, and the thread flags don't get copied over
+	 * from the thread_info on the main stack to the interrupt stack.
+	 */
+	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
+}
+
+#else  /* CONFIG_PPC64 */
+/*
+ * On 32-bit we just access the address and let hash_page create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do_page_fault() won't treat a DSI as a page fault.
+ */
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	int rc;
+
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+	    ((unsigned long)ptr & 3))
+		return -EFAULT;
+
+	pagefault_disable();
+	rc = __get_user_inatomic(*ret, ptr);
+	pagefault_enable();
+
+	return rc;
+}
+
+static inline void perf_callchain_user_64(struct perf_callchain_entry *entry,
+					  struct pt_regs *regs)
+{
+}
+
+static inline int current_is_64bit(void)
+{
+	return 0;
+}
+
+static inline int valid_user_sp(unsigned long sp, int is_64)
+{
+	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
+		return 0;
+	return 1;
+}
+
+#define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
+#define sigcontext32		sigcontext
+#define mcontext32		mcontext
+#define ucontext32		ucontext
+#define compat_siginfo_t	struct siginfo
+
+#endif /* CONFIG_PPC64 */
+
+/*
+ * Layout for non-RT signal frames
+ */
+struct signal_frame_32 {
+	char			dummy[__SIGNAL_FRAMESIZE32];
+	struct sigcontext32	sctx;
+	struct mcontext32	mctx;
+	int			abigap[56];
+};
+
+/*
+ * Layout for RT signal frames
+ */
+struct rt_signal_frame_32 {
+	char			dummy[__SIGNAL_FRAMESIZE32 + 16];
+	compat_siginfo_t	info;
+	struct ucontext32	uc;
+	int			abigap[56];
+};
+
+static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
+{
+	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
+		return 1;
+	if (vdso32_sigtramp && current->mm->context.vdso_base &&
+	    nip == current->mm->context.vdso_base + vdso32_sigtramp)
+		return 1;
+	return 0;
+}
+
+static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
+{
+	if (nip == fp + offsetof(struct rt_signal_frame_32,
+				 uc.uc_mcontext.mc_pad))
+		return 1;
+	if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
+	    nip == current->mm->context.vdso_base + vdso32_rt_sigtramp)
+		return 1;
+	return 0;
+}
+
+static int sane_signal_32_frame(unsigned int sp)
+{
+	struct signal_frame_32 __user *sf;
+	unsigned int regs;
+
+	sf = (struct signal_frame_32 __user *) (unsigned long) sp;
+	if (read_user_stack_32((unsigned int __user *) &sf->sctx.regs, &regs))
+		return 0;
+	return regs == (unsigned long) &sf->mctx;
+}
+
+static int sane_rt_signal_32_frame(unsigned int sp)
+{
+	struct rt_signal_frame_32 __user *sf;
+	unsigned int regs;
+
+	sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
+	if (read_user_stack_32((unsigned int __user *) &sf->uc.uc_regs, &regs))
+		return 0;
+	return regs == (unsigned long) &sf->uc.uc_mcontext;
+}
+
+static unsigned int __user *signal_frame_32_regs(unsigned int sp,
+				unsigned int next_sp, unsigned int next_ip)
+{
+	struct mcontext32 __user *mctx = NULL;
+	struct signal_frame_32 __user *sf;
+	struct rt_signal_frame_32 __user *rt_sf;
+
+	/*
+	 * Note: the next_sp - sp >= signal frame size check
+	 * is true when next_sp < sp, for example, when
+	 * transitioning from an alternate signal stack to the
+	 * normal stack.
+	 */
+	if (next_sp - sp >= sizeof(struct signal_frame_32) &&
+	    is_sigreturn_32_address(next_ip, sp) &&
+	    sane_signal_32_frame(sp)) {
+		sf = (struct signal_frame_32 __user *) (unsigned long) sp;
+		mctx = &sf->mctx;
+	}
+
+	if (!mctx && next_sp - sp >= sizeof(struct rt_signal_frame_32) &&
+	    is_rt_sigreturn_32_address(next_ip, sp) &&
+	    sane_rt_signal_32_frame(sp)) {
+		rt_sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
+		mctx = &rt_sf->uc.uc_mcontext;
+	}
+
+	if (!mctx)
+		return NULL;
+	return mctx->mc_gregs;
+}
+
+static void perf_callchain_user_32(struct perf_callchain_entry *entry,
+				   struct pt_regs *regs)
+{
+	unsigned int sp, next_sp;
+	unsigned int next_ip;
+	unsigned int lr;
+	long level = 0;
+	unsigned int __user *fp, *uregs;
+
+	next_ip = regs->nip;
+	lr = regs->link;
+	sp = regs->gpr[1];
+	perf_callchain_store(entry, next_ip);
+
+	while (entry->nr < PERF_MAX_STACK_DEPTH) {
+		fp = (unsigned int __user *) (unsigned long) sp;
+		if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
+			return;
+		if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
+			return;
+
+		uregs = signal_frame_32_regs(sp, next_sp, next_ip);
+		if (!uregs && level <= 1)
+			uregs = signal_frame_32_regs(sp, next_sp, lr);
+		if (uregs) {
+			/*
+			 * This looks like an signal frame, so restart
+			 * the stack trace with the values in it.
+			 */
+			if (read_user_stack_32(&uregs[PT_NIP], &next_ip) ||
+			    read_user_stack_32(&uregs[PT_LNK], &lr) ||
+			    read_user_stack_32(&uregs[PT_R1], &sp))
+				return;
+			level = 0;
+			perf_callchain_store(entry, PERF_CONTEXT_USER);
+			perf_callchain_store(entry, next_ip);
+			continue;
+		}
+
+		if (level == 0)
+			next_ip = lr;
+		perf_callchain_store(entry, next_ip);
+		++level;
+		sp = next_sp;
+	}
+}
+
+void
+perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	if (current_is_64bit())
+		perf_callchain_user_64(entry, regs);
+	else
+		perf_callchain_user_32(entry, regs);
+}
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
new file mode 100644
index 0000000..64483fd
--- /dev/null
+++ b/arch/powerpc/perf/core-book3s.c
@@ -0,0 +1,1438 @@
+/*
+ * Performance event support - powerpc architecture code
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
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
+#include <asm/reg.h>
+#include <asm/pmc.h>
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/ptrace.h>
+
+struct cpu_hw_events {
+	int n_events;
+	int n_percpu;
+	int disabled;
+	int n_added;
+	int n_limited;
+	u8  pmcs_enabled;
+	struct perf_event *event[MAX_HWEVENTS];
+	u64 events[MAX_HWEVENTS];
+	unsigned int flags[MAX_HWEVENTS];
+	unsigned long mmcr[3];
+	struct perf_event *limited_counter[MAX_LIMITED_HWCOUNTERS];
+	u8  limited_hwidx[MAX_LIMITED_HWCOUNTERS];
+	u64 alternatives[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
+	unsigned long amasks[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
+	unsigned long avalues[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
+
+	unsigned int group_flag;
+	int n_txn_start;
+};
+DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+
+struct power_pmu *ppmu;
+
+/*
+ * Normally, to ignore kernel events we set the FCS (freeze counters
+ * in supervisor mode) bit in MMCR0, but if the kernel runs with the
+ * hypervisor bit set in the MSR, or if we are running on a processor
+ * where the hypervisor bit is forced to 1 (as on Apple G5 processors),
+ * then we need to use the FCHV bit to ignore kernel events.
+ */
+static unsigned int freeze_events_kernel = MMCR0_FCS;
+
+/*
+ * 32-bit doesn't have MMCRA but does have an MMCR2,
+ * and a few other names are different.
+ */
+#ifdef CONFIG_PPC32
+
+#define MMCR0_FCHV		0
+#define MMCR0_PMCjCE		MMCR0_PMCnCE
+
+#define SPRN_MMCRA		SPRN_MMCR2
+#define MMCRA_SAMPLE_ENABLE	0
+
+static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
+{
+	return 0;
+}
+static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
+static inline u32 perf_get_misc_flags(struct pt_regs *regs)
+{
+	return 0;
+}
+static inline void perf_read_regs(struct pt_regs *regs) { }
+static inline int perf_intr_is_nmi(struct pt_regs *regs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PPC32 */
+
+/*
+ * Things that are specific to 64-bit implementations.
+ */
+#ifdef CONFIG_PPC64
+
+static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
+{
+	unsigned long mmcra = regs->dsisr;
+
+	if ((mmcra & MMCRA_SAMPLE_ENABLE) && !(ppmu->flags & PPMU_ALT_SIPR)) {
+		unsigned long slot = (mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT;
+		if (slot > 1)
+			return 4 * (slot - 1);
+	}
+	return 0;
+}
+
+/*
+ * The user wants a data address recorded.
+ * If we're not doing instruction sampling, give them the SDAR
+ * (sampled data address).  If we are doing instruction sampling, then
+ * only give them the SDAR if it corresponds to the instruction
+ * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC
+ * bit in MMCRA.
+ */
+static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
+{
+	unsigned long mmcra = regs->dsisr;
+	unsigned long sdsync = (ppmu->flags & PPMU_ALT_SIPR) ?
+		POWER6_MMCRA_SDSYNC : MMCRA_SDSYNC;
+
+	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || (mmcra & sdsync))
+		*addrp = mfspr(SPRN_SDAR);
+}
+
+static inline u32 perf_get_misc_flags(struct pt_regs *regs)
+{
+	unsigned long mmcra = regs->dsisr;
+	unsigned long sihv = MMCRA_SIHV;
+	unsigned long sipr = MMCRA_SIPR;
+
+	if (TRAP(regs) != 0xf00)
+		return 0;	/* not a PMU interrupt */
+
+	if (ppmu->flags & PPMU_ALT_SIPR) {
+		sihv = POWER6_MMCRA_SIHV;
+		sipr = POWER6_MMCRA_SIPR;
+	}
+
+	/* PR has priority over HV, so order below is important */
+	if (mmcra & sipr)
+		return PERF_RECORD_MISC_USER;
+	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
+		return PERF_RECORD_MISC_HYPERVISOR;
+	return PERF_RECORD_MISC_KERNEL;
+}
+
+/*
+ * Overload regs->dsisr to store MMCRA so we only need to read it once
+ * on each interrupt.
+ */
+static inline void perf_read_regs(struct pt_regs *regs)
+{
+	regs->dsisr = mfspr(SPRN_MMCRA);
+}
+
+/*
+ * If interrupts were soft-disabled when a PMU interrupt occurs, treat
+ * it as an NMI.
+ */
+static inline int perf_intr_is_nmi(struct pt_regs *regs)
+{
+	return !regs->softe;
+}
+
+#endif /* CONFIG_PPC64 */
+
+static void perf_event_interrupt(struct pt_regs *regs);
+
+void perf_event_print_debug(void)
+{
+}
+
+/*
+ * Read one performance monitor counter (PMC).
+ */
+static unsigned long read_pmc(int idx)
+{
+	unsigned long val;
+
+	switch (idx) {
+	case 1:
+		val = mfspr(SPRN_PMC1);
+		break;
+	case 2:
+		val = mfspr(SPRN_PMC2);
+		break;
+	case 3:
+		val = mfspr(SPRN_PMC3);
+		break;
+	case 4:
+		val = mfspr(SPRN_PMC4);
+		break;
+	case 5:
+		val = mfspr(SPRN_PMC5);
+		break;
+	case 6:
+		val = mfspr(SPRN_PMC6);
+		break;
+#ifdef CONFIG_PPC64
+	case 7:
+		val = mfspr(SPRN_PMC7);
+		break;
+	case 8:
+		val = mfspr(SPRN_PMC8);
+		break;
+#endif /* CONFIG_PPC64 */
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
+	case 1:
+		mtspr(SPRN_PMC1, val);
+		break;
+	case 2:
+		mtspr(SPRN_PMC2, val);
+		break;
+	case 3:
+		mtspr(SPRN_PMC3, val);
+		break;
+	case 4:
+		mtspr(SPRN_PMC4, val);
+		break;
+	case 5:
+		mtspr(SPRN_PMC5, val);
+		break;
+	case 6:
+		mtspr(SPRN_PMC6, val);
+		break;
+#ifdef CONFIG_PPC64
+	case 7:
+		mtspr(SPRN_PMC7, val);
+		break;
+	case 8:
+		mtspr(SPRN_PMC8, val);
+		break;
+#endif /* CONFIG_PPC64 */
+	default:
+		printk(KERN_ERR "oops trying to write PMC%d\n", idx);
+	}
+}
+
+/*
+ * Check if a set of events can all go on the PMU at once.
+ * If they can't, this will look at alternative codes for the events
+ * and see if any combination of alternative codes is feasible.
+ * The feasible set is returned in event_id[].
+ */
+static int power_check_constraints(struct cpu_hw_events *cpuhw,
+				   u64 event_id[], unsigned int cflags[],
+				   int n_ev)
+{
+	unsigned long mask, value, nv;
+	unsigned long smasks[MAX_HWEVENTS], svalues[MAX_HWEVENTS];
+	int n_alt[MAX_HWEVENTS], choice[MAX_HWEVENTS];
+	int i, j;
+	unsigned long addf = ppmu->add_fields;
+	unsigned long tadd = ppmu->test_adder;
+
+	if (n_ev > ppmu->n_counter)
+		return -1;
+
+	/* First see if the events will go on as-is */
+	for (i = 0; i < n_ev; ++i) {
+		if ((cflags[i] & PPMU_LIMITED_PMC_REQD)
+		    && !ppmu->limited_pmc_event(event_id[i])) {
+			ppmu->get_alternatives(event_id[i], cflags[i],
+					       cpuhw->alternatives[i]);
+			event_id[i] = cpuhw->alternatives[i][0];
+		}
+		if (ppmu->get_constraint(event_id[i], &cpuhw->amasks[i][0],
+					 &cpuhw->avalues[i][0]))
+			return -1;
+	}
+	value = mask = 0;
+	for (i = 0; i < n_ev; ++i) {
+		nv = (value | cpuhw->avalues[i][0]) +
+			(value & cpuhw->avalues[i][0] & addf);
+		if ((((nv + tadd) ^ value) & mask) != 0 ||
+		    (((nv + tadd) ^ cpuhw->avalues[i][0]) &
+		     cpuhw->amasks[i][0]) != 0)
+			break;
+		value = nv;
+		mask |= cpuhw->amasks[i][0];
+	}
+	if (i == n_ev)
+		return 0;	/* all OK */
+
+	/* doesn't work, gather alternatives... */
+	if (!ppmu->get_alternatives)
+		return -1;
+	for (i = 0; i < n_ev; ++i) {
+		choice[i] = 0;
+		n_alt[i] = ppmu->get_alternatives(event_id[i], cflags[i],
+						  cpuhw->alternatives[i]);
+		for (j = 1; j < n_alt[i]; ++j)
+			ppmu->get_constraint(cpuhw->alternatives[i][j],
+					     &cpuhw->amasks[i][j],
+					     &cpuhw->avalues[i][j]);
+	}
+
+	/* enumerate all possibilities and see if any will work */
+	i = 0;
+	j = -1;
+	value = mask = nv = 0;
+	while (i < n_ev) {
+		if (j >= 0) {
+			/* we're backtracking, restore context */
+			value = svalues[i];
+			mask = smasks[i];
+			j = choice[i];
+		}
+		/*
+		 * See if any alternative k for event_id i,
+		 * where k > j, will satisfy the constraints.
+		 */
+		while (++j < n_alt[i]) {
+			nv = (value | cpuhw->avalues[i][j]) +
+				(value & cpuhw->avalues[i][j] & addf);
+			if ((((nv + tadd) ^ value) & mask) == 0 &&
+			    (((nv + tadd) ^ cpuhw->avalues[i][j])
+			     & cpuhw->amasks[i][j]) == 0)
+				break;
+		}
+		if (j >= n_alt[i]) {
+			/*
+			 * No feasible alternative, backtrack
+			 * to event_id i-1 and continue enumerating its
+			 * alternatives from where we got up to.
+			 */
+			if (--i < 0)
+				return -1;
+		} else {
+			/*
+			 * Found a feasible alternative for event_id i,
+			 * remember where we got up to with this event_id,
+			 * go on to the next event_id, and start with
+			 * the first alternative for it.
+			 */
+			choice[i] = j;
+			svalues[i] = value;
+			smasks[i] = mask;
+			value = nv;
+			mask |= cpuhw->amasks[i][j];
+			++i;
+			j = -1;
+		}
+	}
+
+	/* OK, we have a feasible combination, tell the caller the solution */
+	for (i = 0; i < n_ev; ++i)
+		event_id[i] = cpuhw->alternatives[i][choice[i]];
+	return 0;
+}
+
+/*
+ * Check if newly-added events have consistent settings for
+ * exclude_{user,kernel,hv} with each other and any previously
+ * added events.
+ */
+static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
+			  int n_prev, int n_new)
+{
+	int eu = 0, ek = 0, eh = 0;
+	int i, n, first;
+	struct perf_event *event;
+
+	n = n_prev + n_new;
+	if (n <= 1)
+		return 0;
+
+	first = 1;
+	for (i = 0; i < n; ++i) {
+		if (cflags[i] & PPMU_LIMITED_PMC_OK) {
+			cflags[i] &= ~PPMU_LIMITED_PMC_REQD;
+			continue;
+		}
+		event = ctrs[i];
+		if (first) {
+			eu = event->attr.exclude_user;
+			ek = event->attr.exclude_kernel;
+			eh = event->attr.exclude_hv;
+			first = 0;
+		} else if (event->attr.exclude_user != eu ||
+			   event->attr.exclude_kernel != ek ||
+			   event->attr.exclude_hv != eh) {
+			return -EAGAIN;
+		}
+	}
+
+	if (eu || ek || eh)
+		for (i = 0; i < n; ++i)
+			if (cflags[i] & PPMU_LIMITED_PMC_OK)
+				cflags[i] |= PPMU_LIMITED_PMC_REQD;
+
+	return 0;
+}
+
+static u64 check_and_compute_delta(u64 prev, u64 val)
+{
+	u64 delta = (val - prev) & 0xfffffffful;
+
+	/*
+	 * POWER7 can roll back counter values, if the new value is smaller
+	 * than the previous value it will cause the delta and the counter to
+	 * have bogus values unless we rolled a counter over.  If a coutner is
+	 * rolled back, it will be smaller, but within 256, which is the maximum
+	 * number of events to rollback at once.  If we dectect a rollback
+	 * return 0.  This can lead to a small lack of precision in the
+	 * counters.
+	 */
+	if (prev > val && (prev - val) < 256)
+		delta = 0;
+
+	return delta;
+}
+
+static void power_pmu_read(struct perf_event *event)
+{
+	s64 val, delta, prev;
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	if (!event->hw.idx)
+		return;
+	/*
+	 * Performance monitor interrupts come even when interrupts
+	 * are soft-disabled, as long as interrupts are hard-enabled.
+	 * Therefore we treat them like NMIs.
+	 */
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		barrier();
+		val = read_pmc(event->hw.idx);
+		delta = check_and_compute_delta(prev, val);
+		if (!delta)
+			return;
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &event->hw.period_left);
+}
+
+/*
+ * On some machines, PMC5 and PMC6 can't be written, don't respect
+ * the freeze conditions, and don't generate interrupts.  This tells
+ * us if `event' is using such a PMC.
+ */
+static int is_limited_pmc(int pmcnum)
+{
+	return (ppmu->flags & PPMU_LIMITED_PMC5_6)
+		&& (pmcnum == 5 || pmcnum == 6);
+}
+
+static void freeze_limited_counters(struct cpu_hw_events *cpuhw,
+				    unsigned long pmc5, unsigned long pmc6)
+{
+	struct perf_event *event;
+	u64 val, prev, delta;
+	int i;
+
+	for (i = 0; i < cpuhw->n_limited; ++i) {
+		event = cpuhw->limited_counter[i];
+		if (!event->hw.idx)
+			continue;
+		val = (event->hw.idx == 5) ? pmc5 : pmc6;
+		prev = local64_read(&event->hw.prev_count);
+		event->hw.idx = 0;
+		delta = check_and_compute_delta(prev, val);
+		if (delta)
+			local64_add(delta, &event->count);
+	}
+}
+
+static void thaw_limited_counters(struct cpu_hw_events *cpuhw,
+				  unsigned long pmc5, unsigned long pmc6)
+{
+	struct perf_event *event;
+	u64 val, prev;
+	int i;
+
+	for (i = 0; i < cpuhw->n_limited; ++i) {
+		event = cpuhw->limited_counter[i];
+		event->hw.idx = cpuhw->limited_hwidx[i];
+		val = (event->hw.idx == 5) ? pmc5 : pmc6;
+		prev = local64_read(&event->hw.prev_count);
+		if (check_and_compute_delta(prev, val))
+			local64_set(&event->hw.prev_count, val);
+		perf_event_update_userpage(event);
+	}
+}
+
+/*
+ * Since limited events don't respect the freeze conditions, we
+ * have to read them immediately after freezing or unfreezing the
+ * other events.  We try to keep the values from the limited
+ * events as consistent as possible by keeping the delay (in
+ * cycles and instructions) between freezing/unfreezing and reading
+ * the limited events as small and consistent as possible.
+ * Therefore, if any limited events are in use, we read them
+ * both, and always in the same order, to minimize variability,
+ * and do it inside the same asm that writes MMCR0.
+ */
+static void write_mmcr0(struct cpu_hw_events *cpuhw, unsigned long mmcr0)
+{
+	unsigned long pmc5, pmc6;
+
+	if (!cpuhw->n_limited) {
+		mtspr(SPRN_MMCR0, mmcr0);
+		return;
+	}
+
+	/*
+	 * Write MMCR0, then read PMC5 and PMC6 immediately.
+	 * To ensure we don't get a performance monitor interrupt
+	 * between writing MMCR0 and freezing/thawing the limited
+	 * events, we first write MMCR0 with the event overflow
+	 * interrupt enable bits turned off.
+	 */
+	asm volatile("mtspr %3,%2; mfspr %0,%4; mfspr %1,%5"
+		     : "=&r" (pmc5), "=&r" (pmc6)
+		     : "r" (mmcr0 & ~(MMCR0_PMC1CE | MMCR0_PMCjCE)),
+		       "i" (SPRN_MMCR0),
+		       "i" (SPRN_PMC5), "i" (SPRN_PMC6));
+
+	if (mmcr0 & MMCR0_FC)
+		freeze_limited_counters(cpuhw, pmc5, pmc6);
+	else
+		thaw_limited_counters(cpuhw, pmc5, pmc6);
+
+	/*
+	 * Write the full MMCR0 including the event overflow interrupt
+	 * enable bits, if necessary.
+	 */
+	if (mmcr0 & (MMCR0_PMC1CE | MMCR0_PMCjCE))
+		mtspr(SPRN_MMCR0, mmcr0);
+}
+
+/*
+ * Disable all events to prevent PMU interrupts and to allow
+ * events to be added or removed.
+ */
+static void power_pmu_disable(struct pmu *pmu)
+{
+	struct cpu_hw_events *cpuhw;
+	unsigned long flags;
+
+	if (!ppmu)
+		return;
+	local_irq_save(flags);
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	if (!cpuhw->disabled) {
+		cpuhw->disabled = 1;
+		cpuhw->n_added = 0;
+
+		/*
+		 * Check if we ever enabled the PMU on this cpu.
+		 */
+		if (!cpuhw->pmcs_enabled) {
+			ppc_enable_pmcs();
+			cpuhw->pmcs_enabled = 1;
+		}
+
+		/*
+		 * Disable instruction sampling if it was enabled
+		 */
+		if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
+			mtspr(SPRN_MMCRA,
+			      cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
+			mb();
+		}
+
+		/*
+		 * Set the 'freeze counters' bit.
+		 * The barrier is to make sure the mtspr has been
+		 * executed and the PMU has frozen the events
+		 * before we return.
+		 */
+		write_mmcr0(cpuhw, mfspr(SPRN_MMCR0) | MMCR0_FC);
+		mb();
+	}
+	local_irq_restore(flags);
+}
+
+/*
+ * Re-enable all events if disable == 0.
+ * If we were previously disabled and events were added, then
+ * put the new config on the PMU.
+ */
+static void power_pmu_enable(struct pmu *pmu)
+{
+	struct perf_event *event;
+	struct cpu_hw_events *cpuhw;
+	unsigned long flags;
+	long i;
+	unsigned long val;
+	s64 left;
+	unsigned int hwc_index[MAX_HWEVENTS];
+	int n_lim;
+	int idx;
+
+	if (!ppmu)
+		return;
+	local_irq_save(flags);
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+	if (!cpuhw->disabled) {
+		local_irq_restore(flags);
+		return;
+	}
+	cpuhw->disabled = 0;
+
+	/*
+	 * If we didn't change anything, or only removed events,
+	 * no need to recalculate MMCR* settings and reset the PMCs.
+	 * Just reenable the PMU with the current MMCR* settings
+	 * (possibly updated for removal of events).
+	 */
+	if (!cpuhw->n_added) {
+		mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
+		mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
+		if (cpuhw->n_events == 0)
+			ppc_set_pmu_inuse(0);
+		goto out_enable;
+	}
+
+	/*
+	 * Compute MMCR* values for the new set of events
+	 */
+	if (ppmu->compute_mmcr(cpuhw->events, cpuhw->n_events, hwc_index,
+			       cpuhw->mmcr)) {
+		/* shouldn't ever get here */
+		printk(KERN_ERR "oops compute_mmcr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Add in MMCR0 freeze bits corresponding to the
+	 * attr.exclude_* bits for the first event.
+	 * We have already checked that all events have the
+	 * same values for these bits as the first event.
+	 */
+	event = cpuhw->event[0];
+	if (event->attr.exclude_user)
+		cpuhw->mmcr[0] |= MMCR0_FCP;
+	if (event->attr.exclude_kernel)
+		cpuhw->mmcr[0] |= freeze_events_kernel;
+	if (event->attr.exclude_hv)
+		cpuhw->mmcr[0] |= MMCR0_FCHV;
+
+	/*
+	 * Write the new configuration to MMCR* with the freeze
+	 * bit set and set the hardware events to their initial values.
+	 * Then unfreeze the events.
+	 */
+	ppc_set_pmu_inuse(1);
+	mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
+	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
+	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
+				| MMCR0_FC);
+
+	/*
+	 * Read off any pre-existing events that need to move
+	 * to another PMC.
+	 */
+	for (i = 0; i < cpuhw->n_events; ++i) {
+		event = cpuhw->event[i];
+		if (event->hw.idx && event->hw.idx != hwc_index[i] + 1) {
+			power_pmu_read(event);
+			write_pmc(event->hw.idx, 0);
+			event->hw.idx = 0;
+		}
+	}
+
+	/*
+	 * Initialize the PMCs for all the new and moved events.
+	 */
+	cpuhw->n_limited = n_lim = 0;
+	for (i = 0; i < cpuhw->n_events; ++i) {
+		event = cpuhw->event[i];
+		if (event->hw.idx)
+			continue;
+		idx = hwc_index[i] + 1;
+		if (is_limited_pmc(idx)) {
+			cpuhw->limited_counter[n_lim] = event;
+			cpuhw->limited_hwidx[n_lim] = idx;
+			++n_lim;
+			continue;
+		}
+		val = 0;
+		if (event->hw.sample_period) {
+			left = local64_read(&event->hw.period_left);
+			if (left < 0x80000000L)
+				val = 0x80000000L - left;
+		}
+		local64_set(&event->hw.prev_count, val);
+		event->hw.idx = idx;
+		if (event->hw.state & PERF_HES_STOPPED)
+			val = 0;
+		write_pmc(idx, val);
+		perf_event_update_userpage(event);
+	}
+	cpuhw->n_limited = n_lim;
+	cpuhw->mmcr[0] |= MMCR0_PMXE | MMCR0_FCECE;
+
+ out_enable:
+	mb();
+	write_mmcr0(cpuhw, cpuhw->mmcr[0]);
+
+	/*
+	 * Enable instruction sampling if necessary
+	 */
+	if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
+		mb();
+		mtspr(SPRN_MMCRA, cpuhw->mmcr[2]);
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+
+static int collect_events(struct perf_event *group, int max_count,
+			  struct perf_event *ctrs[], u64 *events,
+			  unsigned int *flags)
+{
+	int n = 0;
+	struct perf_event *event;
+
+	if (!is_software_event(group)) {
+		if (n >= max_count)
+			return -1;
+		ctrs[n] = group;
+		flags[n] = group->hw.event_base;
+		events[n++] = group->hw.config;
+	}
+	list_for_each_entry(event, &group->sibling_list, group_entry) {
+		if (!is_software_event(event) &&
+		    event->state != PERF_EVENT_STATE_OFF) {
+			if (n >= max_count)
+				return -1;
+			ctrs[n] = event;
+			flags[n] = event->hw.event_base;
+			events[n++] = event->hw.config;
+		}
+	}
+	return n;
+}
+
+/*
+ * Add a event to the PMU.
+ * If all events are not already frozen, then we disable and
+ * re-enable the PMU in order to get hw_perf_enable to do the
+ * actual work of reconfiguring the PMU.
+ */
+static int power_pmu_add(struct perf_event *event, int ef_flags)
+{
+	struct cpu_hw_events *cpuhw;
+	unsigned long flags;
+	int n0;
+	int ret = -EAGAIN;
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	/*
+	 * Add the event to the list (if there is room)
+	 * and check whether the total set is still feasible.
+	 */
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+	n0 = cpuhw->n_events;
+	if (n0 >= ppmu->n_counter)
+		goto out;
+	cpuhw->event[n0] = event;
+	cpuhw->events[n0] = event->hw.config;
+	cpuhw->flags[n0] = event->hw.event_base;
+
+	if (!(ef_flags & PERF_EF_START))
+		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	/*
+	 * If group events scheduling transaction was started,
+	 * skip the schedulability test here, it will be performed
+	 * at commit time(->commit_txn) as a whole
+	 */
+	if (cpuhw->group_flag & PERF_EVENT_TXN)
+		goto nocheck;
+
+	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
+		goto out;
+	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
+		goto out;
+	event->hw.config = cpuhw->events[n0];
+
+nocheck:
+	++cpuhw->n_events;
+	++cpuhw->n_added;
+
+	ret = 0;
+ out:
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+	return ret;
+}
+
+/*
+ * Remove a event from the PMU.
+ */
+static void power_pmu_del(struct perf_event *event, int ef_flags)
+{
+	struct cpu_hw_events *cpuhw;
+	long i;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	power_pmu_read(event);
+
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+	for (i = 0; i < cpuhw->n_events; ++i) {
+		if (event == cpuhw->event[i]) {
+			while (++i < cpuhw->n_events) {
+				cpuhw->event[i-1] = cpuhw->event[i];
+				cpuhw->events[i-1] = cpuhw->events[i];
+				cpuhw->flags[i-1] = cpuhw->flags[i];
+			}
+			--cpuhw->n_events;
+			ppmu->disable_pmc(event->hw.idx - 1, cpuhw->mmcr);
+			if (event->hw.idx) {
+				write_pmc(event->hw.idx, 0);
+				event->hw.idx = 0;
+			}
+			perf_event_update_userpage(event);
+			break;
+		}
+	}
+	for (i = 0; i < cpuhw->n_limited; ++i)
+		if (event == cpuhw->limited_counter[i])
+			break;
+	if (i < cpuhw->n_limited) {
+		while (++i < cpuhw->n_limited) {
+			cpuhw->limited_counter[i-1] = cpuhw->limited_counter[i];
+			cpuhw->limited_hwidx[i-1] = cpuhw->limited_hwidx[i];
+		}
+		--cpuhw->n_limited;
+	}
+	if (cpuhw->n_events == 0) {
+		/* disable exceptions if no events are running */
+		cpuhw->mmcr[0] &= ~(MMCR0_PMXE | MMCR0_FCECE);
+	}
+
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+}
+
+/*
+ * POWER-PMU does not support disabling individual counters, hence
+ * program their cycle counter to their max value and ignore the interrupts.
+ */
+
+static void power_pmu_start(struct perf_event *event, int ef_flags)
+{
+	unsigned long flags;
+	s64 left;
+	unsigned long val;
+
+	if (!event->hw.idx || !event->hw.sample_period)
+		return;
+
+	if (!(event->hw.state & PERF_HES_STOPPED))
+		return;
+
+	if (ef_flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	event->hw.state = 0;
+	left = local64_read(&event->hw.period_left);
+
+	val = 0;
+	if (left < 0x80000000L)
+		val = 0x80000000L - left;
+
+	write_pmc(event->hw.idx, val);
+
+	perf_event_update_userpage(event);
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+}
+
+static void power_pmu_stop(struct perf_event *event, int ef_flags)
+{
+	unsigned long flags;
+
+	if (!event->hw.idx || !event->hw.sample_period)
+		return;
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	power_pmu_read(event);
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	write_pmc(event->hw.idx, 0);
+
+	perf_event_update_userpage(event);
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+}
+
+/*
+ * Start group events scheduling transaction
+ * Set the flag to make pmu::enable() not perform the
+ * schedulability test, it will be performed at commit time
+ */
+void power_pmu_start_txn(struct pmu *pmu)
+{
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	perf_pmu_disable(pmu);
+	cpuhw->group_flag |= PERF_EVENT_TXN;
+	cpuhw->n_txn_start = cpuhw->n_events;
+}
+
+/*
+ * Stop group events scheduling transaction
+ * Clear the flag and pmu::enable() will perform the
+ * schedulability test.
+ */
+void power_pmu_cancel_txn(struct pmu *pmu)
+{
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	cpuhw->group_flag &= ~PERF_EVENT_TXN;
+	perf_pmu_enable(pmu);
+}
+
+/*
+ * Commit group events scheduling transaction
+ * Perform the group schedulability test as a whole
+ * Return 0 if success
+ */
+int power_pmu_commit_txn(struct pmu *pmu)
+{
+	struct cpu_hw_events *cpuhw;
+	long i, n;
+
+	if (!ppmu)
+		return -EAGAIN;
+	cpuhw = &__get_cpu_var(cpu_hw_events);
+	n = cpuhw->n_events;
+	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
+		return -EAGAIN;
+	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
+	if (i < 0)
+		return -EAGAIN;
+
+	for (i = cpuhw->n_txn_start; i < n; ++i)
+		cpuhw->event[i]->hw.config = cpuhw->events[i];
+
+	cpuhw->group_flag &= ~PERF_EVENT_TXN;
+	perf_pmu_enable(pmu);
+	return 0;
+}
+
+/*
+ * Return 1 if we might be able to put event on a limited PMC,
+ * or 0 if not.
+ * A event can only go on a limited PMC if it counts something
+ * that a limited PMC can count, doesn't require interrupts, and
+ * doesn't exclude any processor mode.
+ */
+static int can_go_on_limited_pmc(struct perf_event *event, u64 ev,
+				 unsigned int flags)
+{
+	int n;
+	u64 alt[MAX_EVENT_ALTERNATIVES];
+
+	if (event->attr.exclude_user
+	    || event->attr.exclude_kernel
+	    || event->attr.exclude_hv
+	    || event->attr.sample_period)
+		return 0;
+
+	if (ppmu->limited_pmc_event(ev))
+		return 1;
+
+	/*
+	 * The requested event_id isn't on a limited PMC already;
+	 * see if any alternative code goes on a limited PMC.
+	 */
+	if (!ppmu->get_alternatives)
+		return 0;
+
+	flags |= PPMU_LIMITED_PMC_OK | PPMU_LIMITED_PMC_REQD;
+	n = ppmu->get_alternatives(ev, flags, alt);
+
+	return n > 0;
+}
+
+/*
+ * Find an alternative event_id that goes on a normal PMC, if possible,
+ * and return the event_id code, or 0 if there is no such alternative.
+ * (Note: event_id code 0 is "don't count" on all machines.)
+ */
+static u64 normal_pmc_alternative(u64 ev, unsigned long flags)
+{
+	u64 alt[MAX_EVENT_ALTERNATIVES];
+	int n;
+
+	flags &= ~(PPMU_LIMITED_PMC_OK | PPMU_LIMITED_PMC_REQD);
+	n = ppmu->get_alternatives(ev, flags, alt);
+	if (!n)
+		return 0;
+	return alt[0];
+}
+
+/* Number of perf_events counting hardware events */
+static atomic_t num_events;
+/* Used to avoid races in calling reserve/release_pmc_hardware */
+static DEFINE_MUTEX(pmc_reserve_mutex);
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
+static int power_pmu_event_init(struct perf_event *event)
+{
+	u64 ev;
+	unsigned long flags;
+	struct perf_event *ctrs[MAX_HWEVENTS];
+	u64 events[MAX_HWEVENTS];
+	unsigned int cflags[MAX_HWEVENTS];
+	int n;
+	int err;
+	struct cpu_hw_events *cpuhw;
+
+	if (!ppmu)
+		return -ENOENT;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		ev = event->attr.config;
+		if (ev >= ppmu->n_generic || ppmu->generic_events[ev] == 0)
+			return -EOPNOTSUPP;
+		ev = ppmu->generic_events[ev];
+		break;
+	case PERF_TYPE_HW_CACHE:
+		err = hw_perf_cache_event(event->attr.config, &ev);
+		if (err)
+			return err;
+		break;
+	case PERF_TYPE_RAW:
+		ev = event->attr.config;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	event->hw.config_base = ev;
+	event->hw.idx = 0;
+
+	/*
+	 * If we are not running on a hypervisor, force the
+	 * exclude_hv bit to 0 so that we don't care what
+	 * the user set it to.
+	 */
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		event->attr.exclude_hv = 0;
+
+	/*
+	 * If this is a per-task event, then we can use
+	 * PM_RUN_* events interchangeably with their non RUN_*
+	 * equivalents, e.g. PM_RUN_CYC instead of PM_CYC.
+	 * XXX we should check if the task is an idle task.
+	 */
+	flags = 0;
+	if (event->attach_state & PERF_ATTACH_TASK)
+		flags |= PPMU_ONLY_COUNT_RUN;
+
+	/*
+	 * If this machine has limited events, check whether this
+	 * event_id could go on a limited event.
+	 */
+	if (ppmu->flags & PPMU_LIMITED_PMC5_6) {
+		if (can_go_on_limited_pmc(event, ev, flags)) {
+			flags |= PPMU_LIMITED_PMC_OK;
+		} else if (ppmu->limited_pmc_event(ev)) {
+			/*
+			 * The requested event_id is on a limited PMC,
+			 * but we can't use a limited PMC; see if any
+			 * alternative goes on a normal PMC.
+			 */
+			ev = normal_pmc_alternative(ev, flags);
+			if (!ev)
+				return -EINVAL;
+		}
+	}
+
+	/*
+	 * If this is in a group, check if it can go on with all the
+	 * other hardware events in the group.  We assume the event
+	 * hasn't been linked into its leader's sibling list at this point.
+	 */
+	n = 0;
+	if (event->group_leader != event) {
+		n = collect_events(event->group_leader, ppmu->n_counter - 1,
+				   ctrs, events, cflags);
+		if (n < 0)
+			return -EINVAL;
+	}
+	events[n] = ev;
+	ctrs[n] = event;
+	cflags[n] = flags;
+	if (check_excludes(ctrs, cflags, n, 1))
+		return -EINVAL;
+
+	cpuhw = &get_cpu_var(cpu_hw_events);
+	err = power_check_constraints(cpuhw, events, cflags, n + 1);
+	put_cpu_var(cpu_hw_events);
+	if (err)
+		return -EINVAL;
+
+	event->hw.config = events[n];
+	event->hw.event_base = cflags[n];
+	event->hw.last_period = event->hw.sample_period;
+	local64_set(&event->hw.period_left, event->hw.last_period);
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
+	}
+	event->destroy = hw_perf_event_destroy;
+
+	return err;
+}
+
+struct pmu power_pmu = {
+	.pmu_enable	= power_pmu_enable,
+	.pmu_disable	= power_pmu_disable,
+	.event_init	= power_pmu_event_init,
+	.add		= power_pmu_add,
+	.del		= power_pmu_del,
+	.start		= power_pmu_start,
+	.stop		= power_pmu_stop,
+	.read		= power_pmu_read,
+	.start_txn	= power_pmu_start_txn,
+	.cancel_txn	= power_pmu_cancel_txn,
+	.commit_txn	= power_pmu_commit_txn,
+};
+
+/*
+ * A counter has overflowed; update its count and record
+ * things if requested.  Note that interrupts are hard-disabled
+ * here so there is no possibility of being interrupted.
+ */
+static void record_and_restart(struct perf_event *event, unsigned long val,
+			       struct pt_regs *regs)
+{
+	u64 period = event->hw.sample_period;
+	s64 prev, delta, left;
+	int record = 0;
+
+	if (event->hw.state & PERF_HES_STOPPED) {
+		write_pmc(event->hw.idx, 0);
+		return;
+	}
+
+	/* we don't have to worry about interrupts here */
+	prev = local64_read(&event->hw.prev_count);
+	delta = check_and_compute_delta(prev, val);
+	local64_add(delta, &event->count);
+
+	/*
+	 * See if the total period for this event has expired,
+	 * and update for the next period.
+	 */
+	val = 0;
+	left = local64_read(&event->hw.period_left) - delta;
+	if (period) {
+		if (left <= 0) {
+			left += period;
+			if (left <= 0)
+				left = period;
+			record = 1;
+			event->hw.last_period = event->hw.sample_period;
+		}
+		if (left < 0x80000000LL)
+			val = 0x80000000LL - left;
+	}
+
+	write_pmc(event->hw.idx, val);
+	local64_set(&event->hw.prev_count, val);
+	local64_set(&event->hw.period_left, left);
+	perf_event_update_userpage(event);
+
+	/*
+	 * Finally record data if requested.
+	 */
+	if (record) {
+		struct perf_sample_data data;
+
+		perf_sample_data_init(&data, ~0ULL);
+		data.period = event->hw.last_period;
+
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
+			perf_get_data_addr(regs, &data.addr);
+
+		if (perf_event_overflow(event, &data, regs))
+			power_pmu_stop(event, 0);
+	}
+}
+
+/*
+ * Called from generic code to get the misc flags (i.e. processor mode)
+ * for an event_id.
+ */
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	u32 flags = perf_get_misc_flags(regs);
+
+	if (flags)
+		return flags;
+	return user_mode(regs) ? PERF_RECORD_MISC_USER :
+		PERF_RECORD_MISC_KERNEL;
+}
+
+/*
+ * Called from generic code to get the instruction pointer
+ * for an event_id.
+ */
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	unsigned long ip;
+
+	if (TRAP(regs) != 0xf00)
+		return regs->nip;	/* not a PMU interrupt */
+
+	ip = mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
+	return ip;
+}
+
+static bool pmc_overflow(unsigned long val)
+{
+	if ((int)val < 0)
+		return true;
+
+	/*
+	 * Events on POWER7 can roll back if a speculative event doesn't
+	 * eventually complete. Unfortunately in some rare cases they will
+	 * raise a performance monitor exception. We need to catch this to
+	 * ensure we reset the PMC. In all cases the PMC will be 256 or less
+	 * cycles from overflow.
+	 *
+	 * We only do this if the first pass fails to find any overflowing
+	 * PMCs because a user might set a period of less than 256 and we
+	 * don't want to mistakenly reset them.
+	 */
+	if (__is_processor(PV_POWER7) && ((0x80000000 - val) <= 256))
+		return true;
+
+	return false;
+}
+
+/*
+ * Performance monitor interrupt stuff
+ */
+static void perf_event_interrupt(struct pt_regs *regs)
+{
+	int i;
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+	struct perf_event *event;
+	unsigned long val;
+	int found = 0;
+	int nmi;
+
+	if (cpuhw->n_limited)
+		freeze_limited_counters(cpuhw, mfspr(SPRN_PMC5),
+					mfspr(SPRN_PMC6));
+
+	perf_read_regs(regs);
+
+	nmi = perf_intr_is_nmi(regs);
+	if (nmi)
+		nmi_enter();
+	else
+		irq_enter();
+
+	for (i = 0; i < cpuhw->n_events; ++i) {
+		event = cpuhw->event[i];
+		if (!event->hw.idx || is_limited_pmc(event->hw.idx))
+			continue;
+		val = read_pmc(event->hw.idx);
+		if ((int)val < 0) {
+			/* event has overflowed */
+			found = 1;
+			record_and_restart(event, val, regs);
+		}
+	}
+
+	/*
+	 * In case we didn't find and reset the event that caused
+	 * the interrupt, scan all events and reset any that are
+	 * negative, to avoid getting continual interrupts.
+	 * Any that we processed in the previous loop will not be negative.
+	 */
+	if (!found) {
+		for (i = 0; i < ppmu->n_counter; ++i) {
+			if (is_limited_pmc(i + 1))
+				continue;
+			val = read_pmc(i + 1);
+			if (pmc_overflow(val))
+				write_pmc(i + 1, 0);
+		}
+	}
+
+	/*
+	 * Reset MMCR0 to its normal value.  This will set PMXE and
+	 * clear FC (freeze counters) and PMAO (perf mon alert occurred)
+	 * and thus allow interrupts to occur again.
+	 * XXX might want to use MSR.PM to keep the events frozen until
+	 * we get back out of this interrupt.
+	 */
+	write_mmcr0(cpuhw, cpuhw->mmcr[0]);
+
+	if (nmi)
+		nmi_exit();
+	else
+		irq_exit();
+}
+
+static void power_pmu_setup(int cpu)
+{
+	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
+
+	if (!ppmu)
+		return;
+	memset(cpuhw, 0, sizeof(*cpuhw));
+	cpuhw->mmcr[0] = MMCR0_FC;
+}
+
+static int __cpuinit
+power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_UP_PREPARE:
+		power_pmu_setup(cpu);
+		break;
+
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+int __cpuinit register_power_pmu(struct power_pmu *pmu)
+{
+	if (ppmu)
+		return -EBUSY;		/* something's already registered */
+
+	ppmu = pmu;
+	pr_info("%s performance monitor hardware support registered\n",
+		pmu->name);
+
+#ifdef MSR_HV
+	/*
+	 * Use FCHV to ignore kernel events if MSR.HV is set.
+	 */
+	if (mfmsr() & MSR_HV)
+		freeze_events_kernel = MMCR0_FCHV;
+#endif /* CONFIG_PPC64 */
+
+	perf_pmu_register(&power_pmu, "cpu", PERF_TYPE_RAW);
+	perf_cpu_notifier(power_pmu_notifier);
+
+	return 0;
+}
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
new file mode 100644
index 0000000..0a6d2a9
--- /dev/null
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -0,0 +1,688 @@
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
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	/*
+	 * Performance monitor interrupts come even when interrupts
+	 * are soft-disabled, as long as interrupts are hard-enabled.
+	 * Therefore we treat them like NMIs.
+	 */
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		barrier();
+		val = read_pmc(event->hw.idx);
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
+
+	/* The counters are only 32 bits wide */
+	delta = (val - prev) & 0xfffffffful;
+	local64_add(delta, &event->count);
+	local64_sub(delta, &event->hw.period_left);
+}
+
+/*
+ * Disable all events to prevent PMU interrupts and to allow
+ * events to be added or removed.
+ */
+static void fsl_emb_pmu_disable(struct pmu *pmu)
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
+static void fsl_emb_pmu_enable(struct pmu *pmu)
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
+/* context locked on entry */
+static int fsl_emb_pmu_add(struct perf_event *event, int flags)
+{
+	struct cpu_hw_events *cpuhw;
+	int ret = -EAGAIN;
+	int num_counters = ppmu->n_counter;
+	u64 val;
+	int i;
+
+	perf_pmu_disable(event->pmu);
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
+		s64 left = local64_read(&event->hw.period_left);
+		if (left < 0x80000000L)
+			val = 0x80000000L - left;
+	}
+	local64_set(&event->hw.prev_count, val);
+
+	if (!(flags & PERF_EF_START)) {
+		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+		val = 0;
+	}
+
+	write_pmc(i, val);
+	perf_event_update_userpage(event);
+
+	write_pmlcb(i, event->hw.config >> 32);
+	write_pmlca(i, event->hw.config_base);
+
+	ret = 0;
+ out:
+	put_cpu_var(cpu_hw_events);
+	perf_pmu_enable(event->pmu);
+	return ret;
+}
+
+/* context locked on entry */
+static void fsl_emb_pmu_del(struct perf_event *event, int flags)
+{
+	struct cpu_hw_events *cpuhw;
+	int i = event->hw.idx;
+
+	perf_pmu_disable(event->pmu);
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
+	perf_pmu_enable(event->pmu);
+	put_cpu_var(cpu_hw_events);
+}
+
+static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)
+{
+	unsigned long flags;
+	s64 left;
+
+	if (event->hw.idx < 0 || !event->hw.sample_period)
+		return;
+
+	if (!(event->hw.state & PERF_HES_STOPPED))
+		return;
+
+	if (ef_flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	event->hw.state = 0;
+	left = local64_read(&event->hw.period_left);
+	write_pmc(event->hw.idx, left);
+
+	perf_event_update_userpage(event);
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+}
+
+static void fsl_emb_pmu_stop(struct perf_event *event, int ef_flags)
+{
+	unsigned long flags;
+
+	if (event->hw.idx < 0 || !event->hw.sample_period)
+		return;
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	local_irq_save(flags);
+	perf_pmu_disable(event->pmu);
+
+	fsl_emb_pmu_read(event);
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	write_pmc(event->hw.idx, 0);
+
+	perf_event_update_userpage(event);
+	perf_pmu_enable(event->pmu);
+	local_irq_restore(flags);
+}
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
+static int fsl_emb_pmu_event_init(struct perf_event *event)
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
+			return -EOPNOTSUPP;
+		ev = ppmu->generic_events[ev];
+		break;
+
+	case PERF_TYPE_HW_CACHE:
+		err = hw_perf_cache_event(event->attr.config, &ev);
+		if (err)
+			return err;
+		break;
+
+	case PERF_TYPE_RAW:
+		ev = event->attr.config;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	event->hw.config = ppmu->xlate_event(ev);
+	if (!(event->hw.config & FSL_EMB_EVENT_VALID))
+		return -EINVAL;
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
+			return -EINVAL;
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
+			return -EINVAL;
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
+		return -ENOTSUPP;
+
+	event->hw.last_period = event->hw.sample_period;
+	local64_set(&event->hw.period_left, event->hw.last_period);
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
+	return err;
+}
+
+static struct pmu fsl_emb_pmu = {
+	.pmu_enable	= fsl_emb_pmu_enable,
+	.pmu_disable	= fsl_emb_pmu_disable,
+	.event_init	= fsl_emb_pmu_event_init,
+	.add		= fsl_emb_pmu_add,
+	.del		= fsl_emb_pmu_del,
+	.start		= fsl_emb_pmu_start,
+	.stop		= fsl_emb_pmu_stop,
+	.read		= fsl_emb_pmu_read,
+};
+
+/*
+ * A counter has overflowed; update its count and record
+ * things if requested.  Note that interrupts are hard-disabled
+ * here so there is no possibility of being interrupted.
+ */
+static void record_and_restart(struct perf_event *event, unsigned long val,
+			       struct pt_regs *regs)
+{
+	u64 period = event->hw.sample_period;
+	s64 prev, delta, left;
+	int record = 0;
+
+	if (event->hw.state & PERF_HES_STOPPED) {
+		write_pmc(event->hw.idx, 0);
+		return;
+	}
+
+	/* we don't have to worry about interrupts here */
+	prev = local64_read(&event->hw.prev_count);
+	delta = (val - prev) & 0xfffffffful;
+	local64_add(delta, &event->count);
+
+	/*
+	 * See if the total period for this event has expired,
+	 * and update for the next period.
+	 */
+	val = 0;
+	left = local64_read(&event->hw.period_left) - delta;
+	if (period) {
+		if (left <= 0) {
+			left += period;
+			if (left <= 0)
+				left = period;
+			record = 1;
+			event->hw.last_period = event->hw.sample_period;
+		}
+		if (left < 0x80000000LL)
+			val = 0x80000000LL - left;
+	}
+
+	write_pmc(event->hw.idx, val);
+	local64_set(&event->hw.prev_count, val);
+	local64_set(&event->hw.period_left, left);
+	perf_event_update_userpage(event);
+
+	/*
+	 * Finally record data if requested.
+	 */
+	if (record) {
+		struct perf_sample_data data;
+
+		perf_sample_data_init(&data, 0);
+		data.period = event->hw.last_period;
+
+		if (perf_event_overflow(event, &data, regs))
+			fsl_emb_pmu_stop(event, 0);
+	}
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
+				record_and_restart(event, val, regs);
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
+	perf_pmu_register(&fsl_emb_pmu, "cpu", PERF_TYPE_RAW);
+
+	return 0;
+}
diff --git a/arch/powerpc/perf/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
new file mode 100644
index 0000000..cb2e294
--- /dev/null
+++ b/arch/powerpc/perf/e500-pmu.c
@@ -0,0 +1,134 @@
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
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1 	},
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
+early_initcall(init_e500_pmu);
diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
new file mode 100644
index 0000000..fe21b51
--- /dev/null
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -0,0 +1,422 @@
+/*
+ * Performance counter support for MPC7450-family processors.
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
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
+#define N_COUNTER	6	/* Number of hardware counters */
+#define MAX_ALT		3	/* Maximum number of event alternative codes */
+
+/*
+ * Bits in event code for MPC7450 family
+ */
+#define PM_THRMULT_MSKS	0x40000
+#define PM_THRESH_SH	12
+#define PM_THRESH_MSK	0x3f
+#define PM_PMC_SH	8
+#define PM_PMC_MSK	7
+#define PM_PMCSEL_MSK	0x7f
+
+/*
+ * Classify events according to how specific their PMC requirements are.
+ * Result is:
+ *	0: can go on any PMC
+ *	1: can go on PMCs 1-4
+ *	2: can go on PMCs 1,2,4
+ *	3: can go on PMCs 1 or 2
+ *	4: can only go on one PMC
+ *	-1: event code is invalid
+ */
+#define N_CLASSES	5
+
+static int mpc7450_classify_event(u32 event)
+{
+	int pmc;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > N_COUNTER)
+			return -1;
+		return 4;
+	}
+	event &= PM_PMCSEL_MSK;
+	if (event <= 1)
+		return 0;
+	if (event <= 7)
+		return 1;
+	if (event <= 13)
+		return 2;
+	if (event <= 22)
+		return 3;
+	return -1;
+}
+
+/*
+ * Events using threshold and possible threshold scale:
+ *	code	scale?	name
+ *	11e	N	PM_INSTQ_EXCEED_CYC
+ *	11f	N	PM_ALTV_IQ_EXCEED_CYC
+ *	128	Y	PM_DTLB_SEARCH_EXCEED_CYC
+ *	12b	Y	PM_LD_MISS_EXCEED_L1_CYC
+ *	220	N	PM_CQ_EXCEED_CYC
+ *	30c	N	PM_GPR_RB_EXCEED_CYC
+ *	30d	?	PM_FPR_IQ_EXCEED_CYC ?
+ *	311	Y	PM_ITLB_SEARCH_EXCEED
+ *	410	N	PM_GPR_IQ_EXCEED_CYC
+ */
+
+/*
+ * Return use of threshold and threshold scale bits:
+ * 0 = uses neither, 1 = uses threshold, 2 = uses both
+ */
+static int mpc7450_threshold_use(u32 event)
+{
+	int pmc, sel;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	sel = event & PM_PMCSEL_MSK;
+	switch (pmc) {
+	case 1:
+		if (sel == 0x1e || sel == 0x1f)
+			return 1;
+		if (sel == 0x28 || sel == 0x2b)
+			return 2;
+		break;
+	case 2:
+		if (sel == 0x20)
+			return 1;
+		break;
+	case 3:
+		if (sel == 0xc || sel == 0xd)
+			return 1;
+		if (sel == 0x11)
+			return 2;
+		break;
+	case 4:
+		if (sel == 0x10)
+			return 1;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Layout of constraint bits:
+ * 33222222222211111111110000000000
+ * 10987654321098765432109876543210
+ *  |<    ><  > < > < ><><><><><><>
+ *  TS TV   G4   G3  G2P6P5P4P3P2P1
+ *
+ * P1 - P6
+ *	0 - 11: Count of events needing PMC1 .. PMC6
+ *
+ * G2
+ *	12 - 14: Count of events needing PMC1 or PMC2
+ *
+ * G3
+ *	16 - 18: Count of events needing PMC1, PMC2 or PMC4
+ *
+ * G4
+ *	20 - 23: Count of events needing PMC1, PMC2, PMC3 or PMC4
+ *
+ * TV
+ *	24 - 29: Threshold value requested
+ *
+ * TS
+ *	30: Threshold scale value requested
+ */
+
+static u32 pmcbits[N_COUNTER][2] = {
+	{ 0x00844002, 0x00111001 },	/* PMC1 mask, value: P1,G2,G3,G4 */
+	{ 0x00844008, 0x00111004 },	/* PMC2: P2,G2,G3,G4 */
+	{ 0x00800020, 0x00100010 },	/* PMC3: P3,G4 */
+	{ 0x00840080, 0x00110040 },	/* PMC4: P4,G3,G4 */
+	{ 0x00000200, 0x00000100 },	/* PMC5: P5 */
+	{ 0x00000800, 0x00000400 }	/* PMC6: P6 */
+};
+
+static u32 classbits[N_CLASSES - 1][2] = {
+	{ 0x00000000, 0x00000000 },	/* class 0: no constraint */
+	{ 0x00800000, 0x00100000 },	/* class 1: G4 */
+	{ 0x00040000, 0x00010000 },	/* class 2: G3 */
+	{ 0x00004000, 0x00001000 },	/* class 3: G2 */
+};
+
+static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
+				  unsigned long *valp)
+{
+	int pmc, class;
+	u32 mask, value;
+	int thresh, tuse;
+
+	class = mpc7450_classify_event(event);
+	if (class < 0)
+		return -1;
+	if (class == 4) {
+		pmc = ((unsigned int)event >> PM_PMC_SH) & PM_PMC_MSK;
+		mask  = pmcbits[pmc - 1][0];
+		value = pmcbits[pmc - 1][1];
+	} else {
+		mask  = classbits[class][0];
+		value = classbits[class][1];
+	}
+
+	tuse = mpc7450_threshold_use(event);
+	if (tuse) {
+		thresh = ((unsigned int)event >> PM_THRESH_SH) & PM_THRESH_MSK;
+		mask  |= 0x3f << 24;
+		value |= thresh << 24;
+		if (tuse == 2) {
+			mask |= 0x40000000;
+			if ((unsigned int)event & PM_THRMULT_MSKS)
+				value |= 0x40000000;
+		}
+	}
+
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+static const unsigned int event_alternatives[][MAX_ALT] = {
+	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
+	{ 0x418, 0x50f, 0x60f },	/* PM_SNOOP_RETRY */
+	{ 0x502, 0x602 },		/* PM_L2_HIT */
+	{ 0x503, 0x603 },		/* PM_L3_HIT */
+	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */
+	{ 0x505, 0x605 },		/* PM_L3_ICACHE_MISS */
+	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
+	{ 0x507, 0x607 },		/* PM_L3_DCACHE_MISS */
+	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
+	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
+	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
+	{ 0x50e, 0x60e },		/* PM_L3_TOUCH_HIT */
+	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
+	{ 0x513, 0x61d },		/* PM_L2_MISS */
+	{ 0x514, 0x61e },		/* PM_L3_MISS */
+};
+
+/*
+ * Scan the alternatives table for a match and return the
+ * index into the alternatives table if found, else -1.
+ */
+static int find_alternative(u32 event)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
+		if (event < event_alternatives[i][0])
+			break;
+		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
+			if (event == event_alternatives[i][j])
+				return i;
+	}
+	return -1;
+}
+
+static int mpc7450_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, nalt = 1;
+	u32 ae;
+
+	alt[0] = event;
+	nalt = 1;
+	i = find_alternative((u32)event);
+	if (i >= 0) {
+		for (j = 0; j < MAX_ALT; ++j) {
+			ae = event_alternatives[i][j];
+			if (ae && ae != (u32)event)
+				alt[nalt++] = ae;
+		}
+	}
+	return nalt;
+}
+
+/*
+ * Bitmaps of which PMCs each class can use for classes 0 - 3.
+ * Bit i is set if PMC i+1 is usable.
+ */
+static const u8 classmap[N_CLASSES] = {
+	0x3f, 0x0f, 0x0b, 0x03, 0
+};
+
+/* Bit position and width of each PMCSEL field */
+static const int pmcsel_shift[N_COUNTER] = {
+	6,	0,	27,	22,	17,	11
+};
+static const u32 pmcsel_mask[N_COUNTER] = {
+	0x7f,	0x3f,	0x1f,	0x1f,	0x1f,	0x3f
+};
+
+/*
+ * Compute MMCR0/1/2 values for a set of events.
+ */
+static int mpc7450_compute_mmcr(u64 event[], int n_ev,
+				unsigned int hwc[], unsigned long mmcr[])
+{
+	u8 event_index[N_CLASSES][N_COUNTER];
+	int n_classevent[N_CLASSES];
+	int i, j, class, tuse;
+	u32 pmc_inuse = 0, pmc_avail;
+	u32 mmcr0 = 0, mmcr1 = 0, mmcr2 = 0;
+	u32 ev, pmc, thresh;
+
+	if (n_ev > N_COUNTER)
+		return -1;
+
+	/* First pass: count usage in each class */
+	for (i = 0; i < N_CLASSES; ++i)
+		n_classevent[i] = 0;
+	for (i = 0; i < n_ev; ++i) {
+		class = mpc7450_classify_event(event[i]);
+		if (class < 0)
+			return -1;
+		j = n_classevent[class]++;
+		event_index[class][j] = i;
+	}
+
+	/* Second pass: allocate PMCs from most specific event to least */
+	for (class = N_CLASSES - 1; class >= 0; --class) {
+		for (i = 0; i < n_classevent[class]; ++i) {
+			ev = event[event_index[class][i]];
+			if (class == 4) {
+				pmc = (ev >> PM_PMC_SH) & PM_PMC_MSK;
+				if (pmc_inuse & (1 << (pmc - 1)))
+					return -1;
+			} else {
+				/* Find a suitable PMC */
+				pmc_avail = classmap[class] & ~pmc_inuse;
+				if (!pmc_avail)
+					return -1;
+				pmc = ffs(pmc_avail);
+			}
+			pmc_inuse |= 1 << (pmc - 1);
+
+			tuse = mpc7450_threshold_use(ev);
+			if (tuse) {
+				thresh = (ev >> PM_THRESH_SH) & PM_THRESH_MSK;
+				mmcr0 |= thresh << 16;
+				if (tuse == 2 && (ev & PM_THRMULT_MSKS))
+					mmcr2 = 0x80000000;
+			}
+			ev &= pmcsel_mask[pmc - 1];
+			ev <<= pmcsel_shift[pmc - 1];
+			if (pmc <= 2)
+				mmcr0 |= ev;
+			else
+				mmcr1 |= ev;
+			hwc[event_index[class][i]] = pmc - 1;
+		}
+	}
+
+	if (pmc_inuse & 1)
+		mmcr0 |= MMCR0_PMC1CE;
+	if (pmc_inuse & 0x3e)
+		mmcr0 |= MMCR0_PMCnCE;
+
+	/* Return MMCRx values */
+	mmcr[0] = mmcr0;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcr2;
+	return 0;
+}
+
+/*
+ * Disable counting by a PMC.
+ * Note that the pmc argument is 0-based here, not 1-based.
+ */
+static void mpc7450_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	if (pmc <= 1)
+		mmcr[0] &= ~(pmcsel_mask[pmc] << pmcsel_shift[pmc]);
+	else
+		mmcr[1] &= ~(pmcsel_mask[pmc] << pmcsel_shift[pmc]);
+}
+
+static int mpc7450_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 1,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 2,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x217, /* PM_L1_DCACHE_MISS */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x122, /* PM_BR_CMPL */
+	[PERF_COUNT_HW_BRANCH_MISSES] 		= 0x41c, /* PM_BR_MPRED */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x225	},
+		[C(OP_WRITE)] = {	0,		0x227	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x129,		0x115	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	0x634,		0	},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x312	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x223	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x122,		0x41c	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+struct power_pmu mpc7450_pmu = {
+	.name			= "MPC7450 family",
+	.n_counter		= N_COUNTER,
+	.max_alternatives	= MAX_ALT,
+	.add_fields		= 0x00111555ul,
+	.test_adder		= 0x00301000ul,
+	.compute_mmcr		= mpc7450_compute_mmcr,
+	.get_constraint		= mpc7450_get_constraint,
+	.get_alternatives	= mpc7450_get_alternatives,
+	.disable_pmc		= mpc7450_disable_pmc,
+	.n_generic		= ARRAY_SIZE(mpc7450_generic_events),
+	.generic_events		= mpc7450_generic_events,
+	.cache_events		= &mpc7450_cache_events,
+};
+
+static int __init init_mpc7450_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
+		return -ENODEV;
+
+	return register_power_pmu(&mpc7450_pmu);
+}
+
+early_initcall(init_mpc7450_pmu);
diff --git a/arch/powerpc/perf/power4-pmu.c b/arch/powerpc/perf/power4-pmu.c
new file mode 100644
index 0000000..b4f1dda
--- /dev/null
+++ b/arch/powerpc/perf/power4-pmu.c
@@ -0,0 +1,621 @@
+/*
+ * Performance counter support for POWER4 (GP) and POWER4+ (GQ) processors.
+ *
+ * Copyright 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Bits in event code for POWER4
+ */
+#define PM_PMC_SH	12	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0xf
+#define PM_UNIT_SH	8	/* TTMMUX number and setting - unit select */
+#define PM_UNIT_MSK	0xf
+#define PM_LOWER_SH	6
+#define PM_LOWER_MSK	1
+#define PM_LOWER_MSKS	0x40
+#define PM_BYTE_SH	4	/* Byte number of event bus to use */
+#define PM_BYTE_MSK	3
+#define PM_PMCSEL_MSK	7
+
+/*
+ * Unit code values
+ */
+#define PM_FPU		1
+#define PM_ISU1		2
+#define PM_IFU		3
+#define PM_IDU0		4
+#define PM_ISU1_ALT	6
+#define PM_ISU2		7
+#define PM_IFU_ALT	8
+#define PM_LSU0		9
+#define PM_LSU1		0xc
+#define PM_GPS		0xf
+
+/*
+ * Bits in MMCR0 for POWER4
+ */
+#define MMCR0_PMC1SEL_SH	8
+#define MMCR0_PMC2SEL_SH	1
+#define MMCR_PMCSEL_MSK		0x1f
+
+/*
+ * Bits in MMCR1 for POWER4
+ */
+#define MMCR1_TTM0SEL_SH	62
+#define MMCR1_TTC0SEL_SH	61
+#define MMCR1_TTM1SEL_SH	59
+#define MMCR1_TTC1SEL_SH	58
+#define MMCR1_TTM2SEL_SH	56
+#define MMCR1_TTC2SEL_SH	55
+#define MMCR1_TTM3SEL_SH	53
+#define MMCR1_TTC3SEL_SH	52
+#define MMCR1_TTMSEL_MSK	3
+#define MMCR1_TD_CP_DBG0SEL_SH	50
+#define MMCR1_TD_CP_DBG1SEL_SH	48
+#define MMCR1_TD_CP_DBG2SEL_SH	46
+#define MMCR1_TD_CP_DBG3SEL_SH	44
+#define MMCR1_DEBUG0SEL_SH	43
+#define MMCR1_DEBUG1SEL_SH	42
+#define MMCR1_DEBUG2SEL_SH	41
+#define MMCR1_DEBUG3SEL_SH	40
+#define MMCR1_PMC1_ADDER_SEL_SH	39
+#define MMCR1_PMC2_ADDER_SEL_SH	38
+#define MMCR1_PMC6_ADDER_SEL_SH	37
+#define MMCR1_PMC5_ADDER_SEL_SH	36
+#define MMCR1_PMC8_ADDER_SEL_SH	35
+#define MMCR1_PMC7_ADDER_SEL_SH	34
+#define MMCR1_PMC3_ADDER_SEL_SH	33
+#define MMCR1_PMC4_ADDER_SEL_SH	32
+#define MMCR1_PMC3SEL_SH	27
+#define MMCR1_PMC4SEL_SH	22
+#define MMCR1_PMC5SEL_SH	17
+#define MMCR1_PMC6SEL_SH	12
+#define MMCR1_PMC7SEL_SH	7
+#define MMCR1_PMC8SEL_SH	2	/* note bit 0 is in MMCRA for GP */
+
+static short mmcr1_adder_bits[8] = {
+	MMCR1_PMC1_ADDER_SEL_SH,
+	MMCR1_PMC2_ADDER_SEL_SH,
+	MMCR1_PMC3_ADDER_SEL_SH,
+	MMCR1_PMC4_ADDER_SEL_SH,
+	MMCR1_PMC5_ADDER_SEL_SH,
+	MMCR1_PMC6_ADDER_SEL_SH,
+	MMCR1_PMC7_ADDER_SEL_SH,
+	MMCR1_PMC8_ADDER_SEL_SH
+};
+
+/*
+ * Bits in MMCRA
+ */
+#define MMCRA_PMC8SEL0_SH	17	/* PMC8SEL bit 0 for GP */
+
+/*
+ * Layout of constraint bits:
+ * 6666555555555544444444443333333333222222222211111111110000000000
+ * 3210987654321098765432109876543210987654321098765432109876543210
+ *        |[  >[  >[   >|||[  >[  ><  ><  ><  ><  ><><><><><><><><>
+ *        | UC1 UC2 UC3 ||| PS1 PS2 B0  B1  B2  B3 P1P2P3P4P5P6P7P8
+ * 	  \SMPL	        ||\TTC3SEL
+ * 		        |\TTC_IFU_SEL
+ * 		        \TTM2SEL0
+ *
+ * SMPL - SAMPLE_ENABLE constraint
+ *     56: SAMPLE_ENABLE value 0x0100_0000_0000_0000
+ *
+ * UC1 - unit constraint 1: can't have all three of FPU/ISU1/IDU0|ISU2
+ *     55: UC1 error 0x0080_0000_0000_0000
+ *     54: FPU events needed 0x0040_0000_0000_0000
+ *     53: ISU1 events needed 0x0020_0000_0000_0000
+ *     52: IDU0|ISU2 events needed 0x0010_0000_0000_0000
+ *
+ * UC2 - unit constraint 2: can't have all three of FPU/IFU/LSU0
+ *     51: UC2 error 0x0008_0000_0000_0000
+ *     50: FPU events needed 0x0004_0000_0000_0000
+ *     49: IFU events needed 0x0002_0000_0000_0000
+ *     48: LSU0 events needed 0x0001_0000_0000_0000
+ *
+ * UC3 - unit constraint 3: can't have all four of LSU0/IFU/IDU0|ISU2/ISU1
+ *     47: UC3 error 0x8000_0000_0000
+ *     46: LSU0 events needed 0x4000_0000_0000
+ *     45: IFU events needed 0x2000_0000_0000
+ *     44: IDU0|ISU2 events needed 0x1000_0000_0000
+ *     43: ISU1 events needed 0x0800_0000_0000
+ *
+ * TTM2SEL0
+ *     42: 0 = IDU0 events needed
+ *     	   1 = ISU2 events needed 0x0400_0000_0000
+ *
+ * TTC_IFU_SEL
+ *     41: 0 = IFU.U events needed
+ *     	   1 = IFU.L events needed 0x0200_0000_0000
+ *
+ * TTC3SEL
+ *     40: 0 = LSU1.U events needed
+ *     	   1 = LSU1.L events needed 0x0100_0000_0000
+ *
+ * PS1
+ *     39: PS1 error 0x0080_0000_0000
+ *     36-38: count of events needing PMC1/2/5/6 0x0070_0000_0000
+ *
+ * PS2
+ *     35: PS2 error 0x0008_0000_0000
+ *     32-34: count of events needing PMC3/4/7/8 0x0007_0000_0000
+ *
+ * B0
+ *     28-31: Byte 0 event source 0xf000_0000
+ *     	   1 = FPU
+ * 	   2 = ISU1
+ * 	   3 = IFU
+ * 	   4 = IDU0
+ * 	   7 = ISU2
+ * 	   9 = LSU0
+ * 	   c = LSU1
+ * 	   f = GPS
+ *
+ * B1, B2, B3
+ *     24-27, 20-23, 16-19: Byte 1, 2, 3 event sources
+ *
+ * P8
+ *     15: P8 error 0x8000
+ *     14-15: Count of events needing PMC8
+ *
+ * P1..P7
+ *     0-13: Count of events needing PMC1..PMC7
+ *
+ * Note: this doesn't allow events using IFU.U to be combined with events
+ * using IFU.L, though that is feasible (using TTM0 and TTM2).  However
+ * there are no listed events for IFU.L (they are debug events not
+ * verified for performance monitoring) so this shouldn't cause a
+ * problem.
+ */
+
+static struct unitinfo {
+	unsigned long	value, mask;
+	int		unit;
+	int		lowerbit;
+} p4_unitinfo[16] = {
+	[PM_FPU]  = { 0x44000000000000ul, 0x88000000000000ul, PM_FPU, 0 },
+	[PM_ISU1] = { 0x20080000000000ul, 0x88000000000000ul, PM_ISU1, 0 },
+	[PM_ISU1_ALT] =
+		    { 0x20080000000000ul, 0x88000000000000ul, PM_ISU1, 0 },
+	[PM_IFU]  = { 0x02200000000000ul, 0x08820000000000ul, PM_IFU, 41 },
+	[PM_IFU_ALT] =
+		    { 0x02200000000000ul, 0x08820000000000ul, PM_IFU, 41 },
+	[PM_IDU0] = { 0x10100000000000ul, 0x80840000000000ul, PM_IDU0, 1 },
+	[PM_ISU2] = { 0x10140000000000ul, 0x80840000000000ul, PM_ISU2, 0 },
+	[PM_LSU0] = { 0x01400000000000ul, 0x08800000000000ul, PM_LSU0, 0 },
+	[PM_LSU1] = { 0x00000000000000ul, 0x00010000000000ul, PM_LSU1, 40 },
+	[PM_GPS]  = { 0x00000000000000ul, 0x00000000000000ul, PM_GPS, 0 }
+};
+
+static unsigned char direct_marked_event[8] = {
+	(1<<2) | (1<<3),	/* PMC1: PM_MRK_GRP_DISP, PM_MRK_ST_CMPL */
+	(1<<3) | (1<<5),	/* PMC2: PM_THRESH_TIMEO, PM_MRK_BRU_FIN */
+	(1<<3),			/* PMC3: PM_MRK_ST_CMPL_INT */
+	(1<<4) | (1<<5),	/* PMC4: PM_MRK_GRP_CMPL, PM_MRK_CRU_FIN */
+	(1<<4) | (1<<5),	/* PMC5: PM_MRK_GRP_TIMEO */
+	(1<<3) | (1<<4) | (1<<5),
+		/* PMC6: PM_MRK_ST_GPS, PM_MRK_FXU_FIN, PM_MRK_GRP_ISSUED */
+	(1<<4) | (1<<5),	/* PMC7: PM_MRK_FPU_FIN, PM_MRK_INST_FIN */
+	(1<<4),			/* PMC8: PM_MRK_LSU_FIN */
+};
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int p4_marked_instr_event(u64 event)
+{
+	int pmc, psel, unit, byte, bit;
+	unsigned int mask;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = event & PM_PMCSEL_MSK;
+	if (pmc) {
+		if (direct_marked_event[pmc - 1] & (1 << psel))
+			return 1;
+		if (psel == 0)		/* add events */
+			bit = (pmc <= 4)? pmc - 1: 8 - pmc;
+		else if (psel == 6)	/* decode events */
+			bit = 4;
+		else
+			return 0;
+	} else
+		bit = psel;
+
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	mask = 0;
+	switch (unit) {
+	case PM_LSU1:
+		if (event & PM_LOWER_MSKS)
+			mask = 1 << 28;		/* byte 7 bit 4 */
+		else
+			mask = 6 << 24;		/* byte 3 bits 1 and 2 */
+		break;
+	case PM_LSU0:
+		/* byte 3, bit 3; byte 2 bits 0,2,3,4,5; byte 1 */
+		mask = 0x083dff00;
+	}
+	return (mask >> (byte * 8 + bit)) & 1;
+}
+
+static int p4_get_constraint(u64 event, unsigned long *maskp,
+			     unsigned long *valp)
+{
+	int pmc, byte, unit, lower, sh;
+	unsigned long mask = 0, value = 0;
+	int grp = -1;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 8)
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+		grp = ((pmc - 1) >> 1) & 1;
+	}
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	if (unit) {
+		lower = (event >> PM_LOWER_SH) & PM_LOWER_MSK;
+
+		/*
+		 * Bus events on bytes 0 and 2 can be counted
+		 * on PMC1/2/5/6; bytes 1 and 3 on PMC3/4/7/8.
+		 */
+		if (!pmc)
+			grp = byte & 1;
+
+		if (!p4_unitinfo[unit].unit)
+			return -1;
+		mask  |= p4_unitinfo[unit].mask;
+		value |= p4_unitinfo[unit].value;
+		sh = p4_unitinfo[unit].lowerbit;
+		if (sh > 1)
+			value |= (unsigned long)lower << sh;
+		else if (lower != sh)
+			return -1;
+		unit = p4_unitinfo[unit].unit;
+
+		/* Set byte lane select field */
+		mask  |= 0xfULL << (28 - 4 * byte);
+		value |= (unsigned long)unit << (28 - 4 * byte);
+	}
+	if (grp == 0) {
+		/* increment PMC1/2/5/6 field */
+		mask  |= 0x8000000000ull;
+		value |= 0x1000000000ull;
+	} else {
+		/* increment PMC3/4/7/8 field */
+		mask  |= 0x800000000ull;
+		value |= 0x100000000ull;
+	}
+
+	/* Marked instruction events need sample_enable set */
+	if (p4_marked_instr_event(event)) {
+		mask  |= 1ull << 56;
+		value |= 1ull << 56;
+	}
+
+	/* PMCSEL=6 decode events on byte 2 need sample_enable clear */
+	if (pmc && (event & PM_PMCSEL_MSK) == 6 && byte == 2)
+		mask  |= 1ull << 56;
+
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+static unsigned int ppc_inst_cmpl[] = {
+	0x1001, 0x4001, 0x6001, 0x7001, 0x8001
+};
+
+static int p4_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, na;
+
+	alt[0] = event;
+	na = 1;
+
+	/* 2 possibilities for PM_GRP_DISP_REJECT */
+	if (event == 0x8003 || event == 0x0224) {
+		alt[1] = event ^ (0x8003 ^ 0x0224);
+		return 2;
+	}
+
+	/* 2 possibilities for PM_ST_MISS_L1 */
+	if (event == 0x0c13 || event == 0x0c23) {
+		alt[1] = event ^ (0x0c13 ^ 0x0c23);
+		return 2;
+	}
+
+	/* several possibilities for PM_INST_CMPL */
+	for (i = 0; i < ARRAY_SIZE(ppc_inst_cmpl); ++i) {
+		if (event == ppc_inst_cmpl[i]) {
+			for (j = 0; j < ARRAY_SIZE(ppc_inst_cmpl); ++j)
+				if (j != i)
+					alt[na++] = ppc_inst_cmpl[j];
+			break;
+		}
+	}
+
+	return na;
+}
+
+static int p4_compute_mmcr(u64 event[], int n_ev,
+			   unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
+	unsigned int pmc, unit, byte, psel, lower;
+	unsigned int ttm, grp;
+	unsigned int pmc_inuse = 0;
+	unsigned int pmc_grp_use[2];
+	unsigned char busbyte[4];
+	unsigned char unituse[16];
+	unsigned int unitlower = 0;
+	int i;
+
+	if (n_ev > 8)
+		return -1;
+
+	/* First pass to count resource use */
+	pmc_grp_use[0] = pmc_grp_use[1] = 0;
+	memset(busbyte, 0, sizeof(busbyte));
+	memset(unituse, 0, sizeof(unituse));
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;
+			pmc_inuse |= 1 << (pmc - 1);
+			/* count 1/2/5/6 vs 3/4/7/8 use */
+			++pmc_grp_use[((pmc - 1) >> 1) & 1];
+		}
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		lower = (event[i] >> PM_LOWER_SH) & PM_LOWER_MSK;
+		if (unit) {
+			if (!pmc)
+				++pmc_grp_use[byte & 1];
+			if (unit == 6 || unit == 8)
+				/* map alt ISU1/IFU codes: 6->2, 8->3 */
+				unit = (unit >> 1) - 1;
+			if (busbyte[byte] && busbyte[byte] != unit)
+				return -1;
+			busbyte[byte] = unit;
+			lower <<= unit;
+			if (unituse[unit] && lower != (unitlower & lower))
+				return -1;
+			unituse[unit] = 1;
+			unitlower |= lower;
+		}
+	}
+	if (pmc_grp_use[0] > 4 || pmc_grp_use[1] > 4)
+		return -1;
+
+	/*
+	 * Assign resources and set multiplexer selects.
+	 *
+	 * Units 1,2,3 are on TTM0, 4,6,7 on TTM1, 8,10 on TTM2.
+	 * Each TTMx can only select one unit, but since
+	 * units 2 and 6 are both ISU1, and 3 and 8 are both IFU,
+	 * we have some choices.
+	 */
+	if (unituse[2] & (unituse[1] | (unituse[3] & unituse[9]))) {
+		unituse[6] = 1;		/* Move 2 to 6 */
+		unituse[2] = 0;
+	}
+	if (unituse[3] & (unituse[1] | unituse[2])) {
+		unituse[8] = 1;		/* Move 3 to 8 */
+		unituse[3] = 0;
+		unitlower = (unitlower & ~8) | ((unitlower & 8) << 5);
+	}
+	/* Check only one unit per TTMx */
+	if (unituse[1] + unituse[2] + unituse[3] > 1 ||
+	    unituse[4] + unituse[6] + unituse[7] > 1 ||
+	    unituse[8] + unituse[9] > 1 ||
+	    (unituse[5] | unituse[10] | unituse[11] |
+	     unituse[13] | unituse[14]))
+		return -1;
+
+	/* Set TTMxSEL fields.  Note, units 1-3 => TTM0SEL codes 0-2 */
+	mmcr1 |= (unsigned long)(unituse[3] * 2 + unituse[2])
+		<< MMCR1_TTM0SEL_SH;
+	mmcr1 |= (unsigned long)(unituse[7] * 3 + unituse[6] * 2)
+		<< MMCR1_TTM1SEL_SH;
+	mmcr1 |= (unsigned long)unituse[9] << MMCR1_TTM2SEL_SH;
+
+	/* Set TTCxSEL fields. */
+	if (unitlower & 0xe)
+		mmcr1 |= 1ull << MMCR1_TTC0SEL_SH;
+	if (unitlower & 0xf0)
+		mmcr1 |= 1ull << MMCR1_TTC1SEL_SH;
+	if (unitlower & 0xf00)
+		mmcr1 |= 1ull << MMCR1_TTC2SEL_SH;
+	if (unitlower & 0x7000)
+		mmcr1 |= 1ull << MMCR1_TTC3SEL_SH;
+
+	/* Set byte lane select fields. */
+	for (byte = 0; byte < 4; ++byte) {
+		unit = busbyte[byte];
+		if (!unit)
+			continue;
+		if (unit == 0xf) {
+			/* special case for GPS */
+			mmcr1 |= 1ull << (MMCR1_DEBUG0SEL_SH - byte);
+		} else {
+			if (!unituse[unit])
+				ttm = unit - 1;		/* 2->1, 3->2 */
+			else
+				ttm = unit >> 2;
+			mmcr1 |= (unsigned long)ttm
+				<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
+		}
+	}
+
+	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		psel = event[i] & PM_PMCSEL_MSK;
+		if (!pmc) {
+			/* Bus event or 00xxx direct event (off or cycles) */
+			if (unit)
+				psel |= 0x10 | ((byte & 2) << 2);
+			for (pmc = 0; pmc < 8; ++pmc) {
+				if (pmc_inuse & (1 << pmc))
+					continue;
+				grp = (pmc >> 1) & 1;
+				if (unit) {
+					if (grp == (byte & 1))
+						break;
+				} else if (pmc_grp_use[grp] < 4) {
+					++pmc_grp_use[grp];
+					break;
+				}
+			}
+			pmc_inuse |= 1 << pmc;
+		} else {
+			/* Direct event */
+			--pmc;
+			if (psel == 0 && (byte & 2))
+				/* add events on higher-numbered bus */
+				mmcr1 |= 1ull << mmcr1_adder_bits[pmc];
+			else if (psel == 6 && byte == 3)
+				/* seem to need to set sample_enable here */
+				mmcra |= MMCRA_SAMPLE_ENABLE;
+			psel |= 8;
+		}
+		if (pmc <= 1)
+			mmcr0 |= psel << (MMCR0_PMC1SEL_SH - 7 * pmc);
+		else
+			mmcr1 |= psel << (MMCR1_PMC3SEL_SH - 5 * (pmc - 2));
+		if (pmc == 7)	/* PMC8 */
+			mmcra |= (psel & 1) << MMCRA_PMC8SEL0_SH;
+		hwc[i] = pmc;
+		if (p4_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+	}
+
+	if (pmc_inuse & 1)
+		mmcr0 |= MMCR0_PMC1CE;
+	if (pmc_inuse & 0xfe)
+		mmcr0 |= MMCR0_PMCjCE;
+
+	mmcra |= 0x2000;	/* mark only one IOP per PPC instruction */
+
+	/* Return MMCRx values */
+	mmcr[0] = mmcr0;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+static void p4_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	/*
+	 * Setting the PMCxSEL field to 0 disables PMC x.
+	 * (Note that pmc is 0-based here, not 1-based.)
+	 */
+	if (pmc <= 1) {
+		mmcr[0] &= ~(0x1fUL << (MMCR0_PMC1SEL_SH - 7 * pmc));
+	} else {
+		mmcr[1] &= ~(0x1fUL << (MMCR1_PMC3SEL_SH - 5 * (pmc - 2)));
+		if (pmc == 7)
+			mmcr[2] &= ~(1UL << MMCRA_PMC8SEL0_SH);
+	}
+}
+
+static int p4_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 7,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x1001,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x8c10, /* PM_LD_REF_L1 */
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c10, /* PM_LD_MISS_L1 */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x330,  /* PM_BR_ISSUED */
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x331,  /* PM_BR_MPRED_CR */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int power4_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x8c10,		0x3c10	},
+		[C(OP_WRITE)] = {	0x7c10,		0xc13	},
+		[C(OP_PREFETCH)] = {	0xc35,		0	},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0xc34,		0	},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x904	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x900	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x330,		0x331	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+static struct power_pmu power4_pmu = {
+	.name			= "POWER4/4+",
+	.n_counter		= 8,
+	.max_alternatives	= 5,
+	.add_fields		= 0x0000001100005555ul,
+	.test_adder		= 0x0011083300000000ul,
+	.compute_mmcr		= p4_compute_mmcr,
+	.get_constraint		= p4_get_constraint,
+	.get_alternatives	= p4_get_alternatives,
+	.disable_pmc		= p4_disable_pmc,
+	.n_generic		= ARRAY_SIZE(p4_generic_events),
+	.generic_events		= p4_generic_events,
+	.cache_events		= &power4_cache_events,
+};
+
+static int __init init_power4_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power4"))
+		return -ENODEV;
+
+	return register_power_pmu(&power4_pmu);
+}
+
+early_initcall(init_power4_pmu);
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
new file mode 100644
index 0000000..a8757ba
--- /dev/null
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -0,0 +1,690 @@
+/*
+ * Performance counter support for POWER5+/++ (not POWER5) processors.
+ *
+ * Copyright 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Bits in event code for POWER5+ (POWER5 GS) and POWER5++ (POWER5 GS DD3)
+ */
+#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0xf
+#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
+#define PM_UNIT_SH	16	/* TTMMUX number and setting - unit select */
+#define PM_UNIT_MSK	0xf
+#define PM_BYTE_SH	12	/* Byte number of event bus to use */
+#define PM_BYTE_MSK	7
+#define PM_GRS_SH	8	/* Storage subsystem mux select */
+#define PM_GRS_MSK	7
+#define PM_BUSEVENT_MSK	0x80	/* Set if event uses event bus */
+#define PM_PMCSEL_MSK	0x7f
+
+/* Values in PM_UNIT field */
+#define PM_FPU		0
+#define PM_ISU0		1
+#define PM_IFU		2
+#define PM_ISU1		3
+#define PM_IDU		4
+#define PM_ISU0_ALT	6
+#define PM_GRS		7
+#define PM_LSU0		8
+#define PM_LSU1		0xc
+#define PM_LASTUNIT	0xc
+
+/*
+ * Bits in MMCR1 for POWER5+
+ */
+#define MMCR1_TTM0SEL_SH	62
+#define MMCR1_TTM1SEL_SH	60
+#define MMCR1_TTM2SEL_SH	58
+#define MMCR1_TTM3SEL_SH	56
+#define MMCR1_TTMSEL_MSK	3
+#define MMCR1_TD_CP_DBG0SEL_SH	54
+#define MMCR1_TD_CP_DBG1SEL_SH	52
+#define MMCR1_TD_CP_DBG2SEL_SH	50
+#define MMCR1_TD_CP_DBG3SEL_SH	48
+#define MMCR1_GRS_L2SEL_SH	46
+#define MMCR1_GRS_L2SEL_MSK	3
+#define MMCR1_GRS_L3SEL_SH	44
+#define MMCR1_GRS_L3SEL_MSK	3
+#define MMCR1_GRS_MCSEL_SH	41
+#define MMCR1_GRS_MCSEL_MSK	7
+#define MMCR1_GRS_FABSEL_SH	39
+#define MMCR1_GRS_FABSEL_MSK	3
+#define MMCR1_PMC1_ADDER_SEL_SH	35
+#define MMCR1_PMC2_ADDER_SEL_SH	34
+#define MMCR1_PMC3_ADDER_SEL_SH	33
+#define MMCR1_PMC4_ADDER_SEL_SH	32
+#define MMCR1_PMC1SEL_SH	25
+#define MMCR1_PMC2SEL_SH	17
+#define MMCR1_PMC3SEL_SH	9
+#define MMCR1_PMC4SEL_SH	1
+#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
+#define MMCR1_PMCSEL_MSK	0x7f
+
+/*
+ * Layout of constraint bits:
+ * 6666555555555544444444443333333333222222222211111111110000000000
+ * 3210987654321098765432109876543210987654321098765432109876543210
+ *             [  ><><>< ><> <><>[  >  <  ><  ><  ><  ><><><><><><>
+ *             NC  G0G1G2 G3 T0T1 UC    B0  B1  B2  B3 P6P5P4P3P2P1
+ *
+ * NC - number of counters
+ *     51: NC error 0x0008_0000_0000_0000
+ *     48-50: number of events needing PMC1-4 0x0007_0000_0000_0000
+ *
+ * G0..G3 - GRS mux constraints
+ *     46-47: GRS_L2SEL value
+ *     44-45: GRS_L3SEL value
+ *     41-44: GRS_MCSEL value
+ *     39-40: GRS_FABSEL value
+ *	Note that these match up with their bit positions in MMCR1
+ *
+ * T0 - TTM0 constraint
+ *     36-37: TTM0SEL value (0=FPU, 2=IFU, 3=ISU1) 0x30_0000_0000
+ *
+ * T1 - TTM1 constraint
+ *     34-35: TTM1SEL value (0=IDU, 3=GRS) 0x0c_0000_0000
+ *
+ * UC - unit constraint: can't have all three of FPU|IFU|ISU1, ISU0, IDU|GRS
+ *     33: UC3 error 0x02_0000_0000
+ *     32: FPU|IFU|ISU1 events needed 0x01_0000_0000
+ *     31: ISU0 events needed 0x01_8000_0000
+ *     30: IDU|GRS events needed 0x00_4000_0000
+ *
+ * B0
+ *     24-27: Byte 0 event source 0x0f00_0000
+ *	      Encoding as for the event code
+ *
+ * B1, B2, B3
+ *     20-23, 16-19, 12-15: Byte 1, 2, 3 event sources
+ *
+ * P6
+ *     11: P6 error 0x800
+ *     10-11: Count of events needing PMC6
+ *
+ * P1..P5
+ *     0-9: Count of events needing PMC1..PMC5
+ */
+
+static const int grsel_shift[8] = {
+	MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH,
+	MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH,
+	MMCR1_GRS_MCSEL_SH, MMCR1_GRS_FABSEL_SH
+};
+
+/* Masks and values for using events from the various units */
+static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
+	[PM_FPU] =   { 0x3200000000ul, 0x0100000000ul },
+	[PM_ISU0] =  { 0x0200000000ul, 0x0080000000ul },
+	[PM_ISU1] =  { 0x3200000000ul, 0x3100000000ul },
+	[PM_IFU] =   { 0x3200000000ul, 0x2100000000ul },
+	[PM_IDU] =   { 0x0e00000000ul, 0x0040000000ul },
+	[PM_GRS] =   { 0x0e00000000ul, 0x0c40000000ul },
+};
+
+static int power5p_get_constraint(u64 event, unsigned long *maskp,
+				  unsigned long *valp)
+{
+	int pmc, byte, unit, sh;
+	int bit, fmask;
+	unsigned long mask = 0, value = 0;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 6)
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+		if (pmc >= 5 && !(event == 0x500009 || event == 0x600005))
+			return -1;
+	}
+	if (event & PM_BUSEVENT_MSK) {
+		unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+		if (unit > PM_LASTUNIT)
+			return -1;
+		if (unit == PM_ISU0_ALT)
+			unit = PM_ISU0;
+		mask |= unit_cons[unit][0];
+		value |= unit_cons[unit][1];
+		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+		if (byte >= 4) {
+			if (unit != PM_LSU1)
+				return -1;
+			/* Map LSU1 low word (bytes 4-7) to unit LSU1+1 */
+			++unit;
+			byte &= 3;
+		}
+		if (unit == PM_GRS) {
+			bit = event & 7;
+			fmask = (bit == 6)? 7: 3;
+			sh = grsel_shift[bit];
+			mask |= (unsigned long)fmask << sh;
+			value |= (unsigned long)((event >> PM_GRS_SH) & fmask)
+				<< sh;
+		}
+		/* Set byte lane select field */
+		mask  |= 0xfUL << (24 - 4 * byte);
+		value |= (unsigned long)unit << (24 - 4 * byte);
+	}
+	if (pmc < 5) {
+		/* need a counter from PMC1-4 set */
+		mask  |= 0x8000000000000ul;
+		value |= 0x1000000000000ul;
+	}
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+static int power5p_limited_pmc_event(u64 event)
+{
+	int pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+
+	return pmc == 5 || pmc == 6;
+}
+
+#define MAX_ALT	3	/* at most 3 alternatives for any event */
+
+static const unsigned int event_alternatives[][MAX_ALT] = {
+	{ 0x100c0,  0x40001f },			/* PM_GCT_FULL_CYC */
+	{ 0x120e4,  0x400002 },			/* PM_GRP_DISP_REJECT */
+	{ 0x230e2,  0x323087 },			/* PM_BR_PRED_CR */
+	{ 0x230e3,  0x223087, 0x3230a0 },	/* PM_BR_PRED_TA */
+	{ 0x410c7,  0x441084 },			/* PM_THRD_L2MISS_BOTH_CYC */
+	{ 0x800c4,  0xc20e0 },			/* PM_DTLB_MISS */
+	{ 0xc50c6,  0xc60e0 },			/* PM_MRK_DTLB_MISS */
+	{ 0x100005, 0x600005 },			/* PM_RUN_CYC */
+	{ 0x100009, 0x200009 },			/* PM_INST_CMPL */
+	{ 0x200015, 0x300015 },			/* PM_LSU_LMQ_SRQ_EMPTY_CYC */
+	{ 0x300009, 0x400009 },			/* PM_INST_DISP */
+};
+
+/*
+ * Scan the alternatives table for a match and return the
+ * index into the alternatives table if found, else -1.
+ */
+static int find_alternative(unsigned int event)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
+		if (event < event_alternatives[i][0])
+			break;
+		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
+			if (event == event_alternatives[i][j])
+				return i;
+	}
+	return -1;
+}
+
+static const unsigned char bytedecode_alternatives[4][4] = {
+	/* PMC 1 */	{ 0x21, 0x23, 0x25, 0x27 },
+	/* PMC 2 */	{ 0x07, 0x17, 0x0e, 0x1e },
+	/* PMC 3 */	{ 0x20, 0x22, 0x24, 0x26 },
+	/* PMC 4 */	{ 0x07, 0x17, 0x0e, 0x1e }
+};
+
+/*
+ * Some direct events for decodes of event bus byte 3 have alternative
+ * PMCSEL values on other counters.  This returns the alternative
+ * event code for those that do, or -1 otherwise.  This also handles
+ * alternative PCMSEL values for add events.
+ */
+static s64 find_alternative_bdecode(u64 event)
+{
+	int pmc, altpmc, pp, j;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc == 0 || pmc > 4)
+		return -1;
+	altpmc = 5 - pmc;	/* 1 <-> 4, 2 <-> 3 */
+	pp = event & PM_PMCSEL_MSK;
+	for (j = 0; j < 4; ++j) {
+		if (bytedecode_alternatives[pmc - 1][j] == pp) {
+			return (event & ~(PM_PMC_MSKS | PM_PMCSEL_MSK)) |
+				(altpmc << PM_PMC_SH) |
+				bytedecode_alternatives[altpmc - 1][j];
+		}
+	}
+
+	/* new decode alternatives for power5+ */
+	if (pmc == 1 && (pp == 0x0d || pp == 0x0e))
+		return event + (2 << PM_PMC_SH) + (0x2e - 0x0d);
+	if (pmc == 3 && (pp == 0x2e || pp == 0x2f))
+		return event - (2 << PM_PMC_SH) - (0x2e - 0x0d);
+
+	/* alternative add event encodings */
+	if (pp == 0x10 || pp == 0x28)
+		return ((event ^ (0x10 ^ 0x28)) & ~PM_PMC_MSKS) |
+			(altpmc << PM_PMC_SH);
+
+	return -1;
+}
+
+static int power5p_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, nalt = 1;
+	int nlim;
+	s64 ae;
+
+	alt[0] = event;
+	nalt = 1;
+	nlim = power5p_limited_pmc_event(event);
+	i = find_alternative(event);
+	if (i >= 0) {
+		for (j = 0; j < MAX_ALT; ++j) {
+			ae = event_alternatives[i][j];
+			if (ae && ae != event)
+				alt[nalt++] = ae;
+			nlim += power5p_limited_pmc_event(ae);
+		}
+	} else {
+		ae = find_alternative_bdecode(event);
+		if (ae > 0)
+			alt[nalt++] = ae;
+	}
+
+	if (flags & PPMU_ONLY_COUNT_RUN) {
+		/*
+		 * We're only counting in RUN state,
+		 * so PM_CYC is equivalent to PM_RUN_CYC
+		 * and PM_INST_CMPL === PM_RUN_INST_CMPL.
+		 * This doesn't include alternatives that don't provide
+		 * any extra flexibility in assigning PMCs (e.g.
+		 * 0x100005 for PM_RUN_CYC vs. 0xf for PM_CYC).
+		 * Note that even with these additional alternatives
+		 * we never end up with more than 3 alternatives for any event.
+		 */
+		j = nalt;
+		for (i = 0; i < nalt; ++i) {
+			switch (alt[i]) {
+			case 0xf:	/* PM_CYC */
+				alt[j++] = 0x600005;	/* PM_RUN_CYC */
+				++nlim;
+				break;
+			case 0x600005:	/* PM_RUN_CYC */
+				alt[j++] = 0xf;
+				break;
+			case 0x100009:	/* PM_INST_CMPL */
+				alt[j++] = 0x500009;	/* PM_RUN_INST_CMPL */
+				++nlim;
+				break;
+			case 0x500009:	/* PM_RUN_INST_CMPL */
+				alt[j++] = 0x100009;	/* PM_INST_CMPL */
+				alt[j++] = 0x200009;
+				break;
+			}
+		}
+		nalt = j;
+	}
+
+	if (!(flags & PPMU_LIMITED_PMC_OK) && nlim) {
+		/* remove the limited PMC events */
+		j = 0;
+		for (i = 0; i < nalt; ++i) {
+			if (!power5p_limited_pmc_event(alt[i])) {
+				alt[j] = alt[i];
+				++j;
+			}
+		}
+		nalt = j;
+	} else if ((flags & PPMU_LIMITED_PMC_REQD) && nlim < nalt) {
+		/* remove all but the limited PMC events */
+		j = 0;
+		for (i = 0; i < nalt; ++i) {
+			if (power5p_limited_pmc_event(alt[i])) {
+				alt[j] = alt[i];
+				++j;
+			}
+		}
+		nalt = j;
+	}
+
+	return nalt;
+}
+
+/*
+ * Map of which direct events on which PMCs are marked instruction events.
+ * Indexed by PMCSEL value, bit i (LE) set if PMC i is a marked event.
+ * Bit 0 is set if it is marked for all PMCs.
+ * The 0x80 bit indicates a byte decode PMCSEL value.
+ */
+static unsigned char direct_event_is_marked[0x28] = {
+	0,	/* 00 */
+	0x1f,	/* 01 PM_IOPS_CMPL */
+	0x2,	/* 02 PM_MRK_GRP_DISP */
+	0xe,	/* 03 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
+	0,	/* 04 */
+	0x1c,	/* 05 PM_MRK_BRU_FIN, PM_MRK_INST_FIN, PM_MRK_CRU_FIN */
+	0x80,	/* 06 */
+	0x80,	/* 07 */
+	0, 0, 0,/* 08 - 0a */
+	0x18,	/* 0b PM_THRESH_TIMEO, PM_MRK_GRP_TIMEO */
+	0,	/* 0c */
+	0x80,	/* 0d */
+	0x80,	/* 0e */
+	0,	/* 0f */
+	0,	/* 10 */
+	0x14,	/* 11 PM_MRK_GRP_BR_REDIR, PM_MRK_GRP_IC_MISS */
+	0,	/* 12 */
+	0x10,	/* 13 PM_MRK_GRP_CMPL */
+	0x1f,	/* 14 PM_GRP_MRK, PM_MRK_{FXU,FPU,LSU}_FIN */
+	0x2,	/* 15 PM_MRK_GRP_ISSUED */
+	0x80,	/* 16 */
+	0x80,	/* 17 */
+	0, 0, 0, 0, 0,
+	0x80,	/* 1d */
+	0x80,	/* 1e */
+	0,	/* 1f */
+	0x80,	/* 20 */
+	0x80,	/* 21 */
+	0x80,	/* 22 */
+	0x80,	/* 23 */
+	0x80,	/* 24 */
+	0x80,	/* 25 */
+	0x80,	/* 26 */
+	0x80,	/* 27 */
+};
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int power5p_marked_instr_event(u64 event)
+{
+	int pmc, psel;
+	int bit, byte, unit;
+	u32 mask;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = event & PM_PMCSEL_MSK;
+	if (pmc >= 5)
+		return 0;
+
+	bit = -1;
+	if (psel < sizeof(direct_event_is_marked)) {
+		if (direct_event_is_marked[psel] & (1 << pmc))
+			return 1;
+		if (direct_event_is_marked[psel] & 0x80)
+			bit = 4;
+		else if (psel == 0x08)
+			bit = pmc - 1;
+		else if (psel == 0x10)
+			bit = 4 - pmc;
+		else if (psel == 0x1b && (pmc == 1 || pmc == 3))
+			bit = 4;
+	} else if ((psel & 0x48) == 0x40) {
+		bit = psel & 7;
+	} else if (psel == 0x28) {
+		bit = pmc - 1;
+	} else if (pmc == 3 && (psel == 0x2e || psel == 0x2f)) {
+		bit = 4;
+	}
+
+	if (!(event & PM_BUSEVENT_MSK) || bit == -1)
+		return 0;
+
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	if (unit == PM_LSU0) {
+		/* byte 1 bits 0-7, byte 2 bits 0,2-4,6 */
+		mask = 0x5dff00;
+	} else if (unit == PM_LSU1 && byte >= 4) {
+		byte -= 4;
+		/* byte 5 bits 6-7, byte 6 bits 0,4, byte 7 bits 0-4,6 */
+		mask = 0x5f11c000;
+	} else
+		return 0;
+
+	return (mask >> (byte * 8 + bit)) & 1;
+}
+
+static int power5p_compute_mmcr(u64 event[], int n_ev,
+				unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr1 = 0;
+	unsigned long mmcra = 0;
+	unsigned int pmc, unit, byte, psel;
+	unsigned int ttm;
+	int i, isbus, bit, grsel;
+	unsigned int pmc_inuse = 0;
+	unsigned char busbyte[4];
+	unsigned char unituse[16];
+	int ttmuse;
+
+	if (n_ev > 6)
+		return -1;
+
+	/* First pass to count resource use */
+	memset(busbyte, 0, sizeof(busbyte));
+	memset(unituse, 0, sizeof(unituse));
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc > 6)
+				return -1;
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;
+			pmc_inuse |= 1 << (pmc - 1);
+		}
+		if (event[i] & PM_BUSEVENT_MSK) {
+			unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+			byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+			if (unit > PM_LASTUNIT)
+				return -1;
+			if (unit == PM_ISU0_ALT)
+				unit = PM_ISU0;
+			if (byte >= 4) {
+				if (unit != PM_LSU1)
+					return -1;
+				++unit;
+				byte &= 3;
+			}
+			if (busbyte[byte] && busbyte[byte] != unit)
+				return -1;
+			busbyte[byte] = unit;
+			unituse[unit] = 1;
+		}
+	}
+
+	/*
+	 * Assign resources and set multiplexer selects.
+	 *
+	 * PM_ISU0 can go either on TTM0 or TTM1, but that's the only
+	 * choice we have to deal with.
+	 */
+	if (unituse[PM_ISU0] &
+	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_ISU1])) {
+		unituse[PM_ISU0_ALT] = 1;	/* move ISU to TTM1 */
+		unituse[PM_ISU0] = 0;
+	}
+	/* Set TTM[01]SEL fields. */
+	ttmuse = 0;
+	for (i = PM_FPU; i <= PM_ISU1; ++i) {
+		if (!unituse[i])
+			continue;
+		if (ttmuse++)
+			return -1;
+		mmcr1 |= (unsigned long)i << MMCR1_TTM0SEL_SH;
+	}
+	ttmuse = 0;
+	for (; i <= PM_GRS; ++i) {
+		if (!unituse[i])
+			continue;
+		if (ttmuse++)
+			return -1;
+		mmcr1 |= (unsigned long)(i & 3) << MMCR1_TTM1SEL_SH;
+	}
+	if (ttmuse > 1)
+		return -1;
+
+	/* Set byte lane select fields, TTM[23]SEL and GRS_*SEL. */
+	for (byte = 0; byte < 4; ++byte) {
+		unit = busbyte[byte];
+		if (!unit)
+			continue;
+		if (unit == PM_ISU0 && unituse[PM_ISU0_ALT]) {
+			/* get ISU0 through TTM1 rather than TTM0 */
+			unit = PM_ISU0_ALT;
+		} else if (unit == PM_LSU1 + 1) {
+			/* select lower word of LSU1 for this byte */
+			mmcr1 |= 1ul << (MMCR1_TTM3SEL_SH + 3 - byte);
+		}
+		ttm = unit >> 2;
+		mmcr1 |= (unsigned long)ttm
+			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
+	}
+
+	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		psel = event[i] & PM_PMCSEL_MSK;
+		isbus = event[i] & PM_BUSEVENT_MSK;
+		if (!pmc) {
+			/* Bus event or any-PMC direct event */
+			for (pmc = 0; pmc < 4; ++pmc) {
+				if (!(pmc_inuse & (1 << pmc)))
+					break;
+			}
+			if (pmc >= 4)
+				return -1;
+			pmc_inuse |= 1 << pmc;
+		} else if (pmc <= 4) {
+			/* Direct event */
+			--pmc;
+			if (isbus && (byte & 2) &&
+			    (psel == 8 || psel == 0x10 || psel == 0x28))
+				/* add events on higher-numbered bus */
+				mmcr1 |= 1ul << (MMCR1_PMC1_ADDER_SEL_SH - pmc);
+		} else {
+			/* Instructions or run cycles on PMC5/6 */
+			--pmc;
+		}
+		if (isbus && unit == PM_GRS) {
+			bit = psel & 7;
+			grsel = (event[i] >> PM_GRS_SH) & PM_GRS_MSK;
+			mmcr1 |= (unsigned long)grsel << grsel_shift[bit];
+		}
+		if (power5p_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+		if ((psel & 0x58) == 0x40 && (byte & 1) != ((pmc >> 1) & 1))
+			/* select alternate byte lane */
+			psel |= 0x10;
+		if (pmc <= 3)
+			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
+		hwc[i] = pmc;
+	}
+
+	/* Return MMCRx values */
+	mmcr[0] = 0;
+	if (pmc_inuse & 1)
+		mmcr[0] = MMCR0_PMC1CE;
+	if (pmc_inuse & 0x3e)
+		mmcr[0] |= MMCR0_PMCjCE;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+static void power5p_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	if (pmc <= 3)
+		mmcr[1] &= ~(0x7fUL << MMCR1_PMCSEL_SH(pmc));
+}
+
+static int power5p_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0xf,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x100009,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x1c10a8, /* LD_REF_L1 */
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c1088, /* LD_MISS_L1 */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x230e4,  /* BR_ISSUED */
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x230e5,  /* BR_MPRED_CR */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int power5p_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x1c10a8,	0x3c1088	},
+		[C(OP_WRITE)] = {	0x2c10a8,	0xc10c3		},
+		[C(OP_PREFETCH)] = {	0xc70e7,	-1		},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	0,		0		},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0		},
+		[C(OP_WRITE)] = {	0,		0		},
+		[C(OP_PREFETCH)] = {	0xc50c3,	0		},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0xc20e4,	0x800c4		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x800c0		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x230e4,	0x230e5		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+};
+
+static struct power_pmu power5p_pmu = {
+	.name			= "POWER5+/++",
+	.n_counter		= 6,
+	.max_alternatives	= MAX_ALT,
+	.add_fields		= 0x7000000000055ul,
+	.test_adder		= 0x3000040000000ul,
+	.compute_mmcr		= power5p_compute_mmcr,
+	.get_constraint		= power5p_get_constraint,
+	.get_alternatives	= power5p_get_alternatives,
+	.disable_pmc		= power5p_disable_pmc,
+	.limited_pmc_event	= power5p_limited_pmc_event,
+	.flags			= PPMU_LIMITED_PMC5_6,
+	.n_generic		= ARRAY_SIZE(power5p_generic_events),
+	.generic_events		= power5p_generic_events,
+	.cache_events		= &power5p_cache_events,
+};
+
+static int __init init_power5p_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
+	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
+		return -ENODEV;
+
+	return register_power_pmu(&power5p_pmu);
+}
+
+early_initcall(init_power5p_pmu);
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
new file mode 100644
index 0000000..e7f06eb
--- /dev/null
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -0,0 +1,629 @@
+/*
+ * Performance counter support for POWER5 (not POWER5++) processors.
+ *
+ * Copyright 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Bits in event code for POWER5 (not POWER5++)
+ */
+#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0xf
+#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
+#define PM_UNIT_SH	16	/* TTMMUX number and setting - unit select */
+#define PM_UNIT_MSK	0xf
+#define PM_BYTE_SH	12	/* Byte number of event bus to use */
+#define PM_BYTE_MSK	7
+#define PM_GRS_SH	8	/* Storage subsystem mux select */
+#define PM_GRS_MSK	7
+#define PM_BUSEVENT_MSK	0x80	/* Set if event uses event bus */
+#define PM_PMCSEL_MSK	0x7f
+
+/* Values in PM_UNIT field */
+#define PM_FPU		0
+#define PM_ISU0		1
+#define PM_IFU		2
+#define PM_ISU1		3
+#define PM_IDU		4
+#define PM_ISU0_ALT	6
+#define PM_GRS		7
+#define PM_LSU0		8
+#define PM_LSU1		0xc
+#define PM_LASTUNIT	0xc
+
+/*
+ * Bits in MMCR1 for POWER5
+ */
+#define MMCR1_TTM0SEL_SH	62
+#define MMCR1_TTM1SEL_SH	60
+#define MMCR1_TTM2SEL_SH	58
+#define MMCR1_TTM3SEL_SH	56
+#define MMCR1_TTMSEL_MSK	3
+#define MMCR1_TD_CP_DBG0SEL_SH	54
+#define MMCR1_TD_CP_DBG1SEL_SH	52
+#define MMCR1_TD_CP_DBG2SEL_SH	50
+#define MMCR1_TD_CP_DBG3SEL_SH	48
+#define MMCR1_GRS_L2SEL_SH	46
+#define MMCR1_GRS_L2SEL_MSK	3
+#define MMCR1_GRS_L3SEL_SH	44
+#define MMCR1_GRS_L3SEL_MSK	3
+#define MMCR1_GRS_MCSEL_SH	41
+#define MMCR1_GRS_MCSEL_MSK	7
+#define MMCR1_GRS_FABSEL_SH	39
+#define MMCR1_GRS_FABSEL_MSK	3
+#define MMCR1_PMC1_ADDER_SEL_SH	35
+#define MMCR1_PMC2_ADDER_SEL_SH	34
+#define MMCR1_PMC3_ADDER_SEL_SH	33
+#define MMCR1_PMC4_ADDER_SEL_SH	32
+#define MMCR1_PMC1SEL_SH	25
+#define MMCR1_PMC2SEL_SH	17
+#define MMCR1_PMC3SEL_SH	9
+#define MMCR1_PMC4SEL_SH	1
+#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
+#define MMCR1_PMCSEL_MSK	0x7f
+
+/*
+ * Layout of constraint bits:
+ * 6666555555555544444444443333333333222222222211111111110000000000
+ * 3210987654321098765432109876543210987654321098765432109876543210
+ *         <><>[  ><><>< ><> [  >[ >[ ><  ><  ><  ><  ><><><><><><>
+ *         T0T1 NC G0G1G2 G3  UC PS1PS2 B0  B1  B2  B3 P6P5P4P3P2P1
+ *
+ * T0 - TTM0 constraint
+ *     54-55: TTM0SEL value (0=FPU, 2=IFU, 3=ISU1) 0xc0_0000_0000_0000
+ *
+ * T1 - TTM1 constraint
+ *     52-53: TTM1SEL value (0=IDU, 3=GRS) 0x30_0000_0000_0000
+ *
+ * NC - number of counters
+ *     51: NC error 0x0008_0000_0000_0000
+ *     48-50: number of events needing PMC1-4 0x0007_0000_0000_0000
+ *
+ * G0..G3 - GRS mux constraints
+ *     46-47: GRS_L2SEL value
+ *     44-45: GRS_L3SEL value
+ *     41-44: GRS_MCSEL value
+ *     39-40: GRS_FABSEL value
+ *	Note that these match up with their bit positions in MMCR1
+ *
+ * UC - unit constraint: can't have all three of FPU|IFU|ISU1, ISU0, IDU|GRS
+ *     37: UC3 error 0x20_0000_0000
+ *     36: FPU|IFU|ISU1 events needed 0x10_0000_0000
+ *     35: ISU0 events needed 0x08_0000_0000
+ *     34: IDU|GRS events needed 0x04_0000_0000
+ *
+ * PS1
+ *     33: PS1 error 0x2_0000_0000
+ *     31-32: count of events needing PMC1/2 0x1_8000_0000
+ *
+ * PS2
+ *     30: PS2 error 0x4000_0000
+ *     28-29: count of events needing PMC3/4 0x3000_0000
+ *
+ * B0
+ *     24-27: Byte 0 event source 0x0f00_0000
+ *	      Encoding as for the event code
+ *
+ * B1, B2, B3
+ *     20-23, 16-19, 12-15: Byte 1, 2, 3 event sources
+ *
+ * P1..P6
+ *     0-11: Count of events needing PMC1..PMC6
+ */
+
+static const int grsel_shift[8] = {
+	MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH, MMCR1_GRS_L2SEL_SH,
+	MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH, MMCR1_GRS_L3SEL_SH,
+	MMCR1_GRS_MCSEL_SH, MMCR1_GRS_FABSEL_SH
+};
+
+/* Masks and values for using events from the various units */
+static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
+	[PM_FPU] =   { 0xc0002000000000ul, 0x00001000000000ul },
+	[PM_ISU0] =  { 0x00002000000000ul, 0x00000800000000ul },
+	[PM_ISU1] =  { 0xc0002000000000ul, 0xc0001000000000ul },
+	[PM_IFU] =   { 0xc0002000000000ul, 0x80001000000000ul },
+	[PM_IDU] =   { 0x30002000000000ul, 0x00000400000000ul },
+	[PM_GRS] =   { 0x30002000000000ul, 0x30000400000000ul },
+};
+
+static int power5_get_constraint(u64 event, unsigned long *maskp,
+				 unsigned long *valp)
+{
+	int pmc, byte, unit, sh;
+	int bit, fmask;
+	unsigned long mask = 0, value = 0;
+	int grp = -1;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 6)
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+		if (pmc <= 4)
+			grp = (pmc - 1) >> 1;
+		else if (event != 0x500009 && event != 0x600005)
+			return -1;
+	}
+	if (event & PM_BUSEVENT_MSK) {
+		unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+		if (unit > PM_LASTUNIT)
+			return -1;
+		if (unit == PM_ISU0_ALT)
+			unit = PM_ISU0;
+		mask |= unit_cons[unit][0];
+		value |= unit_cons[unit][1];
+		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+		if (byte >= 4) {
+			if (unit != PM_LSU1)
+				return -1;
+			/* Map LSU1 low word (bytes 4-7) to unit LSU1+1 */
+			++unit;
+			byte &= 3;
+		}
+		if (unit == PM_GRS) {
+			bit = event & 7;
+			fmask = (bit == 6)? 7: 3;
+			sh = grsel_shift[bit];
+			mask |= (unsigned long)fmask << sh;
+			value |= (unsigned long)((event >> PM_GRS_SH) & fmask)
+				<< sh;
+		}
+		/*
+		 * Bus events on bytes 0 and 2 can be counted
+		 * on PMC1/2; bytes 1 and 3 on PMC3/4.
+		 */
+		if (!pmc)
+			grp = byte & 1;
+		/* Set byte lane select field */
+		mask  |= 0xfUL << (24 - 4 * byte);
+		value |= (unsigned long)unit << (24 - 4 * byte);
+	}
+	if (grp == 0) {
+		/* increment PMC1/2 field */
+		mask  |= 0x200000000ul;
+		value |= 0x080000000ul;
+	} else if (grp == 1) {
+		/* increment PMC3/4 field */
+		mask  |= 0x40000000ul;
+		value |= 0x10000000ul;
+	}
+	if (pmc < 5) {
+		/* need a counter from PMC1-4 set */
+		mask  |= 0x8000000000000ul;
+		value |= 0x1000000000000ul;
+	}
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+#define MAX_ALT	3	/* at most 3 alternatives for any event */
+
+static const unsigned int event_alternatives[][MAX_ALT] = {
+	{ 0x120e4,  0x400002 },			/* PM_GRP_DISP_REJECT */
+	{ 0x410c7,  0x441084 },			/* PM_THRD_L2MISS_BOTH_CYC */
+	{ 0x100005, 0x600005 },			/* PM_RUN_CYC */
+	{ 0x100009, 0x200009, 0x500009 },	/* PM_INST_CMPL */
+	{ 0x300009, 0x400009 },			/* PM_INST_DISP */
+};
+
+/*
+ * Scan the alternatives table for a match and return the
+ * index into the alternatives table if found, else -1.
+ */
+static int find_alternative(u64 event)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
+		if (event < event_alternatives[i][0])
+			break;
+		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
+			if (event == event_alternatives[i][j])
+				return i;
+	}
+	return -1;
+}
+
+static const unsigned char bytedecode_alternatives[4][4] = {
+	/* PMC 1 */	{ 0x21, 0x23, 0x25, 0x27 },
+	/* PMC 2 */	{ 0x07, 0x17, 0x0e, 0x1e },
+	/* PMC 3 */	{ 0x20, 0x22, 0x24, 0x26 },
+	/* PMC 4 */	{ 0x07, 0x17, 0x0e, 0x1e }
+};
+
+/*
+ * Some direct events for decodes of event bus byte 3 have alternative
+ * PMCSEL values on other counters.  This returns the alternative
+ * event code for those that do, or -1 otherwise.
+ */
+static s64 find_alternative_bdecode(u64 event)
+{
+	int pmc, altpmc, pp, j;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc == 0 || pmc > 4)
+		return -1;
+	altpmc = 5 - pmc;	/* 1 <-> 4, 2 <-> 3 */
+	pp = event & PM_PMCSEL_MSK;
+	for (j = 0; j < 4; ++j) {
+		if (bytedecode_alternatives[pmc - 1][j] == pp) {
+			return (event & ~(PM_PMC_MSKS | PM_PMCSEL_MSK)) |
+				(altpmc << PM_PMC_SH) |
+				bytedecode_alternatives[altpmc - 1][j];
+		}
+	}
+	return -1;
+}
+
+static int power5_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, nalt = 1;
+	s64 ae;
+
+	alt[0] = event;
+	nalt = 1;
+	i = find_alternative(event);
+	if (i >= 0) {
+		for (j = 0; j < MAX_ALT; ++j) {
+			ae = event_alternatives[i][j];
+			if (ae && ae != event)
+				alt[nalt++] = ae;
+		}
+	} else {
+		ae = find_alternative_bdecode(event);
+		if (ae > 0)
+			alt[nalt++] = ae;
+	}
+	return nalt;
+}
+
+/*
+ * Map of which direct events on which PMCs are marked instruction events.
+ * Indexed by PMCSEL value, bit i (LE) set if PMC i is a marked event.
+ * Bit 0 is set if it is marked for all PMCs.
+ * The 0x80 bit indicates a byte decode PMCSEL value.
+ */
+static unsigned char direct_event_is_marked[0x28] = {
+	0,	/* 00 */
+	0x1f,	/* 01 PM_IOPS_CMPL */
+	0x2,	/* 02 PM_MRK_GRP_DISP */
+	0xe,	/* 03 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
+	0,	/* 04 */
+	0x1c,	/* 05 PM_MRK_BRU_FIN, PM_MRK_INST_FIN, PM_MRK_CRU_FIN */
+	0x80,	/* 06 */
+	0x80,	/* 07 */
+	0, 0, 0,/* 08 - 0a */
+	0x18,	/* 0b PM_THRESH_TIMEO, PM_MRK_GRP_TIMEO */
+	0,	/* 0c */
+	0x80,	/* 0d */
+	0x80,	/* 0e */
+	0,	/* 0f */
+	0,	/* 10 */
+	0x14,	/* 11 PM_MRK_GRP_BR_REDIR, PM_MRK_GRP_IC_MISS */
+	0,	/* 12 */
+	0x10,	/* 13 PM_MRK_GRP_CMPL */
+	0x1f,	/* 14 PM_GRP_MRK, PM_MRK_{FXU,FPU,LSU}_FIN */
+	0x2,	/* 15 PM_MRK_GRP_ISSUED */
+	0x80,	/* 16 */
+	0x80,	/* 17 */
+	0, 0, 0, 0, 0,
+	0x80,	/* 1d */
+	0x80,	/* 1e */
+	0,	/* 1f */
+	0x80,	/* 20 */
+	0x80,	/* 21 */
+	0x80,	/* 22 */
+	0x80,	/* 23 */
+	0x80,	/* 24 */
+	0x80,	/* 25 */
+	0x80,	/* 26 */
+	0x80,	/* 27 */
+};
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int power5_marked_instr_event(u64 event)
+{
+	int pmc, psel;
+	int bit, byte, unit;
+	u32 mask;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = event & PM_PMCSEL_MSK;
+	if (pmc >= 5)
+		return 0;
+
+	bit = -1;
+	if (psel < sizeof(direct_event_is_marked)) {
+		if (direct_event_is_marked[psel] & (1 << pmc))
+			return 1;
+		if (direct_event_is_marked[psel] & 0x80)
+			bit = 4;
+		else if (psel == 0x08)
+			bit = pmc - 1;
+		else if (psel == 0x10)
+			bit = 4 - pmc;
+		else if (psel == 0x1b && (pmc == 1 || pmc == 3))
+			bit = 4;
+	} else if ((psel & 0x58) == 0x40)
+		bit = psel & 7;
+
+	if (!(event & PM_BUSEVENT_MSK))
+		return 0;
+
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	if (unit == PM_LSU0) {
+		/* byte 1 bits 0-7, byte 2 bits 0,2-4,6 */
+		mask = 0x5dff00;
+	} else if (unit == PM_LSU1 && byte >= 4) {
+		byte -= 4;
+		/* byte 4 bits 1,3,5,7, byte 5 bits 6-7, byte 7 bits 0-4,6 */
+		mask = 0x5f00c0aa;
+	} else
+		return 0;
+
+	return (mask >> (byte * 8 + bit)) & 1;
+}
+
+static int power5_compute_mmcr(u64 event[], int n_ev,
+			       unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr1 = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
+	unsigned int pmc, unit, byte, psel;
+	unsigned int ttm, grp;
+	int i, isbus, bit, grsel;
+	unsigned int pmc_inuse = 0;
+	unsigned int pmc_grp_use[2];
+	unsigned char busbyte[4];
+	unsigned char unituse[16];
+	int ttmuse;
+
+	if (n_ev > 6)
+		return -1;
+
+	/* First pass to count resource use */
+	pmc_grp_use[0] = pmc_grp_use[1] = 0;
+	memset(busbyte, 0, sizeof(busbyte));
+	memset(unituse, 0, sizeof(unituse));
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc > 6)
+				return -1;
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;
+			pmc_inuse |= 1 << (pmc - 1);
+			/* count 1/2 vs 3/4 use */
+			if (pmc <= 4)
+				++pmc_grp_use[(pmc - 1) >> 1];
+		}
+		if (event[i] & PM_BUSEVENT_MSK) {
+			unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+			byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+			if (unit > PM_LASTUNIT)
+				return -1;
+			if (unit == PM_ISU0_ALT)
+				unit = PM_ISU0;
+			if (byte >= 4) {
+				if (unit != PM_LSU1)
+					return -1;
+				++unit;
+				byte &= 3;
+			}
+			if (!pmc)
+				++pmc_grp_use[byte & 1];
+			if (busbyte[byte] && busbyte[byte] != unit)
+				return -1;
+			busbyte[byte] = unit;
+			unituse[unit] = 1;
+		}
+	}
+	if (pmc_grp_use[0] > 2 || pmc_grp_use[1] > 2)
+		return -1;
+
+	/*
+	 * Assign resources and set multiplexer selects.
+	 *
+	 * PM_ISU0 can go either on TTM0 or TTM1, but that's the only
+	 * choice we have to deal with.
+	 */
+	if (unituse[PM_ISU0] &
+	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_ISU1])) {
+		unituse[PM_ISU0_ALT] = 1;	/* move ISU to TTM1 */
+		unituse[PM_ISU0] = 0;
+	}
+	/* Set TTM[01]SEL fields. */
+	ttmuse = 0;
+	for (i = PM_FPU; i <= PM_ISU1; ++i) {
+		if (!unituse[i])
+			continue;
+		if (ttmuse++)
+			return -1;
+		mmcr1 |= (unsigned long)i << MMCR1_TTM0SEL_SH;
+	}
+	ttmuse = 0;
+	for (; i <= PM_GRS; ++i) {
+		if (!unituse[i])
+			continue;
+		if (ttmuse++)
+			return -1;
+		mmcr1 |= (unsigned long)(i & 3) << MMCR1_TTM1SEL_SH;
+	}
+	if (ttmuse > 1)
+		return -1;
+
+	/* Set byte lane select fields, TTM[23]SEL and GRS_*SEL. */
+	for (byte = 0; byte < 4; ++byte) {
+		unit = busbyte[byte];
+		if (!unit)
+			continue;
+		if (unit == PM_ISU0 && unituse[PM_ISU0_ALT]) {
+			/* get ISU0 through TTM1 rather than TTM0 */
+			unit = PM_ISU0_ALT;
+		} else if (unit == PM_LSU1 + 1) {
+			/* select lower word of LSU1 for this byte */
+			mmcr1 |= 1ul << (MMCR1_TTM3SEL_SH + 3 - byte);
+		}
+		ttm = unit >> 2;
+		mmcr1 |= (unsigned long)ttm
+			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
+	}
+
+	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		psel = event[i] & PM_PMCSEL_MSK;
+		isbus = event[i] & PM_BUSEVENT_MSK;
+		if (!pmc) {
+			/* Bus event or any-PMC direct event */
+			for (pmc = 0; pmc < 4; ++pmc) {
+				if (pmc_inuse & (1 << pmc))
+					continue;
+				grp = (pmc >> 1) & 1;
+				if (isbus) {
+					if (grp == (byte & 1))
+						break;
+				} else if (pmc_grp_use[grp] < 2) {
+					++pmc_grp_use[grp];
+					break;
+				}
+			}
+			pmc_inuse |= 1 << pmc;
+		} else if (pmc <= 4) {
+			/* Direct event */
+			--pmc;
+			if ((psel == 8 || psel == 0x10) && isbus && (byte & 2))
+				/* add events on higher-numbered bus */
+				mmcr1 |= 1ul << (MMCR1_PMC1_ADDER_SEL_SH - pmc);
+		} else {
+			/* Instructions or run cycles on PMC5/6 */
+			--pmc;
+		}
+		if (isbus && unit == PM_GRS) {
+			bit = psel & 7;
+			grsel = (event[i] >> PM_GRS_SH) & PM_GRS_MSK;
+			mmcr1 |= (unsigned long)grsel << grsel_shift[bit];
+		}
+		if (power5_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+		if (pmc <= 3)
+			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
+		hwc[i] = pmc;
+	}
+
+	/* Return MMCRx values */
+	mmcr[0] = 0;
+	if (pmc_inuse & 1)
+		mmcr[0] = MMCR0_PMC1CE;
+	if (pmc_inuse & 0x3e)
+		mmcr[0] |= MMCR0_PMCjCE;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+static void power5_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	if (pmc <= 3)
+		mmcr[1] &= ~(0x7fUL << MMCR1_PMCSEL_SH(pmc));
+}
+
+static int power5_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0xf,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x100009,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x4c1090, /* LD_REF_L1 */
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3c1088, /* LD_MISS_L1 */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x230e4,  /* BR_ISSUED */
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x230e5,  /* BR_MPRED_CR */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int power5_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x4c1090,	0x3c1088	},
+		[C(OP_WRITE)] = {	0x3c1090,	0xc10c3		},
+		[C(OP_PREFETCH)] = {	0xc70e7,	0		},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	0,		0		},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x3c309b	},
+		[C(OP_WRITE)] = {	0,		0		},
+		[C(OP_PREFETCH)] = {	0xc50c3,	0		},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x2c4090,	0x800c4		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x800c0		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x230e4,	0x230e5		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+};
+
+static struct power_pmu power5_pmu = {
+	.name			= "POWER5",
+	.n_counter		= 6,
+	.max_alternatives	= MAX_ALT,
+	.add_fields		= 0x7000090000555ul,
+	.test_adder		= 0x3000490000000ul,
+	.compute_mmcr		= power5_compute_mmcr,
+	.get_constraint		= power5_get_constraint,
+	.get_alternatives	= power5_get_alternatives,
+	.disable_pmc		= power5_disable_pmc,
+	.n_generic		= ARRAY_SIZE(power5_generic_events),
+	.generic_events		= power5_generic_events,
+	.cache_events		= &power5_cache_events,
+};
+
+static int __init init_power5_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
+		return -ENODEV;
+
+	return register_power_pmu(&power5_pmu);
+}
+
+early_initcall(init_power5_pmu);
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
new file mode 100644
index 0000000..31128e0
--- /dev/null
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -0,0 +1,552 @@
+/*
+ * Performance counter support for POWER6 processors.
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Bits in event code for POWER6
+ */
+#define PM_PMC_SH	20	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0x7
+#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
+#define PM_UNIT_SH	16	/* Unit event comes (TTMxSEL encoding) */
+#define PM_UNIT_MSK	0xf
+#define PM_UNIT_MSKS	(PM_UNIT_MSK << PM_UNIT_SH)
+#define PM_LLAV		0x8000	/* Load lookahead match value */
+#define PM_LLA		0x4000	/* Load lookahead match enable */
+#define PM_BYTE_SH	12	/* Byte of event bus to use */
+#define PM_BYTE_MSK	3
+#define PM_SUBUNIT_SH	8	/* Subunit event comes from (NEST_SEL enc.) */
+#define PM_SUBUNIT_MSK	7
+#define PM_SUBUNIT_MSKS	(PM_SUBUNIT_MSK << PM_SUBUNIT_SH)
+#define PM_PMCSEL_MSK	0xff	/* PMCxSEL value */
+#define PM_BUSEVENT_MSK	0xf3700
+
+/*
+ * Bits in MMCR1 for POWER6
+ */
+#define MMCR1_TTM0SEL_SH	60
+#define MMCR1_TTMSEL_SH(n)	(MMCR1_TTM0SEL_SH - (n) * 4)
+#define MMCR1_TTMSEL_MSK	0xf
+#define MMCR1_TTMSEL(m, n)	(((m) >> MMCR1_TTMSEL_SH(n)) & MMCR1_TTMSEL_MSK)
+#define MMCR1_NESTSEL_SH	45
+#define MMCR1_NESTSEL_MSK	0x7
+#define MMCR1_NESTSEL(m)	(((m) >> MMCR1_NESTSEL_SH) & MMCR1_NESTSEL_MSK)
+#define MMCR1_PMC1_LLA		(1ul << 44)
+#define MMCR1_PMC1_LLA_VALUE	(1ul << 39)
+#define MMCR1_PMC1_ADDR_SEL	(1ul << 35)
+#define MMCR1_PMC1SEL_SH	24
+#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
+#define MMCR1_PMCSEL_MSK	0xff
+
+/*
+ * Map of which direct events on which PMCs are marked instruction events.
+ * Indexed by PMCSEL value >> 1.
+ * Bottom 4 bits are a map of which PMCs are interesting,
+ * top 4 bits say what sort of event:
+ *   0 = direct marked event,
+ *   1 = byte decode event,
+ *   4 = add/and event (PMC1 -> bits 0 & 4),
+ *   5 = add/and event (PMC1 -> bits 1 & 5),
+ *   6 = add/and event (PMC1 -> bits 2 & 6),
+ *   7 = add/and event (PMC1 -> bits 3 & 7).
+ */
+static unsigned char direct_event_is_marked[0x60 >> 1] = {
+	0,	/* 00 */
+	0,	/* 02 */
+	0,	/* 04 */
+	0x07,	/* 06 PM_MRK_ST_CMPL, PM_MRK_ST_GPS, PM_MRK_ST_CMPL_INT */
+	0x04,	/* 08 PM_MRK_DFU_FIN */
+	0x06,	/* 0a PM_MRK_IFU_FIN, PM_MRK_INST_FIN */
+	0,	/* 0c */
+	0,	/* 0e */
+	0x02,	/* 10 PM_MRK_INST_DISP */
+	0x08,	/* 12 PM_MRK_LSU_DERAT_MISS */
+	0,	/* 14 */
+	0,	/* 16 */
+	0x0c,	/* 18 PM_THRESH_TIMEO, PM_MRK_INST_FIN */
+	0x0f,	/* 1a PM_MRK_INST_DISP, PM_MRK_{FXU,FPU,LSU}_FIN */
+	0x01,	/* 1c PM_MRK_INST_ISSUED */
+	0,	/* 1e */
+	0,	/* 20 */
+	0,	/* 22 */
+	0,	/* 24 */
+	0,	/* 26 */
+	0x15,	/* 28 PM_MRK_DATA_FROM_L2MISS, PM_MRK_DATA_FROM_L3MISS */
+	0,	/* 2a */
+	0,	/* 2c */
+	0,	/* 2e */
+	0x4f,	/* 30 */
+	0x7f,	/* 32 */
+	0x4f,	/* 34 */
+	0x5f,	/* 36 */
+	0x6f,	/* 38 */
+	0x4f,	/* 3a */
+	0,	/* 3c */
+	0x08,	/* 3e PM_MRK_INST_TIMEO */
+	0x1f,	/* 40 */
+	0x1f,	/* 42 */
+	0x1f,	/* 44 */
+	0x1f,	/* 46 */
+	0x1f,	/* 48 */
+	0x1f,	/* 4a */
+	0x1f,	/* 4c */
+	0x1f,	/* 4e */
+	0,	/* 50 */
+	0x05,	/* 52 PM_MRK_BR_TAKEN, PM_MRK_BR_MPRED */
+	0x1c,	/* 54 PM_MRK_PTEG_FROM_L3MISS, PM_MRK_PTEG_FROM_L2MISS */
+	0x02,	/* 56 PM_MRK_LD_MISS_L1 */
+	0,	/* 58 */
+	0,	/* 5a */
+	0,	/* 5c */
+	0,	/* 5e */
+};
+
+/*
+ * Masks showing for each unit which bits are marked events.
+ * These masks are in LE order, i.e. 0x00000001 is byte 0, bit 0.
+ */
+static u32 marked_bus_events[16] = {
+	0x01000000,	/* direct events set 1: byte 3 bit 0 */
+	0x00010000,	/* direct events set 2: byte 2 bit 0 */
+	0, 0, 0, 0,	/* IDU, IFU, nest: nothing */
+	0x00000088,	/* VMX set 1: byte 0 bits 3, 7 */
+	0x000000c0,	/* VMX set 2: byte 0 bits 4-7 */
+	0x04010000,	/* LSU set 1: byte 2 bit 0, byte 3 bit 2 */
+	0xff010000u,	/* LSU set 2: byte 2 bit 0, all of byte 3 */
+	0,		/* LSU set 3 */
+	0x00000010,	/* VMX set 3: byte 0 bit 4 */
+	0,		/* BFP set 1 */
+	0x00000022,	/* BFP set 2: byte 0 bits 1, 5 */
+	0, 0
+};
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int power6_marked_instr_event(u64 event)
+{
+	int pmc, psel, ptype;
+	int bit, byte, unit;
+	u32 mask;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = (event & PM_PMCSEL_MSK) >> 1;	/* drop edge/level bit */
+	if (pmc >= 5)
+		return 0;
+
+	bit = -1;
+	if (psel < sizeof(direct_event_is_marked)) {
+		ptype = direct_event_is_marked[psel];
+		if (pmc == 0 || !(ptype & (1 << (pmc - 1))))
+			return 0;
+		ptype >>= 4;
+		if (ptype == 0)
+			return 1;
+		if (ptype == 1)
+			bit = 0;
+		else
+			bit = ptype ^ (pmc - 1);
+	} else if ((psel & 0x48) == 0x40)
+		bit = psel & 7;
+
+	if (!(event & PM_BUSEVENT_MSK) || bit == -1)
+		return 0;
+
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	mask = marked_bus_events[unit];
+	return (mask >> (byte * 8 + bit)) & 1;
+}
+
+/*
+ * Assign PMC numbers and compute MMCR1 value for a set of events
+ */
+static int p6_compute_mmcr(u64 event[], int n_ev,
+			   unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr1 = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
+	int i;
+	unsigned int pmc, ev, b, u, s, psel;
+	unsigned int ttmset = 0;
+	unsigned int pmc_inuse = 0;
+
+	if (n_ev > 6)
+		return -1;
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;	/* collision! */
+			pmc_inuse |= 1 << (pmc - 1);
+		}
+	}
+	for (i = 0; i < n_ev; ++i) {
+		ev = event[i];
+		pmc = (ev >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			--pmc;
+		} else {
+			/* can go on any PMC; find a free one */
+			for (pmc = 0; pmc < 4; ++pmc)
+				if (!(pmc_inuse & (1 << pmc)))
+					break;
+			if (pmc >= 4)
+				return -1;
+			pmc_inuse |= 1 << pmc;
+		}
+		hwc[i] = pmc;
+		psel = ev & PM_PMCSEL_MSK;
+		if (ev & PM_BUSEVENT_MSK) {
+			/* this event uses the event bus */
+			b = (ev >> PM_BYTE_SH) & PM_BYTE_MSK;
+			u = (ev >> PM_UNIT_SH) & PM_UNIT_MSK;
+			/* check for conflict on this byte of event bus */
+			if ((ttmset & (1 << b)) && MMCR1_TTMSEL(mmcr1, b) != u)
+				return -1;
+			mmcr1 |= (unsigned long)u << MMCR1_TTMSEL_SH(b);
+			ttmset |= 1 << b;
+			if (u == 5) {
+				/* Nest events have a further mux */
+				s = (ev >> PM_SUBUNIT_SH) & PM_SUBUNIT_MSK;
+				if ((ttmset & 0x10) &&
+				    MMCR1_NESTSEL(mmcr1) != s)
+					return -1;
+				ttmset |= 0x10;
+				mmcr1 |= (unsigned long)s << MMCR1_NESTSEL_SH;
+			}
+			if (0x30 <= psel && psel <= 0x3d) {
+				/* these need the PMCx_ADDR_SEL bits */
+				if (b >= 2)
+					mmcr1 |= MMCR1_PMC1_ADDR_SEL >> pmc;
+			}
+			/* bus select values are different for PMC3/4 */
+			if (pmc >= 2 && (psel & 0x90) == 0x80)
+				psel ^= 0x20;
+		}
+		if (ev & PM_LLA) {
+			mmcr1 |= MMCR1_PMC1_LLA >> pmc;
+			if (ev & PM_LLAV)
+				mmcr1 |= MMCR1_PMC1_LLA_VALUE >> pmc;
+		}
+		if (power6_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+		if (pmc < 4)
+			mmcr1 |= (unsigned long)psel << MMCR1_PMCSEL_SH(pmc);
+	}
+	mmcr[0] = 0;
+	if (pmc_inuse & 1)
+		mmcr[0] = MMCR0_PMC1CE;
+	if (pmc_inuse & 0xe)
+		mmcr[0] |= MMCR0_PMCjCE;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+/*
+ * Layout of constraint bits:
+ *
+ *	0-1	add field: number of uses of PMC1 (max 1)
+ *	2-3, 4-5, 6-7, 8-9, 10-11: ditto for PMC2, 3, 4, 5, 6
+ *	12-15	add field: number of uses of PMC1-4 (max 4)
+ *	16-19	select field: unit on byte 0 of event bus
+ *	20-23, 24-27, 28-31 ditto for bytes 1, 2, 3
+ *	32-34	select field: nest (subunit) event selector
+ */
+static int p6_get_constraint(u64 event, unsigned long *maskp,
+			     unsigned long *valp)
+{
+	int pmc, byte, sh, subunit;
+	unsigned long mask = 0, value = 0;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 4 && !(event == 0x500009 || event == 0x600005))
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+	}
+	if (event & PM_BUSEVENT_MSK) {
+		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+		sh = byte * 4 + (16 - PM_UNIT_SH);
+		mask |= PM_UNIT_MSKS << sh;
+		value |= (unsigned long)(event & PM_UNIT_MSKS) << sh;
+		if ((event & PM_UNIT_MSKS) == (5 << PM_UNIT_SH)) {
+			subunit = (event >> PM_SUBUNIT_SH) & PM_SUBUNIT_MSK;
+			mask  |= (unsigned long)PM_SUBUNIT_MSK << 32;
+			value |= (unsigned long)subunit << 32;
+		}
+	}
+	if (pmc <= 4) {
+		mask  |= 0x8000;	/* add field for count of PMC1-4 uses */
+		value |= 0x1000;
+	}
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+static int p6_limited_pmc_event(u64 event)
+{
+	int pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+
+	return pmc == 5 || pmc == 6;
+}
+
+#define MAX_ALT	4	/* at most 4 alternatives for any event */
+
+static const unsigned int event_alternatives[][MAX_ALT] = {
+	{ 0x0130e8, 0x2000f6, 0x3000fc },	/* PM_PTEG_RELOAD_VALID */
+	{ 0x080080, 0x10000d, 0x30000c, 0x4000f0 }, /* PM_LD_MISS_L1 */
+	{ 0x080088, 0x200054, 0x3000f0 },	/* PM_ST_MISS_L1 */
+	{ 0x10000a, 0x2000f4, 0x600005 },	/* PM_RUN_CYC */
+	{ 0x10000b, 0x2000f5 },			/* PM_RUN_COUNT */
+	{ 0x10000e, 0x400010 },			/* PM_PURR */
+	{ 0x100010, 0x4000f8 },			/* PM_FLUSH */
+	{ 0x10001a, 0x200010 },			/* PM_MRK_INST_DISP */
+	{ 0x100026, 0x3000f8 },			/* PM_TB_BIT_TRANS */
+	{ 0x100054, 0x2000f0 },			/* PM_ST_FIN */
+	{ 0x100056, 0x2000fc },			/* PM_L1_ICACHE_MISS */
+	{ 0x1000f0, 0x40000a },			/* PM_INST_IMC_MATCH_CMPL */
+	{ 0x1000f8, 0x200008 },			/* PM_GCT_EMPTY_CYC */
+	{ 0x1000fc, 0x400006 },			/* PM_LSU_DERAT_MISS_CYC */
+	{ 0x20000e, 0x400007 },			/* PM_LSU_DERAT_MISS */
+	{ 0x200012, 0x300012 },			/* PM_INST_DISP */
+	{ 0x2000f2, 0x3000f2 },			/* PM_INST_DISP */
+	{ 0x2000f8, 0x300010 },			/* PM_EXT_INT */
+	{ 0x2000fe, 0x300056 },			/* PM_DATA_FROM_L2MISS */
+	{ 0x2d0030, 0x30001a },			/* PM_MRK_FPU_FIN */
+	{ 0x30000a, 0x400018 },			/* PM_MRK_INST_FIN */
+	{ 0x3000f6, 0x40000e },			/* PM_L1_DCACHE_RELOAD_VALID */
+	{ 0x3000fe, 0x400056 },			/* PM_DATA_FROM_L3MISS */
+};
+
+/*
+ * This could be made more efficient with a binary search on
+ * a presorted list, if necessary
+ */
+static int find_alternatives_list(u64 event)
+{
+	int i, j;
+	unsigned int alt;
+
+	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
+		if (event < event_alternatives[i][0])
+			return -1;
+		for (j = 0; j < MAX_ALT; ++j) {
+			alt = event_alternatives[i][j];
+			if (!alt || event < alt)
+				break;
+			if (event == alt)
+				return i;
+		}
+	}
+	return -1;
+}
+
+static int p6_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, nlim;
+	unsigned int psel, pmc;
+	unsigned int nalt = 1;
+	u64 aevent;
+
+	alt[0] = event;
+	nlim = p6_limited_pmc_event(event);
+
+	/* check the alternatives table */
+	i = find_alternatives_list(event);
+	if (i >= 0) {
+		/* copy out alternatives from list */
+		for (j = 0; j < MAX_ALT; ++j) {
+			aevent = event_alternatives[i][j];
+			if (!aevent)
+				break;
+			if (aevent != event)
+				alt[nalt++] = aevent;
+			nlim += p6_limited_pmc_event(aevent);
+		}
+
+	} else {
+		/* Check for alternative ways of computing sum events */
+		/* PMCSEL 0x32 counter N == PMCSEL 0x34 counter 5-N */
+		psel = event & (PM_PMCSEL_MSK & ~1);	/* ignore edge bit */
+		pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc && (psel == 0x32 || psel == 0x34))
+			alt[nalt++] = ((event ^ 0x6) & ~PM_PMC_MSKS) |
+				((5 - pmc) << PM_PMC_SH);
+
+		/* PMCSEL 0x38 counter N == PMCSEL 0x3a counter N+/-2 */
+		if (pmc && (psel == 0x38 || psel == 0x3a))
+			alt[nalt++] = ((event ^ 0x2) & ~PM_PMC_MSKS) |
+				((pmc > 2? pmc - 2: pmc + 2) << PM_PMC_SH);
+	}
+
+	if (flags & PPMU_ONLY_COUNT_RUN) {
+		/*
+		 * We're only counting in RUN state,
+		 * so PM_CYC is equivalent to PM_RUN_CYC,
+		 * PM_INST_CMPL === PM_RUN_INST_CMPL, PM_PURR === PM_RUN_PURR.
+		 * This doesn't include alternatives that don't provide
+		 * any extra flexibility in assigning PMCs (e.g.
+		 * 0x10000a for PM_RUN_CYC vs. 0x1e for PM_CYC).
+		 * Note that even with these additional alternatives
+		 * we never end up with more than 4 alternatives for any event.
+		 */
+		j = nalt;
+		for (i = 0; i < nalt; ++i) {
+			switch (alt[i]) {
+			case 0x1e:	/* PM_CYC */
+				alt[j++] = 0x600005;	/* PM_RUN_CYC */
+				++nlim;
+				break;
+			case 0x10000a:	/* PM_RUN_CYC */
+				alt[j++] = 0x1e;	/* PM_CYC */
+				break;
+			case 2:		/* PM_INST_CMPL */
+				alt[j++] = 0x500009;	/* PM_RUN_INST_CMPL */
+				++nlim;
+				break;
+			case 0x500009:	/* PM_RUN_INST_CMPL */
+				alt[j++] = 2;		/* PM_INST_CMPL */
+				break;
+			case 0x10000e:	/* PM_PURR */
+				alt[j++] = 0x4000f4;	/* PM_RUN_PURR */
+				break;
+			case 0x4000f4:	/* PM_RUN_PURR */
+				alt[j++] = 0x10000e;	/* PM_PURR */
+				break;
+			}
+		}
+		nalt = j;
+	}
+
+	if (!(flags & PPMU_LIMITED_PMC_OK) && nlim) {
+		/* remove the limited PMC events */
+		j = 0;
+		for (i = 0; i < nalt; ++i) {
+			if (!p6_limited_pmc_event(alt[i])) {
+				alt[j] = alt[i];
+				++j;
+			}
+		}
+		nalt = j;
+	} else if ((flags & PPMU_LIMITED_PMC_REQD) && nlim < nalt) {
+		/* remove all but the limited PMC events */
+		j = 0;
+		for (i = 0; i < nalt; ++i) {
+			if (p6_limited_pmc_event(alt[i])) {
+				alt[j] = alt[i];
+				++j;
+			}
+		}
+		nalt = j;
+	}
+
+	return nalt;
+}
+
+static void p6_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	/* Set PMCxSEL to 0 to disable PMCx */
+	if (pmc <= 3)
+		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
+}
+
+static int power6_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x1e,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 2,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x280030, /* LD_REF_L1 */
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x30000c, /* LD_MISS_L1 */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x410a0,  /* BR_PRED */
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x400052, /* BR_MPRED */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ * The "DTLB" and "ITLB" events relate to the DERAT and IERAT.
+ */
+static int power6_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x280030,	0x80080		},
+		[C(OP_WRITE)] = {	0x180032,	0x80088		},
+		[C(OP_PREFETCH)] = {	0x810a4,	0		},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x100056 	},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	0x4008c,	0		},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x150730,	0x250532	},
+		[C(OP_WRITE)] = {	0x250432,	0x150432	},
+		[C(OP_PREFETCH)] = {	0x810a6,	0		},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x20000e	},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x420ce		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x430e6,	0x400052	},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1		},
+		[C(OP_WRITE)] = {	-1,		-1		},
+		[C(OP_PREFETCH)] = {	-1,		-1		},
+	},
+};
+
+static struct power_pmu power6_pmu = {
+	.name			= "POWER6",
+	.n_counter		= 6,
+	.max_alternatives	= MAX_ALT,
+	.add_fields		= 0x1555,
+	.test_adder		= 0x3000,
+	.compute_mmcr		= p6_compute_mmcr,
+	.get_constraint		= p6_get_constraint,
+	.get_alternatives	= p6_get_alternatives,
+	.disable_pmc		= p6_disable_pmc,
+	.limited_pmc_event	= p6_limited_pmc_event,
+	.flags			= PPMU_LIMITED_PMC5_6 | PPMU_ALT_SIPR,
+	.n_generic		= ARRAY_SIZE(power6_generic_events),
+	.generic_events		= power6_generic_events,
+	.cache_events		= &power6_cache_events,
+};
+
+static int __init init_power6_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
+		return -ENODEV;
+
+	return register_power_pmu(&power6_pmu);
+}
+
+early_initcall(init_power6_pmu);
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
new file mode 100644
index 0000000..1251e4d
--- /dev/null
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -0,0 +1,379 @@
+/*
+ * Performance counter support for POWER7 processors.
+ *
+ * Copyright 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Bits in event code for POWER7
+ */
+#define PM_PMC_SH	16	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0xf
+#define PM_PMC_MSKS	(PM_PMC_MSK << PM_PMC_SH)
+#define PM_UNIT_SH	12	/* TTMMUX number and setting - unit select */
+#define PM_UNIT_MSK	0xf
+#define PM_COMBINE_SH	11	/* Combined event bit */
+#define PM_COMBINE_MSK	1
+#define PM_COMBINE_MSKS	0x800
+#define PM_L2SEL_SH	8	/* L2 event select */
+#define PM_L2SEL_MSK	7
+#define PM_PMCSEL_MSK	0xff
+
+/*
+ * Bits in MMCR1 for POWER7
+ */
+#define MMCR1_TTM0SEL_SH	60
+#define MMCR1_TTM1SEL_SH	56
+#define MMCR1_TTM2SEL_SH	52
+#define MMCR1_TTM3SEL_SH	48
+#define MMCR1_TTMSEL_MSK	0xf
+#define MMCR1_L2SEL_SH		45
+#define MMCR1_L2SEL_MSK		7
+#define MMCR1_PMC1_COMBINE_SH	35
+#define MMCR1_PMC2_COMBINE_SH	34
+#define MMCR1_PMC3_COMBINE_SH	33
+#define MMCR1_PMC4_COMBINE_SH	32
+#define MMCR1_PMC1SEL_SH	24
+#define MMCR1_PMC2SEL_SH	16
+#define MMCR1_PMC3SEL_SH	8
+#define MMCR1_PMC4SEL_SH	0
+#define MMCR1_PMCSEL_SH(n)	(MMCR1_PMC1SEL_SH - (n) * 8)
+#define MMCR1_PMCSEL_MSK	0xff
+
+/*
+ * Layout of constraint bits:
+ * 6666555555555544444444443333333333222222222211111111110000000000
+ * 3210987654321098765432109876543210987654321098765432109876543210
+ *                                                 [  ><><><><><><>
+ *                                                  NC P6P5P4P3P2P1
+ *
+ * NC - number of counters
+ *     15: NC error 0x8000
+ *     12-14: number of events needing PMC1-4 0x7000
+ *
+ * P6
+ *     11: P6 error 0x800
+ *     10-11: Count of events needing PMC6
+ *
+ * P1..P5
+ *     0-9: Count of events needing PMC1..PMC5
+ */
+
+static int power7_get_constraint(u64 event, unsigned long *maskp,
+				 unsigned long *valp)
+{
+	int pmc, sh;
+	unsigned long mask = 0, value = 0;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 6)
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+		if (pmc >= 5 && !(event == 0x500fa || event == 0x600f4))
+			return -1;
+	}
+	if (pmc < 5) {
+		/* need a counter from PMC1-4 set */
+		mask  |= 0x8000;
+		value |= 0x1000;
+	}
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+#define MAX_ALT	2	/* at most 2 alternatives for any event */
+
+static const unsigned int event_alternatives[][MAX_ALT] = {
+	{ 0x200f2, 0x300f2 },		/* PM_INST_DISP */
+	{ 0x200f4, 0x600f4 },		/* PM_RUN_CYC */
+	{ 0x400fa, 0x500fa },		/* PM_RUN_INST_CMPL */
+};
+
+/*
+ * Scan the alternatives table for a match and return the
+ * index into the alternatives table if found, else -1.
+ */
+static int find_alternative(u64 event)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
+		if (event < event_alternatives[i][0])
+			break;
+		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
+			if (event == event_alternatives[i][j])
+				return i;
+	}
+	return -1;
+}
+
+static s64 find_alternative_decode(u64 event)
+{
+	int pmc, psel;
+
+	/* this only handles the 4x decode events */
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = event & PM_PMCSEL_MSK;
+	if ((pmc == 2 || pmc == 4) && (psel & ~7) == 0x40)
+		return event - (1 << PM_PMC_SH) + 8;
+	if ((pmc == 1 || pmc == 3) && (psel & ~7) == 0x48)
+		return event + (1 << PM_PMC_SH) - 8;
+	return -1;
+}
+
+static int power7_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int i, j, nalt = 1;
+	s64 ae;
+
+	alt[0] = event;
+	nalt = 1;
+	i = find_alternative(event);
+	if (i >= 0) {
+		for (j = 0; j < MAX_ALT; ++j) {
+			ae = event_alternatives[i][j];
+			if (ae && ae != event)
+				alt[nalt++] = ae;
+		}
+	} else {
+		ae = find_alternative_decode(event);
+		if (ae > 0)
+			alt[nalt++] = ae;
+	}
+
+	if (flags & PPMU_ONLY_COUNT_RUN) {
+		/*
+		 * We're only counting in RUN state,
+		 * so PM_CYC is equivalent to PM_RUN_CYC
+		 * and PM_INST_CMPL === PM_RUN_INST_CMPL.
+		 * This doesn't include alternatives that don't provide
+		 * any extra flexibility in assigning PMCs.
+		 */
+		j = nalt;
+		for (i = 0; i < nalt; ++i) {
+			switch (alt[i]) {
+			case 0x1e:	/* PM_CYC */
+				alt[j++] = 0x600f4;	/* PM_RUN_CYC */
+				break;
+			case 0x600f4:	/* PM_RUN_CYC */
+				alt[j++] = 0x1e;
+				break;
+			case 0x2:	/* PM_PPC_CMPL */
+				alt[j++] = 0x500fa;	/* PM_RUN_INST_CMPL */
+				break;
+			case 0x500fa:	/* PM_RUN_INST_CMPL */
+				alt[j++] = 0x2;	/* PM_PPC_CMPL */
+				break;
+			}
+		}
+		nalt = j;
+	}
+
+	return nalt;
+}
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int power7_marked_instr_event(u64 event)
+{
+	int pmc, psel;
+	int unit;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	psel = event & PM_PMCSEL_MSK & ~1;	/* trim off edge/level bit */
+	if (pmc >= 5)
+		return 0;
+
+	switch (psel >> 4) {
+	case 2:
+		return pmc == 2 || pmc == 4;
+	case 3:
+		if (psel == 0x3c)
+			return pmc == 1;
+		if (psel == 0x3e)
+			return pmc != 2;
+		return 1;
+	case 4:
+	case 5:
+		return unit == 0xd;
+	case 6:
+		if (psel == 0x64)
+			return pmc >= 3;
+	case 8:
+		return unit == 0xd;
+	}
+	return 0;
+}
+
+static int power7_compute_mmcr(u64 event[], int n_ev,
+			       unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr1 = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
+	unsigned int pmc, unit, combine, l2sel, psel;
+	unsigned int pmc_inuse = 0;
+	int i;
+
+	/* First pass to count resource use */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc > 6)
+				return -1;
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;
+			pmc_inuse |= 1 << (pmc - 1);
+		}
+	}
+
+	/* Second pass: assign PMCs, set all MMCR1 fields */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		combine = (event[i] >> PM_COMBINE_SH) & PM_COMBINE_MSK;
+		l2sel = (event[i] >> PM_L2SEL_SH) & PM_L2SEL_MSK;
+		psel = event[i] & PM_PMCSEL_MSK;
+		if (!pmc) {
+			/* Bus event or any-PMC direct event */
+			for (pmc = 0; pmc < 4; ++pmc) {
+				if (!(pmc_inuse & (1 << pmc)))
+					break;
+			}
+			if (pmc >= 4)
+				return -1;
+			pmc_inuse |= 1 << pmc;
+		} else {
+			/* Direct or decoded event */
+			--pmc;
+		}
+		if (pmc <= 3) {
+			mmcr1 |= (unsigned long) unit
+				<< (MMCR1_TTM0SEL_SH - 4 * pmc);
+			mmcr1 |= (unsigned long) combine
+				<< (MMCR1_PMC1_COMBINE_SH - pmc);
+			mmcr1 |= psel << MMCR1_PMCSEL_SH(pmc);
+			if (unit == 6)	/* L2 events */
+				mmcr1 |= (unsigned long) l2sel
+					<< MMCR1_L2SEL_SH;
+		}
+		if (power7_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+		hwc[i] = pmc;
+	}
+
+	/* Return MMCRx values */
+	mmcr[0] = 0;
+	if (pmc_inuse & 1)
+		mmcr[0] = MMCR0_PMC1CE;
+	if (pmc_inuse & 0x3e)
+		mmcr[0] |= MMCR0_PMCjCE;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	if (pmc <= 3)
+		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
+}
+
+static int power7_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
+	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
+	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
+	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x10068,	/* BRU_FIN	*/
+	[PERF_COUNT_HW_BRANCH_MISSES] = 0x400f6,	/* BR_MPRED	*/
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int power7_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0xc880,		0x400f0	},
+		[C(OP_WRITE)] = {	0,		0x300f0	},
+		[C(OP_PREFETCH)] = {	0xd8b8,		0	},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x200fc	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	0x408a,		0	},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x16080,	0x26080	},
+		[C(OP_WRITE)] = {	0x16082,	0x26082	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x300fc	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x400fc	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x10068,	0x400f6	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+static struct power_pmu power7_pmu = {
+	.name			= "POWER7",
+	.n_counter		= 6,
+	.max_alternatives	= MAX_ALT + 1,
+	.add_fields		= 0x1555ul,
+	.test_adder		= 0x3000ul,
+	.compute_mmcr		= power7_compute_mmcr,
+	.get_constraint		= power7_get_constraint,
+	.get_alternatives	= power7_get_alternatives,
+	.disable_pmc		= power7_disable_pmc,
+	.flags			= PPMU_ALT_SIPR,
+	.n_generic		= ARRAY_SIZE(power7_generic_events),
+	.generic_events		= power7_generic_events,
+	.cache_events		= &power7_cache_events,
+};
+
+static int __init init_power7_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
+		return -ENODEV;
+
+	return register_power_pmu(&power7_pmu);
+}
+
+early_initcall(init_power7_pmu);
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
new file mode 100644
index 0000000..111eb25
--- /dev/null
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -0,0 +1,502 @@
+/*
+ * Performance counter support for PPC970-family processors.
+ *
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
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
+ * Bits in event code for PPC970
+ */
+#define PM_PMC_SH	12	/* PMC number (1-based) for direct events */
+#define PM_PMC_MSK	0xf
+#define PM_UNIT_SH	8	/* TTMMUX number and setting - unit select */
+#define PM_UNIT_MSK	0xf
+#define PM_SPCSEL_SH	6
+#define PM_SPCSEL_MSK	3
+#define PM_BYTE_SH	4	/* Byte number of event bus to use */
+#define PM_BYTE_MSK	3
+#define PM_PMCSEL_MSK	0xf
+
+/* Values in PM_UNIT field */
+#define PM_NONE		0
+#define PM_FPU		1
+#define PM_VPU		2
+#define PM_ISU		3
+#define PM_IFU		4
+#define PM_IDU		5
+#define PM_STS		6
+#define PM_LSU0		7
+#define PM_LSU1U	8
+#define PM_LSU1L	9
+#define PM_LASTUNIT	9
+
+/*
+ * Bits in MMCR0 for PPC970
+ */
+#define MMCR0_PMC1SEL_SH	8
+#define MMCR0_PMC2SEL_SH	1
+#define MMCR_PMCSEL_MSK		0x1f
+
+/*
+ * Bits in MMCR1 for PPC970
+ */
+#define MMCR1_TTM0SEL_SH	62
+#define MMCR1_TTM1SEL_SH	59
+#define MMCR1_TTM3SEL_SH	53
+#define MMCR1_TTMSEL_MSK	3
+#define MMCR1_TD_CP_DBG0SEL_SH	50
+#define MMCR1_TD_CP_DBG1SEL_SH	48
+#define MMCR1_TD_CP_DBG2SEL_SH	46
+#define MMCR1_TD_CP_DBG3SEL_SH	44
+#define MMCR1_PMC1_ADDER_SEL_SH	39
+#define MMCR1_PMC2_ADDER_SEL_SH	38
+#define MMCR1_PMC6_ADDER_SEL_SH	37
+#define MMCR1_PMC5_ADDER_SEL_SH	36
+#define MMCR1_PMC8_ADDER_SEL_SH	35
+#define MMCR1_PMC7_ADDER_SEL_SH	34
+#define MMCR1_PMC3_ADDER_SEL_SH	33
+#define MMCR1_PMC4_ADDER_SEL_SH	32
+#define MMCR1_PMC3SEL_SH	27
+#define MMCR1_PMC4SEL_SH	22
+#define MMCR1_PMC5SEL_SH	17
+#define MMCR1_PMC6SEL_SH	12
+#define MMCR1_PMC7SEL_SH	7
+#define MMCR1_PMC8SEL_SH	2
+
+static short mmcr1_adder_bits[8] = {
+	MMCR1_PMC1_ADDER_SEL_SH,
+	MMCR1_PMC2_ADDER_SEL_SH,
+	MMCR1_PMC3_ADDER_SEL_SH,
+	MMCR1_PMC4_ADDER_SEL_SH,
+	MMCR1_PMC5_ADDER_SEL_SH,
+	MMCR1_PMC6_ADDER_SEL_SH,
+	MMCR1_PMC7_ADDER_SEL_SH,
+	MMCR1_PMC8_ADDER_SEL_SH
+};
+
+/*
+ * Layout of constraint bits:
+ * 6666555555555544444444443333333333222222222211111111110000000000
+ * 3210987654321098765432109876543210987654321098765432109876543210
+ *               <><><>[  >[  >[  ><  ><  ><  ><  ><><><><><><><><>
+ *               SPT0T1 UC  PS1 PS2 B0  B1  B2  B3 P1P2P3P4P5P6P7P8
+ *
+ * SP - SPCSEL constraint
+ *     48-49: SPCSEL value 0x3_0000_0000_0000
+ *
+ * T0 - TTM0 constraint
+ *     46-47: TTM0SEL value (0=FPU, 2=IFU, 3=VPU) 0xC000_0000_0000
+ *
+ * T1 - TTM1 constraint
+ *     44-45: TTM1SEL value (0=IDU, 3=STS) 0x3000_0000_0000
+ *
+ * UC - unit constraint: can't have all three of FPU|IFU|VPU, ISU, IDU|STS
+ *     43: UC3 error 0x0800_0000_0000
+ *     42: FPU|IFU|VPU events needed 0x0400_0000_0000
+ *     41: ISU events needed 0x0200_0000_0000
+ *     40: IDU|STS events needed 0x0100_0000_0000
+ *
+ * PS1
+ *     39: PS1 error 0x0080_0000_0000
+ *     36-38: count of events needing PMC1/2/5/6 0x0070_0000_0000
+ *
+ * PS2
+ *     35: PS2 error 0x0008_0000_0000
+ *     32-34: count of events needing PMC3/4/7/8 0x0007_0000_0000
+ *
+ * B0
+ *     28-31: Byte 0 event source 0xf000_0000
+ *	      Encoding as for the event code
+ *
+ * B1, B2, B3
+ *     24-27, 20-23, 16-19: Byte 1, 2, 3 event sources
+ *
+ * P1
+ *     15: P1 error 0x8000
+ *     14-15: Count of events needing PMC1
+ *
+ * P2..P8
+ *     0-13: Count of events needing PMC2..PMC8
+ */
+
+static unsigned char direct_marked_event[8] = {
+	(1<<2) | (1<<3),	/* PMC1: PM_MRK_GRP_DISP, PM_MRK_ST_CMPL */
+	(1<<3) | (1<<5),	/* PMC2: PM_THRESH_TIMEO, PM_MRK_BRU_FIN */
+	(1<<3) | (1<<5),	/* PMC3: PM_MRK_ST_CMPL_INT, PM_MRK_VMX_FIN */
+	(1<<4) | (1<<5),	/* PMC4: PM_MRK_GRP_CMPL, PM_MRK_CRU_FIN */
+	(1<<4) | (1<<5),	/* PMC5: PM_GRP_MRK, PM_MRK_GRP_TIMEO */
+	(1<<3) | (1<<4) | (1<<5),
+		/* PMC6: PM_MRK_ST_STS, PM_MRK_FXU_FIN, PM_MRK_GRP_ISSUED */
+	(1<<4) | (1<<5),	/* PMC7: PM_MRK_FPU_FIN, PM_MRK_INST_FIN */
+	(1<<4)			/* PMC8: PM_MRK_LSU_FIN */
+};
+
+/*
+ * Returns 1 if event counts things relating to marked instructions
+ * and thus needs the MMCRA_SAMPLE_ENABLE bit set, or 0 if not.
+ */
+static int p970_marked_instr_event(u64 event)
+{
+	int pmc, psel, unit, byte, bit;
+	unsigned int mask;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	psel = event & PM_PMCSEL_MSK;
+	if (pmc) {
+		if (direct_marked_event[pmc - 1] & (1 << psel))
+			return 1;
+		if (psel == 0)		/* add events */
+			bit = (pmc <= 4)? pmc - 1: 8 - pmc;
+		else if (psel == 7 || psel == 13)	/* decode events */
+			bit = 4;
+		else
+			return 0;
+	} else
+		bit = psel;
+
+	byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	mask = 0;
+	switch (unit) {
+	case PM_VPU:
+		mask = 0x4c;		/* byte 0 bits 2,3,6 */
+		break;
+	case PM_LSU0:
+		/* byte 2 bits 0,2,3,4,6; all of byte 1 */
+		mask = 0x085dff00;
+		break;
+	case PM_LSU1L:
+		mask = 0x50 << 24;	/* byte 3 bits 4,6 */
+		break;
+	}
+	return (mask >> (byte * 8 + bit)) & 1;
+}
+
+/* Masks and values for using events from the various units */
+static unsigned long unit_cons[PM_LASTUNIT+1][2] = {
+	[PM_FPU] =   { 0xc80000000000ull, 0x040000000000ull },
+	[PM_VPU] =   { 0xc80000000000ull, 0xc40000000000ull },
+	[PM_ISU] =   { 0x080000000000ull, 0x020000000000ull },
+	[PM_IFU] =   { 0xc80000000000ull, 0x840000000000ull },
+	[PM_IDU] =   { 0x380000000000ull, 0x010000000000ull },
+	[PM_STS] =   { 0x380000000000ull, 0x310000000000ull },
+};
+
+static int p970_get_constraint(u64 event, unsigned long *maskp,
+			       unsigned long *valp)
+{
+	int pmc, byte, unit, sh, spcsel;
+	unsigned long mask = 0, value = 0;
+	int grp = -1;
+
+	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
+	if (pmc) {
+		if (pmc > 8)
+			return -1;
+		sh = (pmc - 1) * 2;
+		mask |= 2 << sh;
+		value |= 1 << sh;
+		grp = ((pmc - 1) >> 1) & 1;
+	}
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	if (unit) {
+		if (unit > PM_LASTUNIT)
+			return -1;
+		mask |= unit_cons[unit][0];
+		value |= unit_cons[unit][1];
+		byte = (event >> PM_BYTE_SH) & PM_BYTE_MSK;
+		/*
+		 * Bus events on bytes 0 and 2 can be counted
+		 * on PMC1/2/5/6; bytes 1 and 3 on PMC3/4/7/8.
+		 */
+		if (!pmc)
+			grp = byte & 1;
+		/* Set byte lane select field */
+		mask  |= 0xfULL << (28 - 4 * byte);
+		value |= (unsigned long)unit << (28 - 4 * byte);
+	}
+	if (grp == 0) {
+		/* increment PMC1/2/5/6 field */
+		mask  |= 0x8000000000ull;
+		value |= 0x1000000000ull;
+	} else if (grp == 1) {
+		/* increment PMC3/4/7/8 field */
+		mask  |= 0x800000000ull;
+		value |= 0x100000000ull;
+	}
+	spcsel = (event >> PM_SPCSEL_SH) & PM_SPCSEL_MSK;
+	if (spcsel) {
+		mask  |= 3ull << 48;
+		value |= (unsigned long)spcsel << 48;
+	}
+	*maskp = mask;
+	*valp = value;
+	return 0;
+}
+
+static int p970_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	alt[0] = event;
+
+	/* 2 alternatives for LSU empty */
+	if (event == 0x2002 || event == 0x3002) {
+		alt[1] = event ^ 0x1000;
+		return 2;
+	}
+
+	return 1;
+}
+
+static int p970_compute_mmcr(u64 event[], int n_ev,
+			     unsigned int hwc[], unsigned long mmcr[])
+{
+	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
+	unsigned int pmc, unit, byte, psel;
+	unsigned int ttm, grp;
+	unsigned int pmc_inuse = 0;
+	unsigned int pmc_grp_use[2];
+	unsigned char busbyte[4];
+	unsigned char unituse[16];
+	unsigned char unitmap[] = { 0, 0<<3, 3<<3, 1<<3, 2<<3, 0|4, 3|4 };
+	unsigned char ttmuse[2];
+	unsigned char pmcsel[8];
+	int i;
+	int spcsel;
+
+	if (n_ev > 8)
+		return -1;
+
+	/* First pass to count resource use */
+	pmc_grp_use[0] = pmc_grp_use[1] = 0;
+	memset(busbyte, 0, sizeof(busbyte));
+	memset(unituse, 0, sizeof(unituse));
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		if (pmc) {
+			if (pmc_inuse & (1 << (pmc - 1)))
+				return -1;
+			pmc_inuse |= 1 << (pmc - 1);
+			/* count 1/2/5/6 vs 3/4/7/8 use */
+			++pmc_grp_use[((pmc - 1) >> 1) & 1];
+		}
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		if (unit) {
+			if (unit > PM_LASTUNIT)
+				return -1;
+			if (!pmc)
+				++pmc_grp_use[byte & 1];
+			if (busbyte[byte] && busbyte[byte] != unit)
+				return -1;
+			busbyte[byte] = unit;
+			unituse[unit] = 1;
+		}
+	}
+	if (pmc_grp_use[0] > 4 || pmc_grp_use[1] > 4)
+		return -1;
+
+	/*
+	 * Assign resources and set multiplexer selects.
+	 *
+	 * PM_ISU can go either on TTM0 or TTM1, but that's the only
+	 * choice we have to deal with.
+	 */
+	if (unituse[PM_ISU] &
+	    (unituse[PM_FPU] | unituse[PM_IFU] | unituse[PM_VPU]))
+		unitmap[PM_ISU] = 2 | 4;	/* move ISU to TTM1 */
+	/* Set TTM[01]SEL fields. */
+	ttmuse[0] = ttmuse[1] = 0;
+	for (i = PM_FPU; i <= PM_STS; ++i) {
+		if (!unituse[i])
+			continue;
+		ttm = unitmap[i];
+		++ttmuse[(ttm >> 2) & 1];
+		mmcr1 |= (unsigned long)(ttm & ~4) << MMCR1_TTM1SEL_SH;
+	}
+	/* Check only one unit per TTMx */
+	if (ttmuse[0] > 1 || ttmuse[1] > 1)
+		return -1;
+
+	/* Set byte lane select fields and TTM3SEL. */
+	for (byte = 0; byte < 4; ++byte) {
+		unit = busbyte[byte];
+		if (!unit)
+			continue;
+		if (unit <= PM_STS)
+			ttm = (unitmap[unit] >> 2) & 1;
+		else if (unit == PM_LSU0)
+			ttm = 2;
+		else {
+			ttm = 3;
+			if (unit == PM_LSU1L && byte >= 2)
+				mmcr1 |= 1ull << (MMCR1_TTM3SEL_SH + 3 - byte);
+		}
+		mmcr1 |= (unsigned long)ttm
+			<< (MMCR1_TD_CP_DBG0SEL_SH - 2 * byte);
+	}
+
+	/* Second pass: assign PMCs, set PMCxSEL and PMCx_ADDER_SEL fields */
+	memset(pmcsel, 0x8, sizeof(pmcsel));	/* 8 means don't count */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> PM_PMC_SH) & PM_PMC_MSK;
+		unit = (event[i] >> PM_UNIT_SH) & PM_UNIT_MSK;
+		byte = (event[i] >> PM_BYTE_SH) & PM_BYTE_MSK;
+		psel = event[i] & PM_PMCSEL_MSK;
+		if (!pmc) {
+			/* Bus event or any-PMC direct event */
+			if (unit)
+				psel |= 0x10 | ((byte & 2) << 2);
+			else
+				psel |= 8;
+			for (pmc = 0; pmc < 8; ++pmc) {
+				if (pmc_inuse & (1 << pmc))
+					continue;
+				grp = (pmc >> 1) & 1;
+				if (unit) {
+					if (grp == (byte & 1))
+						break;
+				} else if (pmc_grp_use[grp] < 4) {
+					++pmc_grp_use[grp];
+					break;
+				}
+			}
+			pmc_inuse |= 1 << pmc;
+		} else {
+			/* Direct event */
+			--pmc;
+			if (psel == 0 && (byte & 2))
+				/* add events on higher-numbered bus */
+				mmcr1 |= 1ull << mmcr1_adder_bits[pmc];
+		}
+		pmcsel[pmc] = psel;
+		hwc[i] = pmc;
+		spcsel = (event[i] >> PM_SPCSEL_SH) & PM_SPCSEL_MSK;
+		mmcr1 |= spcsel;
+		if (p970_marked_instr_event(event[i]))
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+	}
+	for (pmc = 0; pmc < 2; ++pmc)
+		mmcr0 |= pmcsel[pmc] << (MMCR0_PMC1SEL_SH - 7 * pmc);
+	for (; pmc < 8; ++pmc)
+		mmcr1 |= (unsigned long)pmcsel[pmc]
+			<< (MMCR1_PMC3SEL_SH - 5 * (pmc - 2));
+	if (pmc_inuse & 1)
+		mmcr0 |= MMCR0_PMC1CE;
+	if (pmc_inuse & 0xfe)
+		mmcr0 |= MMCR0_PMCjCE;
+
+	mmcra |= 0x2000;	/* mark only one IOP per PPC instruction */
+
+	/* Return MMCRx values */
+	mmcr[0] = mmcr0;
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	return 0;
+}
+
+static void p970_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	int shift, i;
+
+	if (pmc <= 1) {
+		shift = MMCR0_PMC1SEL_SH - 7 * pmc;
+		i = 0;
+	} else {
+		shift = MMCR1_PMC3SEL_SH - 5 * (pmc - 2);
+		i = 1;
+	}
+	/*
+	 * Setting the PMCxSEL field to 0x08 disables PMC x.
+	 */
+	mmcr[i] = (mmcr[i] & ~(0x1fUL << shift)) | (0x08UL << shift);
+}
+
+static int ppc970_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= 7,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 1,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x8810, /* PM_LD_REF_L1 */
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x3810, /* PM_LD_MISS_L1 */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x431,  /* PM_BR_ISSUED */
+	[PERF_COUNT_HW_BRANCH_MISSES] 		= 0x327,  /* PM_GRP_BR_MPRED */
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int ppc970_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x8810,		0x3810	},
+		[C(OP_WRITE)] = {	0x7810,		0x813	},
+		[C(OP_PREFETCH)] = {	0x731,		0	},
+	},
+	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0x733,		0	},
+	},
+	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x704	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(ITLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0,		0x700	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	0x431,		0x327	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(NODE)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+static struct power_pmu ppc970_pmu = {
+	.name			= "PPC970/FX/MP",
+	.n_counter		= 8,
+	.max_alternatives	= 2,
+	.add_fields		= 0x001100005555ull,
+	.test_adder		= 0x013300000000ull,
+	.compute_mmcr		= p970_compute_mmcr,
+	.get_constraint		= p970_get_constraint,
+	.get_alternatives	= p970_get_alternatives,
+	.disable_pmc		= p970_disable_pmc,
+	.n_generic		= ARRAY_SIZE(ppc970_generic_events),
+	.generic_events		= ppc970_generic_events,
+	.cache_events		= &ppc970_cache_events,
+};
+
+static int __init init_ppc970_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
+	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
+		return -ENODEV;
+
+	return register_power_pmu(&ppc970_pmu);
+}
+
+early_initcall(init_ppc970_pmu);
-- 
1.7.5.4
