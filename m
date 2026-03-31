Return-Path: <linuxppc-dev+bounces-19088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED118109B462
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTDv4sC7z2yjV;
	Wed, 01 Apr 2026 00:17:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963055;
	cv=none; b=A+/N0ixEW7452qT+0XJQMMxMeH5LPOPQ9SE6l+9QFR5nXK9mGF0o+ORozBpw6CbqN7h9Iueu3lnPkpvUhs3XjysLdKkvvGO/AqtAqaBJGrZxkoFFm+xgYIbOh9uq1riB5DioWMwaJDN8jR6zQEsX0vd44amDbFPN6xlOuAR2JQz1vdPi7qYIjxF5yHu3OXUWhjHzJds8zOOUuCsg8WFpPj6Gmz8JYstdOXVTg/7RBH9s6lrhkO0kdIPAUGYWifRJ8cCjavpH2kgBHslzlXG/cT+BiapB5Z0jBdyztZpozRqeqajGXlNPS4sj01bZfY54k3Lw9YLHXnsKMQt5UB5dmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963055; c=relaxed/relaxed;
	bh=wqVFAkxJs3l7xNt/BRJmr1B0U/i2GFKFxv3Ix/i5mTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNCmM+iT2KBGG1TJL5XFcNAkl98UDwuUlZaNEYRrv0TvgdNzRb1twHOeUWKCblcLvaVFIlvpmZPycKowLoDmFGsMf4rV+LBGGjlsBg4/NVG547c0n0DzGVxHlRUZDwb0WUyvLAP5FtmIZLOW2wUDfRUuCcALtwaF6C9JXWb9KdNapMe4kcTQnxXB6k8emqjO1KdKl8H1UFXEEm4g8r0N7+GMYIKq3k66TrGAsU5K2VvUzJaql4kDPyTeL/2JkPHELwfymObNiloju3M0Mnrtp+XyVGXNbvdkj770MGyMHPFm/ptk/T9XWfO0UAMPx5UwGRFBMwHwzu+zHcaPyWTfkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IyNg2bGv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IyNg2bGv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTDt4sqYz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:17:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 995B36024D;
	Tue, 31 Mar 2026 13:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F3C2BCB1;
	Tue, 31 Mar 2026 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963052;
	bh=fNJ/wOIp6ZL2N5olFop6YLLXoKkblq8P3RraqV3W0Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyNg2bGvIjMzMN1RqgNoFjJLrp2MyjlWYmLE/RJmrZONO+C3e6m9GHSltE8x1RleT
	 I9GERowGleebRMcIPfR347ccW1ZqaI6NV0xFl6SNvrBoI1rMQUBCBysHIN8c4CenM4
	 sNmaIDsmg4ESgnFDDkqfOdV1k1AHIrF2j0Bi1L/dwKv7T89wq69iGCPwBvkVSnQZCc
	 0wDCfjiZQ42OSLDoKXcoTd79C+F7UlGBbXKYAViMmXLNv9fhX2DKHjp6KqtfkMl1fq
	 p0n9xtCxQIEjR3OYOwDRyDQ5UfkYWvJppIHfkpQeiRKj1PrVOpQ0ttoFUMrWKv77s9
	 D4tVDpWZW95zw==
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
Subject: [PATCH 08/14] tick/sched: Move dyntick-idle cputime accounting to cputime code
Date: Tue, 31 Mar 2026 15:16:16 +0200
Message-ID: <20260331131622.30505-9-frederic@kernel.org>
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

Although the dynticks-idle cputime accounting is necessarily tied to
the tick subsystem, the actual related accounting code has no business
residing there and should be part of the scheduler cputime code.

