Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702CC43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:48:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55688208CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNGGAAPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55688208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TrTK08hWzDr2h
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 15:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNGGAAPF"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TqlW2TgKzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 15:15:35 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id t16so953433pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HnyQLyQJWF52L9q1/Tv9uIZGI0sjVmfMaFZ6h1TzAQw=;
 b=bNGGAAPFHFfvQvl7NMlaTWQFdeYKSshKnb/wY/9EsoZWZjnZB6PsVi3IT1DSdN6Iao
 /UdTqo+u4IDBzy+RYzmwyRwNrUo05nJ4NeeYH73cy9sCRwWPuKWbqrwew2Y/JG/05ucn
 ki9x/JW1jcOVGbruU/RAau2COdO2dDD1/yn0AFCCk1aq46vSi2aqMwfCQpAu1ykh/AbT
 Q01lh1k1f9fy4LF3EEhgpP2U2eZuI16lNmKAvBSLQoessG0D2tvxov6Q47BA4MyFgWfC
 AC26bOxhI0NjUXlCWyXOa7oMOq4OKONhuzYBJudeAjw28jZoSFliMfy7PEicOuxM7LGD
 jcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HnyQLyQJWF52L9q1/Tv9uIZGI0sjVmfMaFZ6h1TzAQw=;
 b=HGpMOTLeW7Tg563/z6Nzli/zbi9rI8Ky1MVTRXphWNAvcvyob5JvmSeyDjYUvwu2NQ
 mS+i+fZv3HbvWhIi0heRa21Ftm4y28BKlrVNpImMwk6Jgy8wxk1gBgS0lUOFFz4fOR/J
 bRKK2SLW4AUqoNnLRqBYJ7QT6QbhDHgDD4f/dLlveuv3WatVAgrxs+mF+f9JnWIDYYxJ
 xv4kFse2iMURN9NWV11ca7YXQ5HZkpAKD3qC0aLUsTwF4vunvqRtsesEeVzo+OTPLzUJ
 A8psU1CIzUWNd93pWvy6xu63mcO4yp65oG9Hu9hQsTipGs1KhVnd4z3Gvz9xAIIgxY2e
 YSng==
X-Gm-Message-State: APjAAAX3NwZPfuOwO6ffWxQyqLhWW2xq9kYkbvLp0tFRueJZ1ZpgPVxQ
 lCln9qwVbJssfrADZo0nENUyO1ZQ
X-Google-Smtp-Source: APXvYqypk1eaaEEbY6lUwq6EsbIrzPYbQZZDWUdIh+PGDC1TrdcHwxIzVCtb7sB29NCILozIVxpKEA==
X-Received: by 2002:a62:cd8b:: with SMTP id o133mr9932714pfg.24.1561007733025; 
 Wed, 19 Jun 2019 22:15:33 -0700 (PDT)
Received: from bobo.local0.net (193-116-72-140.tpgi.com.au. [193.116.72.140])
 by smtp.gmail.com with ESMTPSA id
 h12sm8235847pje.12.2019.06.19.22.15.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 22:15:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/52] powerpc/64s/exception: remove STD_EXCEPTION_COMMON
 variants
Date: Thu, 20 Jun 2019 15:14:23 +1000
Message-Id: <20190620051459.29573-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051459.29573-1-npiggin@gmail.com>
References: <20190620051459.29573-1-npiggin@gmail.com>
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

These are only called in one place each.

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 22 ----------------------
 arch/powerpc/include/asm/head-64.h       | 19 +++++++++++++++++--
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 6de3c393ddf7..73705421f423 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -555,28 +555,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	EXCEPTION_PROLOG_COMMON_2(area);			\
 	EXCEPTION_PROLOG_COMMON_3(trap)
 
-#define STD_EXCEPTION_COMMON(trap, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap);			\
-	bl	save_nvgprs;					\
-	RECONCILE_IRQ_STATE(r10, r11);				\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr;						\
-	b	ret_from_except
-
-/*
- * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
- * in the idle task and therefore need the special idle handling
- * (finish nap and runlatch)
- */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, hdlr)			\
-	EXCEPTION_COMMON(PACA_EXGEN, trap);			\
-	FINISH_NAP;						\
-	RECONCILE_IRQ_STATE(r10, r11);				\
-	RUNLATCH_ON;						\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	bl	hdlr;						\
-	b	ret_from_except_lite
-
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
  * it has to do so in a loop, and relies on the external interrupt
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 54db05afb80f..dc1940c94a86 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -441,11 +441,26 @@ end_##sname:
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON(realvec, hdlr)
+	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
+	bl	save_nvgprs;						\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	ret_from_except
 
+/*
+ * Like EXC_COMMON, but for exceptions that can occur in the idle task and
+ * therefore need the special idle handling (finish nap and runlatch)
+ */
 #define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON_ASYNC(realvec, hdlr)
+	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
+	FINISH_NAP;							\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	RUNLATCH_ON;							\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	ret_from_except_lite
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.20.1

