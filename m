Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D3C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 04:41:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEA220883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 04:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3pPvxMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dZPr0fzHzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:41:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3pPvxMj"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dZN36qg1zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 14:40:19 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id ck15so8620315plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4M5ZtubRWFyCdwdRoEL48LsxdaC6/O057JSNX2puPOQ=;
 b=b3pPvxMjPFzDPT3X68EQkFY0YDMu6ZoIYHTotLZKnQNHELzEx+0j06iQcJWAYsIvKp
 mZXCxBHY/XQfbIlLWzjP1j2+yKqXvVHsJmSQg3DyzKtiGJjfld27wc6nIYS0GEl3Y58l
 9diIQbxBAKomTSNYZMWi3IbHRjGHkjTRJV20pNSZkdFxyBBM7ogoSUP3flWu3EbVCvru
 X1JcAefka+jUkzCDEenWuGrMLZR+lfmVJgiTivNmbOqCnSamx1qc+Ky0taY4aOKPyRnq
 sI9/k80CTXA+CpKNuB7JNedGbXknNsBEvjT5MuPI4QOBCGiUBsfaKycNTzHVAB34RN9O
 zpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4M5ZtubRWFyCdwdRoEL48LsxdaC6/O057JSNX2puPOQ=;
 b=OgWN480Gb/0tCQ0EN1EWNoafxWZgjz2vsuMZYleYtAaGYpoVmHBAL4yS/94++1HgNT
 M2PpBFEn+ZRMu8pYMSGhblgvbKEtQXNRGfArCpKpCI+1wJsZ5EB/qb+mvgfcFJpfRtTJ
 sU05h8dNg1ZUJc1smwlM1T5WFBBNTfhAoBKQQ96iJ/S4iig7HwUvGUbR2MWalJt0GgXb
 yWS7aRm/Ai30xns+Oi5lNcewPgQF6dcG0j6MUb2rlWMhHn6IPi8n7fS7wvV9pNwQ7ULh
 pBfV1NLumh8VGBjq9141nCBSZmjxAmAPQJXLYT3XCna894Xiw7t3ypEZ/ZFti66HgEMh
 xhhQ==
X-Gm-Message-State: APjAAAU2MqbHjiwMuOlOVdvUik3sL8EVkOt0KIcAxuL/cz+UbhylbWmw
 Nx5bllXsAvePXaEFe4wkM+umpkOC
X-Google-Smtp-Source: APXvYqwUDYKNh9R1lb4Dw2U7p5K6tMlJ+sg/2+hZpcBgDX1av+NDEi68pQO4dBpg7LL9tDCWglUb0Q==
X-Received: by 2002:a17:902:110b:: with SMTP id
 d11mr7439371pla.275.1554784815749; 
 Mon, 08 Apr 2019 21:40:15 -0700 (PDT)
Received: from bobo.local0.net ([58.84.107.218])
 by smtp.gmail.com with ESMTPSA id x66sm19972001pfb.78.2019.04.08.21.40.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 21:40:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/watchdog: Use hrtimers for per-CPU heartbeat
Date: Tue,  9 Apr 2019 14:40:05 +1000
Message-Id: <20190409044005.26446-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Ravikumar Bangoria <ravi.bangoria@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using a jiffies timer creates a dependency on the tick_do_timer_cpu
incrementing jiffies. If that CPU has locked up and jiffies is not
incrementing, the watchdog heartbeat timer for all CPUs stops and
creates false positives and confusing warnings on local CPUs, and
also causes the SMP detector to stop, so the root cause is never
detected.

Fix this by using hrtimer based timers for the watchdog heartbeat,
like the generic kernel hardlockup detector.

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reported-by: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2: Fix per-CPU hrtimer startup noticed by Gautham

 arch/powerpc/kernel/watchdog.c | 81 +++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 3c6ab22a0c4e..af3c15a1d41e 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -77,7 +77,7 @@ static u64 wd_smp_panic_timeout_tb __read_mostly; /* panic other CPUs */
 
 static u64 wd_timer_period_ms __read_mostly;  /* interval between heartbeat */
 
-static DEFINE_PER_CPU(struct timer_list, wd_timer);
+static DEFINE_PER_CPU(struct hrtimer, wd_hrtimer);
 static DEFINE_PER_CPU(u64, wd_timer_tb);
 
 /* SMP checker bits */
@@ -293,21 +293,21 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 	nmi_exit();
 }
 
