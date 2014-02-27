Return-Path: <cody@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ADF022C0316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:31:39 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:31:33 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B876EC90026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:27 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RLVUTX7340526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 21:31:30 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1RLVSUP030357
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:30 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH v3 03/11] perf: provide a common perf_event_nop_0() for use
 with .event_idx
Date: Thu, 27 Feb 2014 13:04:56 -0800
Message-Id: <1393535105-7528-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, scottwood@freescale.com,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather an having every pmu that needs a function that just returns 0 for
.event_idx define their own copy, reuse the one in kernel/events/core.c.

Rename from perf_swevent_event_idx() because we're no longer using it
for just software events. Naming is based on the perf_pmu_nop_*()
functions.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3da5081..24a7b45 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -560,6 +560,7 @@ extern void perf_pmu_migrate_context(struct pmu *pmu,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
+extern int perf_event_nop_0(struct perf_event *event);
 
 struct perf_sample_data {
 	u64				type;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 56003c6..2938a77 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5816,7 +5816,7 @@ static int perf_swevent_init(struct perf_event *event)
 	return 0;
 }
 
-static int perf_swevent_event_idx(struct perf_event *event)
+int perf_event_nop_0(struct perf_event *event)
 {
 	return 0;
 }
@@ -5831,7 +5831,7 @@ static struct pmu perf_swevent = {
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
 
-	.event_idx	= perf_swevent_event_idx,
+	.event_idx	= perf_event_nop_0,
 };
 
 #ifdef CONFIG_EVENT_TRACING
@@ -5950,7 +5950,7 @@ static struct pmu perf_tracepoint = {
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
 
-	.event_idx	= perf_swevent_event_idx,
+	.event_idx	= perf_event_nop_0,
 };
 
 static inline void perf_tp_register(void)
@@ -6177,7 +6177,7 @@ static struct pmu perf_cpu_clock = {
 	.stop		= cpu_clock_event_stop,
 	.read		= cpu_clock_event_read,
 
-	.event_idx	= perf_swevent_event_idx,
+	.event_idx	= perf_event_nop_0,
 };
 
 /*
@@ -6257,7 +6257,7 @@ static struct pmu perf_task_clock = {
 	.stop		= task_clock_event_stop,
 	.read		= task_clock_event_read,
 
-	.event_idx	= perf_swevent_event_idx,
+	.event_idx	= perf_event_nop_0,
 };
 
 static void perf_pmu_nop_void(struct pmu *pmu)
-- 
1.9.0
