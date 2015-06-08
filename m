Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB0C41A0D9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2015 21:39:06 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8C6A1401AB
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 21:39:05 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Jun 2015 17:09:04 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 62DD4E005B
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 17:12:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t58BcXAw59506704
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t58BcWhg022013
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, mikey@neuling.org
Subject: [PATCH V8 04/10] powerpc,
 perf: Re organize PMU based branch filter processing in POWER8
Date: Mon,  8 Jun 2015 17:08:25 +0530
Message-Id: <1433763511-5270-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does some code re-arrangements to make it clear that it ignores
any separate privilege level branch filter request and does not support
any combinations of HW PMU branch filters.

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
