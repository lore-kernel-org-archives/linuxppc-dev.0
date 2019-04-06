Return-Path: <SRS0=xYH3=SI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C63C282CE
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 00:54:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F012175B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 00:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="keNRm2Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F012175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bdW72ScNzDqTw
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 11:54:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=frederic@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="keNRm2Fy"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bcRH0HCDzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 11:06:18 +1100 (AEDT)
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr
 [90.101.143.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46DDC2175B;
 Sat,  6 Apr 2019 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554509175;
 bh=2XBGba5wbr40ZhGObvVDKBaLQIRBMHmzLnyImY9X07g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=keNRm2FyDSLMBgtmUGjedJt5U7gvYYE/EBjbNnlapst4b+GKj5lv302kc8GJpbGOI
 BuZt0opcMwAlct1LSkBbaXpzocP2xPdMeWpy9eiIVw99/oU7x4zhWXpr3V3pC+gvMS
 WDDZP2AkrpidbDMeQ+jQZfE8DJmmFczw0ZALLLnA=
Date: Sat, 6 Apr 2019 02:06:12 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
Message-ID: <20190406000611.GA27782@lenoir>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
 <1553912871.ce5mzizoek.astroid@bobo.none>
 <20190401083827.GE11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401083827.GE11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Sat, 06 Apr 2019 11:53:08 +1100
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

On Mon, Apr 01, 2019 at 10:38:27AM +0200, Peter Zijlstra wrote:
> 
> + fweisbec, who did the remote bits
> 
> On Sat, Mar 30, 2019 at 01:10:28PM +1000, Nicholas Piggin wrote:
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 6b7cdf17ccf8..f0e539d0f879 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > -/* Enqueue the irq work @work on the current CPU */
> > -bool irq_work_queue(struct irq_work *work)
> > +/*
> > + * Enqueue the irq_work @work on @cpu unless it's already pending
> > + * somewhere.
> > + *
> > + * Can be re-enqueued while the callback is still in progress.
> > + */
> > +bool irq_work_queue_on(struct irq_work *work, int cpu)
> >  {
> > +#ifndef CONFIG_SMP
> > +	return irq_work_queue(work);
> > +

I'd suggest to use "if (!IS_ENABLED(CONFIG_SMP))" here to avoid the large
ifdeffery.

> > +#else /* #ifndef CONFIG_SMP */
> > +	/* All work should have been flushed before going offline */
> > +	WARN_ON_ONCE(cpu_is_offline(cpu));
> > +
> >  	/* Only queue if not already pending */
> >  	if (!irq_work_claim(work))
> >  		return false;
> >  
> > -	/* Queue the entry and raise the IPI if needed. */
> >  	preempt_disable();
> > -
> > -	/* If the work is "lazy", handle it from next tick if any */
> > -	if (work->flags & IRQ_WORK_LAZY) {
> > -		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
> > -		    tick_nohz_tick_stopped())
> > -			arch_irq_work_raise();
> > -	} else {
> > -		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
> > -			arch_irq_work_raise();
> > -	}
> > -
> > +	if (cpu != smp_processor_id()) {
> > +		/* Arch remote IPI send/receive backend aren't NMI safe */
> > +		WARN_ON_ONCE(in_nmi());
> > +		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
> > +			arch_send_call_function_single_ipi(cpu);
> > +	} else
> > +		__irq_work_queue(work);

Also perhaps rename __irq_work_queue() to irq_work_queue_local() to make it
instantly clearer to reviewers.

Other than those cosmetic changes,

  Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
