Return-Path: <linuxppc-dev+bounces-23725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA7C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 17:24:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvp4r5SXHz2xKh;
	Wed, 08 Jul 2026 03:24:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783445084;
	cv=none; b=T9SO1fk/WSkC9j6jCLhqgFrkUMd0GKd/MS+/8OQxLnfgjDQeq/pR67buOPnoz/6qLV3KTh0lkCac8/8X5Q7Q2rl0uoxh/K5aSJX+Ni+iaMA82Ifn+weUlsrr7xi5V729erPDxCoUEW8vE1v/0Cg8wcigJJ54sqn/HhGdDvHLhtJ3OS6SxemuPRA/sMiUvT4fXtCOmWZorY0HrdlS5hZmMkIfr1bri8qD93W1Baq/edVilmH6XW1Tl4avY0rhpyHI7C0QOrikH6AIBqI+9WGUzFmjmh8SS3neiK33W9lTB+SK+yCGEif34rsCxMxJXrZPzhF8oTQr7Nml2ovxhW0AGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783445084; c=relaxed/relaxed;
	bh=QVbkKIpVgqIdeBkCJKcg7TksfPhMWq9fBiNA2uIiNXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eULosVL+rZZR+DY7UtpT4Qk+ivgAFajCa1GPN0cuajpD1NtlN1+hHpLGAiC2juf5mPOOxdlNEDnFKKkLP7/CZSen37oOZIBCXbD+at/uahNokyCbyvtWWw/KSGL1GtEtjQaz93VWBt+g6hglcWXINmx3pX9bHC+oo34UzT+eDp2wXLDRD9GkggfeS57Ai3NtfHAZiMGd2sP61ooKJzoM4M5IrKkG+M6J68dNZEkg4VZc5nncjxMSuu/2TsEETKpAN14q1t6yCFWrkKEiYmPhBPodvkgXa0tnRycrHwVCeEZegWUKzP/Ddvo2sYVX7qLLiUKC9hT/C7keAF4hWJzUdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EAFZK6uw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EAFZK6uw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvp4q46H3z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 03:24:42 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2c7cfa17fedso52560655ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783445080; x=1784049880; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVbkKIpVgqIdeBkCJKcg7TksfPhMWq9fBiNA2uIiNXc=;
        b=EAFZK6uwmK5CZqqCeehxBjP0JpNBTFSkE6ul866JEzY0NlY2AA8Hf0lk4q/ExNBNuB
         kSf/9FNdkX39YoPfuKYTDiOTNLvrEQ9wZBBtKRULnq+isUZcO6XOQ4ip9k1l0/AtfWB8
         1RuJ4oTo1QRRkf6GWUVAmVCCVrsAPTTvudTXVIEZHQEb+bKdrvUw9QPIcOoRZKI+3sMo
         6tHu0AAcibLSI+wYV1kaEaZQ1T+dAvtBu8m6Iun6gCO90M5Yk4Z8WERg2ElLjJ35qB7c
         9O1o4+e3LcoQakVB3EIzdquD1SLhwkFaeTdWQiYaMxPJ1+8l4CSOw176zDLxntCBzovt
         oPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783445080; x=1784049880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVbkKIpVgqIdeBkCJKcg7TksfPhMWq9fBiNA2uIiNXc=;
        b=L/+breCMdH8tyhUumSG8VhZBM89aKZfFDn26iq7wXHbq01X5sqIVNtTrtk8yoGXd2B
         UQinlofXnpTmgpn7bdvbMRbxsmyLNixWCagD5sRXx/f9uSfCNlWk8V+LY2LXFHxKLF/z
         6pPPvJVxmsC73O3TWCBwpwIdfuQf7cn5ircAu511RYrtTgmBc/m4ImWbqC2TfNAf1cwg
         FeZmcL8Rta0r9OwZM12NzDmvXUHHqnDOtUU2UFWYVrMri2JxR1SBltUnwcOLjRfKeids
         8VkJ4iBIsgvEkcmhdrCf/hg5VLHn8B8RCXKTjVqCaxIiLuZMgEmQDPJ32k9uDzLDElZc
         kwJw==
X-Forwarded-Encrypted: i=1; AHgh+RqljoIVKGw/zAA4xRsf2jBz1dB3S3grfik8qrzk6IX87adU6TduG9N4Zhpj/Aj4dS5Er58yQs/B39qzQ/c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmFpFE/PX0R6Pjom3ET+rmQSw1pN/2r1UE4YS5Yr1QPoBwtk0o
	w6sPQwQ7q6eHcp1ngS9ek+oOm113rde0kPsiQjlqBgNDCCtbj/90gN3D
