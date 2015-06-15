Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042E01A0E6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:12:09 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BABF14029E
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 22:12:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 17:42:06 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 18CF5E0058
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:45:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5FCBBxW41156768
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:41:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5FBD40a025092
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 16:43:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Subject: [PATCH V9 11/13] powerpc,
 perf: Change POWER8 PMU configuration to work with SW filters
Date: Mon, 15 Jun 2015 17:41:06 +0530
Message-Id: <1434370268-19056-12-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel now supports SW based branch filters for book3s systems with
some specific requirements while dealing with HW supported branch filters
in order to achieve overall OR semantics prevailing in perf branch stack
sampling framework. This patch adapts the BHRB branch filter configuration
to meet those protocols. POWER8 PMU can only handle one HW based branch
filter request at any point of time. For all other combinations PMU will
pass it on to the SW.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 51 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 5e17cb5..8fccf6c 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -656,6 +656,16 @@ static int power8_generic_events[] = {
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filter)
 {
+	u64 x, pmu_bhrb_filter;
+
+	pmu_bhrb_filter = 0;
+	*bhrb_filter = 0;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY) {
+		*bhrb_filter = PERF_SAMPLE_BRANCH_ANY;
+		return pmu_bhrb_filter;
+	}
+
 	/* BHRB and regular PMU events share the same privilege state
 	 * filter configuration. BHRB is always recorded along with a
 	 * regular PMU event. As the privilege state filter is handled
@@ -666,15 +676,42 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filter)
 	/* Ignore user, kernel, hv bits */
 	branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;
 
-	/* No branch filter requested */
-	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY)
-		return 0;
+	/*
+	 * POWER8 does not support ORing of PMU HW branch filters. Hence
+	 * if multiple branch filters are requested which may include filters
+	 * supported in PMU, still go ahead and clear the PMU based HW branch
+	 * filter component as in this case all the filters will be processed
+	 * in SW.
+	 */
 
-	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL)
-		return POWER8_MMCRA_IFM1;
+	for_each_branch_sample_type(x) {
+		/* Ignore privilege branch filters */
+		if ((x == PERF_SAMPLE_BRANCH_USER)
+			|| (x == PERF_SAMPLE_BRANCH_KERNEL)
+				|| (x == PERF_SAMPLE_BRANCH_HV))
+			continue;
+
+		if (!(branch_sample_type & x))
+			continue;
+
+		/* Supported individual PMU branch filters */
+		if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+			branch_sample_type &= ~PERF_SAMPLE_BRANCH_ANY_CALL;
+			if (branch_sample_type) {
+				/* Multiple filters will be processed in SW */
+				pmu_bhrb_filter = 0;
+				*bhrb_filter = 0;
+				return pmu_bhrb_filter;
+			} else {
+				/* Individual filter will be processed in HW */
+				pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
+				*bhrb_filter    |= PERF_SAMPLE_BRANCH_ANY_CALL;
+				return pmu_bhrb_filter;
+			}
+		}
+	}
 
-	/* Every thing else is unsupported */
-	return -1;
+	return pmu_bhrb_filter;
 }
 
 static void power8_config_bhrb(u64 pmu_bhrb_filter)
-- 
2.1.0
