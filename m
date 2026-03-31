Return-Path: <linuxppc-dev+bounces-19083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57EB109B462
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:17:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTDB5h7Pz2ybQ;
	Wed, 01 Apr 2026 00:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963018;
	cv=none; b=V9ve1JSTTXAk3dzDgyAplHKTPsaH9LiLNYIvTztVpZdoHu5G6T5HIcKdM+7mr98/ueyiC5MZcIyxZUWxz6yjHQvLAuYDGP3kP9znolq86d2qdnr//oXTZ07FevmeQ7kRsR9PLg6tWoB5UKg37Z7IcYZ9Je0hVsYpe8NYoeVtHXrQG02sv9mzigVNtwYTuKylKFtPiihIdL7ld8WnJb7GZGg0mO0n+aV3jzSjl5NkicRwPd3nBqknHiBEPQ5WWJ4xzVXx9do/7loni6zbdyLTR+yBTu0S9sGisJdBwLvVjhbSQqHNpfyV5YQbsxb4Zt0Y2xoZPCZMosquv2PYJBkQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963018; c=relaxed/relaxed;
	bh=4eKjdXX6TY0KpkkM3iIZcTI6MOJ/20/hDmgECqm21L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfpHCJS0shrRcshlE87jB8B8Unh7h6VLrqIBYKFRPUgy4/8v2wPGszUUwVOilWHYT84mcRDr3mJ+SZlQm1vGSj8A6HcQnx4SGwJw+rrVuDsOCPt8KW87YfCyVgenYamRJqnJXzOqZKEGXEhWp8FIQAXi+GE/ZrXrXgIgQSeRJ4E8JPh2qA6YbGxQOSNA8D7yP05wFJ4y0wz75Az6+93bb/ld2a3dspfRrFqxO3xbLm0JIk5Zmdurf0Pj+GLUBD8VS4wph4shYTsICkycRArHUUqDjjLJaKnjeZRPjNY6ER+mww+qXx9K2upfF/QfzExNMt2ULz14PjaRELfT6dEdZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GjHPWfWe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GjHPWfWe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTD96y0Yz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:16:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E6D396057A;
	Tue, 31 Mar 2026 13:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D595C2BCB1;
	Tue, 31 Mar 2026 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963015;
	bh=FIR8yqoziWF4eq4PotWtg16qL3+UqHBknbFqZfHWHpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjHPWfWeJs98FD35R2fPBM/zzmkEZNP43NEG8bt/MegfdEYdnKCh5WmYWfZWCazWx
	 1eYNFoge1C83N5pjm7tgqvVKBJJIJRujQVxC2NU9bTTPEF+1d64YqtUL269s5YfVa0
	 8ElSA+AtQL/V7u1rkD5dWiQKPOxdOP7t/0Z6e50NBTmXRGV0f4MirErofvjArrGC2M
	 FGP9F59UajMqE/n/m2ctoV1sZdHnu9OVUoPdt7cyOYJOPrSyYMjII4xNScaX/VzAp9
	 3E8VdNHxps0W5rAPdb5wb3gJKH8LQcOpxjsQJ20r6sJjnwOOOF1L99TDlzgW6zjXqH
	 8Zl0g0x06IITQ==
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
Subject: [PATCH 03/14] sched/cputime: Correctly support generic vtime idle time
Date: Tue, 31 Mar 2026 15:16:11 +0200
Message-ID: <20260331131622.30505-4-frederic@kernel.org>
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

Currently whether generic vtime is running or not, the idle cputime is
fetched from the nohz accounting.

However generic vtime already does its own idle cputime accounting. Only
the kernel stat accessors are not plugged to support it.

Read the idle generic vtime cputime when it's running, this will allow
to later more clearly split nohz and vtime cputime accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/vtime.h    |  9 +++++++--
 kernel/sched/cputime.c   | 38 +++++++++++++++++++++++++++++---------
 kernel/time/tick-sched.c | 12 +++++++++---
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 29dd5b91dd7d..336875bea767 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -10,7 +10,6 @@
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void vtime_account_kernel(struct task_struct *tsk);
-extern void vtime_account_idle(struct task_struct *tsk);
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -27,7 +26,13 @@ static inline void vtime_guest_exit(struct task_struct *tsk) { }
 static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
