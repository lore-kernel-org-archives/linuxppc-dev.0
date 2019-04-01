Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F932C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887D12086C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m9QXBXmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887D12086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xm4p0vtNzDqM9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 19:40:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xm2s5L2QzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 19:38:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnMBELxcMLP/nMpZ6SYPjDZog9u7Xx0QVueRZJbs+e0=; b=m9QXBXmrfR5vSzcx4M81rhWJc
 NMrUJ0UepOnaz21uKO6H0M/O42CbD44GmejEwDZdCe2Zyhc4kx/NquB7liNav6jA2vXNyPJYozuD9
 BtiCPJbY9ihmbk5sKAsgaL/bk+FQBoP6NazqAmVjUdeFTQ1oNWomAmyoPx73W8C/ipZeDORhLsWdc
 87EtQtW6jAnSMxCcoI7082zeN9MCDlhl5qXq539CFeJavNUKJd0nhDJXuAMZPNHkha2tmdJu6VKdX
 JoY5OplWGTqeK4SHL7tPWndmPoUJTRQZrg49MCzqchAnQkpcMOZPiBPgz+bFMoolUU93aD3fFKtOz
 KW2cp+rrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hAsSb-0001LP-GV; Mon, 01 Apr 2019 08:38:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 961A52026BE95; Mon,  1 Apr 2019 10:38:27 +0200 (CEST)
Date: Mon, 1 Apr 2019 10:38:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
Message-ID: <20190401083827.GE11158@hirez.programming.kicks-ass.net>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
 <1553912871.ce5mzizoek.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553912871.ce5mzizoek.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, qemu-ppc@nongnu.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 David? Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


+ fweisbec, who did the remote bits

On Sat, Mar 30, 2019 at 01:10:28PM +1000, Nicholas Piggin wrote:
> Something like this?
> 
> kernel/irq_work: Do not raise an IPI when queueing work on the local CPU
> 
> The QEMU powerpc/pseries machine model was not expecting a self-IPI,
> and it may be a bit surprising thing to do, so have irq_work_queue_on
> do local queueing when target is current CPU.

This seems OK to me.

> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/irq_work.c | 78 ++++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 6b7cdf17ccf8..f0e539d0f879 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -56,61 +56,69 @@ void __weak arch_irq_work_raise(void)
>  	 */
>  }
>  
> -/*
> - * Enqueue the irq_work @work on @cpu unless it's already pending
> - * somewhere.
> - *
> - * Can be re-enqueued while the callback is still in progress.
> - */
> -bool irq_work_queue_on(struct irq_work *work, int cpu)
> +/* Enqueue on current CPU, work must already be claimed and preempt disabled */
> +static void __irq_work_queue(struct irq_work *work)
>  {
> -	/* All work should have been flushed before going offline */
> -	WARN_ON_ONCE(cpu_is_offline(cpu));
> -
> -#ifdef CONFIG_SMP
> -
> -	/* Arch remote IPI send/receive backend aren't NMI safe */
> -	WARN_ON_ONCE(in_nmi());
> +	/* If the work is "lazy", handle it from next tick if any */
> +	if (work->flags & IRQ_WORK_LAZY) {
> +		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
> +		    tick_nohz_tick_stopped())
> +			arch_irq_work_raise();
> +	} else {
> +		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
> +			arch_irq_work_raise();
> +	}
> +}
>  
> +/* Enqueue the irq work @work on the current CPU */
> +bool irq_work_queue(struct irq_work *work)
> +{
>  	/* Only queue if not already pending */
>  	if (!irq_work_claim(work))
>  		return false;
>  
> -	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
> -		arch_send_call_function_single_ipi(cpu);
> -
> -#else /* #ifdef CONFIG_SMP */
> -	irq_work_queue(work);
> -#endif /* #else #ifdef CONFIG_SMP */
> +	/* Queue the entry and raise the IPI if needed. */
> +	preempt_disable();
> +	__irq_work_queue(work);
> +	preempt_enable();
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(irq_work_queue);
>  
> -/* Enqueue the irq work @work on the current CPU */
> -bool irq_work_queue(struct irq_work *work)
> +/*
> + * Enqueue the irq_work @work on @cpu unless it's already pending
> + * somewhere.
> + *
> + * Can be re-enqueued while the callback is still in progress.
> + */
> +bool irq_work_queue_on(struct irq_work *work, int cpu)
>  {
> +#ifndef CONFIG_SMP
> +	return irq_work_queue(work);
> +
> +#else /* #ifndef CONFIG_SMP */
> +	/* All work should have been flushed before going offline */
> +	WARN_ON_ONCE(cpu_is_offline(cpu));
> +
>  	/* Only queue if not already pending */
>  	if (!irq_work_claim(work))
>  		return false;
>  
> -	/* Queue the entry and raise the IPI if needed. */
>  	preempt_disable();
> -
> -	/* If the work is "lazy", handle it from next tick if any */
> -	if (work->flags & IRQ_WORK_LAZY) {
> -		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
> -		    tick_nohz_tick_stopped())
> -			arch_irq_work_raise();
> -	} else {
> -		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
> -			arch_irq_work_raise();
> -	}
> -
> +	if (cpu != smp_processor_id()) {
> +		/* Arch remote IPI send/receive backend aren't NMI safe */
> +		WARN_ON_ONCE(in_nmi());
> +		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
> +			arch_send_call_function_single_ipi(cpu);
> +	} else
> +		__irq_work_queue(work);
>  	preempt_enable();
>  
>  	return true;
> +#endif /* #else #ifndef CONFIG_SMP */
>  }
> -EXPORT_SYMBOL_GPL(irq_work_queue);
> +
>  
>  bool irq_work_needs_cpu(void)
>  {
> -- 
> 2.20.1
> 
