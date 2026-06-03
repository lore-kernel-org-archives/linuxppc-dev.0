Return-Path: <linuxppc-dev+bounces-21989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1156CCD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 19:20:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVyFr0MZ8z2ySJ;
	Thu, 04 Jun 2026 05:20:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780514415;
	cv=none; b=DW0TALpXLwULEFE4JjDSBX1KG5zjnduvAXjSY0grYEgQvHFuTfJjnKHTO5yPrpgcfsV8dI+9+Z62BTyKm/FK5XhNTy/zDpquzcFdP1PFqGkw9Vok+aXzYvuxzPIqmB+c+KPgzlppAn4tfbh+nkidm4Fz21EAjyLvb0eBOwKAAvooVeRrp+T5mbuJIqFrv7h43tuPcTdjWvvA0waGh6x+jRdTb8FRhQJxlK+NqvRKro3U56Wq3FFA/HH36FAYQFUswkCZHKW60k69OaynQXRN0LpZ9SnWg4UwXoiRaAQUhNIXtWywyVhu99aXRa4QzD30bHlHOID3XDBxoYMAMrKC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780514415; c=relaxed/relaxed;
	bh=KwYMAaLF5mHYedGImt+0WHoMwy3yyjRd6iX6DU10JXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WowSBxN+Lo2LKIxutPieR+sfHQtrnZ/8eATD5cjNTbrhLls0MX6DSrNY0I+U34HoDZUtZUnW/DoXdUw/2DYpSp/cjEY64gW4hqVANhIYi4hOyUCcF2MWUN02DrCk/G/jUAMDdj+a64ioYwOYDnFERya9OqyniWHKyRTJ2wwVJqxjINU1FzypZ7bL/nc5y/htwGr1TebfYPvyBL29lVvFKMQePxKjre/WqTVHGuln6KwMDTTIAneysG8wwMU2a8+Ybgz6f61C/R1nAdWE8vfar0IFT9v94FQkXAQrITIYPEjfzBs0bRW40QLYxyW6WFE+3atFLHJJvok8kWs6kJNyHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dG1mTnqL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dG1mTnqL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVyFp1gzfz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 05:20:12 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c857d04cc99so463297a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514410; x=1781119210; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwYMAaLF5mHYedGImt+0WHoMwy3yyjRd6iX6DU10JXs=;
        b=dG1mTnqLkb8lH311VuOEvoZiCFD07ewzSLy6OC++4gRnVYCxvZDErFSwzs6wc0T9ZJ
         MYVzmgMgZbtywDP8S4yIlhugy8bWJKIXIgBehJ439KP7FE7ezdAVdplbHzSJ6HjcENW9
         83VJ/vDpvprFVKOdNafM1NbOvToSEr/Ptqbx9EjQ+3Enu2SDeB1kXEhe60y70Iqu4gxI
         7eXfIWCnpAVq4c/clCV+WEVaX+nhUj77IgpWlYxj2w4PLjt+q2DFCAatGAX20D1VPyVW
         XyIUvYNRSQT1I+r+RKX0j1o3P7nyFqVUBHAMFKUxwg93nyYzJzmEYN26c6ERimmJWq+/
         +o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514410; x=1781119210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwYMAaLF5mHYedGImt+0WHoMwy3yyjRd6iX6DU10JXs=;
        b=J5MaPrD9V+56s+IGwml9Aa5Ot4i7zBjV2fgINc8u4Xs/HAyQsLRQXYcy2oAAcMMnYI
         Ry0tcNHY3G2nuY1OR03FfZwZq2wXkAmLbSwewob/1AuMiYJTVJnMEWmMHs9vx8+bIj3H
         Tkj4+GSk08yatT0UgUh37K1PI3puS190UVafCLWjvf8VTxlQK8hzhhNJ8YeRq5HHzuCP
         wuzPpZpNRUlaXBjBVqvmzcTPSdjnhEf0K5Ud9KkpQngwZ8icNYgP5bsQzHBXLKPsJi0/
         fi5Z6MdmwFTITH04NBX334fYfjRIW8WyA4b6RmxttrBRGOHtGGfuQZNHIf/1IImuQfoY
         z4zg==
X-Forwarded-Encrypted: i=1; AFNElJ+i5hxYIWaXrX2DNlZGf4r/zA/UGbCnlxhW1bSLDXSY2YCRwNToDjWlEl4czuCwfr3SHKCPTtnbB/3N33U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXz/EEQ5TlpUvbtx99xTSAX8ajZqSkpa7RaByjWkH67QUTbYqH
	bI1K2wtizAuustGXOdJTKIlPc6CD6WFcL7Y/JAdVcDYGY3P+ZwHR/xri
X-Gm-Gg: Acq92OFfLagpWQIUOSAIcniHY+w75ZlzOHX43M6LYVIElw62dUQtxTiEZwQB8qeIjhQ
	ThixhCrwFyqT/kKdsfFnvcErNzq7TyRWHytTJDfzcHv3Os3gaQkFzGvXI/T/ePUnUE1X8vXP9pg
	JwGcleiVIYufHXv4nel7AMxcFpsnmFO/NvfeVbyQtkdfBtKtZMy7xdXTwTTZlCJnHLFbXo7Wg87
	8tVWB1O2Dd+Pk4Id0ZEKpcK5ZDzEScJNbFlJY3DRGXFoaXVl+p5POzNLKCNQINPB8wuXV676A6y
	P/fKR44NU2Ua2fVwDJbdxRwZEZYnQPkEc58F+FVbC1JIVUEjGOaC9lQV+WG8EEtUNlpvaPdnFzB
	ni0sg3YdAAna+Fh7Kr6pAE0aWuWSGCYwWyVbfXkDMYCxheKaNvxTuGVH9teolj7KX+0rFXfCwK8
	yJShd3xfnekTzdiVNr/MJww5IWmVAqNbHqjvRX0haQR7I0AObZrsytj7px33z56AKiueQ+W1Wgw
	UjAkVZe5MXBk2mJtZw3VgJfW2aNrfUbCDmoijg7x8K+gg==
X-Received: by 2002:a05:6a21:3995:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3b4b1e4f9c7mr509069637.15.1780514409663;
        Wed, 03 Jun 2026 12:20:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm2548934a12.13.2026.06.03.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:20:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: fsldma: convert to platform_get_irq_optional()
Date: Wed,  3 Jun 2026 12:19:51 -0700
Message-ID: <20260603191951.5729-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional — when
absent (-ENXIO) the driver falls back to per-channel IRQs. Any other
error is treated as fatal. The corresponding irq_dispose_mapping()
calls in the probe error path and remove function are removed.

The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
device_node rather than the platform device's of_node, so it is not
converted here.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 98d02809ade5..08a8090178f8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1239,7 +1239,16 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = platform_get_irq_optional(op, 0);
+	if (fdev->irq < 0) {
+		if (fdev->irq != -ENXIO) {
+			err = fdev->irq;
+			iounmap(fdev->regs);
+			kfree(fdev);
+			return err;
+		}
+		fdev->irq = 0;
+	}
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1301,7 +1310,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1323,7 +1331,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


