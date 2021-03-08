Return-Path: <SRS0=xkpp=IG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE8C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 09:53:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B7C64FB7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 09:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B7C64FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvDF44YCvz3dHV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 20:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=btCzEuSM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=btCzEuSM; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvDDD4F3zz3cLl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Mar 2021 20:53:00 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id t85so1531822pfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Mar 2021 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cKOElDbOOYhBWt4cAVGyc+iLTO7fKLi9zB1w5hJBFng=;
 b=btCzEuSMKWDim8NDHRqt6OsgNoe/QwUxMVr7MScjW31FngkeiQLnUiYt33JqwBQfpS
 2T682Zl0rZl8Oqn7zg/kpdfpRmHOG5WIwFQfhuimkcFQ0WsEB8a+V66WIlfRzreLQEr0
 G6PKmcv2buoU7EzLQqN97ipn+ysiANboIxlanxnAKsIvZg/pz3cN6eI+La1jisDEyMty
 YRFoEhUcpx60S2x1YplDV1kUc7TqCYfowl8IvRBeDwlWezZ85asU5yey1o+8KmUaeH6X
 vv9SBCDIVn/NH2ZNxW5WY9q2KVKP1fAcH6t2K3bGOSUbDtPJtXQHJ88OKK+qxv62J6y+
 S1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cKOElDbOOYhBWt4cAVGyc+iLTO7fKLi9zB1w5hJBFng=;
 b=qWxgZIOHFGdGib22CXfH1zwtaAgTSx4Ax3VFvXnKptnXN94oB3buE+3HfMgCEOrvI2
 nApVUtnTD6V7qIdeX0KUlYb3gi10v8ITOYKUdoW9BeoH3cYbl3/WRZT7DqFmrtp2CyTc
 jqdACBmh3an+twMfQTFHgReLElmw8Rgx0I8x4L5gFsCZAEHOgD1W5x91w+EWXB2nQjL/
 5jFMctUrEo37sXk8K6NPI9F63VYtd66rOsjYizawltcUIz0W74yDdzUO2pmH2TBpIpFx
 xjiHplGNs0HBKRoxf11Ma4B5yjnatXvi/odJZrJz7ofRXhrSNhDPu11Cy3wHpKfE9yXc
 F8GA==
X-Gm-Message-State: AOAM530DHWzU4D0ldEhMqykwZXL4mkHKfn4wBhHMpCjtFNKBR+xr6bvq
 gkDPnFf1T38+Lyn6EPFO14U/bKiKkvY=
X-Google-Smtp-Source: ABdhPJwVpUlOlU5F0jgCuei4SjcY28Kbz5XE9I7fvregeAnMYE+LPG/BOi8F4fj2F8+gGmiHyCh87w==
X-Received: by 2002:a05:6a00:22d6:b029:1cb:35ac:d8e0 with SMTP id
 f22-20020a056a0022d6b02901cb35acd8e0mr20032111pfj.17.1615197177962; 
 Mon, 08 Mar 2021 01:52:57 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id
 e63sm1326850pfe.208.2021.03.08.01.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 01:52:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix inverted SET_FULL_REGS bitop
Date: Mon,  8 Mar 2021 19:52:37 +1000
Message-Id: <20210308095244.3195782-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210308095244.3195782-1-npiggin@gmail.com>
References: <20210308095244.3195782-1-npiggin@gmail.com>
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

This bit operation was inverted and set the low bit rather than cleared
it, breaking the ability to ptrace non-volatile GPRs after exec. Fix.

Fixes: feb9df3462e68 ("powerpc/64s: Always has full regs, so remove remnant checks")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Well this is embarrassing. Condition flags should be represented by the
bit set, rather than bit clear. That would have made the mistake obvious
even at a glance.

In this case, this stuff is going away soon so I won't bother to change
it around.

Thanks,
Nick

 arch/powerpc/include/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 975ba260006a..1499e928ea6a 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -195,7 +195,7 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 #define TRAP_FLAGS_MASK		0x11
 #define TRAP(regs)		((regs)->trap & ~TRAP_FLAGS_MASK)
 #define FULL_REGS(regs)		(((regs)->trap & 1) == 0)
-#define SET_FULL_REGS(regs)	((regs)->trap |= 1)
+#define SET_FULL_REGS(regs)	((regs)->trap &= ~1)
 #endif
 #define CHECK_FULL_REGS(regs)	BUG_ON(!FULL_REGS(regs))
 #define NV_REG_POISON		0xdeadbeefdeadbeefUL
@@ -210,7 +210,7 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 #define TRAP_FLAGS_MASK		0x1F
 #define TRAP(regs)		((regs)->trap & ~TRAP_FLAGS_MASK)
 #define FULL_REGS(regs)		(((regs)->trap & 1) == 0)
-#define SET_FULL_REGS(regs)	((regs)->trap |= 1)
+#define SET_FULL_REGS(regs)	((regs)->trap &= ~1)
 #define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) != 0)
 #define IS_MCHECK_EXC(regs)	(((regs)->trap & 4) != 0)
 #define IS_DEBUG_EXC(regs)	(((regs)->trap & 8) != 0)
-- 
2.23.0

