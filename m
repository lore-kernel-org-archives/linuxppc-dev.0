Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C814606A332
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqXeIoTK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRps4Lpnz2yLF;
	Wed, 18 Nov 2026 01:25:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794925541;
	cv=none; b=Ge+P0HezCfQKbo6HysOT1iO2L5FQg81fAQEj6FKStejRuXLhAl9CxFOKp0wnFXJWLXpd4zmef3YHQHrYRtFOYOshH+VvZWTBLUl4kQYQKboUoC9oNVxQ6Z/3X1k2Wn1r90ADfmte6y8r0FT5IG73O7IFuc8IFFGB3WOFlcThkXq49fc8Ss2hZTtJ0kU8Q3XoUPen3+TYyjpq42EvZnayJjtDxoj0OIA24iWpDd6H0++kIz77qsZKFVri/rI+2PaL9hu+M2/SWnhIHfl9jRmUTkVQ3m0qMyh/GI2iHGnpQo8UcS56z+ToypIbhUxoS003qdldTwibStFgneSTUEz2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794925541; c=relaxed/relaxed;
	bh=cJ9sO9k+T8zaWbNVfOgYQ/LgwKnb8ilExNHXvYhGb+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jabgUCviSXlfiPZYx4qEEx85jORXLrTx3a8YWE9U6Nupp0c/CkGloZSmQobc+7o5klk7TKKCjkUXo4Vamo1BUxwBPlvkYD1ORiKLliSX1bzGc07flvtwUzYecJPJkL0mNb9XMtfYuH8487WZzIjPKK9u8IgprMuUg7OyV1TvDgC8YmWaQFcJ7q50y5zsjcMR29pzNJNRUNYun2oNQzsVYwHtHOrnf2pEp3xZ5f1pZDEeje3JksDgwVGNOPoDZuSOeYpHZ+8yutfHnMpgwGo0An4CuPSnxu/9Wn7LlETCT3cVBRidDDF1xa9DyTfoyWsUqe7R24O2jmGLxq2/5c4wOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqXeIoTK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqXeIoTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRpr6MS7z2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:25:40 +1100 (AEDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-70059e4dab6so3258564eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925538; x=1795530338; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJ9sO9k+T8zaWbNVfOgYQ/LgwKnb8ilExNHXvYhGb+8=;
        b=OqXeIoTKn7bSl7SjbHEakIrh/9OWGGaTl1kC/murxDjzLnMOBZRC1O5fIzdbYQNXoD
         ADYGwV2UdOrgsezHwmD6wZFWkB2ZyP0BqwGRv+x1risFzZSMxEAp60ZhXpLkS+OkMjjF
         9EHsu5he4Run7jMKpTaOhEyGTIIYasYNE/Mk/YuuUXWuAXZFuFdNHUg+X1yQdGqnaJmI
         4ITqC516K3wc6rtGdnlY5UkBr1s98XqR/SinhqdfTBg92uSX5h206NlZYNKmsCL6teNI
         9TebsQRlq9UyTQX+W8xq5VgUIUl5mGg8nsY4RrqIK6Cr0L4s2Y9unI2bI8XYU/yk5epD
         3YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925538; x=1795530338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJ9sO9k+T8zaWbNVfOgYQ/LgwKnb8ilExNHXvYhGb+8=;
        b=HHQj6ncTEkp0XxOqI0fvx/AqXZPlidUW6kTXAIZUYObzMIUxn6TSGSsRw7hoc7Ubgv
         u52OxCnllW55g3supMEzuZGjaZi6bkKtMuo2c6YqU0NDpg7whh7x/vxYMXyoKMHhtesm
         gvl8HvfH0As5t1RG8BorofghSXgL1tkJaX3gDzL7nk2VxWR5lmOcVtSg4d+CQ/mQJ+37
         CSbyJ99VWbSksTLGCv43GXhtySEw/GRuTQcGZA7GTqbYVp4ov2UMukAv16Y7yrgH8wJk
         yv6gJsiXJZPOTeXLG46v69i0FgrNxqWgm4a8pi9GkEQ+m+PCKUH5qTgAYtM1F4BDjLye
         IQfQ==
X-Gm-Message-State: APuU4Z9gfJ44Y70rhkW/A83setGtGhHRRm0fU54oEZJF6zUhv2vRGKnl
	q1tU8GqKDK8fKgKdSjDAoaqEg26YLj6O9y1pTDiqCxkJdRsU0wuNbZMBZNIuG9/V
X-Gm-Gg: AYBFou0oaydXqL01QTvmWJyST1peulRpCV/NzjVnSGbTlfJtSk6rJAGdn8iWHJGMKYo
	57j/oopWgoApg/vh0wNLRU6Rb1+znCQMp8PBrXPcZB2j/TY93cul9Rpbb2mhQaTrzS8PsRdCoDU
	epTB8iokounpS8pMkg5WKVjrPlU2EJPEwM4JgT/MwyeVmwKUyehd5+5tEglABTCHTC0toly7ulP
	kpqckCQoW6l/rA3GJkMk6EC/Wlt9z0AJrgwnfzUEdv9G3L9K9x5kx4kTqoL9asKFJxz4GHBRha7
	vk2tIz4hkJpKkcCZTBX2S/zNbYFY95CrbTDrDVgyMFMnNiTVUGJqKCx7Tg0NP7pC3SG2W+pa5F/
	rXBW75DjLvSoh6DSKUKybfw/nrepXpIJGMCdJO5BTdfnwcHXpg+BmCI9phdvkRDlFIjBR/Ogbu8
	eRh/MJncZy9+UxouOueX7Fn3xTVi3gld22u73774fcSJzG3FuVcO/tHgsLFdJSmsbZTrCTR3XfK
	qMSEErQVlqh49d9m7+pEYaluilPyf9Qs8LMA9YnyStaHWFXYpmp0UJOh0XBejAnrBuxzfs0+tet
	wLbyPvVgqh68xXp1UFOP63m3CTUjPI7VBg==
X-Received: by 2002:a05:6820:169f:b0:71a:ee95:bfe5 with SMTP id 006d021491bc7-71aee95c36fmr4678633eaf.26.1794925538329;
        Tue, 17 Nov 2026 06:25:38 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:36 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Tue, 17 Nov 2026 19:55:17 +0530
Message-Id: <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With PROVE_LOCKING, boot warns once and lockdep turns itself off:
  DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
  WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
  NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
  REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
  MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
  NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
  LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
  Call Trace:
    lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
    trace_hardirqs_on+0x98/0x11c
    irqentry_exit+0x64c/0x1064
    timer_interrupt+0x274/0x6bc
    __replay_soft_interrupts+0x158/0x380
    arch_local_irq_restore+0x1cc/0x244
    console_flush_one_record+0x438/0x654
    console_unlock+0xb8/0x1e0
    vprintk_emit+0x300/0x56c
    vprintk+0x20/0x34
    _printk+0x40/0x54
    lockdep_init+0xdc/0x104
    start_kernel+0xa24/0xc68
    start_here_common+0x1c/0x20

Since commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") a
replayed handler always returns via irqentry_exit(), which traces hardirqs
on while the replay is still inside irq_enter():
  arch_local_irq_restore()
    irq_enter()                        hardirq_context = 1
    __replay_soft_interrupts()
      timer_interrupt(&regs)
        irq_enter_rcu()                hardirq_context = 2
        irq_exit_rcu()                 hardirq_context = 1
        irqentry_exit()
          trace_hardirqs_on()          hardirq_context != 0 -> WARN
      next_interrupt()
        lockdep_hardirq_exit()         too late

Leave the hardirq context before each replayed handler instead of
after it:
  arch_local_irq_restore()
    irq_enter()                        hardirq_context = 1
    __replay_soft_interrupts()
      lockdep_hardirq_exit()           hardirq_context = 0 // fix
      timer_interrupt(&regs)
        irq_enter_rcu()                hardirq_context = 1
        irq_exit_rcu()                 hardirq_context = 0
        irqentry_exit()
          trace_hardirqs_on()          ok
      next_interrupt()
        trace_hardirqs_off()
        lockdep_hardirq_enter()        hardirq_context = 1
    irq_exit()                         hardirq_context = 0

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/irq_64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..b189e796eb34 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -75,12 +75,6 @@ static inline void next_interrupt(struct pt_regs *regs)
 		WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
 	}

