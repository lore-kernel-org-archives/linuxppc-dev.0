Return-Path: <linuxppc-dev+bounces-19093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DFA109B462
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:18:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTFb4hzNz2ynP;
	Wed, 01 Apr 2026 00:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963091;
	cv=none; b=S/EO63G4nTLDFwffoQjRTQqYv0Amt7LPBs97wv3iFxSVmEW2Nf8e+NTw4mNt5vvwO1xVPqm8y3IQTyJxBlu7YFFi1szle9wsW1neP9+Qc+YKDA5bq2cfhKadTIpMMbDvhuG7q84NNmNauPR78clTm3c2bAY7BhZikao9kkXq7eJLvAgvCRqYQUqeXI3ls3sWytagD0HwHwu+rsMfMU2Jmh6PHmB/kB3gwgJb+T6GisFUscIE0zXiL3sDbQF5VOD6oOvl8HxOJpc9Lw4bjLzjo0BG3xRO5hrrGMHCFlgMibkfXpI/IDmzZNeOXrfEY22z6+cpfngYYzNMoZ/oIJJdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963091; c=relaxed/relaxed;
	bh=aVAn0QsyYLqySZbN8c9MxmOHzS7XmUtx/wvkrV8DR8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXqij8LSuJ4PVrRpEaymya9iWxTwF5VNQD5TjRkxkipW47PPeGWxaHurXMuFxGMC5UP7GhSyCBx4HcvXq6L7pN1p7Zn9Pycu/LIdocQQ1MrtmoRS4vt1QJCt7JUkR/eI/Fy7YIviNU1Kuobswm0diyC6q26PIJYcuxG4h+09UFYzIgqwySlyQK53A6MktnRaKjDOYNJcJqlOSv3SsCscB29DqrRwkcW4ekCpb1X00/Lq7sdcry4hXP5ubSAdnq6pbPpqNsrT7RMjDllleIV4EZFoogRKrr+NUX2ueHKvXMoBrJpOTRndaJweTod3G+TQsctRje9884+/82neYaZvQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WeFf0V7Q; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WeFf0V7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTFZ4k46z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:18:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 24B7543E1F;
	Tue, 31 Mar 2026 13:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09445C19423;
	Tue, 31 Mar 2026 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963089;
	bh=92dsTpBynD1g68/x/29CHbwEUuiIPa/Iwbdac5kZ2Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeFf0V7Q76pBqWbBm8IGxACxytO3klh4ei3hm4d7O+torfL3SL0J88znMRVk3JZmw
	 omf84HqK58CsG9RlCrTiYc7+bBSeYHg1vRC3OoshW/Au5njEL+lE6PY15qBPm6wcLt
	 2xWjsIqddQJwLG2HYfTTMM7ykffZVMd5qlLTrON6cT1cGi+j3nmvED7/989mH3RHh3
	 759W7vogKMpmVJ6QNpAFAaV8mdaMZl2RHtcwjuajIUZT4vsozdYWLQG6ajGRF59nS0
	 /ceyoU60qKQX7AEOXV+KNEF2biVlKfOj3qUymOffxL4QvLd6ryyQAUT6bAiirxUy+T
	 aqzSnvT3I0SBA==
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
Subject: [PATCH 13/14] sched/cputime: Handle idle irqtime gracefully
Date: Tue, 31 Mar 2026 15:16:21 +0200
Message-ID: <20260331131622.30505-14-frederic@kernel.org>
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
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/cputime.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 137e6b099fa9..a77b6f1dbdca 100644
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
 
@@ -478,7 +479,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -486,7 +488,8 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
-- 
2.53.0


