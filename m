Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbdH02zdzzDqKn
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 20:41:48 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v259cXs7111594
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 04:41:38 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm3d4rj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 04:41:38 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 5 Mar 2017 15:11:35 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DFF853940033
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 15:11:33 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v259fXYE16973892
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:33 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v259fVEQ014583
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:33 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/6] powerpc/perf: Export memory hierarchy info to user space
Date: Sun,  5 Mar 2017 15:11:13 +0530
In-Reply-To: <1488706877-28604-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488706877-28604-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488706877-28604-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The LDST field and DATA_SRC in SIER identifies the memory hierarchy level
(eg: L1, L2 etc), from which a data-cache miss for a marked instruction
was satisfied. Use the 'perf_mem_data_src' object to export this
hierarchy level to user space.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/perf_event_server.h |  2 +
 arch/powerpc/perf/core-book3s.c              |  4 ++
 arch/powerpc/perf/isa207-common.c            | 78 ++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h            | 16 +++++-
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index ae0a23091a9b..446cdcd9b7f5 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -38,6 +38,8 @@ struct power_pmu {
 				unsigned long *valp);
 	int		(*get_alternatives)(u64 event_id, unsigned int flags,
 				u64 alt[]);
+	void		(*get_mem_data_src)(union perf_mem_data_src *dsrc,
+				u32 flags, struct pt_regs *regs);
 	u64             (*bhrb_filter_map)(u64 branch_sample_type);
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 595dd718ea87..d644c5ab4d2f 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2047,6 +2047,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
 
+		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
+						ppmu->get_mem_data_src)
+			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index e79fb5fb817d..08bb62454a2e 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -119,6 +119,84 @@ static bool is_thresh_cmp_valid(u64 event)
 	return true;
 }
 
+static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
+{
+	u64 ret = 0;
+
+	switch(idx) {
+	case 0:
+		ret = P(LVL, NA);
+		break;
+	case 1:
+		ret = PLH(LVL, L1);
+		break;
+	case 2:
+		ret = PLH(LVL, L2);
+		break;
+	case 3:
+		ret = PLH(LVL, L3);
+		break;
+	case 4:
+		if (sub_idx <= 1)
+			ret = PLH(LVL, LOC_RAM);
+		else if (sub_idx > 1 && sub_idx <= 2)
+			ret = PLH(LVL, REM_RAM1);
+		else
+			ret = PLH(LVL, REM_RAM2);
+		ret |= P(SNOOP, HIT);
+		break;
+	case 5:
+		if ((sub_idx == 0) || (sub_idx == 2) || (sub_idx == 4))
+			ret = (PLH(LVL, REM_CCE1) | P(SNOOP, HIT));
+		else if ((sub_idx == 1) || (sub_idx == 3) || (sub_idx == 5))
+			ret = (PLH(LVL, REM_CCE1) | P(SNOOP, HITM));
+		break;
+	case 6:
+		if ((sub_idx == 0) || (sub_idx == 2))
+			ret = (PLH(LVL, REM_CCE2) | P(SNOOP, HIT));
+		else if ((sub_idx == 1) || (sub_idx == 3))
+			ret = (PLH(LVL, REM_CCE2) | P(SNOOP, HITM));
+		break;
+	case 7:
+		ret = PSM(LVL, L1);
+		break;
+	}
+
+	return ret;
+}
+
+static inline bool is_load_store_inst(u64 sier)
+{
+	u64 val;
+	val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
+
+	/* 1 = load, 2 = store */
+	return val == 1 || val == 2;
+}
+
+void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
+							struct pt_regs *regs)
+{
+	u64 idx;
+	u32 sub_idx;
+	u64 sier;
+
+	/* Skip if no SIER support */
+	if (!(flags & PPMU_HAS_SIER)) {
+		dsrc->val = 0;
+		return;
+	}
+
+	sier = mfspr(SPRN_SIER);
+	if (is_load_store_inst(sier)) {
+		idx = (sier & ISA207_SIER_LDST_MASK) >> ISA207_SIER_LDST_SHIFT;
+		sub_idx = (sier & ISA207_SIER_DATA_SRC_MASK) >> ISA207_SIER_DATA_SRC_SHIFT;
+
+		dsrc->val = isa207_find_source(idx, sub_idx);
+	}
+}
+
+
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 {
 	unsigned int unit, pmc, cache, ebb;
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index cf9bd8990159..982542cce991 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -259,6 +259,19 @@
 #define MAX_ALT				2
 #define MAX_PMU_COUNTERS		6
 
+#define ISA207_SIER_TYPE_SHIFT		15
+#define ISA207_SIER_TYPE_MASK		(0x7ull << ISA207_SIER_TYPE_SHIFT)
+
+#define ISA207_SIER_LDST_SHIFT		1
+#define ISA207_SIER_LDST_MASK		(0x7ull << ISA207_SIER_LDST_SHIFT)
+
+#define ISA207_SIER_DATA_SRC_SHIFT	53
+#define ISA207_SIER_DATA_SRC_MASK	(0x7ull << ISA207_SIER_DATA_SRC_SHIFT)
+
+#define P(a, b)				PERF_MEM_S(a, b)
+#define PLH(a, b)			(P(OP, LOAD) | P(LVL, HIT) | P(a, b))
+#define PSM(a, b)			(P(OP, STORE) | P(LVL, MISS) | P(a, b))
+
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp);
 int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], unsigned long mmcr[],
@@ -266,6 +279,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
 int isa207_get_alternatives(u64 event, u64 alt[],
 				const unsigned int ev_alt[][MAX_ALT], int size);
-
+void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
+							struct pt_regs *regs);
 
 #endif
-- 
2.7.4
