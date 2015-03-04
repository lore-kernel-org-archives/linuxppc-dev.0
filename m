Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A80AD1A08EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 19:35:57 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 03:35:55 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 593C438C804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 03:35:52 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t248ZqA928967134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 08:35:52 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t248Zo2E011306
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 03:35:51 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH 4/4] perf/powerpc: Implement group_read() txn interface for
 24x7 counters
Date: Wed,  4 Mar 2015 00:35:08 -0800
Message-Id: <1425458108-3341-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

The 24x7 counters in Powerpc allow monitoring a large number of counters
simultaneously. They also allow reading several counters in a single
HCALL so we can get a more consistent snapshot of the system.

Use the PMU's transaction interface to monitor and read several event
counters at once. The idea is that users can group several 24x7 events
into a single group of events. We use the following logic to submit
the group of events to the PMU and read the values:

	pmu->start_txn()		// Intialize before first event

	for each event in group
		pmu->read(event);	// queue the event to be read

	pmu->commit_txn()		// Read/update all queued counters

The ->commit_txn() also updates the event counts in the respective
perf_event objects.  The perf subsystem can then directly get the
event counts from the perf_event and can avoid submitting a new
->read() request to the PMU.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 171 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/perf_event.h  |   1 +
 kernel/events/core.c        |  37 ++++++++++
 3 files changed, 209 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8c571fb..a144d67 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -166,6 +166,7 @@ struct perf_event;
  * pmu::capabilities flags
  */
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
+#define PERF_PMU_CAP_GROUP_READ			0x02
 
 /**
  * struct pmu - generic performance monitoring unit
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 77ce4f3..ff62ea5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3677,11 +3677,34 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running,
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
+static int do_pmu_group_read(struct perf_event *leader)
+{
+	int ret;
+	struct pmu *pmu;
+	struct perf_event *sub;
+
+	pmu = leader->pmu;
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	pmu->read(leader);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry)
+		pmu->read(sub);
+
+	/*
+	 * Commit_txn submits the transaction to read all the counters
+	 * in the group _and_ updates the event count.
+	 */
+	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
+
+	return ret;
+}
+
 static int perf_event_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	struct perf_event_context *ctx = leader->ctx;
+	struct pmu *pmu;
 	int n = 0, size = 0, ret;
 	u64 count, enabled, running;
 	u64 values[5];
@@ -3690,7 +3713,21 @@ static int perf_event_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
+	pmu = event->pmu;
 	update = 1;
+
+	if ((read_format & PERF_FORMAT_GROUP) &&
+			(pmu->capabilities & PERF_PMU_CAP_GROUP_READ)) {
+		ret = do_pmu_group_read(event);
+		if (ret)
+			return ret;
+		/*
+		 * ->commit_txn() would have updated the event count,
+		 * so we don't have to consult the PMU again.
+		 */
+		update = 0;
+	}
+
 	count = perf_event_read_value(leader, &enabled, &running, update);
 
 	values[n++] = 1 + leader->nr_siblings;
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 66fa6c8..08c69c1 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -142,6 +142,13 @@ static struct attribute_group event_long_desc_group = {
 
 static struct kmem_cache *hv_page_cache;
 
+struct h_24x7_hw {
+	int flags;
+	int in_txn;
+	int txn_err;
+	struct perf_event *events[255];
+};
+
 /*
  * request_buffer and result_buffer are not required to be 4k aligned,
  * but are not allowed to cross any 4k boundary. Aligning them to 4k is
@@ -150,6 +157,7 @@ static struct kmem_cache *hv_page_cache;
 #define H24x7_DATA_BUFFER_SIZE	4096
 DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
 DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096);
+DEFINE_PER_CPU(struct h_24x7_hw, h_24x7_hw);
 
 static char *event_name(struct hv_24x7_event_data *ev, int *len)
 {
@@ -1210,10 +1218,46 @@ static void update_event_count(struct perf_event *event, u64 now)
 
 static void h_24x7_event_read(struct perf_event *event)
 {
+	int ret;
 	u64 now;
 
+	struct h_24x7_hw *h24x7hw;
+	struct hv_24x7_request_buffer *request_buffer;
+
+	/*
+	 * If in a READ transaction, add this counter to the list of
+	 * counters to read during the next HCALL (i.e commit_txn()).
+	 * If not in a READ transaction, go ahead and make the HCALL
+	 * to read this counter by itself.
+	 */
+	h24x7hw = &get_cpu_var(h_24x7_hw);
+	if (h24x7hw->txn_err)
+		goto out;
+
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	if (h24x7hw->in_txn) {
+		int i;
+
+		ret = add_event_to_24x7_request(event, request_buffer);
+		if (ret) {
+			h24x7hw->txn_err = ret;
+			goto out;
+		}
+		/*
+		 * Assoicate the event with the HCALL request index, so we
+		 * can quickly find/update the count in ->commit_txn().
+		 */
+		i = request_buffer->num_requests - 1;
+		h24x7hw->events[i] = event;
+		ret = 0;
+		goto out;
+	}
+
 	now = h_24x7_get_value(event);
 	update_event_count(event, now);
+
+out:
+	put_cpu_var(h_24x7_hw);
 }
 
 static void h_24x7_event_start(struct perf_event *event, int flags)
