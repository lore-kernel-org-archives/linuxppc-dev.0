Return-Path: <linuxppc-dev+bounces-18720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF2AF54ACB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:53:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgChM4B5nz2yj3;
	Wed, 25 Mar 2026 01:53:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774363987;
	cv=none; b=iY3fRnh8gj0kiigyjVRWBOFPgkRvbaitMC8hKOPC0vRXW+fdTQxbUzuJ8NwSSOc9MAwQNRrCwTyGF/lvxkjYlXDIdGMc7TgvQv2V5mIKZYseDpGHZevx7hwjoF86rSyZP2A7zNSd0NP5U7L5zFlMayFJPq3e3nH7qgBf4tK/v68C5V/qi7/XbCdhF27MBoQyZo+iv8f8VtbxafHVEiaGXqnfJ3HAbIBaR/sCGwAXbScbSH9lQ4KS6Dw1kzuKYbIiySMZZLMlYTFDeyQ+OkJFngyy4xGuyrERgMtqwuPpJrETfCJNSMyMw2OSQlyqMXcirq9fQ1x97kM0WuDt11+5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774363987; c=relaxed/relaxed;
	bh=dQTiWXUntb2hK4ta6L78SB6jSNbyNk5pbSwlHo5nSq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHRL62058wtR5q5rcToIArx5E3+c5n8u8zeDbWQl1uNMptMaXuzJWwSvmhza4Tkm6/g+RMgqyhwcKXP0vFNSs6FvW4rCkTEU3dILQnPMKYMxzaUduMPH6ngQg1LvxtPDQ0nB5FDJkIfLb+BrrGku3zAdEjL5k3xKEK/lvA/2cEWoIlRCXkFxgZmAfcWbWuUeuu7eA09xGXP1HOs/iYXNcQH3ceK0m+3LiCol6VrEfFfIKZENGHn7hALFQ2lLdC9QpEZ74NQ9pCdmuh+fMkQQwfTWFX3YR3RoEr7WJah3enDgmGKSGVzd/5n/6LNrdfvZ0pqW3MrGa8Un/s0KHJFG9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vM6QVJSx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vM6QVJSx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgChL3ZwBz2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 01:53:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D8FBE41A6D;
	Tue, 24 Mar 2026 14:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECC8C19424;
	Tue, 24 Mar 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774363983;
	bh=5PsP7SJiyg6c43hMnhXO1J/nNC4IiO59ALlt88PNREE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vM6QVJSxgx96Yi3fdbsB8ETxK9h5VZ8zZV42xFiAKj4E7VeW8F3aHlbtIXjlWVx5m
	 9MvUIiFq7dLq85ZKui4M+h2uhxY/4j0kMtJn+npADLp35mR317Q51pVYGyhhf6ucJH
	 BFt7NDLckBbS8fpsfTZg/aAnGstXVSIyCtHatX1MYLrHav4PMlUTjJjgaQa98ypH6Q
	 00d8W2DzEFpXevZH4N4B6h6ymHlLO6o2GyvH7TENhZ58gvEy0ucrpBU5JhnABy8nxB
	 U96CPZWqkSd0iD24e01QU5qiJlpu2r1SDDxxBJCl1XyXTJqv+KQe3zSvXbv0j/OaRk
	 DNpKNXyQaYRBw==
Date: Tue, 24 Mar 2026 15:53:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
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
Subject: Re: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time
 correctly
Message-ID: <acKlTdXRUMTXBk1X@localhost.localdomain>
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-16-frederic@kernel.org>
 <be30e259-a690-4530-996c-0c092833bb66@linux.ibm.com>
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
In-Reply-To: <be30e259-a690-4530-996c-0c092833bb66@linux.ibm.com>

Le Tue, Mar 03, 2026 at 04:47:45PM +0530, Shrikanth Hegde a écrit :
> 
> 
> On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> > The dyntick-idle steal time is currently accounted when the tick
> > restarts but the stolen idle time is not substracted from the idle time
> > that was already accounted. This is to avoid observing the idle time
> > going backward as the dyntick-idle cputime accessors can't reliably know
> > in advance the stolen idle time.
> > 
> > In order to maintain a forward progressing idle cputime while
> > substracting idle steal time from it, keep track of the previously
> > accounted idle stolen time and substract it from _later_ idle cputime
> > accounting.
> > 
> 
> s/substract/subtract ?

Right.

> 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   include/linux/kernel_stat.h |  1 +
> >   kernel/sched/cputime.c      | 21 +++++++++++++++------
> >   2 files changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> > index 512104b0ff49..24a54a6151ba 100644
> > --- a/include/linux/kernel_stat.h
> > +++ b/include/linux/kernel_stat.h
> > @@ -39,6 +39,7 @@ struct kernel_cpustat {
> >   	bool		idle_elapse;
> >   	seqcount_t	idle_sleeptime_seq;
> >   	u64		idle_entrytime;
> > +	u64		idle_stealtime;
> >   #endif
> >   	u64		cpustat[NR_STATS];
> >   };
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 92fa2f037b6e..7e79288eb327 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -424,19 +424,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
> >   static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
> >   {
> >   	u64 *cpustat = kc->cpustat;
> > -	u64 delta;
> > +	u64 delta, steal, steal_delta;
> >   	if (!kc->idle_elapse)
> >   		return;
> >   	delta = now - kc->idle_entrytime;
> > +	steal = steal_account_process_time(delta);
> >   	write_seqcount_begin(&kc->idle_sleeptime_seq);
> > +	steal_delta = min_t(u64, kc->idle_stealtime, delta);
> > +	delta -= steal_delta;
> 
> I didn;t get this logic. Why do we need idle_stealtime?
> 
> Lets say 10ms was steal time and 50ms was delta. but idle_stealtime is
> sum of past accumulated steal time. we only need to subtract steal time there no?
> 
> Shouldn't this be delta -= steal ?

That would be a risk to observe backward idle accounting:

Time        CPU 0                                  CPU 1
----        -----                                  -----
0 sec       kcpustat_idle_start()
            <#VMEXIT>
            ...
1 sec       </#VMEXIT>                             
            arch_cpu_idle()                        // returns 2
2 sec       kcpustat_idle_stop()                   kcpustat_field(CPUTIME_IDLE, 0)
               cpustat[CPUTIME_IDLE] = 2 - 1
                                                   // returns 1
                                                   kcpustat_field(CPUTIME_IDLE, 0)

We could instead read remotely the paravirt clock, but then
steal_account_process_time() would need to always hold the ->idle_sleeptime_seq,
though it should happen to work without given the ordering.

Anyway to avoid any surprise I accumulate the steal time of an idle cycle to be
substracted on the next idle cycle.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

