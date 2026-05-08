Return-Path: <linuxppc-dev+bounces-20624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3879CD3447
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 13:19:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBqT6584Sz2yjx;
	Fri, 08 May 2026 23:19:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778246346;
	cv=none; b=ZkzB/9Gd/3NjWOV6ij6qmjnJJukcEGt9P2QCh3RXyYzAFB55Ett8bR5EMXoDQ8vKCCCBaBfnFdpNdYSzE+BEuz7ehyCri0SDuH8lFt1hj473Wpi/ibkZX8fvWIfaJiHNUJOv/Aab4q3pFIkfXjiEEFLuh4UUwTVzojGXnw9CkO5P88D352AncDOFZ0qygSbITk+8Ka80g5L/dPT3uWwxOdqLRvjK9kip/KuYBFdCWLdr3QSjXeNEIUaTsUQ9rBwoWZkcMpCVRWKkwi1tSOeuoLYVQiMpxieD4X2ZfNxn9jyAdjrGsKPXkSgc/q4s5uFBlA2+CKKuzCHXC3x3crN6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778246346; c=relaxed/relaxed;
	bh=Y8cES+HffG1g9+CSYFZk8HpBKt6h8qnilgLSq7bYgGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apG8JP7bOnuq6cAMDWkC4sW+6iuskqcOq7vjt+GVP/v2w5no+2ui5+nZR9OQhJLv+/qGQLH+JJKNIAbJFrlKGspLRI98REj5BrdeF4z11V7P2bLye0gM500vMF5gKLwnLy2ftv9yRQShNke1Kf94S5V4HB0TayArYB8T/6ZG1V4NHgnXr7i1k+AUlMhluR5Rn2ctPvmRtxFgknSmZjar6AK5x1tkSjupRuOZESx9zIjpa/8vFyCDWDQjhHdYjCm1mnX2/Bc0DvKFinilGYFOrJyan14N8YKbq+AncvghV0vZUD8LtnPHIAWlCpEE8FUCl1r1QW8eulMfhtcB/q+bFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qHbbX6uN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qHbbX6uN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBqT56gz1z30HQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 23:19:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A8E8600AE;
	Fri,  8 May 2026 13:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA590C2BCB0;
	Fri,  8 May 2026 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246343;
	bh=XFJ8pRWP/axY4OUs3PqKazFlUE7J3E8NIjuAoFfvd54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHbbX6uNw5iE1JmyAD29DJUX17xmu/WOfINYTTf/zyArVxcRB4G37uk5Iqv+RXV4z
	 HwbuiTsKWfCITC/thuYQbwa8cqqTJz197QCzqql6enFpRG4PfQNhOsF79owoGXVOBx
	 4H1TxhtNXAs9MLtt3xeLeey3Zb+6MWrLKkhk6p9XhCkfkuMc5zaTtUunLSfQLHCkY4
	 +2O5gu6PuMSb1ZwrTNn/vDjdtgQZ99zW5XSQm4QFemx60/kKG40Yu7RwqmYGzBjcto
	 8GvefEz008RHKOKpJxxd5alxoFAsfoZHUJfFVtUZv7IwJxhv5Qu09GIq3FqEIZkRu1
	 Ll6SZU2I+T4BQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Sashiko@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
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
Subject: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Date: Fri,  8 May 2026 15:16:46 +0200
Message-ID: <20260508131647.43868-15-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508131647.43868-1-frederic@kernel.org>
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
Content-Transfer-Encoding: 8bit

The dyntick-idle cputime accounting always assumes that IRQ time
accounting is enabled and consequently stops elapsing the idle time
during dyntick-idle IRQs.

This doesn't mix up well with disabled IRQ time accounting because then
idle IRQs become a cputime blind-spot. Also this feature is disabled
on most configurations and the overhead of pausing dyntick-idle
accounting while in idle IRQs could then be avoided.

Fix the situation with conditionally pausing dyntick-idle accounting
during idle IRQs only iff either native vtime (which does IRQ time
accounting) or generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/cputime.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 335d2c127763..94be22aa5cb6 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -47,7 +47,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
-	irqtime->tick_delta += delta;
+	if (!kcpustat_idle_dyntick())
+		irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
 
@@ -444,6 +445,10 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 
 static void kcpustat_idle_start(struct kernel_cpustat *kc, u64 now)
 {
+	/* Irqtime accounting might have been enabled in the middle of the IRQ */
+	if (kc->idle_elapse)
+		return;
+
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
 	kc->idle_entrytime = now;
 	kc->idle_elapse = true;
@@ -478,7 +483,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -486,7 +492,15 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	/*
+	 * Generic vtime already does its own idle accounting.
+	 * But irqtime accounting or arch vtime which also accounts IRQs
+	 * need to pause nohz accounting. Resume nohz accounting as long
+	 * as the irqtime config is enabled to handle case where irqtime
+	 * accounting got runtime disabled in the middle of an IRQ.
+	 */
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING) || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
-- 
2.53.0


