Return-Path: <linuxppc-dev+bounces-22463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B4CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:54:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJm3rsqz3brC;
	Thu, 11 Jun 2026 13:53:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781150008;
	cv=none; b=HXsm3WNJoGSzyTMWbPiHQGXp4PdUyrtQUXPep6NjMv/q7jurVOm6mi/7eajNVRCVVPPh3q36o8h9QaqMvd0X+wzMbay1WF3mFtyJXj+aI8QrgzQEm7ZEynbUu2L+8ol+3DpSBTUEVyV7VueWcBgAzNRSk+DbWB1umt4GTzmDSk7l5at4YNxESmmAoYN/JyflYxw/txKdY/ncoinyo2MAaGmOgY/T+H0GbmDsvd6GlUHga79+fJ1QLoYdX7+vQiV3AwtuSUwpFKwJCkJf3YXJOGKLr7C61Yy2gbWpbZzNERiuY1C0wJSk+PKFutEV7t4GNjFLvViRjFl9HjNRHK6+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781150008; c=relaxed/relaxed;
	bh=9N+wW4hckA7+pUN5DQbu3VTnKoKBAMqPRZDxheSBFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZAOz4iKaps73nPmRd1TR7W9O4d6xFXZ5nRKlZSts5T+My90e1stpTK8A7toyVVN1oCAXiXLH7wkrtN45MM/XzxTe+AVmFgfxD4mFWCrDI/a3q1GOTUo+la5CcWrfUJi7lcGX629lGpAJtn8JWXq0YYHZbE/4SPMKBPf5EwahNvKz+wGMZCOahs4pg2QJFSOycNsebAqhrmBhBxfT3GxdaHsOtKGTCCp4gTm3bpD7k6koT7JFnZMrOENOLK0FtyehzAuVPAZxqg/1lgAvLd9lNpDpPseyQXz/DQjjNXxzXk/U6HeZ+HqD12ZdXoqC+5m35QCAnKq0gRPrpo1BwJH9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A4ZHENiw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A4ZHENiw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJl6R3Tz3cDR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:27 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-36b9d265355so4594581a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150006; x=1781754806; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N+wW4hckA7+pUN5DQbu3VTnKoKBAMqPRZDxheSBFcw=;
        b=A4ZHENiwF24T5T3zi4gwL4QNQF92410BzAdu3qqXQXtsCYxEXDPXrPpK/mflmjFQEh
         AJy4dgyR4WYEpqI9qPRbKyu+9bDzH56A1XLqY+ShWXXBAnv2EUo73HuhyWSYiOlOBHwK
         tThrE/r3Mzy5oLkPDOHUt8sAtycXBEEkcHfnNZD6t/r8Fyv1BkiJOV3BoxOVJ6vNiEs+
         O+LcrkminSWL8idiKxJjCoIcAD3jnI4XyjMT70MC9HZlHmH3DLbDttSJNWAU/v96v01+
         h8b792cnpEnjTg/koqgQx4jiX4zJA9GGok8cLQeEhqZrXf4b/k2elXMfFbj/rXW1Ad+N
         Cv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150006; x=1781754806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9N+wW4hckA7+pUN5DQbu3VTnKoKBAMqPRZDxheSBFcw=;
        b=XXoVnoeMZUHABH6Y8qoET9HBM4TIgMldrM+pIvo8mQoQ1cX+PhItEVxvhPV4lYES3r
         wJZmHlJ6eQUndvbZRP7Vmfr0fL+L2SlkDw4or6IieJ/eH7oflZoQ3TRyekiEsntYnLZe
         CthLbgBvwdWfhxtUZdEY1WYFwso5nF25BG/Hhh5ZVt7IZBPRwGyCxHHtqiVfczIZpKTb
         1gxrFxobxCs8Hz+F7DTRIeWj1ZuJf09FUAgDclHChEruuhm5aGzeCMhE3qXaYrU1MKda
         7/zN0EqSYKvizq1GulOhAX2JTbUh88pBY7+29DLJT0jebwwo1KVoBpnXz8hcV4v62Yxa
         lwJg==
X-Forwarded-Encrypted: i=1; AFNElJ93QqjeTlT2pJGQbYYPbQkg4gt2SGIYlIGRmIB8vUCoVeJ6bZvPMrEmdy0txgl5ZZjmqctobC/TY2IePNw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIguIABB7D3QYqc7vYQNzNXg9ROosfPzUpZqjoLdN4oFjMchtE
	j6ILr+PCK8kw6u7aaykXREQn+S1G0HRqvOuHI/MQ7j9Vs+w2Mep+r5jt
X-Gm-Gg: Acq92OGr71A4r0rgAOXgEbw66OBqk1ix9LijOj+UgoFCLgO9QIx7fXcFJ+tJ4OeGzT/
	Gz8VPpMovdmN/DXdRqSAJaXhK82zU+kuNsz5HW8CH62NqOPXJdQyf+KUxq3F1zBB5dct/Z21HjK
	t/qUmJ/MRdjJ0RSVCZsyTLMslnGsD56/Di1SXxz0Dq4MoE1N7I52RMAqOC4UgYYf7rX8/By0siH
	zpljHZgYhizijSkYTx237P29P7se+ENyOT16lv+Un8mDdx31OgQchCEItFtTgVJGZBtj88M1DTt
	z9wllUvWGeWtPPJGSJ+J/8WHHHnV8dYtNaX7WVDJh16EpDnE0bR+Ut4k2SQUpB7MGrJfjkE5gzD
	AYrQj6KDvtyFfEWgiSpni6rm3v0VR36e0/EkcPOu5H+xD02OeXWGWXLxwOmbNAoOob8rV9THUGW
	/4qF6l2Nk9NH4deXxpjN9l/M4eoqOiFDrf6rNy/wlvIw+9RlvFvJfq40m7hxblPqadDBiS7JK8Y
	8SbK5w45L+mbd++GgX3DcPaCcx1RBJAf15Rr6hVPt+Rhw==
X-Received: by 2002:a17:90b:1a84:b0:369:f48a:f24b with SMTP id 98e67ed59e1d1-3778ebecbeemr1357925a91.0.1781150005805;
        Wed, 10 Jun 2026 20:53:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:25 -0700 (PDT)
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
Subject: [PATCHv4 15/15] dmaengine: fsldma: fix kernel-doc param names to match function signatures
Date: Wed, 10 Jun 2026 20:52:45 -0700
Message-ID: <20260611035245.13439-16-rosenp@gmail.com>
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

Fix kernel-doc warnings where the documented parameter names
(@chan) no longer match the actual function signatures (@dchan),
and add the missing @cookie and @txstate parameters to
fsl_tx_status.

These are pre-existing mismatches that predate the recent
devm conversion series.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 157db416eaaf..694c1b12bf2b 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -685,7 +685,7 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 
 /**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  *
  * This function will create a dma pool for descriptor allocation.
  *
@@ -742,7 +742,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 /**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
@@ -878,7 +878,7 @@ static int fsl_dma_device_config(struct dma_chan *dchan,
 
 /**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
@@ -891,7 +891,9 @@ static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 
 /**
  * fsl_tx_status - Determine the DMA status
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
+ * @cookie : DMA transaction identifier
+ * @txstate : DMA transaction state
  */
 static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 					dma_cookie_t cookie,
-- 
2.54.0


