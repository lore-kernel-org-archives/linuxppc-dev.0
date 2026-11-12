Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFA606A882
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOwOIWUo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJB6hqDz30WT;
	Thu, 12 Nov 2026 21:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480698;
	cv=none; b=ksdfrLNSwwuHvLeXuqZog0zK7/7fpY9PhnkvVeVDQ8s+FDXzM50mhZXPWgq7WF6r0t43jkXF42hyZewABWzNIBfawTY8tjWUV/6sLbV0/RIr7BCSJaP5pvRWw3H18WFy6m+JELVmsIxhshNbXYU4S7XdXCVVO2paKOllNJ97r9zlEBcRrsiZ53MbhvcU0VF4DHrUogFNcO30/Xs+oYROyQOu8lsHtYBCa+UrL4SXtQs2VnOXj1RZBa6yaYkbQ5KBCE8paS+TZl8fUUd/8EfD1LJuTBVxelPtI35mfrJqSwmKN0YxvX1rzCY9mdHkJLfCwrUEyPBCf39Jfhh8SvZpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480698; c=relaxed/relaxed;
	bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPfEs/1Jpdcs1p9TXUaUHWE9pMA2cLEeiRPCRcDSYWM2au7wx3aIA92UXVj8FdkQj+PKt0royDxoaIYqkCriEBMmNfsDyK0LLbm0lSYEIdNCbomWoJ8xK7z11rCAjsvxaZRJR52mu9GjIe3yLQ6qXhsgHNDgRw9MVSfWh02yAkeRP2pN9fGhpTpng/syi1a5qugdiKQHUtBEqtuJA/BYr6NfmSHFuV5vwwGgppg8Sk6Wyy9RHBexT3e2nQrGJMpyzhcrFVIb+bjQKLVWTxNaoLAM13ETGlHb2AdKU9kERf/1oty7PbAeItWzid0Zbu0n1ksNUeRZrS00rblwxVfUug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOwOIWUo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOwOIWUo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJB2cZ5z2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:38 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so8142224eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480695; x=1795085495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
        b=cOwOIWUouNiyyVvqCH/XZAeXkbQTALYJnZMb5sEsB5d1QaF3urQKzufpqpK/0gMRh6
         XYoX+5kj/VWBiHpwhAav7O6TA7bziYwflQG11fdyTaMlP7oEKxQXSivd2E6dzqCQuuKE
         fdCo0vLdzrhf9m/dodoUKh2i0hSnWCF4AbmrLEiTjFYw7jWNt9hJ3aQELFxesOTOGzgq
         pourl1iImJGXXKLICWDcKd0lNUiTNwFLwWEX64fN04OCTgMzTz0qYFT6JiJbr/UzSsQQ
         i1M/W1Wa0jKksi+gmDZgpwUd+QobWgkoBPXQdZl7PR0QP3oNOqBjoiOX/Zr384LqXyCg
         YIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480695; x=1795085495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
        b=FRL83w+v4KdkoMrImcHAk1XCxWLLIJlsHXE953YAyr5BWldQI/9ClVTE9QY1JDSK+o
         ysPFxCY2VprQIKuThJBQv+eXfC/DoaTWeY+iS6/J3R1zf1n2j2c1m+sF7fJ3wZepMwDo
         AM4dK7Yw9EmmatPMPdswZUKOs87j9hTBxt4HoY+R6po4JkhIB0L0qxv3E3ApnOVGKkct
         Rg9RTcIOF6qmNt8fJeQu7fPVkykOpDAlgw1C4A1IBB3xSxaFjvLJh1Khcg8kDPjxzcHs
         sAy2zLSFG9SW2Cv0VMI2QUSyNIzy/oP/+3xaZCtFiaIG3OuBBLo+VNdLzDBFvjmfsM4L
         1NKA==
X-Forwarded-Encrypted: i=1; AL+hErGEkarOYRNVIAzvndHF4fM7Cke2SGxyqpYsCIYDn7rq6SpMWXX47aw8QLlP7tSY+0EINrNK5/gWDcmkTdg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8xZSNFt0uZ3jBcdWwLBzOQ06KaBstCnqKwQjARf+/JrhBRFBl3
	u1W/eGqoUB4LXkEf371sxwzGZmLhv1Fntzdovj+0SSsu/gO2d42jS52m
