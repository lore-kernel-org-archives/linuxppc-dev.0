Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF41C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 11:28:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B3A20856
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 11:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayjpd5EA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B3A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YRmh0Fp7zDqMP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:28:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ayjpd5EA"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YRhv6V17zDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 22:25:35 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so6414737pgs.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rI3ImivKzMQF1kcjpqnGuwJFTTXKk+PJLrZEuKwdA20=;
 b=Ayjpd5EABKEjd7etj9lc5flADVd/67AwWhuwQI22O/bAKMWzf3qxXxUECioNwqVTMn
 uV1l1uGR5jcr6Ap4KGIUYKLbd4qj6rUQ58SaCilStTF2Ju3LrjwFF8Ai+b/ENIcWgwK8
 CtdlN6ssw9W1eiNElo4OebPlz8ooeNyJqXVejrfDb/6pAUtZts5DmYRYzQu+dolh8HeN
 X8HFX1Av/Hv5ZYTNF5+krm/Rot1FD0GI7Zk8a7MGkMKvBrWhFPKcEved6rLw0aUVGwwU
 decd0r8mjTvwgBQF2B9HMTJD3kxEgHqzTTIlObMrszw2vAfDu1hWBQpes3X+UcH2V86J
 5SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rI3ImivKzMQF1kcjpqnGuwJFTTXKk+PJLrZEuKwdA20=;
 b=iZDflive1o0D9juVm2cBVyVIfcWc7QpqwgwbwAlf28IHWQ0GnKTS+oNA/JKk0eeCP1
 5WgUebNo+ptc7WA4rRizGCirnsGpqGtzfwfuh0kM2+76Hfxr3Tq2UGbbfWpDvGWZaSf9
 rB91m2ybTr1u3U1SyHQPVVgDpIaNpzsvJuYYjTsSOVgX/tWEEcFHaiGSA4BYIND/cFtB
 6Q15VEacR71N5xxluotlch6AgaIFEWsw3IUR8M2VxOz0IlMyyG7nPlW3JggnFgQocHPo
 Bk5nE8kPZ6RpJUGacHx/Fy00EUdgLPXnKS6pZyZpC12qqbFTXKzcRmtS3/C4Vg6O741N
 t7Mw==
X-Gm-Message-State: APjAAAWWpxxE0RMSxXdTpYdAs8p80CF5HggmGr8WpecNpN8K2dbhc8XY
 jv8p6hESzIqPPdaDLclFNuqFCZRI
X-Google-Smtp-Source: APXvYqxWB7keanW1DSznM2ezqKdIqOHrmZrKY60h+5EpgMjGVQtcbr6PjnHGuBncEdFNaqqUhhxFdA==
X-Received: by 2002:a62:1f92:: with SMTP id l18mr26976440pfj.180.1554204332170; 
 Tue, 02 Apr 2019 04:25:32 -0700 (PDT)
Received: from bobo.local0.net ([61.69.158.3])
 by smtp.gmail.com with ESMTPSA id w3sm29611873pfn.179.2019.04.02.04.25.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Apr 2019 04:25:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/watchdog: Use hrtimers for per-CPU heartbeat
Date: Tue,  2 Apr 2019 21:25:21 +1000
Message-Id: <20190402112521.24888-1-npiggin@gmail.com>
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
Cc: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>,
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

Reported-by: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 3c6ab22a0c4e..59a0e5942f6b 100644
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
@@ -325,19 +325,21 @@ EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
 static void start_watchdog_timer_on(unsigned int cpu)
 {
-	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
+	struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);
 
 	per_cpu(wd_timer_tb, cpu) = get_tb();
 
-	timer_setup(t, wd_timer_fn, TIMER_PINNED);
-	wd_timer_reset(cpu, t);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer->function = watchdog_timer_fn;
+	hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
+		      HRTIMER_MODE_REL_PINNED);
 }
 
 static void stop_watchdog_timer_on(unsigned int cpu)
 {
-	struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
+	struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);
 
-	del_timer_sync(t);
+	hrtimer_cancel(hrtimer);
 }
 
 static int start_wd_on_cpu(unsigned int cpu)
-- 
2.20.1

