Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEAEC140303
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 19:11:08 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 14:41:04 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 90F54394003E
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 14:41:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s459B0sV24903786
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:41:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s459AsKQ025001
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:40:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V6 06/11] powerpc,
 perf: Re-arrange PMU based branch filter processing in POWER8
Date: Mon,  5 May 2014 14:39:08 +0530
Message-Id: <1399280953-31442-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does some code re-arrangements to make it clear that
it ignores any separate privilege level branch filter request
and does not support any combinations of HW PMU branch filters.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index fe2763b..13f47f5 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -635,8 +635,6 @@ static int power8_generic_events[] = {
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 {
-	u64 pmu_bhrb_filter = 0;
-
 	/* BHRB and regular PMU events share the same privilege state
 	 * filter configuration. BHRB is always recorded along with a
 	 * regular PMU event. As the privilege state filter is handled
@@ -644,20 +642,15 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 	 * PMU event, we ignore any separate BHRB specific request.
 	 */
 
-	/* No branch filter requested */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
-		return pmu_bhrb_filter;
-
-	/* Invalid branch filter options - HW does not support */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
-		return -1;
+	/* Ignore user, kernel, hv bits */
+	branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
-		return -1;
+	/* No branch filter requested */
+	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY)
+		return 0;
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
-		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
-		return pmu_bhrb_filter;
+	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL) {
+		return POWER8_MMCRA_IFM1;
 	}
 
 	/* Every thing else is unsupported */
-- 
1.7.11.7
