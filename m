Return-Path: <linuxppc-dev+bounces-16670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA243EE20AE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xBs34Jjz2xqk;
	Sat, 07 Feb 2026 01:23:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387781;
	cv=none; b=DRvPRJ8JcuzyFx+gCMgMQN1GKOVjaGK4My7zdXWfXnoPZ/9wV9FLhJzhKJM336zzN7UiGkrbYhuNpSo0klWoh6jZexscWCJjG4U2c9IHTyEErt9vVApdm0axT0HKlBHDzZwWl85VfESMETMRLcLRJxzeZnc4zocAUrMuBuspIgWAN8EBfgGGavAW1cAae1XXCQu6tQu8t9fERbyRFq3jw3YsZbDXVfrfXMJA3HsDm6FBJ3S1guZp0Aop5Wnmj0p8HQ2dUBidRz4ZxrZlaxdVCI+9YqvU2lXhE/Y7JZdOBlZOr5PG6wLSJNxB4JQwuVV9f7dBh7aq0kKRAlhHi575/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387781; c=relaxed/relaxed;
	bh=eA06/bgMGsjzsRVJm+XVy8RQWyEcFnnv4pSzAu4dKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=od1LLpcMP59bI/JYJAksZfjo3uw8quNGyTZyd5hIYhdfI954+CUTbdyLy4AeZOch9AgsmGygwjsKQdtZMFeyM0Af0xaTfRhUotkuZ5kYT1v9f6ussGzYhzuGANBWVjSJFOf1NcakQFwtfTmJpHHcWM1RcOl+mvJ/QiVr/cFuYn/JscT9yadgN2ZrpNpuOjU7O/g5AT6NqSJRGRSvXGKqFXRPUNyVED4jPthAmREf2zT0juY64Am0Lr5eW5C17fmowTq0fEoWJwOUApti7MBgAt1LooUUYqCYFSfeZbwBVQIjoK+oZI7/n99JVfInVrq+36NbdC96aRT8Hwwz/84+vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gHOkkP+g; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gHOkkP+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xBq4n9pz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:22:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6F59540944;
	Fri,  6 Feb 2026 14:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D4C116C6;
	Fri,  6 Feb 2026 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387777;
	bh=5RNRg1BFmFbwFXPge2vBQ/jTNMfqGWngL8N/C51PA/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gHOkkP+gSugbWlo8bJ3uh+YpAx9mDAXAt1cR8dVvhEzYIgOtVBeZsQp64HqmFTY9i
	 YBBA5G/vgdPOgEYP7STZwjGxeEg/GvrZJ3LFK02feY+CrMC99Kh5eSbysAP37BZYwz
	 ypvjlwZSiruBiiudWtg4RNrxhfrSiT8T8WKOZ85y+nObwyke/zdwbm56GMuw17QM0c
	 98g6uujXQlFBaoB6dgRUer8icV5B5JOP6pGn7iq3h4W1M+A0t8ciXwxHh2ptcH5XZP
	 jTswPP1hbzx0c0qPUOY7y1auZxM+C4s+7fvbqq5GcjikUbtO7fRRUXurwwWg+ix21O
	 wW6HZLFnaK26g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-pm@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 00/15 v2] tick/sched: Refactor idle cputime accounting
Date: Fri,  6 Feb 2026 15:22:30 +0100
Message-ID: <20260206142245.58987-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
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
Content-Transfer-Encoding: 8bit

Hi,

After the issue reported here:

        https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/

It occurs that the idle cputime accounting is a big mess that
accumulates within two concurrent statistics, each having their own
shortcomings:

* The accounting for online CPUs which is based on the delta between
  tick_nohz_start_idle() and tick_nohz_stop_idle().

  Pros:
       - Works when the tick is off

       - Has nsecs granularity

  Cons:
       - Account idle steal time but doesn't substract it from idle
         cputime.

       - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
         the IRQ time is simply ignored when
         CONFIG_IRQ_TIME_ACCOUNTING=n

       - The windows between 1) idle task scheduling and the first call
         to tick_nohz_start_idle() and 2) idle task between the last
         tick_nohz_stop_idle() and the rest of the idle time are
         blindspots wrt. cputime accounting (though mostly insignificant
         amount)

       - Relies on private fields outside of kernel stats, with specific
         accessors.

