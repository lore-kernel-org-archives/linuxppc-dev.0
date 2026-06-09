Return-Path: <linuxppc-dev+bounces-22359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78019CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyQ65jkz3btc;
	Wed, 10 Jun 2026 08:19:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043598;
	cv=none; b=iBoqkmNvVj5yu8xqrenHDxuUCNaYtMinRIdyk59xamf25bAG1EJQYLcHDq510yNjAUfQDOptWDx9QfBXTso1dOwVJeNjB34ObjIX6jRINZ8qkA/CQQUC8ZIX5Ky2M0YkAcE7BjE69Ymjx6rnmc/TucMb8cEQxjcNmPLvUX1iKXzEkebFTwW24Lk/VVB7I0Wh+khqYnrQ3reCOQI5cNGUTWOJrZkFxqou7dvQCviPzGIqnQnci0yQNntHhfOgcV8EF+km7OzU1TAB8E3MKOV6LUvev9ZRXXG06XPLMYfcza1RmmlftLkvbpNKPEs4Y9Y+UsggYrDI54q4pgirjrIwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043598; c=relaxed/relaxed;
	bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdpKKcUN5NWpbBm+aM0+/R7wYDhC3bln5vCQolgl/tfggNN7bb8AeS/DWPcc8laE0qDOFv26mMDrcHJczHH8mzJdcNktoBbgpUfTWv7ea8dsy0fkwAiDxF0/PZ/UoPyh/9+BQxPntEPF0cTRy+Sd+KZSNuxFVLs5JRVG5a6VPiIc6DdpcFyKHyT8S+gRgDcbXjxKtgu86WJX7ZVnUp5lwCZHDRORsvVemdRDC+4G8fYVwPv7wkKXop7Z1AEf+oyMAMHxUGMhPEQOIEAjgIXoYeZiKj/In81OGJNp7/y+r24yelW1SF8jm5cHO9nJz7msKDAChkAYBn7Ii4Ej6GHA6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZ7kJc76; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZ7kJc76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyN6Dwkz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:56 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c858d69bde9so2540361a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043595; x=1781648395; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=CZ7kJc76Tt4aBK2T/bF9/thgfO6oUxu7GxrJLNv+Wc2LbJ8Ft53cKQW9OE7UDitai5
         AEL8nTPcW+k/bTPOHUXX8PROKIqVjddFKsjBY4PgtC+dKeXy9jkIAC4LQaTd4ZUJB4Dt
         wdvWqLbQtvoysP7a+NqG9onTQjvN5NVbNGeTpSjsPEwCLrFOCNat4iNIBpbAqvEDiRCy
         TMBx6iswoySU0AjrbnvsGTZulHgsPbCzHryGh4+vgY1mhelsiP7hhOwIGlLi5SHQYQNz
         ThYfJhZi4IeiFrL8uo6WmR8DNRzgiVmWZhQHWA+RfDHkkWTvy7BM9i/nFnPjowIf1mZ0
         brdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043595; x=1781648395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=Fl2GZfl295qXcOtFd5N/c7DC6h1EGKUda93jU81x/ub64/SLol60z41vD4c/OuvNYu
         QBJk43k717BzV/ZrTj7wLZ/qbC7F1aML2oB7JtNOzOg23ujQAJCmo2C88fXwGx3q1ouX
         Y63nFHZdgMK7g1f4N/AmBKY4nQSMC6KNfwnl6uA6mH/opoXV5MD1ghZgvpo9sQxJxKpM
         LY0JmuitYM1LmSJ+27Oo+TP/73z1dbPmYHA7KYTDiy9Ne44vPjQEPeOFsROYxDq2KQO0
         LwYqKZYg/Uoc7uZAVx7nl3JES43aQGHZgm6YB4bUSOw5OM9YtpbuZiH0F6bO74fLJlEf
         iXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yAehK+lhklLS0fT0gAFE1vu+9BT8+274pMnr+ZmaQzvYRIn8mYvFK5dYJZ8PxwrNZ5gX68Sv0ue2c5Oc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwVIqA4IB3lKSc8bmgjACit1EDxP9awTAyqKYFIQZN4BBUvCH4e
	4klcSiR5RDsrsMoZK72qfyoCdm8P2uLePt9X4Bg3Z3T5rDiIBRkCWhcd
