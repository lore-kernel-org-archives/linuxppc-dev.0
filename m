Return-Path: <linuxppc-dev+bounces-22461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D5CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJj2b2sz3c5m;
	Thu, 11 Jun 2026 13:53:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150005;
	cv=none; b=N3k6/M96sVFaY3lYgRXgj7iXrDj6RQ+kTw1Ro/z61TXB2lCjZ+7kJAp9s3p4o2Z8X+G0J+Dbxg9TJ5O77cfD5cH8o/+TM1O/4fi2qThSpM6Nl92BEbkQf4JUApVmsYUV68d3Qent+8Q+VzM/BhRRtwsmkRopjKbHCAqap06PKwgE5uj9nPRB+YPknhUiHoHbuj/epFKqHbpK3qqhBt4YJClA4xwB+sFs4QT/1PRVvkPb9wpCBqUxE3O0Hx8JF7TYrRtDOYZUxftc33cNB/zcpvPsggZRVJ/pyWliRcHlLcC/LKsruBjfHKz+nt0a21Gtp/ooaWDolcnOMYHtFd5Rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150005; c=relaxed/relaxed;
	bh=sSyqeaLlyNKBtKqq9I2lY6bL8Oe5QRX1qiD3SyWg9M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHXzrnA5SGRDMVMJjdfnRMQwuTVZouInt7uSpQoYdp0Mnc2BI8PffJ4ePr9hIknxCBd/RHgtZ43rneMPp0HYj96OfPn3pUpOtIXjzOT/ztxIhi/AML/8iAWmbo9HSmE7uoMLTO4mX4sqmW2s1Zb7uFGmSTjiNve3Rnxa6uVSg9wOJrqWqQiRKzfFGvpu72F/HHbzqey7vCSewE8yDuE/HiMpHExkD1l8aQJN1Snh6uQQNFRK8wB1w2lmpuQL75tX3sP7MwVWLRfTPrieyLLQ4MULuAmc8iEmezMOfoIScreS0oOprg2M/jOBhwydqP/A4CNY7jBNV0MBOKiEde4eLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sL+VymnG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sL+VymnG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJh5G85z3c8C
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:24 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7976852a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150003; x=1781754803; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSyqeaLlyNKBtKqq9I2lY6bL8Oe5QRX1qiD3SyWg9M8=;
        b=sL+VymnGPRcfg1tKlGjb//XgWWfiTosUk9NBrqNd4FM3pSDLQK1l0Q/3ca6U/f+T9s
         F9cWbN5HufIGY6EDoTHKCV9xy5rFSUZCurx92K8hjMAClmeJjarLeBdf5N7ewV2A3i4i
         JVP2cc2WR94gMb9PLUrOjRV6zK57m1gWUKmUwEueIXfjLleVrqHUi++WSNrHQJ88kTHV
         wZuCJ3czMEL5gBolDGTgmHAbvRD2WW+eN0WTtf2pR91VG5Im02YX/27S+LYXxbPXmLrr
         w2/+rOPF866/NLZtn3WQJvdpGX/IHQz4nDp0CHXOjNmygeYlI+i+ELJyI83nPhde67c8
         wZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150003; x=1781754803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSyqeaLlyNKBtKqq9I2lY6bL8Oe5QRX1qiD3SyWg9M8=;
        b=E4X8MAX5ChbC7QnVQBLoeV/l20HU0Lgn20nCCBYAJj9AK9WBpvl3+C7Sv0HfzjNh9N
         N6c2gEp83CRZUMXGv5myIEA4jtMMs4aedw6vWg98ZpIankZUvC6+tasSRCELRJhnGMM9
         EAKOneEfddkEyeja8vMaOB5oFQePEK+zEJslSFN38loIjcDlY0MbgnjS1C+DxUvOqL1R
         0553yD5p9lZm8rCIR3nTtkfGv5MFAjpvZRnU0UXNgfYG86Pd8hIUXuxZFqYhZS0StNKe
         zhGGoz85oFWioYZ+QzJhZlufuggFeFDXyXLX0ie/VLnk3BF5Ztn0xDv6c8fwPIo3VW7Z
         KqlA==
X-Forwarded-Encrypted: i=1; AFNElJ9m8AUg4eogIIZQAvEi1CDOy6CGa4OpjqMBj6h8uuoLREx15kpDinEr1SaIJL6+z25qnNNJ36ZCMGesEP4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsVtQyoVFSpo21Lhp+0Hox5iCavMBHzVa5w7Tmu3arunVNOL8j
	qMSIacP6dZQBBrAulm7EFHzFxTtQCEdqyJnCyPOAncsQKr+cS2OBs+3z
X-Gm-Gg: Acq92OHz2pLlytZGC6y83uLJYdB9NoK4EAqExV61x2nPS/VuZZYQYwAsTmDQaL/1o8A
	Ve3frud8lV0XGg0Rpaua4XHE6ZdwF/w/0nkFwrDSjbw2Wwxibm0zYK1XHGbRwG19pnCFrtduCb4
	fNaNBVQQRdppRSWozZSpLZsevf+Emx4jwuK5V9ZKpzCd6SFufyhvjBAL7FaWiQ0nLFOdJnAZcPw
	KFwa10EANOHMzYfwOh2KYPRdB7zSxLXPospYkLWv0D0NC2IE8k5V3UGWgLOmZW9CIoOK0mKgIvu
	tuAFv/T/0+pa/N20y6zKibLMdrqgWqhvV3QSY6H8P82Arm1NsiA/ZbK2qIvppvJs6sTSDab0Als
	JodaGP+CSDsRALCSvPE3Ltf1GRWTKfvi2JCH9pJd1nAxBRkH0ifK56r/2O8rtaxH9XtD4PMrDYX
	VuP1FBB+l1GgjrUMY8Z1/5ChtF7nhlFwCHTdtWHJod+zGv1nDrVhEbOTEMNibZVMDJftgnZQgxS
	gRHyE0yS3mjfAp4oCzsSvwhCOpEdPGAOUU/fTquAJkZPw==
X-Received: by 2002:a17:90b:4acb:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-377a73e2750mr1300085a91.16.1781150002966;
        Wed, 10 Jun 2026 20:53:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:22 -0700 (PDT)
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
Subject: [PATCHv4 13/15] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Wed, 10 Jun 2026 20:52:43 -0700
Message-ID: <20260611035245.13439-14-rosenp@gmail.com>
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
index dc70a6bf5723..0ee3d719ae95 100644
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
@@ -1178,7 +1184,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


