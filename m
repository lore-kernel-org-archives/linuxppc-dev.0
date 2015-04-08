Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436381A0ACE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:13 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:10 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2DE4B38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:35:08 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380Z8kt29425882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:08 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380Z7xW016581
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:07 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/5] perf: Split perf_event_read() and perf_event_count()
Date: Tue,  7 Apr 2015 17:34:56 -0700
Message-Id: <1428453299-19121-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf_event_read() does two things:

	- call the PMU to read/update the counter value
	- and compute the total count of the event and its children

perf_event_reset() needs the first piece but doesn't need the second.

Similarly, when we implement the ability to read a group of events
using the transaction interface, we would sometimes need one but
not both.

Break up perf_event_read() and have it just read/update the counter
and have the callers compute the total count if necessary.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 97516d3..0a3d7c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3223,7 +3223,7 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
-static u64 perf_event_read(struct perf_event *event)
+static void perf_event_read(struct perf_event *event)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
@@ -3249,8 +3249,6 @@ static u64 perf_event_read(struct perf_event *event)
 		update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
-
-	return perf_event_count(event);
 }
 
 /*
@@ -3654,14 +3652,18 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
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
@@ -3821,7 +3823,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	(void)perf_event_read(event);
+	perf_event_read(event);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
