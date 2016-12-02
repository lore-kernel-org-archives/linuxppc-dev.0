Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVFYh1TC1zDw2K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 11:35:35 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB20YWu8110244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 19:35:33 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 272tu52ssk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 19:35:33 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 2 Dec 2016 10:35:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2CBB23578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 11:35:29 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB20ZT9166650264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 11:35:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB20ZStf023214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 11:35:28 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 2/4] powerpc/perf: update attribute_group data structure
Date: Fri,  2 Dec 2016 06:05:00 +0530
In-Reply-To: <1480638902-23416-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1480638902-23416-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1480638902-23416-3-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/power9-pmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 443511b18bc5..0bdbee132105 100644
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
@@ -274,20 +274,23 @@ static struct power_pmu power9_pmu = {
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
 	.generic_events		= power9_generic_events,
 	.cache_events		= &power9_cache_events,
-	.attr_groups		= power9_pmu_attr_groups,
+	.attr_groups		= power9_isa207_pmu_attr_groups,
 	.bhrb_nr		= 32,
 };
 
 static int __init init_power9_pmu(void)
 {
-	int rc;
+	int rc = 0;
 
 	/* Comes from cpu_specs[] */
 	if (!cur_cpu_spec->oprofile_cpu_type ||
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
