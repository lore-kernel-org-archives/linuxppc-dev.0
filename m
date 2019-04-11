Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C4C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26C32084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLl9hNwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26C32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmzz20dVzDqFF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:42:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLl9hNwt"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmr63HBQzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:18 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 10so2718891pfo.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BNWp/JYAk75hC4HoWk0MvjkPFwZd8/2hFPRLSvOXOzA=;
 b=OLl9hNwtQd2tB2gY61TlRWKsYN1lJrQaRCJPgoKV/o/v19h1MGYYtfn3hqMDcMiDv7
 MlKokVZ7JhzBXCEOi7CCWEQOBLnCFiSgFc2gzOWEVuu0nS6wcvgMMSUUT11hgdzYTmpn
 vFH9Uj5fgfzYwWF619iOjKD/l3KdB0lD9yVxnhqkJNv2gpbUNk+wCj5AY4tjJxUc5itU
 25EsAujPh5U/3AFe0WWBbw+I8or9RlVbH8n3VQ+mk1hiRkZDoSX4zT9ApFaUv7js1JzW
 Go6Fnfvy7y1ArMpTZBHhCUZSesr/PenYyTJMdl4/8znL0E6RHDd8c5Dp3EsubPuUTqeV
 Df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BNWp/JYAk75hC4HoWk0MvjkPFwZd8/2hFPRLSvOXOzA=;
 b=dc1vdKDcW1Nhogd201IOTKgwAkJh++9k5WFVtYtwrcmPFKISjrwV6hRa3I4X6dicDY
 AsUgIadh/1zghkG/G4cXzH1Bkg/i6k1f3ENFdjpBAgGOqrk4VFuTBjSVMizNi211kmpa
 /CjxQDsioOcoaXjIv/VfXWLyupLwEvqaV3n4rpclAe+mvoFEypJxllveTnu7ZmPRgwYD
 TNc+JLAI4kLF0uq46up/10hNXh75r1DOYrjfPG1AkzNJHh/sLvwlFqY3P5c6SwsuY2/u
 Mpj28oX7CqqxD2hS74Ykrdsh+OJbCyy61ILBlLhC4S0vrNVGY4Mo9p0oxqzDIM862rwo
 bayA==
X-Gm-Message-State: APjAAAWkm06fcOEWfRqOoSzIUCVz3ceiYupghfObzkQbXGVezrYyOemN
 fE679XUXP/Ale/BYupRtgtY=
X-Google-Smtp-Source: APXvYqyDgWG4ci3RtiypzLC3Kgjv3A2jZhQBoW86sUX8p83WdFga8vK543Il4hpAUUzCUxz68qhcrQ==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr42647693pgr.403.1554953716793; 
 Wed, 10 Apr 2019 20:35:16 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Date: Thu, 11 Apr 2019 13:34:46 +1000
Message-Id: <20190411033448.20842-4-npiggin@gmail.com>
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

This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
opt-in to allowing suspend to occur on one of the housekeeping CPUs
rather than hardcoded CPU0.

This will allow CPU0 to be a nohz_full CPU with a later change.

It may be possible for platforms with hardware/firmware restrictions
on suspend/wake effectively support this by handing off the final
stage to CPU0 when kernel housekeeping is no longer required. Another
option is to make housekeeping / nohz_full mask dynamic at runtime,
but the complexity could not be justified at this time.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig |  4 ++++
 include/linux/cpu.h  |  7 ++++++-
 kernel/cpu.c         | 10 +++++++++-
 kernel/power/Kconfig |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..bc98b0e37a10 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -318,6 +318,10 @@ config ARCH_SUSPEND_POSSIBLE
 		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
+config ARCH_SUSPEND_NONZERO_CPU
+	def_bool y
+	depends on PPC_POWERNV || PPC_PSERIES
+
 config PPC_DCR_NATIVE
 	bool
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 563e697e7779..dd3813959d62 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -140,7 +140,12 @@ extern void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
-	return freeze_secondary_cpus(0);
+	int cpu = 0;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU))
+		cpu = -1;
+
+	return freeze_secondary_cpus(cpu);
 }
 static inline void suspend_enable_secondary_cpus(void)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6754f3ecfd94..d1bf6e2b4752 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -9,6 +9,7 @@
 #include <linux/notifier.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/task.h>
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
@@ -1199,8 +1200,15 @@ int freeze_secondary_cpus(int primary)
 	int cpu, error = 0;
 
 	cpu_maps_update_begin();
-	if (!cpu_online(primary))
+	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
+		if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
+			primary = housekeeping_any_cpu(HK_FLAG_TIMER);
+	} else {
+		if (!cpu_online(primary))
+			primary = cpumask_first(cpu_online_mask);
+	}
+
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index f8fe57d1022e..9bbaaab14b36 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -114,6 +114,15 @@ config PM_SLEEP_SMP
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 
+config PM_SLEEP_SMP_NONZERO_CPU
+	def_bool y
+	depends on PM_SLEEP_SMP
+	depends on ARCH_SUSPEND_NONZERO_CPU
+	---help---
+	If an arch can suspend (for suspend, hibernate, kexec, etc) on a
+	non-zero numbered CPU, it may define ARCH_SUSPEND_NONZERO_CPU. This
+	will allow nohz_full mask to include CPU0.
+
 config PM_AUTOSLEEP
 	bool "Opportunistic sleep"
 	depends on PM_SLEEP
-- 
2.20.1

