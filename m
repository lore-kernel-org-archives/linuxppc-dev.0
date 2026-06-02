Return-Path: <linuxppc-dev+bounces-21854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7999C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:18:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV3dF1BdLz2xdh;
	Tue, 02 Jun 2026 18:18:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780388337;
	cv=none; b=lqqCIrY1w7qt30Cs1qtfKu6T7xETxSYGkEehhiaFdCS2Qjdw0VBpHPNWIi9JD7RcUhmH5+FQsVNHAR54CkG141jHblUxGwaVSDBfc9TI/vmHw7QSgexpGmDYIp8+Xuo+/TUldt8GsvwL92tC1yZxuIl6kmH7iVF+d/WsLgNtlXQobj5l3ykWD9LwP0TTmEG4nSPlUR9MxJ1wPkUCyotkVCcEotGZugHkcJPcqj3R2nPbLYRIFyQiEsYlWGuHJ9339Kcj+86XWrJRDYQGUAYleGZ9PHmlSf07dcTgfAwJcTVVV+oc++VU0upv+J5f3NjBOejnpuBTIfX4elbX9AmMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780388337; c=relaxed/relaxed;
	bh=Eth7fFuHYGEZavWHClP4kKTw0ybwZVVXf+qx1PULgMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnX6BaAYllmZtxaq0l7Hp9r4YjNePl4EwI1k8PVvkchwCgP6h3GM8EpJGVu0OuMHnTRx3lRt7D7bd39m1A1VSs7kvETctwHsInQJW0N/Eek/bmFmLOpaK41f+OO4pniAYFLumSdq0MzgSNNI4TeRKM+TObSAqCYfG3tZSoPNLbNzkmJM8Vy3Dh7fcgcPsTwmHNu3dlIov0p8yMXt0Zn+BTxgkQ35TJgG2A5+u7MckD9n95mnKnwRz0oTf9UgtibndSVluDU+F+CjQ3Dyffd6DbPbe9YmmRyTkTPrR8X8X94dNIg6hI1SeKtGfiOwKsc+fQd89wc6xrwycpJB3360JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NcOUVdW8; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NcOUVdW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV3dB5Ym6z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:18:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Eth7fFuHYGEZavWHClP4kKTw0ybwZVVXf+qx1PULgMA=; b=NcOUVdW8szMDtLxDzpaGR6UHW7
	Y/vUvQRtcMzM8uhu831Jz3DjkIPF1hzpOfmjmBR71LEO5UXP1tPjbkKur/wR/8NOEq+kEDz+CpWun
	aDEfM+JP9qtT95fpyCQQvd4Q77xAAGyXWBSbZ1zuhD7uevnURoy+uiZ/luwhfpaK26OL8nCUKjNsm
	nbjGqsudOI/0OyVavlAv6ytSu7PoQBUv2VYIZcNhiLQRzVev1c9utwS7vikufn+WaN5oLzJRtinWz
	m9LOeCNEGC9vm4JJf27iZ/tgpTduIn8rCE/YG8hSamktxApepqQWAop1cx9HyooK3RPlWtaEroCj5
	/abVELdA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKKk-00000001akl-33HV;
	Tue, 02 Jun 2026 08:18:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E542630019E; Tue, 02 Jun 2026 10:18:45 +0200 (CEST)
Date: Tue, 2 Jun 2026 10:18:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [linux-next20260529] kernel BUG at kernel/sched/core.c:7512!
Message-ID: <20260602081845.GX3126523@noisy.programming.kicks-ass.net>
References: <7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com>
 <2f8c3d75-de2c-48bf-bd05-46b816d55c69@linux.ibm.com>
 <20260601095601.GN3102624@noisy.programming.kicks-ass.net>
 <37e69c39-564b-4ca9-bb27-1b99faab540c@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e69c39-564b-4ca9-bb27-1b99faab540c@linux.ibm.com>

