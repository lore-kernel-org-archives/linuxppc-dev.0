Return-Path: <linuxppc-dev+bounces-26019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42A7C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:47:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQl9w1mLZz2xRw;
	Thu, 20 Aug 2026 23:47:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787233652;
	cv=none; b=MHXROZi3LL8oF7oQouHstUbH9CeGt44nM2VsR5xR5lunRXc94l2Ki6YMvo6jHA25XDObBqMYgejTeNGvHDCREUAt4vu01sQK8HJmpxV3ZfdVRXLPbkiE6nLqLlBWczX8m2QJe7nG6W5Wt1/JQhDHqfzxFDyvJnjY6ji84MHk6vc2tom7yqJ0n3wMuW8Wl3JlQFPHEGJFhNDQJ0gcscfzLIf6lpYDckQ6tFG0NZkdk3aWxUwnm2PXx2p3r4gnnXXPITNmz0bPeCihzZ3xtxqlGx+oIT7YUAuCmtOwHmdHevDfS53W08ATI8HFaRSprVFCkM0FsjB7nwij+6DUO4vIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787233652; c=relaxed/relaxed;
	bh=/+Pb2p46WtdccY744klNVGN4hQZyY0c6jTVm2kf8RI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBoW8MHJvN3XIul25l6a2Fe3erRpROUODIDHXwVNw4rCTvkz3YsiEEGwYRXXkpy/UlN0u2WxWP/ae+nFdvrYDNa45KhRtolGArYIO7w96Mo6dmhu5JW/NUzQOQRHj6GkfvbGoqNziHDhU2p+PKYH/ft89N1vyjFXDNPOkitpPNOoMfnriVIZ7WIu8i4fH/majUCK2Yew1H0QJGcsH1D8Qbn3NA78F1cW5PgpAvKPcPrJJs1dJu3uKKnT3/g+mrOFP2TzL2quclk4aYXlFTHWj+SKB+YdoZ55jVa0dTYg8GZ/mehA1UJDjkMl0R8OZfDdKBYA0Ze/yoIatIiTi3HbMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KS1tF2kE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KS1tF2kE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQl9t5m7gz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 23:47:30 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1434668a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787233647; x=1787838447; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+Pb2p46WtdccY744klNVGN4hQZyY0c6jTVm2kf8RI8=;
        b=KS1tF2kEWirilVe7SMFHlY5LvyukCDvm3QSKSMIizPVoCKxdzErpNu3PJXkexnU7Et
         rH6SEyDksQARAEAIzOnq1WVe9vvIt0BMhMLtknIWItyAdOYwGKuxCwMRikf5vPhE21sq
         PnhGBA5wBOJNwRfrskGfegw7etrTQwUeTDVA4tuJ/ozYBUNSfShK6Q3PeUxfQxIQB74h
         nYY/ADdL4t3m9uiWqoYWcwV4nFK2sy73iTZ+JdjRVh7fA0WIGPPqnDVi7nTDFRyA69H1
         m/i4cjANVIXP7O4FFJKPXOvjTTawukP3ItbVGN/C/f7tMm/ICk45G1a80eIVtUcON+yx
         2WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787233647; x=1787838447;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+Pb2p46WtdccY744klNVGN4hQZyY0c6jTVm2kf8RI8=;
        b=WwcC5YL8dH+yfegcEQqxJaqiKAiIFS4MhxyBaaTZ9PFHJXULedYV3PzEYp0VXqCISr
         kmq/3Lmz+TJOZYtO1/eA16SUNRzzGz6Dmnu0geKcE8q302Pk9P3SS2/2npFDyYLVBs7w
         B3afKCAKrI1UqumhkL0Ajl65I2QUBb5MeWaHKC/PtXg0UdEbEHvLZlqo9gj3qmTyvMVP
         F2wiBZF6dwEqAl2JMSSbteg2TXSz/leuwYb1JlaWlPh1LykbsaFYI6kS8ibpdB2IzlTY
         bV500s2bkY0HGYe49GMbcvFiaYyQFTfwTx1ZEnozZlPvgvJJ8kBrGt+R/ovtQYx935i9
         ybaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKAY5Oaj2/6HnTiUBqYIRvUwsJlf+xirbCPwmBvC/OlvQxvctNewdORXnNT8D7jzVfjkhuUCmTmbFpAE8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l8eZNuXVOn5bypXdo90cDcDwvsozOCaA6q59hHXE4L7Fz1gDqZ
	va9K48UdLNSiHtZOgM3b4FRm+XI1vIKy6BSFaoSks2F6dACP/ccbEh6/
