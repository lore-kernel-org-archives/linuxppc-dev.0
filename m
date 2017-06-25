Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwbpw38NYzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 01:35:03 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5PFYQtN113381
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 11:35:00 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2babs07gbm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 11:35:00 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 26 Jun 2017 01:34:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5PFYtdH63504438
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 01:34:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5PFYtrq022211
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 01:34:55 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix branch event code for power9
Date: Sun, 25 Jun 2017 21:04:46 +0530
Message-Id: <1498404886-9587-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct "branch" event code of Power9 is "r4d05e".
Replace the current "branch" event code with "r4d05e"
and add a hack to use "r10012" as event code for
power9 dd1.

Fixes: d89f473ff6f8 ("powerpc/perf: Fix PM_BRU_CMPL event code for power9")
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 4 +++-
 arch/powerpc/perf/power9-pmu.c         | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 71a6bfee5c02..80204e064362 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,					0x0001e)
 EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
 EVENT(PM_CMPLU_STALL,				0x1e054)
 EVENT(PM_INST_CMPL,				0x00002)
-EVENT(PM_BRU_CMPL,				0x10012)
+EVENT(PM_BRU_CMPL,				0x4d05e)
 EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 
 /* All L1 D cache load references counted at finish, gated by reject */
@@ -56,3 +56,5 @@ EVENT(PM_RUN_CYC,				0x600f4)
 /* Instruction Dispatched */
 EVENT(PM_INST_DISP,				0x200f2)
 EVENT(PM_INST_DISP_ALT,				0x300f2)
+/* Alternate Branch event code */
+EVENT(PM_BR_CMPL_ALT,				0x10012)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index bb28e1a41257..f17435e4a489 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -231,7 +231,7 @@ static int power9_generic_events_dd1[] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_ICT_NOSLOT_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
 	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_DISP,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BR_CMPL_ALT,
 	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
 	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
 	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1_FIN,
@@ -453,6 +453,12 @@ static int __init init_power9_pmu(void)
 		 * sampling scenarios in power9 DD1, instead use PM_INST_DISP.
 		 */
 		EVENT_VAR(PM_INST_CMPL, _g).id = PM_INST_DISP;
+		/*
+		 * Power9 DD1 should use PM_BR_CMPL_ALT event code for
+		 * "branches" to provide correct counter value.
+		 */
+		EVENT_VAR(PM_BRU_CMPL, _g).id = PM_BR_CMPL_ALT;
+		EVENT_VAR(PM_BRU_CMPL, _c).id = PM_BR_CMPL_ALT;
 		rc = register_power_pmu(&power9_isa207_pmu);
 	} else {
 		rc = register_power_pmu(&power9_pmu);
-- 
2.7.4
