Return-Path: <SRS0=wqjX=GC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6BDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Dec 2020 15:47:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D372B20725
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Dec 2020 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D372B20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5bJH1qMwzDqLq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Dec 2020 02:47:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=arnd@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HCKeDJ0K; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5bFc543YzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2020 02:44:52 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 413BD20725;
 Wed, 30 Dec 2020 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609343088;
 bh=B6KEEyF4RQKJhn/Tlgm2gPhwOX1a1c48tzMAbskoqNY=;
 h=From:To:Cc:Subject:Date:From;
 b=HCKeDJ0KSZ7nc1CoEISb/ZRNzccPTaWWh06Nn2VIZBsId6eP9cn0oGFUJlOABZZZO
 iI0X3/jv9pxyQ5bU7W/XqVpiwAVKTetRviaE1CBU80GpLg/jmLlz66OeoO4ZhibBqQ
 PjjjdalMW1Zz2BoWMBZ8kelnigjz4DMVLkz9RLZvfhx2BBPns1SB0TRK+cYujQxlOH
 8MnDwDJqOqRtqV2yMQCPacw1DfF9pBrJ/RhsJA8R+VJ3BdV7xvpCIPfiT77gwd3boZ
 PiTBMWGGCaRfDf7RBRjRMAgbFOqHd28vArCHhJoja2QAirqWZnxT1vUTZKPDO8Anij
 h3IyOvDVmuzrg==
From: Arnd Bergmann <arnd@kernel.org>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl: fix -Wmaybe-uninitialized warning
Date: Wed, 30 Dec 2020 16:44:15 +0100
Message-Id: <20201230154443.656997-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 clang-built-linux@googlegroups.com, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Arnd Bergmann <arnd@arndb.de>

Clang points out a code path that returns an undefined value
in an error case:

sound/soc/fsl/imx-hdmi.c:165:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsom
etimes-uninitialized]
        if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/fsl/imx-hdmi.c:212:9: note: uninitialized use occurs here
        return ret;

The driver returns -EINVAL for other broken DT properties, so do
it the same way here.

Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/imx-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 2c2a76a71940..ede4a9ad1054 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -164,6 +164,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 
 	if ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in)) {
 		dev_err(&pdev->dev, "Invalid HDMI DAI link\n");
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.29.2

