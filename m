Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3BCA1A0ACE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:14 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:12 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7A8466E804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:26:59 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380Z9h330081130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:09 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380Z9Pq016678
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:09 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 4/5] perf: Define PMU_TXN_READ interface
Date: Tue,  7 Apr 2015 17:34:58 -0700
Message-Id: <1428453299-19121-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

Define a new PERF_PMU_TXN_READ interface to read a group of counters
at once. Note that we use this interface with all PMUs.

PMUs that implement this interface will queue the counters to be read
in ->read() and read them all at once in ->commit_txn().

PMUs that don't implement PERF_PMU_TXN_READ will continue to read one
counter at a time and ignore the ->start_txn() and ->commit_txn().

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e684c6b..3e46a07 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -244,6 +244,7 @@ struct pmu {
 	 * Optional.
 	 */
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
 	void (*start_txn)		(struct pmu *pmu, int flags);
 	/*
 	 * If ->start_txn() disabled the ->add() schedulability test
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1ac99d1..a001582 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3644,6 +3644,33 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
+/*
+ * Use the transaction interface to read the group of events in @leader.
+ * PMUs like the 24x7 counters in Power, can use this to queue the events
+ * in the ->read() operation and perform the actual read in ->commit_txn.
+ *
+ * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
+ * PMU directly in the ->read() operation.
+ */
+static int perf_event_read_txn(struct perf_event *leader)
+{
+	int ret;
+	struct perf_event *sub;
+	struct pmu *pmu;
+
+	pmu = leader->pmu;
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	perf_event_read(leader);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry)
+		perf_event_read(sub);
+
+	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
+
+	return ret;
+}
+
 u64 perf_event_compute_values(struct perf_event *event, u64 *enabled,
 				u64 *running)
 {
@@ -3685,7 +3712,10 @@ static int perf_event_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	perf_event_read(leader);
+	ret = perf_event_read_txn(leader);
+	if (ret)
+		return ret;
+
 	count = perf_event_compute_values(leader, &enabled, &running);
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -3707,7 +3737,6 @@ static int perf_event_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		perf_event_read(sub);
 		values[n++] = perf_event_compute_values(sub, &enabled, &running);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
-- 
1.7.9.5
