Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411CA1A1966
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:20:43 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 19DB41402CC
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:20:41 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 13:50:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8F83F125804B
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:53:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8KXrO65077324
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U7DMM6029622
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 12:43:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH 3/5] powerpc/perf: Replace last usage of get_cpu_var with
 this_cpu_ptr
Date: Tue, 30 Jun 2015 13:50:29 +0530
Message-Id: <1435652431-22024-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 69111bac42f5ce ("powerpc: Replace __get_cpu_var uses")
replaced all usage of get_cpu_var with this_cpu_ptr inside core
perf event handling on powerpc. But it skipped one of them which
is being replaced with this patch.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f9ecd93..57f2c78 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1840,20 +1840,17 @@ static int power_pmu_event_init(struct perf_event *event)
 	if (check_excludes(ctrs, cflags, n, 1))
 		return -EINVAL;
 
-	cpuhw = &get_cpu_var(cpu_hw_events);
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
 		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if (cpuhw->bhrb_filter == -1) {
-			put_cpu_var(cpu_hw_events);
+		if (cpuhw->bhrb_filter == -1)
 			return -EOPNOTSUPP;
-		}
 	}
 
-	put_cpu_var(cpu_hw_events);
 	if (err)
 		return -EINVAL;
 
-- 
2.1.0
