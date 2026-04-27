Return-Path: <linuxppc-dev+bounces-20160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFDCFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42sV1NNLz2y7r;
	Mon, 27 Apr 2026 22:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292894;
	cv=none; b=bfxZR015lXXUXGlxufuy/hDHFO7VdcoHGq+fMLr0HDe6MXzG057QOg3XKvt5SCW/E0F7JeSj/pn2GCYg/D08L5iXyLGopZ8fzCsOt8V17rH3PSbYGhfvxx89/aVeO7++5JGeMAZtYSSQDxHH8mMh9ehAKJUDGQ06tn9yfxrVgtG3SFQL8BH0njNJs3BipB30edki646gR4xwGsZOoLHxK8GiK7u0cixX2efV5+fcbkzfrOtiQB6VCEEfcBwF5JjX9L4cTGa5NfQnRjarsUXR3+1tS2ErflwSfg/qCv7QFPHjvBIBhk0ZMSQEUztPKqdRtTO4YTznoMZB6ZLQ7iwWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292894; c=relaxed/relaxed;
	bh=V3Ix8yVWPzMNREGKmrAx0G5cLQ0OeAzIGo9ilHfqR+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecUVBBK3OCUoa6eaQxWMTwH2yvuqzKveB4RmcexX2neuzuDImxnIhILVndUGKxJYZVeUhet+rYcFZjdlVPGodUUXiFdq/bI4yAkImdAYhC+otdBjC3qcQw99ZAyxqZS1RJOxstCdh871xjc36ZQ2IdRfgYh0X6JQvcwuFGmPBl+9DWN0HgIOSB8brKw3nGZpBEgzKSyu/mi+BlQ7e7eMzhvT+V6Pt9r4cy/NQaK8u//rJiKv2oB3Fuj+VlBVS44ED174y+D3oLH0xDuuGYOnqz2oFEMgbpecqkFE24OwhSI+6iyv99cEZsqkBE8T1VKH/wuBAnU5NNwxlUkOtcICUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlfdfJX+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlfdfJX+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42sT09H9z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:28:13 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so3472155a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292891; x=1777897691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Ix8yVWPzMNREGKmrAx0G5cLQ0OeAzIGo9ilHfqR+E=;
        b=JlfdfJX+BFv5n0mw4x5htuS2UJwUdnP1/uku0hz/+peBoZ6lCItLm6LyfKExHDVAsK
         eHw7Hp4LCK8PbxgV1qOsWclbv4QpP2F3dBKYC+2ZqSD1BKrgdEvhekkFMr38dLTWrB3P
         qmog/6yVVv2sWb5p5M3ivX9T3n7oeZJTgZl+bR+SMVLVXImiuSZYUkmzyGtEC6+yJNZ9
         EFUM3dahyZxfyu+nr6oL9qkcce1Di+TgpzfT8c5qIzqmOgGaPzHZqX8mXdUheSBfXzd+
         jgAsaOfM4yBNwekNWzURHdTj/QWbQKlmrqzdkVW6RwEENoan29bkwwJXyKaUQ/4JcVex
         R+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292891; x=1777897691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3Ix8yVWPzMNREGKmrAx0G5cLQ0OeAzIGo9ilHfqR+E=;
        b=mT4KLxbFHqg7MfFpn1tCjqqHuXDbueZMMvq1PF8JtG5LjjAfM64lIcneNU4xlIv1dx
         ba5RaWfJGtaU96MVM8euUG0A5dn38yv1xcxySHp/4zm4SW8iEz6BEwA8Zpi7TDGybIcJ
         IJksiYr2Ms5njEr1xhlo1nTE0/YSQQwAP0a6biYvL8dr9JeOpmmCx3mYDUxLOWNP2gIP
         M2hQUiWOKvJid/GpCFWnTjtC5yMokUhMOqxOy0ISYBjKSyP8ugyR6IE0GibC16G8pf81
         rkdh/dpd8JUzvmEpFnMpCgqKS2AsV3ofQWkKwetD+56Q4PLtOE8I2w2H8BA2OmpMlUcH
         c5aw==
