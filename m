Return-Path: <linuxppc-dev+bounces-22450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8D5CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJQ2gGKz2yv2;
	Thu, 11 Jun 2026 13:53:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149990;
	cv=none; b=Vplb6KwWPh1b2VeayFV17pPdBiJjfhC4MxpMZWimTnk8fkIS7NThOMSBoVwPTfTeCKoTPUEeN9sF2lHSEaZ5ZMuYBumXT2g99BK7G/chIuncCLqiMykxGbIIgNGEa7DUvShpF4XfLqNqeLLokkr6ZY7ht6g7K1bAMB8jOffIZFud6attAWNymhrmsBosUJ/YpoBFZJSOoGEI9vHnYiDxRgDme7brn2hp+B3m++qt5yjKKByBBnk1LW+SVl4qlBSbEXXNDQL/HUnSINyrXSBCSuTZFsr0u6mg9TBdPOnjZt0lx6cbgpK9UGa8VtyThNR4jUU3FFsrxShPO/vmUK9Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149990; c=relaxed/relaxed;
	bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMbOTMYe+XS1ogxiT++NTqc4kfqB+fADNoQUh7F8dFidGIMw3cM0D+4lpr3TpGOMcqM2OxYaa/CiXrXQ6RGqyfx5+8eOYtiQaK/ZgJjzC+QnzpX6YmXPZFnuqKm5CXzL3Jnda+q3yYdsVXUpXPS1PVeoPxOk38bdMIgatzFuHpAMtQmFuOCe5AqNyR1lyVkfWHVGwVhta6qnB21bBO6AJM/ga0FQO0da7t6vmw3fb984dvWHLtGEGQt8gMk3VxdacES/1kZAa4vbD7KzzlGX4/Ma0bWK9xOk1z65HqisIUvIg/xTXmlCT2dsHv8aSjGZLPSLWXyx1F0uJPWkAZq8xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ge5oMbSx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ge5oMbSx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJP1tt9z3brt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:09 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so4008092a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149987; x=1781754787; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=ge5oMbSxcteJSukhKuqNZkWuCZp5NGMerHgGpSiw23zXfrgbL0BO7jNsVnT6vfOU49
         oQhGF42K8EKaeIk6Rfcw6Uh0zT1ZKhTmPqErZcOu/IE5QF1acZKKDTZhX6cQW66wZ88Z
         IGrPysHG0W+xJRd4BZ/RVtD9vDqc6ct0hD/yWXlqko87/r7VOYXy2MXsDL4jxIhL485B
         6FXU3/w3J52MUL/6AWIneJPS0FE5HP0NbbUSwFPF5gpD3yrXjYMH0i4PEW8y07Hbvy0o
         X9BSd4M5trCVr7qe0MfJAdM5gQuOJw4/fEBQlqvy6g6oUrsSA8ljwEolR6mb408Cp3gC
         QQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149987; x=1781754787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=hdg5qBivU7ZbdkkUB1MSrIZ2odzz4XF0QAV0GlxbpWuOEUSQlg55n6yTcbColQPHU4
         YI7ij6ZXW4eFI2Qf4ElNvxgxfD2iJqevBIvzQ1O1Kzv2MxSSE+TwrFzWehW7qPXz34pq
         j1vUwZw2PZV7ZD2nqSqYnIproGrdvNNmwvs1EFTvTosvrOaNfoMD/IKvcZ/OA8SqF6z3
         ju54HbEK24KMNrZ06GR5YJWQTWDgQEqlK+y3kApGbVVvpVakkavZb4pe9O5Bz+iKvOxb
         YlYhWGWwRHuckZjvoHen8FcBNvjv2BUulVrHmBqWWMD/R/H5CVtKvJn8nUzcXa4DN+H4
         Hxew==
