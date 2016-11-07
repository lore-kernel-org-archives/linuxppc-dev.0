Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBvtH3YRpzDvVx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 12:26:47 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA71NhQI090518
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 20:26:45 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26jc1b78v1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 20:26:44 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 06:56:41 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 07F0CE0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 06:56:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA71QciF45547752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:38 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA71QbXE000608
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:37 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/perf: macros for PowerISA v3.0 format encoding
Date: Mon,  7 Nov 2016 06:56:19 +0530
In-Reply-To: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1478481979-26224-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch to add macros and constants to support the PowerISA v3.0 raw
event encoding format. Couple of new functions added to support
the new width and location of bit fields like PMCxCOMB and THRESH_CMP
within MMCR* in PowerISA v3.0.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 88 ++++++++++++++++++++++++++++++++++++---
 arch/powerpc/perf/isa207-common.h | 27 +++++++++++-
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 2a2040ea5f99..a3d8a6f31226 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -55,6 +55,81 @@ static inline bool event_is_fab_match(u64 event)
 	return (event == 0x30056 || event == 0x4f052);
 }
 
+static bool is_event_valid(u64 event)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+		(cpu_has_feature(CPU_FTR_POWER9_DD1)) &&
+		(event & ~EVENT_VALID_MASK))
+		return false;
+	else if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+		(event & ~ISA300_EVENT_VALID_MASK))
+		return false;
+	else if (event & ~EVENT_VALID_MASK)
+		return false;
+
+	return true;
+}
+
+static u64 mmcra_sdar_mode(u64 event)
+{
+	u64 sm;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	   (cpu_has_feature(CPU_FTR_POWER9_DD1))) {
+		goto sm_tlb;
+	} else if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		sm = (event >> ISA300_SDAR_MODE_SHIFT) & ISA300_SDAR_MODE_MASK;
+		if (sm)
+			return sm<<MMCRA_SDAR_MODE_SHIFT;
+	} else
+		goto sm_tlb;
+
+sm_tlb:
+	return MMCRA_SDAR_MODE_TLB;
+}
+
+static u64 thresh_cmp_val(u64 value)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	   (cpu_has_feature(CPU_FTR_POWER9_DD1)))
+		goto thr_cmp;
+	else if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return value<<ISA300_MMCRA_THR_CMP_SHIFT;
+	else
+		goto thr_cmp;
+thr_cmp:
+	return value<<MMCRA_THR_CMP_SHIFT;
+}
+
+static unsigned long combine_from_event(u64 event)
+{
+	unsigned long combine;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	   (cpu_has_feature(CPU_FTR_POWER9_DD1)))
+		combine = (event >> EVENT_COMBINE_SHIFT) & EVENT_COMBINE_MASK;
+	else if (cpu_has_feature(CPU_FTR_ARCH_300))
+		combine = (event >> ISA300_EVENT_COMBINE_SHIFT) & ISA300_EVENT_COMBINE_MASK;
+	else
+		combine = (event >> EVENT_COMBINE_SHIFT) & EVENT_COMBINE_MASK;
+
+	return combine;
+}
+
+static unsigned long combine_shift(unsigned long pmc)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	   (cpu_has_feature(CPU_FTR_POWER9_DD1)))
+		goto comb_shift;
+	else if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return ISA300_MMCR1_COMBINE_SHIFT(pmc);
+	else
+		goto comb_shift;
+
+comb_shift:
+	return MMCR1_COMBINE_SHIFT(pmc);
+}
+
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 {
 	unsigned int unit, pmc, cache, ebb;
@@ -62,7 +137,7 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 
 	mask = value = 0;
 
-	if (event & ~EVENT_VALID_MASK)
+	if (!is_event_valid(event))
 		return -1;
 
 	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
@@ -189,15 +264,13 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 			pmc_inuse |= 1 << pmc;
 	}
 
