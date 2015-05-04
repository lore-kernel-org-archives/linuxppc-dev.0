Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69CB21A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 15:51:39 +1000 (AEST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4FDC14028F
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 15:51:38 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 3 May 2015 23:51:36 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9856B38C8046
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 01:51:32 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t445pWlV59113570
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 05:51:32 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t445pVuR012064
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 01:51:32 -0400
Message-ID: <554708E0.1010600@linux.vnet.ibm.com>
Date: Mon, 04 May 2015 11:21:28 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: tglx@linutronix.de, mingo@kernel.org
Subject: Re: [PATCH] tick-broadcast: Fix the printing of broadcast masks
References: <20150428084520.3314.62668.stgit@preeti.in.ibm.com>
In-Reply-To: <20150428084520.3314.62668.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, linuxppc-dev@ozlabs.org, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping.

Any comments on this patch ?

Regards
Preeti U Murthy
On 04/28/2015 02:15 PM, Preeti U Murthy wrote:
> Today the number of bits of the broadcast masks that is output into
> /proc/timer_list is sizeof(unsigned long). This means that on machines
> with larger number of CPUs, the bitmasks of CPUs beyond this range do
> not appear.
> 
> Fix this by using bitmap printing through "%*pb" instead, so as to
> output the broadcast masks for the range of nr_cpu_ids into
> /proc/timer_list.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> 
>  kernel/time/timer_list.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index c82b03c..1afc726 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -269,11 +269,11 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
>  {
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  	print_tickdevice(m, tick_get_broadcast_device(), -1);
> -	SEQ_printf(m, "tick_broadcast_mask: %08lx\n",
> -		   cpumask_bits(tick_get_broadcast_mask())[0]);
> +	SEQ_printf(m, "tick_broadcast_mask: %*pb\n",
> +		   cpumask_pr_args(tick_get_broadcast_mask()));
>  #ifdef CONFIG_TICK_ONESHOT
> -	SEQ_printf(m, "tick_broadcast_oneshot_mask: %08lx\n",
> -		   cpumask_bits(tick_get_broadcast_oneshot_mask())[0]);
> +	SEQ_printf(m, "tick_broadcast_oneshot_mask: %*pb\n",
> +		   cpumask_pr_args(tick_get_broadcast_oneshot_mask()));
>  #endif
>  	SEQ_printf(m, "\n");
>  #endif
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
