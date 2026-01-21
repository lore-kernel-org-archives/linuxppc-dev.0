Return-Path: <linuxppc-dev+bounces-16112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6D9C44536
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxBt21zJgz2xqD;
	Thu, 22 Jan 2026 05:04:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769018682;
	cv=none; b=L5u/wH1tqW9C8fBMjGMJhdr3lH7Fro+Gn3kvGUJd6YP4949bIijFwH/T74HzcgoXAdDftUHp+ImRfBMq+u/kJQ5/O2OeR3rlidNf8f8/VBayFmboW9vd9AY/YThFbii2N3cApQgPhdJJkvNQGKAuuWTnmVjeSmr3HIwoXVq18LH7oChr9uKUrhYnKyXDN9RMScgMR+QfniALQmw9sZhqv1CTp25YlzCq3zH2YcZY1gCTk8RxmKNzl2aoTkc5NSKDKKMbRRsf9GN8FSkZXcDtaTkdTQXI4oNEffLn24U/acJi3IAgc/3zKsE3ZrpwV8RlvzdgcwJdCCpQLBGyXlKjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769018682; c=relaxed/relaxed;
	bh=iS20oLjIAG96OV7Uo+tl9ULe0JH4XLICkgZliwSH/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5736N2Q5U7aZ+txAb1tnGmxvWDZJVucpB+3ZWrZ0gmVzURZqukUKrdQ6VmCIKQUwl9EIhmr+IHvR2wl5tELdWRHE26K3Lyd/cy20AnqPhNPImcLZdfI40nyyzzCXdNsOWN0RAjpcnz1toeg3FtZVS/NYxR3YIFeOGjOPfJcJCfi30IoUaERMtibiBDLzN4FB/h77HcYzxed+T0PFWMh2xR3hc/S3KkYpKIxZpeuE9oZ/CwW0zxNHM8WouDa6tUmPSj/L0mDtBWGnNFT/EWG2+kNwQJhWUa6+kB0ei3zCn8ekYma6KFbjT0M7XMRkKsKp7wUZN00QrV7wJuLQjsMAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R8mnX7pQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R8mnX7pQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxBt132Hcz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 05:04:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F50F4332A;
	Wed, 21 Jan 2026 18:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4622CC19422;
	Wed, 21 Jan 2026 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769018679;
	bh=zgHajdVw61MqSQX6CzNOyKpHHjKBbIr1ZOLWeN8umBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8mnX7pQClLyRszYv6lZRWRdiGNnqFJVNvE+Z4pRPauE/B5J84fJI11PNQMH1FpdF
	 lvVk+nNc1pR35MlRZX2TJZxasZFeYFgtsAIiupoZ1+Mu2nqwtnFa4Pq0xkLuK84QU1
	 5nLpIwResJGOP9yVZm6DcV52yoEGIuz9HzqLJdqkPu2VTyKJd58tOMT3jVv+MKz1Zo
	 Rthm5BKmMGOGaLeGW8ezfj1xH4FCNBHHoJ1p+9eeTG3r+qMbTRIpDI9OJcMVtucqs2
	 jrblMtbHN8h5QqjYpsjlc92BkyVYkW8RD59XEMglysdk1t164EM4kbuay4PvII/fuy
	 emULbyvfdS+qQ==
Date: Wed, 21 Jan 2026 19:04:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/15] s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <aXEVM-04lj0lntMr@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
 <20260121121748.9719Bab-hca@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121121748.9719Bab-hca@linux.ibm.com>

Le Wed, Jan 21, 2026 at 01:17:48PM +0100, Heiko Carstens a écrit :
> On Fri, Jan 16, 2026 at 03:51:58PM +0100, Frederic Weisbecker wrote:
> > diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> > index 39cb8d0ae348..54bb932184dd 100644
> > --- a/arch/s390/kernel/idle.c
> > +++ b/arch/s390/kernel/idle.c
> > @@ -35,6 +35,12 @@ void account_idle_time_irq(void)
> >  			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
> >  	}
> >  
> > +	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
> > +
> > +	/* Dyntick idle time accounted by nohz/scheduler */
> > +	if (idle->idle_dyntick)
> > +		return;
> > +
> >  	idle_time = lc->int_clock - idle->clock_idle_enter;
> >  
> >  	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> > @@ -45,7 +51,6 @@ void account_idle_time_irq(void)
> >  
> >  	/* Account time spent with enabled wait psw loaded as idle time. */
> >  	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
> > -	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
> >  	account_idle_time(cputime_to_nsecs(idle_time));
> >  }
> 
> This breaks idle time reporting (aka enabled wait psw time) via the per-cpu
> sysfs files (see show_idle_time()). That is: the second WRITE_ONCE() should
> also go above the early return statement; but of course this leads to other
> dependencies...

Oh right! Will fix that.

BTW here is a question for you, does the timer (as in get_cpu_timer()) still
decrements while in idle? I would assume not, given how lc->system_timer
is updated in account_idle_time_irq().

And another question in this same function is this :

    lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;

clock_idle_enter is updated right before halting the CPU. But when was
last_update_clock updated last? Could be either task switch to idle, or
a previous idle tick interrupt or a previous idle IRQ entry. In any case
I'm not sure the difference is meaningful as steal time.

I must be missing something.

> Not sure what to do with this. I thought about removing those sysfs files
> already in the past, since they are of very limited use; and most likely
> nothing in user space would miss them.

Perhaps but this file is a good comparison point against /proc/stat because
s390 vtime is much closer to measuring the actual CPU halted time than what
the generic nohz accounting does (which includes more idle code execution).

> 
> Anyway, you need to integrate the trivial patch below, so everything compiles
> for s390. It also _seems_ to work.

Thanks, I'll include that.

> 
> Guess I need to spend some more time on accounting and see what it would take
> to convert to VIRT_CPU_ACCOUNTING_GEN, while keeping the current precision and
> functionality.

I would expect more overhead with VIRT_CPU_ACCOUNTING_GEN, though that has yet
to be measured. In any case you'll lose some idle cputime precision (but
you need to read that through s390 sysfs files) if what we want to measure
here is the actual halted time.

Perhaps we could enhance VIRT_CPU_ACCOUNTING_GEN and nohz idle cputime
accounting to match s390 precision. Though I expect some cost
accessing the clock inevitably more often on some machines.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

