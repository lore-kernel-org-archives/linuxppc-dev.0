Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D4CC1A0AEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:13 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 11CF4C90045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:26:18 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380Z81424707100
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:08 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380Z8IY016626
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:08 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/5] perf: Rename perf_event_read_value
Date: Tue,  7 Apr 2015 17:34:57 -0700
Message-Id: <1428453299-19121-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

perf_event_read_value() is mostly computing the event count and enabled/
running times. Move the perf_event_read() into caller and rename
perf_event_read_value() to perf_event_compute_values().

Changelog[v2]
	Export symbol perf_event_read() since x86/kvm needs it now.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/x86/kvm/pmu.c         |    6 ++++--
 include/linux/perf_event.h |    3 ++-
 kernel/events/core.c       |   18 +++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

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
index 4dc3d70..e684c6b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -578,8 +578,9 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				void *context);
 extern void perf_pmu_migrate_context(struct pmu *pmu,
 				int src_cpu, int dst_cpu);
-extern u64 perf_event_read_value(struct perf_event *event,
+extern u64 perf_event_compute_values(struct perf_event *event,
 				 u64 *enabled, u64 *running);
+extern void perf_event_read(struct perf_event *event);
 
 
 struct perf_sample_data {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0a3d7c1..1ac99d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3223,7 +3223,7 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
-static void perf_event_read(struct perf_event *event)
+void perf_event_read(struct perf_event *event)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
@@ -3250,6 +3250,7 @@ static void perf_event_read(struct perf_event *event)
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 }
+EXPORT_SYMBOL_GPL(perf_event_read);
 
 /*
  * Initialize the perf_event context in a task_struct:
@@ -3643,7 +3644,8 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
-u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
+u64 perf_event_compute_values(struct perf_event *event, u64 *enabled,
+				u64 *running)
 {
 	struct perf_event *child;
 	u64 total = 0;
@@ -3653,7 +3655,6 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3671,7 +3672,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	return total;
 }
-EXPORT_SYMBOL_GPL(perf_event_read_value);
+EXPORT_SYMBOL_GPL(perf_event_compute_values);
 
 static int perf_event_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
@@ -3684,7 +3685,8 @@ static int perf_event_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	perf_event_read(leader);
+	count = perf_event_compute_values(leader, &enabled, &running);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3705,7 +3707,8 @@ static int perf_event_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		perf_event_read(sub);
+		values[n++] = perf_event_compute_values(sub, &enabled, &running);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
@@ -3728,7 +3731,8 @@ static int perf_event_read_one(struct perf_event *event,
 	u64 values[4];
 	int n = 0;
 
-	values[n++] = perf_event_read_value(event, &enabled, &running);
+	perf_event_read(event);
+	values[n++] = perf_event_compute_values(event, &enabled, &running);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		values[n++] = enabled;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-- 
1.7.9.5
