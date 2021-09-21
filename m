Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EDC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:19:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54FE60F38
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E54FE60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDZ7j4LTTz3djP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 07:19:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jU4XvWbo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jU4XvWbo; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDYyl1XpSz303f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 07:11:59 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A724C60F38;
 Tue, 21 Sep 2021 21:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258717;
 bh=+31WT2YpLY1PNFXYWVUJANX+51GF0audki7RRoE2ToY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jU4XvWboZSzRPKhb/vn1o8OuJnTe2Ny0E2jx4Tf53rwm256N9xgl+zasRtk8ZroZJ
 11qElLnYgEg297JHkJJSYr/LEMmrCMSWx4Dc1M55boV+oLSKKx+FnP4ty9R9dhTXGV
 TooIeChgV28w/kaYBdSnisNZTQMyYYag+of+sPy2H0Vp3lWg1RmQMY2oxSU3IpjpMy
 41OcvZxyOzjubg5J3BVAjRsMWNhf2fTIeUBCKLBs5TFq2vbLUIQKYvag9ZunLs/YzW
 qo7lRKFGJPFaCAFnmRC930iqc/mACDbUzXKZNFgXbqJ50TbontS94/3iN/caL+aOuS
 3sdpip5mvkVbw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 13/16] ASoC: imx-sgtl5000: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:10:37 +0100
Message-Id: <20210921211040.11624-13-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921211040.11624-1-broonie@kernel.org>
References: <20210921211040.11624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; h=from:subject;
 bh=+31WT2YpLY1PNFXYWVUJANX+51GF0audki7RRoE2ToY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSknlajJbtErs5M2JHhrPL9v3ObE8KSKu2qOqnXTt
 /WwinpCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ5QAKCRAk1otyXVSH0KjUB/
 4v2feYY34VgPgN0A1XUuH5RRkA+dqcx4F9O7LxEN2O7Ip/BGUMaDASCQpHTMyALpQUA1XNLGcrSono
 Cl8g6ZYK8//R87uzsiBBxgzPJOlDLYabFjDgwB8/o2R/U0Q9P0OowPjZ0BUMVulOeogPZ0G5vuCXIi
 juVLZ/8n/xHzcU/ANZ4IT4wlDYNk8+2RflNIVDMwEpnhYBy7azn0/0lTtGMNItGPMz8nUXis/BB6I1
 5ZdA0CA/EoPtdnyplRNJ+IvRl66nVw7af0KicT/eNoaQLqiBbpSpJQtV5B/6ZM2boFNqhGx5090Zax
 wErUjnSY0/++1GIG1VweYi/sBz29ao
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As part of moving to remove the old style defines for the bus clocks update
the imx-sgtl5000 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index f45cb4bbb6c4..2f1acd011042 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -153,7 +153,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->dai.platforms->of_node = ssi_np;
 	data->dai.init = &imx_sgtl5000_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			    SND_SOC_DAIFMT_CBM_CFM;
+			    SND_SOC_DAIFMT_CBP_CFP;
 
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
-- 
2.20.1

