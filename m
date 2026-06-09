Return-Path: <linuxppc-dev+bounces-22365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D259DCD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyc6Xvrz3c2v;
	Wed, 10 Jun 2026 08:20:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043608;
	cv=none; b=SQd3DWmcdbgDUNRvTBhBisw8LeQolGvv4hOsiAT4E3OVFUBGSGfA5ZGYqDBo0vbFiDrBrthe+1VAff7Im7VRSUIATixvgALDJ0877VgKOdSj2z9MKLTI4Lvwo/e7e8rf7tPeycNu9G5CoxywT2tpJ5O6KcGFZXyRuKbr/ilySQnsWmwFkoX6Nnh6m1h9erSEj7S+j7Aa4HZ/AkVMPsypz1vaCTuGzBl/Gd8kXCuDx43QLjFbD/c5mTS5+fndGOGFUSeQUHqFbMkvnlHbsLpSqCalN5sF+NFZicPh0vBeiSIDN2fd/1KZwReGjzrOtQS3NRvaqdAbFDeha3Eyo0THKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043608; c=relaxed/relaxed;
	bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/2W7T2vHLR7L70Xe08GRXKuRDWVPy6/362xFaMGID5BnqGB4FwNuX+9r4x4sySHQWJgls1ECSD5Oqfb0zzXDU0+/NsvkL0xuLpd6t6QJ32+DxtOcA0Mc7RvqY/+aOzXlHWVPejbGbIlxOSS3KO6QHGvkc7gGmZEVdlBewloCSuCo8zUxyJFd+43OT5ytlLymP1+rE0EPyg8y5LSC6x5EGyF62jrfXGkOAZO9n4jAWg2SliVLNtt2vD9pg9zgIKlfTeFoF4NqIS5qdC/xOpYIV5/MJugGuCA2i0oo4f1dBOQGZzmLcWn8Idk03QM1IaZpg58nnHSJL17EHI+AO7UBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oNXFf+eG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oNXFf+eG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyc13zdz3c54
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:07 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c85b2139015so2083278a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043606; x=1781648406; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
        b=oNXFf+eGZpusiDLsfSnsqqm/O91BUV9F8qFPdLijEC3AQw59KPLyVdeKyaRhs/kqt1
         5iPNznoqH2VKEaZa0oCSjLjRorOoNPVvBTYDdliKONcomXQ468p1dg6Nzx7Dc5NDY/JK
         7aY5JaKnnMIOU8yiz1RLCjQpzia5D1PCyVymAd9QDHkMeLZtKFowEo2X+2voQ2TRgZCK
         sDAUrlJgPpTOFlCMyY2GNX4WhVL/mMG7CxUbJ7NHWLgmJK1+7abFSsCljhLvQYEAU84i
         wng0owgGKrLRH9ydl+nu/HiYMF+nwy74Gh7zv4+l5Le86EZChM/0+jTfqd9i1Vj0Fkzj
         h/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043606; x=1781648406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh/mpsi9dKYVr7XXt/nowqZiSrF2hHl6kTiAGF+2p2s=;
        b=IHGtdGDWHgcYW6WOOR3dgvIVu8ND0Gt/cRjQ+o24aBO4aANVi/+epTYsi61z4B3NfE
         3zmhiZR+kh9COZKqTw6kl5l98dPFgcaIo2nnZcIpikL9GQZQ2Vd67XYjACR5Sop3oymR
         C3SnbB7RMJd4jkUTvdUV96vGz8sm1BI9hDzOzJdDhWiY0tzPS1Ap+aeI+b+uC5x1m6VX
         YpI/NCAHp1PS+yB/nYhUn1Ekv4a19wCplGdVvnS4XCjnLFON6XBgm31Uc7HiUktg6bRg
         CzhClGu+Fec/G3lm8gMU3xXMrsOzT67X0JEu1h6Sr6LxZHbK58PwPJJIdfQvVWO+kqhv
         syFA==
X-Forwarded-Encrypted: i=1; AFNElJ8bhyV0/PT5iwUjX2a7b5XAkZ1ixI5uMihaARLZOdIvYbwP9aZ31eRbY8p9hRByFf1FVIpAUIZhN4VIvTE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzesy2WNbQJQE0Ze9BqYPrmtpxLYTjsJxKoz7Mn1w0fTb0PZe67
	fRH581ZkMvOcZtGS7Szwswt3eoXQsLow2HkScIayGzuBJyw8lsRgKbUW
X-Gm-Gg: Acq92OGSKHkBlkUuBlqlv68OvPklkYz6J5TNzDI2kzFX0gQbcG04GmVE5uX5V3pRNYu
	UOZbvSzClr74HDzSqgwxGU0LMXhffXbw8GZb07nNPPi37iMWWQrK6w5LFENXfTl2BoQ4f0snrqJ
	MrN8LTTrScsJHW1BooLqJquNsWrmzx8u5LD9ZwSgggF+SLgCNEp76PDeHnBFR82nIabH2dpCgu5
	9EY9ti3cOH4Gu990m1AYv7xm+qGP1n+Ta/AeU6gs7os4qfEQqCSYVgb4vAU3LgfVN6bTkdeVu3j
	tpbrOmb107jld+Jn4Tdqd8kqZYDsobGyoQNwqiu7DMbp+zj1HJGWPpt4CO6U5UH9+l8P6dJoA4T
	Sl61LWTZMU5x3X039i6vXgxQRS70qTtcJKoiW7Y+vdxItiI5jNcaDT8Yq5hKTiP5pQb4rPKF7dr
	3HsV998OxSM7aovYNy10zJg7I2XFMv8mnvYpts+xV604xxDoGmod5HKHgGowzTDZ41XvgX59u/+
	/XZ6JeU7DOS+ZXZ9wb0FbuzKxdVXSq3m/Z6u+A9E5y7fw==
X-Received: by 2002:a05:6a21:350f:b0:398:9379:d04d with SMTP id adf61e73a8af0-3b53be59e67mr4919030637.24.1781043606091;
        Tue, 09 Jun 2026 15:20:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:05 -0700 (PDT)
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
Subject: [PATCHv3 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
Date: Tue,  9 Jun 2026 15:19:22 -0700
Message-ID: <20260609221926.35538-12-rosenp@gmail.com>
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


