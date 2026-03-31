Return-Path: <linuxppc-dev+bounces-19094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB34109B468
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:18:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTFl543Hz2yfS;
	Wed, 01 Apr 2026 00:18:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963099;
	cv=none; b=Lw73r5PLFDlSUJgP0rQCqr/PUOUoEzbOGUUm+e/OFyIc7umMcVRtohe25DGuy9f9yKvjNYG7kBWJuvkHk8eosN7AsVv8adaoZno6Jv/vA2o175/Jae0ZX7+3bpyVoFkVl3gZZa37xC26bFUHHC0dQyaGQDrINgc4GBxhUScb/Ae6HzzEPvH4p6MJrP1PrCSLLaPhsQucrMJMHlmfvbDwZLAF5UJn4iE/TVS3HdSeVy+abmScwNlgG0deKuOHKQtDn3hW2Ighqvg2Vg5Ya2GWV1KjuQ3AE/nfezi5eQjN1anTknJS9AyTOHCJPpwPrFFbwpYXcgbTloNWWfkTHk+LlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963099; c=relaxed/relaxed;
	bh=/akHv6CooW7edD6FuziWgT1v2QnnFuvY+9BnjAckks8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCvwqse0bzKMIyw1ZcrDPsX6Wlkc97yN6tiKjDF3WJEh/udivKbz/O1zMSnxXBZ0Z1ImneWtcrcu+O4BNdQjoYWIVMA5S/Q6CGMK+IqKo/P3f24Ch8wQ4RZL+TwtGwfhcNiwD7Ssm0rql12LWBwE1o036bp/NpLbhRm7kgJ3CJ6WxL1/fVDXANoRtg6dO+P74eYdCgOvlDYAhwUcusCIRz8y7D0dB/9T3u/AYRg/rWW6xM8QUj29aTNJKIdl2bnsSPBm+FuUXRaKEaCVpnjubC1HfSNqej+elNYTPULnPjfzppN9n34cBtZ3f6MKP+XNyHrSZO6oT4uVPWyMoRUlqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QcjY+/i5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QcjY+/i5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTFk5vbgz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:18:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 89DD26024D;
	Tue, 31 Mar 2026 13:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76BC2BC9E;
	Tue, 31 Mar 2026 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963096;
	bh=PFIpn22Lqg8nUvYixerHksrQguG7VQqiCjtgoj0+dII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcjY+/i5y/kMyQ5zzBs/8HbtBsPy4rODD3TLaBkViHed+LXJHBdR3Hl4Ou6uEQL1/
	 dh5y2JRw47HtffMZP5vvW6JDLevDFG3rthVqd2dVCUquw82FQw9f/WnKemDfCb6ydo
	 7zkk1apR5DmFqaq6YaEvuktsM7cxFtBOxTKP33IISuWEowhBJYUNt8qVHw/MRVQyif
	 FtmCHCuJIBkqo/w31e+CcNNUhEY21vWe5DD+2vEPKRTmCD9TZ2Io/CfwC2NK7r5Mqe
	 FYokXoKTBVBio+IyccRpfZkPOshlHMzMTAwv6aXrSbzrq6tzoumbKFgRXvqEa3e2Wn
	 Z0LqDOdVIb2Og==
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
Subject: [PATCH 14/14] sched/cputime: Handle dyntick-idle steal time correctly
Date: Tue, 31 Mar 2026 15:16:22 +0200
Message-ID: <20260331131622.30505-15-frederic@kernel.org>
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

The dyntick-idle steal time is currently accounted when the tick
restarts but the stolen idle time is not subtracted from the idle time
that was already accounted. This is to avoid observing the idle time
going backward as the dyntick-idle cputime accessors can't reliably know
in advance the stolen idle time.

In order to maintain a forward progressing idle cputime while
subtracting idle steal time from it, keep track of the previously
accounted idle stolen time and substract it from _later_ idle cputime
accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
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
index a77b6f1dbdca..4ae779b161b5 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -425,19 +425,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
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
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -504,10 +509,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
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
2.53.0


