Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBpWD248QzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:25:12 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UCP3k7044531
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:09 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28a5dr82sd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:09 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 22:24:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A75573578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:54 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UCOkX529491232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:54 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UCOMOL007470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:22 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powerpc/perf: Add restrictions to PMC5 in power9 DD1
Date: Mon, 30 Jan 2017 17:53:41 +0530
In-Reply-To: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1485779021-31936-5-git-send-email-maddy@linux.vnet.ibm.com>
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
index a956bda9ecf4..ce00df370ce8 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -438,7 +438,7 @@ static struct power_pmu power9_isa207_pmu = {
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
