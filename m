Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413dlF0YkQzF14f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 00:27:20 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5AENpp8002111
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 10:27:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jgvj35khj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 10:27:17 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 10 Jun 2018 15:27:16 +0100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/perf: Remove l2 bus events from HW cache event
 array
Date: Sun, 10 Jun 2018 19:57:02 +0530
In-Reply-To: <1528640822-4800-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1528640822-4800-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1528640822-4800-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove PM_L2_ST_MISS and PM_L2_ST from HW cache event array since
these are bus events. And these needs to be programmed in groups.
Hence remove them.

Fixes: f1fb60bfde65 ('powerpc/perf: Export Power9 generic and cache events to sysfs')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 9601f0d035b4..0e769a8490a0 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -179,8 +179,6 @@ CACHE_EVENT_ATTR(L1-icache-prefetches,		PM_IC_PREF_WRITE);
 CACHE_EVENT_ATTR(LLC-load-misses,		PM_DATA_FROM_L3MISS);
 CACHE_EVENT_ATTR(LLC-loads,			PM_DATA_FROM_L3);
 CACHE_EVENT_ATTR(LLC-prefetches,		PM_L3_PREF_ALL);
-CACHE_EVENT_ATTR(LLC-store-misses,		PM_L2_ST_MISS);
-CACHE_EVENT_ATTR(LLC-stores,			PM_L2_ST);
 CACHE_EVENT_ATTR(branch-load-misses,		PM_BR_MPRED_CMPL);
 CACHE_EVENT_ATTR(branch-loads,			PM_BR_CMPL);
 CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
@@ -205,8 +203,6 @@ static struct attribute *power9_events_attr[] = {
 	CACHE_EVENT_PTR(PM_DATA_FROM_L3MISS),
 	CACHE_EVENT_PTR(PM_DATA_FROM_L3),
 	CACHE_EVENT_PTR(PM_L3_PREF_ALL),
-	CACHE_EVENT_PTR(PM_L2_ST_MISS),
-	CACHE_EVENT_PTR(PM_L2_ST),
 	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
 	CACHE_EVENT_PTR(PM_BR_CMPL),
 	CACHE_EVENT_PTR(PM_DTLB_MISS),
@@ -371,8 +367,8 @@ static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[ C(RESULT_MISS)   ] = PM_DATA_FROM_L3MISS,
 		},
 		[ C(OP_WRITE) ] = {
-			[ C(RESULT_ACCESS) ] = PM_L2_ST,
-			[ C(RESULT_MISS)   ] = PM_L2_ST_MISS,
+			[ C(RESULT_ACCESS) ] = 0,
+			[ C(RESULT_MISS)   ] = 0,
 		},
 		[ C(OP_PREFETCH) ] = {
 			[ C(RESULT_ACCESS) ] = PM_L3_PREF_ALL,
-- 
2.7.4
