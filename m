Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvRzh0QNVzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 23:38:07 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05CYJkU119017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 07:38:05 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sjbyuyrp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 07:38:04 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 22:38:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A971C2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 23:38:00 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05Cc17U55574688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 23:38:01 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05Cc04M016714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 23:38:00 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] powerpc/perf: support new BHRB filtering modes
Date: Thu,  5 Jan 2017 18:07:53 +0530
In-Reply-To: <1483619873-13899-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483619873-13899-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483619873-13899-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for new BHRB filtering modes in power9.
Filtering modes restrict the type of branch
instructions that can enter into the BHRB.

The filtering criteria are defined using the following
terminology, Call, Return, Jump, Conditional Branch,
Unconditional Branch, Indirect Branch and Direct Branch.

PowerISA v3.0 defines 5 new BHRB filtering bits
in MMCRA[27:31] for the software to prevent various
combinations of each of the above types of Branch
instructions from being entered into the BHRB.

Patch updates the branch types based on "Progrmming Note"
information from PowerISA v3.0 "BHRB Filtering" section.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
1) Added mode comments in code
2) Updates to commit message

 arch/powerpc/perf/power9-pmu.c | 53 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 56ad09801fff..0d232916cab2 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -103,6 +103,31 @@ enum {
 #define POWER9_MMCRA_IFM2		0x0000000080000000UL
 #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
 
+/*
+ * BHRB Filtering mode FJ -- Filter Jump Instructions
+ */
+#define POWER9_MMCRA_FJ			0x0000000100000000UL
+
+/*
+ * BHRB Filtering mode FR -- Filter Return Instructions
+ */
+#define POWER9_MMCRA_FR			0x0000000200000000UL
+
+/*
+ * BHRB Filtering mode FC -- Filter Call Instructions
+ */
+#define POWER9_MMCRA_FC			0x0000000400000000UL
+
+/*
+ * BHRB Filtering mode FU -- Filter Unconditional Branch Instructions
+ */
+#define POWER9_MMCRA_FU			0x0000000800000000UL
+
+/*
+ * BHRB Filtering mode FD -- Filter Direct Branch Instructions
+ */
+#define POWER9_MMCRA_FD			0x0000001000000000UL
+
 /* PowerISA v2.07 format attribute structure*/
 extern struct attribute_group isa207_pmu_format_group;
 
@@ -240,14 +265,30 @@ static u64 power9_bhrb_filter_map(u64 branch_sample_type)
 		return pmu_bhrb_filter;
 
 	/* Invalid branch filter options - HW does not support */
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
-		return -1;
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN) {
+		pmu_bhrb_filter = POWER9_MMCRA_FC | POWER9_MMCRA_FJ;
+		return pmu_bhrb_filter;
+	}
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
-		return -1;
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
+		pmu_bhrb_filter = POWER9_MMCRA_FD | POWER9_MMCRA_FR | POWER9_MMCRA_FJ;
+		return pmu_bhrb_filter;
+	}
 
-	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL)
-		return -1;
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
+		pmu_bhrb_filter = POWER9_MMCRA_FU;
+		return pmu_bhrb_filter;
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_JUMP) {
+		pmu_bhrb_filter = POWER9_MMCRA_FD | POWER9_MMCRA_FC | POWER9_MMCRA_FR;
+		return pmu_bhrb_filter;
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_CALL) {
+		pmu_bhrb_filter = POWER9_MMCRA_FC;
+		return pmu_bhrb_filter;
+	}
 
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
 		pmu_bhrb_filter |= POWER9_MMCRA_IFM1;
-- 
2.7.4
