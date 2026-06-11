Return-Path: <linuxppc-dev+bounces-22454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E0CCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJW1Sy3z3btk;
	Thu, 11 Jun 2026 13:53:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149995;
	cv=none; b=NnV1hWKMctYOlU4t/Qe1+gr40B+HX9n9GKJ0T8whGxq/5iaZGvYWosnDhX6PBgShVushE/Ot+Cjxq9SFtJVn15cycZr2B/Zy4BV9nh3zaCnT2EqLsQEVvyGDi1jkXWyNWyBEKr44ksHBRpgDBOfH2q0SbjpwP4wgQGej6PWZLOsAQcVWgoSHefvsbd9/AAi5+1k312LDQ8JE4hiplrgRITTwGh+WsEnjEJHAht3Maft+Y+6e/3AuwjusGNJMfQ/YjqUmfB6H+UM8thUWAqwlxNMyhoTIJxc6awtx3BHcF2ttDcdmhaJs278nEkli40ALQ3zmd+YpYUbZmf451zoKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149995; c=relaxed/relaxed;
	bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+tijfIstcoyrRtli/yQOqmgxCdF2BNkgOqcLVWLxIYUXtmlXJu+snigJ/dVSZc50JlFRzBIsm+TOXaF1FHvZ5uhuyDahXW6PBeeXwmXi6a5ylW6a6OSxcH1qCdr3EL11M328X2hXchCJ5AxmZQ5/x8HH3q9csUVizHAwXAecI68HCkrF45IodWYdDlVXFSl9l78kp2AS/cX9DGH4fuz9uyGeiyHKJLJSaXyC7VU9E5zeAI1XhTv8B0YVVj0RuX9G8i+AGYmV60Snq1NgnHXfBVQDhLs8kLRiwpziTDAtrciiNPWAimxcEQcfCnYTIz1+I7WcQfc/s1p6DwGla5MAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDXm9p/p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDXm9p/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJV4G7Lz3bxM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:14 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso5156673a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149992; x=1781754792; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=BDXm9p/pwvrU9UuitF4oBDJ/5fF3EsZmAUYxq4i9L1Uq6Bjxv+hWdr+DeIh6/ffIt+
         0sIJqBhkGwdtCt8PufYoJqedHsxPgIe5P8sTmoiVdoEStyIN44akx627v6ciquL2a9rM
         3aCFgIHYJJtg3gD8EIfw5Wr9LMMDQQWFgHSBAEDtqCYEWOKhRf47zavEMJTY6/rQiHH1
         ov5ybKhFkVwo8Q05/ds6DvFsuafAGzayYrGgw0VA7j9WVhAaOCeV4WmZPcN5q/Ao2gVt
         JLuHSlGsYBLOZFmH1hKvuKOAnpWi4CbiiwWI1C8Ncabob5XiQv+gwSnpiP799b2XvOde
         RrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149992; x=1781754792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=lFN+rxUB89+JjYewyPLPWFckw8PRqSf9xsr9lTX6NW2f6tmkiG4jwcKTDBnM0t3Ds6
         uGWLzgU49QR6vz3u85eJkvVkYvZToPCVRi8dxqRNSpPe9CmbPU+xD1+hCTTGgNQdjFlL
         vA8pHiliJ8W8trx86ogsBBdZF8+9FhpMoVAbwDmJcD+hPK12IMkaFvfm97AEm8iQKDTp
         ZatOpdEvSvCDXJM+bJvA0KikpHUxXX2+oSdceVIbBGbjZWDlH47oZjOerri/wEj+jhOt
         75ksPYTtuxR86hR9Dy03Lf+q0nJ2a4FoQDqXdu8FIzPxZ5evXd16vsKeHK8bMP09ntLW
         br5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9qC3XV8a4Ev5Sl0wH92x2STh2vQzVwlBJubUofUHfFF+x/iTN8QcbskrlwX8nE3Rg8GM1dwTf1KQObsR0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUgxlQeLpimAW4UynKmW0Qo+vucAVocIntnefD24QkJhs9WBs+
	HWShrWzalejcbQFpI1iKiePl9o78gwAxpOjsloGiMkDDobJdA4n7zLfB
X-Gm-Gg: Acq92OFYBr9ytvNQMXXQQ3Vdn+thUvlhBU8yAzoDGye4y22Xnrsa4NGG+qZseS70Q6q
	SDGKDVu13VICQGwfid8ca9KLdMxFTKx6Wq2yQ1lfM3Onj/a6oi4CNNcwNLD7ZHdWfyz9vvvBE+5
	8LztoQUt1DLrA8877F+s0yI9uOK17JvkLTVR+owLq1hX2aptUdLiOaN2j9FyHotfvyVPsyLh4qp
	krZtLj+zCaXC3tCZ45C/90fOuRqfdURhyb2uj8IvMXk/aONPzsILwmanWTd8RAMnrVnpFFFEnZW
	k3hRNKuUEEHRlp29B+K5FsTULkSzyjTbOcml4pocFXoamXFHIsR8U4EKyBUvY0GpKiR10s7+Hjo
	ubNZGhdK1OllcqsoZSHwYfFien1tmYZkOJEx9GCq+uqDUQjIvdieLUGyGcFi2O1gUno1xzBK7JR
	kWxc+F+RGPv9DbGwmKiGIfYwNspbwN+HlXxuvn0zVTWvQRVl5u+GPLNApifEp+tJaIRiB/OIzyw
	YLmBR4mWGfbh2dzBJBR8SR9d9Gi2p9vgXmhKQ5rJB4xWg==
X-Received: by 2002:a17:90a:d004:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-3779e231462mr1177515a91.7.1781149992546;
        Wed, 10 Jun 2026 20:53:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:12 -0700 (PDT)
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
Subject: [PATCHv4 06/15] dmaengine: fsldma: fix probe error path not freeing IRQs
Date: Wed, 10 Jun 2026 20:52:36 -0700
Message-ID: <20260611035245.13439-7-rosenp@gmail.com>
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


