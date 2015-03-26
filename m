Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8409E1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 16:58:07 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 23:58:04 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 51B1219D8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 23:49:09 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q5uIZp32309326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 22:56:18 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q5w1XT030157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 23:58:02 -0600
Date: Wed, 25 Mar 2015 22:57:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] perf/powerpc: Implement group_read() txn interface
 for 24x7 counters
Message-ID: <20150326055705.GA5593@us.ibm.com>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317065733.GN2896@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317065733.GN2896@worktop.programming.kicks-ass.net>
Cc: dev@codyps.com, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| 
| Is there a down-side to always doing the txn based group read? If an
| arch does not implement the read txn support it'll fall back to doing
| independent read ops, but we end up doing those anyway.
| 
| That way we get less special case code.

We could, but would need to move the perf_event_read() earlier in
the perf_event_read_group(). Can we do something like this (it
could be broken into two patches, but merging for easier review)
Would something liks this work?

----

perf_event_read_value() is mostly computing event count, enabled
and running times. Move the perf_event_read() into caller and
rename perf_event_read_value() to perf_event_compute_values().

Then, in perf_event_read_group(), read the event counts using the
transaction interface for all PMUs.


----
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 8e6b7d8..5896cb1 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -144,9 +144,11 @@ static u64 read_pmc(struct kvm_pmc *pmc)
 
 	counter = pmc->counter;
 
-	if (pmc->perf_event)
-		counter += perf_event_read_value(pmc->perf_event,
+	if (pmc->perf_event) {
+		perf_event_read(pmc->perf_event);
+		counter += perf_event_compute_values(pmc->perf_event,
 						 &enabled, &running);
+	}
 
 	/* FIXME: Scaling needed? */
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8fe60e..1e30560 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -579,7 +579,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				void *context);
 extern void perf_pmu_migrate_context(struct pmu *pmu,
 				int src_cpu, int dst_cpu);
-extern u64 perf_event_read_value(struct perf_event *event,
+extern u64 perf_event_compute_values(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6abcd3..f7e4705 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3643,7 +3643,27 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
-u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
+static int perf_event_read_values(struct perf_event *leader)
+{
+	int ret;
+	struct perf_event *sub;
+	struct pmu *pmu;
+
+	pmu = leader->pmu;
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	pmu->read(leader);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry)
+		pmu->read(sub);
+
+	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
+
+	return ret;
+}
+
+u64 perf_event_compute_values(struct perf_event *event, u64 *enabled,
+				u64 *running)
 {
 	struct perf_event *child;
 	u64 total = 0;
@@ -3653,7 +3673,6 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3671,7 +3690,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	return total;
 }
-EXPORT_SYMBOL_GPL(perf_event_read_value);
+EXPORT_SYMBOL_GPL(perf_event_compute_values);
 
 static int perf_event_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
@@ -3684,7 +3703,11 @@ static int perf_event_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	ret = perf_event_read_values(leader);
+	if (ret)
+		return ret;
+
+	count = perf_event_compute_values(leader, &enabled, &running);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3705,7 +3728,7 @@ static int perf_event_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		values[n++] = perf_event_compute_values(sub, &enabled, &running);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
@@ -3728,7 +3751,8 @@ static int perf_event_read_one(struct perf_event *event,
 	u64 values[4];
 	int n = 0;
 
-	values[n++] = perf_event_read_value(event, &enabled, &running);
+	perf_event_read(event);
+	values[n++] = perf_event_compute_values(event, &enabled, &running);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		values[n++] = enabled;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
