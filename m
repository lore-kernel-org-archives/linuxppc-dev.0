Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B44632C020F
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:07:58 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 18:07:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 91DB62CE8052
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:07:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s157mQrm590184
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 18:48:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1587sSv010872
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 19:07:55 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V5 07/11] powerpc,
 perf: Change the name of HW PMU branch filter tracking variable
Date: Wed,  5 Feb 2014 13:36:18 +0530
Message-Id: <1391587582-32028-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
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
index 8a44dc1..468f58c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -47,7 +47,7 @@ struct cpu_hw_events {
 	int n_txn_start;
 
 	/* BHRB bits */
-	u64				bhrb_filter;	/* BHRB HW branch filter */
+	u64				bhrb_hw_filter;	/* BHRB HW branch filter */
 	int				bhrb_users;
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
@@ -1161,7 +1161,7 @@ static void power_pmu_enable(struct pmu *pmu)
 
  out:
 	if (cpuhw->bhrb_users)
-		ppmu->config_bhrb(cpuhw->bhrb_filter);
+		ppmu->config_bhrb(cpuhw->bhrb_hw_filter);
 
 	local_irq_restore(flags);
 }
@@ -1256,7 +1256,7 @@ nocheck:
  out:
 	if (has_branch_stack(event)) {
 		power_pmu_bhrb_enable(event);
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 	}
 
@@ -1639,10 +1639,10 @@ static int power_pmu_event_init(struct perf_event *event)
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if(cpuhw->bhrb_filter == -1)
+		if(cpuhw->bhrb_hw_filter == -1)
 			return -EOPNOTSUPP;
 	}
 
-- 
1.7.11.7
