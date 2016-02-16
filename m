Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD74E1A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 17:38:11 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 12:08:09 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G6c4e645154460
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:08:05 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G6brLB030634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:07:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V11_RESEND 05/10] powerpc/perf: Change the name of HW PMU
 branch filter tracking variable
Date: Tue, 16 Feb 2016 12:07:05 +0530
Message-Id: <1455604630-16214-6-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch simply changes the name of the variable from 'bhrb_filter' to
'bhrb_hw_filter' in order to add one more variable which will track SW
filters in generic powerpc book3s code which will be implemented in the
subsequent patch. This patch does not change any functionality.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 02b724b..710c98c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -52,7 +52,7 @@ struct cpu_hw_events {
 	int n_txn_start;
 
 	/* BHRB bits */
-	u64				bhrb_filter;	/* BHRB HW branch filter */
+	u64				bhrb_hw_filter;	/* BHRB HW filter */
 	unsigned int			bhrb_users;
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
@@ -1356,7 +1356,7 @@ static void power_pmu_enable(struct pmu *pmu)
 
 	mb();
 	if (cpuhw->bhrb_users)
-		ppmu->config_bhrb(cpuhw->bhrb_filter);
+		ppmu->config_bhrb(cpuhw->bhrb_hw_filter);
 
 	write_mmcr0(cpuhw, mmcr0);
 
@@ -1464,7 +1464,7 @@ nocheck:
  out:
 	if (has_branch_stack(event)) {
 		power_pmu_bhrb_enable(event);
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 	}
 
@@ -1871,10 +1871,10 @@ static int power_pmu_event_init(struct perf_event *event)
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if (cpuhw->bhrb_filter == -1) {
+		if (cpuhw->bhrb_hw_filter == -1) {
 			put_cpu_var(cpu_hw_events);
 			return -EOPNOTSUPP;
 		}
-- 
2.1.0
