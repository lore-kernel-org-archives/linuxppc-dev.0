Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88FF1A0B97
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:15 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:13 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 29249C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:26:20 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380ZAZx28967130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:10 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380ZAUu016772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:10 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 5/5] powerpc/perf/hv-24x7: Use PMU_TXN_READ interface
Date: Tue,  7 Apr 2015 17:34:59 -0700
Message-Id: <1428453299-19121-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

The 24x7 counters in Powerpc allow monitoring a large number of counters
simultaneously. They also allow reading several counters in a single
HCALL so we can get a more consistent snapshot of the system.

Use the PMU's transaction interface to monitor and read several event
counters at once. The idea is that users can group several 24x7 events
into a single group of events. We use the following logic to submit
the group of events to the PMU and read the values:

	pmu->start_txn()		// Initialize before first event

	for each event in group
		pmu->read(event);	// Queue each event to be read

	pmu->commit_txn()		// Read/update all queued counters

The ->commit_txn() also updates event counts in the respective perf_event
objects.  The perf subsystem can then directly get the event counts from
the perf_event and can avoid submitting a new ->read() request to the PMU.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c |  165 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index b107efd..6d4ff82 100644
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
@@ -1213,9 +1221,47 @@ static void update_event_count(struct perf_event *event, u64 now)
 static void h_24x7_event_read(struct perf_event *event)
 {
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
+	if (h24x7hw->in_txn) {
+		int i;
+		int ret;
+
+		request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+
+		ret = add_event_to_24x7_request(event, request_buffer);
+		if (ret) {
+			h24x7hw->txn_err = ret;
+		} else {
+			/*
+			 * Assoicate the event with the HCALL request index,
+			 * so we can quickly find/update the count in
+			 * ->commit_txn().
+			 */
+			i = request_buffer->num_requests - 1;
+			h24x7hw->events[i] = event;
+		}
+
+		put_cpu_var(hv_24x7_reqb);
+		goto out;
+	}
 
 	now = h_24x7_get_value(event);
 	update_event_count(event, now);
+
+out:
+	put_cpu_var(h_24x7_hw);
 }
 
 static void h_24x7_event_start(struct perf_event *event, int flags)
@@ -1237,6 +1283,122 @@ static int h_24x7_event_add(struct perf_event *event, int flags)
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
+	init_24x7_request(request_buffer, result_buffer);
+	h24x7hw->in_txn = 1;
+
+	put_cpu_var(hv_24x7_resb);
+	put_cpu_var(hv_24x7_reqb);
+	put_cpu_var(h_24x7_hw);
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
+	ret = make_24x7_request(request_buffer, result_buffer);
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
+	put_cpu_var(hv_24x7_resb);
+	put_cpu_var(hv_24x7_reqb);
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
+	WARN_ON_ONCE(!h24x7hw->in_txn);
+	reset_txn(h24x7hw);
+
+	put_cpu_var(h_24x7_hw);
+}
+
 static struct pmu h_24x7_pmu = {
 	.task_ctx_nr = perf_invalid_context,
 
@@ -1248,6 +1410,9 @@ static struct pmu h_24x7_pmu = {
 	.start       = h_24x7_event_start,
 	.stop        = h_24x7_event_stop,
 	.read        = h_24x7_event_read,
+	.start_txn   = h_24x7_event_start_txn,
+	.commit_txn  = h_24x7_event_commit_txn,
+	.cancel_txn  = h_24x7_event_cancel_txn,
 };
 
 static int hv_24x7_init(void)
-- 
1.7.9.5
