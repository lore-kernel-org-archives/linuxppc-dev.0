Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D697E2C0127
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:57:01 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 18:22:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AAAC6E0056
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:28:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3GCumpR9503016
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:26:48 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3GCusc3001593
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:56:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] powerpc,
 perf: Enable branch stack sampling framework support with BHRB
Date: Tue, 16 Apr 2013 18:26:40 +0530
Message-Id: <1366117000-10979-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides basic enablement for perf branch stack sampling framework
on POWER8 processor with a new PMU feature called BHRB (Branch History Rolling
Buffer).

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c     | 96 +++++++++++++++++++++++++++++++++++--
 arch/powerpc/perf/perf_event_bhrb.c | 75 +++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/perf/perf_event_bhrb.c

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4ac6e64..f4d1347 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -19,6 +19,8 @@
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
 
+#define BHRB_MAX_ENTRIES	32
+
 struct cpu_hw_events {
 	int n_events;
 	int n_percpu;
@@ -38,11 +40,21 @@ struct cpu_hw_events {
 
 	unsigned int group_flag;
 	int n_txn_start;
+
+	/* BHRB bits */
+	u64				bhrb_filter;	/* BHRB HW branch filter */
+	int				bhrb_users;
+	void				*bhrb_context;
+	struct	perf_branch_stack	bhrb_stack;
+	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
 };
+
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 struct power_pmu *ppmu;
 
+#include "perf_event_bhrb.c"
+
 /*
  * Normally, to ignore kernel events we set the FCS (freeze counters
  * in supervisor mode) bit in MMCR0, but if the kernel runs with the
@@ -858,6 +870,9 @@ static void power_pmu_enable(struct pmu *pmu)
 	}
 
  out:
+	if (cpuhw->bhrb_users)
+		ppmu->config_bhrb(cpuhw->bhrb_filter);
+
 	local_irq_restore(flags);
 }
 
@@ -888,6 +903,47 @@ static int collect_events(struct perf_event *group, int max_count,
 	return n;
 }
 
+/* Reset all possible BHRB entries */
+static void power_pmu_bhrb_reset(void)
+{
+	asm volatile(PPC_CLRBHRB);
+}
+
+void power_pmu_bhrb_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	if (!ppmu->bhrb_nr)
+		return;
+
+	/* Clear BHRB if we changed task context to avoid data leaks */
+	if (event->ctx->task && cpuhw->bhrb_context != event->ctx) {
+		power_pmu_bhrb_reset();
+		cpuhw->bhrb_context = event->ctx;
+	}
+	cpuhw->bhrb_users++;
+}
+
+void power_pmu_bhrb_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
+
+	if (!ppmu->bhrb_nr)
+		return;
+
+	cpuhw->bhrb_users--;
+	WARN_ON_ONCE(cpuhw->bhrb_users < 0);
+
+	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
+		/* BHRB cannot be turned off when other
+		 * events are active on the PMU.
+		 */
+
+		/* avoid stale pointer */
+		cpuhw->bhrb_context = NULL;
+	}
+}
+
 /*
  * Add a event to the PMU.
  * If all events are not already frozen, then we disable and
@@ -947,6 +1003,9 @@ nocheck:
 
 	ret = 0;
  out:
+	if (has_branch_stack(event))
+		power_pmu_bhrb_enable(event);
+
 	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 	return ret;
@@ -999,6 +1058,9 @@ static void power_pmu_del(struct perf_event *event, int ef_flags)
 		cpuhw->mmcr[0] &= ~(MMCR0_PMXE | MMCR0_FCECE);
 	}
 
+	if (has_branch_stack(event))
+		power_pmu_bhrb_disable(event);
+
 	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 }
@@ -1117,6 +1179,15 @@ int power_pmu_commit_txn(struct pmu *pmu)
 	return 0;
 }
 
+/* Called from ctxsw to prevent one process's branch entries to
+ * mingle with the other process's entries during context switch.
+ */
+void power_pmu_flush_branch_stack(void)
+{
+	if (ppmu->bhrb_nr)
+		power_pmu_bhrb_reset();
+}
+
 /*
  * Return 1 if we might be able to put event on a limited PMC,
  * or 0 if not.
@@ -1231,9 +1302,11 @@ static int power_pmu_event_init(struct perf_event *event)
 	if (!ppmu)
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
-		return -EOPNOTSUPP;
+	if (has_branch_stack(event)) {
+	        /* PMU has BHRB enabled */
+		if (!(ppmu->flags & PPMU_BHRB))
+			return -EOPNOTSUPP;
+	}
 
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
@@ -1314,6 +1387,15 @@ static int power_pmu_event_init(struct perf_event *event)
 
 	cpuhw = &get_cpu_var(cpu_hw_events);
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
+
+	if (has_branch_stack(event)) {
+		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+					event->attr.branch_sample_type);
+
+		if(cpuhw->bhrb_filter == -1)
+			return -EOPNOTSUPP;
+	}
+
 	put_cpu_var(cpu_hw_events);
 	if (err)
 		return -EINVAL;
