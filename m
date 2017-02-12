Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4Y27kZzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:41 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGwu0Z145048
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:39 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28jr42wvf1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:39 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:36 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 43C77125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH3Xg429229260
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3Wvx009494
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:32 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 6/6] powerpc/perf: Add restrictions to PMC5 in power9 DD1
Date: Sun, 12 Feb 2017 22:33:15 +0530
In-Reply-To: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1486918995-16354-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PMC5 on POWER9 DD1 may not provide right counts in all
sampling scenarios, hence use PM_INST_DISP event instead
in PMC2 or PMC3 in preference.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
No changes, just a rebase

 arch/powerpc/perf/isa207-common.h | 4 ++++
 arch/powerpc/perf/power9-pmu.c    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 3e9150f6690a..cf9bd8990159 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -222,6 +222,10 @@
 	CNST_PMC_VAL(1) | CNST_PMC_VAL(2) | CNST_PMC_VAL(3) | \
 	CNST_PMC_VAL(4) | CNST_PMC_VAL(5) | CNST_PMC_VAL(6) | CNST_NC_VAL
 
+/*
+ * Lets restrict use of PMC5 for instruction counting.
+ */
+#define P9_DD1_TEST_ADDER	(ISA207_TEST_ADDER | CNST_PMC_VAL(5))
 
 /* Bits in MMCR1 for PowerISA v2.07 */
 #define MMCR1_UNIT_SHIFT(pmc)		(60 - (4 * ((pmc) - 1)))
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 454e9f70894f..5fe9cb1dc3b6 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -423,7 +423,7 @@ static struct power_pmu power9_pmu = {
 	.name			= "POWER9",
 	.n_counter		= MAX_PMU_COUNTERS,
 	.add_fields		= ISA207_ADD_FIELDS,
-	.test_adder		= ISA207_TEST_ADDER,
+	.test_adder		= P9_DD1_TEST_ADDER,
 	.compute_mmcr		= isa207_compute_mmcr,
 	.config_bhrb		= power9_config_bhrb,
 	.bhrb_filter_map	= power9_bhrb_filter_map,
-- 
2.7.4