X-Gm-Gg: AYBFou1jLpO33DB/CT/MHavnThCKkjKqW6ojlM4pX8EUeU6kY4A6iFSbAG/hqByS1tL
	WbtGutLAT/2VZ/OIrK9uzadl1ugDGNRGeRHHS1+UfftFZP4LrJt67H/r5xeMW1wRX2kb/eFKSmD
	hTuQ723q5y/FJpiN/aYGe2KcASjB7dked/3oxpWzIO3xlMDQgLHT55V0N4/UIxnvE3cGyJbY+6e
	EJ4CmMa8B+33sLF4ktNvojgKXeezepqcS9hZfZQov5NfM722vdm4pS3Dy813fl9+7dRozgtDa75
	xirG+ELwAz8fXjz4oygKAEtiCAhOO9TPwk0nzBdDHLEZS8gtuHVonn7eAX64O/5SFDa8vriY4A6
	POFAG+mC1GTEortMyQWWZ8NA0f9wAsRGq3bLlsKigpz+QOF8VU29ZOkLLbT9hELNxdhvm25cqcp
	Ewsi03YjpmBIJ/OBZkNOk7KgFjgcKGPlhzGcF6yic20ZEVpDrNj4du7PtVWLJHtv8eUXimhP69w
	dgN0/WhXjESq3ILm5QT/QIQ12RFDMsL1BCmH3L36V6dbTA6zcHNNaLK1ZtffQUOKfBeVlTmNAYt
	v6AGYa66LiOmjKKMbCqHFpIh7g+KOVpW6hTxYHLIFH4136MdY8WrUIYEcCqqJOi53XL9JESP+6b
	v8gKD2cCfcNZj8tS9wwzdOCHQ6/WPWWwzsyhb2rcSareD
X-Received: by 2002:a05:693c:41d0:10b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-3768617d395mr5904378eec.19.1794480695079;
        Thu, 12 Nov 2026 02:51:35 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:34 -0800 (PST)
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
Subject: [PATCH 1/5] ASoC: fsl_asrc: Improve probe error handling
Date: Thu, 12 Nov 2026 17:51:12 +0700
Message-ID: <20261112105116.32274-2-phucduc.bui@gmail.com>
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

Use dev_err_probe() when retrieving clocks to avoid logging errors
for deferred probes. Also remove redundant error messages from
the probe function when failures are already reported deeper in
the call chain.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index faf348dd582d..055593d5d37b 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1301,22 +1301,18 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
 			       dev_name(&pdev->dev), asrc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to claim irq %u: %d\n", irq, ret);
+	if (ret)
 		return ret;
-	}
 
 	asrc->mem_clk = devm_clk_get(&pdev->dev, "mem");
-	if (IS_ERR(asrc->mem_clk)) {
-		dev_err(&pdev->dev, "failed to get mem clock\n");
-		return PTR_ERR(asrc->mem_clk);
-	}
+	if (IS_ERR(asrc->mem_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(asrc->mem_clk),
+				     "failed to get mem clock\n");
 
 	asrc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(asrc->ipg_clk)) {
-		dev_err(&pdev->dev, "failed to get ipg clock\n");
-		return PTR_ERR(asrc->ipg_clk);
-	}
+	if (IS_ERR(asrc->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(asrc->ipg_clk),
+				     "failed to get ipg clock\n");
 
 	asrc->spba_clk = devm_clk_get(&pdev->dev, "spba");
 	if (IS_ERR(asrc->spba_clk))
@@ -1325,10 +1321,9 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
 		sprintf(tmp, "asrck_%x", i);
 		asrc_priv->asrck_clk[i] = devm_clk_get(&pdev->dev, tmp);
-		if (IS_ERR(asrc_priv->asrck_clk[i])) {
-			dev_err(&pdev->dev, "failed to get %s clock\n", tmp);
-			return PTR_ERR(asrc_priv->asrck_clk[i]);
-		}
+		if (IS_ERR(asrc_priv->asrck_clk[i]))
+			return dev_err_probe(&pdev->dev, PTR_ERR(asrc_priv->asrck_clk[i]),
+					     "failed to get %s clock\n", tmp);
 	}
 
 	asrc_priv->soc = of_device_get_match_data(&pdev->dev);
@@ -1443,10 +1438,8 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
 					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+	if (ret)
 		goto err_pm_get_sync;
-	}
 
 	ret = fsl_asrc_m2m_init(asrc);
 	if (ret) {
-- 
2.43.0


