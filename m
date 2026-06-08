Return-Path: <linuxppc-dev+bounces-22199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF184CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYtSs066Nz2ytj;
	Mon, 08 Jun 2026 23:39:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780925996;
	cv=none; b=clOudt7DrZBZ8KgGrxa5nKHVu0u+CpAMfLP3XneliVG4FnRObT+yzQLq4PS3udD/fgQIngB3RlAjqxW948K7nPbqLQcTkaiwJi6FixZRNYfcSV0ryYuNpNOwFfRhLJloc+CkLmj8b1pLwX1pC/A9Xk+b58/H04DqgGrDf4hwUOQ/2/ks3k9H3zgv4K2Rvp3LY9UyYeTKEIljg5TikOqHNNjLRwz6K+guHSsr169PRRQOX0mrHJ/njDsQ0nqDurEzx2UNEfT6ar1rffhwno8eOVqbhZEEuo/cb/5xop54YYYkmjrXIi1rqm2Dui9TxLB1XewJvvtMSI7b8XcuZmAoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780925996; c=relaxed/relaxed;
	bh=v5KkougDEniPNaB4zp+jheULTstkgfTv6Bq66fUj4K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZeNApFVtjDR3NA/wLjrbO20oV3RjvfWY12hdcd/7Ss8U9074s0MKZj2+6arzEtuDd+YywnIShXNA/1l1sgCyyDidK2UZcxBAtGiggsrp4co4rqkMUPz6FrWYxsQI6bJRLGt8nI2bsQryLfSHzHkF0QwfCr0NBPQf9bUX5+JBXac+2ol1iV3FK3GyTFyrCrqut4BXuAngT27dltpAwNmlq3t+oiaXESBR1hPPAJsQCu470DrnP+Bx9lNokyhEBxFMYSQK3OQcqPi3eGR6swu2H3G3LObT3DEiJmGWpwnEaOk9fV8zJG/jtut0YApKL7jtgoqGFZwyIfNbX7o5tF29Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ypq3V6Km; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ypq3V6Km;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYtSr2G1wz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:39:56 +1000 (AEST)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-304cf518c9dso5175677eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925994; x=1781530794; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5KkougDEniPNaB4zp+jheULTstkgfTv6Bq66fUj4K0=;
        b=Ypq3V6Kmeil/WWH1Ja3Sbf6cbDu3cV5dw1lUPJThQDgBhsexluICphw7SGzqXJ6iLy
         smxfBs9SZa1K7shyKF14ARIy6sNZ3W+1zl6lAgTp5L+vCwuCE6eodCAwN1eiUbVQgLmp
         /jxg73sNg3/6Nv1uo4gRSwJHNlYwzzInzPOCp8NeuWlx0ZlfgjgufkIY2656GPcRRMG1
         IZRZZ0Bn1sHvM15B7Hxh1MqnYZuf1hl/Phu6Te+alIrch/e7DzZB8/HDmnjfTThlozP0
         6shveA9w6ecrj3LmGhW3RzIznPZ0p6CYM9gXwIhBy/fxq1K03mRhMbHGCYrwGGDzPklh
         Tx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925994; x=1781530794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v5KkougDEniPNaB4zp+jheULTstkgfTv6Bq66fUj4K0=;
        b=hJMXqW+aFoBzS9CXOoyQod5yhJIn8gvAuuP5r6KYwB5GovKb09ylZwd4frCowZyf4f
         oIGTC6war0GWMCBtYeKuINcYrukIugvsUHB+TDhhpXpT4GetPtbISSPVH9BcY5bjUw8g
         ncGE6DdenDQhW5d5yv6VKcWV4FW8YRK/ArveQhZqi0gISfw0bjRMwTVKy+PStolSca0d
         lvTv+FzWbqCSd+plo1Hfz4oVLa5im5mPXRM2WpufJr4/+7eqDeaxz/qtbNoUQCxGXLCI
         Ejg4uPUxr0hYMemmUybOpSGzH+I7KphZSxVoGI3aeJGrNWu+0I9+S762MEDhLieXLOg3
         ZsBw==
