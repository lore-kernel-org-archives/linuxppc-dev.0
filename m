Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49C421A08CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 19:35:56 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 01:35:54 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D90A638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 03:35:51 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t248ZpmH26869796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 08:35:51 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t248Znwx011269
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 03:35:50 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH 3/4] perf: Add 'update' parameter to perf_event_read_value()
Date: Wed,  4 Mar 2015 00:35:07 -0800
Message-Id: <1425458108-3341-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf_event_read_value() reads the counter from the PMC and computes the
total count (including child events). Add an 'update' parameter and have
it read the PMC only if 'update' parameter is TRUE (which it always is
for now). When we add support for reading multiple events using the
transaction interface, we could optimize consulting the PMU, when we know
that the counts are already upto date.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/x86/kvm/pmu.c         |  2 +-
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 20 ++++++++++++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 8e6b7d8..ed91009 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -146,7 +146,7 @@ static u64 read_pmc(struct kvm_pmc *pmc)
 
 	if (pmc->perf_event)
 		counter += perf_event_read_value(pmc->perf_event,
-						 &enabled, &running);
+						 &enabled, &running, 1);
 
 	/* FIXME: Scaling needed? */
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8fe60e..8c571fb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -580,7 +580,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr,
 extern void perf_pmu_migrate_context(struct pmu *pmu,
 				int src_cpu, int dst_cpu);
 extern u64 perf_event_read_value(struct perf_event *event,
-				 u64 *enabled, u64 *running);
+				 u64 *enabled, u64 *running, int update);
 
 
 struct perf_sample_data {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 11c4154..77ce4f3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3643,7 +3643,8 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
-u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
+u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running,
+				int update)
 {
 	struct perf_event *child;
 	u64 total = 0;
@@ -3653,7 +3654,9 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	if (update)
+		perf_event_read(event);
+
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3662,7 +3665,8 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
+		if (update)
+			perf_event_read(child);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3681,10 +3685,13 @@ static int perf_event_read_group(struct perf_event *event,
 	int n = 0, size = 0, ret;
 	u64 count, enabled, running;
 	u64 values[5];
+	int update;
+	
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	update = 1;
+	count = perf_event_read_value(leader, &enabled, &running, update);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3705,7 +3712,8 @@ static int perf_event_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		values[n++] = perf_event_read_value(sub, &enabled, &running,
+								update);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
@@ -3728,7 +3736,7 @@ static int perf_event_read_one(struct perf_event *event,
 	u64 values[4];
 	int n = 0;
 
-	values[n++] = perf_event_read_value(event, &enabled, &running);
+	values[n++] = perf_event_read_value(event, &enabled, &running, 1);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		values[n++] = enabled;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-- 
1.8.3.1
