Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE52606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmcj/fP0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJX0TVfz30V6;
	Thu, 12 Nov 2026 21:51:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480716;
	cv=none; b=dYDQi4i2o36BYjIXTOPaZIadrlOsXXEUFupE8PJgpNYnVh6VSVADB2XCiPLJP98+8IDu5gkGahI/zVokRF1tqTRyXTbBhB8zduLeDpM/8YB/4eRhLvWcTUskUGr2TCpCGeEtA2iSjJg5wZckIJPci7pR0s4108DkjC+Lz7nJ9MyZvvQyYaMVhjdT6cGiY5tqOnmpBco+Fq2lf+Zzyv9wVUCO0105t8dDG24Y8TaVI3xKa6rAw2/OJUPdOTNMJzo96fdULoAM4bHHm65XnUEfcVcbcJemCkKtW8IB6ewOyVx9+f1aLJ+DR1UCQm6+Tas8dy41aRGWql2PIynjdX89Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480716; c=relaxed/relaxed;
	bh=A0pfUkfSu9+4b7u0lMR40b3rWHEvr3iCbrzCpdtLRdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luzJp7LT5INTxiYxfFeSTDvYuCSt91S7mK1Go84cxPzvAarVPAOlYdw5ry+fiiR9k6VHAFa/ArLIysMvGrpFwoo3tx/dCR/1kTBjsIhP7hJng0+Z++KmuvoJ8TO/esVTZueqt1yLxKINsdGbjUDof7kAQMAQqkRrUrpMWCKLR6eCh5ph1xhvrJZF74G3pVe71k8MEmFyKNk8sGzjVn7Iq2875pxfxZM+/dMC10sM3wCzvlm0Xrcd8C7n3nEA7/0MQMSXzc+AoxeO4E81dL1jbibN9zVLCrFRpy9r6zWESaI2JjJrrL6q+U2h2JMk2CX8WgnF1Q16Cd3qkhZh5AWrSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmcj/fP0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmcj/fP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJW2jHJz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:55 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso6189390eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480713; x=1795085513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0pfUkfSu9+4b7u0lMR40b3rWHEvr3iCbrzCpdtLRdw=;
        b=jmcj/fP05suckyNn6Dl6i8LAKWZPwnf/+ByRlHr9DXeZGmxBqxiKY6SkLLSb0hmTr4
         P0Qc7nToGXmA2kXNxu04agztyeCUvxJdgiJgEk1oCl9LmHZ62Pz17xmUthRstAYgxM93
         fZ7kqlz3obxvKzFfSEF2au7p7ip+0lSLtF1KR8D6YFKd7OwzbzyLLx0u53m7+1BewxZn
         Y2+N+KXPNt+Gyv5+kwMkcedk3jtKkxnf2xd+AfU3k+Rel+EXlAUhzFuuWSPbgWYsmWl+
         cqDRerhtuHaqgJbxCMKs4etybLPoQa9ooJa25vf2OtjcZhBNNxsrIcDAM2dTaXd79u0N
         Crsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480713; x=1795085513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0pfUkfSu9+4b7u0lMR40b3rWHEvr3iCbrzCpdtLRdw=;
        b=S+YfsTbP23eX+eF6MCYXM3FDyEHkBfV77pMyG9ylYAmB4jipfzWUF40dwwEoicH2uH
         w9tjuZDjKvgaVxGjDIpcMdmbg6fESXDHazueOw0gs8BTZI+DqtBoLrLgVl23t5lbYZGL
         wEYWaCSUX1wA6DaDeFhoSdQm9AoUIrxenO3FVTUmnmocuXe2tufVZH8kS5mVXzDaZwwB
         h1LEij3ro9Dy0/10SJF+R9jMeo8M9Iya/rM7ZStHxGj64O9BJIiN/wNC3NqCcjzONkTW
         BfJ2AtyDTyT1wvF+FYlucurSFUEqgjZj4nx5KbCAOM7Ud7k7LjYEK9rtvHSDKqV7Bor9
         kb8w==
X-Forwarded-Encrypted: i=1; AL+hErGSkarsnjv/6lW4YiU4XaUh1E3NbPSJUb2qEIbOYaj8tUs/ajMn0MlQJbDzWr2E7AVN772ZxKznil7sjeQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+fEn05xaRE7smu7lMEonxqDZUHAQS8wnXiwt9obJEI8ctY1xFL
	oET+hqbdT6KmsffLhzPEqlHe80NG9q8wmN9ALJ+jGfGSPMwi2Xx/Qily