X-Gm-Gg: AR+sD12NDrVdrMxkc9C5820pi1SEiO7LPOEInfqbiQBXihBq1mxDr7YT9w/fZB7OOlf
	wvNWf8ez47h/yqbqd1ek7oAIhCljQo+PK2AXRrAIg+6oVkJJdiJCP/jX3W4VSbNLCHAYYRSSqI/
	4jX1RGjfHXUd1mlGGwe9JBNsrKUtRmDiSbFZ/LntJk8Vz+XTmzVcVtBl/5H0itODx5F1DZxIGPk
	PSGPfxMaNry6Ekt95swPvcoTaLuL9tg8cMLKWZQK4E8TuJfj7jhQb/gXWMboT4qBvzvR38gPGIJ
	LIAi74Wbxclex38sHEflraZk2mfyta4z3WxR9BN+JDj70hN8toLBwsiznEEx8GnKAhJ6a2b/Rv9
	7Lak5pwjA4qD3soESew6kLoyQtzZ5tqPRw8SVjtusKh1oO+4Opi9B9zs2Qndzm9/Stc40iVE0Rh
	bRbQS+gU47MurSxLOAhvKrlAz/rsw0umZL3Wwv91FirT0tiiKfP3dm6WNQZqCDVEhHI4yZ8AaKR
	mY60MgsXsVfPQ6mT+/nNutVVGeITsQ1U/4ypPpomA==
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39580a4d031mr24899716a91.3.1787233647352;
        Thu, 20 Aug 2026 06:47:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10ca5csm17410270eec.17.2026.08.20.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:47:26 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mchauras@linux.ibm.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V2] powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit
Date: Thu, 20 Aug 2026 19:17:18 +0530
Message-ID: <20260820134718.2176411-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When __replay_soft_interrupts() replays a pending interrupt (e.g.
PACA_IRQ_DEC → timer_interrupt), it calls the handler directly with a
synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
each handler calls arch_interrupt_async_exit_prepare() on the way out,
which calls arch_interrupt_exit_prepare() → local_irq_disable() →
arch_local_irq_disable(), which does:

    irq_soft_mask_set(IRQS_DISABLED)   /* 0x1 */

This unconditionally overwrites irq_soft_mask with IRQS_DISABLED (0x1),
stripping the IRQS_PMI_DISABLED (0x2) bit. The result is that
irq_soft_mask is 0x1 instead of IRQS_ALL_DISABLED (0x3) when the
handler returns to __replay_soft_interrupts().

For a normally-taken interrupt this is harmless: the next interrupt
always enters through arch_interrupt_enter_prepare() which
unconditionally sets irq_soft_mask to IRQS_ALL_DISABLED.
But during replay, next_interrupt() is called
directly between replayed handlers without going back through
arch_interrupt_enter_prepare(), so the stripped bit is never restored.
next_interrupt() then fires a WARNING:

    WARNING: arch/powerpc/kernel/irq_64.c:75
    WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED)

This was introduced by commit bee25f97ad24 ("powerpc: Enable
GENERIC_ENTRY feature"). Before that commit, the old
interrupt_async_exit_prepare() called irq_exit() followed by an empty
interrupt_exit_prepare() stub and never touched irq_soft_mask at all,
so the soft mask was left at IRQS_ALL_DISABLED throughout replay.

The root cause: arch_interrupt_exit_prepare() uses local_irq_disable()
whose only job is to set the IRQS_DISABLED bit; it has no knowledge of
IRQS_PMI_DISABLED. It is there to satisfy irqentry_exit()'s
requirement that interrupts be disabled, but using the plain
irq_soft_mask_set(IRQS_ALL_DISABLED) is the right primitive:

  - irq_soft_mask_set(IRQS_ALL_DISABLED): sets soft mask to 0x3
    (both IRQS_DISABLED and IRQS_PMI_DISABLED). Touches only the soft
    mask. MSR[EE] and PACA_IRQ_HARD_DIS are already correct because
    hard interrupts were never re-enabled during replay
    (PACA_IRQ_REPLAYING is in PACA_IRQ_MUST_HARD_MASK, which blocks
    should_hard_irq_enable()).

  - local_irq_disable() / arch_local_irq_disable(): sets soft mask to
    IRQS_DISABLED (0x1) only, silently dropping IRQS_PMI_DISABLED.

  - hard_irq_disable(): also issues __mtmsrd to clear MSR[EE] in
    hardware and sets PACA_IRQ_HARD_DIS — redundant and wrong here
    since both are already set.

Fix by replacing local_irq_disable() with irq_soft_mask_set(IRQS_ALL_DISABLED)
in arch_interrupt_exit_prepare(), making the exit symmetric with the
entry path in arch_interrupt_enter_prepare() which always sets
IRQS_ALL_DISABLED.

The warning was observed early in boot on a POWER10 pseries guest
during kmem_cache_init_late(), where a spinlock release triggers
interrupt replay that processes a pending timer interrupt.

Debugger state confirming the bug:
  Before timer_interrupt(&regs):
    irq_soft_mask = 0x3 (IRQS_ALL_DISABLED)   correct
    irq_happened  = 0x41 (HARD_DIS|REPLAYING)  correct
  After timer_interrupt(&regs) returns:
    irq_soft_mask = 0x1 (IRQS_DISABLED)        WRONG — PMI bit stripped
    irq_happened  = 0x41                        unchanged

Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
Change log:
V1 -> V2:
	- Instead of using hard_irq_disable use irq_soft_mask_set
V1: https://lore.kernel.org/all/20260812152035.1661781-1-mkchauras@gmail.com

 arch/powerpc/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..2a153dca962c 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 	}
 
 	/* irqentry_exit expects to be called with interrupts disabled */
-	local_irq_disable();
+	irq_soft_mask_set(IRQS_ALL_DISABLED);
 }
 
 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
-- 
2.55.0


