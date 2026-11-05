Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB84606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/rmcISu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzRv3wT2z2yTK;
	Thu, 05 Nov 2026 21:43:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875403;
	cv=none; b=GKM7Etz2gA0qssRPiV8jleEXqmFAkB8WqLVgorqjwGwCEGeWTHHXzu8TF6Jji8ZqnvOCiVNrh2MxoyK0+7edPMyTxv7npqXVIx34WNK1QvYAYeAxUzZfKeLLP+9/Bjb0tmpgknSo5mna3YduSsrYGboqg8y203iJDjgWL061a4KCGfYxCsRdK76ct35PFudKXuJUpjxQ/IB/ZBafleu06fQ8WFUBlSsjtzyZiG/gGwugVBYwrv/qLhVj0kHSCf5kABbjrsmuDCau7tF49Sgk11Hm6LEiLqU2M2LIxLs/SSAYbH1+jI3nkJAjLHgDV7IjvydN0ZhqAojsuvtVRS0rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875403; c=relaxed/relaxed;
	bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIaMBjlUHKsY637h1QCBQke3Y/mIA5lyxVvlkqhIloQrAWbQLoLQSJell7mR9IIzDxLkJYcXdA+hwuiUaEyyyRZVTpWVzv4pXbAL0s8K/x6bImR3IdbwDxDcuShHYJkFCuIsQr1K2v1fWkOGHB1VW4XFcHyeSSSN0q0UrYSEQaQarVac4HxICIO+6uZaebF5gAb7SNLIJPqBoI2qmQI9FMwdhsZBlMXIi/kJTAjqwKL1yle5nFSR5cLCzCyoYOc+Le4JOtJwsvU/bq0UadbaDLfWdADONYlXYUCw1f0n1X1UMEDGblAp3RP2k4EXJXvTV/iOsRReN2UGTXPGzBT/tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/rmcISu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/rmcISu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzRt75PGz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:22 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1b244fb7fffso2315560c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875401; x=1794480201; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
        b=d/rmcISuPeD+QX4I8fG/jmYmMpqWIvC1VzEOz4OH3aOSnnGrX38DlUOFHvfHqAYsSN
         kNjvLxeaXive9Cb10gyCBbpWvc2xX08KeYubEPW/4sMAgCziz9qDYB5IdMNxehN2U8zP
         TFKCVi6OTJywrgAXdYAUPudWKUfuTPPOnQxJuaMeGReitwD5UPjIWflOX+gfQ311B9eL
         xC9OFlngMRQavVi0L+eCcW9wrm7mF59bNQOgswEcW/n5DhMfzgFXi26QLDT9VbV7WoSc
         eia0xBdNgcfKTEjVYCK2A5O3l0p7gBvho7gsmnqqA/8ZqjtV+ayAgqZRhXtyp1qG+4y1
         Mqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875401; x=1794480201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aTbOMPeQQR/WAw575MjV+whoOIimG2HfOgrdg3UiGjw=;
        b=p/oisyCXp77I6CvggRLslC0P5dQPwhxSuriTEugm25ttRFoVtEDzfHhX3IR7c3sQVL
         jjbR1g2szv7qPfXjNjTSLRxNVbqjzkMKSNJUXqJEsvGgYQ7rNv/YXeI8nvfGFyOFbiVv
         C5iKLQ7n0CH7BUt3zk2IYL5MMzmoltU4qUEP4j5G9135aedQYAYwRWGvuDqhsprTWxLq
         gRHg554EMHkLMOT+WRziidlklQ6zxTJ36Rec4ExIaP+gibk6A2m99UCtVdnaOKzDviRz
         ygqwt+J12TF8J2joy+dQ5SVwjrZNr9qqPctUgtksjBMAiFxjdqte9MH5MFo9NXOceXSZ
         0rVA==
