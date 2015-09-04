Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29CD21A18BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 13:09:45 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 3 Sep 2015 21:09:44 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9AFFB19D801C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 21:00:36 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8439fAB46137376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 20:09:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8439eP8005037
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 21:09:41 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [[PATCH v6 04/10] perf: Rename perf_event_read_{one, group},
 perf_read_hw
Date: Thu,  3 Sep 2015 20:07:47 -0700
Message-Id: <1441336073-22750-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

In order to free up the perf_event_read_group() name:

 s/perf_event_read_\(one\|group\)/perf_read_\1/g
 s/perf_read_hw/__perf_read/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 01ede6b..be39e63 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3742,7 +3742,7 @@ static void put_event(struct perf_event *event)
 	 *     see the comment there.
 	 *
 	 *  2) there is a lock-inversion with mmap_sem through
-	 *     perf_event_read_group(), which takes faults while
+	 *     perf_read_group(), which takes faults while
 	 *     holding ctx->mutex, however this is called after
 	 *     the last filedesc died, so there is no possibility
 	 *     to trigger the AB-BA case.
@@ -3837,7 +3837,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_event_read_group(struct perf_event *event,
+static int perf_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
@@ -3885,7 +3885,7 @@ static int perf_event_read_group(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_read_one(struct perf_event *event,
+static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
@@ -3923,7 +3923,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, char __user *buf, size_t count)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -3941,9 +3941,9 @@ perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_event_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, buf);
 	else
-		ret = perf_event_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, buf);
 
 	return ret;
 }
@@ -3956,7 +3956,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = perf_read_hw(event, buf, count);
+	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
-- 
1.7.9.5
