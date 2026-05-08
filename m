Return-Path: <linuxppc-dev+bounces-20610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34512CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 13:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBqQy1mqLz2xdb;
	Fri, 08 May 2026 23:17:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778246234;
	cv=none; b=dKuD0bz89ZCIB+EVYCwRfCG8ITH+1A+J8ZvdkAtrUwaPH/o6CjfN73cUyKLHIV7yj7II20ph2lvULeEscz7hQXg/ms7G15CfUoCA2IFL/4zQU34kqRDKiLrlwAszDZyC2Sd6zXQE4BwpC082p2ZLyqa/VDpKI5HESlfzWJi24RHQkMip/fIZlJmPsBREiE60iTEJhrj2xElWjXnqgobdwN0U7iQ1o82xOdAcsBOKIpThzThTK58JcrVqfHbgzYB2m6UWNNAHU2uu2Cctj4XFrf7UyZZdS66Hd5r9CS5AFCV24kowAJm656fxmuc/wE448X6IVh0FSA+TPsOxpHKNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778246234; c=relaxed/relaxed;
	bh=KSR3buBUoGn7h6QUFUsLNU/EqeWQM09a7paH2USs2Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfLLVWFKt9xleLo0U1WKHFmVBkStTYXh+5kpsY/8+aBz0B2Wpo7VFciTMJLKuW5UA4KzjRId32cZ8YUTQtGXwopND0Iplgm5Ov45RAdRmmksBz9hJKYWIwPwQMdW6j3r9KIC5UUm7q2X8q+hukVpTDZ0Y8Gk1FZLYSeSXHf2PTLtw1++nhjDkxp/blIRxUUUOH9bbuZBiCmA48F5/yMW7O/wTsCN0TeiC6/FMPZMBjxWrWUkOzQax9+xmRYPBw0zTnqokCcyQ0enM3juoc0Bh9qZCoksw9on+XUdGLTjcOni31u+CrOAkJ1EfRP2l4bazsiFAvhyPYowMCMQ9aUmSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGP5FK9r; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGP5FK9r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBqQs1gygz2xQC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 23:17:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DBA24437E8;
	Fri,  8 May 2026 13:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B3C2BCB0;
	Fri,  8 May 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246226;
	bh=Vta7hllmwFIumsR7obeWKsvWVRLZq990abYtI1WVcNk=;
	h=From:To:Cc:Subject:Date:From;
	b=MGP5FK9r9QEOy860Im4ejrteL4FwEhVVu14vipu9Z+cC0I316uNQwgOy0hPfLaVhY
	 zQhpMRfoyyqaX7J92xkQ+LLBJPltZMpkOyxK8CW1LDab4vsyBS15jl9dAajLFcYQ+d
	 kK5YF3Hom2fADVLNDaSgsqvXA0DaQeukbeZ8GVvmIZvU7rBkXPEHxGdUBBENsvirza
	 ARd5MU8U0tleul+fXPjitjj+XOBfZwXLfuLAE6K8/NWnjBl5m1NH7Ymk0sokSPUqTJ
	 I2DswfY8YWOGs4TB0lt1eaRgSZBvqBl+VOwwXu2m22zdvgatVVuQ0wwR7N55pFdd2N
	 d+E2RmzRgmsqQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ben Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Sashiko@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 00/15 v4] tick/sched: Refactor idle cputime accounting
Date: Fri,  8 May 2026 15:16:32 +0200
Message-ID: <20260508131647.43868-1-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Changes since v3 (among which a lot of relevant reviews from Sashiko):

- Add new tags

- Rebase on latest -rc1

- Add "tick/sched: Fix TOCTOU in nohz idle time fetch" (Sashiko)

- Fix buggy state refetch in kcpustat_cpu_fetch_vtime() (Sashiko)

- Fix build issue on powerpc (Christophe Leroy)

- Fix s390 lost steal time occuring on idle IRQs (call vtime_flush() on
  vtime_account_hardirq() and vtime_account_softirq()) (Sashiko)

- Fix build issue on s390

- Fix uninitialized idle_sleeptime_seq (Sashiko)

- Fix irqtime being disabled or enabled in the middle of an idle IRQ
  (Sashiko)
  
- Fix tick restart and then restop in the same idle loop (Sashiko)

- Fix "sched/cputime: Handle idle irqtime gracefully" changelog (Sashiko)

- Fix idle steal time substracted from the wrong index between idle and
  iowait kcpustat. (Sashiko)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core-v4

HEAD: e64ba052ce04e363ff76d3cb8bedc5f812188acb
Thanks,
	Frederic
---

Frederic Weisbecker (15):
      tick/sched: Fix TOCTOU in nohz idle time fetch
      sched/idle: Handle offlining first in idle loop
      sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
      sched/cputime: Correctly support generic vtime idle time
      powerpc/time: Prepare to stop elapsing in dynticks-idle
      s390/time: Prepare to stop elapsing in dynticks-idle
      tick/sched: Unify idle cputime accounting
      tick/sched: Remove nohz disabled special case in cputime fetch
      tick/sched: Move dyntick-idle cputime accounting to cputime code
      tick/sched: Remove unused fields
      tick/sched: Account tickless idle cputime only when tick is stopped
      tick/sched: Consolidate idle time fetching APIs
      sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
      sched/cputime: Handle idle irqtime gracefully
      sched/cputime: Handle dyntick-idle steal time correctly

 arch/powerpc/kernel/time.c         |  41 +++++
 arch/s390/include/asm/idle.h       |   2 +
 arch/s390/kernel/idle.c            |   5 +-
 arch/s390/kernel/vtime.c           |  75 ++++++++-
 drivers/cpufreq/cpufreq.c          |  29 +---
 drivers/cpufreq/cpufreq_governor.c |   6 +-
 drivers/macintosh/rack-meter.c     |   2 +-
 fs/proc/stat.c                     |  40 +----
 fs/proc/uptime.c                   |   8 +-
 include/linux/kernel_stat.h        |  76 +++++++--
 include/linux/tick.h               |   4 -
 include/linux/vtime.h              |  22 ++-
 kernel/rcu/tree.c                  |   9 +-
 kernel/rcu/tree_stall.h            |   7 +-
 kernel/sched/core.c                |   6 +-
 kernel/sched/cputime.c             | 308 +++++++++++++++++++++++++++++++------
 kernel/sched/idle.c                |  13 +-
 kernel/time/tick-sched.c           | 212 ++++++-------------------
 kernel/time/tick-sched.h           |  12 --
 kernel/time/timer_list.c           |   6 +-
 scripts/gdb/linux/timerlist.py     |   4 -
 21 files changed, 529 insertions(+), 358 deletions(-)

