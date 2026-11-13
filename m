Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6A606A338
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0CReA/Y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldf0RLZz3bQl;
	Fri, 13 Nov 2026 16:08:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546502;
	cv=none; b=YpYy3zy6SZtoKvL+C7YqGljAS6SUarJEoIv6hYZwbICDnv0cKYXepkUsesko+3OQ19SGYmgHABTcEC3sINPPdkB3u7ji0a+II3P26fb6M/LQ9Yu2Vl6XLgtmeVMaNxM6KrqP/aKMmiP63grl5UPyjPXkO6jUE8eKNbmXVNiMQxctpiYwi5oIRbOh6T6lfehOGP6RnAAo1j8EnVYliRIxqmgQlPNoUGD4xvUXjWXkVGMGReH0hf7tUMI5itiBuwjOyPt5p68YkTbyJd2vKYx8rhaCTHewWFTvwN84RkOeZ6fqCQUMphpVBTJGSnIh1hSbWFghipxgIqn3u0TQbTWX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546502; c=relaxed/relaxed;
	bh=pldrHiOuWtpoIUL/Y3y4Fat0jR15gtvqdpka0KGtHh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qvn3q5dYAFwpH6eI+gvdmvz/WbwisNblk3KLp3uWe8H5gg55dBopF+Ani1yOOZ/KWKa6Q+tKJkMJvDxmmfOUBavxCyLYweJlwB4EGm/+ceHVQ/9p239fbhtdNGy/B6/zzKIn01SjdHMBoFq025Sh/UGwrwKsN9UnuvvzKFDUGw0irzvLFeLdSdrC0oaJwQ3UIlc3vttIEpmoMf5tewPCsTdtcAs2kabEneK5cb4i/4qLqm+IQrTkw+BfToVxa/t3+d6hcrX6aZm2hNq98dq3LU0L/zTzzi/RMKbrvDBwO7/R3VHI2s+UpGGjOunDN1PxlbsF8pvIB+LfeEgnITElJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0CReA/Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0CReA/Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldd34CMz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:21 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso837568a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546499; x=1795151299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pldrHiOuWtpoIUL/Y3y4Fat0jR15gtvqdpka0KGtHh8=;
        b=C0CReA/Y6xQp6VT7muWrn8B+Rt6VG5Wv9d+8o6uisQL3Mi03CRNzBF4U1NlJVSpOd5
         mozDJHMxhgtBkDroDMfYKOzuQ8mNiX5bnHX2uqWIFbUB+EOZLaDvR+FJgFDqMZcIz36w
         qZUvlBgXwP+sg2dckRWpm4eVqI3pJgt0rqYDsu9alsnFl5w8/WfYUWkfTOLYnByByk1r
         7iITbHrFUXnWxH2HjPlxhwvDzRim6xVsBzlOfnk/wd05rjvgUgcz9gYoUGtJPITvP9jg
         sOPW1IteFsSB5AWhSETtd/rN5Woub49a4PUPbeXinYcrmsMLb1B52zpjXV6YIMZKSVaX
         Q5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546499; x=1795151299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pldrHiOuWtpoIUL/Y3y4Fat0jR15gtvqdpka0KGtHh8=;
        b=hBLjmT3b8j3F5uxsXu4O35PuTrcE9uiAVHIOZ2uyXw31mzfumFXYa4Vbg8mcRSqJmZ
         rBpabXbc0WMT9mWKapW32Sbw9Yz0Hbx+vLj2VMWD9bRFx+1TH+GgEWu+R4Ikkf4Hn7Xl
         o2K3vLjTkuvkUQ0AQzb6O3vUIU8bUJK4QILJ922Kbg41lqUZRl8KMsSQnCVFulWf6ka9
         BlCNkMMI6lQWMjslB0NSwpl03rKEZ1DTjOwmuMWONGHYLMZLrj+tRhnv8s6X1o2ncdGe
         52A0FC8a2Hvn4W0Ht+VuLlu8XiJ6XJWOKZMogTtzqVyI93Y0r0NIZcyRuEW8EZc3yLBX
         Fqxw==
X-Forwarded-Encrypted: i=1; AL+hErH3cWtCH8DpM+v3EF9tEiKfnrEdrn0zZa64WAZONVF5N4xMmEAGIoMPOlVAmCkinvvC3qvxoG6jml7Wo3Y=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9uKbs0nULidrsqsfS6dhDN3fON007/LY1G97BSknDUx/RPJVjQ
	4kZ3e9Vixrh4p164j2hOZ4RAFrDUQRvJjjCMhbDcs3qa+tpgKmpZX9Tg
X-Gm-Gg: AYBFou3mAHP+cSCtYeWO/gI0gGiENXSJzL/3PK7FtpDl62PntM7pOaG96lo/HRHxTHJ
	xPI62jS9eKZFEkITLwKBUqpQi/pTHQgnWBZHLL/Xw5LMaoDqFJ9RxNCnH40p4WSlPycD8+jVr4I
	oVajXRj0nnUKUBsNvZo3fekDvF36SeYeEvO7n3FoK7ow4OVXoJJjIQuWmPXRkDVTYSlMHcgS+rI
	DGrGqyp1wUxdH7j/6dBFdildSn5pk6KmlBbShGVrI/iY1IgaQA1qNxzySLtN3rOKJAenrbW+F7m
	a6mZxYHrSYEjqUOn5zf4jtceZghrDU+xWyFvENQWa6MJTuYhM8QldSJW/VZwDNCVPegQFMlONwa
	XeYcGQvmJeK3FH8jX38RVgCS9qzsex+Y1R6Yeh7Q7SmisqtSL7/71vH+0g8xT5nhMkBWDJpkz08
	G/nXhSxTTeT++Mh/nBcgKREPIQaaKJLmMDgOupObF/BrGQs7PXGyihHnxQU8r4Iya7dshDlA5f8
	DoI5n6Ygariz9Wt08JA81p81IbsSlPJVxNDkHfRy0xk57qT3wcSJBErAUhycw2r2uDKWoE7KMxb
	HL3aTF5KxII3KtI1yoCrBNatGLXCYmUFtFWK/CW7ktXfqeLv2fzRszifX4JiXUcw/F+7k5Rt00l
	619zKbETAGQyydbRUhGMMocEiTFWAfoomdPT07wgH38NK
X-Received: by 2002:a17:90b:54cb:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3b1b0d39a69mr1118659a91.57.1794546499300;
        Thu, 12 Nov 2026 21:08:19 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:18 -0800 (PST)
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
Subject: [PATCH v2 5/6] ASoC: fsl_asrc: Use devm for runtime PM cleanup
Date: Fri, 13 Nov 2026 12:07:26 +0700
Message-ID: <20261113050727.14053-6-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113050727.14053-1-phucduc.bui@gmail.com>
References: <20261113050727.14053-1-phucduc.bui@gmail.com>
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

Change in v2:
 - Remove fsl_asrc_runtime_suspend_action when CONFIG_PM is disabled.

 sound/soc/fsl/fsl_asrc.c | 54 +++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c97f814d7358..317ce0a5c765 100644
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
@@ -1413,22 +1422,38 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
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
-		if (ret)
-			goto err_pm_disable;
+		if (ret) {
+			devm_remove_action(&pdev->dev,
+					   fsl_asrc_runtime_suspend_action,
+					   &pdev->dev);
+			return ret;
+		}
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
@@ -1436,32 +1461,25 @@ static int fsl_asrc_probe(struct platform_device *pdev)
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
@@ -1469,10 +1487,6 @@ static void fsl_asrc_remove(struct platform_device *pdev)
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


