Return-Path: <linuxppc-dev+bounces-24617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E8C4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 22:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4XlG2S2sz2xLm;
	Wed, 22 Jul 2026 08:54:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784674490;
	cv=none; b=i4051hu/oVRkzjLqXMON/jdWUJTmPM77vINsE5HSUdGswNZsed8fReQh/XYvPxrAtTw2WG/0Ww9JSlrm+pi9kVNyQvF0CDSagJz/oyU88yJ2d0YRZwdon7h3GpnCRZkzHDXSgBXa9CaeFLNCgYHLXD1IVtWiUtRs3oX1a6Z6i/yBZjb0PFBmUpkLb+ekJlU+LcPQAbn5VDv7PKR84GF3ovgY0nT27R72K7mYRd5lGvX8raBAiSlPKUTOGo4Njt9w+6b7WwDldg/TknA3A6Dwc8cS9k2h7MYen3E3xGRzZzCwfrp14829gR3n8ojnFmWInnszUbuAXwMDitXMj0DFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784674490; c=relaxed/relaxed;
	bh=QbIg1IxIIpMZeFpgIXtG09JmNMcRp9S88gerpDxWPSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNST5rq/fkPfGHNs7WhOKCre8trnKccX9dcmWB++PXqpK72Z7JCVBkhc3z9eYrbiA7w5mRPdaLaZU9tnc1rPIBLwqe9Su3FWckqpQUKyadfQxndeC8YZIBUvdrMqMgHooxF7WyM0NZGh82jO+bVrxYMlM2oiY/HKREiVi1szqQANyvUEYE/OMd87rYlOEbsWBMdCBDh3c2pfxNqCYoj6ExuiOXaY8hISxLV7Icyf42DjODAHBAVmX6Lqt86qoWGUDBYhtmL1+L6YLV7jiwth0LtpBpXYNdebOzJoAwqIMzOnqFMM46hyBATL5IozFa3LB0L20i8k2ABhHqQvQa7ERQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qvjqti9S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qvjqti9S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4XlF1Dtxz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 08:54:47 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-384c94c9414so7231646a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784674484; x=1785279284; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbIg1IxIIpMZeFpgIXtG09JmNMcRp9S88gerpDxWPSU=;
        b=qvjqti9S87/+q3LEwZfLkJmqlJesqxLoYlzcq/Ux/p6UuhTb03Vvd8kpG+6Oija4y4
         nTXxYX4oqjYnJ8XPjcjS6WTFYhDO6zPzfnkcdARck5HIAAGzktHUwPSII5PLp19OjI8x
         OUdZvgKXX6hzDWUd0DxFQ1SFER8V6idPks9nde3+gHQMfoxop+x1azpU7xjhsbsAUvyE
         2TgKQzwIyftYgWAbfVjn5jOHLg80MPwatQJn0PLqA9kTZ9olDL+L2LmPWi3g/aesB24i
         JAcC4+mZskK3hS+bS0QBTB/XfFmj7u0kQWxsz+ZFmkQJ1VtA+ifn7/dWCjrPyEThBKVk
         DiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674484; x=1785279284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbIg1IxIIpMZeFpgIXtG09JmNMcRp9S88gerpDxWPSU=;
        b=ZObfsd/AHq4h58xQ/Bug+DBOQiaxQ19iUyAePZwV802MhgX61X/8FmFpafT6k5kbfy
         aUxWwHljATcaUlVGUANT5laJUZsMAmZWjcKQM8nBXYVhFfjRVifr81C5svLKpCak5Jbg
         z41KckXr02x/1WKWuvu7FuqEvsKmEEIe6v3eZRLuUmgaJVaB0KLWWhaw3+4PSmc///71
         yDQjMV/wnMM73v6PviK0f0ZJQf8LRx1VOWtHGsaReG0fz+KpNysM6MMt3FiABhxZupY0
         6/fv0mXUN3WE70PWl0HV6sNzvZGD936onqtP/CLSO+AJRwt6Y6is7Ltq6TZ402KKcNhK
         wSzg==
X-Forwarded-Encrypted: i=1; AHgh+RrYHMleCEk1h1/U1UvyGr+mHpT9sn8SV5tC+vJDENiaUxxoMMIMY98TPZ2s7pRN3qJINHOXyT74uJBa16Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyRZRzOpzd9BHawa3F39Xi9ZOylQ/e+yEj09Ol9kQVaX4f9EpS
	uEa+/zZUUxt132XZ801UCBcfbnO4hIQnDeKSjizjs/v9C+QArpttaWl7
X-Gm-Gg: AR+sD12eAJIxDGSZfEmB15pYLtReSWIA3iJufzwS68ehwgKNviWWqwoJ+v/NG1GR3ba
	w7oXZsngFrptIRCynrKsM67EeiicSZ4OcQr0LX32zm5AcLw2cB9XBoS/g+y4d6S2J20VOt0OjDC
	xVGDstUVk8yBaqh+ipz/vF/1QGGbHTasuMHgggLnaMzlyRlujzQXsCf69HJU/yhDJ+YL8QlRRrq
	i4vPowb5Z1ARvZ0gJCb5ILfXcYaw2wECU5tC1SI1GNJk1N6h8Uc4lRmgpx0Mq4I9z/CgN7q2k3p
	lQn8iJpZFH5OTVnngzQINRReops80dnR9rQAnfWq4GFTt5EASoTrLCJHV8MrlWez8j4Tb92II0P
	AhsLTimFWQz1UC+sWZe1TS98uUIkMYpKY7TB+hyMeci2PbvkvF0pM0oajaYwnxu7jDA7SFwY2lp
	o3RlZXH9a7ClfjO+Buj5UM5Abf5wnwMpwPPhgvFK190gUoV2IgifY/wI2pzv+6i6z6VAplG1nnO
	PHB3t2eQg1tLhiSeD3bX3rzWe5MiNMBgaIbLJLqz8ll97qHRYWmdKvJRr8hyDKWdA==
