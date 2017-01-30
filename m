Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBpWW6PWPzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:25:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UCP3L5109942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:25 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28a55t8stb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:08 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 22:24:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 45F112BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:52 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UCOiCU36765860
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:52 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UCOJaA007451
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:20 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 4/5] powerpc/perf: Use PM_INST_DISP for generic instructions
 sample
Date: Mon, 30 Jan 2017 17:53:40 +0530
In-Reply-To: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1485779021-31936-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PM_INST_CMPL may not provide right counts in all
sampling scenarios in power9 DD1, instead use PM_INST_DISP.
Patch also update generic instruction sampling with the same.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 55 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index b38acff8a791..a956bda9ecf4 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -125,6 +125,7 @@ GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
 GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
+GENERIC_EVENT_ATTR(instruction,			PM_INST_DISP);
 GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_CMPL);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
 GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
@@ -147,6 +148,34 @@ CACHE_EVENT_ATTR(branch-loads,			PM_BRU_CMPL);
 CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
 CACHE_EVENT_ATTR(iTLB-load-misses,		PM_ITLB_MISS);
 
+static struct attribute *power9_events_attr_dd1[] = {
+	GENERIC_EVENT_PTR(PM_CYC),
+	GENERIC_EVENT_PTR(PM_ICT_NOSLOT_CYC),
+	GENERIC_EVENT_PTR(PM_CMPLU_STALL),
+	GENERIC_EVENT_PTR(PM_INST_DISP),
+	GENERIC_EVENT_PTR(PM_BRU_CMPL),
+	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
+	GENERIC_EVENT_PTR(PM_LD_REF_L1),
+	GENERIC_EVENT_PTR(PM_LD_MISS_L1_FIN),
+	CACHE_EVENT_PTR(PM_LD_MISS_L1_FIN),
+	CACHE_EVENT_PTR(PM_LD_REF_L1),
+	CACHE_EVENT_PTR(PM_L1_PREF),
+	CACHE_EVENT_PTR(PM_ST_MISS_L1),
+	CACHE_EVENT_PTR(PM_L1_ICACHE_MISS),
+	CACHE_EVENT_PTR(PM_INST_FROM_L1),
+	CACHE_EVENT_PTR(PM_IC_PREF_WRITE),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3MISS),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3),
+	CACHE_EVENT_PTR(PM_L3_PREF_ALL),
+	CACHE_EVENT_PTR(PM_L2_ST_MISS),
+	CACHE_EVENT_PTR(PM_L2_ST),
+	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
+	CACHE_EVENT_PTR(PM_BRU_CMPL),
+	CACHE_EVENT_PTR(PM_DTLB_MISS),
+	CACHE_EVENT_PTR(PM_ITLB_MISS),
+	NULL
+};
+
 static struct attribute *power9_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_CYC),
 	GENERIC_EVENT_PTR(PM_ICT_NOSLOT_CYC),
@@ -175,17 +204,22 @@ static struct attribute *power9_events_attr[] = {
 	NULL
 };
 
-static struct attribute_group power9_pmu_events_group = {
+static struct attribute_group power9_pmu_events_group_dd1 = {
 	.name = "events",
-	.attrs = power9_events_attr,
+	.attrs = power9_events_attr_dd1,
 };
 
 static const struct attribute_group *power9_isa207_pmu_attr_groups[] = {
 	&isa207_pmu_format_group,
-	&power9_pmu_events_group,
+	&power9_pmu_events_group_dd1,
 	NULL,
 };
 
+static struct attribute_group power9_pmu_events_group = {
+	.name = "events",
+	.attrs = power9_events_attr,
+};
+
 PMU_FORMAT_ATTR(event,		"config:0-51");
 PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
 PMU_FORMAT_ATTR(mark,		"config:8");
@@ -228,6 +262,17 @@ static const struct attribute_group *power9_pmu_attr_groups[] = {
 	NULL,
 };
 
+static int power9_generic_events_dd1[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_DISP,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
+	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
+};
+
 static int power9_generic_events[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
@@ -401,8 +446,8 @@ static struct power_pmu power9_isa207_pmu = {
 	.get_alternatives	= power9_get_alternatives,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_NO_SIAR | PPMU_ARCH_207S,
-	.n_generic		= ARRAY_SIZE(power9_generic_events),
-	.generic_events		= power9_generic_events,
+	.n_generic		= ARRAY_SIZE(power9_generic_events_dd1),
+	.generic_events		= power9_generic_events_dd1,
 	.cache_events		= &power9_cache_events,
 	.attr_groups		= power9_isa207_pmu_attr_groups,
 	.bhrb_nr		= 32,
-- 
2.7.4