X-Forwarded-Encrypted: i=1; AKwUvBy+15q4j41yejyOUG35y+y9Oo8XnB1XC5G7r1skCd0bB3mr+tnPlOUwQ0aztjlXcBdWqWLASklTClxalEQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8gxseR/GaA/ob7fE8ksYCv6hJ0pc75vTARfI8W4TW3+D/ZhdSl
	AaoZ+27ZeSz8ZWwu4o+iqNc1cMfti9VxkFw4zLB9JZmK7sKcssV4KBqH
X-Gm-Gg: AYBFou100EYxaZ1Hf77EA7caBSsALRidm+p77PkmWlnOyEu0Za2DvU+cOR/Hy0exN/U
	EuIj/Akz1rL2M9kgrkq61x29PDvXJboWKuXC3GDHDLXNbuD4vFDxtLP7wkilUS4pA1MmJYnAtRG
	GzyCSUBzmM6ZRBChRI2Vm/1WKkCVDn/X0rAy5XWTh+lXVXuBmCgOoLezP7zX24i+/EpZqmQkxcT
	1UTcHbKoEtsopdg24hTktcqPN0frym+nF99BgvrwnOQ3vZoCf7tS3jQ2MfapWUFSw+Cl/UZWk7L
	ani2KahZKjIzKsZK/nu+XEzf+BxAdFbuRsQF6djxmv5Cgosc8f3h/eIXrD3ToyhurzaQYpXZ8M2
	SuKkK4WAC6OXaWOSaNyySGCAYqaXKVEoPonikoCxYuGZWnHgAzpot5du696Ru++rMyjwJhn4UFH
	6GMoaTxezOvT6+Uv1lpr4kZDmp5ivLk527Dz6FjJXjSDT1aJAT+r8jhl6O+I1eFwisfIkkE47oM
	bzkjPy882ONOa1ClDVRVFvkcLwcrqzhtuI2muMkMiN7N27WJ6+ab7DwnJOpV6SD6uk2/g9yvx9Z
	ib6C1Xr2a3+QM45r4km0KK/puMCJeqm/0quLOTivZBTM9/0p7PvP7HjDmfmlOoXUap1Rma0sBGc
	hBF/SL7Cf91QdVsZJjoykTnDHzZRLIVzZ5gGIDn0kkuLn
X-Received: by 2002:a05:7023:d04:b0:14f:4b01:40a1 with SMTP id a92af1059eb24-1ac4fc00dffmr29448840c88.0.1793875400690;
        Thu, 05 Nov 2026 02:43:20 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:20 -0800 (PST)
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
Subject: [PATCH v2 02/10] ASoC: fsl_sai: Use optional clock getter for MCLKs
Date: Thu,  5 Nov 2026 17:42:29 +0700
Message-ID: <20261105104237.38542-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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

The current code uses devm_clk_get() and sets the clock pointer
to NULL when it returns an error. However, this silently ignores
errors such as -EPROBE_DEFER, allowing the driver to continue
probing without the requested clock.

Use devm_clk_get_optional() to handle missing optional clocks
automatically, and dev_err_probe() to properly propagate other
errors, including -EPROBE_DEFER.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 042885ba415e..44a34f48a0cf 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1589,12 +1589,10 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
 		sprintf(tmp, "mclk%d", i);
-		sai->mclk_clk[i] = devm_clk_get(dev, tmp);
-		if (IS_ERR(sai->mclk_clk[i])) {
-			dev_err(dev, "failed to get mclk%d clock: %ld\n",
-					i, PTR_ERR(sai->mclk_clk[i]));
-			sai->mclk_clk[i] = NULL;
-		}
+		sai->mclk_clk[i] = devm_clk_get_optional(dev, tmp);
+		if (IS_ERR(sai->mclk_clk[i]))
+			return dev_err_probe(dev, PTR_ERR(sai->mclk_clk[i]),
+					     "failed to get mclk%d clock\n", i);
 	}
 
 	if (sai->soc_data->mclk0_is_mclk1)
-- 
2.43.0


