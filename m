Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXZPB580TzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:22:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GGJsBL056070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 12:22:04 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccmqxb7ef-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 12:22:03 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 02:22:00 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7GGLvLg22610160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:21:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7GGLv27032403
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:21:57 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix usage of nest_imc_refc
Date: Wed, 16 Aug 2017 21:51:34 +0530
Message-Id: <1502900494-10010-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nest_imc_refc is a reference count struct,
used to track number of active perf sessions
using the nest units.

It is preferred to access nest_imc_refc using
per-cpu pointer 'local_nest_imc_refc'. Since,
nest_imc_refc is not initialized using node_id
as array index. Patch to fix the same.

Fixes: 885dcd709ba91 ('powerpc/perf: Add nest IMC PMU support')
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index a8f95f96d54b..9ccac86f3463 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -404,7 +404,7 @@ static void nest_imc_counters_release(struct perf_event *event)
 		rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
 					    get_hard_smp_processor_id(event->cpu));
 		if (rc) {
-			mutex_unlock(&nest_imc_refc[node_id].lock);
+			mutex_unlock(&ref->lock);
 			pr_err("nest-imc: Unable to stop the counters for core %d\n", node_id);
 			return;
 		}
@@ -487,7 +487,7 @@ static int nest_imc_event_init(struct perf_event *event)
 		rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST,
 					     get_hard_smp_processor_id(event->cpu));
 		if (rc) {
-			mutex_unlock(&nest_imc_refc[node_id].lock);
+			mutex_unlock(&ref->lock);
 			pr_err("nest-imc: Unable to start the counters for node %d\n",
 									node_id);
 			return rc;
-- 
2.7.4
