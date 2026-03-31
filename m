Return-Path: <linuxppc-dev+bounces-19084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678C5109B468
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:17:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTDL09j1z2yft;
	Wed, 01 Apr 2026 00:17:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963025;
	cv=none; b=N82BuYc2NXo5+dcpcq9+70UfspmSmUFihD7MvXTa1xx7z6dP8G2KLA4ruKRbXvGIjiWKV8voPSe52dzZ+MVE/qRH6ZA8+X6tOWZ5SgCL/h0uNqG5WiYgqzjI6pdoEJYQaeekdr9vj8K0OHw+12MW5mnyq+4w0Taq3IPTSGT09uqnSyS4Jyab+gMiIMYRQYIDbwcSA2WyMeMqP3iIaPnDcIIc4fL5Lnj2Q6+k1eoA8PtYSawSNp2UC0uTLNy98lGd/tzhhguY7AHzc94mgAQyW8PZgIiT2Cle5IK4HcAWLpOCsFUzGmA9HRuMY2xz8eULdEqlGwRWKyYzZ+ndh/EQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963025; c=relaxed/relaxed;
	bh=zIbn/CTHW+V2JNBtOAsFOpf77jUoC5oR4stEzePaGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds8y1zvvn7nmj5CrCqMwYNIcRY2SpQlk2MkdHVb6nOA3PunFIsxTJDx+DAS2d/HAFGrVZgc0z68LCBD95MCxMOJSIuOlXYuIsa0k+pfOmIZrBOAdehbVmEwUiuulST9rH+YNNam+uTRBf0rxXpetEkxeqgEJxRwbkW/A5DovBZPc8FNOY36eVKnqt9DW00MNJeDMglDGWaz/T0kYCp27/ndxKWte5OgmLBcdsYRhcVWf/BKvbf8khtu0NwG6VOasZxHVePx4UOZFtJVKvaTL+Cj0KgGUS8Gy1aGwSIIMvKnBkjH28nGtANYQE+7LpaLsMTNutgDUB5V7v6vTD4lVdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=doY1r4lb; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=doY1r4lb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTDK1kNwz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:17:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 62E716024D;
	Tue, 31 Mar 2026 13:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E89DC2BCB1;
	Tue, 31 Mar 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963023;
	bh=3JGza6TEAhXjrijNJ2v2eGWf9KE7T/4fipw25vHTRnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doY1r4lbmnoEkhdUq/s6RcT8z+9x9eEAV7C5WI9HDy3AfoCMn0B1xHRV3ENfZJmC8
	 O4ksxko+GCSlaH3rSSUzugQdojRmm5BLBr0eb2AjWzHIEaM8ltZr8Eilg/JruBmn1G
	 u35tngVYQjeQZMggBo03qZP5vzr1pnw5ESHSyvnzbmgx052jV35aQ8QB0WyiDsCtdl
	 JUCfA5rFQ/jtluXSjaMgjeLWwaWDLEV87RJCA6eRNc4G0JgriBeMg7Th/otuFupIfu
	 cC7ANEwSHfxt2grOivxUGdaiUDbwLy6DJx1h/mnArkKs6kfxB+bH6gV5/J+vg3HnK7
	 4SRXMXsaAGqUw==
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
Subject: [PATCH 04/14] powerpc/time: Prepare to stop elapsing in dynticks-idle
Date: Tue, 31 Mar 2026 15:16:12 +0200
Message-ID: <20260331131622.30505-5-frederic@kernel.org>
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

Currently the tick subsystem stores the idle cputime accounting in
private fields, allowing cohabitation with architecture idle vtime
accounting. The former is fetched on online CPUs, the latter on offline
CPUs.

For consolidation purpose, architecture vtime accounting will continue
to account the cputime but will make a break when the idle tick is
stopped. The dyntick cputime accounting will then be relayed by the tick
subsystem so that the idle cputime is still seen advancing coherently
even when the tick isn't there to flush the idle vtime.

Prepare for that and introduce three new APIs which will be used in
subsequent patches:

_ vtime_dynticks_start() is deemed to be called when idle enters in
  dyntick mode. The idle cputime that elapsed so far is accumulated.

- vtime_dynticks_stop() is deemed to be called when idle exits from
  dyntick mode. The vtime entry clocks are fast-forward to current time
  so that idle accounting restarts elapsing from now.

- vtime_reset() is deemed to be called from dynticks idle IRQ entry to
  fast-forward the clock to current time so that the IRQ time is still
  accounted by vtime while nohz cputime is paused.

Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
accounting twice the idle cputime, along with nohz accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/vtime.h      |  6 ++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4bbeb8644d3d..18506740f4a4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -376,6 +376,47 @@ void vtime_task_switch(struct task_struct *prev)
 		acct->starttime = acct0->starttime;
 	}
 }
+
+#ifdef CONFIG_NO_HZ_COMMON
+/**
+ * vtime_reset - Fast forward vtime entry clocks
+ *
+ * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
+ * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
+ */
+void vtime_reset(void)
+{
+	struct cpu_accounting_data *acct = get_accounting(current);
+
+	acct->starttime = mftb();
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->startspurr = read_spurr(acct->starttime);
+#endif
+}
+
+/**
+ * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
+ *
+ * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
+ * is accumulated and the tick subsystem takes over the idle cputime accounting.
+ */
+void vtime_dyntick_start(void)
+{
+	vtime_account_idle(current);
+}
+
+/**
+ * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
+ *
+ * Called when idle exits from dyntick mode. The vtime entry clocks are
+ * fast-forward to current time so that idle accounting restarts elapsing from
+ * now.
+ */
+void vtime_dyntick_stop(void)
+{
+	vtime_reset();
+}
+#endif /* CONFIG_NO_HZ_COMMON */
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 void __no_kcsan __delay(unsigned long loops)
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 336875bea767..61b94c12d7dd 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
+extern void vtime_reset(void);
+extern void vtime_dyntick_start(void);
+extern void vtime_dyntick_stop(void);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 static inline void vtime_account_softirq(struct task_struct *tsk) { }
 static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
+static inline void vtime_reset(void) { }
+static inline void vtime_dyntick_start(void) { }
+extern inline void vtime_dyntick_stop(void) { }
 #endif
 
 /*
-- 
2.53.0


