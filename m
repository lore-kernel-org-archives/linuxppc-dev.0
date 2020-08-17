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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D149C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 11:52:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5AC20674
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAqvBoa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXTt2QB9zDqXB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 21:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QAqvBoa/; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSc11qCTzDqSw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:57:36 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id p37so7803815pgl.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5ir2EUoXSC9UiT6j30BKzwTi2avjOse2gHmZ0bVuRLw=;
 b=QAqvBoa/dd6F4tETAI6u/nDKz/8vA4EoePLKL2jn8cWNCqTVZrYl40CYqJxWTcf+eH
 ruK1J6R7QGdhsuqcJisS4p1gaDyPL/E5YLmfLh4tTdGhUmDWoUx+iH0koSkUGUQXliO7
 2JCpmXvCn5GzZPEKehV89mhI9YhIgsKxPYCzx0sEZdZFgiJvmspJz6zSMpHviaIGekwJ
 1z8BTY5fdbhG0uMJgtP8lqMAWPG/KEBRDetYK87jDM6OGa5X6bN2ruy4ecHjDY2vFviz
 XLsP4x+jKhVxq0vODvOPtstM1fIX6fFJxk0zucKQXdSgLhefDyQlIGj7mM8phP46n4ur
 aMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5ir2EUoXSC9UiT6j30BKzwTi2avjOse2gHmZ0bVuRLw=;
 b=XrBtRxvhxricGX64/9CbmUy+ACVxxNygm4HuKjf1n5Mihn4uzmlmhoGAgeopya8RhI
 9bfCS1GD4PEMIWbbAiyDSP7K0Jl6hQL7PZMAiGUZRWEL5nFTcvNs1CpT1Vz65GvH9Zpd
 H2vAJ6K1e/3U8o6zWUzBRZAb8PQiNicDf2VW89iLCc8IfKaeiiyO9zvwdgRugMI+Payc
 30d3IXY9N2SpVPNjeDgFMbVOfDoR6+1s/0kFtzYIyrtU9WjGd3lRLf+mc0zN+XQUxn+9
 WUq0ubV5lDsjH7/jdHPpV6LwXCIWIvxpMeEVFNkijD+WIYIQ2NaLfiVuPFTOTZx8haFJ
 zm8w==
X-Gm-Message-State: AOAM531uv3QljyCYA+3bDh1tIFdxUOYZsXfp7ouNXt2TAx0q9UYHl1ut
 F/uiBOEhED31hbtKifClRDc=
X-Google-Smtp-Source: ABdhPJzGb3DXb0HExdoQilfc10prLDt115mewJJXkDS4HvxKOzPFoSgMOQt2dPqyE+lXYYhpi5FbKw==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr9441882pgc.190.1597654654967; 
 Mon, 17 Aug 2020 01:57:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:57:34 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 04/10] sound: riptide: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:26:57 +0530
Message-Id: <20200817085703.25732-5-allen.cryptic@gmail.com>
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
 sound/pci/riptide/riptide.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b4f300281822..098c69b3b7aa 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1070,9 +1070,9 @@ getmixer(struct cmdif *cif, short num, unsigned short *rval,
 	return 0;
 }
 
-static void riptide_handleirq(unsigned long dev_id)
+static void riptide_handleirq(struct tasklet_struct *t)
 {
-	struct snd_riptide *chip = (void *)dev_id;
+	struct snd_riptide *chip = from_tasklet(chip, t, riptide_tq);
 	struct cmdif *cif = chip->cif;
 	struct snd_pcm_substream *substream[PLAYBACK_SUBSTREAMS + 1];
 	struct snd_pcm_runtime *runtime;
@@ -1843,7 +1843,7 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	chip->received_irqs = 0;
 	chip->handled_irqs = 0;
 	chip->cif = NULL;
-	tasklet_init(&chip->riptide_tq, riptide_handleirq, (unsigned long)chip);
+	tasklet_setup(&chip->riptide_tq, riptide_handleirq);
 
 	if ((chip->res_port =
 	     request_region(chip->port, 64, "RIPTIDE")) == NULL) {
-- 
2.17.1

