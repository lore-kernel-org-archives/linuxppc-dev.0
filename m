Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3DB92C00CD
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2012 08:51:03 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 27 Aug 2012 16:50:59 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 93F353E40044
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2012 16:50:34 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7RMoPi6131952
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2012 16:50:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7RMoOkQ014346
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2012 16:50:24 -0600
Date: Mon, 27 Aug 2012 15:50:20 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Make sure IPI handlers see data written by IPI
 senders
Message-ID: <20120827225020.GF2961@linux.vnet.ibm.com>
References: <20120825050423.GD7051@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120825050423.GD7051@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 25, 2012 at 03:04:23PM +1000, Paul Mackerras wrote:
> We have been observing hangs, both in KVM guest vcpus and more
> generally, where a process that is woken doesn't properly wake up and
> continue to run, but instead sticks in TASK_WAKING state.  This
> happens because the update of rq->wake_list in ttwu_queue_remote()
> is not ordered with the update of ipi_message in
> smp_muxed_ipi_message_pass(), and the reading of rq->wake_list in
> scheduler_ipi() is not ordered with the reading of ipi_message in
> smp_ipi_demux().  Thus it is possible for the IPI receiver not to see
> the updated rq->wake_list and therefore conclude that there is nothing
> for it to do.
> 
> In order to make sure that anything done before calling
> smp_send_reschedule() is ordered before anything done in the resulting
> call to scheduler_ipi(), this adds barriers in
> smp_muxed_message_pass() and smp_ipi_demux().  The barrier in
> smp_muxed_message_pass() is a full barrier to ensure that there is a
> full ordering between the smp_send_reschedule() caller and
> scheduler_ipi().  In smp_ipi_demux(), we use xchg() rather than
> xchg_local() because xchg() includes release and acquire barriers.
> Using xchg() rather than xchg_local() makes sense given that
> ipi_message is not just accessed locally.
> 
> These changes made no measurable difference to the speed of IPIs as
> measured using a simple ping-pong latency test across two CPUs on
> different cores of a POWER7 machine.
> 
> The analysis of the reason why processes were not waking up properly
> is due to Milton Miller.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/smp.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index e292ff2..ca1040a 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -197,8 +197,15 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
>  	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
>  	char *message = (char *)&info->messages;
> 
> +	/*
> +	 * Order previous accesses before accesses in the IPI handler.
> +	 */
> +	smp_mb();
>  	message[msg] = 1;
> -	mb();
> +	/*
> +	 * Order setting of message before IPI.
> +	 */
> +	smp_wmb();
>  	smp_ops->cause_ipi(cpu, info->data);
>  }
> 
> @@ -210,7 +217,7 @@ irqreturn_t smp_ipi_demux(void)
>  	mb();	/* order any irq clear */
> 
>  	do {
> -		all = xchg_local(&info->messages, 0);
> +		all = xchg(&info->messages, 0);
> 
>  #ifdef __BIG_ENDIAN
>  		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNCTION)))
> -- 
> 1.7.10.rc3.219.g53414
> 
