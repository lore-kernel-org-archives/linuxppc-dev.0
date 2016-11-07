Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBvtC53HczDvNG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 12:26:43 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA71NhR7129498
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 20:26:41 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jb76gr9x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 20:26:41 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 06:56:38 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4F5C4394005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 06:56:35 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA71QZQZ52822026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA71QY77000552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:34 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/perf: update attribute_group data structure
Date: Mon,  7 Nov 2016 06:56:17 +0530
In-Reply-To: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1478481979-26224-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the power_pmu and attribute_group variables that
support PowerISA v2.07. Add a cpu feature flag check to pick
the PowerISA v2.07 format structures to support.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 443511b18bc5..d1782fd644e9 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -93,7 +93,7 @@ static struct attribute_group power9_pmu_events_group = {
 	.attrs = power9_events_attr,
 };
 
-static const struct attribute_group *power9_pmu_attr_groups[] = {
+static const struct attribute_group *power9_isa207_pmu_attr_groups[] = {
 	&isa207_pmu_format_group,
 	&power9_pmu_events_group,
 	NULL,
@@ -260,7 +260,7 @@ static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 
 #undef C
 
-static struct power_pmu power9_pmu = {
+static struct power_pmu power9_isa207_pmu = {
 	.name			= "POWER9",
 	.n_counter		= MAX_PMU_COUNTERS,
 	.add_fields		= ISA207_ADD_FIELDS,
@@ -274,7 +274,7 @@ static struct power_pmu power9_pmu = {
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
 	.generic_events		= power9_generic_events,
 	.cache_events		= &power9_cache_events,
-	.attr_groups		= power9_pmu_attr_groups,
+	.attr_groups		= power9_isa207_pmu_attr_groups,
 	.bhrb_nr		= 32,
 };
 
@@ -287,7 +287,10 @@ static int __init init_power9_pmu(void)
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
 		return -ENODEV;
 
-	rc = register_power_pmu(&power9_pmu);
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		rc = register_power_pmu(&power9_isa207_pmu);
+	}
+
 	if (rc)
 		return rc;
 
-- 
2.7.4
