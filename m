Return-Path: <paulus@ozlabs.org>
Date: Mon, 2 Aug 2010 16:18:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] perf, powerpc: Convert the FSL driver to use local64_t
Message-ID: <20100802061851.GA898@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <a.p.zijlstra@chello.nl>

For some reason the FSL driver got left out when we converted perf
to use local64_t instead of atomic64_t.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
This is against the perf/core branch in the tip tree at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
Posting here for comment.

 arch/powerpc/kernel/perf_event_fsl_emb.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/perf_event_fsl_emb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/perf_event_fsl_emb.c
+++ linux-2.6/arch/powerpc/kernel/perf_event_fsl_emb.c
@@ -162,15 +162,15 @@ static void fsl_emb_pmu_read(struct perf
 	 * Therefore we treat them like NMIs.
 	 */
 	do {
-		prev = atomic64_read(&event->hw.prev_count);
+		prev = local64_read(&event->hw.prev_count);
 		barrier();
 		val = read_pmc(event->hw.idx);
-	} while (atomic64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
 
 	/* The counters are only 32 bits wide */
 	delta = (val - prev) & 0xfffffffful;
-	atomic64_add(delta, &event->count);
-	atomic64_sub(delta, &event->hw.period_left);
+	local64_add(delta, &event->count);
+	local64_sub(delta, &event->hw.period_left);
 }
 
 /*
@@ -296,11 +296,11 @@ static int fsl_emb_pmu_enable(struct per
 
 	val = 0;
 	if (event->hw.sample_period) {
-		s64 left = atomic64_read(&event->hw.period_left);
+		s64 left = local64_read(&event->hw.period_left);
 		if (left < 0x80000000L)
 			val = 0x80000000L - left;
 	}
-	atomic64_set(&event->hw.prev_count, val);
+	local64_set(&event->hw.prev_count, val);
 	write_pmc(i, val);
 	perf_event_update_userpage(event);
 
@@ -371,8 +371,8 @@ static void fsl_emb_pmu_unthrottle(struc
 	if (left < 0x80000000L)
 		val = 0x80000000L - left;
 	write_pmc(event->hw.idx, val);
-	atomic64_set(&event->hw.prev_count, val);
-	atomic64_set(&event->hw.period_left, left);
+	local64_set(&event->hw.prev_count, val);
+	local64_set(&event->hw.period_left, left);
 	perf_event_update_userpage(event);
 	perf_enable();
 	local_irq_restore(flags);
@@ -500,7 +500,7 @@ const struct pmu *hw_perf_event_init(str
 		return ERR_PTR(-ENOTSUPP);
 
 	event->hw.last_period = event->hw.sample_period;
-	atomic64_set(&event->hw.period_left, event->hw.last_period);
+	local64_set(&event->hw.period_left, event->hw.last_period);
 
 	/*
 	 * See if we need to reserve the PMU.
@@ -541,16 +541,16 @@ static void record_and_restart(struct pe
 	int record = 0;
 
 	/* we don't have to worry about interrupts here */
-	prev = atomic64_read(&event->hw.prev_count);
+	prev = local64_read(&event->hw.prev_count);
 	delta = (val - prev) & 0xfffffffful;
-	atomic64_add(delta, &event->count);
+	local64_add(delta, &event->count);
 
 	/*
 	 * See if the total period for this event has expired,
 	 * and update for the next period.
 	 */
 	val = 0;
-	left = atomic64_read(&event->hw.period_left) - delta;
+	left = local64_read(&event->hw.period_left) - delta;
 	if (period) {
 		if (left <= 0) {
 			left += period;
@@ -584,8 +584,8 @@ static void record_and_restart(struct pe
 	}
 
 	write_pmc(event->hw.idx, val);
-	atomic64_set(&event->hw.prev_count, val);
-	atomic64_set(&event->hw.period_left, left);
+	local64_set(&event->hw.prev_count, val);
+	local64_set(&event->hw.period_left, left);
 	perf_event_update_userpage(event);
 }
 
