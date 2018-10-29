Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B624C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 18:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800512082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ViKF3X5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800512082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kN2S3JVzzDrS4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:11:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ViKF3X5Q";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="ViKF3X5Q";
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kMzR6p4qzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 05:08:35 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w3-v6so4276315pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
 b=ViKF3X5QZz1G04Kuc+UrpCLOIvvtASddvUpgEhbE2NwCsDxuq6JsW/AfF3MtdzfNcH
 x4aFvJIFkNdrS8l2CQjvpOEnAdP+LsFKZAoe9CdyAH5M9odaITFSuzPbsiwDohBeU3UQ
 YDDibS0wr7JOOkRxMW/g3gib7jVbkYmN9FZJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
 b=rWPzD8Kz/424k72FE8iumg42E9xzVYdQ53fEqEtvLTsrFiGrew58+GjBmO7soRIOht
 nguLSQ14hT8+BxHW0S+fMCdM6kfXXmciV2ys2brAxIZ5KIBm7eMXDYa6ApmCLBzwMLQS
 Ks9YkueKQTvWwaUKq/F3rTZXS4Jso592dNxwcSvobBVRsMsIhCEYeN+Rdr1VoP7EsqzJ
 eUVSLgKlalLwUmNlUKObkhzB4ZZre5TCKzO4k8MluaIQmw1Bf4gmDuVmipC6geae+Uvp
 n7eupChnrMD5KmzqS7DgkMxMKaTVThHdw3UqjjUhaWr+jepfmWz1TAAFhWrBXgCDQQ7m
 Y+iw==
X-Gm-Message-State: AGRZ1gLUbSjFptZpz/Jz/b3qn7VFb6ZToiOzcBu+7O8hNH6WUdeKXdzn
 CF9iuzmeeitDz7gy4L5gb/Oeeg==
X-Google-Smtp-Source: AJdET5dnes+lqSdsKf+M8kej513uIWGXuNg0nbxyLNaYWMhztTpOmHr2lEByvMdxDcC5rsUHz1VWbw==
X-Received: by 2002:a62:7a92:: with SMTP id
 v140-v6mr9434788pfc.46.1540836514355; 
 Mon, 29 Oct 2018 11:08:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Oct 2018 11:08:33 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de,
 mingo@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
Date: Mon, 29 Oct 2018 11:07:06 -0700
Message-Id: <20181029180707.207546-7-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
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
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 linux-arm-msm@vger.kernel.org, frederic@kernel.org, riel@surriel.com,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 luto@kernel.org, kgdb-bugreport@lists.sourceforge.net,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In kgdb_roundup_cpus() we've got code that looks like:
  local_irq_enable();
  smp_call_function(kgdb_call_nmi_hook, NULL, 0);
  local_irq_disable();

In certain cases when we drop into kgdb (like with sysrq-g on a serial
console) we'll get a big yell that looks like:

  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Let's add kgdb to the list of reasons not to warn in
smp_call_function_many().  That will allow us (in a future patch) to
stop calling local_irq_enable() which will get rid of the original
splat.

NOTE: with this change comes the obvious question: will we start
deadlocking more often now when we drop into the debugger.  I can't
say that for sure one way or the other, but the fact that we do the
same logic for "oops_in_progress" makes me feel like it shouldn't
happen too often.  Also note that the old logic of turning on
interrupts temporarily wasn't exactly safe since (I presume) that
could have violated spin_lock_irqsave() semantics and ended up with a
deadlock of its own.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 163c451af42e..bb581e58c8dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/kgdb.h>
 
 #include "smpboot.h"
 
@@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * can't happen.
 	 */
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+		     && !oops_in_progress && !early_boot_irqs_disabled
+		     && !in_dbg_master());
 
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
-- 
2.19.1.568.g152ad8e336-goog

