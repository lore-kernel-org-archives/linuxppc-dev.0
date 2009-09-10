Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 64AB7B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 16:29:00 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C1ABDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 16:29:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19112.40097.974792.747829@drongo.ozlabs.ibm.com>
Date: Thu, 10 Sep 2009 16:28:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: perf_counters: Reduce stack usage of
	power_check_constraints
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman reported stack-frame size warnings being produced
for power_check_constraints(), which uses an 8*8 array of u64 and
two 8*8 arrays of unsigned long, which are currently allocated on the
stack, along with some other smaller variables.  These arrays come
to 1.5kB on 64-bit or 1kB on 32-bit, which is a bit too much for the
stack.

This fixes the problem by putting these arrays in the existing
per-cpu cpu_hw_counters struct.  This is OK because two of the call
sites have interrupts disabled already; for the third call site we
use get_cpu_var, which disables preemption, so we know we won't
get a context switch while we're in power_check_constraints().
Note that power_check_constraints() can be called during context
switch but is not called from interrupts.

Reported-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/perf_counter.c |   55 +++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/perf_counter.c b/arch/powerpc/kernel/perf_counter.c
index ccd6b21..7ceefaf 100644
--- a/arch/powerpc/kernel/perf_counter.c
+++ b/arch/powerpc/kernel/perf_counter.c
@@ -32,6 +32,9 @@ struct cpu_hw_counters {
 	unsigned long mmcr[3];
 	struct perf_counter *limited_counter[MAX_LIMITED_HWCOUNTERS];
 	u8  limited_hwidx[MAX_LIMITED_HWCOUNTERS];
+	u64 alternatives[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
+	unsigned long amasks[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
+	unsigned long avalues[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
 };
 DEFINE_PER_CPU(struct cpu_hw_counters, cpu_hw_counters);
 
@@ -239,13 +242,11 @@ static void write_pmc(int idx, unsigned long val)
  * and see if any combination of alternative codes is feasible.
  * The feasible set is returned in event[].
  */
-static int power_check_constraints(u64 event[], unsigned int cflags[],
+static int power_check_constraints(struct cpu_hw_counters *cpuhw,
+				   u64 event[], unsigned int cflags[],
 				   int n_ev)
 {
 	unsigned long mask, value, nv;
-	u64 alternatives[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
-	unsigned long amasks[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
-	unsigned long avalues[MAX_HWCOUNTERS][MAX_EVENT_ALTERNATIVES];
 	unsigned long smasks[MAX_HWCOUNTERS], svalues[MAX_HWCOUNTERS];
 	int n_alt[MAX_HWCOUNTERS], choice[MAX_HWCOUNTERS];
 	int i, j;
@@ -260,21 +261,23 @@ static int power_check_constraints(u64 event[], unsigned int cflags[],
 		if ((cflags[i] & PPMU_LIMITED_PMC_REQD)
 		    && !ppmu->limited_pmc_event(event[i])) {
 			ppmu->get_alternatives(event[i], cflags[i],
-					       alternatives[i]);
-			event[i] = alternatives[i][0];
+					       cpuhw->alternatives[i]);
+			event[i] = cpuhw->alternatives[i][0];
 		}
-		if (ppmu->get_constraint(event[i], &amasks[i][0],
-					 &avalues[i][0]))
+		if (ppmu->get_constraint(event[i], &cpuhw->amasks[i][0],
+					 &cpuhw->avalues[i][0]))
 			return -1;
 	}
 	value = mask = 0;
 	for (i = 0; i < n_ev; ++i) {
-		nv = (value | avalues[i][0]) + (value & avalues[i][0] & addf);
+		nv = (value | cpuhw->avalues[i][0]) +
+			(value & cpuhw->avalues[i][0] & addf);
 		if ((((nv + tadd) ^ value) & mask) != 0 ||
-		    (((nv + tadd) ^ avalues[i][0]) & amasks[i][0]) != 0)
+		    (((nv + tadd) ^ cpuhw->avalues[i][0]) &
+		     cpuhw->amasks[i][0]) != 0)
 			break;
 		value = nv;
-		mask |= amasks[i][0];
+		mask |= cpuhw->amasks[i][0];
 	}
 	if (i == n_ev)
 		return 0;	/* all OK */
@@ -285,10 +288,11 @@ static int power_check_constraints(u64 event[], unsigned int cflags[],
 	for (i = 0; i < n_ev; ++i) {
 		choice[i] = 0;
 		n_alt[i] = ppmu->get_alternatives(event[i], cflags[i],
-						  alternatives[i]);
+						  cpuhw->alternatives[i]);
 		for (j = 1; j < n_alt[i]; ++j)
-			ppmu->get_constraint(alternatives[i][j],
-					     &amasks[i][j], &avalues[i][j]);
+			ppmu->get_constraint(cpuhw->alternatives[i][j],
+					     &cpuhw->amasks[i][j],
+					     &cpuhw->avalues[i][j]);
 	}
 
 	/* enumerate all possibilities and see if any will work */
@@ -307,11 +311,11 @@ static int power_check_constraints(u64 event[], unsigned int cflags[],
 		 * where k > j, will satisfy the constraints.
 		 */
 		while (++j < n_alt[i]) {
-			nv = (value | avalues[i][j]) +
-				(value & avalues[i][j] & addf);
+			nv = (value | cpuhw->avalues[i][j]) +
+				(value & cpuhw->avalues[i][j] & addf);
 			if ((((nv + tadd) ^ value) & mask) == 0 &&
-			    (((nv + tadd) ^ avalues[i][j])
-			     & amasks[i][j]) == 0)
+			    (((nv + tadd) ^ cpuhw->avalues[i][j])
+			     & cpuhw->amasks[i][j]) == 0)
 				break;
 		}
 		if (j >= n_alt[i]) {
@@ -333,7 +337,7 @@ static int power_check_constraints(u64 event[], unsigned int cflags[],
 			svalues[i] = value;
 			smasks[i] = mask;
 			value = nv;
-			mask |= amasks[i][j];
+			mask |= cpuhw->amasks[i][j];
 			++i;
 			j = -1;
 		}
@@ -341,7 +345,7 @@ static int power_check_constraints(u64 event[], unsigned int cflags[],
 
 	/* OK, we have a feasible combination, tell the caller the solution */
 	for (i = 0; i < n_ev; ++i)
-		event[i] = alternatives[i][choice[i]];
+		event[i] = cpuhw->alternatives[i][choice[i]];
 	return 0;
 }
 
@@ -745,7 +749,7 @@ int hw_perf_group_sched_in(struct perf_counter *group_leader,
 		return -EAGAIN;
 	if (check_excludes(cpuhw->counter, cpuhw->flags, n0, n))
 		return -EAGAIN;
-	i = power_check_constraints(cpuhw->events, cpuhw->flags, n + n0);
+	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n + n0);
 	if (i < 0)
 		return -EAGAIN;
 	cpuhw->n_counters = n0 + n;
@@ -800,7 +804,7 @@ static int power_pmu_enable(struct perf_counter *counter)
 	cpuhw->flags[n0] = counter->hw.counter_base;
 	if (check_excludes(cpuhw->counter, cpuhw->flags, n0, 1))
 		goto out;
-	if (power_check_constraints(cpuhw->events, cpuhw->flags, n0 + 1))
+	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
 		goto out;
 
 	counter->hw.config = cpuhw->events[n0];
@@ -1005,6 +1009,7 @@ const struct pmu *hw_perf_counter_init(struct perf_counter *counter)
 	unsigned int cflags[MAX_HWCOUNTERS];
 	int n;
 	int err;
+	struct cpu_hw_counters *cpuhw;
 
 	if (!ppmu)
 		return ERR_PTR(-ENXIO);
@@ -1083,7 +1088,11 @@ const struct pmu *hw_perf_counter_init(struct perf_counter *counter)
 	cflags[n] = flags;
 	if (check_excludes(ctrs, cflags, n, 1))
 		return ERR_PTR(-EINVAL);
-	if (power_check_constraints(events, cflags, n + 1))
+
+	cpuhw = &get_cpu_var(cpu_hw_counters);
+	err = power_check_constraints(cpuhw, events, cflags, n + 1);
+	put_cpu_var(cpu_hw_counters);
+	if (err)
 		return ERR_PTR(-EINVAL);
 
 	counter->hw.config = events[n];
-- 
1.5.5.rc3.7.gba13
