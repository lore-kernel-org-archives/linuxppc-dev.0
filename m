Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3DFC1A107B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:20:40 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0936C1402CC
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:20:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 13:50:37 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8AF70E005C
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:54:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8KXmr5702078
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:34 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U7DMXp029641
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 12:43:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH 5/5] powerpc/perf: Re organize PMU branch filter processing on
 POWER8
Date: Tue, 30 Jun 2015 13:50:31 +0530
Message-Id: <1435652431-22024-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does some code re-arrangements to make it clear that kernel
ignores any separate privilege level branch filter request and does not
support any combinations of HW PMU branch filters.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 396351d..a6c6a2c 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -656,8 +656,6 @@ static int power8_generic_events[] = {
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 {
-	u64 pmu_bhrb_filter = 0;
-
 	/* BHRB and regular PMU events share the same privilege state
 	 * filter configuration. BHRB is always recorded along with a
 	 * regular PMU event. As the privilege state filter is handled
@@ -665,21 +663,15 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
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
-	}
+	if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL)
+		return POWER8_MMCRA_IFM1;
 
 	/* Every thing else is unsupported */
 	return -1;
-- 
2.1.0
