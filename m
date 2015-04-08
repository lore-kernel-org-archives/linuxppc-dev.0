Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5C4D1A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 22:45:51 +1000 (AEST)
Date: Wed, 8 Apr 2015 14:45:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] perf: Define PMU_TXN_READ interface
Message-ID: <20150408124535.GF23123@twins.programming.kicks-ass.net>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428453299-19121-5-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 mingo@redhat.com, Paul Mackerras <paulus@samba.org>, dev@codyps.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2015 at 05:34:58PM -0700, Sukadev Bhattiprolu wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1ac99d1..a001582 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3644,6 +3644,33 @@ static void orphans_remove_work(struct work_struct *work)
>  	put_ctx(ctx);
>  }
>  
> +/*
> + * Use the transaction interface to read the group of events in @leader.
> + * PMUs like the 24x7 counters in Power, can use this to queue the events
> + * in the ->read() operation and perform the actual read in ->commit_txn.
> + *
> + * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
> + * PMU directly in the ->read() operation.
> + */
> +static int perf_event_read_txn(struct perf_event *leader)

perf_event_read_group() might be a better name. Ah, I see that's already
taken. Bugger.

See the below patch.

> +{
> +	int ret;
> +	struct perf_event *sub;
> +	struct pmu *pmu;
> +
> +	pmu = leader->pmu;
> +
> +	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
> +
> +	perf_event_read(leader);
> +	list_for_each_entry(sub, &leader->sibling_list, group_entry)
> +		perf_event_read(sub);
> +
> +	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
> +
> +	return ret;
> +}

And while were here, should we change the NOP txn implementation to not
call perf_pmu_disable for TXN_READ ?

That seems entirely unneeded in this case.

---
Subject: perf: Rename perf_event_read_{one,group}, perf_read_hw

In order to free up the perf_event_read_group() name:

 s/perf_event_read_\(one\|group\)/perf_read_\1/g
 s/perf_read_hw/__perf_read/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 06917d537302..869f6accb4f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3677,7 +3677,7 @@ static void put_event(struct perf_event *event)
 	 *     see the comment there.
 	 *
 	 *  2) there is a lock-inversion with mmap_sem through
-	 *     perf_event_read_group(), which takes faults while
+	 *     perf_read_group(), which takes faults while
 	 *     holding ctx->mutex, however this is called after
 	 *     the last filedesc died, so there is no possibility
 	 *     to trigger the AB-BA case.
@@ -3765,7 +3765,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_event_read_group(struct perf_event *event,
+static int perf_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
@@ -3813,7 +3813,7 @@ static int perf_event_read_group(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_read_one(struct perf_event *event,
+static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
@@ -3851,7 +3851,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, char __user *buf, size_t count)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -3869,9 +3869,9 @@ perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_event_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, buf);
 	else
-		ret = perf_event_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, buf);
 
 	return ret;
 }
@@ -3884,7 +3884,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = perf_read_hw(event, buf, count);
+	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
