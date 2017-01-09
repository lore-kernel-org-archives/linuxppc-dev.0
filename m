Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txwyy0Rf2zDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:31:05 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v09DTRfN102700
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 08:31:03 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27v7m7sg6d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 08:31:03 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 9 Jan 2017 19:00:59 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 111F7125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 19:02:28 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v09DU9mo27000904
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 19:00:09 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v09DUuPh028064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 19:00:56 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL in
 power9 event list
Date: Mon,  9 Jan 2017 19:00:14 +0530
Message-Id: <1483968615-15850-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes:34922527a2bcb ('powerpc/perf: Add power9 event list macros for generic and cache events')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h |  2 +-
 arch/powerpc/perf/power9-pmu.c         | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 6447dc1c3d89..c529d9e3e245 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,					0x0001e)
 EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
 EVENT(PM_CMPLU_STALL,				0x1e054)
 EVENT(PM_INST_CMPL,				0x00002)
-EVENT(PM_BRU_CMPL,				0x40060)
+EVENT(PM_BR_CMPL,				0x40060)
 EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 
 /* All L1 D cache load references counted at finish, gated by reject */
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 346010e8d463..9cd36855bdf3 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -110,7 +110,7 @@ GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
 GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
-GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,		PM_BR_CMPL);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
 GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
 GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1_FIN);
@@ -128,7 +128,7 @@ CACHE_EVENT_ATTR(LLC-prefetches,		PM_L3_PREF_ALL);
 CACHE_EVENT_ATTR(LLC-store-misses,		PM_L2_ST_MISS);
 CACHE_EVENT_ATTR(LLC-stores,			PM_L2_ST);
 CACHE_EVENT_ATTR(branch-load-misses,		PM_BR_MPRED_CMPL);
-CACHE_EVENT_ATTR(branch-loads,			PM_BRU_CMPL);
+CACHE_EVENT_ATTR(branch-loads,			PM_BR_CMPL);
 CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
 CACHE_EVENT_ATTR(iTLB-load-misses,		PM_ITLB_MISS);
 
@@ -137,7 +137,7 @@ static struct attribute *power9_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_ICT_NOSLOT_CYC),
 	GENERIC_EVENT_PTR(PM_CMPLU_STALL),
 	GENERIC_EVENT_PTR(PM_INST_CMPL),
-	GENERIC_EVENT_PTR(PM_BRU_CMPL),
+	GENERIC_EVENT_PTR(PM_BR_CMPL),
 	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
 	GENERIC_EVENT_PTR(PM_LD_REF_L1),
 	GENERIC_EVENT_PTR(PM_LD_MISS_L1_FIN),
@@ -154,7 +154,7 @@ static struct attribute *power9_events_attr[] = {
 	CACHE_EVENT_PTR(PM_L2_ST_MISS),
 	CACHE_EVENT_PTR(PM_L2_ST),
 	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
-	CACHE_EVENT_PTR(PM_BRU_CMPL),
+	CACHE_EVENT_PTR(PM_BR_CMPL),
 	CACHE_EVENT_PTR(PM_DTLB_MISS),
 	CACHE_EVENT_PTR(PM_ITLB_MISS),
 	NULL
@@ -218,7 +218,7 @@ static int power9_generic_events[] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
 	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BR_CMPL,
 	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
 	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
 	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
@@ -344,7 +344,7 @@ static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 	[ C(BPU) ] = {
 		[ C(OP_READ) ] = {
-			[ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
+			[ C(RESULT_ACCESS) ] = PM_BR_CMPL,
 			[ C(RESULT_MISS)   ] = PM_BR_MPRED_CMPL,
 		},
 		[ C(OP_WRITE) ] = {
-- 
2.7.4
