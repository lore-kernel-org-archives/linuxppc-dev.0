Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCACC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 15:57:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A21B61351
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 15:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21B61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5RWh4YG5z3dZh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 01:57:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=aNLcpBVH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aNLcpBVH; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5RPm2DM5z3c4j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 01:51:56 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id v12so3153634plo.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zsgJUSAgahOoBmB/HGol7q1UxchoF+3q7z2sPlgS9Gk=;
 b=aNLcpBVHcqNwq2FrOHgpWEh3tKihr5EOM3f7fJn7SDqfqa6N1reDjEk5/V4H3oABWI
 0vUczvpGxJ6mWYTiIqRZFRTgVHbBlA9fVG7aoB4Hc/fEZjc6t5PPP1BPvIZv4GCjBgMR
 Uc81oVZ0TH0GuO39Fvu+Ytq/bEvB0wM92rOTWh30oH+fOUuWhfyOpxg2qYGWiXMBHtJp
 ddB8bOG6E3Lb2nNKz7hEt62CV4JM1CQlOlH5GEmSeU5TvhcdvIx+FPCfgJ3k25ub5fcD
 Yv+sVEbo+wuyAwV3GIttPDBuvVAD/tlpDEBjOHuevroGWyqmUsNJ4sLN/88c5xA8m+mM
 xLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zsgJUSAgahOoBmB/HGol7q1UxchoF+3q7z2sPlgS9Gk=;
 b=AuVI904WoVkThlUUgC9C9KhUnorypi7xQR2QNYJuzngBKVOY9MUZdLQnkcMLhtBPm5
 q7hwWLVyT28RNzNOHwl48cpH4Tz696HCBNzAChE4SAY/5ZnCZCrzNHT82LTiA9FbbI9O
 N6IRPEUUB/PzUhTjNeSNPg1mVa4IKPxX8TtDcwmnyULU16ldFdouwJaXOfEq2qZ0h74E
 sTiQ939M5Ya6JCBCyKZImBT+HHgLFk1fWGIolmIFmiq7fLY2I9SWshnnPqvqGRGH2jdx
 7cp/Fdrm/Y0D82OYhfWwWn4a7ym6RmkfPoWjpbi0XTH2P8DKLdbV6s+OE2rBHKhQh5LW
 jjBg==
X-Gm-Message-State: AOAM530cYoIKiGfGLLFQGNrfifDjStmCmIzYpl2tK06I7lZYbYmlaeig
 jx1DyIWv0wDRNTStQW2wOPC9iUVW4Zw=
X-Google-Smtp-Source: ABdhPJxBXQtrlnOy6YXk8ygJIdNZGbLbQ2s1DieU1gfXl4ieallp2LrVAA9jVm90Sr69e3XFOKecEA==
X-Received: by 2002:a17:90a:928c:: with SMTP id
 n12mr4162123pjo.30.1623945113073; 
 Thu, 17 Jun 2021 08:51:53 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id a15sm5749733pfl.100.2021.06.17.08.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 08:51:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 13/17] powerpc/interrupt: Rename and lightly change
 syscall_exit_prepare_main()
Date: Fri, 18 Jun 2021 01:51:12 +1000
Message-Id: <20210617155116.2167984-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210617155116.2167984-1-npiggin@gmail.com>
References: <20210617155116.2167984-1-npiggin@gmail.com>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Rename syscall_exit_prepare_main() into interrupt_exit_prepare_main()

Pass it the 'ret' so that it can 'or' it directly instead of
oring twice, once inside the function and once outside.

And remove 'r3' parameter which is not used.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
[np: split out some changes into other patches]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 6dc9b7536511..5bfdf8f9b130 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -243,11 +243,10 @@ static notrace void booke_load_dbcr0(void)
 #endif
 }
 
-static notrace unsigned long syscall_exit_prepare_main(unsigned long r3,
-						       struct pt_regs *regs)
+static notrace unsigned long
+interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 {
 	unsigned long ti_flags;
-	unsigned long ret = 0;
 
 again:
 	ti_flags = READ_ONCE(current_thread_info()->flags);
@@ -365,7 +364,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	}
 
 	local_irq_disable();
-	ret |= syscall_exit_prepare_main(r3, regs);
+	ret = interrupt_exit_user_prepare_main(ret, regs);
 
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
@@ -397,7 +396,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 
 	BUG_ON(!user_mode(regs));
 
-	regs->exit_result |= syscall_exit_prepare_main(r3, regs);
+	regs->exit_result = interrupt_exit_user_prepare_main(regs->exit_result, regs);
 
 	return regs->exit_result;
 }
-- 
2.23.0

