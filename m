Return-Path: <linuxppc-dev+bounces-20612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5322CCD3447
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 13:17:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBqRC1kKfz30Vj;
	Fri, 08 May 2026 23:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778246247;
	cv=none; b=DV2H8+RH34muciobvGvyakKWPRz6Y/M1pe2xtOTjw04s6Q39Hi28lwsvKCDwXkHzsIYk/ZqL2/1AWMUFTQy7WNbw7QYnAFAnVOU4FgoRRfZ4Nnz/TeXRxO7hg/rk3X6LKdSj6mK6aKrLBzhDexPe43DW5x5QssSjahzXLMJsK3GPG9F7tGaWJXWVCj4+72HzLj/Q2J4B3kUU+i5bwyw18doD3mwaGa0WQcjFPt/0xWEQdDoWDme/EtX0CK+0/VqAjacSwewLWYeUVNWk0tdcxE5uhAoaVET4N4eqe1Ub5FIEqCjejb7RTJYkIM15xzHJPhT8Nl0LsBJEiArY/2Sn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778246247; c=relaxed/relaxed;
	bh=0E0o3HVbwghmLFn1IRbz0gC1uLQ710iByXEyo7VAdt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqG0U2Wlc3KQr3c95nnspDuFomNxEkorXJj0EkFsQTGAnsSc8CsKcSo+lwfVk0QWLGRdM/Ih7e8P5hujsKekEMVIfx5Pr4fiD3xUg/FphJ/yLCAiXwEySHysLRFNLx7kAIuZmrQzXusXPDApUgYhFlAU/xsgDnL/wkIjgtoD0kRcx5nq4NmVlHlBBG1paYGZpHlK799OgwO9LETrrEnjU2SC9Cn58BtplvZSMtsC/Lo3Fl3WUK9veaEFZ0I4oTfwkkKud2Kl6LroKvg6O3nukunyxFo9iEZtRooLTBiezRSZEiFEMNY5PTEt166VugCTPTZcjqhNmAS5t0JGT5zhaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HWkHfw6j; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HWkHfw6j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBqRB2k9Pz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 23:17:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F7FD60052;
	Fri,  8 May 2026 13:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985AFC2BCC7;
	Fri,  8 May 2026 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246243;
	bh=UeCeMdJXLMsqcLiyE7L6BjEm2BBFQStG53xrIqv/KCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWkHfw6jK75cNMzAAZKQ5+/l6MQMArstvk7RP/tFCMfz1+R6CNXzwQ3L0ZyjukjaW
	 0uyIzp+bWzVXPIlYleMk1IZZD7hH0tto03sYlMgkIkkouJZt7q9EatrTk/zPWIdMq2
	 NihSRoDrT0G0J7hUFIithGrluCdjOPrWuIJyxPvZVeAZHZpJJFDYPkIUFJ+5LaAPEA
	 4HiPOFmjN8qjLPKmjUuPfz+KrRUCy11VGrzeX571pG2Wrc/Ql8CU5O0Y2ldbRSTgKK
	 xyPyr6dHzCFJb7Bcu1S9kcPxV2uY4hoIYSRtyG8CBqKhj51y1CXnCOZA2CKC6q4tty
	 wyUJbfcdYY/Vg==
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
Subject: [PATCH 02/15] sched/idle: Handle offlining first in idle loop
Date: Fri,  8 May 2026 15:16:34 +0200
Message-ID: <20260508131647.43868-3-frederic@kernel.org>
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

Offline handling happens from within the inner idle loop,
after the beginning of dyntick cputime accounting, nohz idle
load balancing and TIF_NEED_RESCHED polling.

This is not necessary and even buggy because:

* There is no dyntick handling to do. And calling tick_nohz_idle_enter()
  messes up with the struct tick_sched reset that was performed on
  tick_sched_timer_dying().

* There is no nohz idle balancing to do.

* Polling on TIF_RESCHED is irrelevant at this stage, there are no more
  tasks allowed to run.

* No need to check if need_resched() before offline handling since
  stop_machine is done and all per-cpu kthread should be done with
  their job.

Therefore move the offline handling at the beginning of the idle loop.
This will also ease the idle cputime unification later by not elapsing
idle time while offline through the call to:

	tick_nohz_idle_enter() -> tick_nohz_start_idle()

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a83be0c834dd..aa7e3dc59856 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -280,6 +280,14 @@ static void do_idle(void)
 	int cpu = smp_processor_id();
 	bool got_tick = false;
 
+	if (cpu_is_offline(cpu)) {
+		local_irq_disable();
+		/* All per-CPU kernel threads should be done by now. */
+		WARN_ON_ONCE(need_resched());
+		cpuhp_report_idle_dead();
+		arch_cpu_idle_dead();
+	}
+
 	/*
 	 * Check if we need to update blocked load
 	 */
@@ -331,11 +339,6 @@ static void do_idle(void)
 		 */
 		local_irq_disable();
 
-		if (cpu_is_offline(cpu)) {
-			cpuhp_report_idle_dead();
-			arch_cpu_idle_dead();
-		}
-
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
 
-- 
2.53.0


