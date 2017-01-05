Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvRzd0DRrzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 23:38:04 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05CYKVU006587
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 07:38:02 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sg761xdm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 07:38:02 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 22:37:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 15CF53578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 23:37:58 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05CbwVA23330878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 23:37:58 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05CbvSJ016548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 23:37:57 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] powerpc/perf: Factor out bhrb functions
Date: Thu,  5 Jan 2017 18:07:52 +0530
Message-Id: <1483619873-13899-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out the bhrb functions to "isa207-common.c"
to share with power9 DD1. Only code movement and no logic change

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
1)Updates to commit messages

 arch/powerpc/perf/isa207-common.c | 41 ++++++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h |  9 +++++++
 arch/powerpc/perf/power8-pmu.c    | 49 ++-------------------------------------
 arch/powerpc/perf/power9-pmu.c    |  4 ++--
 4 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 50e598cf644b..ee4e3e89c04c 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -338,3 +338,44 @@ void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 	if (pmc <= 3)
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
 }
+
+u64 isa207_bhrb_filter_map(u64 branch_sample_type)
+{
+	u64 pmu_bhrb_filter = 0;
+
+	/* BHRB and regular PMU events share the same privilege state
+	 * filter configuration. BHRB is always recorded along with a
+	 * regular PMU event. As the privilege state filter is handled
+	 * in the basic PMC configuration of the accompanying regular
+	 * PMU event, we ignore any separate BHRB specific request.
+	 */
+
+	/* No branch filter requested */
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
+		return pmu_bhrb_filter;
+
+	/* Invalid branch filter options - HW does not support */
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		return -1;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		return -1;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
+		return -1;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		pmu_bhrb_filter |= MMCRA_IFM1;
+		return pmu_bhrb_filter;
+	}
+
+	/* Every thing else is unsupported */
+	return -1;
+}
+
+void isa207_config_bhrb(u64 pmu_bhrb_filter)
+{
+	/* Enable BHRB filter in PMU */
+	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
+}
+
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 90495f1580c7..e5e4182731da 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -244,6 +244,12 @@
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
 
+/* MMCRA IFM bits */
+#define MMCRA_IFM1		0x0000000040000000UL
+#define MMCRA_IFM2		0x0000000080000000UL
+#define MMCRA_IFM3		0x00000000C0000000UL
+
+
 /* MMCR1 Threshold Compare bit constant for power9 */
 #define p9_MMCRA_THR_CMP_SHIFT	45
 
@@ -261,4 +267,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 				struct perf_event *pevents[]);
 void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
 
+u64 isa207_bhrb_filter_map(u64 branch_sample_type);
+void isa207_config_bhrb(u64 pmu_bhrb_filter);
+
 #endif
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index d07186382f3a..91120bec4173 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -25,11 +25,6 @@ enum {
 
 #undef EVENT
 
-/* MMCRA IFM bits - POWER8 */
-#define	POWER8_MMCRA_IFM1		0x0000000040000000UL
-#define	POWER8_MMCRA_IFM2		0x0000000080000000UL
-#define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
-
 /* PowerISA v2.07 format attribute structure*/
 extern struct attribute_group isa207_pmu_format_group;
 
@@ -195,46 +190,6 @@ static int power8_generic_events[] = {
 	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1,
 };
 
-static u64 power8_bhrb_filter_map(u64 branch_sample_type)
-{
-	u64 pmu_bhrb_filter = 0;
-
-	/* BHRB and regular PMU events share the same privilege state
-	 * filter configuration. BHRB is always recorded along with a
-	 * regular PMU event. As the privilege state filter is handled
-	 * in the basic PMC configuration of the accompanying regular
-	 * PMU event, we ignore any separate BHRB specific request.
-	 */
-
-	/* No branch filter requested */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
-		return pmu_bhrb_filter;
-
-	/* Invalid branch filter options - HW does not support */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
-		return -1;
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
-		return -1;
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
-		return -1;
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
-		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
-		return pmu_bhrb_filter;
-	}
-
-	/* Every thing else is unsupported */
-	return -1;
-}
-
-static void power8_config_bhrb(u64 pmu_bhrb_filter)
-{
-	/* Enable BHRB filter in PMU */
-	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
-}
-
 #define C(x)	PERF_COUNT_HW_CACHE_##x
 
 /*
@@ -352,8 +307,8 @@ static struct power_pmu power8_pmu = {
 	.add_fields		= ISA207_ADD_FIELDS,
 	.test_adder		= ISA207_TEST_ADDER,
 	.compute_mmcr		= isa207_compute_mmcr,
-	.config_bhrb		= power8_config_bhrb,
-	.bhrb_filter_map	= power8_bhrb_filter_map,
+	.config_bhrb		= isa207_config_bhrb,
+	.bhrb_filter_map	= isa207_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
 	.disable_pmc		= isa207_disable_pmc,
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 346010e8d463..56ad09801fff 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -380,8 +380,8 @@ static struct power_pmu power9_isa207_pmu = {
 	.add_fields		= ISA207_ADD_FIELDS,
 	.test_adder		= ISA207_TEST_ADDER,
 	.compute_mmcr		= isa207_compute_mmcr,
-	.config_bhrb		= power9_config_bhrb,
-	.bhrb_filter_map	= power9_bhrb_filter_map,
+	.config_bhrb		= isa207_config_bhrb,
+	.bhrb_filter_map	= isa207_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
-- 
2.7.4
