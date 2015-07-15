Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AEC31A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:03:09 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 21:03:07 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 32A5D19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:54:04 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t6F32Hq353477476
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 20:02:17 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F3347T026802
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:03:04 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 4/8] perf: Split perf_event_read() and perf_event_count()
Date: Tue, 14 Jul 2015 20:01:51 -0700
Message-Id: <1436929315-28520-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index b79aad2..44fb89d 100644
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
