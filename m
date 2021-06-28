Return-Path: <SRS0=PW3U=LW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC61C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 07:53:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D724561990
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 07:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D724561990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GD0GW452Hz3bkh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 17:53:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=WzDZwz4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WzDZwz4Y; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GD0Bb3Xnrz3bTl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 17:49:59 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id b1so1942878pls.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DAxuQnwoSFaaEZhnxTC5DarUsV4i4rnGyZG+PA3KsCo=;
 b=WzDZwz4YJE3LGMd8mwa9tNE/4Pe569zXT56GZZ/T3u9HLAQngLapiJiqz9AENtMjPz
 a4U04pXQUlMKhv8lSSlOnP8+VPiRtOEC1O5hJN6EDfInUnvMR6av8vLIvtCnKNNAF7YP
 6e9gBstqCIqlNVgrcsbGkEZdtPi+KeUy13MRxDK+fpy7RftL5/JUQjZ4aKQYeRlvlVq2
 HyKmJjNvcBzA6hbdwDa9jeovIk+LyiP8ZbMZtS0dBo+lsJoJTcLu1CA7VfLMXSE9fUqO
 XF0ctIkqUKS06rgyfHU+SFGNMQJFktXJb+nHNtpf3ipXwLUxc5qCC9swk0DSFHiAamYR
 gB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DAxuQnwoSFaaEZhnxTC5DarUsV4i4rnGyZG+PA3KsCo=;
 b=pgTlpWQ7oUpCirYoc3Os9/ICs7RExyheCNBNZSrOZtiHocPpy+o1b+TB4/pToSR9oi
 pqMWx8/SqAJ30IEj53NQ8Wxt1+zLqKmcPAINQQ/UMSnRc6FsH/9cQTXr0A9aHHfk9xrz
 JwPmIg9W0hwz6ubWLKvA3m0oldf+fxNmxElt9AvJDL9bsJkliNkZsi+BXyP/QuluLYSa
 KMZMipvtjQ1dRbYbNKSJmdwJjhJ7wanBXBPXWdMvVIbLCzFHQ9ppAcfOxB8faf2/qwsz
 PaSscOPGx8a+c/c5/URODiR982JIOpdBJE/COjy37owxIIUstM1azl8tJdQ4vdP+pIft
 Mcvw==
X-Gm-Message-State: AOAM533pry6vSS2GJBHvFH7qHMGfDKOLAIjnl7IamB2Sr7X4sczXTtBt
 ES7nMGk+PY1Ri7NAmEVkUvQYCaI9k84=
X-Google-Smtp-Source: ABdhPJxa18qq+SF0AHDXyxcwGqZV+oWSvGaXAndSgbOpQ/B99gAqE5kgUqaAHtmn+SpM1UPy8QSPaA==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id
 gt23mr1097281pjb.21.1624866596786; 
 Mon, 28 Jun 2021 00:49:56 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id b22sm5264962pfp.20.2021.06.28.00.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jun 2021 00:49:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/64s: move ret_from_fork etc above
 __end_soft_masked
Date: Mon, 28 Jun 2021 17:49:32 +1000
Message-Id: <20210628074932.1499554-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210628074932.1499554-1-npiggin@gmail.com>
References: <20210628074932.1499554-1-npiggin@gmail.com>
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

Code which runs with interrupts enabled should be moved above
__end_soft_masked where possible, because maskable interrupts that hit
below there need to consult the soft mask table.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt_64.S | 52 +++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
index 795c105850e4..3ca3576690ce 100644
--- a/arch/powerpc/kernel/interrupt_64.S
+++ b/arch/powerpc/kernel/interrupt_64.S
@@ -451,32 +451,6 @@ _ASM_NOKPROBE_SYMBOL(tabort_syscall)
 	b	.	/* prevent speculative execution */
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S
-_GLOBAL(ret_from_fork_scv)
-	bl	schedule_tail
-	REST_NVGPRS(r1)
-	li	r3,0	/* fork() return value */
-	b	.Lsyscall_vectored_common_exit
-#endif
-
-_GLOBAL(ret_from_fork)
-	bl	schedule_tail
-	REST_NVGPRS(r1)
-	li	r3,0	/* fork() return value */
-	b	.Lsyscall_exit
-
-_GLOBAL(ret_from_kernel_thread)
-	bl	schedule_tail
-	REST_NVGPRS(r1)
-	mtctr	r14
-	mr	r3,r15
-#ifdef PPC64_ELF_ABI_v2
-	mr	r12,r14
-#endif
-	bctrl
-	li	r3,0
-	b	.Lsyscall_exit
-
 	/*
 	 * If MSR EE/RI was never enabled, IRQs not reconciled, NVGPRs not
 	 * touched, no exit work created, then this can be used.
@@ -770,3 +744,29 @@ interrupt_return_macro hsrr
 __end_soft_masked:
 DEFINE_FIXED_SYMBOL(__end_soft_masked)
 #endif /* CONFIG_PPC_BOOK3S */
+
+#ifdef CONFIG_PPC_BOOK3S
+_GLOBAL(ret_from_fork_scv)
+	bl	schedule_tail
+	REST_NVGPRS(r1)
+	li	r3,0	/* fork() return value */
+	b	.Lsyscall_vectored_common_exit
+#endif
+
+_GLOBAL(ret_from_fork)
+	bl	schedule_tail
+	REST_NVGPRS(r1)
+	li	r3,0	/* fork() return value */
+	b	.Lsyscall_exit
+
+_GLOBAL(ret_from_kernel_thread)
+	bl	schedule_tail
+	REST_NVGPRS(r1)
+	mtctr	r14
+	mr	r3,r15
+#ifdef PPC64_ELF_ABI_v2
+	mr	r12,r14
+#endif
+	bctrl
+	li	r3,0
+	b	.Lsyscall_exit
-- 
2.23.0

