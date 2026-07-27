Return-Path: <linuxppc-dev+bounces-24911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01370C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 20:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h89Gx69bfz2ygh;
	Tue, 28 Jul 2026 06:31:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785184281;
	cv=none; b=ah73fYiuYsob7/ytxrQo7cd9cgApdcrGSTKNM4tGHMy8XQ2a3g12UA0Gr2ghZSkZ7uCFvJALAzN9V343LRpc/PP3lfslJkBFEn5oevX0Xj0t3orH222ffjbF3DdHg4NqEqyz1onPRfVWzgGLkHbz+jFBx1KomDBY/mMm7Ibtr3cxJ1tDfdlacEaTMxp7NtD16wbgdntUaLPbaq0ieOoP/ENTR1Pjzy4MGdWcWTNqDVgDbA7uhAqBqUv8OJCToeqRyJ1OLHLLPs/1CQHcM7XmDkUSsd3NJooup/6wHx9PtTDPcbFD+LJxrPfzZe48UipvMxSqAvOX0jRtPgivpAsTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785184281; c=relaxed/relaxed;
	bh=DQRhM3rT7FoTMhNOjiuobMB557pHWoxuWR/j4jNacaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTJb+KN5hRtFFIJEOf4ZBrHOivtYvh61o7gBpz4YAFLx0kv/E9fHvZwKuGUVAeGyoeH/m59T/WwWKL+DXGilyq5KbiCYZW66BNZuNpBkRG9By95WINmFodNHUHm2ytDhULbdrTGBMFyos2lZOWoFadWan9H6psh/BaQcwy48HtOpRggjOhxLa+lKAasra+bEdRd1dyXWdC8OL8R+rlGIwv/8KQwC5CaTSA/orLAkxkeBnRA67IK1driDqZJIeUjzZMgg+saygeD8Ma278C654XnmiSz2FssKBXLzUDXl9pdaikl6J4PKeWOr9rvmeTZRdpctw/RcU9W9MWj3bfkWPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sDwyB3TU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sDwyB3TU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h89Gw1c3wz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 06:31:19 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso35146725ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785184276; x=1785789076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQRhM3rT7FoTMhNOjiuobMB557pHWoxuWR/j4jNacaU=;
        b=sDwyB3TUlMrJ0Rdx2bvK4bWj5tWnKdM/puEg8nmFgaOtMsceSpi7C5hiX+BoUbpoWa
         b9YyyLmo9O/Atv9HkAxQukjfvW5t3DoDcXXilO7Y33N9Ypd21rXonuhoqszH7LOhUpLd
         R8leIsDr20NxAcOLVElkAkE1FackNcsBs8QJqZanfTP9uScK6WsFEwiWrDniqeC610rz
         g5mI+M54D/vQNzttSw/PAmeaRELiA+ESI2NIhXZH6UINDku9HE7xqxWGH3NSE0Qcah32
         isQuBQhc7A8kaO4XukMIemk987YgW420Xl+OdO8YUHLrJppiv8r+4c/fOSssXukrffmj
         kkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184276; x=1785789076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQRhM3rT7FoTMhNOjiuobMB557pHWoxuWR/j4jNacaU=;
        b=True7xECCOUmCSRDr0egEdpzfILg105Svcryv3ptCM8g3G0SxH8zKjI7cUyerFZN7C
         Eo8xFXOJY6PofVXRiUr8d6wjCwT5/fDnHKZTFH0OWw0Ww1qdcWGZHJSPKAONCCJFyI1Q
         FtjZ+ef9b4wctUGaWejZ2/yRX1ajk92uTGN5BmkbQgvr6kSjpX1bQiKilC6Rxu9d1c7m
         mqJL6NQhsn07bJlwSRCUUoOKeer7KsRkoufILg/4xhmER+haTXcNvlBD5tZ/im4k9pxa
         jTT27tx72+IWMTd0+bRWB2y1q/qUWdFRnjRjyHFgtzLYDVCnGhCkq1bl9bc+0WOiSK1J
         pG0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp5ch5JTyz4/QQCufzAjP5BiExhAdXrFONvV9gmZd4K5ro0BkjTJGXDakR2oIhx9C75OSgFZ7cUa7p2wcI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZ4Rq/GWJPnkiLfhVzTLukQq468+TYvAwf2pZY+L3j6RAQwa5C
	hAFmOtB0eDim1gaJGzyXWakVrTXB9YH97ac5Oin/amgDaxJX8SP/5dVh
