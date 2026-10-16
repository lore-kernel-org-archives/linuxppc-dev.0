Return-Path: <linuxppc-dev+bounces-29577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D00CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 02:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Tfh4swXz2y2B;
	Fri, 16 Oct 2026 13:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::832"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792118364;
	cv=none; b=UZsrLFHkXo52Y6ikdozm/8/r2PDQD61X3pI7sAQAQQpaSBszOYcyKaE1s9OHuwhw7mcDJjghucctM3sm42Fe1HItnge/Ja8KjWyaYRfUcI/dVrKfcfUotuFq7PMPsPP1mYsDaWXA9pJA7P91h3V/YmWKWe6tTD4Pa68PIvrFaAucBdpGXKad3pwaTjbmjffjHcIINplauVpnBClC4yGTl8MreyCr75TofErpciFp043T4jjdgUUfOWUUYevC+shVLqVYOxrNC8NjLoUmpT48l7z56tShoZCaZWOV/hb7oXoc4MgAKeG9RBfdUk/DVlZ+ip1A3vOxK7ALlmILhKB28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792118364; c=relaxed/relaxed;
	bh=bSW72b6TbEDeHWj4s+TQe2ybMIewbEC1kCXuvHMAJq4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lkVtPPtEw1wnlpicwZ6Wx0e92C1KH24vUurbtjiZ9QPZ991UqIQYF6B3MLdlVJpreh+sg5jehqLIvQVYkPthYPKRKDKQ4s/5eOH1rIr1aXdi+qRXPSWNqWGXds338MoFiJ3D1Psy8MiS02pX26ki0YUmiTAOS5DrgqdaUmo0XCESrWSmTmGv+wNQJzmsgBniRGQBKFJYNzfGtU4X5MmnQPCRjKDy2/iy4SVIrxZZpV1aVvXgWN68SfUS4ujeUmLegSphc+6Z/aIhNElP3w5J/iqHx59fQlFsrpmXEJQ3OmHXpGpDh3d/7sWtiLrmPgFBCbFQW5ea5pLxlfKMH5yvzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ17rb+b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ17rb+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Tfg0d1Pz2xPW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 13:39:22 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-53396adbc53so23875701cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118355; x=1792723155; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSW72b6TbEDeHWj4s+TQe2ybMIewbEC1kCXuvHMAJq4=;
        b=RJ17rb+b6XR4uHrEgXM5CzPR/Y6eozjhjS/JvaBnH4bIMf2R6FAviP72X6aN1V6bW9
         cUYFlVUjTbcgLQiLFcdIJkzkzzWb9EB4pTtzA/UpORKvq0ezVAsFcbu9GRMrW3g3zbMm
         dMvhj8UapqKz2ugkFhfr6V4Cu8BIPzGkmqD9sEOL9XeZrd2gaXuWHAIvrxgGYoPtm8o8
         tKgGfwjw9z+vlb23jHF/v8nLcfTNE7HQONkVcPlQh7ZPovVCtngLXPAWWURPmlCcfyTB
         82Yrw6SoTmLYgCr9RPLMEOHw65iqTJtAP3KBWf0NtbFzu05upB2B62hUww8XpPxLM6z9
         RE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118355; x=1792723155;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bSW72b6TbEDeHWj4s+TQe2ybMIewbEC1kCXuvHMAJq4=;
        b=THFwYtSkkawPoNQH8uWYf67DFv21UAYLt+cMPX3czkylbDqOLYlxzKeOE7j9PEUn/+
         pLcwt+BqcwLDbSSFGmVF6zzhqRZp8/I3hty/B+TBaWn1ncB5y8ho6tSGVUYzWqrOHP50
         trHn5T6IOK6Krw5XK/STcMLCUGyzII59u+Tx5e6Viyku2IpqsQUQLjPpJD/2/teTDkrM
         mcHXKRBZ4LruBNKoQi4Mg4zWjEFezGQPPZ9+QKWxKs5s0im67ps8bm/kXwtl2MmxE2Q6
         DivTSrrS4FErVbJstsP+cfMRpxcQ6pyCM9zUo/INhUoKx/zTZxxQfFD2d8ovcAnNXvmo
         KP/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwV80+AIX/z8P9cpEFUYNjMRuJVoOq9gmQhueHHgK8dMGxgAPRf747xeVgya6VALyMDrBpkiYeG5MwnAfI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxjxGIDpRiYV3H2nDVfVXMlZsPj57DIijp5BRzafaZY6ltylj+
	sNxsttHbWe2fkBkT9qtKUdm0rHbAfegnAUAG8PECFWaiaKPGMwRkNmI=
