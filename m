Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA2B71A17E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:20:41 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 168B81402ED
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:20:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 13:50:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C7A95E0058
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:54:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8KX2I55771136
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U7DMQY029616
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 12:43:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH 2/5] powerpc/perf: Change type of the bhrb_users variable
Date: Tue, 30 Jun 2015 13:50:28 +0530
Message-Id: <1435652431-22024-3-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch just changes data type of bhrb_users variable from
int to unsigned int because it never contains a negative value.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b0c2d53..f9ecd93 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -53,7 +53,7 @@ struct cpu_hw_events {
 
 	/* BHRB bits */
 	u64				bhrb_filter;	/* BHRB HW branch filter */
-	int				bhrb_users;
+	unsigned int			bhrb_users;
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
@@ -369,8 +369,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 	if (!ppmu->bhrb_nr)
 		return;
 
+	WARN_ON_ONCE(!cpuhw->bhrb_users);
 	cpuhw->bhrb_users--;
-	WARN_ON_ONCE(cpuhw->bhrb_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
 
 	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
-- 
2.1.0
