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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B240AC433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:03:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC302067C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M37L93SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC302067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXkG4KZPzDqfL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:03:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=M37L93SC; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVScg6QgHzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:58:11 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id q19so7185397pll.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KccEtbXa6IlqeauaaaE7AIR0JNzfFLmA4P8zWKeg1Pc=;
 b=M37L93SCLVOuNTd2R9Itm92ayKxRQN2wHX1NMFvm06ygZB2w44PlvNXwkJzimpR6iB
 2lXAZrOUVBZYUTzHKKHB25qNW2hykUMYhRfnT7q8KV7f7t8YxEzhRmbvf4l81mXIx4dw
 EPs6ufn++tfqVIgFjil8lKLw0yMOuqogI6PkT+GeHwVipcgtTdeVKXuM1PzVWiWcrfyL
 6zWKzlQDXSZDv347qZKC4pSOvNznLe5RkWVehvvaP0bFYCd2H02PiYftk+J6+iY3wrEa
 vfgyjW7cXLAdOZUKrSj2k0LyCFiN4QXhoyxES3u+AwweLjEaKnkftQ99c8vxeyjYjdEK
 609w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KccEtbXa6IlqeauaaaE7AIR0JNzfFLmA4P8zWKeg1Pc=;
 b=N1YnTwJPLW/xAm3iNDbw9viHBMfG9iQAx5hxhUtTSnCe5JxiBBBUolzXiO2C6XivgR
 5t4ZM5LWlO1g+R5PQFkp4AsGXY5OcWFg48WgoAPE+mlUcTc1KbAI41g/hR6VJ1uwhL3F
 yn8BFBcwbRET8RvdENBK/KUOYrqcAKEy4J0CYnNlRqiJDMyWhXqYsabC+2cmESmZnw/Q
 5LWgBmoNHTjiupNPPOfwnFml70WZ+b3XV5UFbDr723O4L41IO8W16G3OsnCDCu7ablV8
 PxEM+7F89LyoqiDV9svFUvGeQ1L8/+jXnrWPeaRcWID+vfBYGuFust3WoppoTxue94u4
 SIxg==
X-Gm-Message-State: AOAM532Ok3hQNejSZT149oY6BJVRKDBhsqoATIkTy7UPtavGahXc+z2l
 g3hplw/27EPiomuxVtbc1/0=
X-Google-Smtp-Source: ABdhPJzg9Sul/hHo2S3e13LeNtREGnuHKJS0d3HSemC0SzTDZO8mUsRC3gx5jqtsol6tC19JN8YCqA==
X-Received: by 2002:a17:90b:1949:: with SMTP id
 nk9mr11123870pjb.185.1597654687567; 
 Mon, 17 Aug 2020 01:58:07 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:58:07 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
 o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com
Subject: [PATCH 09/10] sound: midi: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 14:27:02 +0530
Message-Id: <20200817085703.25732-10-allen.cryptic@gmail.com>
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
 sound/usb/midi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index df639fe03118..e8287a05e36b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -344,10 +344,9 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
 	spin_unlock_irqrestore(&ep->buffer_lock, flags);
 }
 
-static void snd_usbmidi_out_tasklet(unsigned long data)
+static void snd_usbmidi_out_tasklet(struct tasklet_struct *t)
 {
-	struct snd_usb_midi_out_endpoint *ep =
-		(struct snd_usb_midi_out_endpoint *) data;
+	struct snd_usb_midi_out_endpoint *ep = from_tasklet(ep, t, tasklet);
 
 	snd_usbmidi_do_output(ep);
 }
@@ -1441,7 +1440,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 	}
 
 	spin_lock_init(&ep->buffer_lock);
-	tasklet_init(&ep->tasklet, snd_usbmidi_out_tasklet, (unsigned long)ep);
+	tasklet_setup(&ep->tasklet, snd_usbmidi_out_tasklet);
 	init_waitqueue_head(&ep->drain_wait);
 
 	for (i = 0; i < 0x10; ++i)
-- 
2.17.1

