Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9210C1A1D91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:51:18 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:51:16 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0DC263E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:13 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6pD2B41287926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 23:51:13 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6pCZ2027214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 4/8] perf: Add group reads to perf_event_read()
Date: Thu, 13 Aug 2015 23:49:37 -0700
Message-Id: <1439534981-7937-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <peterz@infradead.org>

Enable perf_event_read() to update entire groups at once, this will be
useful for read transactions.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20150723080435.GE25159@twins.programming.kicks-ass.net
---
 kernel/events/core.c |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 02095f4..31ec842 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,12 +3174,18 @@ void perf_event_exec(void)
 	rcu_read_unlock();
 }
 
+struct perf_read_data {
+	struct perf_event *event;
+	bool group;
+};
+
 /*
  * Cross CPU call to read the hardware event
  */
 static void __perf_event_read(void *info)
 {
-	struct perf_event *event = info;
+	struct perf_read_data *data = info;
+	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 
@@ -3198,9 +3204,21 @@ static void __perf_event_read(void *info)
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
 	}
+
 	update_event_times(event);
 	if (event->state == PERF_EVENT_STATE_ACTIVE)
 		event->pmu->read(event);
+
+	if (!data->group)
+		goto unlock;
+
+	list_for_each_entry(sub, &event->sibling_list, group_entry) {
+		update_event_times(sub);
+		if (sub->state == PERF_EVENT_STATE_ACTIVE)
+			sub->pmu->read(sub);
+	}
+
+unlock:
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3212,15 +3230,19 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return __perf_event_count(event);
 }
 
-static void perf_event_read(struct perf_event *event)
+static void perf_event_read(struct perf_event *event, bool group)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
 	 * value in the event structure:
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
+		struct perf_read_data data = {
+			.event = event,
+			.group = group,
+		};
 		smp_call_function_single(event->oncpu,
-					 __perf_event_read, event, 1);
+					 __perf_event_read, &data, 1);
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3235,7 +3257,10 @@ static void perf_event_read(struct perf_event *event)
 			update_context_time(ctx);
 			update_cgrp_time_from_event(event);
 		}
-		update_event_times(event);
+		if (group)
+			update_group_times(event);
+		else
+			update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 }
@@ -3750,7 +3775,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	perf_event_read(event, false);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3759,7 +3784,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
+		perf_event_read(child, false);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3920,7 +3945,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event);
+	perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
