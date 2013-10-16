Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22BF92C0351
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 17:58:07 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 12:28:03 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B41403940058
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:40 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G70eW332112648
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:30:41 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G6vuh5029081
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V3 10/10] powerpc, perf: Cleanup SW branch filter list look up
Date: Wed, 16 Oct 2013 12:26:57 +0530
Message-Id: <1381906617-11392-11-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds enumeration for all available SW branch filters
in powerpc book3s code and also streamlines the look for the
SW branch filter entries while trying to figure out which all
branch filters can be supported in SW.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f983334..ec2dd61 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -566,6 +566,12 @@ static int match_filters(u64 branch_sample_type, u64 filter_mask)
 	return true;
 }
 
+/* SW implemented branch filters */
+static unsigned int power_sw_filter[] =	      { PERF_SAMPLE_BRANCH_ANY_CALL,
+						PERF_SAMPLE_BRANCH_COND,
+						PERF_SAMPLE_BRANCH_ANY_RETURN,
+						PERF_SAMPLE_BRANCH_IND_CALL };
+
 /*
  * Required SW based branch filters
  *
@@ -578,6 +584,7 @@ static u64 branch_filter_map(u64 branch_sample_type, u64 pmu_bhrb_filter,
 			     					u64 *filter_mask)
 {
 	u64 branch_sw_filter = 0;
+	unsigned int i;
 
 	/* No branch filter requested */
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY) {
@@ -593,34 +600,15 @@ static u64 branch_filter_map(u64 branch_sample_type, u64 pmu_bhrb_filter,
 	 * SW implemented filters. But right now, there is now way to
 	 * initimate the user about this decision.
 	 */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
-		if (!(pmu_bhrb_filter & PERF_SAMPLE_BRANCH_ANY_CALL)) {
-			branch_sw_filter |= PERF_SAMPLE_BRANCH_ANY_CALL;
-			*filter_mask |= PERF_SAMPLE_BRANCH_ANY_CALL;
-		}
-	}
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
-		if (!(pmu_bhrb_filter & PERF_SAMPLE_BRANCH_COND)) {
-			branch_sw_filter |= PERF_SAMPLE_BRANCH_COND;
-			*filter_mask |= PERF_SAMPLE_BRANCH_COND;
-		}
-	}
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN) {
-		if (!(pmu_bhrb_filter & PERF_SAMPLE_BRANCH_ANY_RETURN)) {
-			branch_sw_filter |= PERF_SAMPLE_BRANCH_ANY_RETURN;
-			*filter_mask |= PERF_SAMPLE_BRANCH_ANY_RETURN;
-		}
-	}
-
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
-		if (!(pmu_bhrb_filter & PERF_SAMPLE_BRANCH_IND_CALL)) {
-			branch_sw_filter |= PERF_SAMPLE_BRANCH_IND_CALL;
-			*filter_mask |= PERF_SAMPLE_BRANCH_IND_CALL;
+	for (i = 0; i < ARRAY_SIZE(power_sw_filter); i++) {
+		if (branch_sample_type & power_sw_filter[i]) {
+			if (!(pmu_bhrb_filter & power_sw_filter[i])) {
+				branch_sw_filter |= power_sw_filter[i];
+				*filter_mask |= power_sw_filter[i];
+			}
 		}
 	}
-
 	return branch_sw_filter;
 }
 
-- 
1.7.11.7
