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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F66AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 11:47:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEEA20674
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU8dWmKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEEA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXMc0w3szDqXB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 21:47:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eU8dWmKL; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSbm6sv6zDqSs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:57:24 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id c6so7495537pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t7X4N8pkN3GNmV8aMvjwf42XjKAkvV3xHvRmpPGyZyk=;
 b=eU8dWmKLLv5YTw4tvFvIiBL3Y1IkcJaBGGLUE54vTrcpDfTbismq7GDbmVP1OSDwSu
 TaGr1/B/34snw/Aqar9BeYatdu4L0OFKOM+gpH5kJ7Yq1EJ9pKbAQ0RV0RcwFfJldm+V
 g1PkmbwNpM0cfFbKTQLWgqStuCuhmGLakGOMCuSQURnwSI+d6iQFwg0NIhaOCqxtc43A
 jaZrSY4rFCFm6a1mUQpcNzrtnwO/ZhFTwEG9P9iMcrHKSfjgrG1g183hajzTP4gOHtjc
 XJraSp0qqdj5OPlXXp/hZre3PcGFgLS0V/5pIUsQ0BC7wfLM7uQqZoRi59mBhkpcs+b0
 5hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t7X4N8pkN3GNmV8aMvjwf42XjKAkvV3xHvRmpPGyZyk=;
 b=Fk0ItAZUboXl2VkgCfr3oqphnXOKmRmMIYSEIpn3BA+reZYr9vLSB+z1VEJqKwB09G
 zW9xxeP07CNvzwEUMS/EhmgIP3qoloWgEakzyDlR6+KniVffc3C3Pw34t2QSL0zAkwnY
 TJs94BI/8zAL9+XhJK8WvIgSJfHocKi8MUrMIc42oOdFW9rgeM3lG6ZSNnRTC9xRsupn
 9WPXeII8kur2FCHdt6IRyECOnQwuw1KOsGt8Z5TP6V4/rOnjX13yLqIz1mNZ3DUrjB5G
 cOm4N/LGf3UMg91mPlzovZYXwzZu+a3Us150fscy5pe/bktCUF9PTVHM/MOIZPHEKIzw
 SNLw==
X-Gm-Message-State: AOAM533gyP2guLWCWPvNTrAUmCojbMz3LiqnLhtpkDSso+EvlcbwNw7a
 yvggFnPy5k7ptdGKT4gNc5w=
X-Google-Smtp-Source: ABdhPJwP/IQJZ8mysCiHhZ16IDovHskbje8iA1sUnZbb8zig7yuonzpg7I5LA8g+e5ygnIfnJT9yUg==
X-Received: by 2002:a17:90a:6d26:: with SMTP id
 z35mr11434456pjj.164.1597654642315; 
 Mon, 17 Aug 2020 01:57:22 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:57:21 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 01/10] sound: core: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:26:54 +0530
Message-Id: <20200817085703.25732-2-allen.cryptic@gmail.com>
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
 sound/core/timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index d9f85f2d66a3..6e27d87b18ed 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -816,9 +816,9 @@ static void snd_timer_clear_callbacks(struct snd_timer *timer,
  * timer tasklet
  *
  */
-static void snd_timer_tasklet(unsigned long arg)
+static void snd_timer_tasklet(struct tasklet_struct *t)
 {
-	struct snd_timer *timer = (struct snd_timer *) arg;
+	struct snd_timer *timer = from_tasklet(timer, t, task_queue);
 	unsigned long flags;
 
 	if (timer->card && timer->card->shutdown) {
@@ -967,8 +967,7 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 	INIT_LIST_HEAD(&timer->ack_list_head);
 	INIT_LIST_HEAD(&timer->sack_list_head);
 	spin_lock_init(&timer->lock);
-	tasklet_init(&timer->task_queue, snd_timer_tasklet,
-		     (unsigned long)timer);
+	tasklet_setup(&timer->task_queue, snd_timer_tasklet);
 	timer->max_instances = 1000; /* default limit per timer */
 	if (card != NULL) {
 		timer->module = card->module;
-- 
2.17.1