-	/*
-	 * We are responding to the next interrupt, so interrupt-off
-	 * latencies should be reset here.
-	 */
-	lockdep_hardirq_exit();
-	trace_hardirqs_on();
 	trace_hardirqs_off();
 	lockdep_hardirq_enter();
 }
@@ -137,18 +131,21 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
 	    irq_happened_test_and_clear(PACA_IRQ_HMI)) {
 		regs.trap = INTERRUPT_HMI;
+		lockdep_hardirq_exit();
 		handle_hmi_exception(&regs);
 		next_interrupt(&regs);
 	}

 	if (irq_happened_test_and_clear(PACA_IRQ_DEC)) {
 		regs.trap = INTERRUPT_DECREMENTER;
+		lockdep_hardirq_exit();
 		timer_interrupt(&regs);
 		next_interrupt(&regs);
 	}

 	if (irq_happened_test_and_clear(PACA_IRQ_EE)) {
 		regs.trap = INTERRUPT_EXTERNAL;
+		lockdep_hardirq_exit();
 		do_IRQ(&regs);
 		next_interrupt(&regs);
 	}
@@ -156,6 +153,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_DOORBELL) &&
 	    irq_happened_test_and_clear(PACA_IRQ_DBELL)) {
 		regs.trap = INTERRUPT_DOORBELL;
+		lockdep_hardirq_exit();
 		doorbell_exception(&regs);
 		next_interrupt(&regs);
 	}
@@ -164,6 +162,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
 	    irq_happened_test_and_clear(PACA_IRQ_PMI)) {
 		regs.trap = INTERRUPT_PERFMON;
+		lockdep_hardirq_exit();
 		performance_monitor_exception(&regs);
 		next_interrupt(&regs);
 	}
--
2.39.5


