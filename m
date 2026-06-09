Return-Path: <linuxppc-dev+bounces-22367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE0CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyj1Cl0z3c54;
	Wed, 10 Jun 2026 08:20:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043613;
	cv=none; b=Iqg/q8S3ldK/TvLqNihdITT2AU1NEFChZ4kOUhAHVhfPPLQ/kvclKdVp1TZYCYxzURw+ezCk0XxxSmd5bfXbzNbdqE9Rh1IAmaSfya+32oSdJmwdc9B1K3oPXUNfpn8pPuSCEcoos/7x1k+776ts5fTVID8z5Oa1whRHI3ZIVeBjvRWNThfov1d6sa+1Afet9jjQRA8cdFWWd48ofNYQfaQ9ezA3QFArsVVLccZIAjm0OL/4nn9mH5NUH3iGVbunezqcTABDGxSrhZW8Z/zMB4QSSdhufmW3nnVV+gMGTIhbqYbcKj8cmC+S5qeYZk+ta7Yf6bXyfwP2bHKFAIPktg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043613; c=relaxed/relaxed;
	bh=SpnKWjXftKVnMmEr+XvL/qwRK2/ShAzH1rSpA9h79n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABdHF6osuIcYf4/n9CGYQFhk4JeJMCdfGW56j74opS8rAV/ZZhorUMqpPsNZA7u6GMKpP4TpE2okg42ELJBhMkAPXh4zzcMVjjsh0VDKEBtZ1NXZ6kFq1OmIPRGSbzrAg6CHJ6pDQjAovlixs8n8u3aqbzdwutUD20T594gitgvpoJ2usIgghBT3w64B3GdVyGufXz6x6gzYUsRXD11Gaj///rBrlnfIn7JvEh7t4YQZfH9POUXQ1+8/HooiSpE/OM6cauJavEnxbN6RAF/YyFBT4xF5MFlXOHkZ36grOZheURV9w7uHsw4BO95eJtEzlK/fXqGzSglHe2BOzL8Utw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VWLiHhtb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VWLiHhtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyh32wHz3c7R
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:12 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c8629bed4e7so2117148a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043611; x=1781648411; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpnKWjXftKVnMmEr+XvL/qwRK2/ShAzH1rSpA9h79n8=;
        b=VWLiHhtbcfiusOczVq2QmNg7mYlTbTffoeDqis1PCG/pGlsrG0vJa44MQMZ8G+Rnsq
         fG/CU9tvn+I8NEfNiqbdiHAExb8qAjdELK4tSkq5SDBCzyUD0ju5pe8+wG7Ft8BzN0te
         zoz9Or4hWlZJhTITBUSMRlc8SHN3YWuNJfrjM2BYcx88ANIzH8+ro8UJwXmjBQ8YI+Tf
         Sp5Gf2jcGr8bIWd5dfH8FlrFO0czSmO7p3QwhLJnLr9JwMeLtaIvsC7Hs7Yqef7cxfK0
         LwxcN/oJf1wcVSH0JVfwL5n50wgJqNQcMmbR5soyBqexvM8qJlenD34B7XohK+1GygOJ
         D9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043611; x=1781648411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpnKWjXftKVnMmEr+XvL/qwRK2/ShAzH1rSpA9h79n8=;
        b=B8YRD+z/M0gbZgJfCg6qc6hXGYMoNdxEIXmeyCvE8WwrhR6B7H7CtHMtoTltjqbYzG
         /oC/EbmGtJIyLb1aCdZSABgSVUAwT/Wwtgwe2/p6bEIsdQ4ioyzQMikXCX7jnHhMUH00
         b2lmySlJKQVloAWTSrSRg5ma2smW+/Tl9w+/qREjQyDQhD56P9ZYtcyx4fkYgbECnFCw
         Oo8hM77wPOk3wRl4ooqIuH28adLNwhmBToX+MLdxAwFpclmcbEKQvM9JGMWCjAzQQbJ3
         5MA/i+92qzm+mfGhzom19VeIkhQW/pbduY7dJC+Xu+QQutp+s6R/lVZ8+VLrkhiaGXeX
         +noQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CFxFooO3ZGXoi7LTLivqA1XaR/f/oLlvTk1HknO75VJZowUsegSDe0yek1h+BzQj7zSJgdjf8hpFgv6M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyaZX0V4LHXj8ODbfVsQziiMFnBJ6JyHu7tLc5FEwhr/lXaKd0U
	cdZjjqy1o8J2SJAa5o3uidPqEQhKWpa/6Ef5kdehGtCA8Ua/fqTaoAPA
X-Gm-Gg: Acq92OES6p0OBMWqB7dscXEVzfETSe3OJ2aVFhwQlGXSreCx30tgiK/cK3Uv953loVB
	h7LuVwQpBxTHAKIAyQGFHeB0fnZbdq/oxlO5ZolDZuRlU+EMzzdhAOAUQU+QT53MxwmlKgQd8p0
	vVlicecsjZ/sQR2YInOPLMOyH40FBWio05IC+NM3PhujwQwgX60Xb83ldizD0S+W7N7vxSEy0VQ
	o27eLEdKUadou7yzhzYegXZqxvHmtuTr1Rko3MEMn+/pa7TaSKUa2bqIDbNBoi7uKFzUs0bj1ht
	AgUU6Va3+BWrx05EBVuDJrO91tgYwng9OubxyOMrAK6NWYp8s9+LY7eCvpAV08WeUzIkbCqX/b1
	amCgYGI3ZgssCnTFM5OTZNTUWjrCEp1LXqEr2EkDduqEEZG5C6ZqPhl1bxx5PzhGV5v8fTG8dR/
	ziyK7oqvlwbGpM4R7m6fgNsJ6CFhza6F2RuxQleLIEDGTQESPHJtrUSiURBEmlPyY7MEuJPCJZ6
	1K4AhVcOGmfr58xsMKinK0c+KY3N6OriJKWi4WzsPUUFQ==
X-Received: by 2002:a05:6a21:62c8:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3b4ccd45993mr24628603637.12.1781043610661;
        Tue, 09 Jun 2026 15:20:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:10 -0700 (PDT)
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
Subject: [PATCHv3 13/15] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Tue,  9 Jun 2026 15:19:24 -0700
Message-ID: <20260609221926.35538-14-rosenp@gmail.com>
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

Use of_irq_get() which returns a negative error code on failure
instead of silently returning 0. Split the IRQ validation check
in fsldma_request_irqs to handle three cases:

  - chan->irq < 0: propagate the error (e.g. -EPROBE_DEFER)
  - chan->irq == 0: IRQ not found, return -ENODEV
  - chan->irq > 0: valid IRQ, proceed

The fsldma_free_irqs() function's !chan->irq check is unchanged
since both 0 and negative values mean no IRQ to free.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index a3792864f02a..7d0c80121aa4 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1070,6 +1070,12 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
+		if (chan->irq < 0) {
+			if (chan->irq != -EPROBE_DEFER)
+				chan_err(chan, "interrupts property missing in device tree\n");
+			ret = chan->irq;
+			goto out_unwind;
+		}
 		if (!chan->irq) {
 			chan_err(chan, "interrupts property missing in device tree\n");
 			ret = -ENODEV;
@@ -1093,7 +1099,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq)
+		if (chan->irq <= 0)
 			continue;
 
 		free_irq(chan->irq, chan);
@@ -1181,7 +1187,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