-static void wd_timer_reset(unsigned int cpu, struct timer_list *t)
-{
-	t->expires = jiffies + msecs_to_jiffies(wd_timer_period_ms);
-	if (wd_timer_period_ms > 1000)
-		t->expires = __round_jiffies_up(t->expires, cpu);
-	add_timer_on(t, cpu);
-}
-
-static void wd_timer_fn(struct timer_list *t)
+static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	int cpu = smp_processor_id();
 
+	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+		return HRTIMER_NORESTART;
+
+	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
+		return HRTIMER_NORESTART;
+
 	watchdog_timer_interrupt(cpu);
 
-	wd_timer_reset(cpu, t);
+	hrtimer_forward_now(hrtimer, ms_to_ktime(wd_timer_period_ms));
+
+	return HRTIMER_RESTART;
 }
 
 void arch_touch_nmi_watchdog(void)
@@ -323,37 +323,22 @@ void arch_touch_nmi_watchdog(void)
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
-static void start_watchdog_timer_on(unsigned int cpu)
-{
-	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
-
-	per_cpu(wd_timer_tb, cpu) = get_tb();
-
-	timer_setup(t, wd_timer_fn, TIMER_PINNED);
-	wd_timer_reset(cpu, t);
-}
-
-static void stop_watchdog_timer_on(unsigned int cpu)
-{
-	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
-
-	del_timer_sync(t);
-}
-
-static int start_wd_on_cpu(unsigned int cpu)
+static void start_watchdog(void *arg)
 {
+	struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);
+	int cpu = smp_processor_id();
 	unsigned long flags;
 
 	if (cpumask_test_cpu(cpu, &wd_cpus_enabled)) {
 		WARN_ON(1);
-		return 0;
+		return;
 	}
 
 	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
-		return 0;
+		return;
 
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
-		return 0;
+		return;
 
 	wd_smp_lock(&flags);
 	cpumask_set_cpu(cpu, &wd_cpus_enabled);
@@ -363,27 +348,40 @@ static int start_wd_on_cpu(unsigned int cpu)
 	}
 	wd_smp_unlock(&flags);
 
-	start_watchdog_timer_on(cpu);
+	*this_cpu_ptr(&wd_timer_tb) = get_tb();
 
-	return 0;
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer->function = watchdog_timer_fn;
+	hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
+		      HRTIMER_MODE_REL_PINNED);
 }
 
-static int stop_wd_on_cpu(unsigned int cpu)
+static int start_watchdog_on_cpu(unsigned int cpu)
 {
+	return smp_call_function_single(cpu, start_watchdog, NULL, true);
+}
+
+static void stop_watchdog(void *arg)
+{
+	struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);
+	int cpu = smp_processor_id();
 	unsigned long flags;
 
 	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
-		return 0; /* Can happen in CPU unplug case */
+		return; /* Can happen in CPU unplug case */
 
-	stop_watchdog_timer_on(cpu);
+	hrtimer_cancel(hrtimer);
 
 	wd_smp_lock(&flags);
 	cpumask_clear_cpu(cpu, &wd_cpus_enabled);
 	wd_smp_unlock(&flags);
 
 	wd_smp_clear_cpu_pending(cpu, get_tb());
+}
 
-	return 0;
+static int stop_watchdog_on_cpu(unsigned int cpu)
+{
+	return smp_call_function_single(cpu, stop_watchdog, NULL, true);
 }
 
 static void watchdog_calc_timeouts(void)
@@ -402,7 +400,7 @@ void watchdog_nmi_stop(void)
 	int cpu;
 
 	for_each_cpu(cpu, &wd_cpus_enabled)
-		stop_wd_on_cpu(cpu);
+		stop_watchdog_on_cpu(cpu);
 }
 
 void watchdog_nmi_start(void)
@@ -411,7 +409,7 @@ void watchdog_nmi_start(void)
 
 	watchdog_calc_timeouts();
 	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
-		start_wd_on_cpu(cpu);
+		start_watchdog_on_cpu(cpu);
 }
 
 /*
@@ -423,7 +421,8 @@ int __init watchdog_nmi_probe(void)
 
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"powerpc/watchdog:online",
-					start_wd_on_cpu, stop_wd_on_cpu);
+					start_watchdog_on_cpu,
+					stop_watchdog_on_cpu);
 	if (err < 0) {
 		pr_warn("could not be initialized");
 		return err;
-- 
2.20.1

