Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92960C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:10:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A79207E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 22:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTJf8tGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A79207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4457vp4Vp7zDqSV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=thesven73@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTJf8tGa"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444z8J4HWjzDq6M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 02:35:57 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id e1so1807570iok.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2KXMvYHbrLkp9bZ90/DNJJ31xiACWMEb2YfDg1AjNDk=;
 b=DTJf8tGagUfw+mIoRERyJdMLTWTALbdJHRdSKwqirl7IaYnJi0NIRp/tnyEYxFcBp7
 yxDuUs+ruz4ZxzhmhypbzakuTUqj9mnn4v7ZELW0G8rXQmfh37ADiKbDYfoe6QrrKi8p
 kM1lCb3ZWt6C1cp5A4tobWIvwZgrLInCC2WvWjPxdo7yC7RRonvcKXvl4cPbvftV0Z3j
 1iU/97TpGFdtenxe9jLZATit6NtqIFSA0VU2MIq0A4I8ly7LuIgHaFDI4YnnwZSmdO1J
 a3psm1hq0laz7hI/DnJx69sHS3k5nYwwPl50zHfrJ7YMkWPIQa28wT/XUHFUEXA8Z6pE
 Jsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2KXMvYHbrLkp9bZ90/DNJJ31xiACWMEb2YfDg1AjNDk=;
 b=desq8mP43kRR3dX1I3cSTeCt7BB8QNwEEHTUPJALcQ5ip/oEj0ch1/n8+S8ogndNSb
 I8v3LCIPFtN05ecAlSGvhmdH1NsO5PzUmj2u+IJDexSUN5QTikXYwTG9clbkmt8c/CUM
 gRgBTtzNOumqUOlI9jYHIp/7Xa9UVJc42QfJf+O2innXdCCSSeR0mIQLCR/zR6fXbJ7M
 9cRYuKb8QA00UULtnZnSJSFVG42KDzdMalD30DCl5CSdws06q5hvcBM+Gf/7+yrdU7rT
 9cNqoLqOhjTm79hM3FqNUsc69w0fTOsn+H29r5cYiCmjwhMHVf/IyHwiyFmREfhS1/Ha
 vKAQ==
X-Gm-Message-State: AHQUAuYJKGTQLbhF7aOKazM6Gstibma64wsEcpvh8srKBamk+86W/lKV
 fukNMoKY3vI33ThO9pUtgKE=
X-Google-Smtp-Source: AHgI3Ia4DqozQw5D+6B3vkCJ7wo/OiiGtzPtjjUNTHSEqNAH65vYvPDVbruBbX8NW5wcwnjYFXpK7w==
X-Received: by 2002:a6b:d109:: with SMTP id l9mr25571617iob.108.1550763354739; 
 Thu, 21 Feb 2019 07:35:54 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
 by smtp.gmail.com with ESMTPSA id f142sm4474706itc.15.2019.02.21.07.35.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 07:35:54 -0800 (PST)
From: Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: remove unsupported formats in i2s master mode
Date: Thu, 21 Feb 2019 10:35:50 -0500
Message-Id: <20190221153550.1932-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 22 Feb 2019 09:09:13 +1100
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
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quote from the ssi manual:
"The word length is fixed to 32 in I2S Master mode and
the WL bits determine the number of bits that will
contain valid data (out of the 32 transmitted/received
bits in each channel)."
(61.8.1.4, page 5138, IMX6DQRM Rev. 3, 07/2015)

In other words, in i2s master mode, we always get 32
physical bits/channel, no matter what.

However, the supported list of formats for this ssi
contains S8, S16_XX, S18_3XX, and S20_3XX, which have
8, 16, 24 and 24 physical bits/channel respectively.
If one of these is selected in i2s master mode, the
format generated by the ssi will be incorrect.

Fix by constraining the frame bits in i2s master mode
to 32 * channels. This will filter out those formats
that the ssi cannot support.

Tested on imx6 with tda998x and sgtl5k codecs.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0a648229e643..3d375f60ecf4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -627,6 +627,28 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 	regmap_write(regs, REG_SSI_SOR, SSI_SOR_WAIT(3));
 }
 
+static int fsl_ssi_hw_rule_i2s_master(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *it = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_FRAME_BITS);
+	struct fsl_ssi *ssi = rule->private;
+	struct snd_interval t;
+
+	if (!fsl_ssi_is_i2s_master(ssi))
+		return 0;
+
+	/*
+	 * In i2s master mode, the ssi always generates 32 physical
+	 * bits/channel. Filter out formats that don't have 32 physical
+	 * bits/channel, they are unsupported.
+	 */
+	memset(&t, 0, sizeof(t));
+	t.min = t.max = params_channels(params) * 32;
+
+	return snd_interval_refine(it, &t);
+}
+
 static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -648,6 +670,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
 					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 
+	snd_pcm_hw_rule_add(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_FRAME_BITS,
+			fsl_ssi_hw_rule_i2s_master, ssi,
+			SNDRV_PCM_HW_PARAM_FORMAT, SNDRV_PCM_HW_PARAM_CHANNELS,
+			-1);
+
 	return 0;
 }
 
-- 
2.17.1

