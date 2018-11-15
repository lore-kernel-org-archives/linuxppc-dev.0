Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201AC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:38:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DAC2086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY9xtfZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DAC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wQXh2kMvzF3Y8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 13:38:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YY9xtfZt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YY9xtfZt"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wQS01TlzzF3Xk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 13:34:39 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 80so8281750pge.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 18:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=eYAobIEm3gQtibGKZFELCbqE7wV05FwwLjtyho5JmGI=;
 b=YY9xtfZtYzOhb2S2HKO2ntI7kQjI7rQeW358iNQXulPn9x8YegrVDWdqaRA7Sj1ohi
 Spmzz5ApraNqyuOIsexahdBoG7o1gKbEHKUGPkoHAFDbhtNn1S1kbz74iiZnptPLV4n6
 CcaslUftI4s3jsGLb2AG6dq0pFj3VqJAH3AuAI3v1rmZ9ptXa0xWXP7+WntgRpnFYq4K
 81NE9/Lh5BkAxPDmC8fRQ/PG82FdO36UbGJBYfEfBkA7LV8xNf7PcGUQx4rPhao24wva
 ZebXRhTEX27qdyBbbXg7+7znyeXIYoFVySPG6zGYE8f9dr3WZj9fdcVj7VFkIlJApwgt
 xvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eYAobIEm3gQtibGKZFELCbqE7wV05FwwLjtyho5JmGI=;
 b=Or2xTjEhA6D2P5NiCVfgTH7n3kANME30VpgXxegBtB89QU+sMZk+cPJjh1jlGH3sLT
 +BwxrtG5N2eZhRtecwHsLMmt5c7c0Lc9REYX8fM5+MIPUfBE/WCtFVnlnTVFsp19RJON
 OKbG+8xVjxHhOq1lR7XzXtCjmAbTVS7n7a4CEc1zi0S6Y2nUyLLRQo/sDSQdk/HJWAL1
 Kt2gXar5YP2TyegbcumvwHr8vBgyHfzMLxdUdIPuiKlKOvNdAxZdXdMZFiZ6ymvgZMnj
 2W6XKHg8r2m1SBgN3I3hJYfx8dr1BQcyPHzO88yO5NuJdP34q27AlCnv4fn0K/T7W9Fg
 RIWg==
X-Gm-Message-State: AGRZ1gJjY4qe1VwysAIG3wH41d9d84FYdGuMcPZ9jAtpqlGyuxYdB7CY
 ZdQUoirN2XopGJkZYvSJVjTVrP0R
X-Google-Smtp-Source: AJdET5fZhXhrRdzEHVhESJ1H2+V96cN4Ek2GR/hAIyyML/LTnNQMxXBkSJaOWOMVWj2LyWSoR0CDhg==
X-Received: by 2002:a63:1560:: with SMTP id 32mr4002368pgv.383.1542249277145; 
 Wed, 14 Nov 2018 18:34:37 -0800 (PST)
Received: from roar.ibm.com
 (148.36.194.203.dial.dynamic.acc01-tull-pth.comindico.com.au.
 [203.194.36.148])
 by smtp.gmail.com with ESMTPSA id o86-v6sm31143061pfk.8.2018.11.14.18.34.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Nov 2018 18:34:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Fix kernel stack 16-byte alignment
Date: Thu, 15 Nov 2018 12:34:27 +1000
Message-Id: <20181115023427.31033-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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

Commit 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
than thread_struct") changed sizeof(struct pt_regs) % 16 from 0 to 8,
which causes the interrupt frame allocation on kernel entry to put the
kernel stack out of alignment.

Add a pad field to fix alignment, and add a BUILD_BUG_ON to catch this
in future.

Fixes: 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
than thread_struct")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h | 1 +
 arch/powerpc/kernel/setup_64.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index f73886a1a7f5..1513292bf046 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -54,6 +54,7 @@ struct pt_regs
 
 #ifdef CONFIG_PPC64
 	unsigned long ppr;
+	unsigned long pad;	/* Maintain 16 byte interrupt stack alignment */
 #endif
 };
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2a51e4cc8246..236c1151a3a7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -636,6 +636,8 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
 {
 	unsigned long pa;
 
+	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
+
 	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
 					early_cpu_to_node(cpu), MEMBLOCK_NONE);
 	if (!pa) {
-- 
2.18.0

