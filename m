Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0AD442C02A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:01:50 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 17:01:48 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 45AC56E8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:01:40 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2601jFs9109918
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:01:45 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2601hOU030420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:01:45 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH v4 03/11] perf: provide a common perf_event_nop_0() for use
 with .event_idx
Date: Wed,  5 Mar 2014 16:01:02 -0800
Message-Id: <1394064082-6242-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
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
index 5c12009..23da668 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -560,6 +560,7 @@ extern void perf_pmu_migrate_context(struct pmu *pmu,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
+extern int perf_event_nop_0(struct perf_event *event);
 
 struct perf_sample_data {
 	u64				type;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fa0b2d4..16bf7c2 100644
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
