Return-Path: <linuxppc-dev+bounces-25689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9001DC5B570
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 18:11:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJjWD3DKhz2xLd;
	Tue, 11 Aug 2026 04:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786385496;
	cv=none; b=Kq5FNazmt1bARzLTKj1MBHnixvXsWv+aL96M4pQLnRGL9az4GWIn7cwS0BvEZH3RUWunkCtpJWjjYxkRPRNkhELPcgCT9VO7MHlE1X5wFlzNwW4s1OMdwOQwiwy6z007fu65plxhXhw8KGIazGWfsivrMR4VEpXHZhagne9bHA0sO2EwtA/2l6dH/RNqBKn7XsWR6PuNh6ouwT++VlualBMd6qUn3jRx0GqpYnYjGt2HdzH+j3blHRC0ZEthsTKek7Vz+p0L9ZJ/5dHTo1Tcp+RZ0Oau8fYLghgcPFPtK0HXiVvcvKqtP1yC9LNboFTkaH6As+PiDulfs7HRzz0DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786385496; c=relaxed/relaxed;
	bh=xHByj7whypjAGcgXNhTkpT6ldplRWJVWN4PSrjNWnv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3DiwGEpLchSNYgeFH5EUtTlcM70tVa5DdaZrnlMP8sHr0fxPW+yYm8AiOh0MN8M3ZWNoBFDbFbllCsZB3PLjulugSpQ0QkqU1Gb0ADETT0T4NDgV/v2ghKS/l1vlQZed8zG3JClCQIvSMeSmzbLye20FXi9Yr4EST7MJHjoWAynftecdH0dfSBPzOAsUbQ5ZIZE2hdAMGgUCsc7Hhi1+jehayJoE83C2q9WYs389JYt2oiGTsZhS8rH2Je5nCVD5mhWKDXlBZL3tyu+cGNZ8ATTecCloCzPh1mHwXZ7T8DmLdiYW2vUCkPLXy7lSBlmRH8YUeXRxqWZhpiD6PDmZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nKt6O64k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nKt6O64k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=allen.lkml@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJjWB3l0bz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 04:11:33 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2301282a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786385489; x=1786990289; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHByj7whypjAGcgXNhTkpT6ldplRWJVWN4PSrjNWnv0=;
        b=nKt6O64kyLMZqyYAi3ikNUAzwg+vqD9phM6kttWmFSRcVsQWsCMu7Vw882i6TMLXLS
         mASUy0qLIkaRs76vMMKGoHB5YQhtNTJKEJi85FvgbqcJXcBO76G/IAAOZqYFLHChjsIf
         wvt5DxDbWbSkbY4IctupZX8j6xs4ffRcdh/ZEaHbNGFlcLmLiGB3Gu8P8J9jhp5Q04Li
         Ote+yVp5k/K8xnh3V8Qhe3QQVVaP0bZfqt16iKSF+eBrZ4Z1fK7WfjJu4JPlHAhABCFe
         +xeI5BZoV8oOwpCmIJbV5cq3lwQ661prxkhLrLdDl7OJsScgYHRn9ngnMuOJacsA6iDx
         nCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385489; x=1786990289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHByj7whypjAGcgXNhTkpT6ldplRWJVWN4PSrjNWnv0=;
        b=AfIs0YlCXSzkH6v/rAFMWAXxBrUUaLbdjgNJrjpwVzUh8el7voH8wprXSZJHGJD7ey
         riq6btmFR/9MtZfc32EojlBGn2QUPi0ju2nXG4XJVfHE4/i6bpWIogwo84jXwax7eEV1
         YPzmF22OVKGWsaB2ErnyTQI6kmWKAFxY3t8HXVkymbYNsbPl56hOkXgXD3sMCea1jLqz
         KzS78utToGNG11yNkNkBIRUVcxSmLpnBauqOzYCWbH3KOtq1VB70+rft1WU6oNxdTVDI
         krl5fkS4iR5lf3CYrtJh3jvZlEoJAq6kau2S8mKXApnNw7/3e/NgI8nLdPvDLW7AWWrF
         peiw==
X-Forwarded-Encrypted: i=1; AHgh+RrggWNXu6UueWQcJq+4jOR4VUyZqHgoYnGb+5T0Ha4eeZL8FCDipqvWOuWpI2jK0jASDJXZ/jMmNcs55EQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGYUzK1jcQJ9+lQs3y/4F/r0PI5IXEcskwK2lt4DpoThAVodg1
	f27IHi5ZKCOof50V+ULN2UywRSNhLNIyBBqilh6dxyGINzqBBc5PeB1k
X-Gm-Gg: AR+sD10mzwkuyqXfS2a75G/H5WShqHsyPrCt/2pP2JBF+j1T/QLzkQcj1KDrwKtCRqZ
	Od9Gnp8XqkIUXImQxrrHK6ivfle7Z7yMZmVBr9FBh7Ym8ZJ24UVyf6hZSLYoqyJZnHywHa6Za2m
	Qyqf6Fj7T+fIE8D7QtvF/7oosOA7N67Ay+KsOe4d6zV+6MjVqmiyy+2ZAGKfbg6ncYoDARmXUxc
	GMP7DSwDlA1ZTgrnHfhXkpgC/YTELieqEv2mrJMCYK0L2fpzUI9yDpgDwftTTLqBo93b1loqXKG
	/C/lL6tsT4DwOn2A8gB4xONdfdBoQqp2byl/b7cjBfw+rCGnQSiH0KF6wQm8Avnlssy+xHW6W9H
	fBNNY0gMgew1nIwhDNgugujjkmVG3ifKdyB6P7rHQx12HyLk++8aZTm0+q9PBGsKKhjInRNPepb
	Cw47DeBIL4wvu6OzLctSloiWCvaYFJSd0ijR9fMoP8kNFG6dhHHoMIJyNGw6BH+HV4HDNWDRjr7
	A==
X-Received: by 2002:a17:90b:2785:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-3903c5d2f29mr48635260a91.12.1786385489431;
        Mon, 10 Aug 2026 11:11:29 -0700 (PDT)
Received: from cryptic.lan ([2001:569:7fa9:fa00:b1a9:6513:83c6:1d23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d53b873asm472795a91.17.2026.08.10.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:11:28 -0700 (PDT)
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
Subject: [PATCH v3 06/34] dmaengine: fsldma: migrate tasklet to dmaengine BH
Date: Mon, 10 Aug 2026 11:09:07 -0700
Message-ID: <a9c4d258c73c2d7e3c23825db272cdfeacea478e.1786384168.git.allen.lkml@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786384168.git.allen.lkml@gmail.com>
References: <cover.1785183549.git.allen.lkml@gmail.com> <cover.1786384168.git.allen.lkml@gmail.com>
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

Replace the per-channel tasklet with the shared dmaengine BH helper.
The handler continues to run in softirq context while dmaengine owns
the common scheduling and teardown mechanism.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/fsldma.c | 10 +++++-----
 drivers/dma/fsldma.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..f52547611db9 100644
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
 
@@ -1152,7 +1152,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_setup(&chan->tasklet, dma_do_tasklet);
+	dmaengine_init_bh(&chan->common, dma_do_tasklet);
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


