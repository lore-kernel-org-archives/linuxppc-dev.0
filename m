Return-Path: <linuxppc-dev+bounces-19082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EDD109B468
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTD267s6z2ybR;
	Wed, 01 Apr 2026 00:16:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963010;
	cv=none; b=XN8bv6IQqYv1I1OktI7AsIqDjIqm3yX6RZFpeh4KXo1B1B605H2VPRdneuu7TiPaLVSpvRvSfQfQWawU/cqsRz5GQtcmrUfyV0JLF9XdV87cFN3OD6L2wUbGnalo2Q8OBCBOIGwAHNT6AcXFjCISkk6vPHlmUyuZvpJxaRrjs3SDu41PgiRQiAzJvLxGOAuXsfb0efYzC0AYo0RmMQ3xnLZRRzA1+5Gyh7UPH6xs6cGwFqTuAScXbNPwyAmVIaRG5LAnsPU7yzPqqQTF0SUUerEiGjG3RvLUWYRfgt4n9BWkdJEfUeWGu4zyhvJs8KGUglqzxq8v3VtRnNA+zXNOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963010; c=relaxed/relaxed;
	bh=1BBPGX+TJM0cuDljO7C5k+2/aLwgCqi0Y/ne1BJMjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV9kytqXqv0jil2o/631Ex2Z+uCdRHnjzo7dtoGDEB0opaS7mizS3YgV3mx2uIiKNflcH1AURRp+NqO0cv2Vphg8fbj6j8yFU+2o59k59GoERtPGfOArIdCIcgot0IysmdIG1ORODwR/rrvJ4t37XpcLP7Tf2EJeT06LmJgAHonGrhUenWT57G32PXbLRfPCDLyzlELXKJxWo4IKYxsi/C5SBfpYCXXcL/ndQPq9QLm04jCHqoqDmBDMiOfBcu9hMIUkNeiM0zMHE2EKwwkk0Um3yE6LC/pjIskCzbzGrVcq6HUNDQOavh5oSJGNYIRDp9KEH+I7NdPEbzD1wO+oYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=utJ0Romu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=utJ0Romu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTD211rfz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:16:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A77A40C49;
	Tue, 31 Mar 2026 13:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A4EC2BCB2;
	Tue, 31 Mar 2026 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963008;
	bh=ToJm1amU84B7C3xkdXohgmvzVkmSBy0/3/PURrIxwTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utJ0Romu/Lw2Vfmju3QNiFc/EA0xnYIUlSWdQssecRsJ7FgzJFMgHPfVH2LvAMqja
	 TLf2iG+Sd85g3nB/SE+Jb6dRTNC3m4WMt03izWbNdoYezhFxXjb8wqYBbJ1bUEVQp0
	 WnXJoAtGAnZHjLjg/rFM1mKp9xtk0vnD+9+2zi/SElWUWNzQn/c+oGTEudxRE+dIje
	 0INTYB2sNBultg56aZn3AInnqKCzbh6XpCMtAQ5LTN5t7e659wtaW28LUMwyF032f+
	 w94H++y/FvtDVUGczlKUyuMLCSzrD5tuW13D4sOabe9FDFBbMKMHCmIHkZpN6mBff4
	 jfFtn4MlU++Lg==
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
Subject: [PATCH 02/14] sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
Date: Tue, 31 Mar 2026 15:16:10 +0200
Message-ID: <20260331131622.30505-3-frederic@kernel.org>
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

The first parameter to kcpustat_field() is a pointer to the cpu kcpustat
to be fetched from. This parameter is error prone because a copy to a
kcpustat could be passed by accident instead of the original one. Also
the kcpustat structure can already be retrieved with the help of the
mandatory CPU argument.

Remove the needless parameter.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 drivers/macintosh/rack-meter.c     | 2 +-
 include/linux/kernel_stat.h        | 8 +++-----
 kernel/rcu/tree.c                  | 9 +++------
 kernel/rcu/tree_stall.h            | 7 +++----
 kernel/sched/cputime.c             | 5 ++---
 6 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 36eb7aee4bcd..ed36d22195f6 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -105,7 +105,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
 			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+				j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 		}
 	}
 }
@@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			u64 cur_nice = kcpustat_field(CPUTIME_NICE, j);
 
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
 			j_cdbs->prev_cpu_nice = cur_nice;
@@ -539,7 +539,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		j_cdbs->prev_load = 0;
 
 		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 	}
 
 	gov->start(policy);
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 8a1e2c08b096..26cb93191ede 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -87,7 +87,7 @@ static inline u64 get_cpu_idle_time(unsigned int cpu)
 		 kcpustat->cpustat[CPUTIME_IOWAIT];
 
 	if (rackmeter_ignore_nice)
-		retval += kcpustat_field(kcpustat, CPUTIME_NICE, cpu);
+		retval += kcpustat_field(CPUTIME_NICE, cpu);
 
 	return retval;
 }
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..dd020ecaf67b 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -100,14 +100,12 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-			  enum cpu_usage_stat usage, int cpu);
+extern u64 kcpustat_field(enum cpu_usage_stat usage, int cpu);
 extern void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu);
 #else
-static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-				 enum cpu_usage_stat usage, int cpu)
+static inline u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	return kcpustat->cpustat[usage];
+	return kcpustat_cpu(cpu).cpustat[usage];
 }
 
 static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..3cbf79bee976 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -969,14 +969,11 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
 			int cpu = rdp->cpu;
 			struct rcu_snap_record *rsrp;
-			struct kernel_cpustat *kcsp;
-
-			kcsp = &kcpustat_cpu(cpu);
 
 			rsrp = &rdp->snap_record;
-			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+			rsrp->cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+			rsrp->cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+			rsrp->cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
 			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
 			rsrp->nr_csw = nr_context_switches_cpu(cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..cf7ae51cba40 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -479,7 +479,6 @@ static void print_cpu_stat_info(int cpu)
 {
 	struct rcu_snap_record rsr, *rsrp;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
 
 	if (!rcu_cpu_stall_cputime)
 		return;
@@ -488,9 +487,9 @@ static void print_cpu_stat_info(int cpu)
 	if (rsrp->gp_seq != rdp->gp_seq)
 		return;
 
-	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+	rsr.cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+	rsr.cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+	rsr.cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
 	pr_err("\t number: %8lld %10d %12lld\n",
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index fbf31db0d2f3..caaaf0a04ced 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -975,10 +975,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
 	return 0;
 }
 
-u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-		   enum cpu_usage_stat usage, int cpu)
+u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	u64 *cpustat = kcpustat->cpustat;
+	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
 	u64 val = cpustat[usage];
 	struct rq *rq;
 	int err;
-- 
2.53.0