X-Gm-Gg: AR+sD13cial3LPfusmMWiEcWVJaN6VMIDwRmjYa6LDm4QiNIx1IyQJoY2o45atPA9Ur
	UUqv4J+nItvGJxQ0At0b4+gQJm3APjaQ+sCsZOFpRPUXBexeHGCuTpmdnyFe05+DAdkEI4KO3Jh
	aYVihZeYUrboOKh3koWFnyid3VTBhKEKnGHoSUhmtrRYyXwVkpPzGBMsvSL9GbBZQlmtlqNnOti
	7QoIb2wI+nAhnkUe0RO/1Dg4ygY+/xD3Hsa3MgdLeevaIdLvNBq+CTFYQDdSim63X9U/BLLi1dp
	XBPMhyT041hZA3tV9Wk5NTEoouOCeMMsDZxSE6FAXAQ5zbb1YhVd3j7g99u3jkA8Nf+9Z+C7AqT
	uwKJLEl5b+bi5IUeUmA8/pPjWNp3pzvuLV8FtEynp5VcsIiiIfbaMhNHXwMYU7AhHdIgJHYN2Mr
	v2BuqY
X-Received: by 2002:a17:903:234e:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2cfde683786mr92287575ad.2.1785184275736;
        Mon, 27 Jul 2026 13:31:15 -0700 (PDT)
Received: from cryptic.lan ([2001:569:7fab:e200:3789:64f9:8855:c0af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59b768sm41551805ad.4.2026.07.27.13.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:31:12 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Allen Pais <allen.lkml@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/64] dmaengine: fsldma: migrate tasklet to dma_chan BH
Date: Mon, 27 Jul 2026 13:28:34 -0700
Message-ID: <8a4883ce4557e4cc5804b9d29ee56e6a2570af6b.1785183549.git.allen.lkml@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785183549.git.allen.lkml@gmail.com>
References: <20260108080332.2341725-1-allen.lkml@gmail.com> <cover.1785183549.git.allen.lkml@gmail.com>
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

Replace the per-channel tasklet with the shared dma_chan BH helper.
The handler continues to run in softirq context while dmaengine owns
the common scheduling and teardown mechanism.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/fsldma.c | 10 +++++-----
 drivers/dma/fsldma.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..1cb6ce327078 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -968,18 +968,18 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		chan_err(chan, "irq: unhandled sr 0x%08x\n", stat);
 
 	/*
-	 * Schedule the tasklet to handle all cleanup of the current
+	 * Queue the BH worker to handle all cleanup of the current
 	 * transaction. It will start a new transaction if there is
 	 * one pending.
 	 */
-	tasklet_schedule(&chan->tasklet);
+	dma_chan_schedule_bh(&chan->common);
 	chan_dbg(chan, "irq: Exit\n");
 	return IRQ_HANDLED;
 }
 
-static void dma_do_tasklet(struct tasklet_struct *t)
+static void dma_do_tasklet(struct dma_chan *c)
 {
-	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct fsldma_chan *chan = to_fsl_chan(c);
 
 	chan_dbg(chan, "tasklet entry\n");
 
@@ -1152,7 +1152,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_setup(&chan->tasklet, dma_do_tasklet);
+	dma_chan_init_bh(&chan->common, dma_do_tasklet);
 	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
 
 	/* Initialize the channel */
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index d7b7a3138b85..cab33d010d51 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -173,7 +173,6 @@ struct fsldma_chan {
 	struct device *dev;		/* Channel device */
 	int irq;			/* Channel IRQ */
 	int id;				/* Raw id of this channel */
-	struct tasklet_struct tasklet;
 	u32 feature;
 	bool idle;			/* DMA controller is idle */
 #ifdef CONFIG_PM
-- 
2.43.0


