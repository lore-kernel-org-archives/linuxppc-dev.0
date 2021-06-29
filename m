Return-Path: <SRS0=j7yY=LX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F23C11F67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jun 2021 22:22:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A12C61D8B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jun 2021 22:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A12C61D8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GDzVz0PWyz3dR2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 08:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=okpH+Mqt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=okpH+Mqt; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GDzSK3mTgz3005
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jun 2021 08:20:17 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 b5-20020a17090a9905b029016fc06f6c5bso33095pjp.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jun 2021 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IWBMjXBinn0yPYqP0cxTqwcLCJprYUYGTqwvGOKQk78=;
 b=okpH+MqtDKIKM7eV3Kpr1RYrtAIfKKkpLkq3OJNXsswjd+c6RLgmeCVhb9dxQcEVRN
 cPajFJCKz8OQ0aZbYahB/20wXl9CTBzUMvqpI0SQCfoh7pftLb/76pa/Bj08kPEy14rd
 DeGkKJEqzfXsNKYJcPaOQiNHBH5U8gVINmoCfpFWLy+cKiiTNQvHIP2k2bN89OG3SSJn
 hDBtDpqhO3inSwljOWDqAk9NLVm7W8OTmPpBrnWABeuTBpiJrXYlBO6gdMTFr38kWxlh
 b5SSErFQqaEeb2kIbV4DJDWHZSQaDJpiMLtb1wowJl8xb7u+Gt71CnsD8SYRh1rO2K5j
 1MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IWBMjXBinn0yPYqP0cxTqwcLCJprYUYGTqwvGOKQk78=;
 b=FdtR1TFlKrly6vMls1ZC+sRoFFYCMKTDOPjl3R/7u+LYr3GhYy4r6a0LOxYVo2Uc+A
 Zkb5y3gcEh6r7SL/33dWd+0Sp6CRfNdI7dqLNKZfOILuY3vZSo1aVW7jqRVAd79Snnwe
 ZEqmb47Lk0mTH9JB66zDGZXbQ1t8qTHCK1vtScvY7Ov9F1DCxjGM1FYW63CHJ9TfD0ML
 VczaqJyc088I7DatlDTL9Ckbf/lARJtNZM7uw6NaIZb+17g4rKI1Fkm2drle0sIdtzdG
 p19VSvu2Zd7KLtPOYGxRR7Zu8lm+6edmOJ7++ASyq68l7wkWL9ukDjWKfmd2C6XIdN6J
 HnQw==
X-Gm-Message-State: AOAM531JLvCzC9lnd7sLLkGAv4QJcQFBr8OqM1DH2n9DyZKNN4BQM1gA
 TmONtSEmBAV9QVOLNGMSW20WqD2FXU0=
X-Google-Smtp-Source: ABdhPJwhvZ+Nr2rrtaByYaxy9hgv/PLqF1GevEo9V3tksgxst9+ilp0xpSICNirljzAdQE4Bglapag==
X-Received: by 2002:a17:902:f688:b029:128:e3ab:a868 with SMTP id
 l8-20020a170902f688b0290128e3aba868mr10422386plg.67.1625005215068; 
 Tue, 29 Jun 2021 15:20:15 -0700 (PDT)
Received: from bobo.ibm.com (220-244-87-52.tpgi.com.au. [220.244.87.52])
 by smtp.gmail.com with ESMTPSA id l7sm19316583pgb.19.2021.06.29.15.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 15:20:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/9] powerpc/64s/interrupt: preserve regs->softe for NMI
 interrupts
Date: Wed, 30 Jun 2021 08:19:53 +1000
Message-Id: <20210629221957.1947577-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210629221957.1947577-1-npiggin@gmail.com>
References: <20210629221957.1947577-1-npiggin@gmail.com>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If an NMI interrupt hits in an implicit soft-masked region, regs->softe
is modified to reflect that. This may not be necessary for correctness
at the moment, but it is less surprising and it's unhelpful when
debugging or adding checks.

Make sure this is changed back to how it was found before returning.

Fixes: 4ec5feec1ad0 ("powerpc/64s: Make NMI record implicitly soft-masked code as irqs disabled")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index d7df247a149c..789311d1e283 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -227,6 +227,7 @@ struct interrupt_nmi_state {
 	u8 irq_soft_mask;
 	u8 irq_happened;
 	u8 ftrace_enabled;
+	u64 softe;
 #endif
 };
 
@@ -252,6 +253,7 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
 #ifdef CONFIG_PPC64
 	state->irq_soft_mask = local_paca->irq_soft_mask;
 	state->irq_happened = local_paca->irq_happened;
+	state->softe = regs->softe;
 
 	/*
 	 * Set IRQS_ALL_DISABLED unconditionally so irqs_disabled() does
@@ -311,6 +313,7 @@ static inline void interrupt_nmi_exit_prepare(struct pt_regs *regs, struct inter
 
 	/* Check we didn't change the pending interrupt mask. */
 	WARN_ON_ONCE((state->irq_happened | PACA_IRQ_HARD_DIS) != local_paca->irq_happened);
+	regs->softe = state->softe;
 	local_paca->irq_happened = state->irq_happened;
 	local_paca->irq_soft_mask = state->irq_soft_mask;
 #endif
-- 
2.23.0

