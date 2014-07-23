Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1231F1A0935
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:12:53 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/perf: Add per-event excludes on Power8
Date: Wed, 23 Jul 2014 21:12:38 +1000
Message-Id: <1406113958-28653-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406113958-28653-1-git-send-email-mpe@ellerman.id.au>
References: <1406113958-28653-1-git-send-email-mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power8 has a new register (MMCR2), which contains individual freeze bits
for each counter. This is an improvement on previous chips as it means
we can have multiple events on the PMU at the same time with different
exclude_{user,kernel,hv} settings. Previously we had to ensure all
events on the PMU had the same exclude settings.

The core of the patch is fairly simple. We use the 207S feature flag to
indicate that the PMU backend supports per-event excludes, if it's set
we skip the generic logic that enforces the equality of excludes between
events. We also use that flag to skip setting the freeze bits in MMCR0,
the PMU backend is expected to have handled setting them in MMCR2.

The complication arises with EBB. The FCxP bits in MMCR2 are accessible
R/W to a task using EBB. Which means a task using EBB will be able to
see that we are using MMCR2 for freezing, whereas the old logic which
used MMCR0 is not user visible.

The task can not see or affect exclude_kernel & exclude_hv, so we only
need to consider exclude_user.

The table below summarises the behaviour both before and after this
commit is applied:

 exclude_user           true  false
 ------------------------------------
        | User visible |  N    N
 Before | Can freeze   |  Y    Y
        | Can unfreeze |  N    Y
 ------------------------------------
        | User visible |  Y    Y
  After | Can freeze   |  Y    Y
        | Can unfreeze |  Y/N  Y
 ------------------------------------

So firstly I assert that the simple visibility of the exclude_user
setting in MMCR2 is a non-issue. The event belongs to the task, and
was most likely created by the task. So the exclude_user setting is not
privileged information in any way.

Secondly, the behaviour in the exclude_user = false case is unchanged.
This is important as it is the case that is actually useful, ie. the
event is created with no exclude setting and the task uses MMCR2 to
implement exclusion manually.

For exclude_user = true there is no meaningful change to freezing the
event. Previously the task could use MMCR2 to freeze the event, though
it was already frozen with MMCR0. With the new code the task can use
MMCR2 to freeze the event, though it was already frozen with MMCR2.

The only real change is when exclude_user = true and the task tries to
use MMCR2 to unfreeze the event. Previously this had no effect, because
the event was already frozen in MMCR0. With the new code the task can
unfreeze the event in MMCR2, but at some indeterminate time in the
future the kernel will overwrite its setting and refreeze the event.

Therefore my final assertion is that any task using exclude_user = true
and also fiddling with MMCR2 was deeply confused before this change, and
remains so after it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c | 67 +++++++++++++++++++++++++++--------------
 arch/powerpc/perf/power8-pmu.c  | 24 +++++++++++++--
 2 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 01b30238d7d1..b7cd00b0171e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -36,7 +36,12 @@ struct cpu_hw_events {
 	struct perf_event *event[MAX_HWEVENTS];
 	u64 events[MAX_HWEVENTS];
 	unsigned int flags[MAX_HWEVENTS];
-	unsigned long mmcr[3];
+	/*
+	 * The order of the MMCR array is:
+	 *  - 64-bit, MMCR0, MMCR1, MMCRA, MMCR2
+	 *  - 32-bit, MMCR0, MMCR1, MMCR2
+	 */
+	unsigned long mmcr[4];
 	struct perf_event *limited_counter[MAX_LIMITED_HWCOUNTERS];
 	u8  limited_hwidx[MAX_LIMITED_HWCOUNTERS];
 	u64 alternatives[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
@@ -112,9 +117,9 @@ static bool is_ebb_event(struct perf_event *event) { return false; }
 static int ebb_event_check(struct perf_event *event) { return 0; }
 static void ebb_event_add(struct perf_event *event) { }
 static void ebb_switch_out(unsigned long mmcr0) { }
-static unsigned long ebb_switch_in(bool ebb, unsigned long mmcr0)
+static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 {
-	return mmcr0;
+	return cpuhw->mmcr[0];
 }
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
@@ -542,8 +547,10 @@ static void ebb_switch_out(unsigned long mmcr0)
 	current->thread.mmcr2 = mfspr(SPRN_MMCR2) & MMCR2_USER_MASK;
 }
 
-static unsigned long ebb_switch_in(bool ebb, unsigned long mmcr0)
+static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 {
+	unsigned long mmcr0 = cpuhw->mmcr[0];
+
 	if (!ebb)
 		goto out;
 
@@ -568,7 +575,15 @@ static unsigned long ebb_switch_in(bool ebb, unsigned long mmcr0)
 	mtspr(SPRN_SIAR, current->thread.siar);
 	mtspr(SPRN_SIER, current->thread.sier);
 	mtspr(SPRN_SDAR, current->thread.sdar);
-	mtspr(SPRN_MMCR2, current->thread.mmcr2);
+
+	/*
+	 * Merge the kernel & user values of MMCR2. The semantics we implement
+	 * are that the user MMCR2 can set bits, ie. cause counters to freeze,
+	 * but not clear bits. If a task wants to be able to clear bits, ie.
+	 * unfreeze counters, it should not set exclude_xxx in its events and
+	 * instead manage the MMCR2 entirely by itself.
+	 */
+	mtspr(SPRN_MMCR2, cpuhw->mmcr[3] | current->thread.mmcr2);
 out:
 	return mmcr0;
 }
@@ -915,6 +930,14 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	int i, n, first;
 	struct perf_event *event;
 
+	/*
+	 * If the PMU we're on supports per event exclude settings then we
+	 * don't need to do any of this logic. NB. This assumes no PMU has both
+	 * per event exclude and limited PMCs.
+	 */
+	if (ppmu->flags & PPMU_ARCH_207S)
+		return 0;
+
 	n = n_prev + n_new;
 	if (n <= 1)
 		return 0;
@@ -1230,19 +1253,20 @@ static void power_pmu_enable(struct pmu *pmu)
 		goto out;
 	}
 
