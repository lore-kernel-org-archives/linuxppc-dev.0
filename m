Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rczmB0rf8zDqlh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:29 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5QHXqwP029037
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 13:37:28 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sjufdnxt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 13:37:27 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 03:37:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E3FA62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5QHbLFa8651116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5QHbLgO025805
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:37:21 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/6] powerpc/perf: factor out power8 pmu functions
Date: Sun, 26 Jun 2016 23:07:05 +0530
In-Reply-To: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1466962629-30692-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1466962629-30692-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out some of the power8 pmu functions
to new file "isa207-common.c" to share with
power9 pmu code. Only code movement and no
logic change

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile        |   2 +-
 arch/powerpc/perf/isa207-common.c | 263 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h |   6 +
 arch/powerpc/perf/power8-pmu.c    | 256 +------------------------------------
 4 files changed, 273 insertions(+), 254 deletions(-)
 create mode 100644 arch/powerpc/perf/isa207-common.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 77b6394a7c50..92f8ea46238b 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   power8-pmu.o
+				   isa207-common.o power8-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
new file mode 100644
index 000000000000..6143c99f3ec5
--- /dev/null
+++ b/arch/powerpc/perf/isa207-common.c
@@ -0,0 +1,263 @@
+/*
+ * Common Performance counter support functions for PowerISA v2.07 processors.
+ *
+ * Copyright 2009 Paul Mackerras, IBM Corporation.
+ * Copyright 2013 Michael Ellerman, IBM Corporation.
+ * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "isa207-common.h"
+
+static inline bool event_is_fab_match(u64 event)
+{
+	/* Only check pmc, unit and pmcxsel, ignore the edge bit (0) */
+	event &= 0xff0fe;
+
+	/* PM_MRK_FAB_RSP_MATCH & PM_MRK_FAB_RSP_MATCH_CYC */
+	return (event == 0x30056 || event == 0x4f052);
+}
+
+int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
+{
+	unsigned int unit, pmc, cache, ebb;
+	unsigned long mask, value;
+
+	mask = value = 0;
+
+	if (event & ~EVENT_VALID_MASK)
+		return -1;
+
+	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
+	unit  = (event >> EVENT_UNIT_SHIFT)       & EVENT_UNIT_MASK;
+	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
+	ebb   = (event >> EVENT_EBB_SHIFT)        & EVENT_EBB_MASK;
+
+	if (pmc) {
+		u64 base_event;
+
+		if (pmc > 6)
+			return -1;
+
+		/* Ignore Linux defined bits when checking event below */
+		base_event = event & ~EVENT_LINUX_MASK;
+
+		if (pmc >= 5 && base_event != 0x500fa &&
+				base_event != 0x600f4)
+			return -1;
+
+		mask  |= CNST_PMC_MASK(pmc);
+		value |= CNST_PMC_VAL(pmc);
+	}
+
+	if (pmc <= 4) {
+		/*
+		 * Add to number of counters in use. Note this includes events with
+		 * a PMC of 0 - they still need a PMC, it's just assigned later.
+		 * Don't count events on PMC 5 & 6, there is only one valid event
+		 * on each of those counters, and they are handled above.
+		 */
+		mask  |= CNST_NC_MASK;
+		value |= CNST_NC_VAL;
+	}
+
+	if (unit >= 6 && unit <= 9) {
+		/*
+		 * L2/L3 events contain a cache selector field, which is
+		 * supposed to be programmed into MMCRC. However MMCRC is only
+		 * HV writable, and there is no API for guest kernels to modify
+		 * it. The solution is for the hypervisor to initialise the
+		 * field to zeroes, and for us to only ever allow events that
+		 * have a cache selector of zero. The bank selector (bit 3) is
+		 * irrelevant, as long as the rest of the value is 0.
+		 */
+		if (cache & 0x7)
+			return -1;
+
+	} else if (event & EVENT_IS_L1) {
+		mask  |= CNST_L1_QUAL_MASK;
+		value |= CNST_L1_QUAL_VAL(cache);
+	}
+
+	if (event & EVENT_IS_MARKED) {
+		mask  |= CNST_SAMPLE_MASK;
+		value |= CNST_SAMPLE_VAL(event >> EVENT_SAMPLE_SHIFT);
+	}
+
+	/*
+	 * Special case for PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
+	 * the threshold control bits are used for the match value.
+	 */
+	if (event_is_fab_match(event)) {
+		mask  |= CNST_FAB_MATCH_MASK;
+		value |= CNST_FAB_MATCH_VAL(event >> EVENT_THR_CTL_SHIFT);
+	} else {
+		/*
+		 * Check the mantissa upper two bits are not zero, unless the
+		 * exponent is also zero. See the THRESH_CMP_MANTISSA doc.
+		 */
+		unsigned int cmp, exp;
+
+		cmp = (event >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
+		exp = cmp >> 7;
+
+		if (exp && (cmp & 0x60) == 0)
+			return -1;
+
+		mask  |= CNST_THRESH_MASK;
+		value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
+	}
+
+	if (!pmc && ebb)
+		/* EBB events must specify the PMC */
+		return -1;
+
+	if (event & EVENT_WANTS_BHRB) {
+		if (!ebb)
+			/* Only EBB events can request BHRB */
+			return -1;
+
+		mask  |= CNST_IFM_MASK;
+		value |= CNST_IFM_VAL(event >> EVENT_IFM_SHIFT);
+	}
+
+	/*
+	 * All events must agree on EBB, either all request it or none.
+	 * EBB events are pinned & exclusive, so this should never actually
+	 * hit, but we leave it as a fallback in case.
+	 */
+	mask  |= CNST_EBB_VAL(ebb);
+	value |= CNST_EBB_MASK;
+
+	*maskp = mask;
+	*valp = value;
+
+	return 0;
+}
+
+int isa207_compute_mmcr(u64 event[], int n_ev,
+			       unsigned int hwc[], unsigned long mmcr[],
+			       struct perf_event *pevents[])
+{
+	unsigned long mmcra, mmcr1, mmcr2, unit, combine, psel, cache, val;
+	unsigned int pmc, pmc_inuse;
+	int i;
+
+	pmc_inuse = 0;
+
+	/* First pass to count resource use */
+	for (i = 0; i < n_ev; ++i) {
+		pmc = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+		if (pmc)
+			pmc_inuse |= 1 << pmc;
+	}
+
+	/* In continuous sampling mode, update SDAR on TLB miss */
+	mmcra = MMCRA_SDAR_MODE_TLB;
+	mmcr1 = mmcr2 = 0;
+
+	/* Second pass: assign PMCs, set all MMCR1 fields */
+	for (i = 0; i < n_ev; ++i) {
+		pmc     = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+		unit    = (event[i] >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
+		combine = (event[i] >> EVENT_COMBINE_SHIFT) & EVENT_COMBINE_MASK;
+		psel    =  event[i] & EVENT_PSEL_MASK;
+
+		if (!pmc) {
+			for (pmc = 1; pmc <= 4; ++pmc) {
+				if (!(pmc_inuse & (1 << pmc)))
+					break;
+			}
+
+			pmc_inuse |= 1 << pmc;
+		}
+
+		if (pmc <= 4) {
+			mmcr1 |= unit << MMCR1_UNIT_SHIFT(pmc);
+			mmcr1 |= combine << MMCR1_COMBINE_SHIFT(pmc);
+			mmcr1 |= psel << MMCR1_PMCSEL_SHIFT(pmc);
+		}
+
+		if (event[i] & EVENT_IS_L1) {
+			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
+			mmcr1 |= (cache & 1) << MMCR1_IC_QUAL_SHIFT;
+			cache >>= 1;
+			mmcr1 |= (cache & 1) << MMCR1_DC_QUAL_SHIFT;
+		}
+
+		if (event[i] & EVENT_IS_MARKED) {
+			mmcra |= MMCRA_SAMPLE_ENABLE;
+
+			val = (event[i] >> EVENT_SAMPLE_SHIFT) & EVENT_SAMPLE_MASK;
+			if (val) {
+				mmcra |= (val &  3) << MMCRA_SAMP_MODE_SHIFT;
+				mmcra |= (val >> 2) << MMCRA_SAMP_ELIG_SHIFT;
+			}
+		}
+
+		/*
+		 * PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
+		 * the threshold bits are used for the match value.
+		 */
+		if (event_is_fab_match(event[i])) {
+			mmcr1 |= ((event[i] >> EVENT_THR_CTL_SHIFT) &
+				  EVENT_THR_CTL_MASK) << MMCR1_FAB_SHIFT;
+		} else {
+			val = (event[i] >> EVENT_THR_CTL_SHIFT) & EVENT_THR_CTL_MASK;
+			mmcra |= val << MMCRA_THR_CTL_SHIFT;
+			val = (event[i] >> EVENT_THR_SEL_SHIFT) & EVENT_THR_SEL_MASK;
+			mmcra |= val << MMCRA_THR_SEL_SHIFT;
+			val = (event[i] >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
+			mmcra |= val << MMCRA_THR_CMP_SHIFT;
+		}
+
+		if (event[i] & EVENT_WANTS_BHRB) {
+			val = (event[i] >> EVENT_IFM_SHIFT) & EVENT_IFM_MASK;
+			mmcra |= val << MMCRA_IFM_SHIFT;
+		}
+
+		if (pevents[i]->attr.exclude_user)
+			mmcr2 |= MMCR2_FCP(pmc);
+
+		if (pevents[i]->attr.exclude_hv)
+			mmcr2 |= MMCR2_FCH(pmc);
+
+		if (pevents[i]->attr.exclude_kernel) {
+			if (cpu_has_feature(CPU_FTR_HVMODE))
+				mmcr2 |= MMCR2_FCH(pmc);
+			else
+				mmcr2 |= MMCR2_FCS(pmc);
+		}
+
+		hwc[i] = pmc - 1;
+	}
+
+	/* Return MMCRx values */
+	mmcr[0] = 0;
+
+	/* pmc_inuse is 1-based */
+	if (pmc_inuse & 2)
+		mmcr[0] = MMCR0_PMC1CE;
+
+	if (pmc_inuse & 0x7c)
+		mmcr[0] |= MMCR0_PMCjCE;
+
+	/* If we're not using PMC 5 or 6, freeze them */
+	if (!(pmc_inuse & 0x60))
+		mmcr[0] |= MMCR0_FC56;
+
+	mmcr[1] = mmcr1;
+	mmcr[2] = mmcra;
+	mmcr[3] = mmcr2;
+
+	return 0;
+}
+
+void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[])
+{
+	if (pmc <= 3)
+		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
+}
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 03205f5354e9..4d0a4e5017c2 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -227,4 +227,10 @@
 #define MAX_ALT				2
 #define MAX_PMU_COUNTERS		6
 
+int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp);
+int isa207_compute_mmcr(u64 event[], int n_ev,
+				unsigned int hwc[], unsigned long mmcr[],
+				struct perf_event *pevents[]);
+void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
+
 #endif
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 4303e9b91e43..5fde2b192fec 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -30,250 +30,6 @@ enum {
 #define	POWER8_MMCRA_IFM2		0x0000000080000000UL
 #define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
 
-static inline bool event_is_fab_match(u64 event)
-{
-	/* Only check pmc, unit and pmcxsel, ignore the edge bit (0) */
-	event &= 0xff0fe;
-
-	/* PM_MRK_FAB_RSP_MATCH & PM_MRK_FAB_RSP_MATCH_CYC */
-	return (event == 0x30056 || event == 0x4f052);
-}
-
-static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
-{
-	unsigned int unit, pmc, cache, ebb;
-	unsigned long mask, value;
-
-	mask = value = 0;
-
-	if (event & ~EVENT_VALID_MASK)
-		return -1;
-
-	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
-	unit  = (event >> EVENT_UNIT_SHIFT)       & EVENT_UNIT_MASK;
-	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
-	ebb   = (event >> EVENT_EBB_SHIFT)        & EVENT_EBB_MASK;
-
-	if (pmc) {
-		u64 base_event;
-
-		if (pmc > 6)
-			return -1;
-
-		/* Ignore Linux defined bits when checking event below */
-		base_event = event & ~EVENT_LINUX_MASK;
-
-		if (pmc >= 5 && base_event != PM_RUN_INST_CMPL &&
-				base_event != PM_RUN_CYC)
-			return -1;
-
-		mask  |= CNST_PMC_MASK(pmc);
-		value |= CNST_PMC_VAL(pmc);
-	}
-
-	if (pmc <= 4) {
-		/*
-		 * Add to number of counters in use. Note this includes events with
-		 * a PMC of 0 - they still need a PMC, it's just assigned later.
-		 * Don't count events on PMC 5 & 6, there is only one valid event
-		 * on each of those counters, and they are handled above.
-		 */
-		mask  |= CNST_NC_MASK;
-		value |= CNST_NC_VAL;
-	}
-
-	if (unit >= 6 && unit <= 9) {
-		/*
-		 * L2/L3 events contain a cache selector field, which is
-		 * supposed to be programmed into MMCRC. However MMCRC is only
-		 * HV writable, and there is no API for guest kernels to modify
-		 * it. The solution is for the hypervisor to initialise the
-		 * field to zeroes, and for us to only ever allow events that
-		 * have a cache selector of zero. The bank selector (bit 3) is
-		 * irrelevant, as long as the rest of the value is 0.
-		 */
-		if (cache & 0x7)
-			return -1;
-
-	} else if (event & EVENT_IS_L1) {
-		mask  |= CNST_L1_QUAL_MASK;
-		value |= CNST_L1_QUAL_VAL(cache);
-	}
-
-	if (event & EVENT_IS_MARKED) {
-		mask  |= CNST_SAMPLE_MASK;
-		value |= CNST_SAMPLE_VAL(event >> EVENT_SAMPLE_SHIFT);
-	}
-
-	/*
-	 * Special case for PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
-	 * the threshold control bits are used for the match value.
-	 */
-	if (event_is_fab_match(event)) {
-		mask  |= CNST_FAB_MATCH_MASK;
-		value |= CNST_FAB_MATCH_VAL(event >> EVENT_THR_CTL_SHIFT);
-	} else {
-		/*
-		 * Check the mantissa upper two bits are not zero, unless the
-		 * exponent is also zero. See the THRESH_CMP_MANTISSA doc.
-		 */
-		unsigned int cmp, exp;
-
-		cmp = (event >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
-		exp = cmp >> 7;
-
-		if (exp && (cmp & 0x60) == 0)
-			return -1;
-
-		mask  |= CNST_THRESH_MASK;
-		value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
-	}
-
-	if (!pmc && ebb)
-		/* EBB events must specify the PMC */
-		return -1;
-
-	if (event & EVENT_WANTS_BHRB) {
-		if (!ebb)
-			/* Only EBB events can request BHRB */
-			return -1;
-
-		mask  |= CNST_IFM_MASK;
-		value |= CNST_IFM_VAL(event >> EVENT_IFM_SHIFT);
-	}
-
-	/*
-	 * All events must agree on EBB, either all request it or none.
-	 * EBB events are pinned & exclusive, so this should never actually
-	 * hit, but we leave it as a fallback in case.
-	 */
-	mask  |= CNST_EBB_VAL(ebb);
-	value |= CNST_EBB_MASK;
-
-	*maskp = mask;
-	*valp = value;
-
-	return 0;
-}
-
-static int power8_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[],
-			       struct perf_event *pevents[])
-{
-	unsigned long mmcra, mmcr1, mmcr2, unit, combine, psel, cache, val;
-	unsigned int pmc, pmc_inuse;
-	int i;
-
-	pmc_inuse = 0;
-
-	/* First pass to count resource use */
-	for (i = 0; i < n_ev; ++i) {
-		pmc = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
-		if (pmc)
-			pmc_inuse |= 1 << pmc;
-	}
-
-	/* In continuous sampling mode, update SDAR on TLB miss */
-	mmcra = MMCRA_SDAR_MODE_TLB;
-	mmcr1 = mmcr2 = 0;
-
-	/* Second pass: assign PMCs, set all MMCR1 fields */
-	for (i = 0; i < n_ev; ++i) {
-		pmc     = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
-		unit    = (event[i] >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
-		combine = (event[i] >> EVENT_COMBINE_SHIFT) & EVENT_COMBINE_MASK;
-		psel    =  event[i] & EVENT_PSEL_MASK;
-
-		if (!pmc) {
-			for (pmc = 1; pmc <= 4; ++pmc) {
-				if (!(pmc_inuse & (1 << pmc)))
-					break;
-			}
-
-			pmc_inuse |= 1 << pmc;
-		}
-
-		if (pmc <= 4) {
-			mmcr1 |= unit << MMCR1_UNIT_SHIFT(pmc);
-			mmcr1 |= combine << MMCR1_COMBINE_SHIFT(pmc);
-			mmcr1 |= psel << MMCR1_PMCSEL_SHIFT(pmc);
-		}
-
-		if (event[i] & EVENT_IS_L1) {
-			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
-			mmcr1 |= (cache & 1) << MMCR1_IC_QUAL_SHIFT;
-			cache >>= 1;
-			mmcr1 |= (cache & 1) << MMCR1_DC_QUAL_SHIFT;
-		}
-
-		if (event[i] & EVENT_IS_MARKED) {
-			mmcra |= MMCRA_SAMPLE_ENABLE;
-
-			val = (event[i] >> EVENT_SAMPLE_SHIFT) & EVENT_SAMPLE_MASK;
-			if (val) {
-				mmcra |= (val &  3) << MMCRA_SAMP_MODE_SHIFT;
-				mmcra |= (val >> 2) << MMCRA_SAMP_ELIG_SHIFT;
-			}
-		}
-
-		/*
-		 * PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
-		 * the threshold bits are used for the match value.
-		 */
-		if (event_is_fab_match(event[i])) {
-			mmcr1 |= ((event[i] >> EVENT_THR_CTL_SHIFT) &
-				  EVENT_THR_CTL_MASK) << MMCR1_FAB_SHIFT;
-		} else {
-			val = (event[i] >> EVENT_THR_CTL_SHIFT) & EVENT_THR_CTL_MASK;
-			mmcra |= val << MMCRA_THR_CTL_SHIFT;
-			val = (event[i] >> EVENT_THR_SEL_SHIFT) & EVENT_THR_SEL_MASK;
-			mmcra |= val << MMCRA_THR_SEL_SHIFT;
-			val = (event[i] >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
-			mmcra |= val << MMCRA_THR_CMP_SHIFT;
-		}
-
-		if (event[i] & EVENT_WANTS_BHRB) {
-			val = (event[i] >> EVENT_IFM_SHIFT) & EVENT_IFM_MASK;
-			mmcra |= val << MMCRA_IFM_SHIFT;
-		}
-
-		if (pevents[i]->attr.exclude_user)
-			mmcr2 |= MMCR2_FCP(pmc);
-
-		if (pevents[i]->attr.exclude_hv)
-			mmcr2 |= MMCR2_FCH(pmc);
-
-		if (pevents[i]->attr.exclude_kernel) {
-			if (cpu_has_feature(CPU_FTR_HVMODE))
-				mmcr2 |= MMCR2_FCH(pmc);
-			else
-				mmcr2 |= MMCR2_FCS(pmc);
-		}
-
-		hwc[i] = pmc - 1;
-	}
-
-	/* Return MMCRx values */
-	mmcr[0] = 0;
-
-	/* pmc_inuse is 1-based */
-	if (pmc_inuse & 2)
-		mmcr[0] = MMCR0_PMC1CE;
-
-	if (pmc_inuse & 0x7c)
-		mmcr[0] |= MMCR0_PMCjCE;
-
-	/* If we're not using PMC 5 or 6, freeze them */
-	if (!(pmc_inuse & 0x60))
-		mmcr[0] |= MMCR0_FC56;
-
-	mmcr[1] = mmcr1;
-	mmcr[2] = mmcra;
-	mmcr[3] = mmcr2;
-
-	return 0;
-}
-
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ PM_MRK_ST_CMPL,		PM_MRK_ST_CMPL_ALT },
@@ -354,12 +110,6 @@ static int power8_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 	return num_alt;
 }
 
-static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
-{
-	if (pmc <= 3)
-		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
-}
-
 GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_GCT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
@@ -632,12 +382,12 @@ static struct power_pmu power8_pmu = {
 	.max_alternatives	= MAX_ALT + 1,
 	.add_fields		= ISA207_ADD_FIELDS,
 	.test_adder		= ISA207_TEST_ADDER,
-	.compute_mmcr		= power8_compute_mmcr,
+	.compute_mmcr		= isa207_compute_mmcr,
 	.config_bhrb		= power8_config_bhrb,
 	.bhrb_filter_map	= power8_bhrb_filter_map,
-	.get_constraint		= power8_get_constraint,
+	.get_constraint		= isa207_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
-	.disable_pmc		= power8_disable_pmc,
+	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
 	.generic_events		= power8_generic_events,
-- 
1.9.1