On Tue, Jun 02, 2026 at 01:26:48PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 6/1/26 3:26 PM, Peter Zijlstra wrote:
> > On Mon, Jun 01, 2026 at 02:46:24PM +0530, Shrikanth Hegde wrote:
> > 
> > > Ritesh, Mukesh, Is below possible scenario?
> > > 
> > > do_page_fault seems to enable irq's in the interrupt handler?
> > > is that expected? if so, one might see
> > > 
> > > -- do_page_fault (enter kernel mode)
> > >     -- enables interrupts
> > >     -- gets interrupt - Sets need_resched.
> > >        -- irqentry_exit - Sees it is kernel mode. Just checks preempt count
> > > 			 and calls preempt_schedule_irq, which catches both
> > > 			 preempt_count and !irqs_disabled. Hence the panic?
> > > 
> > > Should do_page_fault do preempt_disable when it enables the interrupts?
> > 
> > No, it is expected for page-fault to be able to schedule. Specifically,
> > it must be able to sleep to support loading pages from disk.
> 
> Oh yes. Ok. Thanks for taking a look.
> 
> > 
> > Please check the value of preempt_count() (does it perchance have
> > HARDIRQ_OFFSET?). Also, if the fault handler does enable IRQs, it must
> > also disable them again once done.
> 
> Will check it.
> 
> > 
> > Notably, I see ___do_page_fault() do interrupt_cond_loadl_irq_enable(),
> > but I'm not seeing a local_irq_disable() to match!
> 
> Yes, that's likely the culprit. It is possible that ___do_page_fault runs for longer
> and it may set need_resched. If it was in kernel mode, then it may not disable the
> interrupt and then subsequent irqentry_exit panics.
> 
> BTW I was able to consistently repro this on P9 with hackbench as below.
> 
> for i in {0..10}; do ./hackbench 10 process 10000 loops; done;
> for i in {0..10}; do ./hackbench 20 process 10000 loops; done;
> for i in {0..10}; do ./hackbench 30 process 10000 loops; done;
> for i in {0..10}; do ./hackbench 40 process 10000 loops; done;    << usually panics here.
> for i in {0..10}; do ./hackbench 10 thread 10000 loops; done;
> for i in {0..10}; do ./hackbench 20 thread 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 10 process 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 20 process 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 30 process 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 40 process 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 10 thread 10000 loops; done;
> for i in {0..10}; do ./hackbench -pipe 20 thread 10000 loops; done;
> 
> Note, if i run ./hackbench 40 process 10000 loops alone, it doesn't panic.
> Likely some continous stressing needed to get into this case.
> 
> Below diff helps to fix it. With it see test passes. Hackbench numbers aren't super happy
> about it. It is regressing a bit compared to baseline. But no panic atleast.
> AND i have changed the BUG_ON to WARN_ON as irq_disabled right after. We could still fix the
> call sites if the warning is seen.
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index de5601282755..7da373a56813 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>  static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>  {
>         if (user_mode(regs)) {
> -               BUG_ON(regs_is_unrecoverable(regs));
> -               BUG_ON(regs_irqs_disabled(regs));
> +               WARN_ON(regs_is_unrecoverable(regs));
> +               WARN_ON(regs_irqs_disabled(regs));
>                 /*
>                  * We don't need to restore AMR on the way back to userspace for KUAP.
>                  * AMR can only have been unlocked if we interrupted the kernel.
>                  */
>                 kuap_assert_locked();
> -
> -               local_irq_disable();
>         }
> +
> +       /* irqentry_exit expects to be called with interrupts disabled */
> +       local_irq_disable();
>  }
>  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> 

I would suggest trying something a little more focussed like so:

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 806c74e0d5ab..b002c179415c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -589,6 +589,7 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
 	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
 	if (unlikely(err))
 		bad_page_fault(regs, err);
+	local_irq_disable();
 }
 
 DEFINE_INTERRUPT_HANDLER(do_page_fault)

Since only ___do_page_fault() will enable interrupts, you only need to
disable them again on its return path. 


