Return-Path: <linuxppc-dev+bounces-16671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BFDEE20AC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6xC10bz1z3bTf;
	Sat, 07 Feb 2026 01:23:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770387789;
	cv=none; b=osQRiqIR6SxHio9mAdq0/0Ux7N7EQaAdoehRZ/AYCuqnQvD/yvx5cbP3ngiMovNvbD9OOPVPVB/BfuEidTKl3gfnory0AwOPrbiiBHnOJTr42Ce8tioIn0DIf3FvaaI/3H4Odtv1pib2DL9+f4ih1BqVVOdk83J57fqFMENe5o0wZ2XtU9vOwIy27IbqEaxHfZCgc760pdTusPVWUezT+pO/X9TlBPB6xOQtljkHtuYatljARrCcTOyHH+uks8oMQirwPe9XXSBz/MM5l9igo6OTjuSXRi+EVrBgDqnDGFyvKrS+uTUAp5hsIjGRlAf5Oezu2FURw2I84Hryyg9Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770387789; c=relaxed/relaxed;
	bh=CbDFQIh/JqMSKygs0XM/rWzl40nrhv3gM1k+kFifQoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twl6qQ+EK7kDg7+khCv+UzeVvRWPowxG74LcmDinQCr3szPY//6e0XzEZpIW+N/D1BmIYNRKQmNRMWk9yP05G2Pua7LQ3llmqBnCWxYxqjB/TqWmZY6bCGNsFWpvLSglfaikC/ElZdInQG2VH024yaXkFFScp7zGdusHTw4W/IUl3m2uVUueyVeMU3ZcBYUpRzCi6W6Lb/DaB+7xUJi18zRkHqg/zFKQyxrql/1dq4eHIH5KjubstZ0a/vbqRCYu4FkhfvRfN1LZRrENNqBSINHMC0WdnlkvqmYE4qwxEZxljHVOZ1pEY5OxQSmZl1TlEQceQHaJ3FAmRcGCO8xe5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JpZ8uh3d; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JpZ8uh3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6xC01PrTz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 01:23:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 67C5060125;
	Fri,  6 Feb 2026 14:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52E9C19422;
	Fri,  6 Feb 2026 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387785;
	bh=wLAGVyuXhhrWKSeELGYkoOFpqB5ysD0I9rHCulvW2nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpZ8uh3dVO70F+77got86Wunt3Up/fK/qFnnYDGHTtdQmqrjOvVd3KVzTRYvBu0y+
	 hdptMlW1CyrwZUjMxaknor8oyK3IRqdqjaqtM22j0CKyPl24pF+YtrXA7/ywoUsqVc
	 N9FX/G/KlvtZP8UxRFrnyUBU06Yv5WyoSVVEeBxk/62132uvMF9T6F+EG0VdunYtzv
	 rnhxjkXAi7wdshbMhVW+Nut7nB0ETScRmNlE8rJMSW5BA8jxbGhTLWuoA+ffTzdJxY
	 eKxCztC7aCrqJmnr9bEPApU27MVgTDBeostanKewHhWrIQeSoqcWzG7/MaOwP3EPwu
	 wQo4EUCnj7jcg==
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
Subject: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Date: Fri,  6 Feb 2026 15:22:31 +0100
Message-ID: <20260206142245.58987-2-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd17..51764cbec6f3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -260,6 +260,14 @@ static void do_idle(void)
 {
 	int cpu = smp_processor_id();
 
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
@@ -311,11 +319,6 @@ static void do_idle(void)
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
2.51.1


