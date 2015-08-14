Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 672831A1D90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:51:18 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:51:16 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7FD3A3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:14 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6mSXM36503648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 23:48:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6pDGU027333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:14 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 7/8] Define PERF_PMU_TXN_READ interface
Date: Thu, 13 Aug 2015 23:49:40 -0700
Message-Id: <1439534981-7937-8-git-send-email-sukadev@linux.vnet.ibm.com>
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

Define a new PERF_PMU_TXN_READ interface to read a group of counters
at once.

        pmu->start_txn()                // Initialize before first event

        for each event in group
                pmu->read(event);       // Queue each event to be read

        rc = pmu->commit_txn()          // Read/update all queued counters

Note that we use this interface with all PMUs.  PMUs that implement this
interface use the ->read() operation to _queue_ the counters to be read
and use ->commit_txn() to actually read all the queued counters at once.

PMUs that don't implement PERF_PMU_TXN_READ ignore ->start_txn() and
->commit_txn() and continue to read counters one at a time.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v4]
        - [Peter Zijlstra] Add lockdep_assert_held() in perf_event_read_group().
          Make sure the entire transaction happens on the same CPU.
---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 44bf05f..da307ad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -169,6 +169,7 @@ struct perf_event;
 #define PERF_EVENT_TXN 0x1
 
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
 
 /**
  * pmu::capabilities flags
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3ce047..fde2f43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3189,6 +3189,7 @@ static void __perf_event_read(void *info)
 	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct pmu *pmu = event->pmu;
 
 	/*
 	 * If this is a task context, we need to check whether it is
@@ -3207,18 +3208,31 @@ static void __perf_event_read(void *info)
 	}
 
 	update_event_times(event);
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		goto unlock;
 
-	if (!data->group)
+	if (!data->group) {
+		pmu->read(event);
+		data->ret = 0;
 		goto unlock;
+	}
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	pmu->read(event);
 
 	list_for_each_entry(sub, &event->sibling_list, group_entry) {
 		update_event_times(sub);
-		if (sub->state == PERF_EVENT_STATE_ACTIVE)
+		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
+			/*
+			 * Use sibling's PMU rather than @event's since
+			 * sibling could be on different (eg: software) PMU.
+			 */
 			sub->pmu->read(sub);
+		}
 	}
-	data->ret = 0;
+
+	data->ret = pmu->commit_txn(pmu);
 
 unlock:
 	raw_spin_unlock(&ctx->lock);
-- 
1.7.9.5