-	/*
-	 * Add in MMCR0 freeze bits corresponding to the
-	 * attr.exclude_* bits for the first event.
-	 * We have already checked that all events have the
-	 * same values for these bits as the first event.
-	 */
-	event = cpuhw->event[0];
-	if (event->attr.exclude_user)
-		cpuhw->mmcr[0] |= MMCR0_FCP;
-	if (event->attr.exclude_kernel)
-		cpuhw->mmcr[0] |= freeze_events_kernel;
-	if (event->attr.exclude_hv)
-		cpuhw->mmcr[0] |= MMCR0_FCHV;
+	if (!(ppmu->flags & PPMU_ARCH_207S)) {
+		/*
+		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
+		 * bits for the first event. We have already checked that all
+		 * events have the same value for these bits as the first event.
+		 */
+		event = cpuhw->event[0];
+		if (event->attr.exclude_user)
+			cpuhw->mmcr[0] |= MMCR0_FCP;
+		if (event->attr.exclude_kernel)
+			cpuhw->mmcr[0] |= freeze_events_kernel;
+		if (event->attr.exclude_hv)
+			cpuhw->mmcr[0] |= MMCR0_FCHV;
+	}
 
 	/*
 	 * Write the new configuration to MMCR* with the freeze
@@ -1254,6 +1278,8 @@ static void power_pmu_enable(struct pmu *pmu)
 	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
 	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
 				| MMCR0_FC);
+	if (ppmu->flags & PPMU_ARCH_207S)
+		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
 
 	/*
 	 * Read off any pre-existing events that need to move
@@ -1309,10 +1335,7 @@ static void power_pmu_enable(struct pmu *pmu)
  out_enable:
 	pmao_restore_workaround(ebb);
 
-	if (ppmu->flags & PPMU_ARCH_207S)
-		mtspr(SPRN_MMCR2, 0);
-
-	mmcr0 = ebb_switch_in(ebb, cpuhw->mmcr[0]);
+	mmcr0 = ebb_switch_in(ebb, cpuhw);
 
 	mb();
 	if (cpuhw->bhrb_users)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 19bbddf495dd..396351db601b 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
 #include <asm/firmware.h>
+#include <asm/cputable.h>
 
 
 /*
@@ -266,6 +267,11 @@
 #define MMCRA_SDAR_MODE_TLB		(1ull << 42)
 #define MMCRA_IFM_SHIFT			30
 
+/* Bits in MMCR2 for POWER8 */
+#define MMCR2_FCS(pmc)			(1ull << (63 - (((pmc) - 1) * 9)))
+#define MMCR2_FCP(pmc)			(1ull << (62 - (((pmc) - 1) * 9)))
+#define MMCR2_FCH(pmc)			(1ull << (57 - (((pmc) - 1) * 9)))
+
 
 static inline bool event_is_fab_match(u64 event)
 {
@@ -396,7 +402,7 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 			       unsigned int hwc[], unsigned long mmcr[],
 			       struct perf_event *pevents[])
 {
-	unsigned long mmcra, mmcr1, unit, combine, psel, cache, val;
+	unsigned long mmcra, mmcr1, mmcr2, unit, combine, psel, cache, val;
 	unsigned int pmc, pmc_inuse;
 	int i;
 
@@ -411,7 +417,7 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 
 	/* In continous sampling mode, update SDAR on TLB miss */
 	mmcra = MMCRA_SDAR_MODE_TLB;
-	mmcr1 = 0;
+	mmcr1 = mmcr2 = 0;
 
 	/* Second pass: assign PMCs, set all MMCR1 fields */
 	for (i = 0; i < n_ev; ++i) {
@@ -473,6 +479,19 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 			mmcra |= val << MMCRA_IFM_SHIFT;
 		}
 
+		if (pevents[i]->attr.exclude_user)
+			mmcr2 |= MMCR2_FCP(pmc);
+
+		if (pevents[i]->attr.exclude_hv)
+			mmcr2 |= MMCR2_FCH(pmc);
+
+		if (pevents[i]->attr.exclude_kernel) {
+			if (cpu_has_feature(CPU_FTR_HVMODE))
+				mmcr2 |= MMCR2_FCH(pmc);
+			else
+				mmcr2 |= MMCR2_FCS(pmc);
+		}
+
 		hwc[i] = pmc - 1;
 	}
 
@@ -492,6 +511,7 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 
 	mmcr[1] = mmcr1;
 	mmcr[2] = mmcra;
+	mmcr[3] = mmcr2;
 
 	return 0;
 }
-- 
1.9.1