X-Gm-Gg: AfdE7cmBC1hxvTtcqS4d7OWHqUGgVIYwLHOlTDpDZ0f7hkRxH4RdQ6k5uXNwMXUpLNn
	bZEQNgxgRq22WE+5Ripp0iCYshze98GkijGoLva9i4xQjaiQ03Au+waHKI7Xq1Pk70sVmaT4T26
	9j37GdO3ocTzyKEF+LPpk215bUug7FIH6gMutFSU+0kGFM6XsgGW3DgGsEGJhOU2QuN3Dg2MlBw
	trWBO7w8QjddNxYbemlGj9kojmT13mdVDiOUTl6FhZeEpHRhAgTok0RropLkFXoozGYumq3F469
	8D5b97Z35JYcC963x9clOOsaGvdTXwjcZFgDBgRSxcgbA/56tDz0UCgw2S4XppZigRO+0TPrGqt
	QZyjsvU/Q+ObFusETiG9Z0kaHK7i5lJCxj1wqwEQeKCYGzN68tA0vNwMsnYY78USaugaYxW03I8
	bE39Nqm1Wic9E46RK61Bb4KRr5mI93dPTZRGaCJU6YNX32Qc1pBKi24nGQtrMScaDNxQ==
X-Received: by 2002:a05:6a21:50f:b0:3bf:c126:baf7 with SMTP id adf61e73a8af0-3c08ef51a7fmr7588434637.47.1783445079945;
        Tue, 07 Jul 2026 10:24:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8665sm10569833c88.10.2026.07.07.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:24:39 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mchauras@linux.ibm.com,
	mkchauras@gmail.com,
	ruanjinjie@huawei.com,
	thuth@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] powerpc/970: fix nap return address corruption on async interrupt exit
Date: Tue,  7 Jul 2026 22:54:30 +0530
Message-ID: <20260707172430.790040-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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

On PowerMac G5 (PPC970, CONFIG_PPC_970_NAP) the system panics shortly
after boot with symptoms including instruction fetch faults, kernel data
access faults, and stack corruption, predominantly on SMP and always
somewhere inside softirq processing.

The PPC970 idle path works by setting _TLF_NAPPING in the current
thread's local flags before entering the MSR_POW nap loop.  When any
async interrupt wakes the CPU, nap_adjust_return() is expected to detect
_TLF_NAPPING, clear it, and rewrite regs->NIP to power4_idle_nap_return
so that the interrupt returns cleanly to the caller of power4_idle_nap()
rather than back into the nap spin loop.

DEFINE_INTERRUPT_HANDLER_ASYNC generates the following sequence:

    irq_enter_rcu();
    ____func(regs);           /* timer_interrupt / do_IRQ body */
    irq_exit_rcu();           /* softirqs run here, irqs re-enabled */
    arch_interrupt_async_exit_prepare(regs); /* nap_adjust_return was here */
    irqentry_exit(regs, state);

irq_exit_rcu() calls invoke_softirq() -> do_softirq_own_stack(), which
runs softirqs with hardware interrupts re-enabled.  A nested async
interrupt can therefore arrive while _TLF_NAPPING is still set.  That
nested interrupt reaches nap_adjust_return() in its own
arch_interrupt_async_exit_prepare() call, finds _TLF_NAPPING set, and
redirects *its own* regs->NIP to power4_idle_nap_return.  Returning via
that blr with an unrelated LR on the softirq stack jumps to a garbage
address, causing the observed crashes.

The comment that previously lived in arch_interrupt_async_exit_prepare()
even described this exact hazard ("must come before irq_exit()"), but
nap_adjust_return() was placed after irq_exit_rcu() in the macro, so
the protection was never effective.

Fix this by calling nap_adjust_return() inside DEFINE_INTERRUPT_HANDLER_ASYNC
immediately before irq_exit_rcu(), ensuring _TLF_NAPPING is cleared and
regs->NIP is adjusted before any code that can re-enable interrupts or
invoke softirqs runs.  Move the explanatory comment into
nap_adjust_return() itself and remove it from arch_interrupt_async_exit_prepare().

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Closes: https://lore.kernel.org/all/87wlvazrdy.fsf@igel.home/
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/entry-common.h | 15 +++++++--------
 arch/powerpc/include/asm/interrupt.h    |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index fc636c42e89a..c5adb5006361 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -66,6 +66,13 @@ static inline void srr_regs_clobbered(void)
 static inline void nap_adjust_return(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC_970_NAP
+	/*
+	 * Adjust the nap return address before irq_exit_rcu(). irq_exit_rcu()
+	 * may invoke softirqs with interrupts re-enabled, allowing a nested
+	 * async interrupt to arrive. If _TLF_NAPPING is still set at that
+	 * point, the nested interrupt would erroneously redirect its own
+	 * return address to power4_idle_nap_return, corrupting the stack.
+	 */
 	if (unlikely(test_thread_local_flags(_TLF_NAPPING))) {
 		/* Can avoid a test-and-clear because NMIs do not call this */
 		clear_thread_local_flags(_TLF_NAPPING);
@@ -286,14 +293,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
 
 static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
 {
-	/*
-	 * Adjust at exit so the main handler sees the true NIA. This must
-	 * come before irq_exit() because irq_exit can enable interrupts, and
-	 * if another interrupt is taken before nap_adjust_return has run
-	 * here, then that interrupt would return directly to idle nap return.
-	 */
-	nap_adjust_return(regs);
-
 	arch_interrupt_exit_prepare(regs);
 }
 
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index fb42a664ae54..1b45a49e9bed 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)			\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	____##func (regs);						\
+	nap_adjust_return(regs);					\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	arch_interrupt_async_exit_prepare(regs);			\
-- 
2.55.0