X-Gm-Gg: AYBFou1DPbKbETmd09EwtNb/OJtlOu88Dm6+UE3jEn7yOas5TB45HQn+iaISFtrfan9
	8SP4J4l6ENvvv/tAtj6K4h7IjJf/wg9ohEaL5gf46XjIE6FjDQXi+UHiRdF2uRtKLCRBJqwvVQj
	03Pb3ymR63If++noMGjjv0Fcno02q5ryjXMuqeCcuUkJe1yoi+oNeBwmrLEKjIdHxwCJkJzhWi1
	6II3y3CuQF/KJUsJXPpjUUC3KWHq2Pf1aEp4kwYTsF/1GJ9WaHcvTBPyK3lJzoDZEObe5BjlU42
	Luwu4J8llRzzQtDN3mF0JaJ0MxsWlGEidlLPpwdz4ponClhTNFj4a4qRtGXdUMF9C58oDLr8exV
	uHvT2DcPBohYlFCD4zPGDikGQQWsOxS6iAYwADhLHjZMLtzGamxfkeTeB+e385aiHi6OXZB71Iy
	r+B4Wxtn513GdKoeiCzTrPl6vJExnrOL2GS7r6sBq+AowF7pzoy12+6p9bEYKbTKdS9acI4wX1d
	m7Hkbff4R7S5Bl3bwKb4r+NHidmM+NE93orEua7yJZV9vv8TKLu8wSEe8PAo9+DMfzuhD1Z/iy8
	hKGf74zZ7sc3B5jidlmj2SWp0oFg
X-Received: by 2002:ac8:5f8e:0:b0:51c:fc4:a144 with SMTP id d75a77b69052e-5359f46d56bmr352039851cf.4.1792118355392;
        Thu, 15 Oct 2026 19:39:15 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e782fsm10160841cf.8.2026.10.15.19.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:39:14 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: Disable reset work before suspending on remove
Date: Thu, 15 Oct 2026 22:39:12 -0400
Message-ID: <20261016023912.3658714-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
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

XRUN recovery was introduced as deferred reset and later converted to a
work item. The reset reads ESAI registers and can restart the transmit
and receive paths. fsl_esai_remove() currently suspends the device before
cancelling the work, so a running reset can overlap regcache and clock
shutdown. The managed IRQ can also queue another reset after cancellation.

Disable and drain the work before runtime PM teardown. This lets an
already running reset finish while the device is active and rejects later
queue attempts until the managed IRQ is released. The IRQ handler's own
register accesses during teardown are a separate issue.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (arm64). No runtime testing.

Backports before the tasklet-to-work conversion need adaptation; check
disable_work_sync() availability.

 sound/soc/fsl/fsl_esai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 4a530a6..83a9963 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -10,6 +10,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/workqueue.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
@@ -1099,11 +1100,11 @@ static void fsl_esai_remove(struct platform_device *pdev)
 {
 	struct fsl_esai *esai_priv = platform_get_drvdata(pdev);
 
+	disable_work_sync(&esai_priv->work);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_esai_runtime_suspend(&pdev->dev);
-
-	cancel_work_sync(&esai_priv->work);
 }
 
 static const struct of_device_id fsl_esai_dt_ids[] = {

