Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4S3m8QzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:36 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGxEpb145558
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:32 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28hyg15gjv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:32 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:29 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A6325E0024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:34:56 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH3QG542270748
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3PSM009386
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:26 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 1/6] powerpc/perf: Factor of event_alternative function
Date: Sun, 12 Feb 2017 22:33:10 +0530
Message-Id: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
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
Changelog v1:
No changes to this patch, just a rebase

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
