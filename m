Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE2C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:21:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A8920989
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A8920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43999G2g9PzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:21:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398W63DZSzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:30 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id a11so19778838otr.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ThQ7RT0snc2eXhKBllFE/yVobWH1ZvOxkwfOj6s8tE8=;
 b=o4tCqymkhD7YMjwIFiPfWYVwCcIjM8VGmF0ck6SGtdO0VhxskWqffVAXg9UPKGduwO
 OM5ioXtGl2PvTCkAlODTic9/LE+aDoMLGFsYNw8+AxYg3Ispf8JVSGTnlcthfRa7PrV+
 b87UnQGZvn2VbrmZHk9UC8C6R3WMmYnm6LEH0A31DY4Ph0VxHAbxGt3Juk9DlrItyb3C
 n6AlkN8Jk/22cUmE1bWOHxjk2bZ6mxI3Gk97Nu2rxsL+Ma3F52UUwDVQ3Np4e2KMgO/U
 Lqbs0SgxOIdReD+15gmhwNHx7dAyKST88z5IVJdF6x8ED2ibU5q34KSbN5YeMXXZTW+v
 1KYw==
X-Gm-Message-State: AA+aEWYNiUpXQgMUM/3FNFwvXvEPl8knBvdflVkXcVZsl69wVDhhDVca
 5TWV8ugy6tbaNou1IIcGTQ==
X-Google-Smtp-Source: AFSGD/WpzdhTG/04KfFGOZWhkfcbxlLfUQArESSierVbdwONFtNtAjGMAkfqvVdxhqqgqIJsIfGAnQ==
X-Received: by 2002:a05:6830:13c2:: with SMTP id
 e2mr15266877otq.15.1544039488275; 
 Wed, 05 Dec 2018 11:51:28 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:27 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:49 -0600
Message-Id: <20181205195050.4759-33-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For the FSL ASoC card, the full node names appear to be "ssi", "esai",
and "sai", so there's not any reason to use strstr and of_node_name_eq
can be used instead.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
 sound/soc/generic/simple-scu-card.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 44433b20435c..81f2fe2c6d23 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -571,17 +571,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
-	if (strstr(cpu_np->name, "ssi")) {
+	if (of_node_name_eq(cpu_np, "ssi")) {
 		/* Only SSI needs to configure AUDMUX */
 		ret = fsl_asoc_card_audmux_init(np, priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to init audmux\n");
 			goto asrc_fail;
 		}
-	} else if (strstr(cpu_np->name, "esai")) {
+	} else if (of_node_name_eq(cpu_np, "esai")) {
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
 		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
-	} else if (strstr(cpu_np->name, "sai")) {
+	} else if (of_node_name_eq(cpu_np, "sai")) {
 		priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
 		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
 	}
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 85b46f0eae0f..e9a1acffcf5b 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -216,7 +216,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
+		if (of_node_name_eq(np, PREFIX "cpu"))
 			is_fe = true;
 
 		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
-- 
2.19.1

