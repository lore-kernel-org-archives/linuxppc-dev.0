Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D522D2C00E5
 for <linuxppc-dev@ozlabs.org>; Mon,  6 May 2013 19:51:47 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 May 2013 19:32:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 640372CE9761
 for <linuxppc-dev@ozlabs.org>; Mon,  6 May 2013 17:00:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r466kMbH12386422
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 16:46:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4670A9q015923
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 17:00:11 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc,
 perf: Clear out branch entries to avoid any previous stale values
Date: Mon,  6 May 2013 12:29:48 +0530
Message-Id: <1367823588-28871-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'to' field inside branch entries might contain stale values from previous
PMU interrupt instances which had indirect branches. So clear all the values
before reading a fresh set of BHRB entries after a PMU interrupt.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c627843..09db68d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1590,6 +1590,8 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
 			struct cpu_hw_events *cpuhw;
 			cpuhw = &__get_cpu_var(cpu_hw_events);
+			memset(cpuhw->bhrb_entries, 0,
+				sizeof(struct perf_branch_entry) * BHRB_MAX_ENTRIES);
 			power_pmu_bhrb_read(cpuhw);
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
-- 
1.7.11.7
