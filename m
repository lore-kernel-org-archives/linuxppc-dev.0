Return-Path: <linuxppc-dev+bounces-22448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D0CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJN1hgMz3bpt;
	Thu, 11 Jun 2026 13:53:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149988;
	cv=none; b=eGLJ/KhQ8nNga4/X5gKBsfEXjYDIHPTUiq7B/L/jTA8HLmgg5et5fBdBkxwiQUx/rUtIXuEJHVjS805QWzUzwTGVSMvmTNJ59gI7ysw+L6vJ6brCNHE8DpDayAzOngLgrcF23AsIWdAAcI6jIvmHFyd57XQQ2wiKvV0ccP5lFLukiG7IqdueeU9FnBJxBmHjBO3Ul06eUZML0sJRobpzlVFjBe3kPyqPZLn79u9hLqCbIxrv1M3OHHUnXBmyOim40QpMvALq6svyDr3nYARV296OIQ0b1PMQmuHIR9DWviQXPCnG59YbQpaAQmr3b1Hq4ofFBFQFUxYjR/gqOxZqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149988; c=relaxed/relaxed;
	bh=kn+zKrxqRiv/1m18H+iH3XPWY8WSKvkkOnHkQbRgV6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR9w6iJYRzyMrfiAX7yPCS3nxAwDS7CzVpnIjzj0dkkbNn/S/bM42Gl3UyR0UcGv7+sxV4eVB10TSI0knInNna5Anub9v3aSSeDA9Twp/aMLh7iH2odq9Y5Rwwi2qtyQ/tX+VjOwnP3MeTI0cvoAYfkVAvUzszX5248ee6C37YN67gW8RQb3S4kWNYiflItpp8kMHHNimT9V1RZQVaD6mvPg38XjytdCB4wGtkonsfq5B44W/oh+AQ6MRtUiYBp25mU/rbrYPwLrdnxxbVZynTtcRjYxQEXR3KteqMUaFcEM4EqT/jbi61o2O2paP7oeeEusXhX7Q+ZF7/bR0WyP8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GI1Dd803; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GI1Dd803;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJM2DN0z2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:07 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-36b9d265355so4594454a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149985; x=1781754785; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn+zKrxqRiv/1m18H+iH3XPWY8WSKvkkOnHkQbRgV6Y=;
        b=GI1Dd803LZlcEyZz7d5TC7JZ//Sl4D3haIz3qWmfkWx/9xyd6MOZjRoNHeNELqb3sQ
         ve7urWXs2irhS1CDRujmBKaV9PxcH11JWi5zixQl4kVRGOj0ruTJFZg+Ckf5YeN9hdyS
         UCg1sdicUBSTiWUvIjuP0IOjCGBngUt7zSdu9MgOPOLCyd2XBkidvEqHOxuIJJ8EcUTf
         lLPeMzGX64h7zP3cvYOpee4q65+QZtC4T2MHYU2tndgHSL+g3dOQG3hwN/EUKg+5yg+c
         vI5aN+xc++OUs50W10cSI9XLe5gZs/lzwxbOHwfQROynC3CewEozw1A/Gy+f6TfCp8zI
         jeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149985; x=1781754785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kn+zKrxqRiv/1m18H+iH3XPWY8WSKvkkOnHkQbRgV6Y=;
        b=rHWnNsNyi7jdo95A6YyXGQ8X+Y4bLwBkoHh+f/A54CNySWqG2jQEd+WZcvK2HelPzM
         8+/SDTJ7M1HFUse9ER2MRW4fRMUSF668CwokeCSnec+r3ZEu7PhAjL79castcvJGkPYT
         dKZfPQDjESFQVbVcaA0X7ZEO4JEB6RJJokPQBAcEJo+pL/IOi6ZQ1j8yVEITgMnXkvxf
         WnIGkxFGBNMQlWwT3oJsJLQAyEAV1EAt+0l4gmupM4tBlHAQS97cDbBPX5fDptFOfo9Q
         ZkrjvuHg54Aj/cW8uoY4SXkrJ3naY1cU3guxuPoCGsU3g+gupCXHt1QhendH7KDUooE8
         f9yA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qm58SfZFdYtcYoMljST/RI1fGIJrE9jpie1V2oMK+LHOaGd+GGTDpWnXCFkQX9Tz11i6djdOmg2vHpzo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJxjP0jlSJ/Dd7UB7XeeJKmY1YLeyDvmQ5RUyX7v23M/sO4+nW
	UAXBsb5dvdD4SkMNXihKTeVQFknvReggGMOtZ59axufhMXIJcAQuBMsn
X-Gm-Gg: Acq92OEkZEzHcepY9dY3LLbnOomOBkGGjA8h9Z85sUZY83XnNOpGwa6AoigcBZ2ktk/
	6g1BOQo/AKjSwLGfMb2DGVFeJXeOV8DMylhqFUXQwxKS+gnw8NeH4q9DXWq7VT2CjZi95xjo9Hs
	ENnE1S2hi7iWNd0uwHmNrv+mEGwH+vasBEzVJKmJpoE8ue/sxp3ov+J3IPViOGaCYa+s+pc5C9a
	5ekiu+VmPuHmHWhqIjLVh/DUjqrdfXy2zqMhK+efSrDej7tFQCJXTe2alup74zKAvTV33rZFKSk
	rvP8g8cs9FuPCHBMxgoQ7G2V4Rs0U4zaVR50YuW55CvgrVZiEzNjiceZvoa8bDvDHJCeAUDkpQK
	EjV847kn28s/FyZ1gj5iWpuRc6lFwALxoVyzWqBItIB77nxTw/d7DQa3Li9xAZowlZqyD+GQano
	1NoGvceoCkTX6UCXi9epTCVHpYQA8ak1FRQOtlWilLEDtHg5edkqtQjHCaxOg7Kk6gcyqAO5kfa
	brhtsMni2sulFO9ZM4XBvv4gTYDLVtJpMZt8hSvFKA3kg==
X-Received: by 2002:a17:90b:5867:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-3779d2d7c32mr1202152a91.6.1781149985147;
        Wed, 10 Jun 2026 20:53:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:04 -0700 (PDT)
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
Subject: [PATCHv4 01/15] dmaengine: fsldma: kill tasklet before removing channel
Date: Wed, 10 Jun 2026 20:52:31 -0700
Message-ID: <20260611035245.13439-2-rosenp@gmail.com>
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

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..0e2f84862261 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.54.0


