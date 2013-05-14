Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 1/3] powerpc/perf: Move BHRB code into CONFIG_PPC64 region
Date: Tue, 14 May 2013 14:44:56 +1000
Message-Id: <1368506698-22400-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1368506698-22400-1-git-send-email-mikey@neuling.org>
References: <1368506698-22400-1-git-send-email-mikey@neuling.org>
In-Reply-To: <9911.1368179795@ale.ozlabs.ibm.com>
References: <9911.1368179795@ale.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new Branch History Rolling buffer (BHRB) code is only useful on 64bit
processors, so move it into the #ifdef CONFIG_PPC64 region.

This avoids code bloat on 32bit systems.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/perf/core-book3s.c |  248 ++++++++++++++++++++-------------------
 1 file changed, 127 insertions(+), 121 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c627843..843bb8b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -100,6 +100,10 @@ static inline int siar_valid(struct pt_regs *regs)
 	return 1;
 }
 
+static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
+static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
+void power_pmu_flush_branch_stack(void) {}
+static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 #endif /* CONFIG_PPC32 */
 
 static bool regs_use_siar(struct pt_regs *regs)
@@ -308,6 +312,129 @@ static inline int siar_valid(struct pt_regs *regs)
 	return 1;
 }
 
+
+/* Reset all possible BHRB entries */
+static void power_pmu_bhrb_reset(void)
+{
+	asm volatile(PPC_CLRBHRB);
+}
+
+static void power_pmu_bhrb_enable(struct perf_event *event)
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
+static void power_pmu_bhrb_disable(struct perf_event *event)
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
+/* Called from ctxsw to prevent one process's branch entries to
+ * mingle with the other process's entries during context switch.
+ */
+void power_pmu_flush_branch_stack(void)
+{
+	if (ppmu->bhrb_nr)
+		power_pmu_bhrb_reset();
+}
+
+
+/* Processing BHRB entries */
+static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
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
+
 #endif /* CONFIG_PPC64 */
 
 static void perf_event_interrupt(struct pt_regs *regs);
@@ -904,47 +1031,6 @@ static int collect_events(struct perf_event *group, int max_count,
 	return n;
 }
 
-/* Reset all possible BHRB entries */
-static void power_pmu_bhrb_reset(void)
-{
-	asm volatile(PPC_CLRBHRB);
-}
-
-void power_pmu_bhrb_enable(struct perf_event *event)
-{
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	if (!ppmu->bhrb_nr)
-		return;
-
-	/* Clear BHRB if we changed task context to avoid data leaks */
-	if (event->ctx->task && cpuhw->bhrb_context != event->ctx) {
-		power_pmu_bhrb_reset();
-		cpuhw->bhrb_context = event->ctx;
-	}
-	cpuhw->bhrb_users++;
-}
-
-void power_pmu_bhrb_disable(struct perf_event *event)
-{
-	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
-
-	if (!ppmu->bhrb_nr)
-		return;
-
-	cpuhw->bhrb_users--;
-	WARN_ON_ONCE(cpuhw->bhrb_users < 0);
-
-	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
-		/* BHRB cannot be turned off when other
-		 * events are active on the PMU.
-		 */
-
-		/* avoid stale pointer */
-		cpuhw->bhrb_context = NULL;
-	}
-}
-
 /*
  * Add a event to the PMU.
  * If all events are not already frozen, then we disable and
@@ -1180,15 +1266,6 @@ int power_pmu_commit_txn(struct pmu *pmu)
 	return 0;
 }
 
-/* Called from ctxsw to prevent one process's branch entries to
- * mingle with the other process's entries during context switch.
- */
-void power_pmu_flush_branch_stack(void)
-{
-	if (ppmu->bhrb_nr)
-		power_pmu_bhrb_reset();
-}
-
 /*
  * Return 1 if we might be able to put event on a limited PMC,
  * or 0 if not.
@@ -1458,77 +1535,6 @@ struct pmu power_pmu = {
 	.flush_branch_stack = power_pmu_flush_branch_stack,
 };
 
-/* Processing BHRB entries */
-void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
-{
-	u64 val;
-	u64 addr;
-	int r_index, u_index, target, pred;
-
-	r_index = 0;
-	u_index = 0;
-	while (r_index < ppmu->bhrb_nr) {
-		/* Assembly read function */
-		val = read_bhrb(r_index);
-
-		/* Terminal marker: End of valid BHRB entries */
-		if (val == 0) {
-			break;
-		} else {
-			/* BHRB field break up */
-			addr = val & BHRB_EA;
-			pred = val & BHRB_PREDICTION;
-			target = val & BHRB_TARGET;
-
-			/* Probable Missed entry: Not applicable for POWER8 */
-			if ((addr == 0) && (target == 0) && (pred == 1)) {
-				r_index++;
-				continue;
-			}
-
-			/* Real Missed entry: Power8 based missed entry */
-			if ((addr == 0) && (target == 1) && (pred == 1)) {
-				r_index++;
-				continue;
-			}
-
-			/* Reserved condition: Not a valid entry  */
-			if ((addr == 0) && (target == 1) && (pred == 0)) {
-				r_index++;
-				continue;
-			}
-
-			/* Is a target address */
-			if (val & BHRB_TARGET) {
-				/* First address cannot be a target address */
-				if (r_index == 0) {
-					r_index++;
-					continue;
-				}
-
-				/* Update target address for the previous entry */
-				cpuhw->bhrb_entries[u_index - 1].to = addr;
-				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
-				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
-
-				/* Dont increment u_index */
-				r_index++;
-			} else {
-				/* Update address, flags for current entry */
-				cpuhw->bhrb_entries[u_index].from = addr;
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
-
-				/* Successfully popullated one entry */
-				u_index++;
-				r_index++;
-			}
-		}
-	}
-	cpuhw->bhrb_stack.nr = u_index;
-	return;
-}
-
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
-- 
1.7.10.4