X-Forwarded-Encrypted: i=1; AFNElJ+uMZTgEvD2KKkv99XZ7unGmu9+odY75fSQR4FGg6SRhnSRL5Y1c6ndLmR4PydAVNODKzIdQP65BpA+48c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCB78rHcFE2yQKBk5g+nIedty3yZ0V2iQLfg4r71SQj4wLLjoB
	nhJR3eeIVc7aLKhQmdqsa3NjPAKTn4/gy1Dzd9ITSFRlOVb3vFhCikyb
X-Gm-Gg: AeBDietHoBlcGcV2NPnjVExAFRRIpPZLLkTik7VaANIM/ss/PyTwus0pTv1lM+vZe2W
	3bY/zkDO+QSHC/UhWWW3Q8fW2ZAhKId1vw5tMrqh06plbCBAkIJM//cqbBAXbAP0+T28IVZLN2f
	CHzmsKnVFYFOMux/FR7/BrOwRIELEITg5cJYmXcTt4vFgc1nQWD6L/utCePCG0oLprlvQkkVZU5
	CTKLIN5cnab5fyyZ3JkaYeqgOvvAvVXaC8T0X/F22ZudiapL7CM2yffDhy6JEKScEr0wbPas4x8
	Z4JwqRblaP4inOrWCGDFxNaonapYIG4JxRD2vvFrilbNaTU3qLtt8XVnqmLx7As/0W27cfjRXUU
	OftSLRcbAPiFE5Ums2dPCLGxpmB9Hq1hs3YfDXZKLS0Joi/IJDkDPJaAxadFfDdrZeQvjwiTmvq
	ildD31QUUqicvfSMNnRbX4Wp70x4P3oiesQjICqbfVC0nUFEme8wLyWRaFE1PZdic5d3y9FfujW
	3rQpw==
X-Received: by 2002:a05:6a00:4b01:b0:82f:390a:69df with SMTP id d2e1a72fcca58-82f8c8d616emr45497999b3a.35.1777292891062;
        Mon, 27 Apr 2026 05:28:11 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:28:10 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Samir M <samir@linux.ibm.com>,
	David Gow <davidgow@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5 1/8] powerpc: rename arch_irq_disabled_regs
Date: Mon, 27 Apr 2026 17:57:35 +0530
Message-ID: <20260427122742.210074-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
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

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Rename arch_irq_disabled_regs() to regs_irqs_disabled() to align with the
naming used in the generic irqentry framework. This makes the function
available for use both in the PowerPC architecture code and in the
common entry/exit paths shared with other architectures.

This is a preparatory change for enabling the generic irqentry framework
on PowerPC.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h    |  4 ++--
 arch/powerpc/include/asm/interrupt.h | 16 ++++++++--------
 arch/powerpc/kernel/interrupt.c      |  4 ++--
 arch/powerpc/kernel/syscall.c        |  2 +-
 arch/powerpc/kernel/traps.c          |  2 +-
 arch/powerpc/kernel/watchdog.c       |  2 +-
 arch/powerpc/perf/core-book3s.c      |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 9cd945f2acaf..b7eee6385ae5 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -393,7 +393,7 @@ static inline void do_hard_irq_enable(void)
 	__hard_irq_enable();
 }
 
-static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
+static inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
 	return (regs->softe & IRQS_DISABLED);
 }
@@ -466,7 +466,7 @@ static inline bool arch_irqs_disabled(void)
 
 #define hard_irq_disable()		arch_local_irq_disable()
 
-static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
+static inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
 	return !(regs->msr & MSR_EE);
 }
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index eb0e4a20b818..0e2cddf8bd21 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -172,7 +172,7 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 	/* Enable MSR[RI] early, to support kernel SLB and hash faults */
 #endif
 
-	if (!arch_irq_disabled_regs(regs))
+	if (!regs_irqs_disabled(regs))
 		trace_hardirqs_off();
 
 	if (user_mode(regs)) {
@@ -192,11 +192,11 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 			CT_WARN_ON(ct_state() != CT_STATE_KERNEL &&
 				   ct_state() != CT_STATE_IDLE);
 		INT_SOFT_MASK_BUG_ON(regs, is_implicit_soft_masked(regs));
-		INT_SOFT_MASK_BUG_ON(regs, arch_irq_disabled_regs(regs) &&
-					   search_kernel_restart_table(regs->nip));
+		INT_SOFT_MASK_BUG_ON(regs, regs_irqs_disabled(regs) &&
+				     search_kernel_restart_table(regs->nip));
 	}
