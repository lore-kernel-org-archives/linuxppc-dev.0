Return-Path: <linuxppc-dev+bounces-22934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A08CDB479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:35:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl8K62sGgz2ygG;
	Wed, 24 Jun 2026 01:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782228922;
	cv=none; b=NWUD+vxh5A7kOrVpBFC6PpDTLQR+tftLPd92bvh3qWIHQi+dm/OheirEAfAWpD4dpmnxIl54Gh/nnZjkWzSKkC0qGZzmDTzTRp9EedNmKILaNNqn7GrbSSkcNAFu2ZEY4lfVjR4oFe72hxEuzXBqBNpkX9fenNVC9mVNUHBBsLmRXmOYMc0O1K9FoDo8vAeH3QaxP7LOfBT4wmiHV9K+a93EqszyAaOeVHX+fvY/CZz6juIYlqY2gk63zpIJDrOkfH8koPM0SLlC4/zC+OVKWbhrQ33JX9RsPp4B7Z4m5P0EfmDkcmdEvUJtvfmYGX7+pzqB+T7eYT1u46OcLLMKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782228922; c=relaxed/relaxed;
	bh=Os9oifXwMlAiBtFnDxy99rfvPjtg+YzWauHeJ0k/L1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkC+s7b/jwWSC3Sm6L2pRhr1v/Qf4gkrG5lk9xv2lJmvSsyTp+AX4RoXo3DXksur+GrZ3tQo8Raae7d5krjamZPMryQFYBTDNT6G7s/vrXxb+lTny0Nm3/0E1xEABB2FroU3vzUJ8edfjqiK5M/CSSyWv04x3mwBs3FPKTksUR5W3AJuBSuJie7kFEgJFKMvO0/EgsTU+eTNo1nbixKBNvljhCbbBMjCGc37/C/L2sQZtOr4pypvPCTMDEcAG2yuqJJ8NA7pcEqZtBncNqBHVME2M+paXAGzXmrBnx7uXIAFrzGNOFIbW6+jfkTa+XAVi+WS5FN7Sjh0J/1baicpgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=qtcIcsOE; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=qtcIcsOE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl8K20gZqz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 01:35:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228908;
	bh=Os9oifXwMlAiBtFnDxy99rfvPjtg+YzWauHeJ0k/L1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtcIcsOEEiDAgh+PJN0zVmzj0UsLYuBJ5xk+ituAH0ITICphsZY0QZ+x0LyNK7DMg
	 cQSOBI62dT3JxK47xQ9IMopUiDLMEKSAiXocYtTcYjmhTJql5mIVet16uOFb8Ai2rd
	 3bCAr6T+ka/2Vl1g+LyzRJc8PyIdNoxnv8+pPR1M=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jr6d4yz10xm;
	Tue, 23 Jun 2026 15:35:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jq4x34z10xZ;
	Tue, 23 Jun 2026 15:35:07 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 2/4] watchdog: avoid sys_info fallback for all_bt
Date: Tue, 23 Jun 2026 15:34:59 +0000
Message-ID: <af891d9ca90fa98eabe48e8647d0c80dfce62d42.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
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

The watchdog prints all CPU backtraces itself. When the watchdog mask
contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
sys_info(0) falls back to kernel_sys_info.

Use sys_info_without_all_bt() so an explicit all_bt mask does not request
the global default.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- Use the shared sys_info_without_all_bt() helper.
- Keep the generic watchdog change separate from powerpc.

 kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..5bf24231a5d8 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -208,6 +208,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
 	int hardlockup_all_cpu_backtrace;
 	unsigned int this_cpu;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
@@ -216,7 +217,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		return;
 	}
 
-	hardlockup_all_cpu_backtrace = (hardlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(hardlockup_si_mask);
+	hardlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_hardlockup_all_cpu_backtrace;
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
@@ -286,7 +288,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 			clear_bit_unlock(0, &hard_lockup_nmi_warn);
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info_without_all_bt(si_mask);
 	if (hardlockup_panic)
 		nmi_panic(regs, "Hard LOCKUP");
 
@@ -798,6 +800,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int softlockup_all_cpu_backtrace;
 	int duration, thresh_count;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (!watchdog_enabled)
@@ -809,7 +812,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (panic_in_progress())
 		return HRTIMER_NORESTART;
 
-	softlockup_all_cpu_backtrace = (softlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(softlockup_si_mask);
+	softlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_softlockup_all_cpu_backtrace;
 
 	watchdog_hardlockup_kick();
@@ -900,7 +904,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info_without_all_bt(si_mask);
 		thresh_count = duration / get_softlockup_thresh();
 
 		if (softlockup_panic && thresh_count >= softlockup_panic)
-- 
2.53.0

