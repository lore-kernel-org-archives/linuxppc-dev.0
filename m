Return-Path: <linuxppc-dev+bounces-28290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF18C9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 00:08:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hslBq3rbKz2yr0;
	Sun, 27 Sep 2026 10:08:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790467683;
	cv=none; b=TPg+GR0CZ3TvbE//WiMdLYiuzdElh3LvegVAtvU6zjfaZRWf+KpzGDgSj9rZFjzDOZKBbq/p3uoUWP8pPLR9Rlg2kKtF8zaZt4IzP4ZwGMgAEVLELTVV6Ns0AFdaJTqZNhNRFMm2Z2RU9O6l8tVoRX0w0/+bkpavSF/FObnkF/fFgozG4AHuc2Y38SwO3Kg7zyyPKcY3eZ4zcsHMUdyEpt4F4V+K+tJTDpfpjOobNlN+74jpyfRZmZ0T41u5Y4e957lBJlaXhF1j3hkSkAtrV/RfOFGSD0QaDbsXZ0LTGjzlS/HjYYENnCehGEwNQMHZtMUFLsGXK4Nwtm367Wwyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790467683; c=relaxed/relaxed;
	bh=Ml7jgvZEPQBNcx9fLsK9k4wmKlEvGi66dtLDkClqgKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTO0eIdhHH5P3S12qO/jc+mVwbEjNRXj3nDoF6mHcKJB/l6ObPSxfUR5TGWA3JRiIz0XieoosR68st5liIQm5iZ9mYFZoQAj0UFcnnTHDbC4F27Dqdo4Osapy/rRJ1yiE1nfvaQuhlPsAB2Rl93WchgNOEqLWrNyNYcUN5Q7DEObQwGFHazI9DCI5A5APDOLjX0ekZbExXRjr5CD4ShTg78B+jsAEJGwtVfxt8S+ttLl289DQyhV9aqfcT7SSLbfWLqVUwG1RMYBTCjHWejndMx0rf9LC9Me3yrgiKV6gum5E/ehmKbJhiC79Dkaqr4D60frG44k8jEHr66pZn9m7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=QbF4QyhC; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=QbF4QyhC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m155101.qiye.163.com (unknown [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hslBl6wZnz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:07:56 +1000 (AEST)
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f363ff90;
	Sun, 27 Sep 2026 08:07:39 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: shengjiu.wang@gmail.com,
	xiubo.lee@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: festevam@gmail.com,
	nicoleotsuka@gmail.com,
	error27@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] ASoC: fsl_asrc: fix second front-end channel check
Date: Sun, 27 Sep 2026 08:07:38 +0800
Message-Id: <20260927000738.10105-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa0e03057b003a1kunm99d393ae198c63
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEgdVk1NSE0dS05PGU5IHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=QbF4QyhCjw6hG36cGPxr6IHjhboHEUGFsa4OqBkqdFogpp1Ww3yyYkkd6hqPmAYnwxyUxJ8c5foEYk/eqh9HuQBdP6m6pYxEPHOjeGtWlHSLuL4UI1ZFmALhwh0Z8iM/mdguRw5Dt8MxGcAbRF2XGSUF8fXbiYLReV8ehEUEVfc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Ml7jgvZEPQBNcx9fLsK9k4wmKlEvGi66dtLDkClqgKE=;
	h=date:mime-version:subject:message-id:from;

Commit b045248399d0 ("ASoC: fsl_asrc: Replace dma_request_slave_channel()
by dma_request_chan()") made ->get_dma_channel() propagate error
pointers, so the !NULL check added by commit b4136c0d69ea ("ASoC:
fsl_asrc: check the second front-end DMA channel") no longer catches
failures and the error pointer would be dereferenced at
tmp_chan->private.

Use IS_ERR() and propagate the error, keeping the release of the
previously acquired persistent Front-End channel.

Fixes: b045248399d0 ("ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 sound/soc/fsl/fsl_asrc_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 0aa5db8973d6..097a0d5e8b31 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -251,10 +251,10 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 
 		/* Get DMA request of Front-End */
 		tmp_chan = asrc->get_dma_channel(pair, dir);
-		if (!tmp_chan) {
+		if (IS_ERR(tmp_chan)) {
 			dma_release_channel(pair->dma_chan[!dir]);
 			pair->dma_chan[!dir] = NULL;
-			return -EINVAL;
+			return PTR_ERR(tmp_chan);
 		}
 		tmp_data = tmp_chan->private;
 		pair->dma_data.dma_request2 = tmp_data->dma_request;
-- 
2.34.1


