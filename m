Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 375761A0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:42:02 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 26 Jul 2015 23:42:00 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 010573E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:41:57 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6R5fuIl52494486
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 22:41:56 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6R5fupt026501
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:41:56 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 03/10] perf: Define perf_event_aggregate()
Date: Sun, 26 Jul 2015 22:40:31 -0700
Message-Id: <1437975638-789-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

Move the part of perf_event_read_value() that aggregates the event
counts and event times into a new function, perf_event_aggregate().

This would allow us to call perf_event_aggregate() independently.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v4]
	[Peter Zijlstra] Add missing lockdep_assert(). Rename
	perf_event_compute() (to perf_event_aggregate()).

Changelog[v3]
	Rather than move perf_event_read() into callers and then
	rename, just move the computations into a separate function
	(redesign to address comment from Peter Zijlstra).

---
 kernel/events/core.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f9ca8cb..97619ed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3704,6 +3704,31 @@ static int perf_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
+			      u64 *running)
+{
+	struct perf_event *child;
+	u64 total;
+
+	total = perf_event_count(event);
+
+	*enabled += event->total_time_enabled +
+			atomic64_read(&event->child_total_time_enabled);
+	*running += event->total_time_running +
+			atomic64_read(&event->child_total_time_running);
+
+	lockdep_assert_held(&event->child_mutex);
+
+	list_for_each_entry(child, &event->child_list, child_list) {
+		perf_event_read(child);
+		total += perf_event_count(child);
+		*enabled += child->total_time_enabled;
+		*running += child->total_time_running;
+	}
+
+	return total;
+}
+
 /*
  * Remove all orphanes events from the context.
  */
@@ -3742,7 +3767,6 @@ static void orphans_remove_work(struct work_struct *work)
 
 u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 {
-	struct perf_event *child;
 	u64 total = 0;
 
 	*enabled = 0;
@@ -3751,19 +3775,8 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 	mutex_lock(&event->child_mutex);
 
 	perf_event_read(event);
-	total += perf_event_count(event);
-
-	*enabled += event->total_time_enabled +
-			atomic64_read(&event->child_total_time_enabled);
-	*running += event->total_time_running +
-			atomic64_read(&event->child_total_time_running);
+	total = perf_event_aggregate(event, enabled, running);
 
-	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
-		total += perf_event_count(child);
-		*enabled += child->total_time_enabled;
-		*running += child->total_time_running;
-	}
 	mutex_unlock(&event->child_mutex);
 
 	return total;
-- 
1.7.9.5
