Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E324606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uN2iPi//
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTBD76VJyz2xqL;
	Tue, 17 Nov 2026 15:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794888791;
	cv=none; b=kNAhmrrTjx5gEArmxlTwmQt/rPjBAtfWg4sot3WboVTZMJNt/YZSv2yWwtGMPXa4OTqu1lGPR+fK8T4md9eWKmR8CX4ojIZ3DIKt+ASv4muWKsIy5+kQkqEwtLizkrD8bj/r3pAUPzKH9U7VGD/XCczGciQ75Khd37ul2SVjbIPgmEVBT+TTTuYKidWQKg8KP4PramWgQEyrVAH0A9Jz/rOHqponRe7T7rdmK/DYN9LZotylmoVWyxpqDd/B0hWTtaIPUPBv3mN3hBQvdlBNcdBUh1EfW6r1z4O2kJNvMwfIPtN32QtPBX85I2HGqfLSO1mtxRiuLejXyCv801PcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794888791; c=relaxed/relaxed;
	bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h01sfwlt1JgA1Nl+xweYNaDMBNYPc9yB7UcS05jya5GI7SezNykE/TI4gBC83TTCyf3JE1Rh85hrN1m6zDbIgILOstiuFfC1FUGiLg8Q8ffbgqFi2n+bFwZY8th0mL67btrqkgloA2ttfVXRgqZ9/DHmCDvlXjyQqMmoAXX5406atNpgTs4II/FBlKuUhzstMRa/Z8bBTjapCICkmgP6CuQv+rA42DHnVZuBBMdZ/u+DAMHmBnFZ7xEOxFC8h2vmt9KdYY3SAEDHupbQhPsqaHxcPrTucngtHeuhhzoCsyhPkVlpTcKXW6+7aC8UEJkoclKF9dQyJ8v+pRQ3gWECIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uN2iPi//; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uN2iPi//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTBD71HL6z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 15:13:11 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3791619605cso7756659eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 20:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888789; x=1795493589; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
        b=uN2iPi//zJLGnb8gzgA47VPi2NhiK8eZod0oQ0kRajB+3DQm0wqrrewfwSNPtqpAMf
         Vq+Ba9OQQrJ6IvqxUrGs3VH2+oaPe1DMnd0mG+brVBdT5WzwfAs9Nc1ca00rKAXgdt0/
         WeWVHHt5mR6MgfrTWx2QTduU+htEjvTzpNzqFKXgrUvuegNFAUs4ooHlL7rktCsC0GfM
         pQscAbvJT9PBiJt2rh35XI51yA+deZAlu+r4mfgIqVuyExwHtdVscTnwTeaONqe7AE1V
         ajUZK2mIRZRKWNy4NWqN4uWTrTMifB21zLlV+jhzpt1inlTMFw02ALAMw5yL97UQRdHG
         WiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888789; x=1795493589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
        b=vOVp4INArb/S3Qbc96G/1xxK59iBi6FErbOuwkuDLmmHa/om5jHaoRdFSnF6sgzwJ2
         F83Y5rE0/s9UkvTcyulIKmDYfKGNFC6lqP/z76Umhieh01/HcZOEJKlJyu8wwOrfGT6r
         g5JrE6rR+NJ+FmhJT3uZ3zBMKcHb4+3WZRFVKI24o7tqApmYvvOnXzDP6SLFqZ0kTCxA
         dAurELFLbzIQ2dXwomtMVmCQt1YeptVCDSBxn+FfgWm6qMqENGt+BDxhNS5UvQEYzgQr
         +syzFL+UyNJQT4X5QUVVIOQlciF7XOBIJNFs+iHPl16//vGBNy744ywsMWnPpOy4li4/
         nOFw==
X-Gm-Message-State: APuU4Z/sN9g6dhkuUCAz4X35wzj5+l8nbRe/wrWffULCywaziTenDd54
	M9M1UlsU/8CQTI0kOxavyklJ8UAUERaq7yK3nR38kzN3WMzvaZvxTGo6o1CJ2QXR
X-Gm-Gg: AYBFou11MAkReUNPbsjbRlia9z1J/UaASRaV0t4kxYyRdsZwly/oa4Ik9qvswXhJ4EJ
	E7/u39X+JDJo/dNyXQc8hl2IVEx/h9k/ca5IeCtNioScFMuXqTQra33u/rCmxVGho1iK1P3Jrpf
	WWrahDetp0pH04LUiI3qvFX+rRhc4x400/fWoeBy5GE0rflpe7relOpE+GOyITs6/KIl+iVqr5N
	FAYfiP3yF0rj/FABuBQYF0DSAIY0b9U87UHenFwOoayulKUABG3QDPrGEpZUY0NfGaixGtiRlh7
	XqVefIa8fI7jX4D4ZgskIlT4CRyBb81KclJ+Zhq1c9oLE2aWYUu3ByyvvR7MrGtbKx43Z+OwI+5
	bBdQJwRxn3QMDokL3OYWUrMZsSSoUdLaJQZipuxuLGYYOfSfFyVlz1pBfiuB6jUpuVL0wBBP6yV
	v+NakGFZ4y3iP2a+9k5Wm3haeDnovCxr1zz2Y49NXlrh/D6+KsNb6LEceNJX4NTjI9O9UbOoHJL
	INmEYqgNgu3OZCbQaaWB1ITxWOv01B5s43Yv+bwhYq3pY51mHbsm2CFszA9tLOQrNIv2FIf4Wej
	3QYQAEjUiro08l27a08+23JMmJIgqpvyGA==
X-Received: by 2002:a05:701b:4191:10b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b5030f8bd1mr13178220c88.19.1794888788801;
        Mon, 16 Nov 2026 20:13:08 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:07 -0800 (PST)
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
Subject: [PATCH 1/3] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Tue, 17 Nov 2026 09:42:51 +0530
Message-Id: <b0bad13ee4a9222a62f1bceb50215c3719e764a7.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794887659.git.ritesh.list@gmail.com>
References: <cover.1794887659.git.ritesh.list@gmail.com>
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
on while the replay is still inside irq_enter() (w/o fix):
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
after it (with the fix):
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


