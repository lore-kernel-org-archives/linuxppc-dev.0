Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F3C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:53:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D774461027
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D774461027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJWwl3PvXz3dc1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:53:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=p7hMf2tY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=p7hMf2tY; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJWr13ShBz3bsB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 11:49:21 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id q10so8176699pgj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z2fLHBAlH6bMHiwD8ZSE8QbPd3NRupfIKb21fqNXnZg=;
 b=p7hMf2tYA10VOWRMIzi44LqFQ2CoDByIZfx56TEpJUgd1gHL6CCsQmXTE8FTsgaMvD
 peH4lGHU6CvfW++H+LD1R4Y7k46i028/OVBscxf8tOIz5zUnPnIsbDUPdLlkRYqIEVgf
 ZHcTaGlworvRlmEnIQmfgYP7SDjFMeoymNAIVAU8pK+7JIQDMc34nYCjvT0+Ktpa8Q+I
 aVGufIrDy3waGFh8SKgnbJpa6FWYQGfXX2UfMUdqBEjqQnnYsZrdVBBrJtZ2reVrxLiX
 LMDm+Kou92cHhc2MmYao3uJCCkaoA/piS/1DpgTkc/X9ZnINTvg7afHtw9QjOUAEZmq0
 ie9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2fLHBAlH6bMHiwD8ZSE8QbPd3NRupfIKb21fqNXnZg=;
 b=G+Em/UucJIDUqjcWYs2CWawZc4lAiYJs+LyKYT+8utEN2utVnEAsZ4ypmOmxZqwBXc
 hs8XXN7bRrGscWRzxCsotXyVfOwLj2dC2W1AOaRmLijy3l/cHgZKgHaSnstCw2fs5i/9
 eeqK4MEVmUFC5gEiJwRBRH4rytuRPzrEWY0zY4E6UaELoqqf7Ke9xkIAMnMXpkn/yR/Y
 4drvG2tYOp0+ApKIDoMxVkygRzucZ4A1U7+m+CwzkaGN2Figj2qDywi62111PoG6O/OX
 bIPSu1aDAWpWAf0IJO2o+A8gOPPabCaTjuw+2xuACGWKh8GaAw3gih19OGu7Vp2ctVfu
 MXfQ==
X-Gm-Message-State: AOAM5319r0QTcnXobuIn+8+UGRGiG9Jz64W6HQvm6+gXsRGhxAYBtl6B
 nVZCGSklULMZZlnAPCmN9Jg=
X-Google-Smtp-Source: ABdhPJyGwKQHQ40lX6Tr0ZUdfWy4PrLWq/Nc/fBvKNzpneGC8SGnH8UVYCjX+1KZbFLpfw+CAVlbMQ==
X-Received: by 2002:a63:6682:: with SMTP id
 a124mr15283236pgc.363.1618192159275; 
 Sun, 11 Apr 2021 18:49:19 -0700 (PDT)
Received: from bobo.ibm.com (193-116-90-211.tpgi.com.au. [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id m9sm9502345pgt.65.2021.04.11.18.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 18:49:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 09/12] powerpc/64s: Remove KVM handler support from CBE_RAS
 interrupts
Date: Mon, 12 Apr 2021 11:48:42 +1000
Message-Id: <20210412014845.1517916-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210412014845.1517916-1-npiggin@gmail.com>
References: <20210412014845.1517916-1-npiggin@gmail.com>
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

Cell does not support KVM.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8082b690e874..a0515cb829c2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2530,8 +2530,6 @@ EXC_VIRT_NONE(0x5100, 0x100)
 INT_DEFINE_BEGIN(cbe_system_error)
 	IVEC=0x1200
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_system_error)
 
 EXC_REAL_BEGIN(cbe_system_error, 0x1200, 0x100)
@@ -2701,8 +2699,6 @@ EXC_COMMON_BEGIN(denorm_exception_common)
 INT_DEFINE_BEGIN(cbe_maintenance)
 	IVEC=0x1600
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_maintenance)
 
 EXC_REAL_BEGIN(cbe_maintenance, 0x1600, 0x100)
@@ -2754,8 +2750,6 @@ EXC_COMMON_BEGIN(altivec_assist_common)
 INT_DEFINE_BEGIN(cbe_thermal)
 	IVEC=0x1800
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_thermal)
 
 EXC_REAL_BEGIN(cbe_thermal, 0x1800, 0x100)
-- 
2.23.0

