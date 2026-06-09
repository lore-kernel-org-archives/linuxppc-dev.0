Return-Path: <linuxppc-dev+bounces-22362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4D2CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyW2G4fz3byl;
	Wed, 10 Jun 2026 08:20:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043603;
	cv=none; b=byiznMvOrrz04D2LJKwBaTn8A7cTndECIdicWP2FhKUQ6PORTwEfLqvz5iwKeSu2kM8Or9wI2G+o/b3JSmRo+23/K2tLnOEAQn3ahkxy8uTrirR0rTvEwkA/XoPb8iQDU47VutBqqeeYCaH9dCRNzQZKeB8xCOte7rfi5dE63PZX1+QV8sNzfU22BtLm3kP96MEEAt/SdZWgDvfY/ff6pXsb+aCqlmdnF5EVbbbzKJ7kAKEV7BevuzIfNI+6B7tikq3GzHGd505Rmh11Om5FSStD8Cy6PU8dBbHkEeF/ztgcVbLEVxCEuuJxtUmSC/+1/zdAPV6azkxBqmUra5M0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043603; c=relaxed/relaxed;
	bh=txLeeHxUVUSX7wi9aUsbTgq6v6+yCgWQ3OKqqrJje5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq1PHFaAxQVxe6HYGUaMyGrt2LbkW50D7FG1pmTAbNyQ5G/NiV9WKNPkMl7djPpRxnqVutR6IV3JMGN+gxZjhGiW/xiPIdla87Me+AjdyTTbx/AClSQvHifINHaVRadCLI77edTW2HJ41SvrvKCrFdXBRefliGis+GfilfzOxjfIh1BY5iYeSY1ctNYMgepXiqwvhL03YxHtkKoUZ4vOCHHEdEkjXFfz9i8s54LlZtO0L/RotgXjC8B097fhy2IwX8oconsblcPqL2qUefu7SeDMjf1VvbItZjl/WbkfCquCl2Uzi8ILZPBJ5Gcj9r7Ec0Wv4scfL9OZq8Ar5OQB1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BBLqUFt4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BBLqUFt4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyV3rYvz3c1S
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:02 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c85d8615b09so3551327a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043601; x=1781648401; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txLeeHxUVUSX7wi9aUsbTgq6v6+yCgWQ3OKqqrJje5Y=;
        b=BBLqUFt4kh1ndMZcL0rmt4ix4aPs3iRUg5dp2FcjlYqPwsa4XqPE1f/vB+wX54I7Pn
         JKL1SFdzeMyx4lF2Q/2phO+QC4joZ4PdOp6c8DPZ2SUvCmm5TnnsbGeR+l2+agX+GaiY
         CdHIwQlsVjXGqfWbbE41JrfjzD/qzx9c0cP4Z+p/odr84csHV0/+SdS4KbzRb61IsKwk
         JoZsVZ8O/xgJqscCdnyrNL/ylzzKUuWS/N+YzmZE6PuYh6k34508qptJB6/kSydw79Yr
         9yZ5lO3MDgBpBd5VwkBBnrZjCE5exdf7U6j+qIdVTQSIt/EeIuwRR6KsPucGIkaeINDG
         5mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043601; x=1781648401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txLeeHxUVUSX7wi9aUsbTgq6v6+yCgWQ3OKqqrJje5Y=;
        b=tOhnVDkixy+XTIihYAeoTuJ7tV6I3U/r1CHmmkL1f/uOS8AmgjyHeWxDXRMwl1yKAf
         lOz+UrRMsQ7slTv+lxA27HuazsTruKndjtAjsRI6auWlre3sjb83Vq9YakhFZpGarElj
         4fjos6RHwIJwGq48el0xpOjxnKhu85FeLEInmmNJ4sDadTICz9FuZzZXyd7bXVfWNoqc
         Iqz0/pezUy+JvFB1cPPVmUK1Z6AoXFMf9HZ5EP3iaJSXNiQxHMjZpCAz3pJDtW21XQD8
         Qa9MpPIT0CSWY+OvGcyzG8WqitrBZSW89QarxtkRN6FY95ChUZHjNBf0fBSnc/Mo5imb
         eS1Q==
X-Forwarded-Encrypted: i=1; AFNElJ99BBQjA5mIuDg0WTLx/RP5vjfCCCgwt/nUnH4b8ltSXcHRrjJjKEq//VvxLz8w5gRAk9KDc5zmt9IC02s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFt/RN75Z7TdeWlJK7jOo701pIMYDMv6aJjRNXG+CQB9XswqaQ
	e6chq6OAfwdNEIvOvVWpS6MmO+iUjqRTjsYCyuxckhaoltM1JyznXSqi
X-Gm-Gg: Acq92OFg+RFzRpylabXN/sCCkbpNBSknrbu4NhVUoyr31OWWJPnwqcpr2hJQadV88uk
	OgscKPYTklwq9VwMHb3lWOPgBbmUq6RAbTL2rLReO9nlQEZkcF2vFcv6kdwDHMlUtvMl6FYulyB
	Bb0A2ftcr5mQTS2BvpGiesFCAWoV2kFMY6xM5Bhv7BuSZxIir7Txi45IikEokiw7+P60g+nxzxv
	Pv6aTn+5ULzgKbPXE1xh+Dg+c3cJ2AwrJKYI9YqpLgyx0ove/y12Tzutk4AkFND4huRINMYva+4
	dyLSgfgn820nbZtkODKH7CbuhheMKL8CLxj1WzMQbaOfl6+ud1TzOhrwjUOE+iHP93MoNOs7PDR
	DVw+itjMONpM3X/Dfqteg3beIAr+SDKt2DjwaB23YhnhhpcFknHNBPHDn6yw8kKJMshfTlbhG9p
	rZjMcpo9Mgfd+1QbvwSTqk2wBTaR+IU205m2wt84w3zxI6vWF7cw4XGxeycWLPZ5LHiSdUky7FY
	rsMr3YfJ+zRBBBt4XUtK5zBeRdp9I0jR/P/+UeATG4znw==
X-Received: by 2002:a05:6a21:4c16:b0:3b4:8ad2:5ea8 with SMTP id adf61e73a8af0-3b4ccf81eebmr27631680637.30.1781043600819;
        Tue, 09 Jun 2026 15:20:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:00 -0700 (PDT)
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
Subject: [PATCHv3 08/15] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Tue,  9 Jun 2026 15:19:19 -0700
Message-ID: <20260609221926.35538-9-rosenp@gmail.com>
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

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional -- when
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


