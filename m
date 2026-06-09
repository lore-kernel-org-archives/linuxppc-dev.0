Return-Path: <linuxppc-dev+bounces-22366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13B7CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyg65lhz3c6P;
	Wed, 10 Jun 2026 08:20:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043611;
	cv=none; b=ChJOjy4njSt5scnoD6f4tT7MTCG8oOkjUTHDUZk0ZQU3h8kKRPAe+ElNs3zMp7CiFvjdvE4Ypo87/60JoH+Gm5iQoIkxeUGjodc+bLciR7cU3NpybocOb911Yl4KwfbnGGr9b9TwNb82LkHDKjdf0F4VflThYDEYl0dhUhovrxYP0I45OkZo2lQAq3nUxfhSIkAw4y/E1dhntBpGaJhDZM2BVbpIsnHc7LhoyHOH8WJnMhmhIn17r7umL3Ld27gHbOF5CRkw7ZnqmVTRZjy2bcJKF4RwrGPO8AmPKO7IGcumBEtiaqimLL46dg3mCpYw0cPQclw1fI8hIkdsuIbMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043611; c=relaxed/relaxed;
	bh=6APiQiw2BT/NGR5IuAfPSsypVG22xWgyAJZHy+kmaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLOQf9DuEmCN1Wa4Sem/pmoKPzFcbIiDCLa63aYKHbKzu+BxCHQP0Da4wOGQQwEDmprGbxfjHNPImY9hFYKBQYkpP6zonS5RoHizIGH7TDKNJkxn+hVpXtxP6MWoKKgeepstznAbf3S+kC4DXWh4VC/WQMhe4USuS9JYV9SteqLzTxZcR8SEBuqUabpviIEDWL1oQlmOAD6cpsEKEqAHi65ZJTQL3356VhDD1eZ6PPhcCMgqh7HZKX9P/t178YTeWORXTIVAGf2jrjqRwrWcE57lJqGuoz4AlWu2MM1Ls+NPERy9og2qcNTOFHqH0eUBh4gjI5CfZGpaX0OePVbbgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M5Ir7s/P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M5Ir7s/P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyg1FpSz3c54
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:11 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so2167124a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043609; x=1781648409; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6APiQiw2BT/NGR5IuAfPSsypVG22xWgyAJZHy+kmaO0=;
        b=M5Ir7s/PdmnvV17Rr/a01dBq5fK97cn1Q9hqRgUX8k76oJZhatXD2/Q8JU6L4u3UIa
         vGNsNtCBdZCcJtRCeYee3RBdm7Hi+iaEp3hSLONwP974YPSqA7+SB0rQb2K0p9kz70b/
         6StuOFktGmN8FwspLbc0mrF82XuWbD6E2KPcXzW0IGe9xu1NDGoEUmay24iBUF5AGEBB
         ZkfR12ceDkqdu4ihpbhhyFMXoJJI6u4DcB3Mz+fk1Msdob+FOUVyzt/vN0R//8wf1K2h
         IwpBJoS0lc1D+lZWx7o4EcTngH8rpDsi4aIXE/t3wojjW72skFctNupEevSD2JsopaEg
         YevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043609; x=1781648409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6APiQiw2BT/NGR5IuAfPSsypVG22xWgyAJZHy+kmaO0=;
        b=aznK4+w6+L+qQxDUlsdR5sbIYMoGL0OUbWR1oTlMZxRKUdO6MMIY42aUObDAemAqY5
         zSHFuPa3C70vMUW4VhAhjqW/lyFFNAGFzpHP37Df/nmMPqwWj5UoSQRetx8k+uR0dT2d
         Fhjnmp7ZWv/berpM8jtkFxI5SHLnR87VZT2UDCQQQFGpVUAnA4Ljg6wJmod5REshM4ac
         G+qXNz7B/tNIhJY3cN0omszQb1bzWlBwW+RWyfE8ZfnE8hj8d+K+w4KaShr/f0FjaBXo
         JKY3ckL4moafuPzLwqj3n+5HCyxaEvb21JVDwU9oEKWDdeCPaLmHEDdXnQ0ZFyIgATsy
         RSow==
