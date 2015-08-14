Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E7DE1A1DBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:51:16 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:51:14 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4AFDD19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:42:09 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6oFn958392740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 23:50:15 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6pBW7027178
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 3/8] perf: Rename perf_event_read_{one, group}, perf_read_hw
Date: Thu, 13 Aug 2015 23:49:36 -0700
Message-Id: <1439534981-7937-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

In order to free up the perf_event_read_group() name:

 s/perf_event_read_\(one\|group\)/perf_read_\1/g
 s/perf_read_hw/__perf_read/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f9ca8cb..02095f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3675,7 +3675,7 @@ static void put_event(struct perf_event *event)
 	 *     see the comment there.
 	 *
 	 *  2) there is a lock-inversion with mmap_sem through
-	 *     perf_event_read_group(), which takes faults while
+	 *     perf_read_group(), which takes faults while
 	 *     holding ctx->mutex, however this is called after
 	 *     the last filedesc died, so there is no possibility
 	 *     to trigger the AB-BA case.
@@ -3770,7 +3770,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_event_read_group(struct perf_event *event,
+static int perf_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
@@ -3818,7 +3818,7 @@ static int perf_event_read_group(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_read_one(struct perf_event *event,
+static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
@@ -3856,7 +3856,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, char __user *buf, size_t count)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -3874,9 +3874,9 @@ perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_event_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, buf);
 	else
-		ret = perf_event_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, buf);
 
 	return ret;
 }
@@ -3889,7 +3889,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = perf_read_hw(event, buf, count);
+	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
-- 
1.7.9.5
