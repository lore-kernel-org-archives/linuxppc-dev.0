Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED68C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 09:47:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0CD206F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 09:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SinIXReR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0CD206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6CGK00P1zDqkT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 19:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SinIXReR; dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6CCx0lTBzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 19:45:00 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id k6so1757619wrn.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
 b=SinIXReRv8gqiSN2QfRyGZoxeCSVs1tW6IJ0fPIXqJKyYvSmw8FpS+EVBSF+0RW2Sh
 ZfKeXn9lmtbB+SD4BCJTJtQtDjyF2+P5LA2TO/WhKm/a78apZ8l4h9DB5vNSrDY7ImIu
 27zi1mRvX6cZpJGg/WmAanuUBKuAlFUU9iN8VbKWgpo540NBthUPbNZPqtKKMlWE5juh
 Ut84YQeS4jXHNSmflZPszNc5fOGAmn02ROdfQGAteYwrd9dDC6lrCh/JloCEggU+Wffe
 XRSDKtOVNA3pnZjeWEYAlDKuTayNQ2dWFNwMG7b7jH0R7Za1vatKApj6jDIhtjHreS2w
 RZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
 b=ksvUNYi85yn+VyGdhxcnhwbNRaoTTgIg06Ru8kTOT8PmBbx8+/SY4T7BIKMVi3rN1K
 Z/JcD6SZbMVNHMsfIWsQdB91vKsKnC6zEhxGbdNHCiD/C9B7OSZ/OTEN55GIlXWiXE03
 11Te6zmzyFqUw6NsEBxrNpCU27L4LsgcLo5mhjUg4iSO5SvT14KVqxBNI7OQCX8zHRLC
 ZdEjnBK9rNz9xSzOXeJsusCO3lSNoVEJ3DC9ALjWXWMwMuHOtAjB4ht86etNyPv2YTq/
 jvnPzMd0nxUzaP6YTyjf+RazNPwqLZyFmdecz5DVB62gcYqCxfpSO0wilIlIiO/MluOS
 GD/A==
X-Gm-Message-State: AOAM533cfgMU/3mfzMZnWjoLZJpA6KJMEXiJke8+nfF92lmYtFAEffVJ
 sGSRMvHwjlx0HQKj8H2Udn0Taw==
X-Google-Smtp-Source: ABdhPJz9iEgW39p9NP+x+8HK/WX7+X1jz9XTLGQ3OWUni12lXxbaIHvRiJa1hStnOPuDJMtNRKu1oQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr9877312wrr.279.1594806293824; 
 Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
 by smtp.gmail.com with ESMTPSA id r10sm2774916wrm.17.2020.07.15.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of
 'exists'
Date: Wed, 15 Jul 2020 10:44:47 +0100
Message-Id: <20200715094447.3170843-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
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
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index faac6ce9a82cb..399c9aad48b1d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -92,8 +92,7 @@ struct fsl_asoc_card_priv {
 };
 
 /*
- * This dapm route map exits for DPCM link only.
+ * This dapm route map exists for DPCM link only.
  * The other routes shall go through Device Tree.
  *
  * Note: keep all ASRC routes in the second half
-- 
2.25.1