X-Gm-Gg: AYBFou0ru6gPyLx5YGynCyuN7xnK6brSOqjBr566qvx6udO8cwV4UQOey5qzuwFeMXB
	yVfgTuZp+vl5Di+IJFWPYDyClJg+csV66o2jvrDfj8vDUdaAKzWrpCA3cDaTWuivL+iw3yLlDTQ
	7C1h1oFrcG4ykqH44vEnCsea9uh9PtYPx6sAbjoug3pn8emJulTW7uGayV+TQKpJfUH2eThAo71
	u65HQXL3Bxo2b+glww/0q47oap7BGF3fM420XEOPRATxHZOvWWh3HA2+8Phr8hLTFXyKsgVrDk4
	bqpSlSF+oNh884Y0OlVGERFfBavJ2u4r+S7x6KhnIplo28jJzP+o2sONG+NEX9+9wepFGppyzXd
	1KfBMHi1+RGz/nLNqXZMBQayXKTiZ+mmdRnvbzPyzza6cpoyBQ7KM/jiFbJn6ukU6K4rQBh24xF
	K70CrQX25vY9YPCHvGUgqMnrx7Chd+1yNHRKgs8gKOKCt0F8Gxa9eJFbAc75OQJ2cuMHK+ylTwR
	KKN92/+mSrthShn8+dRMBZh8/nl2OH9symN9nheKrNQHxqBDODhpMhR0DYRQ28Qn4ZCtgDfGhEu
	Tt2W0N+cy5wcRLkWpAwJOGJ1Yuvjk21cgX15S576DWcnDwyFzgd/8Xx4RlonDpDNH8GVMnBzLX3
	pLCKK6Yay9RuCwIATa+SyZHUe69+FutUz4CVXK398piOm
X-Received: by 2002:a05:7300:d709:b0:376:37a2:87f3 with SMTP id 5a478bee46e88-37686b43109mr6989721eec.31.1794480713499;
        Thu, 12 Nov 2026 02:51:53 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:53 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 5/5] ASoC: fsl_asrc: Use devm for runtime PM cleanup
Date: Thu, 12 Nov 2026 17:51:16 +0700
Message-ID: <20261112105116.32274-6-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112105116.32274-1-phucduc.bui@gmail.com>
References: <20261112105116.32274-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

On unbind, fsl_asrc_remove() gates the clocks before devres
unregisters the component and frees the IRQ, while the component
may still be in use.

Move the cleanup to devm. The action that disables the clocks is
registered before devm_pm_runtime_enable(), so it runs last, after
runtime PM is disabled, as in fsl_asrc_remove().

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 48 ++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c97f814d7358..09e09164a106 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1258,6 +1258,15 @@ static int fsl_asrc_m2m_pair_resume(struct fsl_asrc_pair *pair)
 static int fsl_asrc_runtime_resume(struct device *dev);
 static int fsl_asrc_runtime_suspend(struct device *dev);
 
+/* devm action: runtime suspend the device if it is not runtime suspended yet */
+static void fsl_asrc_runtime_suspend_action(void *data)
+{
+	struct device *dev = data;
+
+	if (!pm_runtime_status_suspended(dev))
+		fsl_asrc_runtime_suspend(dev);
+}
+
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1413,22 +1422,34 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, asrc);
 	spin_lock_init(&asrc->lock);
-	pm_runtime_enable(&pdev->dev);
+
+	/*
+	 * Ensure the device is suspended after the IRQ and component
+	 * have been released.
+	 */
+	ret = devm_add_action(&pdev->dev, fsl_asrc_runtime_suspend_action,
+			      &pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = fsl_asrc_runtime_resume(&pdev->dev);
 		if (ret)
-			goto err_pm_disable;
+			return ret;
 	}
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
-		goto err_pm_get_sync;
+		return ret;
 
 	ret = fsl_asrc_init(asrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
 		pm_runtime_put_noidle(&pdev->dev);
-		goto err_pm_get_sync;
+		return ret;
 	}
 
 	/* Request the IRQ only once the device is initialized */
@@ -1436,32 +1457,25 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), asrc);
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
-		goto err_pm_get_sync;
+		return ret;
 	}
 
 	ret = pm_runtime_put_sync(&pdev->dev);
 	if (ret < 0 && ret != -ENOSYS)
-		goto err_pm_get_sync;
+		return ret;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
 					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
 	if (ret)
-		goto err_pm_get_sync;
+		return ret;
 
 	ret = fsl_asrc_m2m_init(asrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
-		goto err_pm_get_sync;
+		return ret;
 	}
 
 	return 0;
-
-err_pm_get_sync:
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		fsl_asrc_runtime_suspend(&pdev->dev);
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	return ret;
 }
 
 static void fsl_asrc_remove(struct platform_device *pdev)
@@ -1469,10 +1483,6 @@ static void fsl_asrc_remove(struct platform_device *pdev)
 	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
 
 	fsl_asrc_m2m_exit(asrc);
-
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		fsl_asrc_runtime_suspend(&pdev->dev);
 }
 
 static int fsl_asrc_runtime_resume(struct device *dev)
-- 
2.43.0


