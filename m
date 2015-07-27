Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A4761A0780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:42:05 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 26 Jul 2015 23:42:03 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3A07419D8041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:32:59 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6R5fxE155836800
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 22:42:00 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6R5fxhA026678
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:41:59 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 07/10] perf: Add group parameter to perf_event_read()
Date: Sun, 26 Jul 2015 22:40:35 -0700
Message-Id: <1437975638-789-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a 'group' parameter to perf_event_read(). It will be used (set
to true) in a follow-on patch to update event times of the group.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 21a55d1..f38fe0b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3212,7 +3212,7 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return __perf_event_count(event);
 }
 
-static int perf_event_read(struct perf_event *event)
+static int perf_event_read(struct perf_event *event, bool group)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
@@ -3235,7 +3235,12 @@ static int perf_event_read(struct perf_event *event)
 			update_context_time(ctx);
 			update_cgrp_time_from_event(event);
 		}
-		update_event_times(event);
+
+		if (group)
+			update_group_times(event);
+		else
+			update_event_times(event);
+
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 
@@ -3722,7 +3727,7 @@ static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
 	lockdep_assert_held(&event->child_mutex);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		(void)perf_event_read(child);
+		(void)perf_event_read(child, false);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3776,7 +3781,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	(void)perf_event_read(event);
+	(void)perf_event_read(event, false);
 	total = perf_event_aggregate(event, enabled, running);
 
 	mutex_unlock(&event->child_mutex);
@@ -3831,7 +3836,7 @@ static int perf_read_group(struct perf_event *event,
 
 		mutex_lock(&leader->child_mutex);
 
-		(void)perf_event_read(sub);
+		(void)perf_event_read(sub, false);
 		values[n++] = perf_event_aggregate(sub, &enabled, &running);
 
 		mutex_unlock(&leader->child_mutex);
@@ -3953,7 +3958,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	(void)perf_event_read(event);
+	(void)perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
