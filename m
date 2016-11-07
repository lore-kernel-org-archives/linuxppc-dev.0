Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBvtD690tzDvPY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 12:26:44 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA71Nhdw129464
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 20:26:43 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jb76gram-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 20:26:43 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 06:56:39 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 174991258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 06:57:24 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA71Qa9Y47120552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA71QZCn000569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:35 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/perf: PowerISA v3.0 raw event format encoding
Date: Mon,  7 Nov 2016 06:56:18 +0530
In-Reply-To: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1478481979-26224-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch to update the PowerISA v3.0 raw event encoding format
information and add support for the same in Power9.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 134 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index d1782fd644e9..928d0e739ed4 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -16,6 +16,78 @@
 #include "isa207-common.h"
 
 /*
+ * Raw event encoding for PowerISA v3.0:
+ *
+ *        60        56        52        48        44        40        36        32
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   | | [ ]                       [ ] [      thresh_cmp     ]   [  thresh_ctl   ]
+ *   | |  |                         |                                     |
+ *   | |  *- IFM (Linux)            |    thresh start/stop OR FAB match -*
+ *   | *- BHRB (Linux)              *sm
+ *   *- EBB (Linux)
+ *
+ *        28        24        20        16        12         8         4         0
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   [   ] [  sample ]   [cache]   [ pmc ]   [unit ]   []    m   [    pmcxsel    ]
+ *     |        |           |                          |     |
+ *     |        |           |                          |     *- mark
+ *     |        |           *- L1/L2/L3 cache_sel      |
+ *     |        |                                      |
+ *     |        *- sampling mode for marked events     *- combine
+ *     |
+ *     *- thresh_sel
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
+ * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
+ *	# PM_MRK_FAB_RSP_MATCH
+ *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
+ *	# PM_MRK_FAB_RSP_MATCH_CYC
+ *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ * else
+ *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
+ *
+ * if thresh_sel:
+ *	MMCRA[45:47] = thresh_sel
+ *
+ * if thresh_cmp:
+ *	MMCRA[9:11] = thresh_cmp[0:2]
+ *	MMCRA[12:18] = thresh_cmp[3:9]
+ *
+ * if unit == 6 or unit == 7
+ *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
+ * else if unit == 8 or unit == 9:
+ *	if cache_sel[0] == 0: # L3 bank
+ *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
+ *	else if cache_sel[0] == 1:
+ *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
+ * else if cache_sel[1]: # L1 event
+ *	MMCR1[16] = cache_sel[2]
+ *	MMCR1[17] = cache_sel[3]
+ *
+ * if mark:
+ *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
+ *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
+ *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
+ *
+ * if EBB and BHRB:
+ *	MMCRA[32:33] = IFM
+ *
+ * MMCRA[SDAR_MODE]  = sm
+ */
+
+/*
  * Some power9 event codes.
  */
 #define EVENT(_name, _code)	_name = _code,
@@ -99,6 +171,48 @@ static const struct attribute_group *power9_isa207_pmu_attr_groups[] = {
 	NULL,
 };
 
+PMU_FORMAT_ATTR(event,		"config:0-51");
+PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
+PMU_FORMAT_ATTR(mark,		"config:8");
+PMU_FORMAT_ATTR(combine,	"config:10-11");
+PMU_FORMAT_ATTR(unit,		"config:12-15");
+PMU_FORMAT_ATTR(pmc,		"config:16-19");
+PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
+PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
+PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
+PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
+PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
+PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
+PMU_FORMAT_ATTR(sdar_mode,	"config:50-51");
+
+static struct attribute *power9_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcxsel.attr,
+	&format_attr_mark.attr,
+	&format_attr_combine.attr,
+	&format_attr_unit.attr,
+	&format_attr_pmc.attr,
+	&format_attr_cache_sel.attr,
+	&format_attr_sample_mode.attr,
+	&format_attr_thresh_sel.attr,
+	&format_attr_thresh_stop.attr,
+	&format_attr_thresh_start.attr,
+	&format_attr_thresh_cmp.attr,
+	&format_attr_sdar_mode.attr,
+	NULL,
+};
+
+static struct attribute_group power9_pmu_format_group = {
+	.name = "format",
+	.attrs = power9_pmu_format_attr,
+};
+
+static const struct attribute_group *power9_pmu_attr_groups[] = {
+	&power9_pmu_format_group,
+	&power9_pmu_events_group,
+	NULL,
+};
+
 static int power9_generic_events[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
@@ -278,6 +392,24 @@ static struct power_pmu power9_isa207_pmu = {
 	.bhrb_nr		= 32,
 };
 
+static struct power_pmu power9_pmu = {
+	.name			= "POWER9",
+	.n_counter		= MAX_PMU_COUNTERS,
+	.add_fields		= ISA207_ADD_FIELDS,
+	.test_adder		= ISA207_TEST_ADDER,
+	.compute_mmcr		= isa207_compute_mmcr,
+	.config_bhrb		= power9_config_bhrb,
+	.bhrb_filter_map	= power9_bhrb_filter_map,
+	.get_constraint		= isa207_get_constraint,
+	.disable_pmc		= isa207_disable_pmc,
+	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
+	.n_generic		= ARRAY_SIZE(power9_generic_events),
+	.generic_events		= power9_generic_events,
+	.cache_events		= &power9_cache_events,
+	.attr_groups		= power9_pmu_attr_groups,
+	.bhrb_nr		= 32,
+};
+
 static int __init init_power9_pmu(void)
 {
 	int rc;
@@ -289,6 +421,8 @@ static int __init init_power9_pmu(void)
 
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
 		rc = register_power_pmu(&power9_isa207_pmu);
+	} else {
+		rc = register_power_pmu(&power9_pmu);
 	}
 
 	if (rc)
-- 
2.7.4
