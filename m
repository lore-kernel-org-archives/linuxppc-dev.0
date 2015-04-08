Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDD851A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:12 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:09 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9E7026E804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:26:56 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380Z6Ni25428028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:07 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380Z62C016523
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:06 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/5] perf: Add a flags parameter to pmu txn interfaces
Date: Tue,  7 Apr 2015 17:34:55 -0700
Message-Id: <1428453299-19121-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PMU interface allows reading only one counter at a time.
But some PMUs like the 24x7 counters in Power, support reading several
counters at once. To leveage this functionality, extend the transaction
interface to support a "transaction type".

The first type, PERF_PMU_TXN_ADD, refers to the existing transactions,
i.e. used to _schedule_ all the events on the PMU as a group.

A second transaction type, PERF_PMU_TXN_READ, will be used in a follow
on patch, by the 24x7 counters to read several counters at once.

For now, extend the transaction interfaces to the PMU to accept a
'flags' parameter and use this parameter to ignore any transactions
that are not of type PERF_PMU_TXN_ADD.

Note:	For now we add the 'flags' parameter to all three txn functions
	(start, commit, cancel). We could add the parameter to only the
	->start interface and have the PMUs cache the transaction type.
	But that would need slightly more intrusive changes in all PMUs
	to support a second transaction type.

Thanks to Peter Zijlstra for his input.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c  |   16 +++++++++++++---
 arch/s390/kernel/perf_cpum_cf.c  |   15 ++++++++++++---
 arch/sparc/kernel/perf_event.c   |   15 ++++++++++++---
 arch/x86/kernel/cpu/perf_event.c |   15 ++++++++++++---
 include/linux/perf_event.h       |   13 ++++++++++---
 kernel/events/core.c             |   26 +++++++++++++++-----------
 6 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 7c4f669..9cb8008 100644
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
@@ -1600,13 +1606,17 @@ static void power_pmu_cancel_txn(struct pmu *pmu)
  * Perform the group schedulability test as a whole
  * Return 0 if success
  */
-static int power_pmu_commit_txn(struct pmu *pmu)
+static int power_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw;
 	long i, n;
 
 	if (!ppmu)
 		return -EAGAIN;
+
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return -EINVAL;
+
 	cpuhw = this_cpu_ptr(&cpu_hw_events);
 	n = cpuhw->n_events;
 	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 56fdad4..7fa742e 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -573,10 +573,13 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
  * Start group events scheduling transaction.
  * Set flags to perform a single test at commit time.
  */
-static void cpumf_pmu_start_txn(struct pmu *pmu)
+static void cpumf_pmu_start_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->flags |= PERF_EVENT_TXN;
 	cpuhw->tx_state = cpuhw->state;
@@ -587,12 +590,15 @@ static void cpumf_pmu_start_txn(struct pmu *pmu)
  * Assumes cpumf_pmu_del() is called for each successful added
  * cpumf_pmu_add() during the transaction.
  */
-static void cpumf_pmu_cancel_txn(struct pmu *pmu)
+static void cpumf_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
 	WARN_ON(cpuhw->tx_state != cpuhw->state);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	cpuhw->flags &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
@@ -602,11 +608,14 @@ static void cpumf_pmu_cancel_txn(struct pmu *pmu)
  * transaction is closed.   On error, the transaction is kept open
  * until cpumf_pmu_cancel_txn() is called.
  */
-static int cpumf_pmu_commit_txn(struct pmu *pmu)
+static int cpumf_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 	u64 state;
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	/* check if the updated state can be scheduled */
 	state = cpuhw->state & ~((1 << CPUMF_LCCTL_ENABLE_SHIFT) - 1);
 	state >>= CPUMF_LCCTL_ENABLE_SHIFT;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 86eebfa..b4b558e 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1523,10 +1523,13 @@ static int sparc_pmu_event_init(struct perf_event *event)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  */
-static void sparc_pmu_start_txn(struct pmu *pmu)
+static void sparc_pmu_start_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->group_flag |= PERF_EVENT_TXN;
 }
@@ -1536,10 +1539,13 @@ static void sparc_pmu_start_txn(struct pmu *pmu)
  * Clear the flag and pmu::enable() will perform the
  * schedulability test.
  */
-static void sparc_pmu_cancel_txn(struct pmu *pmu)
+static void sparc_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
@@ -1549,7 +1555,7 @@ static void sparc_pmu_cancel_txn(struct pmu *pmu)
  * Perform the group schedulability test as a whole
  * Return 0 if success
  */
-static int sparc_pmu_commit_txn(struct pmu *pmu)
+static int sparc_pmu_commit_txn(struct pmu *pmu, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int n;
@@ -1557,6 +1563,9 @@ static int sparc_pmu_commit_txn(struct pmu *pmu)
 	if (!sparc_pmu)
 		return -EINVAL;
 
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 	n = cpuc->n_events;
 	if (check_excludes(cpuc->event, 0, n))
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index b71a7f8..a59aab5 100644
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
+		return 0;
+
 	n = cpuc->n_events;
 
 	if (!x86_pmu_initialized())
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2b62198..4dc3d70 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -240,20 +240,27 @@ struct pmu {
 	 *
 	 * Start the transaction, after this ->add() doesn't need to
 	 * do schedulability tests.
+	 *
+	 * Optional.
 	 */
-	void (*start_txn)		(struct pmu *pmu); /* optional */
+#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
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
index 2fabc06..97516d3 100644
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
 
@@ -6728,23 +6728,27 @@ static void perf_pmu_nop_void(struct pmu *pmu)
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
@@ -6978,9 +6982,9 @@ got_cpu_context:
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
1.7.9.5
