Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797A606A32C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKymwn+Q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6nV66W7z2yRZ;
	Tue, 24 Nov 2026 00:52:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441934;
	cv=none; b=bWpOXumemiSawYmelzkRgV4pwkm14gYEpYbrGoM3dARcZFwl9GSulmhi7IO0l4CX5OzTinIE9rCtWv7RVYN0nWykxKdzxRbokIo+f1ByroT5EZ/1g160XKgwdpFy6W0jNxAQQ8Y1bHkmWaDlokhp85VNyCbWvD30y3wuaFML2GzscZR3tJPUrMSgWp8bvlSlpN2ne5aEd93NZiqS6PtA1tkDOZkiapE7b3HXBklhWedJG6NcgPiDldeAuruNghf5QnKZ+gk/31+PHiVP/K7NYVfqJVZt7Fm4wuq52wKzb/Xr43uwgYtCMbBo2UN4iymQAo6fBppdsrDOFE3A8UoETA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441934; c=relaxed/relaxed;
	bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSWIhp31rXv0b3Rr3vTdgZr710o2MfLKINoc4eya8ImPsJ1Z7f4NBvuXG9WOcOHXfNodL55qhWcdPHazWuPpFQeM7xwJHrPtnVXbxsPW3NYrHJyuAQtHK8AUfQ9vlmqge5sRbjoPsiX+pJ6q8NB3h5+Yw+WCb3kVZ+L4BoFszr0jvbb7uTkKIch2HY6zmv0bzACoXVyAmF9LTodDiLmzMkJdyekkhA3shHBIvPqK83YDlmAr1GGOcftxkWdMYdlCYf3UFiFwvK7X/9IktuNScqG+t2pgk91/68Wjdij1j5V4b8OgHUNcodbViEbZ6cyEIryFLenZpMMT/B4aSyc1Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKymwn+Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKymwn+Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6nV14HFz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:14 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1660438a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441932; x=1796046732; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
        b=aKymwn+QlSXwWcEziNgmDLLvMSVoZblPqgo9eqCcvxsBxBw5LVJ5HWXQXNzmbqp9/z
         HY/yUBktsUiuvTKzuidODStF8BH3IhyluGnWffPVM9ZfCn1YjI8cWXrE/ckj+1g0/rTk
         ADCAATeVmfFKEzp7468rzJwX4YSpgqcGHdqx6gWd6Q6vUGhgqs96kDeu81/Ifm0HOmFH
         CoJjuyVXt5BHm3+vcXQtfUIC3xGOyrks3lriRdyaxvZES1McEQyArH5ZsNiqKwf8jbVt
         Kyc3VComyNOoeaoFNSTgZqkEEn3UrDa28f7zAsbWRTswfaUscbbf0KT2NeiarBCxTD4j
         vHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441932; x=1796046732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
        b=0RKAGA0Ad3+0LZPcXXVzf66NFsI1NWQKLLlmY0g5Sy8kwYRJeNcHyUmhAmGHEpYYLq
         U+AsBZ0dgFGIDF7VVWMQLDdhR+bMOOEmDfGQMHIN44FNtT0vwEDfjEq3aRgbvJYbAWv+
         DLDJfMcAx8J5Dl8p9vJTTWccl7Zrh5fpE8lotC8pzeeKDkfTfKSZWfZWVSTw+ZzUNnZj
         vkl2G0p2ZI6LUG59AE1+sV+QomGnNsGUztPdOPe+YJXqJrXZmuFpOXnFEmZ4xfWwnTQT
         dDhJS7halPp9SdL6x/QddU7wcyTIn0pr+1CztyF7M3P2rNc8qOwvP7R9iybGX54cR8JY
         RvUQ==
X-Gm-Message-State: APuU4Z8o0nQX4yDkZf0haJukKJvZOHaJFeVCoq0PvinvWpvZ39X9rWRU
	NFX95V+GSYMPL4YvzTSzPG3RfFNV0/SQI3xRFAleb8SX+H4h6mqgNM62Xgaa+A==
X-Gm-Gg: AZFdTZe78gWj77Pi9y3nkDEHcIrusQYCfxHddnXD3bWLFiakzmuRA0le6ctMwFdlGpg
	eb8ulw5Un3MIjzweLD1MW2eVsZn2AJ7BXD2Me8FqyJpIyZLJZbpsBa58wEGbrLmyYBtKLzBg5cr
	GNHpgD8s+w+EnZVgIDGyi6VbtkoARaJaaUlZsJfbLP3OhwPq5q8Hf7MXxeM/PbDm9T5ci7jDutU
	4wYQ5+3CwoHu4iQtWJgGMWiZZOm/Gbo2At4V/Pr+RZdKhNofGGcSUpvSMSwW/7y9IG9EMittMrN
	ND6QiXVsqIr/QZUZRvLUE2dLb4biruj8IIvpyv03KaO5VQ9pDdoPJGtcGUxWLRlG7UPTH/OlfwF
	l6PAxMErO3LBURoCTf4GAkEdDKsrvWJNvUrpC3GRcqqv9XBaAaAaYhUyr7sKIV63dzXGURzKwjp
	8f63Ok1KvlLToCS8VwhNj8TTzgZUrZcF2/7qW9n+yHpD0l3+KSNis0KPzTG184CLOZ+FumhQ1PV
	RuV5kivAQ6M3KPHoZZeqIWHzJj/shXHndxBaBZjblBzyGuZVBTeeLQrg5m+d/yA4FEv5xVUjar4
	rsnTit5zDCV0We2DtrAsbI/NTXtKsWY8ljI=
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr10570164a91.20.1795441931768;
        Mon, 23 Nov 2026 05:52:11 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:11 -0800 (PST)
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
Subject: [PATCHv3 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Mon, 23 Nov 2026 19:21:50 +0530
Message-Id: <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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


