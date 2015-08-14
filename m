Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B1041A1D91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:51:17 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:51:14 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7AE211FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:42:21 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6pBhA55967884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 23:51:11 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6pBLq027143
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:11 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 2/8] perf: Split perf_event_read() and perf_event_count()
Date: Thu, 13 Aug 2015 23:49:35 -0700
Message-Id: <1439534981-7937-3-git-send-email-sukadev@linux.vnet.ibm.com>
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

perf_event_read() does two things:

	- call the PMU to read/update the counter value, and
	- compute the total count of the event and its children

Not all callers need both. perf_event_reset() for instance needs the
first piece but doesn't need the second.  Similarly, when we implement
the ability to read a group of events using the transaction interface,
we would need the two pieces done independently.

Break up perf_event_read() and have it just read/update the counter
and have the callers compute the total count if necessary.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4435bf5..f9ca8cb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3212,7 +3212,7 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return __perf_event_count(event);
 }
 
-static u64 perf_event_read(struct perf_event *event)
+static void perf_event_read(struct perf_event *event)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
@@ -3238,8 +3238,6 @@ static u64 perf_event_read(struct perf_event *event)
 		update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
-
-	return perf_event_count(event);
 }
 
 /*
@@ -3751,14 +3749,18 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 	*running = 0;
 
 	mutex_lock(&event->child_mutex);
-	total += perf_event_read(event);
+
+	perf_event_read(event);
+	total += perf_event_count(event);
+
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
 	*running += event->total_time_running +
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		total += perf_event_read(child);
+		perf_event_read(child);
+		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -3918,7 +3920,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	(void)perf_event_read(event);
+	perf_event_read(event);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
