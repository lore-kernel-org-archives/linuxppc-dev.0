Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRlc34bQxzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:59:15 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KDtdSi046356
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:59:13 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pk55y1e4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:59:12 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 19:29:09 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B386F3940033
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:29:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KDw4RA27263146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:28:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KDx5Qj024157
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:29:07 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Handle sdar_mode for marked event in power9
Date: Mon, 20 Feb 2017 19:29:03 +0530
Message-Id: <1487599143-28749-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MMCRA[SDAR_MODE] specifices how the SDAR should be updated in
continous sampling mode. On P9 it must be set to 0b00 when
MMCRA[63] is set.

Fixes: c7c3f568beff2 ('powerpc/perf: macros for power9 format encoding')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 43 ++++++++++++++++++++++++++++++++-------
 arch/powerpc/perf/isa207-common.h |  1 +
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 50e598cf644b..9078d4b5fa55 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -65,12 +65,41 @@ static bool is_event_valid(u64 event)
 	return !(event & ~valid_mask);
 }
 
-static u64 mmcra_sdar_mode(u64 event)
+static inline bool is_event_marked(u64 event)
 {
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
-		return p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
+	if (event & EVENT_IS_MARKED)
+		return true;
+
+	return false;
+}
 
-	return MMCRA_SDAR_MODE_TLB;
+static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
+{
+	/*
+	 * MMCRA[SDAR_MODE] specifices how the SDAR should be updated in
+	 * continous sampling mode.
+	 *
+	 * Incase of Power8:
+	 * MMCRA[SDAR_MODE] will be programmed as "0b01" for continous sampling
+	 * mode and will be un-changed when setting MMCRA[63] (Marked events).
+	 *
+	 * Incase of Power9:
+	 * Marked event: MMCRA[SDAR_MODE] will be set to 0b00 ('No Updates'),
+	 *               or if group already have any marked events.
+	 * Non-Marked events (for DD1):
+	 *	MMCRA[SDAR_MODE] will be set to 0b01
+	 * For rest
+	 *	MMCRA[SDAR_MODE] will be set from event code.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (is_event_marked(event) || (*mmcra & MMCRA_SAMPLE_ENABLE))
+			*mmcra &= MMCRA_SDAR_MODE_NO_UPDATES;
+		else if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+			*mmcra |=  p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
+		else if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+			*mmcra |= MMCRA_SDAR_MODE_TLB;
+	} else
+		*mmcra |= MMCRA_SDAR_MODE_TLB;
 }
 
 static u64 thresh_cmp_val(u64 value)
@@ -158,7 +187,7 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 		value |= CNST_L1_QUAL_VAL(cache);
 	}
 
-	if (event & EVENT_IS_MARKED) {
+	if (is_event_marked(event)) {
 		mask  |= CNST_SAMPLE_MASK;
 		value |= CNST_SAMPLE_VAL(event >> EVENT_SAMPLE_SHIFT);
 	}
@@ -256,7 +285,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 		}
 
 		/* In continuous sampling mode, update SDAR on TLB miss */
-		mmcra |= mmcra_sdar_mode(event[i]);
+		mmcra_sdar_mode(event[i], &mmcra);
 
 		if (event[i] & EVENT_IS_L1) {
 			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
@@ -265,7 +294,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 			mmcr1 |= (cache & 1) << MMCR1_DC_QUAL_SHIFT;
 		}
 
-		if (event[i] & EVENT_IS_MARKED) {
+		if (is_event_marked(event[i])) {
 			mmcra |= MMCRA_SAMPLE_ENABLE;
 
 			val = (event[i] >> EVENT_SAMPLE_SHIFT) & EVENT_SAMPLE_MASK;
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 90495f1580c7..7554dd4b4e43 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -242,6 +242,7 @@
 #define MMCRA_THR_CMP_SHIFT		32
 #define MMCRA_SDAR_MODE_SHIFT		42
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
+#define MMCRA_SDAR_MODE_NO_UPDATES	~(0x3ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
 
 /* MMCR1 Threshold Compare bit constant for power9 */
-- 
2.7.4
