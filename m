Return-Path: <linuxppc-dev+bounces-22134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902BACD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlX6khRz3bsR;
	Sat, 06 Jun 2026 08:02:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696920;
	cv=none; b=bJ3vyiwngxKCv7iLCz4QNbQxKDjJwP/lpunM0GvMtSvgb6Lkxa0cGVohZGAcLncPOxZvRrSsYmswz7GG0oaXim1+XEbbslGHgVwHbGFeMO+EOptS5kP8+2KeXunMvNFaNZYNXcneKoBphfQ0l0Yr5MXopJ/+jaXegto3kk9ffTO2lCIa15cqEvvRoffF33cZ1whJtKeREsh75t+WSDYobk1ePct06UrmOz9XDWlI8oLTvPOVV8kDqBBTTqs+py8JeKZgZD77B8wn548NMJ23+qDNahFEPOTyI3aL6VtWOhrkQz7BIDFM/Oov3paEwIXOQeOn5/oVjhrgwTJNwW/Idg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696920; c=relaxed/relaxed;
	bh=sFsQX2lLtec69DeOnNMYpEwpbYN8i05xT/hHGIXIjWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAgIn8n11eDcam7RL1siPuWnlDyYJK9wFWXPYIbDjWc2QIU9weX3AbeFd0eiC6oWGabUajHTaKFeL8hADlB8KG35JjaGwsJeuakhWhdAIJXDfhKwtb+mh0Q6JJ806jT6cMvGfxJ8+8kWPhZXk4hCpVm0KZQ4ykzpQ5TmL29QsdzzAsujQAV4zbM9iBH2qQB7LpkQVxOou13nA9qN8vBC8e2l1UEMEBrAghwDq789E0GGdLpCRVd8CpFRKoqf5YAYNabUlr6XJklAWalzJ64ZS9Ee3sl64j3gvrPn4YmRn+XtblRFoC3mm93XatWmOjjOi5UF+/TBqKRwf4BcnMhKTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBb5XDWf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBb5XDWf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlX0XV1z3brm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:01:59 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1068687b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696918; x=1781301718; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFsQX2lLtec69DeOnNMYpEwpbYN8i05xT/hHGIXIjWY=;
        b=RBb5XDWf89973cjg+uLLFKplTK1Hm7rcmrMOeVRw37fPFzRfPjM8OYwiSCkCmfSmKK
         WFp05OSQEbr0d3ejYoSutcHTSnFvjeNJYyoHPLLD0KsMLf9sEwzUlXxK9w7SIkt10SRb
         4WtkE9aEoKXullAElKlWMwJ/lNSzWXd1YiYjRqyq+fh6GnU6MRi4Fmp48kKLKq85HbpF
         K8dwPVtBhN/XYshgzTavX2/0XFLaLvDghXvDKTdJ73WX5I4Myiy2T4dkRBv/G1g3Bqbg
         I/9lTqyETwfsn1YARQqaQQWU37XvirAoJz2J993JpjDRTFxSvXXVmevNasG4fPuMW9eP
         /FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696918; x=1781301718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFsQX2lLtec69DeOnNMYpEwpbYN8i05xT/hHGIXIjWY=;
        b=cKFkhteUg/EVJWGxkhxBku11Og+/nE+OjCqtTH7c8z4+FO5wJN3LSJTyF9DPZa+0DU
         iVY8Ia9xs/jBvY4hC2292dlLN+mPwo1+sCmJ3t/F6w2sEJ8iv65Qocp/9js5MhUAUdlG
         5WwSetlKDVgtoLW1CXCG3+LKMMZVgKxWuf4MllSrdUQs5653wVBVtdiMkVoJ92NFKmoO
         GMEU5KL2N0b9CL1/xmNfcYctWvca3r6bl7jw7jwSsV4aDaE3WP9fwtSQkh0UAbKs7wMF
         mE3tPhJPDaBSHzhGB3LGIRNdWYEvXvvEZptzf2qkNUjtyTfAW5ZrqXBt3psItnH0smkP
         0JWg==
X-Forwarded-Encrypted: i=1; AFNElJ+Njh9AFAkWlZUcQSrZbWnVqIyoxllmV1ZD6Q1iFbtmVyHWi3yxBhasu2lNcnz5cYd6Aa1I1e7t71n/HnA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWaCOy8d4wowlevQ9Kyy7BAnD9YcvLFNUODsccSrhJYIj2Dy4j
	1/LfuVWGnFM9Qn4FjycL17ovIRXovYjzyu29ZSUvRdBfpmCnl2VcTz/x
X-Gm-Gg: Acq92OFMD0YLjNuDBJbOuZARZZFa7ljEyBHWRvzVeF87Rd7ApSvPb/2kYxa9pAU4IGv
	AwNVTBZ3SOWVpf/i+C5DDj+tQ9jm29Ojzfkce3ZeUJoM5knZQUWxCd1Y9Mn2m/ZRtkilPQnSQA7
	C/zj2FB3QNOYPR+rs9Nj6z2v+zBlZ9m0CtZo0/zxEZ1UD/U0vSNr0ZKFmH4GT/4e0pJS/x27mln
	ULRerQZCsk0qO8cfe8D54aXQrGoxhHtofuRsTiA6BxggA6TZsp5XQ2fJP0C2SjGG3/VSxszVoCs
	WLC1HXJQ7TfBUa8f7bIAnlMZi5rUVDPN95lZosn0eTSd6FMlVN8b4ZT5LO8tIOA2VMpHVKQZMtu
	Yrhc8NwlT9rBnP3DolvtTmmRfqAiQGI7tMrnjYyXGJKDUEzwt9LI6J0EyIUySvlg4gq39lAFXhW
	cKByk2AwsKxOv1EAs/Iz19+o0DBLlXNfAhB6lYPlxwoKVQj+WM26nrfMYmgdML4CVsNkf4QVJQJ
	ZTNCV6C9MEw+Zh4+X4aaEpxLesExFcv1xnXHlaL8jYQzA==
X-Received: by 2002:a05:6a00:4510:b0:842:8500:95f1 with SMTP id d2e1a72fcca58-842b0fb6d77mr5329246b3a.40.1780696917721;
        Fri, 05 Jun 2026 15:01:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:57 -0700 (PDT)
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
Subject: [PATCH 03/10] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Fri,  5 Jun 2026 15:01:27 -0700
Message-ID: <20260605220134.43295-4-rosenp@gmail.com>
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
 drivers/dma/fsldma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 89b88447be1b..0d28f8299bf8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1206,7 +1206,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
 	tasklet_kill(&chan->tasklet);
-	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
 	kfree(chan);
@@ -1239,7 +1238,14 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = platform_get_irq_optional(op, 0);
+	if (fdev->irq < 0) {
+		if (fdev->irq != -ENXIO) {
+			err = fdev->irq;
+			goto out_iounmap;
+		}
+		fdev->irq = 0;
+	}
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1305,7 +1311,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1327,7 +1333,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


