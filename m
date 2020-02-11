Return-Path: <SRS0=nxP5=37=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE302C352A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 05:47:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708712070A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 05:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpjAYnqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708712070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GsHB7441zDqB7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 16:47:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mpjAYnqR; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gs1r2MrCzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 16:35:44 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id b9so5087622pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2020 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sy30zezA8UG0tp7Giemz8QNhssiNZiqXiDjk5/wplUA=;
 b=mpjAYnqRuvMD9/SoEntvXcrXY23ZuOTehtjlFlr8W3MGcgf02zFdvEefcivt/nKSuS
 rQ3dPxz8GZgoE9oyKb8XS3h+3H8zbY3cX0o3JVNFcQmNxnHcGY4fI3qOaHmeW6k7Zf4m
 v+KvHIsWOWCYIiydUfCS1ZFdsBI9WjeOojb/tmFMfcOHm+EPujMdhev+ZVAigFRJI8PE
 KAhhybKRcStZH1Iia9XMcttky9BwGrPWzPukInTxLyiIl2VDiK+NQwU2RVXeW28pa5XJ
 1tLwFSUnyRMBPO73HDkfO35zZvK9w5i3ijI54Cn5s2+jSF0n37INWeA4yjpsQPWoczC7
 ChXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sy30zezA8UG0tp7Giemz8QNhssiNZiqXiDjk5/wplUA=;
 b=OYOWgMpk9RKLmdNVdt2S01h46n2UmIaBlZR2QXCvjssJyZruXG8o8Ypo1TLTFi6Utd
 +EuhuerhfR1gHzFJGkyT0IShtw5CsNBDIbznMJHz5UtuN81fsKHWuMpzSbLefZPY4Q8y
 lFYyXlVhHfWTZBMXP8vEbCYiRLyFS/+Sthod955PbOp0AXJSgomwNegt16tS2gm6Uo8T
 04/yiyx2Ob2Ajsx2AGKGfEGwHTOLKeE4UnPxhrKiLvWe0ZgoDL+7EHa02FBS6thOR92w
 IeBcxXr+VK422alaXICv426v9WVwvwippLOUbUgS3prxrjfY25WsjgHrHTYCHGA2I/9E
 1kgQ==
X-Gm-Message-State: APjAAAWFp7mQHESrxK6gphz4eeCEzo876cX2/JoisRs/hrY/65G+4XZh
 ZaEVP/E4TOsbuUA0q64rSfdgsSVrr3hVEQ==
X-Google-Smtp-Source: APXvYqw/vZuxM0XFDoZAQ4Z9EtnZT4o9dVehN1Nr7pt0v1yDWy8IFKR6fWQvFmwz4QpiShGs26fMQQ==
X-Received: by 2002:a63:e545:: with SMTP id z5mr5100536pgj.209.1581399341583; 
 Mon, 10 Feb 2020 21:35:41 -0800 (PST)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id a19sm1189025pju.11.2020.02.10.21.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 21:35:41 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/13] powerpc sstep: Add support for prefixed fixed-point
 arithmetic
Date: Tue, 11 Feb 2020 16:33:47 +1100
Message-Id: <20200211053355.21574-6-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211053355.21574-1-jniethe5@gmail.com>
References: <20200211053355.21574-1-jniethe5@gmail.com>
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
Cc: alistair@popple.id.au, mpe@ellerman.id.a,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net, bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds emulation support for the following prefixed Fixed-Point
Arithmetic instructions:
  * Prefixed Add Immediate (paddi)

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/lib/sstep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 0e21c21ff2be..8ba74c10bc03 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2777,6 +2777,10 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				break;
 			op->ea = mlsd_8lsd_ea(instr, suffix, regs);
 			switch (suffixopcode) {
+			case 14:	/* paddi */
+				op->type = COMPUTE | PREFIXED;
+				op->val = op->ea;
+				goto compute_done;
 			case 32:	/* plwz */
 				op->type = MKOP(LOAD, PREFIXED, 4);
 				break;
-- 
2.17.1

