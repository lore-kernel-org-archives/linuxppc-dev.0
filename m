Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA06C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 08:01:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCAF23120
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 08:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCAF23120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DG0JW6r9gzDqWK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 19:01:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f;
 helo=mail-pf1-x42f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SxLzTrwf; dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFzgW1jwczDqnV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 18:32:55 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id h186so721534pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 23:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rF2K8503We+UZeN099aEi/lLo/gGBUZJC64MtQTsCSs=;
 b=SxLzTrwff6Ls8IlNgoMDYw/GNWTWw2uEs1jyWPJYHCZAx5sUxA6uDToiQVgHeRuAMW
 cBON6sqCifnDYC7MgQvtdwuc/5ktOX00C72B5TaK6MpoXurOlPyQIsT2Htjx+Vr8oLGX
 i3zheQTKV3tjhuJz3sBtIB+8ihRVABVzHcbfUwzz9yIq/zV+fH79CNpwcC5USiCguXF+
 inHyY6ZcD5oW5wCH6vp8upk8SFlmnE7ZP59/JtuFJut7zsqpfSW3F0M0sNfArq6hTe+D
 FHkXB4g93VcHZOyVdZUH7YsN5tr61sLO4dPczer9fCUJAlYKx+Taobzup8xYUXCLMSo4
 SeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rF2K8503We+UZeN099aEi/lLo/gGBUZJC64MtQTsCSs=;
 b=g1rRNNQpv3OA8EIL1zS0v3TJY3IqhVwnDjY9VJ0lyDIn2krQwggWwmRSGR5YsF1r9c
 YdtRCVqSo/WKBj6UylVdHpZz77DEiTKGVTbPxTXo75YFQpdFDMFyfQxPROCTZQmfmpvk
 V1kSKK3rml3tCOCQshBbyzHsnrR3AxzD3OqyXdrolarYy6QeW/cAngYrzxm+iieyzfLO
 BBFHeHUKOweZdWZLtue7fXHZ1GATT897RuX+XsZQtkAUsk15uoEC02s2Bf+vFR4DCvEQ
 zYSDzanb0TYw573FuDYtpFkGCxXyF+GSRJ7V7MzAwVFNuadChuOu58Og+K8EEU8ZFmnV
 2VbA==
X-Gm-Message-State: AOAM532gOC9jRksobDrkc0MC5QF08cXvPXJp0j+VSrpzsNo3lXlrbKEN
 9lqwPR8p6kVN/UjstE4/DTb6zlB+dCo=
X-Google-Smtp-Source: ABdhPJy7GG+dTwqqtuG/I1igmGs/m5AhKahWCQmj3M3MLnJSXHR5Vn6n7M1HLFRU5UeFFlalvBsNOA==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr921566pgl.290.1610523172840; 
 Tue, 12 Jan 2021 23:32:52 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id m77sm1394264pfd.105.2021.01.12.23.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 23:32:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 12/21] powerpc/64: add context tracking to asynchronous
 interrupts
Date: Wed, 13 Jan 2021 17:32:06 +1000
Message-Id: <20210113073215.516986-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210113073215.516986-1-npiggin@gmail.com>
References: <20210113073215.516986-1-npiggin@gmail.com>
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

Previously context tracking was not done for asynchronous interrupts,
(those that run in interrupt context), and if those would cause a
reschedule when they exit, then scheduling functions (schedule_user,
preempt_schedule_irq) call exception_enter/exit to fix this up and
exit user context.

This is a hack we would like to get away from, so do context tracking
for asynchronous interrupts too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 7fab54a14152..7c40ce78c4bb 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -42,10 +42,12 @@ static inline void interrupt_exit_prepare(struct pt_regs *regs, struct interrupt
 
 static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
+	interrupt_enter_prepare(regs, state);
 }
 
 static inline void interrupt_async_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
+	interrupt_exit_prepare(regs, state);
 }
 
 struct interrupt_nmi_state {
-- 
2.23.0

