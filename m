Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A20C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:50:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BA364F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BA364F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmZ1c3Dfhz3djG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 00:50:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=aCwoSEX3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aCwoSEX3; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmYxy4G7Mz3cmj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 00:47:34 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d12so1106360pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AWnzQkuEUPMoWm/4qDOGdHuIkxWe5CpH2emCUPPeV1U=;
 b=aCwoSEX3CLiQ454/HcUwBUvX4+4SdXsdFI7ce0eGhYjN7OO6qXwC8Zpv30cSV3NsN+
 xN58WSX4Mp50JLz1QtcjNVuA3YOeONO6rzxaQUp5KLZM3KbVDY1iwMRQSnUhCtqbxb+C
 KKIUuUyjjzvnd2//gHKsW0eN/UB6FJg1Qm2lCVrXfMlEVmJLqV+XZvDdkSEhetgGmsDf
 iKrSVGVsSFJqR79TrKrZbgl+HnU8/6czzDuGqUYxb7h9gL/ZireF8m2Dcld6tfh4Qnq2
 CHLsIwppPaqa0Wf8v/0uMej+HhKGkXU977LRRyiDZKMOSqJYXlBL6fjfrjzkIhdSLTLU
 lTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AWnzQkuEUPMoWm/4qDOGdHuIkxWe5CpH2emCUPPeV1U=;
 b=RNvcnQ531qXJdBThMgxAhwX1N8zQPaUZUFsgs6lR76mgK8ihJLLY07Xbc3HUMuAQK4
 Nfqw28TJDvObF9+kAAFGy7g+/IVL1ZefX/y5ThJ8jVsqJtcPIDThQxLf6UTkSFuBiyC/
 0LXXlTiWF1SrZv0IVtVzNz3eGa2IaAHyDy1q0mqO4isNC3P1RHCrKdbVvHUNvCIMQ99p
 2z1jlhC1bYizC8zl6H8arpoLpSEh7ByiApCtYaR2zxUhr58TndD6O6QuwjymZAWgyGgS
 XNwPQLfbhTelYntypm+NmEgo4FP8C9d2dsSs3amOJuPL1QL36r3YUjvOwdr+CtcgCyf9
 HlCg==
X-Gm-Message-State: AOAM532t7LEDgX8HNN0659xGf1hF2smZf654rdx2ZOeaW/riDxuaZtCM
 KR0hgfbpKrJFbLnCItl4ytg=
X-Google-Smtp-Source: ABdhPJwEMI7Log06mCQHoCSRxy9UFT2J7w4Jc1vzc5d7sNcJknEZi9OvrFEJZxi8S0j9BRjhUpvJwQ==
X-Received: by 2002:a63:1350:: with SMTP id 16mr3031040pgt.85.1614260852602;
 Thu, 25 Feb 2021 05:47:32 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id a9sm5925868pjq.17.2021.02.25.05.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 05:47:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 08/37] KVM: PPC: Book3S 64: add hcall interrupt handler
Date: Thu, 25 Feb 2021 23:46:23 +1000
Message-Id: <20210225134652.2127648-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210225134652.2127648-1-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a separate hcall entry point. This can be used to deal with the
different calling convention.

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 arch/powerpc/kvm/book3s_64_entry.S   | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d956dd9ed61f..9ae463e8522b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1992,13 +1992,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 * Requires __LOAD_FAR_HANDLER beause kvmppc_interrupt lives
 	 * outside the head section.
 	 */
-	__LOAD_FAR_HANDLER(r10, kvmppc_interrupt)
+	__LOAD_FAR_HANDLER(r10, kvmppc_hcall)
 	mtctr   r10
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	bctr
 #else
 	ld	r10,PACA_EXGEN+EX_R10(r13)
-	b       kvmppc_interrupt
+	b       kvmppc_hcall
 #endif
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
index c1276f616af4..9572f759255c 100644
--- a/arch/powerpc/kvm/book3s_64_entry.S
+++ b/arch/powerpc/kvm/book3s_64_entry.S
@@ -7,9 +7,13 @@
 #include <asm/reg.h>
 
 /*
- * This is branched to from interrupt handlers in exception-64s.S which set
+ * These are branched to from interrupt handlers in exception-64s.S which set
  * IKVM_REAL or IKVM_VIRT, if HSTATE_IN_GUEST was found to be non-zero.
  */
+.global	kvmppc_hcall
+.balign IFETCH_ALIGN_BYTES
+kvmppc_hcall:
+
 .global	kvmppc_interrupt
 .balign IFETCH_ALIGN_BYTES
 kvmppc_interrupt:
-- 
2.23.0

