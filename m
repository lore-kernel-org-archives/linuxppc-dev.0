Return-Path: <linuxppc-dev+bounces-22358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B01CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyQ56PGz3btY;
	Wed, 10 Jun 2026 08:19:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043598;
	cv=none; b=Djiyws1EbshSuoK98lwxGznexbfsSsbpRWoIfJG66eOqCeNYT6AGduemBxRq2dMwqNvA21x71DCAaGNeoykGwkz1vTWp5WkhouEBOH1Dj4oKh5C+d/lwCWtlgbjqKArJA44ZfzREqyRNmoAqYvQPuiz/qdAlm6FrNVCpLnOHLG1iZJ1m+uyR2CkNMXQIq7Q4Dz8k50eMm2SX0Kbm8Ufgn2Ic+VOZbYlDzSJydw0cstMVEQoWBWCZAZOPi/voJEP0FxL0qHgTDOqrB7vtC0oKM41J1WNrLI4kQWOCIfK0MPzPG1EoZJIyFYX3OC7k6vhtQGFcr2Zg7IVfSkonOyI85A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043598; c=relaxed/relaxed;
	bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f73MDHvYJlfg0maIqmczVpnOjnGm87ywPz7wvEx9FqeArWthqTq7zVsLMwCRzQ9BPcFgNfQNP5OZJySD/dp31XPZ7llONg1Kw48OLZmUw7O97hawX4xJiMGh5Ak3lUmoMYavV2QL8GdyJfZsuvQtsm3L6gnr89ShGgF4JwipkcYZKt+RUbLjize/Oab3fWEHh2bkPqaD41iUip4+T6QOX5hn3R/6oKKNvIJtSZDes1Fn87sEpWSULi6YJsjarQ4uT7E8u+HahLhZpUOaGcCqWkUv4ZMMYWGEj/IrM4kQjoBvB1CpAB1PaAHGe01A1eQrhmw333l3rzcfpWdD7OVfuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cHk0nLTe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cHk0nLTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyP6rJrz3bsQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:57 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c858961a8efso2283008a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043596; x=1781648396; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=cHk0nLTeJ1ICw4yWcHdJ5b28CMbPVwOxuvzIYly4G0/rltJvoEUo6l8NUyo2RTkyG4
         w6Cc3yOZEYo1ZI/KqsaLAjhxBkx+HkIXrrCZBcRoHQlkF0rbA8JTz8nmTToreLBhQtre
         jMo/vx26y7K/rEghjimZCs3F1MbG9CaOgG5oRBrYzC8RafL7pDIg/RLB/LhPwFoqiMEL
         nbUAQdWKzrwZlh0s6fCsY3Q8OdDRS/asM86WtwhWKGbQsYNW019ZbUC8hFuXLP50vsRF
         7EXgG8FAkBi2Gb8nr+NT9kB3TuVVCpU84JF34zig/bb+yUHfD3QpAkuYSNSFuE0QNqtx
         T5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043596; x=1781648396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=pcfPcsb/qkcQ30wghw5Mtkr+RnG5K+/hr8xogEaPOLRuId9OGJX2zL9z8GZHK0NC7b
         XVvCznW03hNwxYDpZvrV2mk2PJ9wXzo4tN1b50mmhJ+FlxjoLYPMcd9nOFP7/ZVIhaqG
         /eIoCgEvB1wHiWH7+AN+bDarjVuNvgXmdpnCbsqUiomc5iuhFlun7Pq3gbjbBWUd2G2i
         NB3qLFGbGZNjUwLO+QiiSkjObEvzfJiB7UzbgFPjRoaH4zCGUh5hyhDe9yJfXG843vu0
         0BMYyrxqpIeGsv2DFUeNp70KSdKV42Yu7BOHzs40xNAdKhjhXx0Hq2R/L6AReqR6eMRk
         3gVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hx9nTk7j95N9u6+bM55I8OaLkqnhdV4yy6HqNSbl0Tb8EuTA9xmxmhqy+wFn+02lF5I1hcjO2PVErPZA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxv6wkUcVfyp3wg//ziUTITgEno1lQrv1Y5Hol0gr8LLo9Ot/vW
	93eMbZuoEAWBgsOyeGcebw6eyQ943d/pmBRHzvi04Uag35V9RkuPnC+D
X-Gm-Gg: Acq92OEwGZlAGy8AIogTwZkIHCYkQbJIUZuSIrmY5oB1CY1MLaI8HdCFBdr7xzFcGp1
	EvOJm9tRISYRt6rzq8H6CpgsWt+V0iCY4p9hxALFCUASM4iYOvWONcv1kfLkxSkozHBtnBNCY5e
	DBRsBdkR54VuhKeuBfcqVxwyau30gnN9825ebcvuYysdsnAGKYnAsE3RTbLlHS5z/ZbriCeB0bN
	3qRE2ZlBI96gPqh3J8FBIVV3Ogfij/RLfWnVExSPZQzzmG60Q4Zbf3NWUhAAAx0nylHJfMAXG96
	FXDbgkdakM8li6yZdzXf+VVuONo5o7NziEPScVmhSE1k59FPNlVzFLw93TGAIvYf9TDRLn01jFi
	iLwKRMaKBVQsOMKFG7y455ImvWEw5aH8PoaAMlERhNAUZyaaQG4P9ugS3HRRwb8Tb2xutgpu+gs
	0pdzAWuc+zWDNEPgrPqn8rbYcajcjngrpiHrVT26qSU2JyX/TZiMgKHWGVePCf69jVQRNzoLIYj
	PvX21bi4IFwiZJkzzXvdvmY6sk8+jbTperii9WmlgsfYQ==
X-Received: by 2002:a05:6a21:7a82:b0:3b4:85db:1bea with SMTP id adf61e73a8af0-3b4ccd1b486mr26738313637.5.1781043596210;
        Tue, 09 Jun 2026 15:19:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:55 -0700 (PDT)
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
Subject: [PATCHv3 05/15] dmaengine: fsldma: check dma_async_device_register() return value
Date: Tue,  9 Jun 2026 15:19:16 -0700
Message-ID: <20260609221926.35538-6-rosenp@gmail.com>
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
index 43d817f6ded1..3009e1531292 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1303,7 +1303,11 @@ static int fsldma_of_probe(struct platform_device *op)
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


