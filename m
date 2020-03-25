Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E510C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 09:33:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D7D20714
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 09:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8MwUPAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D7D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nNFn4fCjzDqjY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 20:33:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=f8MwUPAA; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nNCK3Yd3zDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 20:30:53 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id kx8so774349pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AMfvjOKDadlpigSJ4aW8QAUhnUbUXuvzudszQfaOw0g=;
 b=f8MwUPAAaSdhHPIk5MrUtMCLXim4VrrtHUsC1ssWczn4VEOCoOL+ZkQZUZaSAcZ0MW
 NG0KQ1hRAmUgrfeLiDoe5mfHBZN+OWr4svtXWQmyu4pscwLnNYIyZaExc9Gw7rIvKc3P
 /5KGj27GQoQwA0GkPWpJzOasJX8WjtzG5IbGE++ebwNEIUzM3ZNYjnTa5svMg+AyJS7j
 AHgntWFltcoiThT45vdgzlVKNg+1OrGeeZIw0adJ1gK5kf4YT5zxFeWFtfkwPtj0zlzx
 1o3S0OpughpMssZCl5HjnhYY/GeUZmbnvB1GcZvvaleNZGsQEmgTp00ttV+osDmoItDn
 FlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AMfvjOKDadlpigSJ4aW8QAUhnUbUXuvzudszQfaOw0g=;
 b=OThVzsNn2/fF3YGutatvWuRY1NgHNRoVOWqs4ptFsBDIDd6vw8/tAURu7CU9Q/PeX+
 Hs411bjnMnzhW/00mYFjteyy6EAQKgUqr+OYCF5RUn5O3ZDS7b44aiHq2tspSElLYuRm
 pXLL4S4nRNGhnf+7l1x8i+/XOds/YKpNqC9H7xuxUu6Th7TyL4VpB4CZLZD2XCvoqmF9
 AeqY1s2dcFjayVUvLjAIVdmRgQon2s8IW1S8vE2rf248h8esk+xfTz2eFHdkxBGCswjh
 Gh8nnIvSFIy6KRCA2u9B2nULBPFMyCMd+6Dro5GypvfpOhZDtfyvCsiyHDWQne8Rn442
 JVFw==
X-Gm-Message-State: ANhLgQ2rg8Ew8kv4PmnXKZD4IQPLOflNW6h5lQ1CE55Jdrmu0KDe/p0A
 Z4UvocNjkFVM8xTgV5CvEPMZ0jH0
X-Google-Smtp-Source: ADFU+vvCFmITaEqWU/MMFKr+tBqpuq6yvkR8AQe109iRIH5TaPjOjLmyAp5rLC7zKcBgr1D7aeVVZQ==
X-Received: by 2002:a17:902:a5c6:: with SMTP id
 t6mr2480416plq.323.1585128650681; 
 Wed, 25 Mar 2020 02:30:50 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id b124sm831904pfa.34.2020.03.25.02.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 02:30:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] Fix 3 "[v3,
 28/32] powerpc/64s: interrupt implement exit logic in C"
Date: Wed, 25 Mar 2020 19:30:14 +1000
Message-Id: <20200325093014.149962-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325093014.149962-1-npiggin@gmail.com>
References: <20200325093014.149962-1-npiggin@gmail.com>
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

This fixes the interrupt-return part of the MSR_VSX restore bug caught
by tm-unavailable selftest.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/syscall_64.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index 56533a26f3b7..a2995909b83b 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -251,19 +251,21 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 		ti_flags = READ_ONCE(*ti_flagsp);
 	}
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S)) {
-		unsigned long mathflags = 0;
-
-		if (IS_ENABLED(CONFIG_PPC_FPU))
-			mathflags |= MSR_FP;
-		if (IS_ENABLED(CONFIG_ALTIVEC))
-			mathflags |= MSR_VEC;
-
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && IS_ENABLED(CONFIG_PPC_FPU)) {
 		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
-						(ti_flags & _TIF_RESTORE_TM))
+				unlikely((ti_flags & _TIF_RESTORE_TM))) {
 			restore_tm_state(regs);
-		else if ((regs->msr & mathflags) != mathflags)
-			restore_math(regs);
+		} else {
+			unsigned long mathflags = MSR_FP;
+
+			if (cpu_has_feature(CPU_FTR_VSX))
+				mathflags |= MSR_VEC | MSR_VSX;
+			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
+				mathflags |= MSR_VEC;
+
+			if ((regs->msr & mathflags) != mathflags)
+				restore_math(regs);
+		}
 	}
 
 	trace_hardirqs_on();
-- 
2.23.0

