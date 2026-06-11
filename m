Return-Path: <linuxppc-dev+bounces-22456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C8CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJY6Z78z3c2q;
	Thu, 11 Jun 2026 13:53:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149997;
	cv=none; b=TKc+7NZ8hDGqSSHKk6bEkae1AhLH/ILnwS+npoJmoMFaKVwtSqNNm28RRvPDVebqQRtVWKdRCpmZI5szAR2nLoKA64TgKMoL8vgc/QqmAd4AA+Mv815UyvEZHiFgW9EPIHHUBgVQjmrSHAiYXQoNJ4yIwFg+04dDGR8pdSxbigIC0RQ40m5wxD3cA7AH1CaCbrUClrnQNTZ6cKp3tYOGSDUqkqSlDYXdn427dzs8hh8kLBztp1bxF4RK+T4mdi8eXfnfCg8SllRHAowx0/7eQaHjjVqDPD0SR7Z3NU2USZKfkxbEZ+rXt0u4fFFpoffHsCB1cap/AhoPpsX8BlZkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149997; c=relaxed/relaxed;
	bh=R8RAk798iHkOqMUF+266tq7iD91rBE+7QMl47XALgu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cjg4nOGTO60DZxSUPPD7WcUoIcYwkVOEV8nJojKPrSLq7ksmGZ8Xgvp0VujW9KIWoH1REP5Sz4kUfzzqzaGWomMOVoxlHuxLRWLA9b81KnwmfgAN9jin/lFGqSCc+G41G5OoSMlrZopkcIQCYg+SvH8gOcPmOUei8NQq2M3O3I5av7rcMDv3LbsmIZIjJKEV0H0oPmttNypAu8xQIxRAdWp3EsKakOeQ+ZOXKqimWYVas5KOR4iDQgpgTHlPsnY7jEn0kx/asMY4yMqY45RuX71u17uMlEP83UCWbRR793slHmA9s5I6A7x+woiv1C2QtX4eWepPlnL93JObzV9XWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=el8FKCU3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=el8FKCU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJY1mHTz3c2G
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:17 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso6502671a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149995; x=1781754795; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8RAk798iHkOqMUF+266tq7iD91rBE+7QMl47XALgu8=;
        b=el8FKCU3CStEK3co7R/2LtdPc+YY3/h4bIJoY+ga3JsZgjYsJqTFgZnKlx1jTjBI90
         vqLU7tACjCWRoIkld+MSbciWv0HPmxVczaazbf9/pj8l7qD01yfXj6S+TVoPVYA4nJ7v
         1dNLev1I6DypleMQJRCtYX8R1N36I9wGGZDQqoX89W2fbPRTmvRPg5nP4Tji4AzN0Faw
         LCDNp3cjkP9EVg+1+tXODh6ueDlfy7OAY8cosm60ECQM7AM8tdi36NHvXibL6HS3TA1G
         oRU5vryBNuYF+6/3JSrNvvqnqznENy9WX3Q9i5VJkeCJEydikTQ+ugp3Uw+PgfWqXuXq
         0V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149995; x=1781754795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8RAk798iHkOqMUF+266tq7iD91rBE+7QMl47XALgu8=;
        b=KJceyjB5XPqJj1Wf6DBvE/z365NCnvNM1KA6XrArLCaLCX6Du/b5B/qEWNaIXRUgHp
         tooH3SpZbT4CVYC1/TW07mKGMptRjhybYJrpFhX0Qi/34HetV3yI6nNyJw1YZbv/CoXU
         cRiONdIUcPAZmuGiyKQ6um4ejQ+lWLvJzZIArNNryMZeJJ+HI9bADW006F3eAM8vn2uk
         ERP3DyAVCUZ1X0wDYzIWAmq3aWMTREFQZSIHcpU5Z0TC/9lwoHGwSjPNEEyTT/ybImLT
         FEaQ7nk60KKSZkzEWuED+AepMTMKt5K2M8VMDSR2VnzFQS7hQ0WRDHRmiVY4FNBVrx22
         dmaA==
X-Forwarded-Encrypted: i=1; AFNElJ8WpZ71kylwnzFrlr9HtE7JCUhfKKG2kpmHSEuk4VinJh+a//lWhzAHfmEn0txijpKAiTg+5gUMU2w1auI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0LWnGBhbVFVoFSF8E9NRgxWFI0u7NQxJEwvWE2EJdrjdcYFdk
	TpxXpO4pixjz1+21zwcODaMyvDMiUCVzekyEjeNJpEaiLGt3cHwuWzwE
X-Gm-Gg: Acq92OHj7YB4n2VRU3dKbj1cnYROitacaseK6mnzmjznpd+BgR/RVe2aIxswGfab4bg
	5RQuOE8fGQnudLYNl+PZyfb9lNZj9Eo0D2YVzYlcMrSd6uaLhWvUn5fvHP9Cgw7Cib/l0xms4OS
	fmycGnNYlDKxdnbFbf91PXJBTd5yOn6Ws2GG0ytyu8/pSR31CWl4B/Riq2EMReXvoc6LjRjm+vt
	kMaE8H8mXtYxc9VXXtEiEuePIv2aZeCSkzjbHlEsCKgzt4ckHJVk7zgUOuPsC8VYWyDV2NGZv+g
	PrRsi3OfosZOBEapR+A/X8e7Rgz15Mw6X3GuA8gQGNLyNHQdemWQxv89T3DMQYL9CouIFF6B4Hw
	Vrn0AvFqA67v81m2vp102Ybmp1vwzfvuZ+g7SE9RTUlvdzYxS3eATziNXiptofzb0+rhkwA8MJm
	N7IYXaTKoCVRZCEye5sDocHw3TeHxHc5kVIM2+eFpQZ+sH4FmS3hxFdYTjISctokOtfwJeMrzND
	x+uDwgVlbkL1mD2LcB4Xi+GZ+6EXI5XFQFmW3WM6/pjWQ==
X-Received: by 2002:a17:90b:1642:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-377a5915432mr1202815a91.16.1781149995246;
        Wed, 10 Jun 2026 20:53:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:14 -0700 (PDT)
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
Subject: [PATCHv4 08/15] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Wed, 10 Jun 2026 20:52:38 -0700
Message-ID: <20260611035245.13439-9-rosenp@gmail.com>
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

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional when absent
(-ENXIO) and the driver falls back to per-channel IRQs. Any other error is
treated as fatal. The corresponding irq_dispose_mapping() calls in the
probe error path and remove function are removed.

The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
device_node rather than the platform device's of_node, so it is not
converted here.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c04a7fbd2ed0..eba194d64105 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1213,7 +1213,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	spin_unlock_bh(&chan->desc_lock);
 
 	tasklet_kill(&chan->tasklet);
-	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
 	kfree(chan);
@@ -1248,7 +1247,14 @@ static int fsldma_of_probe(struct platform_device *op)
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
@@ -1317,7 +1323,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1353,7 +1359,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


