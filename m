Return-Path: <SRS0=Gm8F=VT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C7C76188
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 13:07:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051ED218EA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 13:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051ED218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45shjT22vvzDqWH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 23:07:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45shTG47P7zDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 22:57:05 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C5251A01FE;
 Mon, 22 Jul 2019 14:48:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F1E11A00AA;
 Mon, 22 Jul 2019 14:48:56 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net
 (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D54E205DB;
 Mon, 22 Jul 2019 14:48:55 +0200 (CEST)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Subject: [PATCH 10/10] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Date: Mon, 22 Jul 2019 15:48:33 +0300
Message-Id: <20190722124833.28757-11-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722124833.28757-1-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
 viorel.suman@nxp.com, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@nxp.com, angus@akkea.ca,
 tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com, linux-imx@nxp.com,
 kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 l.stach@pengutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
at the beginning of register address space.

On imx7ulp FIFOs can held up to 16 x 32 bit samples.
On imx8mq FIFOs can held up to 128 x 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f2441b84877e..b05837465b5a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1065,10 +1065,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.reg_offset = 0,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 16,
+	.reg_offset = 8,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
+	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
+	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.17.1

