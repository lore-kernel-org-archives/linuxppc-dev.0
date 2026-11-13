Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4389606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGF1QZj5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldK05fvz3bYx;
	Fri, 13 Nov 2026 16:08:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546484;
	cv=none; b=PZjDk82bbLb0RLQ/ltwSt0Fimjy0GzNK+ABY/n9nhm0Qr06IkFhnzCctcz/BNMWeladuXa0hRYfKIxxXkQm4FLbJzUArYwZF4yEN9efeD3ksZ4fuhjnWRKRzbSjkOng1NZG1L6IQ6Vo+xaU5NMcEyhrazlS0NjkdAjGJ/fC7jeiXa8q8IKZDEJxxJlA8cLLZKUp4V2IkGCs3PA779B9ItMqAn6fvfCiBghh7YCJOpdzPF4jesEgRHbES2TvgGZWqv0YjG2qLRA6BRQAnzKj7AAhCzfs5+rMGV5ygo6+DQ3IExK++iZ5z99+y9Iqxn9vSMzLmordAXe6ya5nG/UOpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546484; c=relaxed/relaxed;
	bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7q7luVX3eefJr7Wy9BIBvsVY3vBoCp6ZmsrVGGTku8vNcAHa+0cdhFap0OKLQAoFfiklT/RwUC1HTzPagMLp9J4dyBdfVA3WUUyVQOqba3xHF5O+xZ/1KtwyHHMoC1Y8ks/1TWyjCDIY4Cym4ZyPkImnUaQW0Nq2C+NzrL87SRV2bPDZiw166GoO/kqbQw3d+qnOABKggkXTqQaPGKmPqMJb/yoylxPFfzuCrvxjl0SISe5VANFFZ6DEF79ynOT05NLPNPNeiQJ9Gx+mBTIrS6ZzjZRoT8XOY6Wkd+jPrD6m83KQbUGUQEgvWmTkLouk/IqZT6/HKR/qQIbHHhPmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGF1QZj5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGF1QZj5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldJ2jKCz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:04 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso625537a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546482; x=1795151282; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
        b=FGF1QZj5X74HrypzVcBXYNLM1bGFNFKH9tldxNH/FDNWRSVgzz4iORSnaWtg4b6J5P
         Myky3+qD9Co7k8kdUdAp40DDQ3AqSbnRNLE5a+tDHGC0UF04gX6tD1dEh0m3NqJ9LBt2
         RaQ5MiswG07KD4aiFViFzn632WwkcweuNMIbUOKUHqph3Zf58l0nZHXaw69IZavXWZXC
         YiYBaNSHWKBTZ5ivgHkaX5UxmQrLNHNB2TUpqzJ4CpFth7S/KDtN/GtmOfN8SIIfeSFi
         k277biJsdKdiLmcgaUDZAJYa0sc9owQ1W0UDNDEsJjvD65NXl4GvZxVR2kYPygBsq70+
         lLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546482; x=1795151282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+bOEewGQp4neyd9SSV/bwg/g3p32KtwElAVtEDUsaQ=;
        b=qmlDAdVzkNMqvssrE8NxDKyG7OP86uZ0TsF2PNh769M2d9AL8/fyD95u+BZnVrSANV
         wOh1N1CZQFVF0tn0cKs4SrGCCGBOI0+WepDDBaAHEk3fI4P7mevV4ULaD2RSvATdoYZZ
         Jpbv56OLuSg26Ita3j3X90siWC3SpbUSwk5+GYWqfQplDnwTieyM8JscOagzVFzj6tGY
         1u92dNNlpOwyMzlkVXc5xXzgTMSgl32jh46AGovtFDP1O1L5d5uODUg5uXpwA/hoSpXX
         hRE7InnA0tIOwmP7EnjdUPAjm3QbM/TLqycex6jSlPGqHE/laHjsVpPbHwLVhEcz17MO
         Vg2Q==
X-Forwarded-Encrypted: i=1; AL+hErG3MK3AZHcXUf/4C0MHVKkbK3TUA6DQFJigGXG8sZBPZo6K+kR/80/bntjHULGHBFzdaYGUqJudFbWO0SI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9gbHZXKFOARP1Z/EUGn5IeR23NrYhIjgtiPKb9zz2LbIyWF4P5
	7l+wPlOvXP/9HtF3h1oWu/wUd6oG9Fh96M1n8L38ek33VN8w2ALQr945
X-Gm-Gg: AYBFou06CPnPl7oQ+Aq6yOdNTZMdARws0bdm15NkghPxliT6IId9KKa64i+62Ud/EYc
	9dbm1Lv/NOGyXibExBP7qOgpCJ26MJ2uyc2gvtomLE/ZlImu4w6jbeRCg5hRYe9UMLMKDdEei7v
	xADt8bRqqviYyIMHcX0k/t8a7Dvm/wkdeAUyIpDGyepuQB8sbU/9wpE5Is4vhGMEbMI37SmGKaa
	pXye0MFPLNQ2hwnKcNPpvYlW5ScVS+Nn5JoT6KAj+Ibnpei1Pu5YDhldCktF3Jxz9Nv5xgICqRF
	RcnTPUquVHVDbWaO8aAS5/K+1fZrAdKjBafUBhXaqw9fTYAI5GOrZONwcsBVECsO0OaBvP2a+4b
	UeA7aJ1RJbN+lol98JVk8jGc42KPCIUzrz7JVR01UeSJz6DSgcnrHq3MByEk+kaRxvr0GnU0WRQ
	oPp0J74e7qjjoAzeTMgj34OmNlOyH9bYJZO85HHUhqYPyeuPijZa3HXBq4+arjixmOfbfrK7ke3
	V1ODyc63z/bRs1E88Jlpz/FQbwfxoe6RG1YDWop9K8MKAZdboe5n3bNtAmEyGFbo4kVO/HoSAjD
	fgqOr2AoQlK0Ol5u0LkVUrr4AT/GrLTFy8KrsehfRCwqp9A4cT+UA+A4CHHvcfJTTxK4YecCYKT
	NQdaqtTU2RR0dRSuYtD7dckD1cDQKZFs7m9LWQ2Cdb3wY
X-Received: by 2002:a17:90b:1cce:b0:3b1:3598:f881 with SMTP id 98e67ed59e1d1-3b1b0a4adbfmr1144305a91.53.1794546482206;
        Thu, 12 Nov 2026 21:08:02 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:01 -0800 (PST)
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
Subject: [PATCH v2 1/6] ASoC: fsl_asrc: Improve probe error handling
Date: Fri, 13 Nov 2026 12:07:22 +0700
Message-ID: <20261113050727.14053-2-phucduc.bui@gmail.com>
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


