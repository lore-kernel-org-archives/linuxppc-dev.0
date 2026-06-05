Return-Path: <linuxppc-dev+bounces-22133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B896CD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlW360yz3bps;
	Sat, 06 Jun 2026 08:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696919;
	cv=none; b=nEa+R9K+b3BGpNtj0wnhC6c4rN/I4Ekf4CFsmmBUFnpd3rCkbIfiXPDzh0uGCO9TxRoyaOl91f2pAyMxUNRJ5gZoxr/zfH4mpkhmYq/C32vcJgrxYXk8xVvmueGt8eEAcDPrCx9QY6nKdyWWAmgsCG3MYEkBDbYTHUm3VOCeHLgvDvZRNuv0IpaUr37qvBmxHrOJOUZyFeiCz6Q0pJb/VvCFEbvLpEhNfBAcXG79nT2OfxCl7BMUn3YiBK7Ul0yafrwzc7wi+U2kC31bg9ERGtIN78KMxPK9uoL+2xrG5eBwOc/YvR4R9uNNoI/zgkM03jZb7fYbst2kIUTfx+Dkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696919; c=relaxed/relaxed;
	bh=+5mTbmbGFqfQuWANwj/hsm3FmxeOXZxoynp4ibqSmkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FweXuCjpKPrqXzqbTrwd1ctntenQ6PBAST0a7dH5ByOKC7qk4+QzJ7hPgxMHZhmuii1hIiW8T2FEK0V1nRYdzrZm9LSVyHi9392tfHtl+UX+7xRmDzAw5ysth9LKrKlTZr+dsUbhbAwgSTeLi3MjXGn87Tb65a4KqNycGJi7AuISl5lAk10jN6fG6UWnuM8e2riG+ZeBy+2uVjJrrNDV3jc8zMvK+DAH0rCEEYnc0eYICtpCUCCUeHTw20tgLnWaow3Ks40vSRHLx6qLhk2rwx7g5/AofVcTtK2KROiwih4Kw0qTEGI3TS3N0B2Km6lwg+SppvgvSAYa+Gr9ccQCRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SlFzF/ZE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SlFzF/ZE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlV45DGz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:01:58 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8422524cb38so827284b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696916; x=1781301716; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5mTbmbGFqfQuWANwj/hsm3FmxeOXZxoynp4ibqSmkc=;
        b=SlFzF/ZE1hQxh5d2SdZVPvtv6wf83GM7HI7l/4WpHuIWYsU4pVZ3OWqjtMvusymtol
         4mM5JFXL/u4GkJs/aErliCEuZhrwr2GrFk4PbtV78EXt12KK7rN2qXfbKeAc/Li0MuiZ
         calykDLe/SC0kdwYgH63qEOQeDiUWGaf3caU1/fz+Em/c2vPpznQkasEKVNc+0cnYIoz
         XgZYn4vw7HBsQQJ0/0kTsNlNNdsBBE/8fIHXOtYlzoWGDB8Wnht7EuWuOyhb688kvNH3
         uWPVwFWR/XtJkk+5XqZshFxHjqCAoFJ1Nul4rjl351CQCoIra3vWjjN5ehp/6OkoW3nn
         nQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696916; x=1781301716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5mTbmbGFqfQuWANwj/hsm3FmxeOXZxoynp4ibqSmkc=;
        b=NSFOkVLGDKwa8jwZ+48guicUGM5KbMe814SCa4ywsnQmTOdpzTTpHj2yU21ud91K8m
         gxg4UaP+/Y6pCicEj8i/mcCuQqvZmtgY6Qv3966FXDaPhtzrRsZLqtrSzDKWSaubrgMQ
         YALxI+SpmQ4Vndw/S+/MVGYCSW9FBtc9sIq9fPaKnpFp0trkwVje3MYGjBC0t/90uDik
         gnGo3t148xupsmYsyosHlK8dUBhRKW8hAuzHJT3+SLzGpIZCdGLYDguS8A4e+/ZVDJnU
         +hZB2FEIHQLbZKsq2rWu6ZUKOQVCtTJsfbwWPENtPPiZs1lJH2hI8KI6p1LF9y2uv2sh
         Aq3A==
X-Forwarded-Encrypted: i=1; AFNElJ9QM+dRiJWBgDRHqOgyEEEBqWRw0bT9KNZqGHrcOtzDl1NSFUOaKxhqQfH3nq3LEBvWpu9rbx6/WRUr8g4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7Tk8d/3jcwpNN/M6hnzhhCzJSG+aY2/FS0vQo+AEbrB2aXdBt
	V1XYZt7/eO16HfvM/qAp2qoQskmk8qFDrrALMin0iabKSdf1ApuwKFFU
X-Gm-Gg: Acq92OFa7Da9b2YZirhv3P3eOO03ePYQzcyrCWf5GnJx/XZpbhJSAczER/QAUqSfVsF
	REbQyX+E8XyyThnLKhFxpaV3+ogY8e4y7JP3GuPSn04LEbas/Jo9u4isIvjVJcpbYzXPpvKiojU
	g1vFi9TXCKLkpen08k6ACvEn2bFpZZhk5jW0ro5PE4jdPR+sWX/441aHt4msEqQNigHZNzdOIaU
	eOpAG3F9oTVjYI/nnfR05SndL2PQGozgCwHClP5Ue/HKOgbtoftmoUUj9AZ2LeqF6ex1PJGdbhW
	yyDzd5mLEbMtsXYOeqsoGf+KYOmzRqE4Oxd+W0NjcLwDpSLPLihDsQ5DOYnTdJ/V08AfYyukkv6
	VgHEJaUOJ3cRXc2lgBein2SBBmIqraoFBSF/1neE7qG7tb4DVB5a/IW/uTNdgTqRHgjP4mJnBr/
	BRgx0gIBooB6L0aga4Bagrg/8McMvvekPj++mNIWwiUcncQVQbIjJf+4xR0piFtC0Ol5kKB0agD
	EfhczLCgsln9tJE5CD2VjAvKvV+8uUGwolVVsTCzGyfs64jt7ya5xbt
X-Received: by 2002:a05:6a00:3692:b0:842:5da3:9b84 with SMTP id d2e1a72fcca58-842b0fb2843mr5346862b3a.34.1780696916252;
        Fri, 05 Jun 2026 15:01:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:55 -0700 (PDT)
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
Subject: [PATCH 02/10] dmaengine: fsldma: check dma_async_device_register() return value
Date: Fri,  5 Jun 2026 15:01:26 -0700
Message-ID: <20260605220134.43295-3-rosenp@gmail.com>
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

Check the return value of dma_async_device_register() in the probe
path and propagate errors instead of silently returning success.
Previously, a registration failure would cause a NULL pointer
dereference in list_del_rcu() during remove when
dma_async_device_unregister() tried to remove the device's
global_node from a list it was never added to.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0e2f84862261..89b88447be1b 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1293,7 +1293,11 @@ static int fsldma_of_probe(struct platform_device *op)
 		goto out_free_fdev;
 	}
 
-	dma_async_device_register(&fdev->common);
+	err = dma_async_device_register(&fdev->common);
+	if (err) {
+		dev_err(fdev->dev, "unable to register DMA device\n");
+		goto out_free_fdev;
+	}
 	return 0;
 
 out_free_fdev:
-- 
2.54.0


