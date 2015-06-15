Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB48E1A0EC4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:11:34 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2AAB014016A
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 22:11:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 17:41:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 193EAE005C
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:44:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5FCBQQo66781248
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:41:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5FBD4Cs025089
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 16:43:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Subject: [PATCH V9 08/13] powerpc,
 perf: Change the name of HW PMU branch filter tracking variable
Date: Mon, 15 Jun 2015 17:41:03 +0530
Message-Id: <1434370268-19056-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
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
index ea77057..6f6a7ca 100644
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
@@ -1348,7 +1348,7 @@ static void power_pmu_enable(struct pmu *pmu)
 
 	mb();
 	if (cpuhw->bhrb_users)
-		ppmu->config_bhrb(cpuhw->bhrb_filter);
+		ppmu->config_bhrb(cpuhw->bhrb_hw_filter);
 
 	write_mmcr0(cpuhw, mmcr0);
 
@@ -1456,7 +1456,7 @@ nocheck:
  out:
 	if (has_branch_stack(event)) {
 		power_pmu_bhrb_enable(event);
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 	}
 
@@ -1839,10 +1839,10 @@ static int power_pmu_event_init(struct perf_event *event)
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		cpuhw->bhrb_hw_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if (cpuhw->bhrb_filter == -1)
+		if (cpuhw->bhrb_hw_filter == -1)
 			return -EOPNOTSUPP;
 	}
 
-- 
2.1.0