-	/* In continuous sampling mode, update SDAR on TLB miss */
-	mmcra = MMCRA_SDAR_MODE_TLB;
 	mmcr1 = mmcr2 = 0;
 
 	/* Second pass: assign PMCs, set all MMCR1 fields */
 	for (i = 0; i < n_ev; ++i) {
 		pmc     = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
 		unit    = (event[i] >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
-		combine = (event[i] >> EVENT_COMBINE_SHIFT) & EVENT_COMBINE_MASK;
+		combine = combine_from_event(event[i]);
 		psel    =  event[i] & EVENT_PSEL_MASK;
 
 		if (!pmc) {
@@ -211,10 +284,13 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 
 		if (pmc <= 4) {
 			mmcr1 |= unit << MMCR1_UNIT_SHIFT(pmc);
-			mmcr1 |= combine << MMCR1_COMBINE_SHIFT(pmc);
+			mmcr1 |= combine << combine_shift(pmc);
 			mmcr1 |= psel << MMCR1_PMCSEL_SHIFT(pmc);
 		}
 
+		/* In continuous sampling mode, update SDAR on TLB miss */
+		mmcra |= mmcra_sdar_mode(event[i]);
+
 		if (event[i] & EVENT_IS_L1) {
 			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
 			mmcr1 |= (cache & 1) << MMCR1_IC_QUAL_SHIFT;
@@ -245,7 +321,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 			val = (event[i] >> EVENT_THR_SEL_SHIFT) & EVENT_THR_SEL_MASK;
 			mmcra |= val << MMCRA_THR_SEL_SHIFT;
 			val = (event[i] >> EVENT_THR_CMP_SHIFT) & EVENT_THR_CMP_MASK;
-			mmcra |= val << MMCRA_THR_CMP_SHIFT;
+			mmcra |= thresh_cmp_val(val);
 		}
 
 		if (event[i] & EVENT_WANTS_BHRB) {
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 4d0a4e5017c2..0a240635cf48 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -134,6 +134,24 @@
 	 PERF_SAMPLE_BRANCH_KERNEL      |\
 	 PERF_SAMPLE_BRANCH_HV)
 
+/* Contants to support PowerISA v3.0 encoding format */
+#define ISA300_EVENT_COMBINE_SHIFT	10	/* Combine bit */
+#define ISA300_EVENT_COMBINE_MASK	0x3ull
+#define ISA300_SDAR_MODE_SHIFT		50
+#define ISA300_SDAR_MODE_MASK		0x3ull
+
+#define ISA300_EVENT_VALID_MASK		\
+	((ISA300_SDAR_MODE_MASK<< ISA300_SDAR_MODE_SHIFT	|	\
+	(EVENT_THRESH_MASK    << EVENT_THRESH_SHIFT)		|	\
+	(EVENT_SAMPLE_MASK    << EVENT_SAMPLE_SHIFT)		|	\
+	(EVENT_CACHE_SEL_MASK << EVENT_CACHE_SEL_SHIFT)		|	\
+	(EVENT_PMC_MASK       << EVENT_PMC_SHIFT)		|	\
+	(EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
+	(ISA300_EVENT_COMBINE_MASK << ISA300_EVENT_COMBINE_SHIFT) |	\
+	(EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
+	 EVENT_LINUX_MASK					|	\
+	 EVENT_PSEL_MASK))
+
 /*
  * Layout of constraint bits:
  *
@@ -210,15 +228,22 @@
 #define MMCR1_DC_QUAL_SHIFT		47
 #define MMCR1_IC_QUAL_SHIFT		46
 
+/* MMCR1 Combine bits macro for PowerISA v3.0 */
+#define ISA300_MMCR1_COMBINE_SHIFT(pmc)	(38 - ((pmc - 1) * 2))
+
 /* Bits in MMCRA for PowerISA v2.07 */
 #define MMCRA_SAMP_MODE_SHIFT		1
 #define MMCRA_SAMP_ELIG_SHIFT		4
 #define MMCRA_THR_CTL_SHIFT		8
 #define MMCRA_THR_SEL_SHIFT		16
 #define MMCRA_THR_CMP_SHIFT		32
-#define MMCRA_SDAR_MODE_TLB		(1ull << 42)
+#define MMCRA_SDAR_MODE_SHIFT		42
+#define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
 
+/* MMCR1 Threshold Compare bit constant for PowerISA v3.0 */
+#define ISA300_MMCRA_THR_CMP_SHIFT	45
+
 /* Bits in MMCR2 for PowerISA v2.07 */
 #define MMCR2_FCS(pmc)			(1ull << (63 - (((pmc) - 1) * 9)))
 #define MMCR2_FCP(pmc)			(1ull << (62 - (((pmc) - 1) * 9)))
-- 
2.7.4
