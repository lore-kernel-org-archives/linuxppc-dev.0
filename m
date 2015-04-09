Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9896C1A0BD5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:27:58 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 13:27:55 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id DE95E6E8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 13:19:40 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3GHRa1l13828114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 17:27:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3GHRZss012685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 13:27:36 -0400
Date: Thu, 9 Apr 2015 12:10:29 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/5] perf: Define PMU_TXN_READ interface
Message-ID: <20150409191029.GA29855@us.ibm.com>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150408124535.GF23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150408124535.GF23123@twins.programming.kicks-ass.net>
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

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Apr 07, 2015 at 05:34:58PM -0700, Sukadev Bhattiprolu wrote:
| > diff --git a/kernel/events/core.c b/kernel/events/core.c
| > index 1ac99d1..a001582 100644
| > --- a/kernel/events/core.c
| > +++ b/kernel/events/core.c
| > @@ -3644,6 +3644,33 @@ static void orphans_remove_work(struct work_struct *work)
| >  	put_ctx(ctx);
| >  }
| >  
| > +/*
| > + * Use the transaction interface to read the group of events in @leader.
| > + * PMUs like the 24x7 counters in Power, can use this to queue the events
| > + * in the ->read() operation and perform the actual read in ->commit_txn.
| > + *
| > + * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
| > + * PMU directly in the ->read() operation.
| > + */
| > +static int perf_event_read_txn(struct perf_event *leader)
| 
| perf_event_read_group() might be a better name. Ah, I see that's already
| taken. Bugger.
| 
| See the below patch.

Sure, will include your patch in the next version and use
perf_event_read_group().

| 
| > +{
| > +	int ret;
| > +	struct perf_event *sub;
| > +	struct pmu *pmu;
| > +
| > +	pmu = leader->pmu;
| > +
| > +	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
| > +
| > +	perf_event_read(leader);
| > +	list_for_each_entry(sub, &leader->sibling_list, group_entry)
| > +		perf_event_read(sub);
| > +
| > +	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
| > +
| > +	return ret;
| > +}
| 
| And while were here, should we change the NOP txn implementation to not
| call perf_pmu_disable for TXN_READ ?
| 
| That seems entirely unneeded in this case.

Yes. Should we use a per-cpu, per-pmu variable to save/check the
transaction type like this? (I am using the cpuhw->group_flag in
x86, Power and other PMUs)


>From 2f3658b0b131739dc08e0d6d579e58864d1777bc Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 9 Apr 2015 13:47:50 -0400
Subject: [PATCH 1/1] perf: Have NOP txn interface ignore non ADD txns

The NOP txn interface should ignore non TXN_ADD transactions and
avoid disabling/enabling the PMU.

Use a per-cpu, per-PMU flag to store/check the type of transaction
in progress.

Thanks to Peter Zijlstra for the input.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9e869b2..9466864 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -160,7 +160,10 @@ struct perf_event;
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
  */
-#define PERF_EVENT_TXN 0x1
+#define PERF_EVENT_TXN_ADD      0x1    /* txn to add/schedule event on PMU */
+#define PERF_EVENT_TXN_READ     0x2    /* txn to add/schedule event on PMU */
+
+#define PERF_EVENT_TXN_MASK     (PERF_EVENT_TXN_ADD|PERF_EVENT_TXN_READ)
 
 /**
  * pmu::capabilities flags
@@ -240,8 +243,10 @@ struct pmu {
         *
         * Start the transaction, after this ->add() doesn't need to
         * do schedulability tests.
+        *
+        * Optional.
         */
-       void (*start_txn)               (struct pmu *pmu); /* optional */
+       void (*start_txn)               (struct pmu *pmu, int flags);
        /*
         * If ->start_txn() disabled the ->add() schedulability test
         * then ->commit_txn() is required to perform one. On success
@@ -534,6 +534,7 @@ struct perf_cpu_context {
 	ktime_t				hrtimer_interval;
 	struct pmu			*unique_pmu;
 	struct perf_cgroup		*cgrp;
+	int				group_flag;
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0ebc468..08d0c3e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6746,18 +6746,35 @@ static int perf_pmu_nop_int(struct pmu *pmu)
 
 static void perf_pmu_start_txn(struct pmu *pmu, int flags)
 {
-	perf_pmu_disable(pmu);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+
+	BUG_ON(cpuctx->group_flag);
+
+	cpuctx->group_flag = flags;
+
+	if (flags & PERF_EVENT_TXN_ADD)
+		perf_pmu_disable(pmu);
 }
 
 static int perf_pmu_commit_txn(struct pmu *pmu)
 {
-	perf_pmu_enable(pmu);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+
+	if (cpuctx->group_flag & PERF_EVENT_TXN_ADD)
+		perf_pmu_enable(pmu);
+
+	cpuctx->group_flag &= ~PERF_EVENT_TXN_MASK;
 	return 0;
 }
 
 static void perf_pmu_cancel_txn(struct pmu *pmu)
 {
-	perf_pmu_enable(pmu);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+
+	if (cpuctx->group_flag & PERF_EVENT_TXN_ADD)
+		perf_pmu_enable(pmu);
+
+	cpuctx->group_flag &= ~PERF_EVENT_TXN_MASK;
 }
 
 static int perf_event_idx_default(struct perf_event *event)