* The accounting for offline CPUs which is based on ticks and the
  jiffies delta during which the tick was stopped.

  Pros:
       - Handles steal time correctly

       - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
         CONFIG_IRQ_TIME_ACCOUNTING=n correctly.

       - Handles the whole idle task

       - Accounts directly to kernel stats, without midlayer accumulator.

   Cons:
       - Doesn't elapse when the tick is off, which doesn't make it
         suitable for online CPUs.

       - Has TICK_NSEC granularity (jiffies)

       - Needs to track the dyntick-idle ticks that were accounted and
         substract them from the total jiffies time spent while the tick
         was stopped. This is an ugly workaround.

Having two different accounting for a single context is not the only
problem: since those accountings are of different natures, it is
possible to observe the global idle time going backward after a CPU goes
offline, as reported by Xin Zhao.

Clean up the situation with introducing a hybrid approach that stays
coherent, fixes the backward jumps and works for both online and offline
CPUs:

* Tick based or native vtime accounting operate before the tick is
  stopped and resumes once the tick is restarted.

* When the idle loop starts, switch to dynticks-idle accounting as is
  done currently, except that the statistics accumulate directly to the
  relevant kernel stat fields.

* Private dyntick cputime accounting fields are removed.

* Works on both online and offline case.

* Move most of the relevant code to the common sched/cputime subsystem

* Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
  dynticks-idle accounting still elapses while on IRQs.

* Correctly substract idle steal cputime from idle time

Changes since v1:

- Fix deadlock involving double seq count lock on idle

- Fix build breakage on powerpc

- Fix build breakage on s390 (Heiko)

- Fix broken sysfs s390 idle time file (Heiko)

- Convert most ktime usage here into u64 (Peterz)

- Add missing (or too implicit) <linux/sched/clock.h> (Peterz)

- Fix whole idle time acccounting breakage due to missing TS_FLAG_ set
  on idle entry (Shrikanth Hegde)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core-v2

HEAD: 21458b98c80a0567d48131240317b7b73ba34c3c
Thanks,
	Frederic
---

Frederic Weisbecker (15):
      sched/idle: Handle offlining first in idle loop
      sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
      sched/cputime: Correctly support generic vtime idle time
      powerpc/time: Prepare to stop elapsing in dynticks-idle
      s390/time: Prepare to stop elapsing in dynticks-idle
      tick/sched: Unify idle cputime accounting
      cpufreq: ondemand: Simplify idle cputime granularity test
      tick/sched: Remove nohz disabled special case in cputime fetch
      tick/sched: Move dyntick-idle cputime accounting to cputime code
      tick/sched: Remove unused fields
      tick/sched: Account tickless idle cputime only when tick is stopped
      tick/sched: Consolidate idle time fetching APIs
      sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
      sched/cputime: Handle idle irqtime gracefully
      sched/cputime: Handle dyntick-idle steal time correctly

 arch/powerpc/kernel/time.c         |  41 +++++
 arch/s390/include/asm/idle.h       |  14 +-
 arch/s390/kernel/idle.c            |  19 ++-
 arch/s390/kernel/vtime.c           |  57 ++++++-
 drivers/cpufreq/cpufreq.c          |  29 +---
 drivers/cpufreq/cpufreq_governor.c |   6 +-
 drivers/cpufreq/cpufreq_ondemand.c |   7 +-
 drivers/macintosh/rack-meter.c     |   2 +-
 fs/proc/stat.c                     |  40 +----
 fs/proc/uptime.c                   |   8 +-
 include/linux/kernel_stat.h        |  76 ++++++++--
 include/linux/tick.h               |   6 +-
 include/linux/vtime.h              |  22 ++-
 kernel/rcu/tree.c                  |   9 +-
 kernel/rcu/tree_stall.h            |   7 +-
 kernel/sched/cputime.c             | 304 +++++++++++++++++++++++++++++++------
 kernel/sched/idle.c                |  13 +-
 kernel/sched/sched.h               |   1 +
 kernel/time/hrtimer.c              |   2 +-
 kernel/time/tick-internal.h        |   2 -
 kernel/time/tick-sched.c           | 210 ++++++-------------------
 kernel/time/tick-sched.h           |  12 --
 kernel/time/timer.c                |   2 +-
 kernel/time/timer_list.c           |   6 +-
 scripts/gdb/linux/timerlist.py     |   4 -
 25 files changed, 525 insertions(+), 374 deletions(-)

