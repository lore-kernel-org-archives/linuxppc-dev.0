Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4X0RZNzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:39 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGwv4Y046196
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:38 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28j5xu9kc8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:37 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:34 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C0459125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH2VPd23920876
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:32:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3V2F009470
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:31 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 5/6] powerpc/perf: Use Instruction Counter value
Date: Sun, 12 Feb 2017 22:33:14 +0530
In-Reply-To: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1486918995-16354-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since PM_INST_DISP include speculative instruction,
based on the workload the dispatch count could vary
considerably. Hence as an alternative, for completed
instruction counting, program the PM_INST_DISP event
to the MMCR* but use Instruction Counter register value.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
1)Removed the #ifdef and added changes for EBB count updates
 
 arch/powerpc/perf/core-book3s.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 270eb9b74e2e..87d17a1f7168 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -57,6 +57,7 @@ struct cpu_hw_events {
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
+	u64				ic_init;
 };
 
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
@@ -127,6 +128,10 @@ static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
 static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
 static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
+static bool use_ic(u64 event)
+{
+	return false;
+}
 #endif /* CONFIG_PPC32 */
 
 static bool regs_use_siar(struct pt_regs *regs)
@@ -688,6 +693,15 @@ static void pmao_restore_workaround(bool ebb)
 	mtspr(SPRN_PMC5, pmcs[4]);
 	mtspr(SPRN_PMC6, pmcs[5]);
 }
+
+static bool use_ic(u64 event)
+{
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1) &&
+			(event == 0x200f2 || event == 0x300f2))
+		return true;
+
+	return false;
+}
 #endif /* CONFIG_PPC64 */
 
 static void perf_event_interrupt(struct pt_regs *regs);
@@ -1007,6 +1021,7 @@ static u64 check_and_compute_delta(u64 prev, u64 val)
 static void power_pmu_read(struct perf_event *event)
 {
 	s64 val, delta, prev;
+	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
 	if (event->hw.state & PERF_HES_STOPPED)
 		return;
@@ -1016,6 +1031,13 @@ static void power_pmu_read(struct perf_event *event)
 
 	if (is_ebb_event(event)) {
 		val = read_pmc(event->hw.idx);
+		if (use_ic(event->attr.config)) {
+			val = mfspr(SPRN_IC);
+			if (val > cpuhw->ic_init)
+				val = val - cpuhw->ic_init;
+			else
+				val = val + (0 - cpuhw->ic_init);
+		}
 		local64_set(&event->hw.prev_count, val);
 		return;
 	}
@@ -1029,6 +1051,13 @@ static void power_pmu_read(struct perf_event *event)
 		prev = local64_read(&event->hw.prev_count);
 		barrier();
 		val = read_pmc(event->hw.idx);
+		if (use_ic(event->attr.config)) {
+			val = mfspr(SPRN_IC);
+			if (val > cpuhw->ic_init)
+				val = val - cpuhw->ic_init;
+			else
+				val = val + (0 - cpuhw->ic_init);
+		}
 		delta = check_and_compute_delta(prev, val);
 		if (!delta)
 			return;
@@ -1466,6 +1495,13 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 					event->attr.branch_sample_type);
 	}
 
+	/*
+	 * Workaround for POWER9 DD1 to use the Instruction Counter
+	 * register value for instruction counting
+	 */
+	if (use_ic(event->attr.config))
+		cpuhw->ic_init = mfspr(SPRN_IC);
+
 	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 	return ret;
-- 
2.7.4
