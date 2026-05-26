Return-Path: <linuxppc-dev+bounces-21508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446C7CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 10:42:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPq7y6t5fz2y8t;
	Tue, 26 May 2026 20:42:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779792142;
	cv=none; b=n/2wZ3MbkakS9TuPEctbgb4P7zhVOGLgdbaQLYeUJj8z9m7eT5bch1nVmhADXb7CYqESH3MqVy5sIbs+clCvx15gVssrYOibrNYHxWPyTORDhncgG3Ij+AVroqDH12kRteX7OkY95OoWCIV27GK38PDeanji50Yeh40xYLqBdiJmKJk6zsOKTCKsExy0S0L7lADu0/1dYGglhhrk3saV67+/R2+BtdJKscUTUI1lWP0Gs4jRgMYDLNujrwDFhY6IOvBFt0zb2+mTU0tZoR5QsSKktS2HcLfKdEj7IN7JaP1NFoQ+0EGoD4YtfApx0TCei+clSf5gVMVnR8L5w/uoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779792142; c=relaxed/relaxed;
	bh=L35IJ9WIVC7+atMHRpuJtxHcWN3aZ/3jF8Oyw9Qgfdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAAQUrveJGGldYvGEZlvUI6DT86H5AN/alx4wSpCloYrIaheOWUAlw0oMLc8F+IJahXhxJaxwBkco+GKIQixAIYLqrCX+MiyDtd004GDiWQL+d4okB5/GxShnSKeoTkm159I7rC4uQLjvh9kHqs94QlLY3i8d1qya+0s3CD2bmfgtmf0z0RqFf3FeuilPLRHNFvJBdBohaU0pN7Zh/J+PnS9atf7ZdIDcdTtdCBbWjBcnZE6F/oTkckfDgH1NVQS0SiqVo/tlEz2a7kU5pGrSYScQXT5yviU4jelQBaCK7ndhcyxa0ftWcgc0agStlubOTeo6W4t9NK5EfWRtZU1pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1cEhu6G; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1cEhu6G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPq7x6H1kz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 20:42:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7A9160018;
	Tue, 26 May 2026 10:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9AB1F000E9;
	Tue, 26 May 2026 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779792139;
	bh=L35IJ9WIVC7+atMHRpuJtxHcWN3aZ/3jF8Oyw9Qgfdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m1cEhu6G9y4XvRjUGsyR5hyCzt/7JJnLHzG4LYJ9jE+ye3Qo4gY+AtUN2095cV2n8
	 9wtv6MsAfWqWL54yBxDpZpZYy2rUgX2gMJDlQ/yUsfEo3SIubXVgmQQyT6qA2k4ogo
	 i8+pdUaSlsbQJoLNXMrJ9Mza+dJtogv3DE41DdtDJwRxuFKG+YFtysHZXakpcPMs47
	 UWEsYPOFqr09BtTJ/tLFTCn1DJaBxWsmYn7+klXMTDjyV183RxkQ+TDu9LahzTX21d
	 q2T9tLtfEvz5xq3+Lqo+3gkUYu1BCbXQqyjYYFfVjQDJoJlt1uaH2AG8cX5jSNiufk
	 wES/210Zef+5w==
Date: Tue, 26 May 2026 12:42:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ben Segall <bsegall@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Sashiko@localhost.localdomain, Ingo Molnar <mingo@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 00/15 v4] tick/sched: Refactor idle cputime accounting
Message-ID: <ahV5CFMvMEKtuVct@localhost.localdomain>
References: <20260508131647.43868-1-frederic@kernel.org>
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
In-Reply-To: <20260508131647.43868-1-frederic@kernel.org>

Hi,

I don't see any further concern. What should we do with this? It could
either go through the scheduler tree or the timer tree.

Thanks.


