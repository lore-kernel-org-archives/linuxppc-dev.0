Return-Path: <linuxppc-dev+bounces-19085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF644109B462
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTDT3Bcbz2yfl;
	Wed, 01 Apr 2026 00:17:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963033;
	cv=none; b=Wz+qjYjHasb7Zy21SI8EpIotxho/c9HH2quv+Ww6ipMgQ3WjLAanIGCG+nPAXWJrLPbhyUFN/R53zyUwj+bCeuDonzk0OPWxjTkLmX5s3Oz+Z0+THhz+zY6xDUdyGRvqPvscwlZKywnFvMIH3aN7bIGxADQmH/f6pmiWtixGS5vT3iAyt1eqdceIL3wbU8NokgieIqxgQ2NuHvPVo8TXGFL6Gdq+87SCznWyLwwmBYYyCI9VoasL3G22NN81vllFKqwUJfP8JEoOHvxZ+5zrVGYAPMgYnX+bFH34kQET8/IYrUYOnhuMaN3IEDlFLqyJJZCTY5coBiQefaGtPnWcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963033; c=relaxed/relaxed;
	bh=6RGMHeFO1V15n+G7RgAQJvta3XjFaEIddwAG7yQBIpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSX+MOUnzOOwj31H3+z5rtP+WqJaiO20NHGiZ0IIXtRvaoTdZSEpDGVFHG+szj5e5s3jTqCIXm+u0q0dKjg0CPUvCQ9VB/HBZCWbJSTxmre0TsihWu7/57YbFU6Kn2pQbwVmvjENs3WKyJuptwMDYeEuzhf96DU3Mt6dKDvFwiClm9VK5pBFFTitBmTeySxG7XBl99cmJUAAd6Ga62pfWO4wNj6jt50JHyU5RitW/JC8xjsUaKGFOET9FaeMz8lGwrXmrwD1r/XdouuUwrgqh3o8YqCz8r5fqsZvIxWhIBS1QF9Uf3mI+8ghfGtTbCYpwG5NLdvv1g7kCEqFF0WG1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QOr8z5aO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QOr8z5aO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTDS3wgZz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:17:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 74369436D4;
	Tue, 31 Mar 2026 13:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECAEC19423;
	Tue, 31 Mar 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963030;
	bh=bK9FrHwYdtzlfjtR+gYpB517UvY6FDy8GPtD0U1/TCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOr8z5aObamx4kProSnztxVwdQlHn9xLwz3QWRSh54AQnpHHqbKZLhGNZ8tOlSwht
	 aJGFYaGh7Q8hKi6bouEvSeeWyEytZ8tkdEXdbWJeS17SWm9fmh2LJgL2pGW/wVorf+
	 YdlB4Zfd9HeHHgTa5TyngS/chK8jPejZkVxL69tKzNc7I0fQRRml/6UTYbWisjBoS1
	 xNp9oJkag50xrbV02FIhJ324cQz44XqfTCYVw9H+j3NYGcZWEGWNYp/YjAwqdhjjMp
	 1LF9/OTtA4QLU8bI0+lmlPgD8uU4C7vLjIiylBJx9BlT/+3U2dCvQd0TySn++3HPIo
	 fCmn8xbE6Rdkg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/14] s390/time: Prepare to stop elapsing in dynticks-idle
Date: Tue, 31 Mar 2026 15:16:13 +0200
Message-ID: <20260331131622.30505-6-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131622.30505-1-frederic@kernel.org>
References: <20260331131622.30505-1-frederic@kernel.org>
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

Currently the tick subsystem stores the idle cputime accounting in
private fields, allowing cohabitation with architecture idle vtime
accounting. The former is fetched on online CPUs, the latter on offline
CPUs.

For consolidation purpose, architecture vtime accounting will continue
to account the cputime but will make a break when the idle tick is
stopped. The dyntick cputime accounting will then be relayed by the tick
subsystem so that the idle cputime is still seen advancing coherently
even when the tick isn't there to flush the idle vtime.

Prepare for that and introduce three new APIs which will be used in
subsequent patches:

