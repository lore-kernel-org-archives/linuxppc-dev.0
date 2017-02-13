Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMNjl67z4zDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:34:03 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1DBXlsQ052882
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 06:34:01 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kax4jxws-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 06:34:00 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 21:33:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3ED1C2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:33:54 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1DBXke836372592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:33:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1DBXLQq021500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:33:22 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Avoid FAB_*_MATCH checks for power9
Date: Mon, 13 Feb 2017 17:02:54 +0530
Message-Id: <1486985574-32608-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since power9 does not support FAB_*_MATCH bits in MMCR1,
avoid these checks for power9. For this, patch factor out
code in isa207_get_constraint() to retain these checks
only for power8.

Patch also updates the comment in power9-pmu raw event
encode layout to remove FAB_*_MATCH.

Finally for power9, patch adds additional check for
threshold events when adding the thresh mask and value in
isa207_get_constraint().

fixes: 7ffd948fae4c ('powerpc/perf: factor out power8 pmu functions')
fixes: 18201b204286 ('powerpc/perf: power9 raw event format encoding')
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 58 ++++++++++++++++++++++++++-------------
 arch/powerpc/perf/power9-pmu.c    |  8 ++----
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 50e598cf644b..2703a1e340e7 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -97,6 +97,28 @@ static unsigned long combine_shift(unsigned long pmc)
 	return MMCR1_COMBINE_SHIFT(pmc);
 }
 
+static inline bool event_is_threshold(u64 event)
+{
+	return (event >> EVENT_THR_SEL_SHIFT) & EVENT_THR_SEL_MASK;
+}
+
+static bool is_thresh_cmp_valid(u64 event)
+{
+	unsigned int cmp, exp;
+
+	/*
+	 * Check the mantissa upper two bits are not zero, unless the
+	 * exponent is also zero. See the THRESH_CMP_MANTISSA doc.
+	 */
+	cmp = (event >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
+	exp = cmp >> 7;
+
+	if (exp && (cmp & 0x60) == 0)
+		return false;
+
+	return true;
+}
+
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 {
 	unsigned int unit, pmc, cache, ebb;
@@ -163,28 +185,26 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 		value |= CNST_SAMPLE_VAL(event >> EVENT_SAMPLE_SHIFT);
 	}
 
-	/*
-	 * Special case for PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
-	 * the threshold control bits are used for the match value.
-	 */
-	if (event_is_fab_match(event)) {
-		mask  |= CNST_FAB_MATCH_MASK;
-		value |= CNST_FAB_MATCH_VAL(event >> EVENT_THR_CTL_SHIFT);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))  {
+		if (event_is_threshold(event) && is_thresh_cmp_valid(event)) {
+			mask  |= CNST_THRESH_MASK;
+			value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
+		}
 	} else {
 		/*
-		 * Check the mantissa upper two bits are not zero, unless the
-		 * exponent is also zero. See the THRESH_CMP_MANTISSA doc.
+		 * Special case for PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
+		 * the threshold control bits are used for the match value.
 		 */
-		unsigned int cmp, exp;
-
-		cmp = (event >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
-		exp = cmp >> 7;
-
-		if (exp && (cmp & 0x60) == 0)
-			return -1;
+		if (event_is_fab_match(event)) {
+			mask  |= CNST_FAB_MATCH_MASK;
+			value |= CNST_FAB_MATCH_VAL(event >> EVENT_THR_CTL_SHIFT);
+		} else {
+			if (!is_thresh_cmp_valid(event))
+				return -1;
 
-		mask  |= CNST_THRESH_MASK;
-		value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
+			mask  |= CNST_THRESH_MASK;
+			value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
+		}
 	}
 
 	if (!pmc && ebb)
@@ -279,7 +299,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 		 * PM_MRK_FAB_RSP_MATCH and PM_MRK_FAB_RSP_MATCH_CYC,
 		 * the threshold bits are used for the match value.
 		 */
-		if (event_is_fab_match(event[i])) {
+		if (!cpu_has_feature(CPU_FTR_ARCH_300) && event_is_fab_match(event[i])) {
 			mmcr1 |= ((event[i] >> EVENT_THR_CTL_SHIFT) &
 				  EVENT_THR_CTL_MASK) << MMCR1_FAB_SHIFT;
 		} else {
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 7332634e18c9..7950cee7d617 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -22,7 +22,7 @@
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
  *   | | [ ]                       [ ] [      thresh_cmp     ]   [  thresh_ctl   ]
  *   | |  |                         |                                     |
- *   | |  *- IFM (Linux)            |    thresh start/stop OR FAB match -*
+ *   | |  *- IFM (Linux)            |	               thresh start/stop -*
  *   | *- BHRB (Linux)              *sm
  *   *- EBB (Linux)
  *
@@ -50,11 +50,9 @@
  * MMCR1[31]   = pmc4combine[1]
  *
  * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
- *	# PM_MRK_FAB_RSP_MATCH
- *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ *	MMCR1[20:27] = thresh_ctl
  * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
- *	# PM_MRK_FAB_RSP_MATCH_CYC
- *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ *	MMCR1[20:27] = thresh_ctl
  * else
  *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
  *
-- 
2.7.4
