Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7260A263B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3TpTs3v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP6bh3Zrcz3bt2;
	Wed, 11 Nov 2026 00:16:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794316560;
	cv=none; b=TZ1L29QNZ1ofrsIYKPhplcwjpzB0XmAHkBo84umEdx4O8DI6WJscHmv//FqkgtqGxCVh6mD8CHPo4fXKQskPNxKvJR4kkG/qtRuPLRQFDkocrqiTiG9TNVHGCcJHIzs/8+ueMwy9lsduSb2W+l7vLj+xCm4/+vVqQGYuihu6ngBPhiPajulu2NvoUZNNwJRRIZ8nhk4PQSjWQh3t6TtGnPRvXExV9DyP+Wc/+kgNgpGlMTegDKSMBgnAk8kM2OMWPNN7mDy8S9dQgCwYGGJo35KuAIlc7OeNHmGdbxFH0YVRfIC6fau9hnLuNKUg+2VF6l+TamukbRZEOqoXuuJ+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794316560; c=relaxed/relaxed;
	bh=5J6MwDWOHWjl7QywHmcoK9CGF6kb9+LR3zZN5cslCcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8ZfAbkmYJpe6II8cd1HMpByZWUGYfssnqlSBq0l4O1Lr0BYWkbyBzOn1Z/MK396qtK2KUey8Ia/3CuahhoA2a/stp+fh5ljDHMgdJSqiRopuQMzUtSkTiFFb1CEshCRtriuEHH/kxSfRlkXMduYRHD8+KaOhTVdJ3ExgwvJshd3xlGsm9hUhdd+XsA9pjfPlYVm99q/FIrxCu38bdhFtTNof+xVdzQA2OQj8uzINb/wZulmVyVQUBUjF/I0O1pMgXaIpuKQX5ZP4FuNbLuwL2PfWUE3KJpww6WvKS5nNVCxqbe3xqpUtxp6WzWK73o4gyEi9O+dyBZjZDAShSYlSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3TpTs3v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3TpTs3v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP6bg2l6Kz3brv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 00:15:58 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso988812a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316556; x=1794921356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5J6MwDWOHWjl7QywHmcoK9CGF6kb9+LR3zZN5cslCcw=;
        b=j3TpTs3v/Dl7KrsoNHRv08WjhimEFK/KTEl8YNc+UGfGe07JySWhq4/Ak4weIOcPfT
         OlcnL7fWZC7JD1qP9uKasWXaht1GIGNG2++ad6rjTOycZlKm1umcSE0d9IHsSdyv4p+Z
         oYLrOVTcJ2NYlq6xyMEcQBOtploDDCxJX3ZktIYBK4v8HeA83LiZUXR2yv0O3zrJHbH0
         7LpPuMQF3ayL2+0nzz9HO2kHFl80a/fqompGKUEJkFERh0NCw0xQ+kNO4nU42YQCcXfU
         J7cvon6U0l9HAgWgm9eEXvUd10yD4EGQ6hkMCQPcp7ZnUSFpyMQXtZWAoVK3lxOIVrFO
         kRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316556; x=1794921356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5J6MwDWOHWjl7QywHmcoK9CGF6kb9+LR3zZN5cslCcw=;
        b=Ojz35KU0+DakK8j64ta2rqhE6cb3DErbv6IDABXNbm0lnAN5MNeVHBlq7AxmC8xrRL
         ZZXZ6ctYLVBzk1IA88ZwdTOsXSXTrIyiqbBrFh8dWMVUIxy69OfRcZ2mkgaXN2LlGT38
         TJTF3ryqsr7Z3rmq92IUWkb99vwppGhuOwrkJobWhL2ENOuiCX5rc+mW1V55VfGhxwRM
         Wz5tXpQUT+w0COolvNlyAYtl/yR2JxHZCsmm+kgwTrYWuPjDaB4m7z4SYTx95kaxU4/7
         xKFNesc7/q1+kFxQ/w1TICjdUfVqqTdldqFe4welNjk6tpahlJojs0I5riNjJ8O37/ux
         O1Iw==
