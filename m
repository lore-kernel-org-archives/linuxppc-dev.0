Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:01:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EA92067C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6IDOwP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EA92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXgt48xZzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:01:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P6IDOwP5; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVScY1cQKzDqSy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:58:05 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id g7so6038422plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jl7zq958bvyphHRDKv4nNAmR0zSknfotUpyL6Tf/wt8=;
 b=P6IDOwP5JjvvGriwph12LdSiIuRxpIgAmAdMDNUOEdE3wlgtHweKJoc7ASfqWWFbOV
 1SCY05N0lES3ftWwuw0qEvw3kHzrei9IGR7fosnwng703pUgzzIvRYsyvraiJ/VaIpMA
 k71+8G+uSed3hr9W9FQlwtv/jvRlQi8TYx3lq5goJm6mW5TbZcyp5ew06Vj/0R+oHH0H
 wL3aGoRxbVBtWnNo0LqEQPeBeLQWUXCHOBaGbAtDhANFy802MUStNt5AsT9vr7qMCxWB
 rjEbhj3ixZnzZHJBpeZN7wkoHdNNxSDUNewjoQhY19JIehAGVzC27UkcvmMgIB59PGjG
 s35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jl7zq958bvyphHRDKv4nNAmR0zSknfotUpyL6Tf/wt8=;
 b=M2pai9b44qylr/gY3Ui5mSAS/Lw0vRaBoFW0c1bJK5HDHg0ju5d18S21+0W5znO+nK
 /dzwTtsJNzxOo1G2KaqJ+icAQEoEY95bzCdHNnMSnzSdgvxjZMEwgU5gK/9TfGTgARYn
 RAi9UpOgHrg3qyjZJYHI+hUeTaAP6/YP10s1fzLjyveQWcB2Ijo523dom9nVdEsqlH8T
 MxWbS9NiOR0A5JVhQF0s5EGwcKDnJswm5GPBBZEWZMK1jN9yKcHcO9FgdulXzt7JFkjn
 KoF2p79BekmbDVM/Z3zTo1iBpX9NvmjEzUXrVtoPooBi+cYAbY4kl6UlWpA+2CaEwXjW
 +Lig==
X-Gm-Message-State: AOAM5337giEKedkfrvmSK89pZCqI0/aYGvqP1FW21aawUcjwvlEG45KY
 LUb9fANueBQ4VNSdrJH1iOk=
X-Google-Smtp-Source: ABdhPJzq+K7CR467KRQ31me/jHavVenQGpsdx8Y2B5GP1GWBoaBp3308lEe+K8lDR2l6eP6TZaJOjA==
X-Received: by 2002:a17:90a:7348:: with SMTP id
 j8mr10509100pjs.137.1597654683313; 
 Mon, 17 Aug 2020 01:58:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:58:02 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 08/10] sound/soc: txx9: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:27:01 +0530
Message-Id: <20200817085703.25732-9-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085703.25732-1-allen.cryptic@gmail.com>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
X-Mailman-Approved-At: Mon, 17 Aug 2020 21:23:57 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, keescook@chromium.org,
 Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/soc/txx9/txx9aclc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 4b1cd4da3e36..939b33ec39f5 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -134,9 +134,9 @@ txx9aclc_dma_submit(struct txx9aclc_dmadata *dmadata, dma_addr_t buf_dma_addr)
 
 #define NR_DMA_CHAIN		2
 
-static void txx9aclc_dma_tasklet(unsigned long data)
+static void txx9aclc_dma_tasklet(struct tasklet_struct *t)
 {
-	struct txx9aclc_dmadata *dmadata = (struct txx9aclc_dmadata *)data;
+	struct txx9aclc_dmadata *dmadata = from_tasklet(dmadata, t, tasklet);
 	struct dma_chan *chan = dmadata->dma_chan;
 	struct dma_async_tx_descriptor *desc;
 	struct snd_pcm_substream *substream = dmadata->substream;
@@ -352,8 +352,7 @@ static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 			"playback" : "capture");
 		return -EBUSY;
 	}
-	tasklet_init(&dmadata->tasklet, txx9aclc_dma_tasklet,
-		     (unsigned long)dmadata);
+	tasklet_setup(&dmadata->tasklet, txx9aclc_dma_tasklet);
 	return 0;
 }
 
-- 
2.17.1