X-Forwarded-Encrypted: i=1; AFNElJ/Rnvr5C8ekQOD6orZ2vJHWB76IpSOBVPxosAZfKWb4YAwSSEzEgvg60pUkbBhPCdc1NpVrCTEfDw8O5GU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywxerpj3LBl7hZsTQUBYboszW3dv6og2ioIbGnFbu/PluHVC5U8
	vis01YKvDaBc9K0W6quoHpfQLZh41lxiJ7i0mZBEI2OTagIZdgaenDwS
X-Gm-Gg: Acq92OFxbCfOP/1euSXVUF/EXJ19VH+okpC50MCSfGFsnoJIgJRQuoIrg2nRmSYp30v
	Hq3KXWlgrbdrBOAIm7A0piiohikxlUDC90Hja8ulrPJx/2+TVMQFTFir/JpIm3Me6JktpJyKi0U
	HKXKHLcFyx6oSC805W2tpnWiFrJxRPcXVeI8OUZPEs7leyn1bFe7eg9JRW5LQErIho4GPeYr+S9
	Fxv6rRuQycgfAMci/hXAuq5vDxdejEzGux/PGQiBGKeIkQRao+xz3IkeYzfojJ1OZuSW3lSaq32
	taFixdfBkXNDd2jMd+qgOEB4cJ2KBKXUVgoHgMPgGAhl91xK84IqngpI2j9DC2HY/xhWtg09oQc
	+jhSGAuYGX/PjPK37IyLgnVTAYzEAQLNTfdxpd2Ki5eVYkwPHiYSLzqDufDYqAk3mpmz8yv7Ai/
	jHOhYx4aDtX5Gb3Kj1Z+hyBZ9tbKLoRsXZ1k04uctV5Iiy5zCr4tdadyd/80uh6y3OdsT4oOT2T
	Iiyrn+kM0DbIR5VdboMuqv12xVfFpEUZ2kvXMo/fvu1NA==
X-Received: by 2002:a17:90b:4984:b0:36c:e254:4d5 with SMTP id 98e67ed59e1d1-3779c569455mr1233425a91.4.1781149987152;
        Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:06 -0700 (PDT)
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
Subject: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before invoking client callback
Date: Wed, 10 Jun 2026 20:52:32 -0700
Message-ID: <20260611035245.13439-3-rosenp@gmail.com>
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

fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invoke()
while still holding chan->desc_lock.  If the client submits a new
transaction from their completion callback, fsl_dma_tx_submit()
tries to acquire the same non-recursive spinlock, causing a
self-deadlock.

Fix by extracting the callback info under the lock, removing the
descriptor from ld_running, dropping the lock, then invoking the
callback and running dependencies outside the lock.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 108 ++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0e2f84862261..455d21d738de 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -496,16 +496,19 @@ static void fsldma_clean_completed_descriptor(struct fsldma_chan *chan)
 }
 
 /**
- * fsldma_run_tx_complete_actions - cleanup a single link descriptor
+ * fsldma_run_tx_complete_actions - unmap and extract callback from a descriptor
  * @chan: Freescale DMA channel
- * @desc: descriptor to cleanup and free
+ * @desc: descriptor to process
  * @cookie: Freescale DMA transaction identifier
+ * @cb: returned callback information
  *
- * This function is used on a descriptor which has been executed by the DMA
- * controller. It will run any callbacks, submit any dependencies.
+ * Unmap the descriptor if it has been submitted and extract its callback
+ * into @cb.  The caller must invoke the callback and run dependencies
+ * after releasing chan->desc_lock.
  */
 static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
-		struct fsl_desc_sw *desc, dma_cookie_t cookie)
+		struct fsl_desc_sw *desc, dma_cookie_t cookie,
+		struct dmaengine_desc_callback *cb)
 {
 	struct dma_async_tx_descriptor *txd = &desc->async_tx;
 	dma_cookie_t ret = cookie;
@@ -514,49 +517,14 @@ static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
 
 	if (txd->cookie > 0) {
 		ret = txd->cookie;
-
 		dma_descriptor_unmap(txd);
-		/* Run the link descriptor callback function */
-		dmaengine_desc_get_callback_invoke(txd, NULL);
 	}
 
-	/* Run any dependencies */
-	dma_run_dependencies(txd);
+	dmaengine_desc_get_callback(txd, cb);
 
 	return ret;
 }
 
