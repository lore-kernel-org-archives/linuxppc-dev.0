Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51C381A0038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 17:37:52 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 12:07:49 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G6bjdn3146060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:07:46 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G6bifg030106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:07:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V11_RESEND 03/10] powerpc/perf: Restore privilege level filter
 support for BHRB
Date: Tue, 16 Feb 2016 12:07:03 +0530
Message-Id: <1455604630-16214-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'commit 9de5cb0f6df8 ("powerpc/perf: Add per-event excludes on Power8")'
broke the PMU based BHRB privilege level filter. BHRB depends on the
same MMCR0 bits for privilege level filter which was used to freeze all
the PMCs as a group. Once we moved to individual event based privilege
filters through MMCR2 register on POWER8, event associated privilege
filters are no longer applicable to the BHRB captured branches.

This patch solves the problem by restoring to the previous method of
privilege level filters for the event in case BHRB based branch stack
sampling is requested. This patch also changes 'check_excludes' for
the same reason.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a158923..0930a07 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -941,7 +941,7 @@ static int power_check_constraints(struct cpu_hw_events *cpuhw,
  * added events.
  */
 static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
-			  int n_prev, int n_new)
+			  int n_prev, int n_new, unsigned int bhrb_users)
 {
 	int eu = 0, ek = 0, eh = 0;
 	int i, n, first;
@@ -950,9 +950,10 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	/*
 	 * If the PMU we're on supports per event exclude settings then we
 	 * don't need to do any of this logic. NB. This assumes no PMU has both
-	 * per event exclude and limited PMCs.
+	 * per event exclude and limited PMCs. But again if the event has also
+	 * requested for branch stack sampling, then process the logic here.
 	 */
-	if (ppmu->flags & PPMU_ARCH_207S)
+	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
 		return 0;
 
 	n = n_prev + n_new;
@@ -1270,7 +1271,7 @@ static void power_pmu_enable(struct pmu *pmu)
 		goto out;
 	}
 
-	if (!(ppmu->flags & PPMU_ARCH_207S)) {
+	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users) {
 		/*
 		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
 		 * bits for the first event. We have already checked that all
@@ -1295,7 +1296,7 @@ static void power_pmu_enable(struct pmu *pmu)
 	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
 	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
 				| MMCR0_FC);
-	if (ppmu->flags & PPMU_ARCH_207S)
+	if ((ppmu->flags & PPMU_ARCH_207S) && !cpuhw->bhrb_users)
 		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
 
 	/*
@@ -1447,7 +1448,8 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 	if (cpuhw->txn_flags & PERF_PMU_TXN_ADD)
 		goto nocheck;
 
-	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
+	if (check_excludes(cpuhw->event, cpuhw->flags,
+				n0, 1, cpuhw->bhrb_users))
 		goto out;
 	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
 		goto out;
@@ -1650,7 +1652,7 @@ static int power_pmu_commit_txn(struct pmu *pmu)
 	}
 
 	n = cpuhw->n_events;
-	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
+	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n, cpuhw->bhrb_users))
 		return -EAGAIN;
 	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
 	if (i < 0)
@@ -1863,10 +1865,10 @@ static int power_pmu_event_init(struct perf_event *event)
 	events[n] = ev;
 	ctrs[n] = event;
 	cflags[n] = flags;
-	if (check_excludes(ctrs, cflags, n, 1))
+	cpuhw = &get_cpu_var(cpu_hw_events);
+	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users))
 		return -EINVAL;
 
-	cpuhw = &get_cpu_var(cpu_hw_events);
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-- 
2.1.0
