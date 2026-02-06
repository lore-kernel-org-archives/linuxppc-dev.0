Return-Path: <linuxppc-dev+bounces-16685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB5DEE20AA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:25:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xF6698Pz3btw;
	Sat, 07 Feb 2026 01:24:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387898;
	cv=none; b=M8CpRsOH0muliRekoee9IqfO7c2kjXp67laYXT86WsGFhIxEmkiGY46kJfM3gMJUp+t3SZdOHnwrbi6FFmmDFXZ03LP8aioPz4Th+G82EWNLRzLT++qvgo9+x8W9X+sCVbyVTFEEVxpgJeF3eTn9OZV8rmmuqaBy8gKKdxxeTlnsy+xyg3TSytQdF5FLZh7Y47mHUTVr1yzgEXDFdgbHzFWIqIzcRaePZki/X0vQlmmLcYg8cuGBq1QisfDNizJKEJ/SsqTfN+dzX3KSohxFOFNWec9EB7NyIxNsW9cCa/DXiocY5mtDGNFqT57SOjLuMEeqyoHfCH6O5pJJrsikmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387898; c=relaxed/relaxed;
	bh=fiUKlq90fY/CR+4SiWUcB1trF0SfhS+LdjhtQMr/gOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBpHNzwyWo51UQ/sKD0+93Cgfc0IdeazZeHYkm4fSj7xRlwC50QLPewicX/XiFbpg/UzVmuWX6Uh59/2i+Ik42i7EEoiaR1pGL/TxrdAtCa5D/5vAp3ZmvCT3OhHi7v3xgq45X4bDttanOdEfUSuhkfTPh/ojLgtX/KIRiSjdScqdOX+v0QyvfJ/owcNuLrbgcQOpuzD/V7V0Px/1ZH+zqpALlrvmaBCzPTjQtz5vc2rMlIOfWhP7QU6C/drOqynbPwzgoAm8YiFxrukxBwowo7lCl+oQRPW+vD1ejXB17q8GHJ17zTegzXM5Apq4NsMednhTRBLlypYh05MgvXgsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JnGDPW3W; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JnGDPW3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xF60hqlz30GV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:24:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4917060010;
	Fri,  6 Feb 2026 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F4C116C6;
	Fri,  6 Feb 2026 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387896;
	bh=axD30NXxtXM5SUHtedxFjg90A77tUvhavW17z9RBWt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnGDPW3WKQhZalgvDsfBR/ftmpCbHIg1kQ0jgLm0KnWWKT+zYa23crSRw7f5YRXCM
	 btDzqBLYR0Y0L4Cokn+/iY4Hvkk1LkJUyVU9RhKCw56WiwHT/UxGr31MDM0RACUhrV
	 YlzTAPXCA4NQtRJKJWqG1kMqJAvuoV7QdX7PlPuOIxgYZxAAilXOiHkCS39U7SyzkR
	 6gVTqKVllraCVZZi/Pl0sOAUW9n76CxeszJ1hzlDS8iF/uHHjHHoHKmekWABTOsAVz
	 eX8l3T5Ax5VY6BHzJDpKsCH3geoZS801SZSmFMGC/Ebc1IKNLQCaeHmaINBKfiIT72
	 /v4G2qyFhFU9A==
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
Subject: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time correctly
Date: Fri,  6 Feb 2026 15:22:45 +0100
Message-ID: <20260206142245.58987-16-frederic@kernel.org>
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

The dyntick-idle steal time is currently accounted when the tick
restarts but the stolen idle time is not substracted from the idle time
that was already accounted. This is to avoid observing the idle time
going backward as the dyntick-idle cputime accessors can't reliably know
in advance the stolen idle time.

In order to maintain a forward progressing idle cputime while
substracting idle steal time from it, keep track of the previously
accounted idle stolen time and substract it from _later_ idle cputime
accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kernel_stat.h |  1 +
 kernel/sched/cputime.c      | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 512104b0ff49..24a54a6151ba 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -39,6 +39,7 @@ struct kernel_cpustat {
 	bool		idle_elapse;
 	seqcount_t	idle_sleeptime_seq;
 	u64		idle_entrytime;
+	u64		idle_stealtime;
 #endif
 	u64		cpustat[NR_STATS];
 };
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 92fa2f037b6e..7e79288eb327 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -424,19 +424,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
-	u64 delta;
+	u64 delta, steal, steal_delta;
 
 	if (!kc->idle_elapse)
 		return;
 
 	delta = now - kc->idle_entrytime;
+	steal = steal_account_process_time(delta);
 
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	steal_delta = min_t(u64, kc->idle_stealtime, delta);
+	delta -= steal_delta;
+	kc->idle_stealtime -= steal_delta;
+
 	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		cpustat[CPUTIME_IOWAIT] += delta;
 	else
 		cpustat[CPUTIME_IDLE] += delta;
 
+	kc->idle_stealtime += steal;
 	kc->idle_entrytime = now;
 	kc->idle_elapse = false;
 	write_seqcount_end(&kc->idle_sleeptime_seq);
@@ -460,7 +466,6 @@ void kcpustat_dyntick_stop(u64 now)
 		kc->idle_dyntick = false;
 		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -505,10 +510,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 	do {
 		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
 
-		if (kc->idle_elapse && compute_delta)
-			idle = cpustat[idx] + (now - kc->idle_entrytime);
-		else
-			idle = cpustat[idx];
+		idle = cpustat[idx];
+
+		if (kc->idle_elapse && compute_delta) {
+			u64 delta = now - kc->idle_entrytime;
+
+			delta -= min_t(u64, kc->idle_stealtime, delta);
+			idle += delta;
+		}
 	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
 
 	return idle;
-- 
2.51.1


