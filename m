Return-Path: <linuxppc-dev+bounces-16681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB45EE20AA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:24:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xDW6Zv8z3blq;
	Sat, 07 Feb 2026 01:24:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387867;
	cv=none; b=TZbpFP2fovHB9Z7q7b3gznevJrNvYb5Q0HAFYGgyd/qT5Lfj0mLPxVFjy6Ui9BMUH56Ff2WD/lfwuBRa5Bu++eGRD3NrQGEhSK9pn7V10lWqSG/oz0AHAWnj3yUBmM/9EzT72vgRMirE7Fo46Ad4yx7ZONo6jy93EXeT0Jms8TmcersYQl6NJhuAcf5oj1yHU1iN3lHqo8tbR4cZ5GPBLO0GCdO5Bbx5/X/uYWBWsGpY+wBppiypunvrzQkNt6Ih5kJSTXYSRWjUQB01a7xqYjyC75RkOodDpx16jNGqj1iKS19JabRNCD7/Gy30CVGu5ItTwuuYYupTWzurnUllOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387867; c=relaxed/relaxed;
	bh=NtRe+jJDkvI/SHHrYt64WzIZVtmqwSweWFz344IPqcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHTvMLthDxbRb5z6oDhc1jalY6+nB36br6axFrdiRb4GJ+J7XFVOdO6NXadx1TgEaHCr79oJOm9sNNy7OLt6Odx3VobajuY8AF/xv8MovyM4i7Jr+3JTdVI50SDM7GJkp5q1ExLA+SMeJDnsYI0tNEmQpfQ8YxRSD82p0lKgczfliOBGcoKwLgYjy77H6PxeBHzb+6os0d5wwNPUvZxTFT2t1TfAqAwPjWBcXQKKnpHk+EbYV1tTd0YFb9LAwWNqGHSVjGe3XY91KcRZ7ZTaVfbFcQb6hdU8gRKiCmG/4CpbIj2uBMT+XZXzJ2omCjlj+rRYKMR6LteqkiV5Md0nEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eyi386IP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eyi386IP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xDW0dnWz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:24:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EA2160051;
	Fri,  6 Feb 2026 14:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A780C2BC87;
	Fri,  6 Feb 2026 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387864;
	bh=YMOHPjr/Wf/QWbFo/ZB5fJoqYZ8Q3rjy/SRpdY/7S30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eyi386IPJs0ew93oNS6xfd09R1UlajX6a5KrKlsJtSf9mcz+6T9YaurId5Htp1MpM
	 WfPcsKebHrzcgsjgE0wdSaJxcL5U22ixrgJXmJOUk4kOTrUiLwZqSH2+HSa1hX39PA
	 TZnUSqQFUpP5k0z9UYebJ5CVWrFmZFi7DO3gefzrpsC0SOp2hl646yWhU4rhIC9f9k
	 skSWd04NnZEEVztfQm/uZZ6OFk3onL1UtKxMAt694F/qSu98hH8tX/Hpfh1UrZjWaa
	 rCknHJn0J9KvsyBu2m3Jgv0rO4T+0JHWddOoF3tCQ1uaB32OFIQCHv73caXhwphMV0
	 UHfCvUQvH8WUw==
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
	linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 11/15] tick/sched: Account tickless idle cputime only when tick is stopped
Date: Fri,  6 Feb 2026 15:22:41 +0100
Message-ID: <20260206142245.58987-12-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260206142245.58987-1-frederic@kernel.org>
References: <20260206142245.58987-1-frederic@kernel.org>
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

There is no real point in switching to dyntick-idle cputime accounting
mode if the tick is not actually stopped. This just adds overhead,
notably fetching the GTOD, on each idle exit and each idle IRQ entry for
no reason during short idle trips.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 44 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index aa36c8d218e2..bceed0c4dd2c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1141,8 +1141,10 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
 
-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			kcpustat_dyntick_start(ts->idle_entrytime);
 			nohz_balance_enter_idle(cpu);
+		}
 	} else {
 		tick_nohz_retain_tick(ts);
 	}
@@ -1184,7 +1186,6 @@ void tick_nohz_idle_enter(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
 	ts->idle_entrytime = ktime_get();
-	kcpustat_dyntick_start(ts->idle_entrytime);
 	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
@@ -1214,9 +1215,10 @@ void tick_nohz_irq_exit(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
-		ts->idle_entrytime = ktime_get();
-		kcpustat_irq_exit(ts->idle_entrytime);
 		tick_nohz_clock_sleep(ts);
+		ts->idle_entrytime = ktime_get();
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+			kcpustat_irq_exit(ts->idle_entrytime);
 	} else {
 		tick_nohz_full_update_tick(ts);
 	}
@@ -1317,8 +1319,11 @@ void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+		ktime_t now = ktime_get();
+		kcpustat_dyntick_stop(now);
+		tick_nohz_restart_sched_tick(ts, now);
+	}
 }
 
 static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
@@ -1348,7 +1353,6 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 void tick_nohz_idle_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	bool idle_active, tick_stopped;
 	ktime_t now;
 
 	local_irq_disable();
@@ -1357,18 +1361,13 @@ void tick_nohz_idle_exit(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 
 	tick_sched_flag_clear(ts, TS_FLAG_INIDLE);
-	idle_active = tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE);
-	tick_stopped = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	tick_nohz_clock_wakeup(ts);
 
-	if (idle_active || tick_stopped)
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		now = ktime_get();
-
-	if (idle_active)
-		tick_nohz_clock_wakeup(ts);
-
-	if (tick_stopped)
+		kcpustat_dyntick_stop(now);
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop(now);
+	}
 
 	local_irq_enable();
 }
@@ -1422,15 +1421,13 @@ static inline void tick_nohz_irq_enter(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
 
-	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
+	tick_nohz_clock_wakeup(ts);
+
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		return;
 
 	now = ktime_get();
-
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
-		tick_nohz_clock_wakeup(ts);
-		kcpustat_irq_enter(now);
-	}
+	kcpustat_irq_enter(now);
 
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
@@ -1439,8 +1436,7 @@ static inline void tick_nohz_irq_enter(void)
 	 * rare case (typically stop machine). So we must make sure we have a
 	 * last resort.
 	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_update_jiffies(now);
+	tick_nohz_update_jiffies(now);
 }
 
 #else
-- 
2.51.1


