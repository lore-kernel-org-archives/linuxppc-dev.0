Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:45:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06AE217D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2CJjcit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06AE217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fn3c5GtkzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:45:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="o2CJjcit"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmrJ1WZ1zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:28 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id bf11so2639920plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UpRg7geaI+sWEyGZepnH29ISOYwE+XLjV9k/cfsCiuY=;
 b=o2CJjcitwO6wtJumeOLIWIub9KrwU4jm2I0w2cXbOuJZY00RCSlCWBF2hlS/LCqFwo
 GJzDCLga3utOB9Rj7VXj41vD5AdLfm+uZ61hB+8BsP60YHo+oyZbgtti+htyZxrPQJPU
 TBybDPzy0GCp7Lhhu6rd9HINhbZxSh6QiZgfvnY27n+LeMP0O/a5SgP5Io647Hjag7Zc
 EPNFrJpMtce1w7be7OptoalHJpOukogTux0ZNDRfpt9gNWQ8HOJAKbZDMJHsT6kVr9nf
 fGg3J20z0aSquozH9ecnFGulBLcxpKVUPb6BRQuRcm9p0iUrzNZG6LoVPY0XktdPBJrM
 bNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UpRg7geaI+sWEyGZepnH29ISOYwE+XLjV9k/cfsCiuY=;
 b=fWwBmiAoxnFUV0WTPZdHvPst253ETge8opJiRytiJgbVNULRQazc+4cAmrqIcaeO+O
 GJjqHAGFjkep4ePLWenodACVWCKvPFxCefVC+2h9bPXPFE9XrxCP9j1Y/H7riEEPuRhH
 aw78AOK6KCqZoE2XIdprNPJfUecI5U0LLIdMxJK8Jq5pub5dwvWrOZ8+pUVvSfkkEL8e
 A1mjoqPTYYuSzttUC4srhhyTtku+d577FSGDYZW99RHKlPg0JPCfJUWbl7rUI8Kg9to8
 MP3eI3Ly8mOGF+ObDDWguLXiiyK3aHuoFlmdNdQS6BmJWtYw7k4eTwx754YOtvQ86luf
 W9Bg==
X-Gm-Message-State: APjAAAXyuUXBoGN8nJXvZVtYTMZzoD2PEjtdG9POETkEEI3nwZsEJYkF
 QPINvk6ycUArBSoWa4t7tGnjKhyNtcA=
X-Google-Smtp-Source: APXvYqzHm5C8szaxszwf4LH9CmoFhQYt3+sIDLhVmTUw/W6VqM+UxaJ3ACZETByRUvwVV+JLTX67AQ==
X-Received: by 2002:a17:902:441:: with SMTP id
 59mr18094723ple.242.1554953726019; 
 Wed, 10 Apr 2019 20:35:26 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 5/5] nohz_full: Allow the boot CPU to be nohz_full
Date: Thu, 11 Apr 2019 13:34:48 +1000
Message-Id: <20190411033448.20842-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Allow the boot CPU / CPU0 to be nohz_full. Have the boot CPU take the
do_timer duty during boot until a housekeeping CPU can take over.

This is supported when CONFIG_PM_SLEEP_SMP is not configured, or when
it is configured and the arch allows suspend on non-zero CPUs.

nohz_full has been trialed at a large supercomputer site and found to
significantly reduce jitter. In order to deploy it in production, they
need CPU0 to be nohz_full because their job control system requires
the application CPUs to start from 0, and the housekeeping CPUs are
placed higher. An equivalent job scheduling that uses CPU0 for
housekeeping could be achieved by modifying their system, but it is
preferable if nohz_full can support their environment without
modification.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++--------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 529143b4c8d2..31146c13226e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -46,6 +46,14 @@ ktime_t tick_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
+#ifdef CONFIG_NO_HZ_FULL
+/*
+ * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
+ * tick_do_timer_cpu and it should be taken over by an eligible secondary
+ * when one comes online.
+ */
+static int tick_do_timer_boot_cpu __read_mostly = -1;
+#endif
 
 /*
  * Debugging: see timer_list.c
@@ -167,6 +175,26 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static void giveup_do_timer(void *info)
+{
+	int cpu = *(unsigned int *)info;
+
+	WARN_ON(tick_do_timer_cpu != smp_processor_id());
+
+	tick_do_timer_cpu = cpu;
+}
+
+static void tick_take_do_timer_from_boot(void)
+{
+	int cpu = smp_processor_id();
+	int from = tick_do_timer_boot_cpu;
+
+	if (from >= 0 && from != cpu)
+		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
+}
+#endif
+
 /*
  * Setup the tick device
  */
@@ -186,12 +214,26 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			if (!tick_nohz_full_cpu(cpu))
-				tick_do_timer_cpu = cpu;
-			else
-				tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+			tick_do_timer_cpu = cpu;
+
 			tick_next_period = ktime_get();
 			tick_period = NSEC_PER_SEC / HZ;
+#ifdef CONFIG_NO_HZ_FULL
+			/*
+			 * The boot CPU may be nohz_full, in which case set
+			 * tick_do_timer_boot_cpu so the first housekeeping
+			 * secondary that comes up will take do_timer from
+			 * us.
+			 */
+			if (tick_nohz_full_cpu(cpu))
+				tick_do_timer_boot_cpu = cpu;
+
+		} else if (tick_do_timer_boot_cpu != -1 &&
+						!tick_nohz_full_cpu(cpu)) {
+			tick_take_do_timer_from_boot();
+			tick_do_timer_boot_cpu = -1;
+			WARN_ON(tick_do_timer_cpu != cpu);
+#endif
 		}
 
 		/*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..4aa917acbe1c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -121,10 +121,16 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * into a long sleep. If two CPUs happen to assign themselves to
 	 * this duty, then the jiffies update is still serialized by
 	 * jiffies_lock.
+	 *
+	 * If nohz_full is enabled, this should not happen because the
+	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)
-	    && !tick_nohz_full_cpu(cpu))
+	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+#ifdef CONFIG_NO_HZ_FULL
+		WARN_ON(tick_nohz_full_running);
+#endif
 		tick_do_timer_cpu = cpu;
+	}
 #endif
 
 	/* Check, if the jiffies need an update */
@@ -395,8 +401,8 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
 	/*
-	 * The boot CPU handles housekeeping duty (unbound timers,
-	 * workqueues, timekeeping, ...) on behalf of full dynticks
+	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
@@ -423,12 +429,15 @@ void __init tick_nohz_init(void)
 		return;
 	}
 
-	cpu = smp_processor_id();
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP) &&
+			!IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU)) {
+		cpu = smp_processor_id();
 
-	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
-			cpu);
-		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
+			pr_warn("NO_HZ: Clearing %d from nohz_full range "
+				"for timekeeping\n", cpu);
+			cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		}
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
@@ -904,8 +913,13 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		/*
 		 * Boot safety: make sure the timekeeping duty has been
 		 * assigned before entering dyntick-idle mode,
+		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE)
+		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
+			return false;
+
+		/* Should not happen for nohz-full */
+		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
 			return false;
 	}
 
-- 
2.20.1

