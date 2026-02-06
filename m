Return-Path: <linuxppc-dev+bounces-16684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09539EE20AA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xDy2sl4z30FP;
	Sat, 07 Feb 2026 01:24:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387890;
	cv=none; b=aoyYEXxIq77wDebRIoNrCnwv8iUVQ/PdHCarbH95Pl1k0j1p9dxi/BCcXb10XL1jXMHwzG+aq9BJrjlFYxxU4m3I5gLFJ9BkoZWL0nVjmfR0hxebEv1bar1LlXlwasu3nh//EJ+Qc6MssvaBYb6IJmmLO58CVu3mk/BznAhG+iflBJEWPleDuD8hhK18PuCNFARRFd7chdwYUz0UnoJSx3hjBl8OqdP8+3AtM4SOKqR7jBaO3XL4DdPyZ2It3zNFW6aJuPClzWWsZ8yvORwEIRRP2+nn5rN4D0r9kxvNhWe0Vofuzg9RE5NU6HBLpeA6iIVaoL/Wlbaqa/SBxBSJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387890; c=relaxed/relaxed;
	bh=agoTVneqYfK3b0CD1TxAvpSyFJNdnmFQBj8Fwmrbp1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCvsvuVV5WBh/HakRt7j1I808DppQOg1yjSWN1rglbuuAlPL5r0MBbSHAVP3Oa+q/4oBySYtuchM2NNptFo6p1BJhz/FnljVR9JTSlYkESjh7dXednKg+U2Ppb9Qjze3jxGXkH9ktfB4NtblCN4N/TdXLliiSJguJ62USC1Fj7vw3BTmp0IVG4LWMiYyUsv0yfeCt27RA2tLonVl41UUmG1rSr2uXZx+Nw8OL8syEwcvLw+BuD7vt5pZPlEFd5D2dvg2ApAB1hOVp4Ai+uUOv4uxjf8DP45TMZTm9MnqtRBjSbrGlggGLan2e5a21A1tDsxGmHc7Q+V7BJp2GfNa3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pyvvjMdH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pyvvjMdH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xDx4kF2z30GV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:24:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 22ECF40358;
	Fri,  6 Feb 2026 14:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3AC19424;
	Fri,  6 Feb 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387888;
	bh=1a8G23aJDuAPjK+U9mKc7z3SxXZk+XIfUuQdAEaa5yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyvvjMdH3hIzpy6aY54/LbDRrNWblh4tmt5l6YkK+fTkvt2lfzilz/SMkfwmrBCTa
	 SdLlYowtBljkJ90q0VuzNj72diFgimT3w+ipxS9PtB8dSXBlzs4yP8OfTHShrVnSgr
	 gIf5I4KVPgt8ITyocNbbNovtS1ms8WfLW13HT+LGC2E4XC8HPszlhfOeclfv2fM5jt
	 dXpbutriVMuVXNcdLINPem/tHoz9daDrciUC3ojdNmBJ73HAVeG1sT48y3yzyYxiIE
	 55GK83AOK2oYqnpMm+ZYmC8nbn9afCH/50djVJ6jux706lusveFloWpWJaZDjViUcl
	 ImbJ0ASRdg5Qw==
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
Subject: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Date: Fri,  6 Feb 2026 15:22:44 +0100
Message-ID: <20260206142245.58987-15-frederic@kernel.org>
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

The dyntick-idle cputime accounting always assumes that IRQ time
accounting is enabled and consequently stops elapsing the idle time
during dyntick-idle IRQs.

This doesn't mix up well with disabled IRQ time accounting because then
idle IRQs become a cputime blind-spot. Also this feature is disabled
on most configurations and the overhead of pausing dyntick-idle
accounting while in idle IRQs could then be avoided.

Fix the situation with conditionally pausing dyntick-idle accounting
during idle IRQs only if neither native vtime (which does IRQ time
accounting) nor generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/cputime.c | 24 +++++++++++++++++++++---
 kernel/sched/sched.h   |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d588a4a50e57..92fa2f037b6e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -46,7 +46,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
-	irqtime->tick_delta += delta;
+	if (!irqtime->idle_dyntick)
+		irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
 
@@ -81,6 +82,16 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
+static inline void irqtime_dyntick_start(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, true);
+}
+
+static inline void irqtime_dyntick_stop(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, false);
+}
+
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
@@ -94,6 +105,9 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 
 #else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 
+static inline void irqtime_dyntick_start(void) { }
+static inline void irqtime_dyntick_stop(void) { }
+
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -444,6 +458,7 @@ void kcpustat_dyntick_stop(u64 now)
 		WARN_ON_ONCE(!kc->idle_dyntick);
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
+		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
@@ -455,6 +470,7 @@ void kcpustat_dyntick_start(u64 now)
 
 	if (!vtime_generic_enabled_this_cpu()) {
 		vtime_dyntick_start();
+		irqtime_dyntick_start();
 		kc->idle_dyntick = true;
 		kcpustat_idle_start(kc, now);
 	}
@@ -464,7 +480,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -472,7 +489,8 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5..cf677ff12b10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3307,6 +3307,7 @@ static inline void sched_core_tick(struct rq *rq) { }
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
+	bool			idle_dyntick;
 	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
-- 
2.51.1


