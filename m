Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32C7C2C036A
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 17:58:06 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 12:28:01 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1B268E0058
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:29:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G6vsYE9896184
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G6vuTj029075
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V3 09/10] power8, perf: Change BHRB branch filter configuration
Date: Wed, 16 Oct 2013 12:26:56 +0530
Message-Id: <1381906617-11392-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com,
 eranian@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Powerpc kernel now supports SW based branch filters for book3s systems with some
specifc requirements while dealing with HW supported branch filters in order to
achieve overall OR semantics prevailing in perf branch stack sampling framework.
This patch adapts the BHRB branch filter configuration to meet those protocols.
POWER8 PMU does support 3 branch filters (out of which two are getting used in
perf branch stack) which are mutually exclussive and cannot be ORed with each
other. This implies that PMU can only handle one HW based branch filter request
at any point of time. For all other combinations PMU will pass it on to the SW.

Also the combination of PERF_SAMPLE_BRANCH_ANY_CALL and PERF_SAMPLE_BRANCH_COND
can now be handled in SW, hence we dont error them out anymore.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 73 +++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 94460bc..7b82725 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -560,7 +560,56 @@ static int power8_generic_events[] = {
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *filter_mask)
 {
-	u64 pmu_bhrb_filter = 0;
+	u64 x, tmp, pmu_bhrb_filter = 0;
+	*filter_mask = 0;
+
+	/* No branch filter requested */
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY) {
+		*filter_mask = PERF_SAMPLE_BRANCH_ANY;
+		return pmu_bhrb_filter;
+	}
+
+	/*
+	 * P8 does not support oring of PMU HW branch filters. Hence
+	 * if multiple branch filters are requested which includes filters
+	 * supported in PMU, still go ahead and clear the PMU based HW branch
+	 * filter component as in this case all the filters will be processed
+ 	 * in SW.
+	 */
+	tmp = branch_sample_type;
+
+	/* Remove privilege filters before comparison */
+	tmp &= ~PERF_SAMPLE_BRANCH_USER;
+	tmp &= ~PERF_SAMPLE_BRANCH_KERNEL;
+	tmp &= ~PERF_SAMPLE_BRANCH_HV;
+
+	for_each_branch_sample_type(x) {
+		/* Ignore privilege requests */
+		if ((x == PERF_SAMPLE_BRANCH_USER) || (x == PERF_SAMPLE_BRANCH_KERNEL) || (x == PERF_SAMPLE_BRANCH_HV))
+			continue;
+
+		if (!(tmp & x))
+			continue;
+
+               /* Supported HW PMU filters */
+		if (tmp & PERF_SAMPLE_BRANCH_ANY_CALL) {
+			tmp &= ~PERF_SAMPLE_BRANCH_ANY_CALL;
+			if (tmp) {
+				pmu_bhrb_filter = 0;
+				*filter_mask = 0;
+				return pmu_bhrb_filter;
+			}
+		}
+
+		if (tmp & PERF_SAMPLE_BRANCH_COND) {
+			tmp &= ~PERF_SAMPLE_BRANCH_COND;
+			if (tmp) {
+				pmu_bhrb_filter = 0;
+				*filter_mask = 0;
+				return pmu_bhrb_filter;
+			}
+		}
+	}
 
 	/* BHRB and regular PMU events share the same privilege state
 	 * filter configuration. BHRB is always recorded along with a
@@ -569,34 +618,20 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *filter_mask)
 	 * PMU event, we ignore any separate BHRB specific request.
 	 */
 
-	/* No branch filter requested */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
-		return pmu_bhrb_filter;
-
-	/* Invalid branch filter options - HW does not support */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
-		return -1;
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
-		return -1;
-
-	/* Invalid branch filter combination - HW does not support */
-	if ((branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) &&
-			(branch_sample_type & PERF_SAMPLE_BRANCH_COND))
-		return -1;
-
+	/* Supported individual branch filters */
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
 		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
+		*filter_mask    |= PERF_SAMPLE_BRANCH_ANY_CALL;
 		return pmu_bhrb_filter;
 	}
 
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
 		pmu_bhrb_filter |= POWER8_MMCRA_IFM3;
+		*filter_mask    |= PERF_SAMPLE_BRANCH_COND;
 		return pmu_bhrb_filter;
 	}
 
-	/* Every thing else is unsupported */
-	return -1;
+	return pmu_bhrb_filter;
 }
 
 static void power8_config_bhrb(u64 pmu_bhrb_filter)
-- 
1.7.11.7
