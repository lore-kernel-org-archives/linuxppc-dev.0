Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD92606A32E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhHvFb0u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHSH2r3jz2yGT;
	Wed, 25 Nov 2026 22:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605983;
	cv=none; b=hD60M6rgUKZMGX42botdoOIV0cDeE6pzYfMAw9T4m5og0ce/59OuCBtmxamWIT3TiLz2DXNvJKVh/F1OQYPNR9i0qxTYZz81yVb5+dI/UaSUSmIrrbuj4FjB6mjTwadxcEWG+iasuU2sUZXJPEJb3ig0aQurUvBdGPkrXrLnnFLtBrOidx+TppzmDZUUfuwfQeHNwSc7GnQtZ/JSJW6TPRsdtefLZL7yoOXZlBA+5HpCNbX0/fd2+QqbOQi5A6JA4l8ZKwepCynW5qKSlVXkDKcbdJwT+VP5S+zrMtTZC1Apcu5blrrNVs9L/httiDkfrU8kk5/j+1haZGqgde7LzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605983; c=relaxed/relaxed;
	bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdJUcZ5zDij08dD4bNJkNtu4XQgCWeXL06busacHJ/XPmMBn5sjbwoh4fhD2NHWMUJSt6JBKT0XS/YkQFIInkGyw6fijalL10NQfsW+WeSakiHqvk8UrqLJTD8IDC8LAbQOOO/PzE/y7n4oQrBkcxEQMy60nDlqJG5bgeIZU4hcblZ08Cqvx2I4jKGp165a8Kfags8U0NNWi/RmWW1r0budiS6VK0nUm5yXp0Ztj3HsIHC0L/7JMH9YRbi2Tg+R4gBKxqY69+ZfdG64+tVQ1/qAFxsba6MC6AEfLvwCSsARbjyvgUqdzkcTNB0ggBECLF3ETAwQnQqm1z8vY3ChbWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhHvFb0u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VhHvFb0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZHSG5q7Sz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:26:22 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-38644aedba1so8591572eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605980; x=1796210780; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
        b=VhHvFb0ucY6joOGeKj+SreqktFPPiPdjEj2baybnP4Yed1RAy/Lrm43JCBEluwysQm
         b6SANhyHh3Q/zYIzcHViAki/dIKyLtEi5294+mavoG9A9vcHy65/s79e0ZUYAsZC/Ps9
         Ooth8MlSs/TeY4F5vKFXyp3a5zXmvXbz0t4XLX0U7UfTopEGOYxQsvzysrcn+IFou0ys
         S94gaFbMY/0TUJOPbWYskfKepWuuStUc5QSIdZ7pzzcPbD44gDznW8nYIeKUYfUTPQyH
         N62kC2l/PxKhHFOWuMqMmbMiRvADazsXD4TlXpbzk3fyvIBfCkLjgSevSWYHVStgHr+/
         WQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605980; x=1796210780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
        b=PF7EBpmcyKGfuaSFScnkGFHzSn4U8s+lvE1kbk+vnoHIGlPDjeLEM5juLtBRMLUK5M
         5RqTIZZzADMw1Kkwk8SM3U9L4nKe7FqiqIqd6fAPdL2/rn1JzX9m+oWuhfPWZA3k+yA3
         rnKH4J4dlCHSZewbh3ivxSX99/89tckuQqgwmGZexcIL6B4i2VCpuSdKbJFIany6Cp3+
         usoVGYilVPfB6n5AwOcbaU8BmvWfIzs7aVe1dLhOvPALFA+UFK0Q9CyR0P59Ml+vr4j3
         yKikYzsBS7+qM9fzFWyBikmjmMhhGoHAEypR+giYlHhY9+9YI3qyBe3oulInQLASYpec
         hOYg==
X-Gm-Message-State: APuU4Z9xgCXRhYxD7lDjfTIXS5Tg6rXECj+ATui97LZx9RHHjet0W0AY
	kXf/7qP8O4DJ4eH1tzFzMDNckMifFWZ3uTeEzCCzmHJzFonxTqw8B42amteK7A==
