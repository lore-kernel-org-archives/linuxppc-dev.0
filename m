Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E4191A08FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 17:57:41 +1100 (AEDT)
Date: Tue, 17 Mar 2015 07:57:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] perf/powerpc: Implement group_read() txn interface
 for 24x7 counters
Message-ID: <20150317065733.GN2896@worktop.programming.kicks-ass.net>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425458108-3341-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Wed, Mar 04, 2015 at 12:35:08AM -0800, Sukadev Bhattiprolu wrote:
> +++ b/kernel/events/core.c
> @@ -3677,11 +3677,34 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running,
>  }
>  EXPORT_SYMBOL_GPL(perf_event_read_value);
>  
> +static int do_pmu_group_read(struct perf_event *leader)
> +{
> +	int ret;
> +	struct pmu *pmu;
> +	struct perf_event *sub;
> +
> +	pmu = leader->pmu;
> +	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
> +
> +	pmu->read(leader);
> +	list_for_each_entry(sub, &leader->sibling_list, group_entry)
> +		pmu->read(sub);
> +
> +	/*
> +	 * Commit_txn submits the transaction to read all the counters
> +	 * in the group _and_ updates the event count.
> +	 */
> +	ret = pmu->commit_txn(pmu, PERF_PMU_TXN_READ);
> +
> +	return ret;
> +}
> +
>  static int perf_event_read_group(struct perf_event *event,
>  				   u64 read_format, char __user *buf)
>  {
>  	struct perf_event *leader = event->group_leader, *sub;
>  	struct perf_event_context *ctx = leader->ctx;
> +	struct pmu *pmu;
>  	int n = 0, size = 0, ret;
>  	u64 count, enabled, running;
>  	u64 values[5];
> @@ -3690,7 +3713,21 @@ static int perf_event_read_group(struct perf_event *event,
>  
>  	lockdep_assert_held(&ctx->mutex);
>  
> +	pmu = event->pmu;
>  	update = 1;
> +
> +	if ((read_format & PERF_FORMAT_GROUP) &&
> +			(pmu->capabilities & PERF_PMU_CAP_GROUP_READ)) {
> +		ret = do_pmu_group_read(event);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * ->commit_txn() would have updated the event count,
> +		 * so we don't have to consult the PMU again.
> +		 */
> +		update = 0;
> +	}
> +

Is there a down-side to always doing the txn based group read? If an
arch does not implement the read txn support it'll fall back to doing
independent read ops, but we end up doing those anyway.

That way we get less special case code.
