Return-Path: <linuxppc-dev+bounces-22360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A5CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyS1Cytz3btR;
	Wed, 10 Jun 2026 08:20:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043600;
	cv=none; b=KmIlaqM2Wzj6DPcpeQmTOs1TnwLi2tyAAupr9bqFp3xYBTNQNEfEa5vygsH2agMRgonBY1/O8dAE4pkbv4jmhvTWAe5X8Ca7n4FdKmGA2Q2SkWBCbVlF490WWcDry/B0VbhxvwDXTLQUx/+mB0HHlOeSm+TAOjI70J+GeuxfL+6u1J91xpO7ZtrPw09pTTbkSJRtNIMbtnNTGIiNn+EnDSYOsMc/HtYg4perQ02Kr3rn1CI/YzIOn+KtI0f0H6xysa7EnZgAIR7U+2zGEgLgD8nbTGtUtoCKL7mtiqiRoCVlBiHGXbiFhJf06mA+/JcXGU4DzwWqUuLDrDMg9bzmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043600; c=relaxed/relaxed;
	bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3lOtQuexLCn21semNLCwss5ybGknZtnG4YhUq+8awCoW/imaAE+QT0wG3K2XgbvTjj/WS6BNaoyPbo1XMTwNNvGHUatWCy86gLd6EY7s/jkkQH6H8WIH/QsUiL6VG6a/sLwsdqmuFVFIiLd5VPCEDA7+ZZssSeaR+fuVtxeJPXdxyrf8YNHQLNXVTfikF5rr86oK83vKUsXYVCtJOdsmrDMQAeV486zlfUB2mo+3PS+ILWrrkBk18pBoGNpfpphDyA09GqVLqz/fe6Sd+T/CFXFJMf3fyRxtaLi4lW0QLQ90vW8L44NuKrSchuVRd6ZEixYXCrf5eoqW3oI+aJhGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxZAOYZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxZAOYZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyR379Dz3bwd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:59 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so3707125a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043598; x=1781648398; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=rlxZAOYZDu8KQyGcDuRjKuk2DMw4Dqk4Fdb/f45nyC5K7Pvxm1rLJz4DPrMNAx7Wps
         J0FLyl8BedA1ztCmUT/1iAGmINyJfn2bjXgiusoMpSRxodvwsyHB33LHXRPhoLyHEPZG
         PIGWUAgUdxyWfey9g5FdD3hDx2q0ezbOhqyt8NkBE6k/U7g2h7u/9Wr5MeAdXpMPF9yW
         5nMcevHmOcUg7FXYSwvyiYWTtLJkddRiucge8vVXaSDkYdd0uxfSHiOoXxAXEr++2Irz
         ZGSEP78UnqwgUplXafk6DdSu/PD08F6aOwyygCuaxox0A4OvlAXk6hDd/J+6dT85xCg3
         O6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043598; x=1781648398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=XSWThhPTQTSLNjy9X8asivwo6zNfIXkCBjWM91XXiqkjrM3IuggrHtg4DG2T9NdSl6
         gNCT8v/ZTzv7FFmYHawzP2s9r9NthgX6sLiN7wrqJKACoFqzQyymPI7mbtxLWnDT2t4h
         7WWU510MfLqZVEwAsdoxkqJrKGcSj+ZRiztrbv+j5EBWrSZ5Oa2e4XMC/H++EJ5vjTVm
         Mamzg0jS54LZZ+i+LSK9iMCKl8R8GD1ZoqERu2Jk6Xj5eqeL0309+dlQR/KPnSbupIA8
         BfernSD5RwMpDF2R/fC/ppaltON1V8m2bh53wVjFiZ/rdj3gbT3raA/Mth18QeVyhqgB
         +qCg==
X-Forwarded-Encrypted: i=1; AFNElJ9Up5+/cTZB1fW6USwm6yCJKATIMCKfI2458/QXgwp/uIFIB/8IvkOSNrtxOjLuBhE8r1wNWHncl9lNeqg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRrOd5QyUgCagrb0xPya/WxcH/xT3KQGgpd4rrKHwxGgx2TaTP
	bNfhmSsruWEqY4GI0Fgz+sKuaIjYibV2AHxb3vKIXpGybTtQqiv2jDEJ
X-Gm-Gg: Acq92OEp9tk20R1IczJQSc/1qeb+MxhESylyOxC+lSAIq6Ky4VlSA9Icrp59lGqlzxb
	QUR6G11Pkiykh8KN9KTvxgy/2SLq+ok8mD+cvMLcYlvf8kApRWGB2HTE7l9QI4uv9eYHXIL5Ixw
	m9T+p4egA5pr33jU0+IOGIytZN1hsefoIEVvjuHhnCTzYUgU2ZQrsDQ3ChQzcUJ+C8/r7wD0uAm
	MJlO7Feg7lspFbUSVCW8dIq4PzMXjwEXjU8UI/LAOVa6Yi2TaalQ1ph2lHIFexZpPRUxKgb8AL6
	axspkBLMbQFZxEtL2kMgVGckP15yad3FzHFpNCs4Exp/zIA8upNjN6BlSVw8L/O+y0NRuoYrgQt
	SsS6g8zOhZlygl4YEmAwDcvSSaFBceX7kMyce1dBJI5+A9xwwLxrV9AZBvRZA75DtwBxJfAKqlz
	7V4TsLpEK4JvAvxqQjNNkUT9NYnl64j25LNHlp+uk3rHZE3FizBgyn1p0IVZFE4x7jXpH6VasaD
	d19jrvuHE8ZKwNBO5Vsv90tSL7y7qF6nyxm7fcSHkz7rg==
X-Received: by 2002:a05:6a20:2cf:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3b4ccd77495mr28317102637.5.1781043597716;
        Tue, 09 Jun 2026 15:19:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:57 -0700 (PDT)
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
Subject: [PATCHv3 06/15] dmaengine: fsldma: fix probe error path not freeing IRQs
Date: Tue,  9 Jun 2026 15:19:17 -0700
Message-ID: <20260609221926.35538-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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

If dma_async_device_register() fails after fsldma_request_irqs()
succeeded, the error path jumped to out_free_fdev which only removed
channels but never freed the already-registered IRQs.  A subsequent
interrupt would access freed memory.

Fix by adding an out_free_irqs label that calls fsldma_free_irqs()
before falling through to the existing channel cleanup.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 3009e1531292..4475d50a94f5 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1306,10 +1306,12 @@ static int fsldma_of_probe(struct platform_device *op)
 	err = dma_async_device_register(&fdev->common);
 	if (err) {
 		dev_err(fdev->dev, "unable to register DMA device\n");
-		goto out_free_fdev;
+		goto out_free_irqs;
 	}
 	return 0;
 
+out_free_irqs:
+	fsldma_free_irqs(fdev);
 out_free_fdev:
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
-- 
2.54.0


