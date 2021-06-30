Return-Path: <SRS0=aNTg=LY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E097FC11F65
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 07:49:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F486197F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 07:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F486197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFD4y1HJsz3dVW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 17:49:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=lJMOxMvb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lJMOxMvb; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFD1w1Ynbz301q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jun 2021 17:46:44 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id c8so1646254pfp.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jun 2021 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sn7Ojggh30t3WB4BGjc5ohzlPP6Zc+Zek+1eXAXBLaY=;
 b=lJMOxMvbcpe/l48WN63xbUkRL6wQ9eowWRcfozQYUTFSPwGK+UbRDaU/jxnnQ5Vsfe
 QaX3N5hHnL6Ec2jH3YeXW2RR/ByQ+OEiiKjPlxBaKdwI6TLjPcF1Yh1+SducdK702pfK
 gCIkXtlfHC5MSV7EUjzK54yBlfsZOxNcRZxVFrGQ391/qZgwu4TlOhd1O7aBHTDu8+8b
 4x0Qv75gJCFMcBiOL9YmNpm+pe5cmycixw4i6HSmowFS+Zm2Hxeoz8XMucC0+r5GKsdM
 RWQr/3OlZr0vAmCJDzZhYTtSSs6pBpDYtsEuY1QayyRKCV8mP4n+6Ax8nmruXZD9hC/b
 pY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sn7Ojggh30t3WB4BGjc5ohzlPP6Zc+Zek+1eXAXBLaY=;
 b=N/dAuYOI1h3lKqKJIOKPKcsJ6bYmqm1gGFR81774FD3m1WOeSX8x7PKE/LIksVepTz
 G+c02CD4a6u1dKqnPKvwIaAu48zQ0GPX+ADkEVKBkvkGMyKGOROcA9qVRA1lWHdaI4tG
 os4Psikp3VQtQlPZaYLLeQBDh96D/fqWqJFRZD4+QtjB6Xj+UwM9QLxGncJpY6F3jpP7
 a7/bJFs7Rdg/YM1Ed1c/0LCTBMvRjtaPSPZbLLtglkuBAPcddr9TS503zYgpXcL6mrYd
 OmpGHV6FMBcOM4NEFpGBORxP16svWHclPNKqQhLH1UNBX7NrSvpJiYEiCM55GwBeXVLF
 BvvA==
X-Gm-Message-State: AOAM530FkjMJBbDlrwX/Y2XXoS+VQ3hFeMqeN4hwC4k7FU4NVVnd+Pga
 WsvTnvkrnycus6Y9NmIKQBkD6khkKbU=
X-Google-Smtp-Source: ABdhPJwAUaOLPCsV+qiNlEoFDfcfWmX9EgKsgIQBIRF/gapaRmbbtYyRoNfDSFQCJkNfH9IWAshDeA==
X-Received: by 2002:a05:6a00:2403:b029:309:8a37:2d51 with SMTP id
 z3-20020a056a002403b02903098a372d51mr26707732pfh.79.1625039201690; 
 Wed, 30 Jun 2021 00:46:41 -0700 (PDT)
Received: from bobo.ibm.com (220-244-87-52.tpgi.com.au. [220.244.87.52])
 by smtp.gmail.com with ESMTPSA id g4sm20503369pfu.134.2021.06.30.00.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 00:46:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 6/9] powerpc/64: enable MSR[EE] in irq replay pt_regs
Date: Wed, 30 Jun 2021 17:46:18 +1000
Message-Id: <20210630074621.2109197-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210630074621.2109197-1-npiggin@gmail.com>
References: <20210630074621.2109197-1-npiggin@gmail.com>
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

Similar to commit 2b48e96be2f9f ("powerpc/64: fix irq replay
pt_regs->softe value"), enable MSR_EE in pt_regs->msr. This makes the
regs look more normal. It also allows some extra debug checks to be
added to interrupt handler entry.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 4 ++++
 arch/powerpc/kernel/irq.c            | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 789311d1e283..d4bdf7d274ac 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -173,6 +173,8 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 			BUG_ON(search_kernel_restart_table(regs->nip));
 #endif
 	}
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		BUG_ON(!arch_irq_disabled_regs(regs) && !(regs->msr & MSR_EE));
 #endif
 
 	booke_restore_dbcr0();
@@ -268,6 +270,8 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
 		// arch_irq_disabled_regs(regs) behaves as expected.
 		regs->softe = IRQS_ALL_DISABLED;
 	}
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		BUG_ON(!arch_irq_disabled_regs(regs) && !(regs->msr & MSR_EE));
 
 	/* Don't do any per-CPU operations until interrupt state is fixed */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8428caf3194e..91e63eac4e8f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -121,6 +121,7 @@ void replay_soft_interrupts(void)
 
 	ppc_save_regs(&regs);
 	regs.softe = IRQS_ENABLED;
+	regs.msr |= MSR_EE;
 
 again:
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-- 
2.23.0

