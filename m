Return-Path: <linuxppc-dev+bounces-22356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22626CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:20:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyL35QZz2ykX;
	Wed, 10 Jun 2026 08:19:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043594;
	cv=none; b=kXnZyvu6msQer8nzBKZbfGHcFVnutC5My3DUEWtXbWA1EyXZHhkfg0ZItxZYfOZ2gL28UF+BIm1umH/6tN0HCLkXUVIBYJxxPy0M06nNTqNdlX7XyjH9rpwPFICiYopi7l0i45M0U4wfEOJYEBuTls7IzI/YZZd5ng3GMtsskAm3oBiUgsmbYKMWHdcmozCPLAUWYCfQqA9mXvdfL9w4EUL8UoXqG9C7jSIthcUybbRsj4pd5nSgBK5ahKg7neiTWs9lfNJShueW054gzA+QJIx81djZIClVc6NuyntsveZTUW4OhybP/oAMbbX8ygNfJCJnyQMV0X/9gVSWKH5DeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043594; c=relaxed/relaxed;
	bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPJNhvMfsaoAHvlEVAhQNMSVpEeDLt+2XuCsByK+aDDIAWXq7H6QPAuv36Vhp9QK8W7GBK90qbYVHXWFAPHm94r/RwpBai79TW81uCFy2ggOOhaRmHKeg2chVImaakgRgr97K3AqjRPRP4xw9hqkUP9DeYnWZtHuAq6zeb6QiaGqQStthEdfsGMjdpWZMbg5lJOuJuHVMU8AnC93XCLFEyzw4nS9ngvhiUiGIby5Y1BG1tmsLY3FgoPBwytY9tY0+D2GfTvwmwVFAx1eGYIJg3cvLJO14iuQC2fXINSgsckqJEMD5ZNrHildkMkPlB00fnsKm8bcLggouORqimUVMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Znu4Wjg4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Znu4Wjg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyJ3jqxz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:52 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so3589618a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043590; x=1781648390; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=Znu4Wjg4it+s75YbKsmPy0ZggejsXYkT33d6l3Y7D8EXT9NGvV33zQCRZz9TmTjnlE
         W+YJVrjDNJyTQGwIEv8f7WpwG7TszSy67CYAPullMpTO5mibm3mLeZqgDNIjS0OhsKRM
         rAroNW09EUrrgZwGCTV3FmDa1zpQIRQF2PRe9XGUfLLva0NlMGnDYFBdP++2LIu2+4tv
         dv0a1RboRoBtA/B+JbgQ5cnANOnZ1JTE1hq2Z+Md7UU2mvThI7L+bE5RBwWw/r1pMT9A
         Ue2n/1evAtgBMJ/GmAsYOyQFeHw099DJWNobyH3Yax28ud6XPaBYx9v8+/iG/Xckn+rJ
         upug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043590; x=1781648390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=Mjw25naSd9Tfeewm4IEXv7f+XP/k0Yn2NgcGH2Z7KMqUNxKukKwSa0iiz/Sm36VM3y
         0AbC1OiVhR6SXBtr0Ig4qmjkuJ3oe9fry7K/75ApeLFdYG4zFY/R437D/EPBTPFXfGs6
         ArAHy13q5TXCG/4z5qXdYpDDxUExfUcBz68IxRYMqbUJu5Bbg7yNE6f5bSLwz4eaL6NT
         quwONnMzd5yp0HOgAYb4Wp39ML0iZQS8v9QcjSLtVIAJo4YoUAumDFv7i/T6bMnRiznq
         8M4r3JGpVOcuipfbiTvlWjCTwscth6irHqh8MtAVmrj2gBLhccV5+EKSNdOGCAFx4XjK
         DA8g==
X-Forwarded-Encrypted: i=1; AFNElJ8cdw/WR5zAjHfS0NYVNqTyKJ9NaYoKK5rysSup9ZZ2eQ9mWTBgu7Fzx1tMfe0Qdr3fa/q1EYY53kddTvQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxfvb1OPI7hNCsMlivjWg8wCqgtyZevdZMX2//i6+v0XM0lMV/H
	AC5nCf0OTDhxBUJP/mF5xUWE4+pROPFIGGCc3nBoRWOWM1DOQFaK+EoA
X-Gm-Gg: Acq92OHufLjsSW3HiFsgZnENHdsFqU9stQMNQhETq6SZut9aCwamWT29D9TpF5KGC4M
	UThbnsyhwU2yPhbMd3HyHxPxNlMKQFGlowmDJdFe7vLiQRtFjw9btYSm3G0BbidjwzwgmuIcmUE
	NA7fJQ6ccwKbs253OKTWHrPeEPRdm13f58moMNchaxwCk9jgncCmh2r9C39Ab56itR2zyTpY6Tn
	z3S6KDL91pk55+4Omql7bJ0qXcjpcAa8ux8ANA8uyuVFipwSLYPeqwPCTAdvCrmglLxyGzGGtNR
	Wgrb0ecZ8P9KGbnouqdiwtgTdrxZftrHnKY/EttFkEXG+uzAF/+v8yBMzrabF8pp6IhMSHg82v9
	GbGoxICpHbhe/P79v6fSAjLybfwIlA+PmC/QtxNyFv7dz0MzbznVO0lilCNnrH4+tqc73sIXwGm
	dS9T61+bZQaI4IPK0VdO1ZWdjXWc8u+RwkelfYAkJdlgTFKiipH2MY0f4ol37YBR9h1Vx2K1yEE
	9MNv3u9SNclKPgGTvxRMPcrrXAIirpkUocUaNqa1uhqng==
X-Received: by 2002:a05:6a20:1609:b0:39f:3ca8:a33b with SMTP id adf61e73a8af0-3b4ccd764e8mr27610402637.17.1781043590415;
        Tue, 09 Jun 2026 15:19:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:49 -0700 (PDT)
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
Subject: [PATCHv3 02/15] dmaengine: fsldma: drop desc_lock before invoking client callback
Date: Tue,  9 Jun 2026 15:19:13 -0700
Message-ID: <20260609221926.35538-3-rosenp@gmail.com>
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