X-Forwarded-Encrypted: i=1; AFNElJ8lAXvq2ipZUHYP98ECMmrKAZgDc04tgHqD3DrAfVeX+mXr3MovzTZkMyT0YrtZRXM2+t83I6eOf4UKwjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzEN1ki9/SF7rUtIiOkHysOQHENWxz4jNVPopJuFCS7VkChxXDw
	JnUWm47u7s9mE3uiBWTOnSAHom5bSHmQcRIfAy/Iyix62f7NXfwE4sft
X-Gm-Gg: Acq92OHLbUQg16OcocRtW+OOGELm7xmeRnqO3wV2fId5SEVZypLsc73JtyhbR8XxB11
	0zu8/Rd0jhmNZ/r6h7iRXzZruZPMgLKZ24QtOKlXZtDtzSryP1yv+eugjyGzG0qoRTQDQsRng2a
	yZm4W+/0V50RRgIsiX7wqYCfQBmKiHyxoUmaL7o3pC7PhUgMHZBDFFEn2NwcpBW2GLIl8Rswzvt
	BUPgOTqW0GqXzIn/K16sVm6+4fMe0LKO8zGVOpoKRChztZ2hCotoSAP7lPS4zxTnnD1O6E7ovdw
	RLQ8dT4/mi8rrB3x0/SzMRmSn2phSh/LP0CaDwuFV7JC5lSwAZ/snzDE6fNZKu9xzHWl5eTlVsq
	wAsn7mWOBG8aRQgaRcpiLZssPYEb/9nnWaR+3TUjd+FJrn7GEPoPbMjIUeTr3byakWRyFdcf71K
	lUuq2WJfkeOjPQgzf7OcG8cmRmseHZXaVhAo/oiOjoqmhPlGaz15qn6aEjWjS6PKbH/YPR5zl6G
	YZQIAyPJnXq
X-Received: by 2002:a05:693c:3003:b0:304:d835:27f with SMTP id 5a478bee46e88-3077b15d304mr7307289eec.22.1780925994137;
        Mon, 08 Jun 2026 06:39:54 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm23893449eec.5.2026.06.08.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:39:53 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 08 Jun 2026 10:39:12 -0300
Subject: [PATCH 2/3] ASoC: fsl: fsl_qmc_audio: use scoped child node loop
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-asoc-of-node-scoped-cleanup-v1-2-9e3ac518dc2e@gmail.com>
References: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
In-Reply-To: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=MCx2N3prAUvO8MqB4noVmeheqznOyy7WsBMuY4aEAtk=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFlqxyQ6WbXOHZl573lk8fKZWS9rEjeZ7J/2YxvT62vSk
 utzDuowdZSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBE3n5k+Mm48r9C6PqddYW7
 uKUX3W660TnB1a/qr6303zidBctYjqoxMuyLmB/7u3zl96m+jSwPQpazaHlsyeq94VPsoy/x/EV
 /FzcA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

qmc_audio_probe() manually puts the current child node before returning
from the DAI parsing loop on error.

Use for_each_available_child_of_node_scoped() so the current child node is
released automatically on early return and normal loop exit.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 76e014dfb6d7..d0f644573f49 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -905,7 +905,6 @@ static int qmc_audio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct qmc_audio *qmc_audio;
-	struct device_node *child;
 	unsigned int i;
 	int ret;
 
@@ -931,14 +930,12 @@ static int qmc_audio_probe(struct platform_device *pdev)
 	}
 
 	i = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		ret = qmc_audio_dai_parse(qmc_audio, child,
 					  qmc_audio->dais + i,
 					  qmc_audio->dai_drivers + i);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 		i++;
 	}
 

-- 
2.54.0