X-Forwarded-Encrypted: i=1; AFNElJ9x5/cLt0r8zsXUeXMrGAU5Gr4DZnVWNoXuO9QiJ4nRgsEzTi6TtjRKLkDu9qF+7IhJKIIcZsDsu8Go2Bk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFS4UOhvimWw6OMdVtXJ5oMcnQa0uvTTHzeqTJcskX3P+83ubB
	/SmKHO5nTBt4Tmd9osejeugOomyx/B4L+BCGHgwiSrdihGCtV/rdVir9
X-Gm-Gg: Acq92OEOZtZZUzvdHDgtiPGt4qsOH5CdIwLweWDILOB3l0O2Otrjmi1USUGvMzQEIHi
	3fn1w9M/oeWTUqKJWkz+ypTzmym9oPaEn5W/+6k1O3nPCkJurFiyMnMEbAxI4bLXO9jIsbGY3u5
	4LE9EXjYNyQHySjmfrdyukZziI4kgdtjEftK3uiz7mBO4SbveIFGRpXsi5DGWgqFfiPzBN9j58Q
	M8ZWxB6BagffHh9AlYQoIrR7nXxxly/O/hvP/90OqZeTXDr9ACJ3B2M9lNVDj1pW+vUbknPHQMG
	JursFjxdE8RrPo5ppXnWjUVL7xaQ+IttdjoCp/zOrWR131b6AfW6U9vBV03zqFeiF2qsYqd06PG
	d/5FVZvCvZdwOnQHOzpyf/3G7k1GjP9MvaS7FR5V13EFtHfea9EeTF5MItXUvXGa+d+wkC1LAJ0
	WOsZZqoSC4HE94bdbzq2kU+65/dADto9rjJSLFPOPUeD1lo1gVHsK2M1u8JxkavvpVsS2MAjeo3
	gjSrsr2f1o0Qb9XyCO/jx2hAS/POYu5NCbE5O4/h+9/aw==
X-Received: by 2002:a05:6a20:9f8c:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3b53bccd5c1mr6114388637.19.1781043609267;
        Tue, 09 Jun 2026 15:20:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:07 -0700 (PDT)
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
Subject: [PATCHv3 12/15] dmaengine: fsldma: use devm for of_iomap()
Date: Tue,  9 Jun 2026 15:19:23 -0700
Message-ID: <20260609221926.35538-13-rosenp@gmail.com>
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

Replace of_iomap() with devm_of_iomap() for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0df09789187d..a3792864f02a 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1111,7 +1111,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 {
 	struct fsldma_chan *chan;
 	struct resource res;
-	int err;
 
 	/* alloc channel */
 	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
@@ -1119,17 +1118,14 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		return -ENOMEM;
 
 	/* ioremap registers for use */
-	chan->regs = of_iomap(node, 0);
-	if (!chan->regs) {
-		dev_err(fdev->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free_chan;
-	}
+	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
+	if (IS_ERR(chan->regs))
+		return dev_err_probe(fdev->dev, PTR_ERR(chan->regs), "unable to ioremap registers\n");
 
-	err = of_address_to_resource(node, 0, &res);
+	int err = of_address_to_resource(node, 0, &res);
 	if (err) {
 		dev_err(fdev->dev, "unable to find 'reg' property\n");
-		goto out_iounmap_regs;
+		return err;
 	}
 
 	chan->feature = feature;
@@ -1148,8 +1144,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		   ((res.start - 0x200) & 0xfff) >> 7;
 	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
-		err = -EINVAL;
-		goto out_iounmap_regs;
+		return -EINVAL;
 	}
 
 	fdev->chan[chan->id] = chan;
@@ -1195,10 +1190,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
-
-out_iounmap_regs:
-	iounmap(chan->regs);
-	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
@@ -1209,7 +1200,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
-	iounmap(chan->regs);
 }
 
 static void fsldma_device_release(struct dma_device *dma_dev);
-- 
2.54.0