@@ -1235,6 +1279,129 @@ static int h_24x7_event_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+static void h_24x7_event_start_txn(struct pmu *pmu, int flags)
+{
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_data_result_buffer *result_buffer;
+	struct h_24x7_hw *h24x7hw;
+
+	/*
+	 * 24x7 counters only support READ transactions. They are
+	 * always counting and dont need/support ADD transactions. 
+	 */
+	if (flags & ~PERF_PMU_TXN_READ)
+		return;
+
+	h24x7hw = &get_cpu_var(h_24x7_hw);
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
+
+	/* We should not be called if we are already in a txn */
+	WARN_ON_ONCE(h24x7hw->in_txn);
+
+	start_24x7_get_data(request_buffer, result_buffer);
+	h24x7hw->in_txn = 1;
+
+	put_cpu_var(h_24x7_hw);
+
+	return;
+}
+
+static void reset_txn(struct h_24x7_hw *h24x7hw)
+{
+	/* Clean up transaction */
+	h24x7hw->in_txn = 0;
+	h24x7hw->txn_err = 0;
+	h24x7hw->flags = 0;
+
+	/*
+	 * request_buffer and result_buffer will be initialized
+	 * during the next read/txn.
+	 */
+	return;
+}
+
+static int h_24x7_event_commit_txn(struct pmu *pmu, int flags)
+{
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_data_result_buffer *result_buffer;
+	struct h_24x7_hw *h24x7hw;
+	struct hv_24x7_result *resb;
+	struct perf_event *event;
+	u64 count;
+	int i, ret;
+
+	/*
+	 * 24x7 counters only support READ transactions. They are
+	 * always counting and dont need/support ADD transactions. 
+	 */
+	if (flags & ~PERF_PMU_TXN_READ)
+		return 0;
+
+	h24x7hw = &get_cpu_var(h_24x7_hw);
+	if (h24x7hw->txn_err) {
+		ret = h24x7hw->txn_err;
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (!h24x7hw->in_txn) {
+		WARN_ON_ONCE(1);
+		goto out;
+	}
+
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
+
+	ret = commit_24x7_get_data(request_buffer, result_buffer);
+	if (ret) {
+		log_24x7_hcall(request_buffer, result_buffer, ret);
+		goto put_reqb;
+	}
+
+	/* Update event counts from hcall */
+	for (i = 0; i < request_buffer->num_requests; i++) {
+		resb = &result_buffer->results[i];
+		count = be64_to_cpu(resb->elements[0].element_data[0]);
+		event = h24x7hw->events[i];
+		h24x7hw->events[i] = NULL;
+		update_event_count(event, count);
+	}
+
+put_reqb:
+        put_cpu_var(hv_24x7_reqb);
+        put_cpu_var(hv_24x7_resb);
+out:
+	reset_txn(h24x7hw);
+	put_cpu_var(h_24x7_hw);
+	return ret;
+}
+
+static void h_24x7_event_cancel_txn(struct pmu *pmu, int flags)
+{
+	struct h_24x7_hw *h24x7hw;
+
+	/*
+	 * 24x7 counters only support READ transactions. They are
+	 * always counting and dont need/support ADD transactions. 
+	 */
+	if (flags & ~PERF_PMU_TXN_READ)
+		return;
+
+	h24x7hw = &get_cpu_var(h_24x7_hw);
+
+	if (!h24x7hw->in_txn) {
+		WARN_ON_ONCE(1);
+		goto out;
+	}
+
+	reset_txn(h24x7hw);
+
+out:
+	put_cpu_var(h_24x7_hw);
+	return;
+}
+
 static struct pmu h_24x7_pmu = {
 	.task_ctx_nr = perf_invalid_context,
 
@@ -1246,6 +1413,9 @@ static struct pmu h_24x7_pmu = {
 	.start       = h_24x7_event_start,
 	.stop        = h_24x7_event_stop,
 	.read        = h_24x7_event_read,
+	.start_txn   = h_24x7_event_start_txn,
+	.commit_txn  = h_24x7_event_commit_txn,
+	.cancel_txn  = h_24x7_event_cancel_txn,
 };
 
 static int hv_24x7_init(void)
@@ -1272,6 +1442,7 @@ static int hv_24x7_init(void)
 
 	/* sampling not supported */
 	h_24x7_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	h_24x7_pmu.capabilities |= PERF_PMU_CAP_GROUP_READ;
 
 	create_events_from_catalog(&event_group.attrs,
 				   &event_desc_group.attrs,
-- 
1.8.3.1