_ vtime_dynticks_start() is deemed to be called when idle enters in
  dyntick mode. The idle cputime that elapsed so far is accumulated
  and accounted. Also idle time accounting is ignored.

- vtime_dynticks_stop() is deemed to be called when idle exits from
  dyntick mode. The vtime entry clocks are fast-forward to current time
  so that idle accounting restarts elapsing from now. Also idle time
  accounting is resumed.

- vtime_reset() is deemed to be called from dynticks idle IRQ entry to
  fast-forward the clock to current time so that the IRQ time is still
  accounted by vtime while nohz cputime is paused.

Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
accounting twice the idle cputime, along with nohz accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/s390/include/asm/idle.h |  2 ++
 arch/s390/kernel/idle.c      |  5 +++-
 arch/s390/kernel/vtime.c     | 57 ++++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 32536ee34aa0..e4ad09a22400 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -8,10 +8,12 @@
 #ifndef _S390_IDLE_H
 #define _S390_IDLE_H
 
+#include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
 
 struct s390_idle_data {
+	bool	      idle_dyntick;
 	unsigned long idle_count;
 	unsigned long idle_time;
 	unsigned long clock_idle_enter;
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 1f1b06b6b4ef..4685d7c5bc51 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -31,7 +31,10 @@ void account_idle_time_irq(void)
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	__atomic64_add(idle_time, &idle->idle_time);
 	__atomic64_add_const(1, &idle->idle_count);
-	account_idle_time(cputime_to_nsecs(idle_time));
+
+	/* Dyntick idle time accounted by nohz/scheduler */
+	if (!idle->idle_dyntick)
+		account_idle_time(cputime_to_nsecs(idle_time));
 }
 
 void noinstr arch_cpu_idle(void)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index bf48744d0912..b1c7700d082c 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -17,6 +17,7 @@
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
+#include <asm/idle.h>
 #include <asm/smp.h>
 
 #include "entry.h"
@@ -110,6 +111,16 @@ static void account_system_index_scaled(struct task_struct *p, u64 cputime,
 	account_system_index_time(p, cputime_to_nsecs(cputime), index);
 }
 
+static inline void vtime_reset_last_update(struct lowcore *lc)
+{
+	asm volatile(
+		"	stpt	%0\n"	/* Store current cpu timer value */
+		"	stckf	%1"	/* Store current tod clock value */
+		: "=Q" (lc->last_update_timer),
+		  "=Q" (lc->last_update_clock)
+		: : "cc");
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
@@ -121,12 +132,9 @@ static int do_account_vtime(struct task_struct *tsk)
 
 	timer = lc->last_update_timer;
 	clock = lc->last_update_clock;
-	asm volatile(
-		"	stpt	%0\n"	/* Store current cpu timer value */
-		"	stckf	%1"	/* Store current tod clock value */
-		: "=Q" (lc->last_update_timer),
-		  "=Q" (lc->last_update_clock)
-		: : "cc");
+
+	vtime_reset_last_update(lc);
+
 	clock = lc->last_update_clock - clock;
 	timer -= lc->last_update_timer;
 
@@ -239,6 +247,43 @@ void vtime_account_hardirq(struct task_struct *tsk)
 	get_lowcore()->hardirq_timer += vtime_delta();
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+/**
+ * vtime_reset - Fast forward vtime entry clocks
+ *
+ * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
+ * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
+ */
+void vtime_reset(void)
+{
+	vtime_reset_last_update(get_lowcore());
+}
+
+/**
+ * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
+ *
+ * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
+ * is flushed and the tick subsystem takes over the idle cputime accounting.
+ */
+void vtime_dyntick_start(void)
+{
+	__this_cpu_write(s390_idle.idle_dyntick, true);
+	vtime_flush(current);
+}
+
+/**
+ * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
+ *
+ * Called when idle exits from dyntick mode. The vtime entry clocks are
+ * fast-forward to current time and idle accounting resumes.
+ */
+void vtime_dyntick_stop(void)
+{
+	vtime_reset_last_update(get_lowcore());
+	__this_cpu_write(s390_idle.idle_dyntick, false);
+}
+#endif /* CONFIG_NO_HZ_COMMON */
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
-- 
2.53.0


