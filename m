Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D557C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:43:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D8B6500C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 10:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D8B6500C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F08yQ4F7Wz30Gk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 21:43:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=qgUqKV/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qgUqKV/i; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F08xV3rjrz3035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 21:42:21 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha17so9634378pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDJoUG1yLv0WyAFnf8ZykYSJsUDwHka1W1/1b/XD9EY=;
 b=qgUqKV/i0lqQGQ8cpf3T8NjxZmLAYoqRVMPd64/OVpYlXSqPQGe4tOTpKq1U1sDVad
 akThFTvykQ+4JoLA2rvOyQKkr+r6iqtmkNMuuKhnHT+MaOrkfbepBAmLkzfPMHGdtFUn
 nieTSRef+E1Yls5NvaW6fWMLfesAKbqoACXfcuCiAErklDsRs0CDkWuN78ScFHbVBoCH
 B55EfscgdxVvEeMpt35onBYfeRFzcJEMEGe8VSnI8k7txpd71+8ckQ/acSeXuopL4Og5
 35NRVV8oF0KVesaeFeM8EpjsA+HZzn0xPB8KOIY4wn4u+Dft2z0aFnp18AMDbxqqsCzi
 T5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDJoUG1yLv0WyAFnf8ZykYSJsUDwHka1W1/1b/XD9EY=;
 b=jlVJmzVX2RKrKGhKhONKCWbLpOY94YcSgJrhtthc7ViLGhankNrv1Uio9Xc2m1L55D
 MmeD8k+4ZW9UOSuY2MZ2ArNITWzekdLPnHt8flhAqyJfo4VFJ3jdBCNq3TC4MUYRisc4
 S/VElFvRi6fO7kd13ZQalj8E1wpBVZPfl23de4mp0rEycPwOF1AV6uQlQF6xdTyqh+83
 TYJkh3Mp2rq6b1U0p3oHftPTA9Bpe9RhTb9R2w5VNRmdl507fq+n8XHGKDU8ClqoNgyk
 D3lGJIWRrY9DtSe+1qFxKtrclwziWd5V79Np74/PGxS9toei7J32ln+HZUlJJEr8Y6z3
 fsXQ==
X-Gm-Message-State: AOAM531niUUIfbGwIlgxjTaqgJFh5x3IiZnXSQLtGKt9H75btGErv4hk
 lqpr9VJnBhgzSpEgsngFea6yvrCGCDU=
X-Google-Smtp-Source: ABdhPJyRPBCcrYPk025d+rz2yifSyS3Mboy00PTPnNP9byvEwjZgY3KNVfpG4eRcE+AYuyjZXlmZoA==
X-Received: by 2002:a17:90a:8408:: with SMTP id j8mr4251110pjn.1.1615891339145; 
 Tue, 16 Mar 2021 03:42:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 r30sm15828489pgu.86.2021.03.16.03.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 03:42:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/11] powerpc/syscall: switch user_exit_irqoff and
 trace_hardirqs_off order
Date: Tue, 16 Mar 2021 20:41:55 +1000
Message-Id: <20210316104206.407354-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210316104206.407354-1-npiggin@gmail.com>
References: <20210316104206.407354-1-npiggin@gmail.com>
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
Cc: Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

user_exit_irqoff() -> __context_tracking_exit -> vtime_user_exit
warns in __seqprop_assert due to lockdep thinking preemption is enabled
because trace_hardirqs_off() has not yet been called.

Switch the order of these two calls, which matches their ordering in
interrupt_enter_prepare.

Fixes: 5f0b6ac3905f ("powerpc/64/syscall: Reconcile interrupts")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c4dd4b8f9cfa..fbabb49888d3 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -43,11 +43,11 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
 		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
 
+	trace_hardirqs_off(); /* finish reconciling */
+
 	CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
 	user_exit_irqoff();
 
-	trace_hardirqs_off(); /* finish reconciling */
-
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
-- 
2.23.0

