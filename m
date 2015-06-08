Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 085F31A09E4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2015 21:39:08 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 385081401DE
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 21:39:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Jun 2015 17:09:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2D87B3940061
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 17:09:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t58BcWvC64618604
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t58BcWpG021998
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, mikey@neuling.org
Subject: [PATCH V8 02/10] powerpc,
 perf: Restore privillege level filter support for BHRB
Date: Mon,  8 Jun 2015 17:08:23 +0530
Message-Id: <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

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
 arch/powerpc/perf/core-book3s.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c246e65..ae61629 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -930,7 +930,7 @@ static int power_check_constraints(struct cpu_hw_events *cpuhw,
  * added events.
  */
 static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
-			  int n_prev, int n_new)
+			  int n_prev, int n_new, int bhrb_users)
 {
 	int eu = 0, ek = 0, eh = 0;
 	int i, n, first;
@@ -941,7 +941,7 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	 * don't need to do any of this logic. NB. This assumes no PMU has both
 	 * per event exclude and limited PMCs.
 	 */
-	if (ppmu->flags & PPMU_ARCH_207S)
+	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
 		return 0;
 
 	n = n_prev + n_new;
@@ -1259,7 +1259,7 @@ static void power_pmu_enable(struct pmu *pmu)
 		goto out;
 	}
 
-	if (!(ppmu->flags & PPMU_ARCH_207S)) {
+	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users) {
 		/*
 		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
 		 * bits for the first event. We have already checked that all
@@ -1284,7 +1284,7 @@ static void power_pmu_enable(struct pmu *pmu)
 	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
 	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
 				| MMCR0_FC);
-	if (ppmu->flags & PPMU_ARCH_207S)
+	if ((ppmu->flags & PPMU_ARCH_207S) && !cpuhw->bhrb_users)
 		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
 
 	/*
@@ -1436,7 +1436,8 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 	if (cpuhw->group_flag & PERF_EVENT_TXN)
 		goto nocheck;
 
-	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
+	if (check_excludes(cpuhw->event, cpuhw->flags,
+				n0, 1, cpuhw->bhrb_users))
 		goto out;
 	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
 		goto out;
@@ -1615,7 +1616,7 @@ static int power_pmu_commit_txn(struct pmu *pmu)
 		return -EAGAIN;
 	cpuhw = this_cpu_ptr(&cpu_hw_events);
 	n = cpuhw->n_events;
-	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
+	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n, cpuhw->bhrb_users))
 		return -EAGAIN;
 	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
 	if (i < 0)
@@ -1828,10 +1829,12 @@ static int power_pmu_event_init(struct perf_event *event)
 	events[n] = ev;
 	ctrs[n] = event;
 	cflags[n] = flags;
-	if (check_excludes(ctrs, cflags, n, 1))
+	cpuhw = &get_cpu_var(cpu_hw_events);
+	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users)) {
+		put_cpu_var(cpu_hw_events);
 		return -EINVAL;
+	}
 
-	cpuhw = &get_cpu_var(cpu_hw_events);
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-- 
2.1.0
