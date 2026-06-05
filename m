Return-Path: <linuxppc-dev+bounces-22136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CFFCD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlc2s77z3bvX;
	Sat, 06 Jun 2026 08:02:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696924;
	cv=none; b=JeTfwIW2ToXGzq3C4Eqrz+LCHqhhAn6Fk+PlOeUd5owvZsmD1magdSyRyBZCRZZV64nkgCM77FcfW4a8o0AVL5Kjy50iCXPgaAAf2Dww8E5a6RyxF7xOEcNkFfcpQs5PbEFeu2NerHXt5U2SXeI4bJr1L/WztAF+/5Z4allSP97JjE7twaBJp6egWrSH9Jf7FcwnMXDp/PxPIksReHGzJnh7rk+sssLo4UyUQfgpMIx3WWjSqHJPOQyj3+iBGx7pojHUaS5RP7/rgF/RQRYBeEsw2xb/GWZ3U9mQa5XLhafFbTkP69cGGPOlqsXxpYfs5xbuJUxFzoMyQFTd1l273Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696924; c=relaxed/relaxed;
	bh=w0IcJHFrxrpFxcVE04G7XPPulmPSc2DO5kl+s9g50fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn4VoIAq+0POwzxI97x3MDn/JLe8XhMz1QEGEkVOYrvqE6jXGjifiLUEvAS+baT49Ys9eQBzSTZVC84pXDuzWlxwKfv+3XHGSvr3NwJ4LdXZ193b9jwg3RCnTYUphFAMAmWoOqup7PJl4fOo8B/vESD2+Ue3qW8hCJkd3LwIafuCSVK0Bcs4yH5vxqS/956K2cWQZxbeFlauMYGLaHlCgMe6/vXh31qvzRvGCUmaw+pugHA5r+2AdzZgBUTU5yZprOjp+NY6/TjYFQi/wQUKvNb7nwpxcpB5eBobz3OEBB15tFFGe4vHDr4w4nc24Hznw2ODiuuKvZCIid7dQu99ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L7G3Z/c+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L7G3Z/c+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlb2tP4z3btm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:03 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8422524cb38so827302b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696921; x=1781301721; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0IcJHFrxrpFxcVE04G7XPPulmPSc2DO5kl+s9g50fo=;
        b=L7G3Z/c+T9f00dZbDAnNPTrLFq4wiEtONoCGn8iym4ZiK13ROUzSrPkH8DScUrTF1s
         +8AujZwt173TCMDXC2UXWGzmZeucOeDDuilbdsGPKWckT21FeoGU2GQOJbcam+NGTwPW
         6V4mV7FCEcu76Y2EFNusOaMS6lg7dZ8PopLZ19Ie79iSXrgaB+2WGeWhC7Py5f3TfIWm
         4JxzD11ahs6hob/09+jXfgGaafrdLeIDT71B4L5NhPpkOqa+0rivkU5Fpb7xI5BM/MP7
         w/JkQIGkB37xbGyu2tJSbxMwLndL5tkuL/nlm7nxWvbLQllEW23m9KZpiKsfwjCRGMQY
         K92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696921; x=1781301721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0IcJHFrxrpFxcVE04G7XPPulmPSc2DO5kl+s9g50fo=;
        b=WdzswsBYg1bIb+KSBi2pNivEMpDKjTxKEuU92AhLQvvD3ARc1Ctpzz+f7E65Cas3J/
         bB4puCW8WnaGz0oBkooAfIRRtb17uTuaw3nX0yx8IA7tTBaF123Lqt7adGHzVDeSd9eJ
         al8c132vlUoB1BQwLOK1EMhB1yGl287QNoB5x5LnpZRwXoBM+j03+TFdHkL7u/Qr9fR2
         ZrQe7QrjTAOSIeA3BgPtYVJuCwZhKhZewFWfEImFrbGC11R8AHIqNUyYiU4L6qBpEkSX
         9GKUGZwHAAt3p2OjxiTIntF9CpJEkVyRQxRvl4f62Yms6vuRualBz9pqe+f0JF634kVF
         2bXg==
X-Forwarded-Encrypted: i=1; AFNElJ90rH6ZLuaNCwzzi8TBgV4EU9HHvnGE/wPpIx0UQXa2QfGFYILf7okmtl5It3hubVDxX5AEwPVCADvTlYM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxXxhpQ2k2F5tLjPMMT0FzL/bX/HsnHfQOJXQNjPkq5EGmFv+x
	jLjuTlP1B7EIV9ieOSmcp8Wh/L0rzCLC2TjevRF1Knx5Pn/b/D8af6Fs
X-Gm-Gg: Acq92OFmiDiyvRu5b3q138aCBN9+tQQd7Qx+POKKFxbvNuTgbL9r+xGUyCalgICmB2Z
	0YjyxcvJF9ZO7Cwe5SFpzVhuplc8ovB5BqEyF1JeCsMu1MoiAzg3zx8jSniG13DUUYNQEWDPEhD
	z2cAgYqsHANa2WqsTLuIBjd8SQZPhjO8XjWm1jBY5cM++aMNt53FchAoMdVWSb+jWjsWhQ45b4q
	QZQ2GJzaCu4Q3wM2qXGPvCVAuEfj3OL8dgaJ4mosvxImnrmNgoU9waqaoLA1UvEwtbz1rT+dRtl
	wfGp7KQ9B+IQ651u0DCmuYXATZ7d5RpJQ4SFhX9hW9bAcjE7y+vMdBR7lvV6JGMET29hVa3sI/a
	d2R8Rf2f2ux2LrJPZnAye9CyXvrhQpFGZS5ZLoX/9tZQPiEHrijmirNWEJp4/hpfuFswy0VT+MI
	y++4W5pp8orhGzUEk/gOGPi+FI4O5e3mqRVMSDRTfHHP5QuFV+t1xCFOL4ncGQ48a+RlkK+9HO2
	ep20D2VuPZBrvyrRzVFYSRJZ4v+ACbEd/8i5isT4w/nGQ==
X-Received: by 2002:a05:6a00:1c94:b0:842:6d5d:58dc with SMTP id d2e1a72fcca58-842b0feef0fmr5682549b3a.43.1780696920695;
        Fri, 05 Jun 2026 15:02:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH 05/10] dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource
Date: Fri,  5 Jun 2026 15:01:29 -0700
Message-ID: <20260605220134.43295-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert of_iomap to devm_platform_ioremap_resource to let the devm
framework handle unmapping. This allows removing the out_iounmap
label, out_return label, and the explicit iounmap in both the probe
error path and the remove function.

The DGSR (fdev->regs) and per-channel registers (chan->regs) map
physically distinct regions in all supported variants
(EloPlus/Elo/Elo3), so there is no overlap risk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2efa16d12679..2a6a247761a4 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1229,19 +1229,17 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
+	fdev->regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(fdev->regs)) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		return -ENOMEM;
+		return PTR_ERR(fdev->regs);
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
 	if (fdev->irq < 0) {
-		if (fdev->irq != -ENXIO) {
-			err = fdev->irq;
-			goto out_iounmap;
-		}
+		if (fdev->irq != -ENXIO)
+			return fdev->irq;
 		fdev->irq = 0;
 	}
 
@@ -1309,8 +1307,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-out_iounmap:
-	iounmap(fdev->regs);
 	return err;
 }
 
@@ -1328,8 +1324,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-
-	iounmap(fdev->regs);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