Le Fri, May 08, 2026 at 03:16:32PM +0200, Frederic Weisbecker a écrit :
> Hi,
> 
> After the issue reported here:
> 
>         https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/
> 
> It occurs that the idle cputime accounting is a big mess that
> accumulates within two concurrent statistics, each having their own
> shortcomings:
> 
> * The accounting for online CPUs which is based on the delta between
>   tick_nohz_start_idle() and tick_nohz_stop_idle().
> 
>   Pros:
>        - Works when the tick is off
> 
>        - Has nsecs granularity
> 
>   Cons:
>        - Account idle steal time but doesn't substract it from idle
>          cputime.
> 
>        - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
>          the IRQ time is simply ignored when
>          CONFIG_IRQ_TIME_ACCOUNTING=n
> 
>        - The windows between 1) idle task scheduling and the first call
>          to tick_nohz_start_idle() and 2) idle task between the last
>          tick_nohz_stop_idle() and the rest of the idle time are
>          blindspots wrt. cputime accounting (though mostly insignificant
>          amount)
> 
>        - Relies on private fields outside of kernel stats, with specific
>          accessors.
> 
> * The accounting for offline CPUs which is based on ticks and the
>   jiffies delta during which the tick was stopped.
> 
>   Pros:
>        - Handles steal time correctly
> 
>        - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
>          CONFIG_IRQ_TIME_ACCOUNTING=n correctly.
> 
>        - Handles the whole idle task
> 
>        - Accounts directly to kernel stats, without midlayer accumulator.
> 
>    Cons:
>        - Doesn't elapse when the tick is off, which doesn't make it
>          suitable for online CPUs.
> 
>        - Has TICK_NSEC granularity (jiffies)
> 
>        - Needs to track the dyntick-idle ticks that were accounted and
>          substract them from the total jiffies time spent while the tick
>          was stopped. This is an ugly workaround.
> 
> Having two different accounting for a single context is not the only
> problem: since those accountings are of different natures, it is
> possible to observe the global idle time going backward after a CPU goes
> offline, as reported by Xin Zhao.
> 
> Clean up the situation with introducing a hybrid approach that stays
> coherent, fixes the backward jumps and works for both online and offline
> CPUs:
> 
> * Tick based or native vtime accounting operate before the tick is
>   stopped and resumes once the tick is restarted.
> 
> * When the idle loop starts, switch to dynticks-idle accounting as is
>   done currently, except that the statistics accumulate directly to the
>   relevant kernel stat fields.
> 
> * Private dyntick cputime accounting fields are removed.
> 
> * Works on both online and offline case.
> 
> * Move most of the relevant code to the common sched/cputime subsystem
> 
> * Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
>   dynticks-idle accounting still elapses while on IRQs.
> 
> * Correctly substract idle steal cputime from idle time
> 
> Changes since v3 (among which a lot of relevant reviews from Sashiko):
> 
> - Add new tags
> 
> - Rebase on latest -rc1
> 
> - Add "tick/sched: Fix TOCTOU in nohz idle time fetch" (Sashiko)
> 
> - Fix buggy state refetch in kcpustat_cpu_fetch_vtime() (Sashiko)
> 
> - Fix build issue on powerpc (Christophe Leroy)
> 
> - Fix s390 lost steal time occuring on idle IRQs (call vtime_flush() on
>   vtime_account_hardirq() and vtime_account_softirq()) (Sashiko)
> 
> - Fix build issue on s390
> 
> - Fix uninitialized idle_sleeptime_seq (Sashiko)
> 
> - Fix irqtime being disabled or enabled in the middle of an idle IRQ
>   (Sashiko)
>   
> - Fix tick restart and then restop in the same idle loop (Sashiko)
> 
> - Fix "sched/cputime: Handle idle irqtime gracefully" changelog (Sashiko)
> 
> - Fix idle steal time substracted from the wrong index between idle and
>   iowait kcpustat. (Sashiko)
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/core-v4
> 
> HEAD: e64ba052ce04e363ff76d3cb8bedc5f812188acb
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (15):
>       tick/sched: Fix TOCTOU in nohz idle time fetch
>       sched/idle: Handle offlining first in idle loop
>       sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
>       sched/cputime: Correctly support generic vtime idle time
>       powerpc/time: Prepare to stop elapsing in dynticks-idle
>       s390/time: Prepare to stop elapsing in dynticks-idle
>       tick/sched: Unify idle cputime accounting
>       tick/sched: Remove nohz disabled special case in cputime fetch
>       tick/sched: Move dyntick-idle cputime accounting to cputime code
>       tick/sched: Remove unused fields
>       tick/sched: Account tickless idle cputime only when tick is stopped
>       tick/sched: Consolidate idle time fetching APIs
>       sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
>       sched/cputime: Handle idle irqtime gracefully
>       sched/cputime: Handle dyntick-idle steal time correctly
> 
>  arch/powerpc/kernel/time.c         |  41 +++++
>  arch/s390/include/asm/idle.h       |   2 +
>  arch/s390/kernel/idle.c            |   5 +-
>  arch/s390/kernel/vtime.c           |  75 ++++++++-
>  drivers/cpufreq/cpufreq.c          |  29 +---
>  drivers/cpufreq/cpufreq_governor.c |   6 +-
>  drivers/macintosh/rack-meter.c     |   2 +-
>  fs/proc/stat.c                     |  40 +----
>  fs/proc/uptime.c                   |   8 +-
>  include/linux/kernel_stat.h        |  76 +++++++--
>  include/linux/tick.h               |   4 -
>  include/linux/vtime.h              |  22 ++-
>  kernel/rcu/tree.c                  |   9 +-
>  kernel/rcu/tree_stall.h            |   7 +-
>  kernel/sched/core.c                |   6 +-
>  kernel/sched/cputime.c             | 308 +++++++++++++++++++++++++++++++------
>  kernel/sched/idle.c                |  13 +-
>  kernel/time/tick-sched.c           | 212 ++++++-------------------
>  kernel/time/tick-sched.h           |  12 --
>  kernel/time/timer_list.c           |   6 +-
>  scripts/gdb/linux/timerlist.py     |   4 -
>  21 files changed, 529 insertions(+), 358 deletions(-)

-- 
Frederic Weisbecker
SUSE Labs

