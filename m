Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B3C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:40:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6F62084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw8J5926"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6F62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmxX5yBJzDqMx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:40:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rw8J5926"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmr24mskzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:14 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id c8so2701530pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CWZZCmwLSXHeUqxxSF0Ph+9iewvMlr+/1Ia04zeauj4=;
 b=Rw8J5926VOh6N6GRYh64cQHUYKgIbzn3cVCWvglyjinr/XQis7QUebTd1zkribG7yU
 f1GvC+vhIm07yufwON2Q6gG2S+rMfRT2OYdTv7Ywql9CpZSBzVFhJEUXz5pukAg1Qofu
 41YrO6ick+TDyM5/01vdqZ9eWZfbMPNtAdHdiJkzN6vKmKiTFoShyx2AfzF2imlch2AG
 PUYNk8bhga8X8v7yXgCG7yCajZzWKGTFpEd1yAZ0tR5DfuK8+YXJM4BbcIFd/Zpn0Fxl
 fUVxdJX+fVKVgYhLchbdzldoFMHzw0zaUf0X32Wa4Nvx+526PzFq6h1tHLYm74XEC/HK
 0esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CWZZCmwLSXHeUqxxSF0Ph+9iewvMlr+/1Ia04zeauj4=;
 b=jZJ3hIJQ7jpmZflPjLhKYjZWHVc5yo9H5aoMNOmbtIG9oQjSYXWPnKpWpyJtfWMOUh
 fr6OHH/E3KEtT3fOtpHaSz2PE6b45Fii0B0fO1oZPe9nMyh6Wm7j5M7NzY2pYFlHOhBa
 ZEODvHguFDWWuO12xLCkmJi28jjuO3hCg3LK73SN7pxvp9td05NBmQZYqmKtjRK3bR6p
 8DLE5olRt0wBPXvgNddWrBHw0e/s3GAHlUP0OdiFswNeL4aOMuRxKBLatP/57cyq0z4Q
 7VliD7ZUGS6DJ8eGo0uobWrDx8EOTRaIFKHk/8d+JMR5FSw8eTOsTVFWOkOLo8RfK1fN
 NQYw==
X-Gm-Message-State: APjAAAUSN1LSJdcEsPio1FXzWPBKTl/KJqIiOVE+czDsjjk/cgDtqTrN
 I51D/JPeb92ZBX4Jss0D81w=
X-Google-Smtp-Source: APXvYqzz0Xm66Ni2uxsno4bD0pqDZS8jgJGqdXnEg82Kz8dd6boGm+cqHzPjvqlvPsYMFG/YmkMXIw==
X-Received: by 2002:a62:75cd:: with SMTP id q196mr38508311pfc.70.1554953712281; 
 Wed, 10 Apr 2019 20:35:12 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 2/5] PM / suspend: add function to disable secondaries for
 suspend
Date: Thu, 11 Apr 2019 13:34:45 +1000
Message-Id: <20190411033448.20842-3-npiggin@gmail.com>
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

This adds a function to disable secondary CPUs for suspend that are
not necessarily non-zero / non-boot CPUs. Platforms will be able to
use this to suspend using non-zero CPUs.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/cpu.h      | 10 ++++++++++
 kernel/kexec_core.c      |  4 ++--
 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/suspend.c   |  4 ++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..563e697e7779 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -137,6 +137,16 @@ static inline int disable_nonboot_cpus(void)
 	return freeze_secondary_cpus(0);
 }
 extern void enable_nonboot_cpus(void);
+
+static inline int suspend_disable_secondary_cpus(void)
+{
+	return freeze_secondary_cpus(0);
+}
+static inline void suspend_enable_secondary_cpus(void)
+{
+	return enable_nonboot_cpus();
+}
+
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..fd5c95ff9251 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
-		error = disable_nonboot_cpus();
+		error = suspend_disable_secondary_cpus();
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
@@ -1183,7 +1183,7 @@ int kernel_kexec(void)
  Enable_irqs:
 		local_irq_enable();
  Enable_cpus:
-		enable_nonboot_cpus();
+		suspend_enable_secondary_cpus();
 		dpm_resume_start(PMSG_RESTORE);
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..cfc7a57049e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -281,7 +281,7 @@ static int create_image(int platform_mode)
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -323,7 +323,7 @@ static int create_image(int platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	platform_finish(platform_mode);
@@ -417,7 +417,7 @@ int hibernation_snapshot(int platform_mode)
 
 int __weak hibernate_resume_nonboot_cpu_disable(void)
 {
-	return disable_nonboot_cpus();
+	return suspend_disable_secondary_cpus();
 }
 
 /**
@@ -486,7 +486,7 @@ static int resume_target_kernel(bool platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Cleanup:
 	platform_restore_cleanup(platform_mode);
@@ -564,7 +564,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error)
 		goto Enable_cpus;
 
@@ -586,7 +586,7 @@ int hibernation_platform_enter(void)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	hibernation_ops->finish();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..59b6def23046 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -428,7 +428,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -458,7 +458,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_wake:
 	platform_resume_noirq(state);
-- 
2.20.1

