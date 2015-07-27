Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3442E1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:42:01 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 26 Jul 2015 23:41:59 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C0F6B1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:33:07 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6R5fOMj27787496
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 22:41:24 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6R5fvd7026546
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:41:57 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 04/10] perf: Rename perf_event_read_{one,group}, perf_read_hw
Date: Sun, 26 Jul 2015 22:40:32 -0700
Message-Id: <1437975638-789-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

In order to free up the perf_event_read_group() name:

 s/perf_event_read_\(one\|group\)/perf_read_\1/g
 s/perf_read_hw/__perf_read/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 97619ed..a6bd09d 100644
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
@@ -3783,7 +3783,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_event_read_group(struct perf_event *event,
+static int perf_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
@@ -3831,7 +3831,7 @@ static int perf_event_read_group(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_read_one(struct perf_event *event,
+static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
@@ -3869,7 +3869,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, char __user *buf, size_t count)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -3887,9 +3887,9 @@ perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_event_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, buf);
 	else
-		ret = perf_event_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, buf);
 
 	return ret;
 }
@@ -3902,7 +3902,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = perf_read_hw(event, buf, count);
+	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
-- 
1.7.9.5
