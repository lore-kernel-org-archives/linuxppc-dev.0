Return-Path: <linuxppc-dev+bounces-22848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10404CDB466
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2026 23:31:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjW2J0xK5z2ySW;
	Sun, 21 Jun 2026 09:31:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781993459;
	cv=none; b=ouWyHaRynCsXj5N6GUDblHmF2w4tJtgNdvbnGzjbuM11MVT4e55KT/R3/0KNgB7ZWxYwwstGiSZ8U30P+nwRf4oOJVHcv0NTQmw3r9LzSSsbYYzSmGnb3p+VREYdAgXNbDVKNdpvZT7uaBdXxrj4M4ygJrpI4cWWB6ZweNp0sQWNRVp+5uyRZm9v9qYNBK2H7Ii/KXr7Ppa17fygqdtqO/i9xb4FptgBxSLOEZdk5A1HbAVvCd7OHpQom3XSMLigVVJa0gugSkW+vvzUNcHe/uj8JHsHAO693rJRj8BXfxUoczRN5Ia/Tu0m0kcXvB9hXZN+To9YX8EPROBpz3XQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781993459; c=relaxed/relaxed;
	bh=3vIdAFJFm2VmX3nU7cHArA7YHYS0lSiPW10WwQVdXmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W69K0M9iOr51XhHwmUY60TLp7Yh2ruLVwUMTPJgIGb2JFjmAJ8v+Y9l1WoE9FB3rnA+LBUT2bL8AlOv82DFjhgLCL7kUzMMqlitNKr1LR9UC4cbuXIQWa/ZGLbm2EPXKnh8Hlor9rUCA1aqWQ5LrQWdz8+S8u6Ro+vGOKGPTMOubWV9ln1TmNEvtu9aD6liKNlYG0a38AErBnhnHPk6f/hzKhVjOeoK4Eldo8AFn3uk8tTDT9b1NDFMFAwmLypTnceEv9xJhKC8ExKN1Ggf+B+mxyIkR0r3m54C3NpVXtNM6sAALAGFBMkvj7OUH95t08Xo5RRxdLhTTJ6j5xK9LwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=cEIhlfUp; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=cEIhlfUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 518 seconds by postgrey-1.37 at boromir; Sun, 21 Jun 2026 08:10:56 AEST
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjTDw5pzcz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 08:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781992927;
	bh=3vIdAFJFm2VmX3nU7cHArA7YHYS0lSiPW10WwQVdXmk=;
	h=From:To:Cc:Subject:Date:From;
	b=cEIhlfUp2mUGtjDU8LSFIien9pW8rzycayd78HxsyDxD3cDBa5G1a1PY638SCAEkJ
	 lsp389ddOHskiFlLCOJHpe6ufANRDR+6YAehGr/E3Rh34T4gY8E6z2KguI4buLAOFs
	 ErYvB8Fn4YCVloPkoV8/0bdXp8QUgVWgms69XYv4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gjT2l6fTVz110b;
	Sat, 20 Jun 2026 22:02:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gjT2l2BkSz110S;
	Sat, 20 Jun 2026 22:02:07 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/watchdog: avoid extra sys_info dumps for all_bt
Date: Sat, 20 Jun 2026 22:02:04 +0000
Message-ID: <20260620220204.15756-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
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

The powerpc watchdog handles SYS_INFO_ALL_BT itself. When that is the
only hardlockup_sys_info bit, sys_info(0) falls back to kernel_sys_info.

Skip sys_info() for that case.

Fixes: e561383a39ed ("powerpc/watchdog: add support for hardlockup_sys_info sysctl")
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/powerpc/kernel/watchdog.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..6338e12651e3 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -92,6 +92,16 @@ static cpumask_t wd_smp_cpus_pending;
 static cpumask_t wd_smp_cpus_stuck;
 static u64 wd_smp_last_reset_tb;
 
+static void watchdog_sys_info(unsigned long si_mask)
+{
+	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
+
+	if (si_mask && !dump_mask)
+		return;
+
+	sys_info(dump_mask);
+}
+
 #ifdef CONFIG_PPC_PSERIES
 static u64 wd_timeout_pct;
 #endif
@@ -201,6 +211,7 @@ static bool set_cpu_stuck(int cpu)
 static void watchdog_smp_panic(int cpu)
 {
 	static cpumask_t wd_smp_cpus_ipi; // protected by reporting
+	unsigned long si_mask;
 	unsigned long flags;
 	u64 tb, last_reset;
 	int c;
@@ -236,8 +247,9 @@ static void watchdog_smp_panic(int cpu)
 	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld (%lldms ago)\n",
 		 cpu, tb, last_reset, tb_to_ns(tb - last_reset) / 1000000);
 
+	si_mask = READ_ONCE(hardlockup_si_mask);
 	if (sysctl_hardlockup_all_cpu_backtrace ||
-	    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
+	    (si_mask & SYS_INFO_ALL_BT)) {
 		trigger_allbutcpu_cpu_backtrace(cpu);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	} else {
@@ -251,7 +263,7 @@ static void watchdog_smp_panic(int cpu)
 		}
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	watchdog_sys_info(si_mask);
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
 
@@ -371,6 +383,7 @@ static void watchdog_timer_interrupt(int cpu)
 
 DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 {
+	unsigned long si_mask;
 	unsigned long flags;
 	int cpu = raw_smp_processor_id();
 	u64 tb;
@@ -418,11 +431,12 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
+		si_mask = READ_ONCE(hardlockup_si_mask);
 		if (sysctl_hardlockup_all_cpu_backtrace ||
-		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
+		    (si_mask & SYS_INFO_ALL_BT))
 			trigger_allbutcpu_cpu_backtrace(cpu);
 
-		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+		watchdog_sys_info(si_mask);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-- 
2.53.0


