Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCF851A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 22:51:29 +1000 (AEST)
Date: Wed, 8 Apr 2015 14:51:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] powerpc/perf/hv-24x7: Use PMU_TXN_READ interface
Message-ID: <20150408125113.GG23123@twins.programming.kicks-ass.net>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-6-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428453299-19121-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, Apr 07, 2015 at 05:34:59PM -0700, Sukadev Bhattiprolu wrote:
> @@ -1213,9 +1221,47 @@ static void update_event_count(struct perf_event *event, u64 now)
>  static void h_24x7_event_read(struct perf_event *event)
>  {
>  	u64 now;
> +	struct h_24x7_hw *h24x7hw;
> +	struct hv_24x7_request_buffer *request_buffer;
> +
> +	/*
> +	 * If in a READ transaction, add this counter to the list of
> +	 * counters to read during the next HCALL (i.e commit_txn()).
> +	 * If not in a READ transaction, go ahead and make the HCALL
> +	 * to read this counter by itself.
> +	 */
> +	h24x7hw = &get_cpu_var(h_24x7_hw);
> +	if (h24x7hw->txn_err)
> +		goto out;
> +
> +	if (h24x7hw->in_txn) {
> +		int i;
> +		int ret;
> +
> +		request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
> +
> +		ret = add_event_to_24x7_request(event, request_buffer);
> +		if (ret) {
> +			h24x7hw->txn_err = ret;
> +		} else {
> +			/*
> +			 * Assoicate the event with the HCALL request index,
> +			 * so we can quickly find/update the count in
> +			 * ->commit_txn().
> +			 */
> +			i = request_buffer->num_requests - 1;
> +			h24x7hw->events[i] = event;
> +		}
> +
> +		put_cpu_var(hv_24x7_reqb);
> +		goto out;
> +	}
>  
>  	now = h_24x7_get_value(event);
>  	update_event_count(event, now);
> +
> +out:
> +	put_cpu_var(h_24x7_hw);
>  }

Most of the pmu ops are called with IRQs disabled, no need to use
get_cpu_var()/put_cpu_var() which disable/enable preemption.
