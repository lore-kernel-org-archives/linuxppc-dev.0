Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj0KG0f6QzDwLF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:17:05 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJC01cT113584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 07:17:03 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27eaas582n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 07:17:02 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 22:16:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7B6EB2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:16:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJCGvLm31064202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:16:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJCGugC024999
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:16:57 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] selftest/powerpc: Wrong PMC initialized in pmc56_overflow test
Date: Mon, 19 Dec 2016 17:46:53 +0530
Message-Id: <1482149813-24652-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test uses PMC2 to count the event. But PMC1 is being initialized.
Patch to fix it.

Fixes: 3752e453f6ba ('selftests/powerpc: Add tests of PMU EBBs')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
index c22860ab9733..30e1ac62e8cb 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
@@ -66,7 +66,7 @@ int pmc56_overflow(void)
 
 	FAIL_IF(ebb_event_enable(&event));
 
-	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC2, pmc_sample_period(sample_period));
 	mtspr(SPRN_PMC5, 0);
 	mtspr(SPRN_PMC6, 0);
 
-- 
2.7.4
