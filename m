Return-Path: <linuxppc-dev+bounces-22357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9529ECD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyN0Lq2z2xk7;
	Wed, 10 Jun 2026 08:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043595;
	cv=none; b=YETYfXvHEMqHEGbUlv3I2Nz3OTMTRLGHgF2Q/L98gVkJI8Vlt6Ulz6zHShyEJOqm9MYcXscQw+pbfAIkFwyK6/G2U1SXV7TpIVwOM3O/XWdeGM4VG9w4pbrQYISbG4pOigmV6ZInmadBEVlTgkwsB7kIBHwzB+YdXDi4fmChFTE07ifQr74NVSvbH+D0CFB6jSyTSfKGGXvxVqcdfsA6OZOaQ7bCQ2JXOudIJBevw1gapoo+9uoFzh4DUKc/CX+jY2D1ozZTi2517OEmD99x/6qJJXwAFMhmrUV7i76tLsOipwNCl9QQmwrjb6Bzs6E4lH6cYR2JNgH9ODnZpNSOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043595; c=relaxed/relaxed;
	bh=tNx4Xy1KooduVSVGOlll8hTxHBnljmtg7WB5wHO3xtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWtfIg5Uy3MeT1eYL3qZhLytEC4O+AhBo5OtMH3cpTcgXiRBYPD2Es6nVyAaPDzWkMS9UXhJVoCwYDchL3Cr5J4o59SezNvleGS9UnArIGkOpka0GY8Abo+yE4lkV56/mCgjEJjf7TAtUqhBZlgqMncDQJ554/LPtQIDiLRZr/+SfCpAjH8J7//IjWBkzM9F6vRYUHFDrTKindILrpJDj3mg+eVIVCGu1GeUBGsVroslXi7Jey6BeKULevx/7zoFlT0ynMh0kPPkbZfHa1z4pf8jTHDV0wZ1kI7yi8krFVGSkRjf23sHYYTiqHm23gVqpsJqGnqF+oTBkmTlqghYjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MWbOzKQF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MWbOzKQF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyM2ngWz3bsQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:55 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c85893bce34so2420385a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043593; x=1781648393; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNx4Xy1KooduVSVGOlll8hTxHBnljmtg7WB5wHO3xtI=;
        b=MWbOzKQFoVGjQABi86JbFYt1j2oMvBvffJfOyK09I5TlL9J7vGvL3yVOlcOL+MzI59
         +NGJQWDyQDaQtvWVTxwCg0ilJA8PxKjRSQmZw2IHpPFO/haGJkf9oVFlAczLZWeNltDQ
         /8hrH7mOwc/Yokzg7QjuymzjwHdyKcTFaaWYRHIisqia/RfGh/nabmIBIoFwuSuwdYeK
         bxa7jYF3dKdDg3D4oa8xg3Q7uLkgubfGplrFwAdtBDXLofyMKpBE3/qrGa0kN2PuTuMA
         OpVRDd7thlytrpSsu+/+C+LDKIpuFFhdAiw/m0JRi26E6NRvRqjLCXPi77+BYvu0Id8s
         JuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043593; x=1781648393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNx4Xy1KooduVSVGOlll8hTxHBnljmtg7WB5wHO3xtI=;
        b=Cmz33rfTiLaPhsaQYnCd0RrynGImogQ90CrjwV0+880YB92fT7g2riPKQNxdXsSl1S
         Zf+teQP+sYuofqJuAU9332tK1i1AfEwqAlkaBw4BnajNKOtZEX4e9hElfl1a6gCw1NB1
         BDkbvwpayrCBOcysLgEaMmnaQPE5T4qSEIR9bQITAjzwTgfZcI3+esJvLzeuVgVlCK+I
         8ys6P04VN2poJ1OH7fA2xGZFN4yJbcxKFj4Tvtc0KGY/WdFuJU/q3F7FZFs0SNP1fhbS
         M62cBMqlUqpzhKt+26q2YKFusdr7oM6QoBKQXIobiAn0S0LprNrvYu+afQlGzoCrV6Gx
         4GJg==
X-Forwarded-Encrypted: i=1; AFNElJ85MJRrQnvjA3MH1TFgNS8YzgTmshZmFSCFwVWVoc2GeyZkh/WZfMPnRP7BHQcVgKj/hRf+Y+KNrww6n2U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YybWaSLAe1mV18B6UM8iiFSJRqR4aJNTwqSVhQ346mb01HpgWr/
	1juR8sFnKJNUirMd1VpuoaW4Ug3S9tJJafTdB5IFrvKXSbogezzxBoEV
X-Gm-Gg: Acq92OGDsKZ/xmvVZhivk4Cx6Z6+XKx7TdawPJl3Ivg19LaiYCp2nDE2TmlXjYfYEoj
	iQLmV5MEBa3gY9PeIqvQpgwDZmPR6GG/49d6JOPaDd0UnulSbvhagGvKpeEaqMkmGX43olOVWaR
	SRFZ02w/iey0f6m8RxvljYwljXwj2JQGfuYjtmCnMB7Yjh0h1nT9An16G+mBuRdI/3ASTMdx3ln
	ftkOJkUoQAfjVOpgU98FWsG9sq6um0KJ+73R3/TN03n195moj7y9YS9kVZ5H84NOhPDYdX7OaID
	Tt5hHx5u4ZbfhZLb5f4+GcCOECX3g3bcsFcRutN/BnsCniynWs7gWJv6iQ40AF2djeFifhPdT1j
	km14F+mEw1Pj8WebtyYutenhIJ7X+YNO2A5V+Fx5MWnt0Gzm/zFTWC4vRRzXEZ83267I4QBgITC
	paZpo7DcNGp+RgK2OznOl2gJqDE2CTFEvFZyRc4ecZcFuPSB2N4ZHfvkg3GxFPYUAO33DNmYt+s
	F/Snllb8V7ED5NO7D3cNJ1FrtCWeBGDkHFBMePTaFttlg==
X-Received: by 2002:a05:6a21:6113:b0:3b3:65c4:c680 with SMTP id adf61e73a8af0-3b4ccf7f2b8mr29078053637.25.1781043593166;
        Tue, 09 Jun 2026 15:19:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:52 -0700 (PDT)
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
Subject: [PATCHv3 03/15] dmaengine: fsldma: halt DMA engine before freeing resources
Date: Tue,  9 Jun 2026 15:19:14 -0700
Message-ID: <20260609221926.35538-4-rosenp@gmail.com>
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

When a channel is released (fsl_dma_free_chan_resources) or the driver is
unbound (fsl_dma_chan_remove), the descriptor pool and channel resources
are freed without stopping the DMA hardware first.  An active transfer
could continue executing in the background, fetching descriptors or
writing data to physical memory pages that have already been freed.

Fix by calling dma_halt() in both paths before cleaning up, matching
the pattern already used in fsl_dma_device_terminate_all().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 455d21d738de..1ba10d065278 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -748,6 +748,7 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 
 	chan_dbg(chan, "free all channel resources\n");
 	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
 	fsldma_cleanup_descriptors(chan);
 	fsldma_free_desc_list(chan, &chan->ld_pending);
 	fsldma_free_desc_list(chan, &chan->ld_running);
@@ -1207,6 +1208,10 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
+	spin_unlock_bh(&chan->desc_lock);
+
 	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
-- 
2.54.0