+static inline bool vtime_generic_enabled_cpu(int cpu)
+{
+	return context_tracking_enabled_cpu(cpu);
+}
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+extern void vtime_account_idle(struct task_struct *tsk);
 extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
@@ -74,7 +79,7 @@ static inline bool vtime_accounting_enabled(void)
 
 static inline bool vtime_accounting_enabled_cpu(int cpu)
 {
-	return context_tracking_enabled_cpu(cpu);
+	return vtime_generic_enabled_cpu(cpu);
 }
 
 static inline bool vtime_accounting_enabled_this_cpu(void)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index caaaf0a04ced..d91b495457ec 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -773,9 +773,9 @@ void vtime_guest_exit(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
-void vtime_account_idle(struct task_struct *tsk)
+static void __vtime_account_idle(struct vtime *vtime)
 {
-	account_idle_time(get_vtime_delta(&tsk->vtime));
+	account_idle_time(get_vtime_delta(vtime));
 }
 
 void vtime_task_switch_generic(struct task_struct *prev)
@@ -784,7 +784,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 
 	write_seqcount_begin(&vtime->seqcount);
 	if (vtime->state == VTIME_IDLE)
-		vtime_account_idle(prev);
+		__vtime_account_idle(vtime);
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
@@ -926,6 +926,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
+	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -967,6 +968,14 @@ static int kcpustat_field_vtime(u64 *cpustat,
 			if (state == VTIME_GUEST && task_nice(tsk) > 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
+		case CPUTIME_IDLE:
+			if (state == VTIME_IDLE && !atomic_read(&rq->nr_iowait))
+				*val += vtime_delta(vtime);
+			break;
+		case CPUTIME_IOWAIT:
+			if (state == VTIME_IDLE && atomic_read(&rq->nr_iowait) > 0)
+				*val += vtime_delta(vtime);
+			break;
 		default:
 			break;
 		}
@@ -1029,8 +1038,8 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		*dst = *src;
 		cpustat = dst->cpustat;
 
-		/* Task is sleeping, dead or idle, nothing to add */
-		if (state < VTIME_SYS)
+		/* Task is sleeping or dead, nothing to add */
+		if (state < VTIME_IDLE)
 			continue;
 
 		delta = vtime_delta(vtime);
@@ -1039,15 +1048,17 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
-		if (state == VTIME_SYS) {
+		switch (vtime->state) {
+		case VTIME_SYS:
 			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
-		} else if (state == VTIME_USER) {
+			break;
+		case VTIME_USER:
 			if (task_nice(tsk) > 0)
 				cpustat[CPUTIME_NICE] += vtime->utime + delta;
 			else
 				cpustat[CPUTIME_USER] += vtime->utime + delta;
-		} else {
-			WARN_ON_ONCE(state != VTIME_GUEST);
+			break;
+		case VTIME_GUEST:
 			if (task_nice(tsk) > 0) {
 				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
 				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
@@ -1055,6 +1066,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
 				cpustat[CPUTIME_USER] += vtime->gtime + delta;
 			}
+			break;
+		case VTIME_IDLE:
+			if (atomic_read(&cpu_rq(cpu)->nr_iowait) > 0)
+				cpustat[CPUTIME_IOWAIT] += delta;
+			else
+				cpustat[CPUTIME_IDLE] += delta;
+			break;
+		default:
+			WARN_ON_ONCE(1);
 		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f7907fadd63f..7224a50d9c44 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -783,9 +783,10 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 	sched_clock_idle_sleep_event();
 }
 
-static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx, ktime_t *sleeptime,
 				 bool compute_delta, u64 *last_update_time)
 {
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t now, idle;
 	unsigned int seq;
 
@@ -796,6 +797,11 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
 
+	if (vtime_generic_enabled_cpu(cpu)) {
+		idle = kcpustat_field(idx, cpu);
+		return ktime_to_us(idle);
+	}
+
 	do {
 		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
@@ -833,7 +839,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
-	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE, &ts->idle_sleeptime,
 				     !nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
@@ -859,7 +865,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
-	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT, &ts->iowait_sleeptime,
 				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-- 
2.53.0