@@ -1372,6 +1454,7 @@ struct pmu power_pmu = {
 	.cancel_txn	= power_pmu_cancel_txn,
 	.commit_txn	= power_pmu_commit_txn,
 	.event_idx	= power_pmu_event_idx,
+	.flush_branch_stack = power_pmu_flush_branch_stack,
 };
 
 
@@ -1433,6 +1516,13 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 		if (event->attr.sample_type & PERF_SAMPLE_ADDR)
 			perf_get_data_addr(regs, &data.addr);
 
+		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
+			struct cpu_hw_events *cpuhw;
+			cpuhw = &__get_cpu_var(cpu_hw_events);
+			power_pmu_bhrb_read(cpuhw);
+			data.br_stack = &cpuhw->bhrb_stack;
+		}
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/arch/powerpc/perf/perf_event_bhrb.c b/arch/powerpc/perf/perf_event_bhrb.c
new file mode 100644
index 0000000..5beddef
--- /dev/null
+++ b/arch/powerpc/perf/perf_event_bhrb.c
@@ -0,0 +1,75 @@
+#define BHRB_TARGET		0x0000000000000002
+#define	BHRB_PREDICTION		0x0000000000000001
+#define	BHRB_EA			0xFFFFFFFFFFFFFFFC
+
+extern unsigned long int read_bhrb(int n);
+
+void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
+{
+	u64 val;
+	u64 addr;
+	int r_index, u_index, target, pred;
+
+	r_index = 0;
+	u_index = 0;
+	while (r_index < ppmu->bhrb_nr) {
+		/* Assembly read function */
+		val = read_bhrb(r_index);
+
+		/* Terminal marker: End of valid BHRB entries */
+		if (val == 0) {
+			break;
+		} else {
+			/* BHRB field break up */
+			addr = val & BHRB_EA;
+			pred = val & BHRB_PREDICTION;
+			target = val & BHRB_TARGET;
+
+			/* Probable Missed entry: Not applicable for POWER8 */
+			if ((addr == 0) && (target == 0) && (pred == 1)) {
+				r_index++;
+				continue;
+			}
+
+			/* Real Missed entry: Power8 based missed entry */
+			if ((addr == 0) && (target == 1) && (pred == 1)) {
+				r_index++;
+				continue;
+			}
+
+			/* Reserved condition: Not a valid entry  */
+			if ((addr == 0) && (target == 1) && (pred == 0)) {
+				r_index++;
+				continue;
+			}
+
+			/* Is a target address */
+			if (val & BHRB_TARGET) {
+				/* First address cannot be a target address */
+				if (r_index == 0) {
+					r_index++;
+					continue;
+				}
+
+				/* Update target address for the previous entry */
+				cpuhw->bhrb_entries[u_index - 1].to = addr;
+				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
+				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
+
+				/* Dont increment u_index */
+				r_index++;
+			} else {
+				/* Update address, flags for current entry */
+				cpuhw->bhrb_entries[u_index].from = addr;
+				cpuhw->bhrb_entries[u_index].mispred = pred;
+				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+
+				/* Successfully popullated one entry */
+				u_index++;
+				r_index++;
+			}
+		}
+	}
+	cpuhw->bhrb_stack.nr = u_index;
+	return;
+}
-- 
1.7.11.7
