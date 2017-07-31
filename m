Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLX4Z74G4zDsP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 18:02:54 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6V7wbGs046414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 04:02:53 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c1y0tv1mm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 04:02:52 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 18:02:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6V82kDO27918382
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 18:02:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6V82bIO025047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 18:02:37 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Factor out PPMU_ONLY_COUNT_RUN check code from
 power8
Date: Mon, 31 Jul 2017 13:32:41 +0530
Message-Id: <1501488161-27033-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some hardware events on Power systems which only
count when the processor is not idle, and there are some
fixed-function counters which count such events. For example,
the "run cycles" event counts cycles when the processor is
not idle. If the user asks to count cycles, we can use
"run cycles" if this is a per-task event, since the processor
is running when the task is running, by definition. We can't
use "run cycles" if the user asks for "cycles" on a system-wide
counter.

Currently in power8 this check is done using PPMU_ONLY_COUNT_RUN
flag in power8_get_alternatives() function. Based on the
flag, events are switched if needed. This function should
also be enabled in power9, so factor out the code to
isa207_get_alternatives().

Fixes: efe881afdd999 ('powerpc/perf: Factor out event_alternative function')
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 29 +++++++++++++++++++++++++++--
 arch/powerpc/perf/isa207-common.h |  4 ++--
 arch/powerpc/perf/power8-pmu.c    | 33 +++++----------------------------
 arch/powerpc/perf/power9-pmu.c    |  5 +++--
 4 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 3f3aa9a7063a..26c81aaa4c2d 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -488,8 +488,8 @@ static int find_alternative(u64 event, const unsigned int ev_alt[][MAX_ALT], int
 	return -1;
 }
 
-int isa207_get_alternatives(u64 event, u64 alt[],
-				const unsigned int ev_alt[][MAX_ALT], int size)
+int isa207_get_alternatives(u64 event, u64 alt[], int size, unsigned int flags,
+					const unsigned int ev_alt[][MAX_ALT])
 {
 	int i, j, num_alt = 0;
 	u64 alt_event;
@@ -505,5 +505,30 @@ int isa207_get_alternatives(u64 event, u64 alt[],
 		}
 	}
 
+	if (flags & PPMU_ONLY_COUNT_RUN) {
+		/*
+		 * We're only counting in RUN state, so PM_CYC is equivalent to
+		 * PM_RUN_CYC and PM_INST_CMPL === PM_RUN_INST_CMPL.
+		 */
+		j = num_alt;
+		for (i = 0; i < num_alt; ++i) {
+			switch (alt[i]) {
+			case 0x1e:			/* PMC_CYC */
+				alt[j++] = 0x600f4;	/* PM_RUN_CYC */
+				break;
+			case 0x600f4:
+				alt[j++] = 0x1e;
+				break;
+			case 0x2:			/* PM_INST_CMPL */
+				alt[j++] = 0x500fa;	/* PM_RUN_INST_CMPL */
+				break;
+			case 0x500fa:
+				alt[j++] = 0x2;
+				break;
+			}
+		}
+		num_alt = j;
+	}
+
 	return num_alt;
 }
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 8acbe6e802c7..348cb6b9b911 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -287,8 +287,8 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], unsigned long mmcr[],
 				struct perf_event *pevents[]);
 void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
-int isa207_get_alternatives(u64 event, u64 alt[],
-				const unsigned int ev_alt[][MAX_ALT], int size);
+int isa207_get_alternatives(u64 event, u64 alt[], int size, unsigned int flags,
+					const unsigned int ev_alt[][MAX_ALT]);
 void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 							struct pt_regs *regs);
 void isa207_get_mem_weight(u64 *weight);
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 5463516e369b..0bd27769e81e 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -50,34 +50,11 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
 
 static int power8_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 {
-	int i, j, num_alt = 0;
-
-	num_alt = isa207_get_alternatives(event, alt, event_alternatives,
-					(int)ARRAY_SIZE(event_alternatives));
-	if (flags & PPMU_ONLY_COUNT_RUN) {
-		/*
-		 * We're only counting in RUN state, so PM_CYC is equivalent to
-		 * PM_RUN_CYC and PM_INST_CMPL === PM_RUN_INST_CMPL.
-		 */
-		j = num_alt;
-		for (i = 0; i < num_alt; ++i) {
-			switch (alt[i]) {
-			case PM_CYC:
-				alt[j++] = PM_RUN_CYC;
-				break;
-			case PM_RUN_CYC:
-				alt[j++] = PM_CYC;
-				break;
-			case PM_INST_CMPL:
-				alt[j++] = PM_RUN_INST_CMPL;
-				break;
-			case PM_RUN_INST_CMPL:
-				alt[j++] = PM_INST_CMPL;
-				break;
-			}
-		}
-		num_alt = j;
-	}
+	int num_alt = 0;
+
+	num_alt = isa207_get_alternatives(event, alt,
+				(int)ARRAY_SIZE(event_alternatives), flags,
+				event_alternatives);
 
 	return num_alt;
 }
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 2280cf87ff9c..805bdfcb38ec 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -115,8 +115,9 @@ static int power9_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 {
 	int num_alt = 0;
 
-	num_alt = isa207_get_alternatives(event, alt, power9_event_alternatives,
-				(int)ARRAY_SIZE(power9_event_alternatives));
+	num_alt = isa207_get_alternatives(event, alt,
+			(int)ARRAY_SIZE(power9_event_alternatives), flags,
+						power9_event_alternatives);
 
 	return num_alt;
 }
-- 
2.7.4
