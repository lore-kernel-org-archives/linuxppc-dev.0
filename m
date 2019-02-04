Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC94C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:48:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEBB2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZDauDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEBB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVvJ64zQzDqD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSZDauDD"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFW4jrKzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:11 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id q1so6818697pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T0rlXOWVyPhrfSFAvJf3qYcg4m2syYerNFGENr0aZp8=;
 b=mSZDauDDdZiZjaj2Yx7ADxWnIQxReLcUOQ9ZVOc1kqFmo5XS6ec/+wx9k+dIuJStag
 YmYQsbMYXj7BYbctl4sM2XofbC/RkZAQBwoTHTWTD60ioy1K4kQoWJO8HOwLJR9asJLT
 DDcmSgXdQIt/Bl3lAUvF5XN6ZehW7lfOHKnDYS2HaABN45zc4tw/CYTdLhXLZvG4AUkM
 upcO0wHpuCbk1UmFnSkiL72OcDjq1Y0xZvqrqkdk1D23W4jnTTUX1ADpCuk9mCesy88b
 H9QVoOe6/J1+pg0Ii3x3dhXTBUB5WAn56zUWyJGIam/EYje0W5UUfYc2QhXh09ALIPsf
 74rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T0rlXOWVyPhrfSFAvJf3qYcg4m2syYerNFGENr0aZp8=;
 b=AqLMqZVdWQwZJQEql4/KT0NTmZIlwFs4DzPW9HwQd2NHJrXInuXVR1YBR17IO0dUqe
 2vLAUOAgnEIs7hQ4DIdOQqFuil7YiuBRtvgiJ2qwXGx0imEbXNcthep38816qav5nK2E
 T1ePDOqm/pzSkGsflLOnDlnu37qJIXzvAIIx7jlR2YayVJLHyg3Fk2eOlW7SWpDZxz97
 yKeeHem10maro37xauBFHDruqHk9CCcCgwPUFTZwA/Ici47XJ5QJIbveEDJn2HYfOObJ
 HS/ZMTkGpSN3XS/1czUSlISDg+7z4qrBQPLTGrQ7oC5pQ9qAV7qgeUP391P/THeH+FtL
 qpaQ==
X-Gm-Message-State: AJcUukf85FKUqip1l/LwtgFn0WTE6ecKwz4ItZbw7cu8c6RoexahHrQ7
 DKi2g434Q+YvvUZWrX4duOwDuENb
X-Google-Smtp-Source: ALg8bN4XMMEyvhIE47JsrvmTdGC53zqDmekODcu6OORfufzoYjhDIQICcaGEdoBHM+NGXS6RViU8tg==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr50137746pfn.192.1549289949320; 
 Mon, 04 Feb 2019 06:19:09 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/17] powerpc/64s/exception: remove STD_EXCEPTION_COMMON
 variants
Date: Tue,  5 Feb 2019 00:18:25 +1000
Message-Id: <20190204141828.13043-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 22 ----------------------
 arch/powerpc/include/asm/head-64.h       | 19 +++++++++++++++++--
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index e7e5c71b1ad0..4d3bd10ea59a 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -557,28 +557,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
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
index 40096c097c3c..341f23306a80 100644
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
2.18.0