-	INT_SOFT_MASK_BUG_ON(regs, !arch_irq_disabled_regs(regs) &&
-				   !(regs->msr & MSR_EE));
+	INT_SOFT_MASK_BUG_ON(regs, !regs_irqs_disabled(regs) &&
+			     !(regs->msr & MSR_EE));
 
 	booke_restore_dbcr0();
 }
@@ -298,7 +298,7 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
 		 * Adjust regs->softe to be soft-masked if it had not been
 		 * reconcied (e.g., interrupt entry with MSR[EE]=0 but softe
 		 * not yet set disabled), or if it was in an implicit soft
-		 * masked state. This makes arch_irq_disabled_regs(regs)
+		 * masked state. This makes regs_irqs_disabled(regs)
 		 * behave as expected.
 		 */
 		regs->softe = IRQS_ALL_DISABLED;
@@ -372,7 +372,7 @@ static inline void interrupt_nmi_exit_prepare(struct pt_regs *regs, struct inter
 
 #ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_BOOK3S
-	if (arch_irq_disabled_regs(regs)) {
+	if (regs_irqs_disabled(regs)) {
 		unsigned long rst = search_kernel_restart_table(regs->nip);
 		if (rst)
 			regs_set_return_ip(regs, rst);
@@ -661,7 +661,7 @@ void replay_soft_interrupts(void);
 
 static inline void interrupt_cond_local_irq_enable(struct pt_regs *regs)
 {
-	if (!arch_irq_disabled_regs(regs))
+	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
 }
 
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e63bfde13e03..666eadb589a5 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -347,7 +347,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	unsigned long ret;
 
 	BUG_ON(regs_is_unrecoverable(regs));
-	BUG_ON(arch_irq_disabled_regs(regs));
+	BUG_ON(regs_irqs_disabled(regs));
 	CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	/*
@@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 
 	local_irq_disable();
 
-	if (!arch_irq_disabled_regs(regs)) {
+	if (!regs_irqs_disabled(regs)) {
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index b762677f8737..52d6e10eab22 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -32,7 +32,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 
 	BUG_ON(regs_is_unrecoverable(regs));
 	BUG_ON(!user_mode(regs));
-	BUG_ON(arch_irq_disabled_regs(regs));
+	BUG_ON(regs_irqs_disabled(regs));
 
 #ifdef CONFIG_PPC_PKEY
 	if (mmu_has_feature(MMU_FTR_PKEY)) {
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index cb8e9357383e..629f2a2d4780 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1956,7 +1956,7 @@ DEFINE_INTERRUPT_HANDLER_RAW(performance_monitor_exception)
 	 * prevent hash faults on user addresses when reading callchains (and
 	 * looks better from an irq tracing perspective).
 	 */
-	if (IS_ENABLED(CONFIG_PPC64) && unlikely(arch_irq_disabled_regs(regs)))
+	if (IS_ENABLED(CONFIG_PPC64) && unlikely(regs_irqs_disabled(regs)))
 		performance_monitor_exception_nmi(regs);
 	else
 		performance_monitor_exception_async(regs);
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 764001deb060..c40c69368476 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -376,7 +376,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 	u64 tb;
 
 	/* should only arrive from kernel, with irqs disabled */
-	WARN_ON_ONCE(!arch_irq_disabled_regs(regs));
+	WARN_ON_ONCE(!regs_irqs_disabled(regs));
 
 	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
 		return 0;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8b0081441f85..f7518b7e3055 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2482,7 +2482,7 @@ static void __perf_event_interrupt(struct pt_regs *regs)
 	 * will trigger a PMI after waking up from idle. Since counter values are _not_
 	 * saved/restored in idle path, can lead to below "Can't find PMC" message.
 	 */
-	if (unlikely(!found) && !arch_irq_disabled_regs(regs))
+	if (unlikely(!found) && !regs_irqs_disabled(regs))
 		printk_ratelimited(KERN_WARNING "Can't find PMC that caused IRQ\n");
 
 	/*
-- 
2.53.0