Move away the relevant pieces and state machine to where they belong.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/kernel_stat.h |  14 +++-
 kernel/sched/cputime.c      | 149 +++++++++++++++++++++++++++++++--
 kernel/time/tick-sched.c    | 162 +++++++-----------------------------
 3 files changed, 184 insertions(+), 141 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index ba65aad308a1..9343353ac7a3 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -35,9 +35,12 @@ enum cpu_usage_stat {
 
 struct kernel_cpustat {
 #ifdef CONFIG_NO_HZ_COMMON
-	int idle_dyntick;
+	bool		idle_dyntick;
+	bool		idle_elapse;
+	seqcount_t	idle_sleeptime_seq;
+	u64		idle_entrytime;
 #endif
-	u64 cpustat[NR_STATS];
+	u64		cpustat[NR_STATS];
 };
 
 struct kernel_stat {
@@ -103,8 +106,11 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-extern void kcpustat_dyntick_start(void);
-extern void kcpustat_dyntick_stop(void);
+extern void kcpustat_dyntick_start(u64 now);
+extern void kcpustat_dyntick_stop(u64 now);
+extern void kcpustat_irq_enter(u64 now);
+extern void kcpustat_irq_exit(u64 now);
+
 static inline bool kcpustat_idle_dyntick(void)
 {
 	return __this_cpu_read(kernel_cpustat.idle_dyntick);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 4934c537f5e3..4a259f2700a1 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,7 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/tsacct_kern.h>
 #include "sched.h"
@@ -420,22 +421,156 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_NO_HZ_COMMON
-void kcpustat_dyntick_start(void)
+static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
-	if (!vtime_generic_enabled_this_cpu()) {
-		vtime_dyntick_start();
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 1);
-	}
+	u64 *cpustat = kc->cpustat;
+	u64 delta;
+
+	if (!kc->idle_elapse)
+		return;
+
+	delta = now - kc->idle_entrytime;
+
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		cpustat[CPUTIME_IOWAIT] += delta;
+	else
+		cpustat[CPUTIME_IDLE] += delta;
+
+	kc->idle_entrytime = now;
+	kc->idle_elapse = false;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
 }
 
-void kcpustat_dyntick_stop(void)
+static void kcpustat_idle_start(struct kernel_cpustat *kc, u64 now)
 {
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	kc->idle_entrytime = now;
+	kc->idle_elapse = true;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+void kcpustat_dyntick_stop(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
 	if (!vtime_generic_enabled_this_cpu()) {
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 0);
+		WARN_ON_ONCE(!kc->idle_dyntick);
+		kcpustat_idle_stop(kc, now);
+		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
 }
+
+void kcpustat_dyntick_start(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu()) {
+		vtime_dyntick_start();
+		kc->idle_dyntick = true;
+		kcpustat_idle_start(kc, now);
+	}
+}
+
+void kcpustat_irq_enter(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_stop(kc, now);
+}
+
+void kcpustat_irq_exit(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_start(kc, now);
+}
+
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
+				 bool compute_delta, u64 *last_update_time)
+{
+	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	u64 *cpustat = kc->cpustat;
+	unsigned int seq;
+	ktime_t now;
+	u64 idle;
+
+	now = ktime_get();
+	if (last_update_time)
+		*last_update_time = ktime_to_us(now);
+
+	if (vtime_generic_enabled_cpu(cpu)) {
+		idle = kcpustat_field(idx, cpu);
+		goto to_us;
+	}
+
+	do {
+		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
+
+		if (kc->idle_elapse && compute_delta)
+			idle = cpustat[idx] + (now - kc->idle_entrytime);
+		else
+			idle = cpustat[idx];
+	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
+
+to_us:
+	do_div(idle, NSEC_PER_USEC);
+
+	return idle;
+}
+
+/**
+ * get_cpu_idle_time_us - get the total idle time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative idle time (since boot) for a given
+ * CPU, in microseconds. Note that this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
+ */
+u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
+				     !nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
+
+/**
+ * get_cpu_iowait_time_us - get the total iowait time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative iowait time (since boot) for a given
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
+ */
+u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
+				     nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
+
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6cd7777755dd..0da83d9b324a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -749,125 +749,6 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	touch_softlockup_watchdog_sched();
 }
 
-static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
-{
-	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	ktime_t delta;
-
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
-		return;
-
-	delta = ktime_sub(now, ts->idle_entrytime);
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
-		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
-	else
-		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
-
-	ts->idle_entrytime = now;
-	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-
-	sched_clock_idle_wakeup_event();
-}
-
-static void tick_nohz_start_idle(struct tick_sched *ts)
-{
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	ts->idle_entrytime = ktime_get();
-	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-	sched_clock_idle_sleep_event();
-}
-
-static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
-				 bool compute_delta, u64 *last_update_time)
-{
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
-	ktime_t now, idle;
-	unsigned int seq;
-
-	now = ktime_get();
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
-
-	if (vtime_generic_enabled_cpu(cpu)) {
-		idle = kcpustat_field(idx, cpu);
-		return ktime_to_us(idle);
-	}
-
-	do {
-		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
-
-		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			idle = ktime_add(cpustat[idx], delta);
-		} else {
-			idle = cpustat[idx];
-		}
-	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
-
-	return ktime_to_us(idle);
-
-}
-
-/**
- * get_cpu_idle_time_us - get the total idle time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds. Note that this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
- */
-u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
-
-/**
- * get_cpu_iowait_time_us - get the total iowait time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative iowait time (since boot) for a given
- * CPU, in microseconds. Note this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
- */
-u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
@@ -1275,6 +1156,20 @@ void tick_nohz_idle_retain_tick(void)
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
 }
 
+static void tick_nohz_clock_sleep(struct tick_sched *ts)
+{
+	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
+	sched_clock_idle_sleep_event();
+}
+
+static void tick_nohz_clock_wakeup(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
+		sched_clock_idle_wakeup_event();
+	}
+}
+
 /**
  * tick_nohz_idle_enter - prepare for entering idle on the current CPU
  *
@@ -1289,12 +1184,11 @@ void tick_nohz_idle_enter(void)
 	local_irq_disable();
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
-
 	WARN_ON_ONCE(ts->timer_expires_base);
-
 	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
-	kcpustat_dyntick_start();
-	tick_nohz_start_idle(ts);
+	ts->idle_entrytime = ktime_get();
+	kcpustat_dyntick_start(ts->idle_entrytime);
+	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
 }
@@ -1322,10 +1216,13 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
-		tick_nohz_start_idle(ts);
-	else
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
+		ts->idle_entrytime = ktime_get();
+		kcpustat_irq_exit(ts->idle_entrytime);
+		tick_nohz_clock_sleep(ts);
+	} else {
 		tick_nohz_full_update_tick(ts);
+	}
 }
 
 /**
@@ -1470,11 +1367,11 @@ void tick_nohz_idle_exit(void)
 		now = ktime_get();
 
 	if (idle_active)
-		tick_nohz_stop_idle(ts, now);
+		tick_nohz_clock_wakeup(ts);
 
 	if (tick_stopped)
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop();
+	kcpustat_dyntick_stop(now);
 
 	local_irq_enable();
 }
@@ -1530,9 +1427,14 @@ static inline void tick_nohz_irq_enter(void)
 
 	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
 		return;
+
 	now = ktime_get();
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE))
-		tick_nohz_stop_idle(ts, now);
+
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_nohz_clock_wakeup(ts);
+		kcpustat_irq_enter(now);
+	}
+
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
 	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
-- 
2.53.0


