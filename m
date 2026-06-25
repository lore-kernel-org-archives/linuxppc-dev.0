Return-Path: <linuxppc-dev+bounces-22987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1352DCDE001
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmN1j2gFFz2yjs;
	Fri, 26 Jun 2026 01:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782401177;
	cv=none; b=E65PCpV5V2r6gdzhozA8T3U/7/klwiBv0IO3vHASkqQykr+AzRcNZFbXSS9GXIVO0mJHA4YPihmm5iGk4hP+fB9NW+Km4nIwBxpY76n3Qzhiu7FDIJH5Pl7LKcWc2M8VUODhr56tA1dvsmspBFPpWgizybT/t7/mmgi5VWQVE4Z6mHJfqn5f+yHQiZXFQdwS4y2t4cCrMHtCnsm/ZJOcpq0A0uqFlxHARxUIn3d44XBZo9RVw+77wH88GBNLTz0eU1IhpLy9BjArWg9U/16wExDwwIlZzyTetMIdwTCgviG83mEt4vccfJ4fL/usK7RYCFZ04Y97tz5oYrH96aktmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782401177; c=relaxed/relaxed;
	bh=OwmcRXwC4OrIlUB8eo98mnX8ajr2JCkygJ17pPQ9kS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOOaXa2Fzxbj6s7nWOolFjoSiIKjZcd/ifASSmBnD5zibwAvl7Jstfu3W8B2LkSnAs9uU7jPrT8YHDEsWn5UlZBApZB2FMlFqJDaKkoPTByG6B/NPEmooPxeIBNLrj6E4oszf/hISrWaSpxVeWAQe1DXMA4m/U1qv5v0VOoRwVp7RnmCAjHL7CbcyrPTVsMP54hcL9NoA2djVwRDari7+ur8ncarjm/CIrEx3Pnb8pm0G9TpEmICHLdVOB3QULf5jGy9BFGYgxXk/sY5drmY5Bz+JoxALNM4rBrIhhkVut9gNXE4rycqFopAMv6OrUIFSUueEwKVCSknIPZcbQqGLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=EY3F45Dk; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=EY3F45Dk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmN1h4j0Dz2yjR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:26:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401174;
	bh=OwmcRXwC4OrIlUB8eo98mnX8ajr2JCkygJ17pPQ9kS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EY3F45DktU7nciOcOua2/yhVRN8c1JtIYotcO4vXyLs16oaE9G1kWAA55kUvwHVMQ
	 s0KnYu+bM8qRYYho1J2UNAM1tIlvdvbtM/JcAPPQg1laAAu9mWDQfcgWxpzSUnpA7I
	 hvHFdIdoY+QRfgA45cXENGtrLknFfINIl9rUwOUc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1f3H79z10v5;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1d5blBz10tb;
	Thu, 25 Jun 2026 15:26:13 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 3/4] powerpc/watchdog: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:57 +0000
Message-ID: <20260625152558.7450-4-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
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

The powerpc watchdog prints all CPU backtraces itself. When the watchdog
mask contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
sys_info(0) falls back to kernel_sys_info.

Use sys_info_with_filter() so an explicit all_bt mask does not request
the global default.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c40c69368476..d3a9c6da962d 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -201,6 +201,7 @@ static bool set_cpu_stuck(int cpu)
 static void watchdog_smp_panic(int cpu)
 {
 	static cpumask_t wd_smp_cpus_ipi; // protected by reporting
+	unsigned long si_mask;
 	unsigned long flags;
 	u64 tb, last_reset;
 	int c;
@@ -236,8 +237,9 @@ static void watchdog_smp_panic(int cpu)
 	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld (%lldms ago)\n",
 		 cpu, tb, last_reset, tb_to_ns(tb - last_reset) / 1000000);
 
+	si_mask = READ_ONCE(hardlockup_si_mask);
 	if (sysctl_hardlockup_all_cpu_backtrace ||
-	    (hardlockup_si_mask & SYS_INFO_ALL_BT)) {
+	    (si_mask & SYS_INFO_ALL_BT)) {
 		trigger_allbutcpu_cpu_backtrace(cpu);
 		cpumask_clear(&wd_smp_cpus_ipi);
 	} else {
@@ -251,7 +253,7 @@ static void watchdog_smp_panic(int cpu)
 		}
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
 
@@ -371,6 +373,7 @@ static void watchdog_timer_interrupt(int cpu)
 
 DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 {
+	unsigned long si_mask;
 	unsigned long flags;
 	int cpu = raw_smp_processor_id();
 	u64 tb;
@@ -418,11 +421,12 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 
 		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
 
+		si_mask = READ_ONCE(hardlockup_si_mask);
 		if (sysctl_hardlockup_all_cpu_backtrace ||
-		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
+		    (si_mask & SYS_INFO_ALL_BT))
 			trigger_allbutcpu_cpu_backtrace(cpu);
 
-		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-- 
2.53.0


