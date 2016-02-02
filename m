Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 025691A0202
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 05:18:29 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 04:18:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DD62B2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 05:18:24 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12IIGBJ50069584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 05:18:24 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12IHqCX023706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 05:17:52 +1100
Subject: Re: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20160130030710.GA7330@us.ibm.com>
 <20160130030744.GB7330@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <56B0F2BD.4090007@linux.vnet.ibm.com>
Date: Tue, 2 Feb 2016 23:47:33 +0530
MIME-Version: 1.0
In-Reply-To: <20160130030744.GB7330@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 30 January 2016 08:37 AM, Sukadev Bhattiprolu wrote:
> From a1aa992fb25fb8e98a5c5724376ae8cc91463de3 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Mon, 25 Jan 2016 23:05:36 -0500
> Subject: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values
>
> For 24x7 counters, perf displays the raw value of the 24x7 counter, which
> is a monotonically increasing value.
>
> 	perf stat -C 0 -e \
> 		'hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/' \
> 		sleep 1
>
>  Performance counter stats for 'CPU(s) 0':
>
>      9,105,403,170      hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/
>
>        0.000425751 seconds time elapsed
>
> In the typical usage of 'perf stat' this counter value is not as useful
> as the _change_ in the counter value over the duration of the application.

This may break application using this interface right? i.e, since
for all this time, counter output was raw values and application
may be post processing to calculate the difference, now with
this patch, application may need some change? Also,
should not this be documented somewhere?

Maddy

> Have h_24x7_event_init() set the event's prev_count to the raw value of
> the 24x7 counter at the time of initialization. When the application
> terminates, hv_24x7_event_read() will compute the change in value and
> report to the perf tool. Similarly, for the transaction interface, clear
> the event count to 0 at the beginning of the transaction.
>
> 	perf stat -C 0 -e \
> 		'hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/' \
> 		sleep 1
>
>  Performance counter stats for 'CPU(s) 0':
>
>            245,758      hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/
>
>        1.006366383 seconds time elapsed
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index b7a9a03..77b958f 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1222,11 +1222,12 @@ static int h_24x7_event_init(struct perf_event *event)
>  		return -EACCES;
>  	}
>  
> -	/* see if the event complains */
> +	/* Get the initial value of the counter for this event */
>  	if (single_24x7_request(event, &ct)) {
>  		pr_devel("test hcall failed\n");
>  		return -EIO;
>  	}
> +	(void)local64_xchg(&event->hw.prev_count, ct);
>  
>  	return 0;
>  }
> @@ -1289,6 +1290,16 @@ static void h_24x7_event_read(struct perf_event *event)
>  			h24x7hw = &get_cpu_var(hv_24x7_hw);
>  			h24x7hw->events[i] = event;
>  			put_cpu_var(h24x7hw);
> +			/*
> +			 * Clear the event count so we can compute the _change_
> +			 * in the 24x7 raw counter value at the end of the txn.
> +			 *
> +			 * Note that we could alternatively read the 24x7 value
> +			 * now and save its value in event->hw.prev_count. But
> +			 * that would require issuing a hcall, which would then
> +			 * defeat the purpose of using the txn interface.
> +			 */
> +			local64_set(&event->count, 0);
>  		}
>  
>  		put_cpu_var(hv_24x7_reqb);
