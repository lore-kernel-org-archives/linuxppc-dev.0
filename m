Return-Path: <SRS0=x21H=ZZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F120C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 11:15:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC392070A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 11:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7RcBsG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC392070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47RztX4hL7zDqW3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=hslester96@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7RcBsG1"; 
 dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Rzqj2rgRzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2019 22:13:20 +1100 (AEDT)
Received: by mail-pj1-x1041.google.com with SMTP id w23so318346pjd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2019 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PPxVVC8nLDBEci1WSeW2S69uGVw9UleHZ5a7bu0I1Xs=;
 b=g7RcBsG1I43aqXOgX8NNWXdzwyKNnQzBaNigzS3hH9D+dPCt1yXrXC8KBQAxmAGw1V
 xIVzEZChlfDG+nQak288bYsUyD9FbjuWB5Hzwm9gi3Sc7px/7s/hrq5rBogS1I/+NkHs
 YlJ/+VAmQtSSMduDkdWU0dBpiA9oXDKOYfzFFxYwh8rKlAwK9S0R+nzfs0I5JMyJkcia
 VKZR8p9/KzWzukCGkgsTulEh7Q+hcEUGvxxswb3M63yMSulPhT32jXbFavKL4bQwnGny
 wl9QyR/fQTj4HCWqeF7iY3iuOaH5dRvExDdcoN2F9oeNqVKE+tn2djXq8qI967rtQEFd
 9lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PPxVVC8nLDBEci1WSeW2S69uGVw9UleHZ5a7bu0I1Xs=;
 b=r/VIBnJde7Bz9wRwBuDd26wTTWv+524b5UCN/LyEzjL0wKQGvsKk1UX275KdibMxDD
 OyD39N8RuOYSPbqNlnnZD+DRyTXlQCnHjxpfFEKcITk2TpGTDiebAUy44d5M9LW3fuuS
 kyrIy6S40GUepXnRfQs5So0HX3spyy17j2JpVAraK715t6sTfEUzBlYA/ExjKIGtsqXO
 9crTkrke20LHmxXYzuH2/CGyGuz9kLAGgzSEGefTrhT/pZ2UfOeIjCQjbdXGrHBGmLu6
 aQ1Ap2wb4M4fhLNij7Xsdfq6tZYX9ww67EozULhkyFnQbx6+rT0hWRh7Sldtrjb46zh4
 GbnQ==
X-Gm-Message-State: APjAAAXM+iOsmlGua8a6QqlSAp5dpKgB37N0G9gEaWkwuM9m7QT3IHF8
 u/mDf/6bbqaBSvHpE3Q47bE=
X-Google-Smtp-Source: APXvYqwVXNPxflvrN2v14hE+cqab22DeGQaHc2v2d7g8tdd1ATtAmfxDtIDe+nffB7gaEjuEQcQb5w==
X-Received: by 2002:a17:902:9692:: with SMTP id
 n18mr4397865plp.152.1575371596975; 
 Tue, 03 Dec 2019 03:13:16 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.gmail.com with ESMTPSA id p5sm3160077pgj.63.2019.12.03.03.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 03:13:16 -0800 (PST)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Subject: [PATCH resend] ASoC: fsl_audmix: add missed pm_runtime_disable
Date: Tue,  3 Dec 2019 19:13:03 +0800
Message-Id: <20191203111303.12933-1-hslester96@gmail.com>
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
index a1db1bce330f..5faecbeb5497 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -505,15 +505,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
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
 
@@ -521,6 +526,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
 
-- 
2.24.0

