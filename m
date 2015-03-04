Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B04A91A08CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 19:35:54 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 01:35:52 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4AFED38C804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 03:35:50 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t248Zog027066426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 08:35:50 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t248ZmkW011147
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 03:35:49 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH 1/4] perf: Add 'flags' parameter to pmu txn interfaces
Date: Wed,  4 Mar 2015 00:35:05 -0800
Message-Id: <1425458108-3341-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In addition to using the transaction interface to schedule events
on a PMU, we will use it to also read a group of counters at once.
Accordingly, add a flags parameter to the transaction interfaces.
The flags indicate wheether the transaction is to add events to
the PMU (PERF_PMU_TXN_ADD) or to read the events PERF_PMU_TXN_READ.

Based on input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c  | 15 ++++++++++++---
 arch/x86/kernel/cpu/perf_event.c | 15 ++++++++++++---
 include/linux/perf_event.h       | 14 +++++++++++---
 kernel/events/core.c             | 26 +++++++++++++++-----------
 4 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 7c4f669..3d3739a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1573,10 +1573,13 @@ static void power_pmu_stop(struct perf_event *event, int ef_flags)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  */
-static void power_pmu_start_txn(struct pmu *pmu)
+static void power_pmu_start_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->group_flag |= PERF_EVENT_TXN;
 	cpuhw->n_txn_start = cpuhw->n_events;
@@ -1587,10 +1590,13 @@ static void power_pmu_start_txn(struct pmu *pmu)
  * Clear the flag and pmu::enable() will perform the
  * schedulability test.
  */
-static void power_pmu_cancel_txn(struct pmu *pmu)
+static void power_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
@@ -1600,11 +1606,14 @@ static void power_pmu_cancel_txn(struct pmu *pmu)
  * Perform the group schedulability test as a whole
  * Return 0 if success
  */
-static int power_pmu_commit_txn(struct pmu *pmu)
+static int power_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw;
 	long i, n;
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return -EINVAL;
+
 	if (!ppmu)
 		return -EAGAIN;
 	cpuhw = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index b71a7f8..b2c9e3b 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1607,8 +1607,11 @@ static inline void x86_pmu_read(struct perf_event *event)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  */
-static void x86_pmu_start_txn(struct pmu *pmu)
+static void x86_pmu_start_txn(struct pmu *pmu, int flags)
 {
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	__this_cpu_or(cpu_hw_events.group_flag, PERF_EVENT_TXN);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
@@ -1619,8 +1622,11 @@ static void x86_pmu_start_txn(struct pmu *pmu)
  * Clear the flag and pmu::enable() will perform the
  * schedulability test.
  */
-static void x86_pmu_cancel_txn(struct pmu *pmu)
+static void x86_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	__this_cpu_and(cpu_hw_events.group_flag, ~PERF_EVENT_TXN);
 	/*
 	 * Truncate collected array by the number of events added in this
@@ -1638,12 +1644,15 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
  *
  * Does not cancel the transaction on failure; expects the caller to do this.
  */
-static int x86_pmu_commit_txn(struct pmu *pmu)
+static int x86_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int assign[X86_PMC_IDX_MAX];
 	int n, ret;
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return -EINVAL;
+
 	n = cpuc->n_events;
 
 	if (!x86_pmu_initialized())
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2b62198..c8fe60e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -225,6 +225,8 @@ struct pmu {
 	 * should stop the counter when perf_event_overflow() returns
 	 * !0. ->start() will be used to continue.
 	 */
+#define	PERF_PMU_TXN_ADD	1
+#define	PERF_PMU_TXN_READ	2
 	void (*start)			(struct perf_event *event, int flags);
 	void (*stop)			(struct perf_event *event, int flags);
 
@@ -240,20 +242,26 @@ struct pmu {
 	 *
 	 * Start the transaction, after this ->add() doesn't need to
 	 * do schedulability tests.
+	 *
+	 * Optional.
 	 */
-	void (*start_txn)		(struct pmu *pmu); /* optional */
+	void (*start_txn)		(struct pmu *pmu, int flags);
 	/*
 	 * If ->start_txn() disabled the ->add() schedulability test
 	 * then ->commit_txn() is required to perform one. On success
 	 * the transaction is closed. On error the transaction is kept
 	 * open until ->cancel_txn() is called.
+	 *
+	 * Optional.
 	 */
-	int  (*commit_txn)		(struct pmu *pmu); /* optional */
+	int  (*commit_txn)		(struct pmu *pmu, int flags);
 	/*
 	 * Will cancel the transaction, assumes ->del() is called
 	 * for each successful ->add() during the transaction.
+	 *
+	 * Optional.
 	 */
-	void (*cancel_txn)		(struct pmu *pmu); /* optional */
+	void (*cancel_txn)		(struct pmu *pmu, int flags);
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f04daab..dbc12bf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1924,10 +1924,10 @@ group_sched_in(struct perf_event *group_event,
 	if (group_event->state == PERF_EVENT_STATE_OFF)
 		return 0;
 
-	pmu->start_txn(pmu);
+	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
 	if (event_sched_in(group_event, cpuctx, ctx)) {
-		pmu->cancel_txn(pmu);
+		pmu->cancel_txn(pmu, PERF_PMU_TXN_ADD);
 		perf_cpu_hrtimer_restart(cpuctx);
 		return -EAGAIN;
 	}
@@ -1942,7 +1942,7 @@ group_sched_in(struct perf_event *group_event,
 		}
 	}
 
-	if (!pmu->commit_txn(pmu))
+	if (!pmu->commit_txn(pmu, PERF_PMU_TXN_ADD))
 		return 0;
 
 group_error:
@@ -1973,7 +1973,7 @@ group_error:
 	}
 	event_sched_out(group_event, cpuctx, ctx);
 
-	pmu->cancel_txn(pmu);
+	pmu->cancel_txn(pmu, PERF_PMU_TXN_ADD);
 
 	perf_cpu_hrtimer_restart(cpuctx);
 
@@ -6718,23 +6718,27 @@ static void perf_pmu_nop_void(struct pmu *pmu)
 {
 }
 
-static int perf_pmu_nop_int(struct pmu *pmu)
+static void perf_pmu_nop_txn(struct pmu *pmu, int flags)
+{
+}
+
+static int perf_pmu_nop_txn_int(struct pmu *pmu, int flags)
 {
 	return 0;
 }
 
-static void perf_pmu_start_txn(struct pmu *pmu)
+static void perf_pmu_start_txn(struct pmu *pmu, int flags)
 {
 	perf_pmu_disable(pmu);
 }
 
-static int perf_pmu_commit_txn(struct pmu *pmu)
+static int perf_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	perf_pmu_enable(pmu);
 	return 0;
 }
 
-static void perf_pmu_cancel_txn(struct pmu *pmu)
+static void perf_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
 	perf_pmu_enable(pmu);
 }
@@ -6968,9 +6972,9 @@ got_cpu_context:
 			pmu->commit_txn = perf_pmu_commit_txn;
 			pmu->cancel_txn = perf_pmu_cancel_txn;
 		} else {
-			pmu->start_txn  = perf_pmu_nop_void;
-			pmu->commit_txn = perf_pmu_nop_int;
-			pmu->cancel_txn = perf_pmu_nop_void;
+			pmu->start_txn  = perf_pmu_nop_txn;
+			pmu->commit_txn = perf_pmu_nop_txn_int;
+			pmu->cancel_txn = perf_pmu_nop_txn;
 		}
 	}
 
-- 
1.8.3.1