X-Gm-Gg: Acq92OEDGsu1JjrFwwOy9zecveLqEi7PAl4VE2sf57CNd4055tFOK43PWSJ3pu3kX+f
	/yOk+6tN8JtApsHS6+05yfkb5GlsF5P45dmJrZCDuTQW3VuPAnkp4Socf5mZOr/E2+DusedMqYm
	fgL4H1ayVyxKUb7T+URxMllvgBbRgGAXPz0l1ekaKuGXotEMEgAuYMlkF770ZXzB9j2zqaJBa4a
	S+mTyN7Imm+3mz9kfB5zNLVUZwv3KimoDpiklldYo+lX/yUVepVZeOykqf32Go9lufWg77o6s02
	fjP43fuPf9LT6kMed9WI5R3IRhWTMk/3V/wMgY1BElRGZwxI0MqYClAautAyLjF0GLaDVY8YWlE
	ubxUmvg3KI8NVCse48GDioY14ea7X8Yp4cdK7pHeFyT8kxDZ0ZvO6Q1SrbYuQ8MVWT5c/OU9Xfy
	rTukWooi1h1I480/FfwRU2laieHIt15c/6SAb+DCVk+DxHAoqI6wj6uNIve8M9Sb7DlC3uzQBko
	Y+paGYoYDRpD76Z0vdx4de6PQwPVfmHPF013FSo+BRPRQ==
X-Received: by 2002:a05:6a20:d043:b0:3b4:84c5:45d0 with SMTP id adf61e73a8af0-3b4ccf35b24mr25054339637.27.1781043594737;
        Tue, 09 Jun 2026 15:19:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:54 -0700 (PDT)
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
Subject: [PATCHv3 04/15] dmaengine: fsldma: provide device_release callback
Date: Tue,  9 Jun 2026 15:19:15 -0700
Message-ID: <20260609221926.35538-5-rosenp@gmail.com>
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

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped (see the comment above dma_async_device_register()).

This driver violated that contract: fdev was devm_kzalloc()'d with no
device_release callback.  If a client still held a channel reference
when the driver was unbound, dma_device_release() would eventually
run on freed memory, causing a use-after-free.

Fix by allocating fdev with kzalloc_obj(), adding
fsldma_device_release() to free it, and setting device_release.
fsldma_of_remove() now saves channel pointers and frees IRQs before
calling dma_async_device_unregister(), since fdev may be freed by
the release callback inside that call.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1ba10d065278..43d817f6ded1 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1219,6 +1219,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	kfree(chan);
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev);
+
 static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
@@ -1257,6 +1259,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_config = fsl_dma_device_config;
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
+	fdev->common.device_release = fsldma_device_release;
 	fdev->common.dev = &op->dev;
 
 	fdev->common.src_addr_widths = FSL_DMA_BUSWIDTHS;
@@ -1316,19 +1319,33 @@ static int fsldma_of_probe(struct platform_device *op)
 	return err;
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev)
+{
+	struct fsldma_device *fdev = container_of(dma_dev, struct fsldma_device,
+						  common);
+	kfree(fdev);
+}
+
 static void fsldma_of_remove(struct platform_device *op)
 {
-	struct fsldma_device *fdev;
+	struct fsldma_device *fdev = platform_get_drvdata(op);
+	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	unsigned int i;
 
-	fdev = platform_get_drvdata(op);
-	dma_async_device_unregister(&fdev->common);
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
+		chans[i] = fdev->chan[i];
 
 	fsldma_free_irqs(fdev);
 
+	/*
+	 * fdev may be freed by fsldma_device_release inside this call;
+	 * use saved copies of the channel pointers afterwards.
+	 */
+	dma_async_device_unregister(&fdev->common);
+
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		if (fdev->chan[i])
-			fsl_dma_chan_remove(fdev->chan[i]);
+		if (chans[i])
+			fsl_dma_chan_remove(chans[i]);
 	}
 	irq_dispose_mapping(fdev->irq);
 
-- 
2.54.0


