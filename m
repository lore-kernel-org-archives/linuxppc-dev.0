Return-Path: <SRS0=J0gu=EM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BBC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 16:18:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C911922202
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 16:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqMi685f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C911922202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSQXl0SFqzDr2g
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 03:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sqMi685f; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSQ7y3CcfzDrMh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2020 02:59:58 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so1240483pgb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2020 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWbyVffMxUVPhyOnZmsQjVupJESirxcTMoc1INN6Djc=;
 b=sqMi685f0nbitfvczPlzNa2K+U0cS7DuH4R4f6kl82nQYyFR2OMy5LFxO7ZWoKDUNH
 jnBpRJxhJ3GzUnVAWzmcaPOjq3iO8zRtetYFD85Jhz+FwTyzehRWgE51Jy00wxTf5tzx
 4+8o4J9l3GnOF9RqarGIeJujfD8/2xbdEAOR3z+5N3UHF1gsUWM14IgW00ZKeYeDjJSp
 Yav79XJ7hK7uggLWsa2kfNFGiIqW2Mgew+i/e+UNQJgeVZZhIG6KpWQFrJZ178v1/cH+
 ZDXDT1vqvURP196k6GGfSOd2qIQOURUGTBESRstEkDuKkPiZwLO03GXB5zsFbbnTLlb8
 YHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWbyVffMxUVPhyOnZmsQjVupJESirxcTMoc1INN6Djc=;
 b=n1n58qrPUAyDVOtegs/nUdS5axJj7v0pXYGneX//fwtQ4cbIu7UeWIAFJ+wQwapjsA
 ZMzazVT8doBzJjMwmiURU2Rac0SJ2FrwQRuyfq0slo0gOtd51MHcvLyeGkwjgZkhMPxX
 U45aV0z33MPFEDNFS2ulgw1GrAqcUmbpudU2uLypZtj6DzSakBmZJH9WeZrpImV9DfaM
 cmF1epr7zRDG2e9QJnTQ69L2NaQZXfjEJ67dNVEi1e2Ku7d0rgj9dPxJ1EfoNzWrUVZm
 miVgGKvFnds+Elv1T2LyBxGNuLZBp891bk+IeGn/MQhEaWdCKPLFCGutheaOw9XaI3H0
 Vdgw==
X-Gm-Message-State: AOAM5300RDa8Sr/vFvzeiG4JggUb1gemDqTEOUXVHzeAVbYKFuIwXb0w
 XAmZBjTTpdR31Is4SZcevEYK4/uvC0c=
X-Google-Smtp-Source: ABdhPJysA0kGjucoNIS2cM1z6BGUUL7LUa9TuEc2L8n4EiI/zTjt789i8r5zm8gxuCXDl0KrBtxmNw==
X-Received: by 2002:a63:2f41:: with SMTP id v62mr2250502pgv.10.1604678396227; 
 Fri, 06 Nov 2020 07:59:56 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id g7sm2899536pjl.11.2020.11.06.07.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:59:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 8/9] powerpc/64s: interrupt soft-enable race fix
Date: Sat,  7 Nov 2020 01:59:28 +1000
Message-Id: <20201106155929.2246055-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201106155929.2246055-1-npiggin@gmail.com>
References: <20201106155929.2246055-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Prevent interrupt restore from allowing racing hard interrupts going
ahead of previous soft-pending ones, by using the soft-masked restart
handler to allow a store to clear the soft-mask while knowing nothing
is soft-pending.

This probably doesn't matter much in practice, but it's a simple
demonstrator / test case to exercise the restart table logic.

XXX: 64e can't do this unless it adds restart table support

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 79 +++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c8185f709d26..9671468b2c51 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -317,52 +317,73 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	unsigned char irq_happened;
 
 	/* Write the new soft-enabled value */
-	irq_soft_mask_set(mask);
-	if (mask)
+	if (mask) {
+		irq_soft_mask_set(mask);
 		return;
+	}
 
 	/*
-	 * From this point onward, we can take interrupts, preempt,
-	 * etc... unless we got hard-disabled. We check if an event
-	 * happened. If none happened, we know we can just return.
-	 *
-	 * We may have preempted before the check below, in which case
-	 * we are checking the "new" CPU instead of the old one. This
-	 * is only a problem if an event happened on the "old" CPU.
+	 * After the stb, interrupts are unmasked and there are no interrupts
+	 * pending replay. The restart sequence makes this atomic with
+	 * respect to soft-masked interrupts. If this was just a simple code
+	 * sequence, a soft-masked interrupt could become pending right after
+	 * the comparison and before the stb.
 	 *
-	 * External interrupt events will have caused interrupts to
-	 * be hard-disabled, so there is no problem, we
-	 * cannot have preempted.
+	 * This allows interrupts to be unmasked without hard disabling, and
+	 * also without new hard interrupts coming in ahead of pending ones.
 	 */
+	asm_volatile_goto(
+"1:					\n"
+"		lbz	9,%0(13)	\n"
+"		cmpwi	9,0		\n"
+"		bne	%l[happened]	\n"
+"		stb	9,%1(13)	\n"
+"2:					\n"
+		RESTART_TABLE(1b, 2b, 1b)
+	: : "i" (offsetof(struct paca_struct, irq_happened)),
+	    "i" (offsetof(struct paca_struct, irq_soft_mask))
+	: "cr0", "r9"
+	: happened);
+
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		WARN_ON_ONCE(!(mfmsr() & MSR_EE));
+
+	return;
+
+happened:
 	irq_happened = get_irq_happened();
-	if (!irq_happened) {
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		WARN_ON_ONCE(!irq_happened);
+
+	if (irq_happened == PACA_IRQ_HARD_DIS) {
 		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
+			WARN_ON_ONCE(mfmsr() & MSR_EE);
+		irq_soft_mask_set(IRQS_ENABLED);
+		local_paca->irq_happened = 0;
+		__hard_irq_enable();
 		return;
 	}
 
-	/* We need to hard disable to replay. */
+	/* Have interrupts to replay, need to hard disable first */
 	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
-		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
+		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
+			if (!(mfmsr() & MSR_EE)) {
+				/*
+				 * An interrupt could have come in and cleared
+				 * MSR[EE] and set IRQ_HARD_DIS, so check
+				 * IRQ_HARD_DIS again and warn if it is still
+				 * clear.
+				 */
+				irq_happened = get_irq_happened();
+				WARN_ON_ONCE(!(irq_happened & PACA_IRQ_HARD_DIS));
+			}
+		}
 		__hard_irq_disable();
 	} else {
-		/*
-		 * We should already be hard disabled here. We had bugs
-		 * where that wasn't the case so let's dbl check it and
-		 * warn if we are wrong. Only do that when IRQ tracing
-		 * is enabled as mfmsr() can be costly.
-		 */
 		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
 			if (WARN_ON_ONCE(mfmsr() & MSR_EE))
 				__hard_irq_disable();
 		}
-
-		if (irq_happened == PACA_IRQ_HARD_DIS) {
-			local_paca->irq_happened = 0;
-			__hard_irq_enable();
-			return;
-		}
 	}
 
 	/*
-- 
2.23.0

