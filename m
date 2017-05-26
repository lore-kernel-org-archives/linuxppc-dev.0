Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYzLx26KqzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 18:09:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4Q88b6l078635
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 04:09:35 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2apa6sdg55-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 04:09:35 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 26 May 2017 18:09:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4Q89JPt3145992
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 18:09:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4Q88lZl003644
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 18:08:47 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix Power9 test_adder field
Date: Fri, 26 May 2017 13:38:27 +0530
Message-Id: <1495786107-341-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 DD1')
was added to restrict the use of PMC5 in Power9 DD1. Intend is to diable
the use of PMC5 using raw event code. Commit instead of updating "power9_isa207_pmu"
structure, updated "power9_pmu" structure. Patch to fix the same.

Fixes: 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 DD1')
Reported-by: Shriya <shriyak@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 018f8e90ac35..bb28e1a41257 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -402,7 +402,7 @@ static struct power_pmu power9_isa207_pmu = {
 	.name			= "POWER9",
 	.n_counter		= MAX_PMU_COUNTERS,
 	.add_fields		= ISA207_ADD_FIELDS,
-	.test_adder		= ISA207_TEST_ADDER,
+	.test_adder		= P9_DD1_TEST_ADDER,
 	.compute_mmcr		= isa207_compute_mmcr,
 	.config_bhrb		= power9_config_bhrb,
 	.bhrb_filter_map	= power9_bhrb_filter_map,
@@ -421,7 +421,7 @@ static struct power_pmu power9_pmu = {
 	.name			= "POWER9",
 	.n_counter		= MAX_PMU_COUNTERS,
 	.add_fields		= ISA207_ADD_FIELDS,
-	.test_adder		= P9_DD1_TEST_ADDER,
+	.test_adder		= ISA207_TEST_ADDER,
 	.compute_mmcr		= isa207_compute_mmcr,
 	.config_bhrb		= power9_config_bhrb,
 	.bhrb_filter_map	= power9_bhrb_filter_map,
-- 
2.7.4