-/**
- * fsldma_clean_running_descriptor - move the completed descriptor from
- * ld_running to ld_completed
- * @chan: Freescale DMA channel
- * @desc: the descriptor which is completed
- *
- * Free the descriptor directly if acked by async_tx api, or move it to
- * queue ld_completed.
- */
-static void fsldma_clean_running_descriptor(struct fsldma_chan *chan,
-		struct fsl_desc_sw *desc)
-{
-	/* Remove from the list of transactions */
-	list_del(&desc->node);
-
-	/*
-	 * the client is allowed to attach dependent operations
-	 * until 'ack' is set
-	 */
-	if (!async_tx_test_ack(&desc->async_tx)) {
-		/*
-		 * Move this descriptor to the list of descriptors which is
-		 * completed, but still awaiting the 'ack' bit to be set.
-		 */
-		list_add_tail(&desc->node, &chan->ld_completed);
-		return;
-	}
-
-	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-}
-
 /**
  * fsl_chan_xfer_ld_queue - transfer any pending transactions
  * @chan : Freescale DMA channel
@@ -635,22 +603,23 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
  */
 static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 {
-	struct fsl_desc_sw *desc, *_desc;
+	struct fsl_desc_sw *desc;
 	dma_cookie_t cookie = 0;
 	dma_addr_t curr_phys = get_cdar(chan);
 	int seen_current = 0;
 
 	fsldma_clean_completed_descriptor(chan);
 
-	/* Run the callback for each descriptor, in order */
-	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
-		/*
-		 * do not advance past the current descriptor loaded into the
-		 * hardware channel, subsequent descriptors are either in
-		 * process or have not been submitted
-		 */
-		if (seen_current)
-			break;
+	/*
+	 * Take descriptors one at a time from the front of the running
+	 * queue.  We re-read the list each iteration so that we don't
+	 * chase a stale next pointer across the lock-drop below.
+	 */
+	while (!seen_current && !list_empty(&chan->ld_running)) {
+		struct dmaengine_desc_callback cb;
+
+		desc = list_first_entry(&chan->ld_running,
+					struct fsl_desc_sw, node);
 
 		/*
 		 * stop the search if we reach the current descriptor and the
@@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 				break;
 		}
 
-		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie);
+		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie, &cb);
 
-		fsldma_clean_running_descriptor(chan, desc);
+		/*
+		 * Remove from the running list before dropping the lock so
+		 * that terminate_all cannot free this descriptor while we
+		 * call into the client below.
+		 */
+		list_del(&desc->node);
+
+		/*
+		 * Prevent dma_run_dependencies() from calling
+		 * fsl_chan_xfer_ld_queue() while we are not holding the
+		 * lock.  That would splice pending descriptors into
+		 * ld_running before they have been completed by hardware.
+		 * fsl_chan_xfer_ld_queue at the end of this function will
+		 * re-evaluate the situation.
+		 */
+		chan->idle = false;
+
+		/*
+		 * Drop the lock before invoking the client callback, since
+		 * the DMAengine API explicitly allows clients to submit new
+		 * transactions from their completion callback.  Otherwise
+		 * we self-deadlock on chan->desc_lock.
+		 */
+		spin_unlock(&chan->desc_lock);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+		dma_run_dependencies(&desc->async_tx);
+		spin_lock(&chan->desc_lock);
+
+		chan->idle = true;
+
+		if (!async_tx_test_ack(&desc->async_tx))
+			list_add_tail(&desc->node, &chan->ld_completed);
+		else
+			dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 
 	/*
-- 
2.54.0