X-Received: by 2002:a17:90b:2ec6:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-38e6a446b78mr8745830a91.0.1784674484427;
        Tue, 21 Jul 2026 15:54:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea7aff836sm39369a91.15.2026.07.21.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:54:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] ASoC: fsl: dma: use platform helpers and devm cleanup
Date: Tue, 21 Jul 2026 15:54:42 -0700
Message-ID: <20260721225442.817787-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Convert fsl_soc_dma_probe() to managed APIs. Replace the open-coded
of_address_to_resource()/of_iomap() of the DMA channel registers with
devm_platform_ioremap_resource(), and irq_of_parse_and_map() with
platform_get_irq() (which returns a negative errno instead of 0).
Switch the allocation to devm_kzalloc() and register the component via
the devm variant, dropping the now-unneeded error-path cleanup and the
manual fsl_soc_dma_remove().

The SSI node's register resource is still read via of_address_to_resource()
to compute the SSI FIFO physical addresses (dma->ssi_stx_phys /
ssi_srx_phys); only the DMA controller window is mapped.

The DMA controller register window is owned solely by this driver, so the
new region request from devm_platform_ioremap_resource() cannot conflict
with another claimant, and it is mapped exactly once (no double mapping).

The local channel pointer is declared as void __iomem * so the
devm_platform_ioremap_resource() result can be stored before assignment
to dma->channel.

No functional change; built for powerpc (allmodconfig + CONFIG_SND_SOC_FSL_DMA)
with LLVM=1 and sound/soc/fsl/fsl_dma.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/soc/fsl/fsl_dma.c | 68 ++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index b12474880185..b1b341132dd6 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -18,8 +18,6 @@
 #include <linux/delay.h>
 #include <linux/gfp.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
@@ -824,9 +822,34 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ssi_np;
 	struct resource res;
+	void __iomem *channel;
 	const uint32_t *iprop;
+	int irq;
 	int ret;
 
+	channel = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	dma = devm_kzalloc(&pdev->dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	dma->dai.name = DRV_NAME;
+	dma->dai.open = fsl_dma_open;
+	dma->dai.close = fsl_dma_close;
+	dma->dai.hw_params = fsl_dma_hw_params;
+	dma->dai.hw_free = fsl_dma_hw_free;
+	dma->dai.pointer = fsl_dma_pointer;
+	dma->dai.pcm_new = fsl_dma_new;
+
+	dma->channel = channel;
+	dma->irq = irq;
+
 	/* Find the SSI node that points to us. */
 	ssi_np = find_ssi_node(np);
 	if (!ssi_np) {
@@ -842,55 +865,19 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dma = kzalloc_obj(*dma);
-	if (!dma) {
-		of_node_put(ssi_np);
-		return -ENOMEM;
-	}
-
-	dma->dai.name = DRV_NAME;
-	dma->dai.open = fsl_dma_open;
-	dma->dai.close = fsl_dma_close;
-	dma->dai.hw_params = fsl_dma_hw_params;
-	dma->dai.hw_free = fsl_dma_hw_free;
-	dma->dai.pointer = fsl_dma_pointer;
-	dma->dai.pcm_new = fsl_dma_new;
-
 	/* Store the SSI-specific information that we need */
 	dma->ssi_stx_phys = res.start + REG_SSI_STX0;
 	dma->ssi_srx_phys = res.start + REG_SSI_SRX0;
 
 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
+	of_node_put(ssi_np);
 	if (iprop)
 		dma->ssi_fifo_depth = be32_to_cpup(iprop);
 	else
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		dma->ssi_fifo_depth = 8;
 
-	of_node_put(ssi_np);
-
-	ret = devm_snd_soc_register_component(&pdev->dev, &dma->dai, NULL, 0);
-	if (ret) {
-		dev_err(&pdev->dev, "could not register platform\n");
-		kfree(dma);
-		return ret;
-	}
-
-	dma->channel = of_iomap(np, 0);
-	dma->irq = irq_of_parse_and_map(np, 0);
-
-	dev_set_drvdata(&pdev->dev, dma);
-
-	return 0;
-}
-
-static void fsl_soc_dma_remove(struct platform_device *pdev)
-{
-	struct dma_object *dma = dev_get_drvdata(&pdev->dev);
-
-	iounmap(dma->channel);
-	irq_dispose_mapping(dma->irq);
-	kfree(dma);
+	return devm_snd_soc_register_component(&pdev->dev, &dma->dai, NULL, 0);
 }
 
 static const struct of_device_id fsl_soc_dma_ids[] = {
@@ -905,7 +892,6 @@ static struct platform_driver fsl_soc_dma_driver = {
 		.of_match_table = fsl_soc_dma_ids,
 	},
 	.probe = fsl_soc_dma_probe,
-	.remove = fsl_soc_dma_remove,
 };
 
 module_platform_driver(fsl_soc_dma_driver);
-- 
2.55.0