X-Gm-Gg: AZFdTZcH1SE6eQLndjS8lW5SlEDlWlCN41CkOjRZu1nweggR1fbV/23Tr5+u8FsHArF
	bcqvXpgVz+1iWRe+wRpQE92GgYK7Ot+4FSFeGdMQTwfBe6ybpfYMXrf14QvfxDbPmq7O5GQAt8C
	VFTQjSdc5vGFaIO5vI3OF/sXMCxxMvLWfBWk763WMA0fVYCNxmx7nepKPtiIXW3DFVSbkpimyey
	+YlY1FWHNGQ18HGds0WmXQ5k5xAItHwOWzRAWx/w/X+XfKisrsCNBoD7YMsWI0SLDKSuW+eayqP
	34vanznVJfO40H0rk6ODLyKma9J4f96VSXwXSXZhKqMR/qdoPl2FBJqeJWdkpJCFeusjBcz0MEb
	cEniKKbSpV2W7CXheGRmjzOnoiNEwRpuvdVlosv/Z6Rhs+Cepkkv5qv/CXtjNdULvW7USoOxrWB
	rBORjD70Xlwg3/mHjWv9DoNhcWxjWhGu0GnK2/PHMHYXWI1EM3JTWWGytyPYokj6vuCmCH9BbJi
	kUj8+81A/sfD2AwI3vAQtoTFZK8v/eprJEJx1oP8JyJ87JP9VlzDUAk3lPA62FZa1KlUSDujJ56
	8yhwELffYcdDPcFIebPSoSDta7tOWDaZ6Wc4nhHiGGqrDvC1zLOsChXy
X-Received: by 2002:a05:7300:7316:b0:386:c5d3:7300 with SMTP id 5a478bee46e88-386c5d37603mr5633447eec.12.1795605980290;
        Wed, 25 Nov 2026 03:26:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:19 -0800 (PST)
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
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Wed, 25 Nov 2026 16:56:03 +0530
Message-Id: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

The warning is triggered because trace_hardirqs_on() gets called while
lockdep's hardirq_context still says we are handling an interrupt. To
fix that, we need to ensure lockdep's hardirq_context and
hardirqs_enabled state stays consistent with powerpc's soft-masked
interrupt replay code and the generic entry/exit code.

With the current change, this is how the new state machine looks like:
                                       hardirq_context  hardirqs_enabled
  arch_local_irq_restore()
    trace_hardirqs_off()                     0             1 -> 0
    irq_enter()                           0 -> 1           0          (softirqs held off)
    __replay_soft_interrupts()
      lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
      timer_interrupt(&regs)
        irq_enter_rcu()                   0 -> 1           0          handler starts
        irq_exit_rcu()                    1 -> 0           0          handler done
        irqentry_exit()
          trace_hardirqs_on()                0             0 -> 1     legal: context is 0
      next_interrupt()
        trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
      ...                                 same for each pending interrupt
      lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
    irq_exit()                            1 -> 0           0          softirqs may run now
    trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linutronix.de/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/irq_64.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..e2f1e5b7a3a7 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
 	}

 	/*
-	 * We are responding to the next interrupt, so interrupt-off
-	 * latencies should be reset here.
+	 * We are responding to the next interrupt. The irqentry_exit() of the
+	 * replayed handler has traced hardirqs on, which also reset the
+	 * interrupt-off latencies. Trace them off again.
 	 */
-	lockdep_hardirq_exit();
-	trace_hardirqs_on();
 	trace_hardirqs_off();
-	lockdep_hardirq_enter();
 }

 static inline bool irq_happened_test_and_clear(u8 irq)
@@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	 */
 	local_paca->irq_happened |= PACA_IRQ_REPLAYING;

+	/*
+	 * The irq_enter() of our callers is there to hold off softirqs. Each
+	 * replayed handler enters and leaves the hardirq context itself and
+	 * returns through irqentry_exit(), which again traces hardirqs on.
+	 * Since lockdep only allows that outside of hardirq context, so leave
+	 * it for the duration of the replay.
+	 */
+	lockdep_hardirq_exit();
+
 	ppc_save_regs(&regs);
 	regs.softe = IRQS_ENABLED;
 	regs.msr |= MSR_EE;
@@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
 		next_interrupt(&regs);
 	}

+	lockdep_hardirq_enter();
+
 	local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
 }

--
2.39.5


