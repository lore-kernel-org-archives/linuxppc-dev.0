Return-Path: <linuxppc-dev+bounces-22459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173FCD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJd6N43z3c4h;
	Thu, 11 Jun 2026 13:53:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150001;
	cv=none; b=ltIeRrnmsPKCcTRHxBOYvKj3P1ZXmcqxXlzr8AX6pjxdY6EzQinBnXJd0X4WOajV5T8nlsAyuTW2VqbGTV5tb/9ZCutsEdPcCr21hTeY3Ue72xZdkCT758kw2XfTmhi2FPPlpj1vZJ+fxuoDCIoSF4x0cHexWuHaTSrKfH6fBhkMAaSgIAcZjRgYSy7tm+tcDAP+y+vFuFA76e+tU0KlDSH+NuOcnQcLHb/kPF0VrGsAnQpv9SosxtV6Mny9iNg4wz0aj6pncX6ByiGhvMdbDX9a2b74/VokA/rkxRHY+EaIY0O9oE2kTmGkMOr0UfVFlmHBnrYz0h6IR/FgFX/PAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150001; c=relaxed/relaxed;
	bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km6m76wSHy6OuBxa8+BGnhNMS5nFtaU87GZ0aOOXS27AGL7uMSmi2c9vXtMJp1pGNS1ekWM2YbDBMxlhjS7TYQHAoGtF8ak3rFXkjfj5eRysr851dwqZIRdW4mafbzCxDZvrvmt02DnVdbZLfmtRvKkBQnx6+nEHMoQHAjstxvWKALAM4CpeyORO1ONDYbbAS+ve7eFsPs6E/aItqGFJR5cJ4PgyDL+zrs+PPTnuYgbhYmWi5zdf9S7BbYGY5grE/Gbjtz82SnVQPxbmQOy2Dd5UtqlY9yhVSP/qHWYY8KbOUUNR3sH4EJ4Ui815IDBEg0/Iv1jjV5T1W9wuPcgeZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y++gDHCn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y++gDHCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJd1s8cz3c5m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:21 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso6502698a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149999; x=1781754799; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
        b=Y++gDHCnInyud4q5LD1W5UHa47qrGKkbd4pVH49rzX2kgp1suMJ1jcVwwmTG9J49eh
         /bif9iT2d7pAyn+urIoOSFruPP6VSKWk5RKIDL9avFGDLwE/gcXd8qZnTEH85pWQUF2q
         VjRRCw5aKwKmdPlKwm6ypoWEr4ujA7bbvtAENlY9cTtQGhRgZUzJ0P4RNu/S4GlnRXWa
         D9HbU7AIQ+IaoLQwYgvQ3BLUicFHDilZOSXCafFfcC8rO8ctMl7sUXdhdYpNJZmeP8p+
         18ToYWcqqUgGiPIGOorTscYoml65RMAFXbSA9d8MlAExDFkImTxIfJEj+NGHsVMRoszN
         9IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149999; x=1781754799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
        b=aSQQYgW+e1I9WoFIA+Dp1i4J8IcE01a1NoKA92iXO4fHAibN4JXuL+NklbEJ4D7y1p
         nY1tOyHn+CVqBU0xMjIVcEMP5QognYnc1NsCjlL1ohf4O78T/zpRBmfX4djipVW7aI8e
         k5X10VExz8BIdiqYN5jht0OwlRrY8G2VocPXed375xds1/5E4GQxRRsZEKXgGprIh0QK
         BpGmhHxbf//MG8FEng5qWxVPFfhAjj7nX9nxz3Fq82Y11MaIIFe0/xpfi4+pmcdPiCfI
         mh6M8FSwG/P0fTQAJXFEscYh7xVjWg6Jdv0UbDx9U76HBgeuYVsqDraBuZgMl+ACP1z2
         yAPA==
X-Forwarded-Encrypted: i=1; AFNElJ/Q19X7mueGWbBHwSjdnj9bJ5u8AhrWzpSBgwcl0s5b7VJxVXuh3Wu+9PH80Ce4cFw+RLYNFx2MGwNEbhE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEzoEUqLwF2M5FhfJ85o6fNOgIZWGQN7STydXZvp9G3Qukg3uZ
	mBl08Ir8k8bnSCXzcNU+c7z2ny1iEOfjYnT1ZQmGupTOcFqchq2jUWkh
X-Gm-Gg: Acq92OEutixCtP5oBWJ1oHZxHSgx50kPFHpKUFImxlpHYBHrxi9m2OHjBGf+At9Rvfh
	Mbe5gQi8uxfJUK5SvLfD5xuuoxp27zEvtfULOswErEVgiuPppAAM3wRfbDGLG57TkJfFk+BX24J
	yL8LxIEhqCP4UFVAuGQygJx7+rXqwiq032P9cCQxrfSxS9z5sURgm3EtrYrGTfl7A4KKZ9jWTJE
	Uxj/zf2lUrKPoMsAzOYYPY56qhydi1O25zY1fr+uK2V9XwT21HXZNr9mFB5wyYzkAmJXlo85dXv
	EVcF/us1NOwmi+cgrknREaweIuinzlknNoa76OinK94ePU1jYubhRICGISUbkH5c+uMwU2sG9uZ
	M+DJZzGtvRAGgSBACU4/XQZgZUlaa4kEIOtll/eEkmaPUKvAnfSF/G2A95RBbwVlq6GpGEi4HnO
	3U4Nd36DrprDh2KYYDnUsLRe84z/ShrZApr03AZX2bh7+TPeXDpIxbM7Svzn9sBkqAnDCdgTgxQ
	Xe9xnML7IsfR9/x3h7FciwuCzNbzpX/GwdsayYZ/DHoDg==
X-Received: by 2002:a17:90b:5204:b0:36d:f28b:72e2 with SMTP id 98e67ed59e1d1-3779f092a96mr1323967a91.8.1781149999281;
        Wed, 10 Jun 2026 20:53:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:18 -0700 (PDT)
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
Subject: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
Date: Wed, 10 Jun 2026 20:52:41 -0700
Message-ID: <20260611035245.13439-12-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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

Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), tying
the channel lifetime to the parent DMA device. Remove kfree(chan) in both
the probe error path and the remove function.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index e4a3315a7d9d..0df09789187d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	int err;
 
 	/* alloc channel */
-	chan = kzalloc_obj(*chan);
-	if (!chan) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
 
 	/* ioremap registers for use */
 	chan->regs = of_iomap(node, 0);
@@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 out_iounmap_regs:
 	iounmap(chan->regs);
-out_free_chan:
-	kfree(chan);
-out_return:
 	return err;
 }
 
@@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-	kfree(chan);
 }
 
 static void fsldma_device_release(struct dma_device *dma_dev);
-- 
2.54.0


