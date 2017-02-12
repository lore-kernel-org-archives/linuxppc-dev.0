Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4V5CxjzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:38 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGww1I140243
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:36 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28jh238952-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:35 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:32 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 109D8E0024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:35:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH2UWR12386310
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:32:30 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3UCw009441
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:30 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] powerpc/perf: Use PM_INST_DISP for generic
 instructions sample
Date: Sun, 12 Feb 2017 22:33:13 +0530
In-Reply-To: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1486918995-16354-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since PM_INST_CMPL may not provide right counts in all
sampling scenarios in power9 DD1, instead use PM_INST_DISP.
Patch also update generic instruction sampling with the same.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
Based on DD1 check, modified the event code to use for "instructions"

 arch/powerpc/perf/power9-pmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index b38acff8a791..454e9f70894f 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -228,6 +228,17 @@ static const struct attribute_group *power9_pmu_attr_groups[] = {
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
@@ -401,8 +412,8 @@ static struct power_pmu power9_isa207_pmu = {
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
@@ -437,6 +448,11 @@ static int __init init_power9_pmu(void)
 		return -ENODEV;
 
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		/*
+		 * Since PM_INST_CMPL may not provide right counts in all
+		 * sampling scenarios in power9 DD1, instead use PM_INST_DISP.
+		 */
+		EVENT_VAR(PM_INST_CMPL, _g).id = PM_INST_DISP;
 		rc = register_power_pmu(&power9_isa207_pmu);
 	} else {
 		rc = register_power_pmu(&power9_pmu);
-- 
2.7.4