X-Forwarded-Encrypted: i=1; AL+hErGQfggmrQNXLkVC6g37+v4QQVm7agojdmEZZuJOV5CEl11uqn7R9VmSNtg2kdnIeuoHWHf8FCOQL6VgSu8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8VK9g8+cpJ+Jt+nrBG3a1vYZAQ7TFwz+XHOx/Ynr4kMRsw81Rm
	cYv9DICSCel8Uz5ZtnlRxk211Nk4lEUe5iNFwW2ffiv4Hr59QYJ4Hx9j
X-Gm-Gg: AYBFou0v0CD1BnLFgMX20tyJZ3SWwAn4iyMhTSXCs89+NvAe6uEGQ8206QSx+1KNXig
	WTx5/KUkzaleMgstCNu6Kdx22oIjJd3ZtmWPogM8s9WATzCqpwENv1kMhUd3M0eqK3U8Ha/0Cx0
	2lVSG6A88z7Z/vmc9X01XVnbv8mE1mTJlfCVb17eB7tGBz8VA0bR4GFE8UZSeqfIQWZGhxtPUmn
	SEdAaGYVK8ZvO83DyAtEAPfyGp2qDdPQY9PXVZe9IBxTjtZGjmulLprHqZwI1s8/3mxAw4LVWCk
	sL5MCWauhdkFOzeJKPr0hmFsKjMm6kwXof6odZLLtnxRwkdiz9mJFPaw56gZdFZpYx/8nOh9uBl
	p9kan3Me+HdURfPh8jphqZ+lUN31lWbQ7A0O5oacGzASBDjHhJNuvHU3sRhwUmS2YzPK3Mhd2YI
	SUB5pzOd2rl1ECBqNfOUzNUDEFPvx3T2IXm0F1qpka3EMvA9oHTg9gu0fZJCGQ+Tjm3p6n7KNAf
	kP3J7Hcjfww8x00jwCE2iNsQs/DqxWzC+9GPRhKj+aZRCoeZ8CEE8A48n2v1TgKVT59d0Z1qyuu
	vRsbcNh5B8cq1FhnBPu+3NhSGFm1gw0=
X-Received: by 2002:a17:90b:4484:b0:3ab:2d46:1dd6 with SMTP id 98e67ed59e1d1-3b166ad1edamr2975506a91.4.1794316556474;
        Tue, 10 Nov 2026 05:15:56 -0800 (PST)
Received: from cryptic.lan ([2001:569:7077:be00:8191:2bfc:aa6d:704b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b589sm3806975a91.5.2026.11.10.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:15:56 -0800 (PST)
From: Allen Pais <allen.lkml@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Allen Pais <allen.lkml@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Wei <zw@zh-kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 06/33] dmaengine: fsldma: migrate tasklet to dmaengine BH
Date: Tue, 10 Nov 2026 05:13:06 -0800
Message-ID: <351fd16a4ad121e2f2a423898480b449c5778480.1794315350.git.allen.lkml@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794315350.git.allen.lkml@gmail.com>
References: <cover.1794315350.git.allen.lkml@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the per-channel tasklet with the shared dmaengine BH helper.
The handler continues to run in softirq context while dmaengine owns
the common scheduling and teardown mechanism.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 12 ++++++------
 drivers/dma/fsldma.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 99a878ed1444..f069d1bbff17 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -970,18 +970,18 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		chan_err(chan, "irq: unhandled sr 0x%08x\n", stat);
 
 	/*
-	 * Schedule the tasklet to handle all cleanup of the current
+	 * Queue the BH worker to handle all cleanup of the current
 	 * transaction. It will start a new transaction if there is
 	 * one pending.
 	 */
-	tasklet_schedule(&chan->tasklet);
+	dmaengine_schedule_bh(&chan->common);
 	chan_dbg(chan, "irq: Exit\n");
 	return IRQ_HANDLED;
 }
 
-static void dma_do_tasklet(struct tasklet_struct *t)
+static void dma_do_tasklet(struct dma_chan *c)
 {
-	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct fsldma_chan *chan = to_fsl_chan(c);
 
 	chan_dbg(chan, "tasklet entry\n");
 
@@ -1154,7 +1154,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_setup(&chan->tasklet, dma_do_tasklet);
+	dmaengine_init_bh(&chan->common, dma_do_tasklet);
 	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
 
 	/* Initialize the channel */
@@ -1207,7 +1207,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
-	tasklet_kill(&chan->tasklet);
+	dmaengine_kill_bh(&chan->common);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
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


