Return-Path: <linuxppc-dev+bounces-22452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCDFCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJT3r2Sz3bv8;
	Thu, 11 Jun 2026 13:53:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149993;
	cv=none; b=ZapbA7EzmZ9+/c8XaDICf5BNfIRbbnLGH7uLxTH5afQk/S4OI0QAt6mlsmjVQqm4nJxo+DS+3jOv8c/0xKQAmeJaTIL5FmgxjIQ6OUylPI3oMeGZhUiu2FoERJiBCRq69e6IPSZLH7XSxuBS2ycB9lJl3oo//E/L/DJ+n5Han3t0ZR4y6KD48SMyhy+YagRZ1HfPdpK1PHqwxIDuEYDH/xdZhM9MgrCWiFEKptPZWfO/3sWkIgimcz11paLugunR9eSwtHPQGSar0J5qB1kilvdu/Yp/rmUI2REsMU/OgueAxeBVG9oiqG+Lc9wUSfsLS6c8zn4Pq31ApwrOthKMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149993; c=relaxed/relaxed;
	bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaL+aCHG3p42cihzqW/QJoeXNGeoFSTne2ighc8jLq5KH8t12ogMjFWG4XR/4OsHDKV7IXCILN35fEYK1AYWnyGAEJ80HIFLVg/ACKx59AQcgf0AedLPyt8hY1x4HtxUsF6WRj4lJkWvdtFcTjHZ9NK7hD6n7gAx9ItRWFiaFH1iPnDmJgeQOxqix0IgnO9ccDjMTb0R0dMoT3C2SMrgnJgmcLOtRYVUxouvcNCj239rfMor7x2VYJhjHNiVjiq/YyzMeKg4ocAPFo2+oNvjDlLlF+zk8ZfLy2UQDU0ouv+T1HQzdSYhPsRWstQ4v6TIYBQ7pRn4ttwk2nAdAK41eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LYs8FLAK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LYs8FLAK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJS6pXqz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:12 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-36b900f350fso6465625a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149991; x=1781754791; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=LYs8FLAKnmHRABVx553i07rKrhG6trNC0jh5Bj7H8x9lfL60FDJEj9mMQG1mpUCEeI
         f7Wp7qsPORr21pQPKA67VBdLD1QK4O9AWFgbhMmitt07svGemmT6ggfbdkslWIcJqZfB
         l9eZQ2uX5ypV71Q+2qipn8PL3Lfz5uHESA4Jk8JQ2eU53Ff9X7In4Lz74m+VMJ26JjFb
         Qs05MVGZdfPiAgYK9klmjn2BpS6yZHT1zTNNzPx43YSg8YWVqoRESHGOGKAH2izMJuhD
         vsFUqd6AoiPGxo+pZYW9Kz6xgd6g5bf6EzZh4TkACMzTwZl0sFxxDXrB3cBo5Ox4tNST
         mEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149991; x=1781754791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Axf2i08FEMNQcDQLuzX7KUZnp7l0NF95o4nFAH7q5yc=;
        b=PZOcbdMZ43Q4y+js63tXFfGcZssDziMK9TIHTmWvCrDSc7HyW2MxTcAOhWBBAWCCQZ
         QKyvSXQnjBWRC0cGl+bPUdYqkkbny6mY0JkAti2meS+0TaQgyBbvG8qJGLhL+H6gmyQJ
         vE85eVbXXvEfK9U+JVb/3WVxcILaTBDpTcGyvfRv7aaLDpLIrdoBs+zBmX64hB4wirAN
         YuOyDFvrXjGX4Q9EKR7MTRwSy+uso6EPd66TDE3IRHBp9cCAQmbUCGS45JVB+rKrK7aO
         CeF0oojCaVGKkEl/YsXbSMVU4Y8yIeBk0hOEpKKwOoF5wCncRMBtbwnshnYP8iOsPhis
         IBKw==
X-Forwarded-Encrypted: i=1; AFNElJ81HthEc3777Ii0LfRq+wB9x2GfL3kBS6jgi+wSlkZBe64AihWhXDpgCLGc91HzCrMdIcNIUJ5F0aGo7/c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxq6fMiY3UOaQLiFWV85MXtNQbjP058KgcOTADNpjwog5jDEO9U
	fYWg3109EfY61X4pRlSisecxl9J5gDK+wId7XTVCaw/r9BOuJRii52kn
X-Gm-Gg: Acq92OEwkn49uo1ljWFSjizJtfmP71SyJilgaxEkIJJU1g+I720FioAvc0GXrtI6Tuw
	KSzGe9cGmiAabhEdU/uZIDmJBv5MDRzsDkt+7Z6EhPf2OcXAHxdXC3KviLLEk/nmID2RQKEDaHH
	u+rkMlAOnfyV9KrlqCq9kPgt8seFnwJJ+VBZUqiZmfeBR3asNRjDEasnwBFU04j5mk4pssdrX9R
	AKb5WKAt4ft57MrQrIc2n5xnWP+9QerfLpL2J/hLVOrG1R7iHb8OqXmknLF4KcCRRJlwTRlyyQs
	EZ1OOSgfajsvnXTnZd99Lfcxq0Ka97OBFgwjM3vAqFRXkmn45srbCG0N2rJM3aD2sbTb/aL3sPy
	PIhTxf8PY58Sz/l2xzUqAL28tTEsKavLHmfxIZlsK/Vs3yhC6ngn+UIKO4MGGkmLigSLiDSc/+r
	TdyGibuv56YfCP1YmUYTJasxw0r53c6mahOUMZRaoFjNprs6cfLmNvp6kNzFaBR6wjCKGBQcb/i
	W3mw+glZo3m5eUw+0vvgmtRAhgVA1p3Oi0ERZJfq5GXYA==
X-Received: by 2002:a17:90b:2dc8:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-377aa799f69mr1529495a91.22.1781149991227;
        Wed, 10 Jun 2026 20:53:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:10 -0700 (PDT)
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
Subject: [PATCHv4 05/15] dmaengine: fsldma: check dma_async_device_register() return value
Date: Wed, 10 Jun 2026 20:52:35 -0700
Message-ID: <20260611035245.13439-6-rosenp@gmail.com>
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


