Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCEC432C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 02:49:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1B2206A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 02:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW+dGN+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1B2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GYML74g0zDqZy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:49:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=hslester96@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lW+dGN+R"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47GYKC4pljzDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 13:47:37 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id c184so9624971pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2019 18:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RREC1ahvRFfGyw76l4ibA9bqTupLckMQgY54O0gStrA=;
 b=lW+dGN+REA8N1B3l0ms9i7xiFULF9g+HqA3J5bWNgPmMViTEGbfFiKZqRb5DNPvniM
 nkT58TrOQmBLhxqz49sqtU1r50FRvwWUPT/uPWPvWYritw8YmnvSZpe/N1jjluLp0brm
 RwPDgpC8hKxNR3WrYAwWt4JxVxPBgKZftCWLVMEi8APgIusbf/VGUjGjXu5nRU8DjCEM
 WHU4vKhL99/VhKPIN8xoM4nd64Fw6AT8Jio2hQFHW1ZhAhsLZxDe2BRmmyOEdUp1th7u
 KuDfTgX/yUS3Vcao+srvscZfjN4uEFanBlq73GkeXVvSCv8FODgJ4DaCMFGAgBWVMZO1
 3egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RREC1ahvRFfGyw76l4ibA9bqTupLckMQgY54O0gStrA=;
 b=B3c+9xeGqnJv+0icJ73hCm3gnk8aQI6M8lcKhOhGfxqSI0+d4WnBao/FZCL7As+sbX
 P2b/CDVLA7JpqRGM9hak9usaSszM4TRLd2K1B+DGhLl9pljDrrHGTE/1/LY8Y8Sj9LZ6
 g2uQLZY8JXXrUu6rqTUj1MAG3y19mhpz1KzXkN48BC7Nrl7Uz7nxKMEJ/+mSqxGzldXw
 3A2cpP7jSPRTc6tHwMu9Vm4nkhRPYZX09xqhIk9YIkKwJRWc6tR2xOVflbM/wJ6kW7iy
 06RRdfNni3Dr53++mES4ymHna73aNbO5zTh9moRU0peQqpRhs88COzOoFRibBeb2+uvc
 Tg3w==
X-Gm-Message-State: APjAAAWchyH+BLmmxifTKtxd+yn5Mbl/Wius+4r7Zxh3L6AxEBA8erNo
 SbOV511wEfpqGO+MU/Szfko=
X-Google-Smtp-Source: APXvYqwkWq6NxTkksNOXzjkY9PZHBW5+dMlAb/ErmHYmqKufTtuFkiVtJ9liXzA7erSbF37VU8yNcA==
X-Received: by 2002:a63:334f:: with SMTP id z76mr3320019pgz.277.1574045254633; 
 Sun, 17 Nov 2019 18:47:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.gmail.com with ESMTPSA id x186sm20158760pfx.105.2019.11.17.18.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 18:47:33 -0800 (PST)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH] ASoC: fsl_audmix: add missed pm_runtime_disable
Date: Mon, 18 Nov 2019 10:47:21 +0800
Message-Id: <20191118024721.21400-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/fsl/fsl_audmix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index c7e4e9757dce..57cad4365e56 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -499,15 +499,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_disable_pm;
 	}
 
 	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
 		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
+		goto err_disable_pm;
 	}
 
+	return 0;
+
+err_disable_pm:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -515,6 +520,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
 
-- 
2.24.0

