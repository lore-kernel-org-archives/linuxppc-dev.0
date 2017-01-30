Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBpWB1Hj7zDq61
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:25:09 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UCP48V046835
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:07 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28a2r8y319-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:07 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 22:24:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F30802BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:40 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UCOWGc37159026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:40 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UCO8rl007257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:08 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/5] powerpc/perf: Factor of event_alternative function
Date: Mon, 30 Jan 2017 17:53:37 +0530
Message-Id: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out the power8 event_alternative function to share
the code with power9.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 36 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h |  3 +++
 arch/powerpc/perf/power8-pmu.c    | 35 ++---------------------------------
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 50e598cf644b..a86fadee352b 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -338,3 +338,39 @@ void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 	if (pmc <= 3)
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
 }
+
+static int find_alternative(u64 event, const unsigned int ev_alt[][MAX_ALT], int size)
+{
+	int i, j;
+
+	for (i = 0; i < size; ++i) {
+		if (event < ev_alt[i][0])
+			break;
+
+		for (j = 0; j < MAX_ALT && ev_alt[i][j]; ++j)
+			if (event == ev_alt[i][j])
+				return i;
+	}
+
+	return -1;
+}
+
+int isa207_get_alternatives(u64 event, u64 alt[],
+				const unsigned int ev_alt[][MAX_ALT], int size)
+{
+	int i, j, num_alt = 0;
+	u64 alt_event;
+
+	alt[num_alt++] = event;
+	i = find_alternative(event, ev_alt, size);
+	if (i >= 0) {
+		/* Filter out the original event, it's already in alt[0] */
+		for (j = 0; j < MAX_ALT; ++j) {
+			alt_event = ev_alt[i][j];
+			if (alt_event && alt_event != event)
+				alt[num_alt++] = alt_event;
+		}
+	}
+
+	return num_alt;
+}
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 90495f1580c7..3e9150f6690a 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -260,5 +260,8 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], unsigned long mmcr[],
 				struct perf_event *pevents[]);
 void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
+int isa207_get_alternatives(u64 event, u64 alt[],
+				const unsigned int ev_alt[][MAX_ALT], int size);
+
 
 #endif
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index d07186382f3a..ce15b19a7962 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -48,43 +48,12 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ PM_RUN_INST_CMPL_ALT,		PM_RUN_INST_CMPL },
 };
 
-/*
- * Scan the alternatives table for a match and return the
- * index into the alternatives table if found, else -1.
- */
-static int find_alternative(u64 event)
-{
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			break;
-
-		for (j = 0; j < MAX_ALT && event_alternatives[i][j]; ++j)
-			if (event == event_alternatives[i][j])
-				return i;
-	}
-
-	return -1;
-}
-
 static int power8_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 {
 	int i, j, num_alt = 0;
-	u64 alt_event;
-
-	alt[num_alt++] = event;
-
-	i = find_alternative(event);
-	if (i >= 0) {
-		/* Filter out the original event, it's already in alt[0] */
-		for (j = 0; j < MAX_ALT; ++j) {
-			alt_event = event_alternatives[i][j];
-			if (alt_event && alt_event != event)
-				alt[num_alt++] = alt_event;
-		}
-	}
 
+	num_alt = isa207_get_alternatives(event, alt, event_alternatives,
+					(int)ARRAY_SIZE(event_alternatives));
 	if (flags & PPMU_ONLY_COUNT_RUN) {
 		/*
 		 * We're only counting in RUN state, so PM_CYC is equivalent to
-- 
2.7.4
