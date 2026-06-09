Return-Path: <linuxppc-dev+bounces-22363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C49CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyX6bm1z3c1S;
	Wed, 10 Jun 2026 08:20:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043604;
	cv=none; b=gWKv6IKtHS7/7zObJFBPTs536t5sbKIsda/Tv9nq6wW2+s2UPe1D07xVtIx3WCSiXSBIAOXsD8c3gE25iStkeI5LkFdpvjDLPb/WpYA052WvQQC3Ub0FEcBRN/W9lVLAMKFWhCaTscgEdwEqXv3ThidCjYYMy+Q9F7bRPqRH0aiYQjShkwmYqT6XCift20hzQI4XQEHwWuJ+VLOwSNL7wnL+mVgbnRfxLEuwTQi+gHCQigEVGqMAc9Bk3/w2SFT23ybasAM+qpLD1bCwHPPEZhnSCODKh3eUkhCp0EBY75xv/DOD7+SEBE9a0sayoblD9IrQhuuxByzkjtPPY7Xzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043604; c=relaxed/relaxed;
	bh=LQhRsjTa8nt00Vhb5aXmUlX4VLfCEPtM7YH8ZPQELfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYjzvgaKY4hg9NYlz8DAFmQPgB7+AevAq7LovkIbQwMRSlTsYbAFmSAvrMoLZRoc4psLE8SrmYzJrgsur42q05FzmuC9vQGZmAsQtEFbzQTblS8pvX3EDM2Mr5CjpKQNeSOGMUN/uWB+/ybP1/jZ7Yuj/z+5KdxQf2o8AcLye7Dxd3WD4IfXcPkRKXjef1VqqCx4KWr8LOG50hNOesLXDiKJkSHPMK7yALjJjZ6AE+hvGOIDph0YEc/wyIZ8FGBMRpfsIL+S2isUhS+PcuSXyc4n+6pTu05XUwC38k3fLphfGeuWBr0LAic7eG8sUAngQDa2405+W+fz8AQ+V66vCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrdqOykJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrdqOykJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyX1y9jz3c2v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:04 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c859878eb48so2401543a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043602; x=1781648402; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQhRsjTa8nt00Vhb5aXmUlX4VLfCEPtM7YH8ZPQELfs=;
        b=VrdqOykJ366t3Sd3yW8Nc07SBfgr7jeHnQJu5op11kJb1d07Q6iqa1xF1gvYqwv1RA
         cuffcSa4VBhFhuhxhgGf0hozHfRTRpRtc8SMgosQ4vSLZ1u26P6M9xO9zFYkSFwi2wpr
         XOYhamEzNDif9B9/6k0jW7On6QlLnvNPf3Ds9yvY7SXpuG7+O8oz8VCqZkAWZMIf9EzL
         /HWjZgCZr+JNjUDn8NwTFCer4Y9qwsWPomC5iKXcTau5TrOK+9dOFUdv25hJlARdCsk3
         cNeQ728W9OBztOi3zhNzF7qw5MvPmFS5VFL4L3nAe6b9X/NOIHWoNauMp50k0MuCosdB
         +edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043602; x=1781648402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQhRsjTa8nt00Vhb5aXmUlX4VLfCEPtM7YH8ZPQELfs=;
        b=bva9TzMar4Izv2sXPfAJNKC/fDUs9wEAOzhmrt1TJiaQ4aHcVom+Gw+PeUffiI2ECA
         049lI7THzQ5SkilWcT6S25Q7UQWwdns+nbxrdct4lgG3pH+6f7947iqFRJR5TmEr7wxq
         hvhEgz5VjB73sN6ywmNQ9T90ylMr5FjOx35Ke2rY7JELGPRoawjd9SxlvCUu9s3z/Lhg
         SxXRyV7xe4Fzw2ubz9LUhXDifM/Zm2IxJOLjLBBkF4UnPbZejp4zNA3Ffs7rRZiVdrYy
         6R0HI+y4ytINgsLW5X7ELxVXsm/R1HIRHFx5J3gGfS7d0gp06I54FibpPtLX7WnGfXy5
         W8Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8N1WxG3lTgPn9DoNQkd7E3Mi5U4vaYd801Ndzey2+1Ve8lbL3tvDJ7hf37AQr8Gn1r6Ysz6UUuucCK4SQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhbRK3ucvc+t+KK1HcR1Ojatq2Izg8RaZBSFBCrb4eH+ILUSGj
	CEq0FzKT6/0ruy4Rz/2ECy7YxVWn9VVinsdHMhH7WW25EAe+Ah8U2ZN71A7lWMZ6
X-Gm-Gg: Acq92OGsMx3LggM8owwC6lnJadTRjAGF3x9VDew8qgZakVbLNTBEwNQF6tQJKyyT7Rg
	bMInnFs2IsJfBQX+fgkN6zSa9mz/+h+r4E7mXK11SApocs/cejbLSck9PI847Wq+SUSYIQ1cFsV
	fWGzY138gf0A61OAwE7ZqNnlAMJ9rYP8voeos7RRLmQRxR+tmvqrxlKP8a9PdUj+QeO3SRF9SdQ
	0m5d8/lsFpQjMRs6zCpTqMyYOU3XnHZgUxx0oPdmSIlfXoxISzcT3wzt1dg+hVJ8du9z04ecGPq
	FwYyIsPsZiz3V9sAD8/4W1zMoi/Y7U9vWHolxbUwn+1InWgDOdTShahKY8uVb4UW4VeME19A5Ce
	tGuVw/mdu1R7n+iedM34nhJFKWvrWkGp9ewM4KZ3yKn946zQYwwdPMS6ITY4/4l/PzymsTuzzA1
	s3jM+EESwi23rr3GMPMAHhe9u6YoFY+bs9hhkZ492gKqxUkErWZwUzJ+742z849TkZoUiA7uxc6
	uTvexEpMr090UMYHZXz+vPW8GQTHbEdmAmoFa3FEbnNMnt2WnTwBKsN
X-Received: by 2002:a05:6a21:a94:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3b4ccd76836mr27046937637.12.1781043602200;
        Tue, 09 Jun 2026 15:20:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:01 -0700 (PDT)
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
Subject: [PATCHv3 09/15] dmaengine: fsldma: use devm for kzalloc()
Date: Tue,  9 Jun 2026 15:19:20 -0700
Message-ID: <20260609221926.35538-10-rosenp@gmail.com>
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

Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
the probe error and remove paths by dropping the explicit kfree.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index eba194d64105..dac12de06ef5 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1222,18 +1222,17 @@ static void fsldma_device_release(struct dma_device *dma_dev);
 
 static int fsldma_of_probe(struct platform_device *op)
 {
+	struct device *dev = &op->dev;
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
 	int err;
 
-	fdev = kzalloc_obj(*fdev);
-	if (!fdev) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
 
-	fdev->dev = &op->dev;
+	fdev->dev = dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
 	/* The DMA address bits supported for this device. */
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
@@ -1242,8 +1241,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->regs = of_iomap(op->dev.of_node, 0);
 	if (!fdev->regs) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
@@ -1325,9 +1323,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1361,7 +1356,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


