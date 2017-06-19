Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrcZc07nJzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 13:55:36 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, maddy@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf: Fix POWER9 branch event
Date: Mon, 19 Jun 2017 13:55:26 +1000
Message-Id: <20170619035526.7070-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The POWER9 branch event is wrong, and we always get a count of zero:

...
                 0      branches
              3844      branch-misses             #    0.00% of all branches

Replace it with the correct event.

Fixes: d89f473ff6f8 ("powerpc/perf: Fix PM_BRU_CMPL event code for power9")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/perf/power9-events-list.h |  2 +-
 arch/powerpc/perf/power9-pmu.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index e9e417eefa59..ebec41aa7c7d 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,					0x0001e)
 EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
 EVENT(PM_CMPLU_STALL,				0x1e054)
 EVENT(PM_INST_CMPL,				0x00002)
-EVENT(PM_BRU_CMPL,				0x10012)
+EVENT(PM_BR_CMPL,				0x4d05e)
 EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 
 /* All L1 D cache load references counted at finish, gated by reject */
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index b9168163b2b2..90abbebf538f 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -125,7 +125,7 @@ GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
 GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
-GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,		PM_BR_CMPL);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
 GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
 GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1_FIN);
@@ -143,7 +143,7 @@ CACHE_EVENT_ATTR(LLC-prefetches,		PM_L3_PREF_ALL);
 CACHE_EVENT_ATTR(LLC-store-misses,		PM_L2_ST_MISS);
 CACHE_EVENT_ATTR(LLC-stores,			PM_L2_ST);
 CACHE_EVENT_ATTR(branch-load-misses,		PM_BR_MPRED_CMPL);
-CACHE_EVENT_ATTR(branch-loads,			PM_BRU_CMPL);
+CACHE_EVENT_ATTR(branch-loads,			PM_BR_CMPL);
 CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
 CACHE_EVENT_ATTR(iTLB-load-misses,		PM_ITLB_MISS);
 
@@ -152,7 +152,7 @@ static struct attribute *power9_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_ICT_NOSLOT_CYC),
 	GENERIC_EVENT_PTR(PM_CMPLU_STALL),
 	GENERIC_EVENT_PTR(PM_INST_CMPL),
-	GENERIC_EVENT_PTR(PM_BRU_CMPL),
+	GENERIC_EVENT_PTR(PM_BR_CMPL),
 	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
 	GENERIC_EVENT_PTR(PM_LD_REF_L1),
 	GENERIC_EVENT_PTR(PM_LD_MISS_L1_FIN),
@@ -169,7 +169,7 @@ static struct attribute *power9_events_attr[] = {
 	CACHE_EVENT_PTR(PM_L2_ST_MISS),
 	CACHE_EVENT_PTR(PM_L2_ST),
 	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
-	CACHE_EVENT_PTR(PM_BRU_CMPL),
+	CACHE_EVENT_PTR(PM_BR_CMPL),
 	CACHE_EVENT_PTR(PM_DTLB_MISS),
 	CACHE_EVENT_PTR(PM_ITLB_MISS),
 	NULL
@@ -233,7 +233,7 @@ static int power9_generic_events_dd1[] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
 	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_DISP,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BR_CMPL,
 	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
 	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
 	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
@@ -244,7 +244,7 @@ static int power9_generic_events[] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
 	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BR_CMPL,
 	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
 	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
 	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
@@ -370,7 +370,7 @@ static int power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 	[ C(BPU) ] = {
 		[ C(OP_READ) ] = {
-			[ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
+			[ C(RESULT_ACCESS) ] = PM_BR_CMPL,
 			[ C(RESULT_MISS)   ] = PM_BR_MPRED_CMPL,
 		},
 		[ C(OP_WRITE) ] = {
-- 
2.11.0
