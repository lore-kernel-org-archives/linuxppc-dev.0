Return-Path: <linuxppc-dev+bounces-20204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2024FF8867
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 03:07:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4QMx4Zxdz2yqt;
	Tue, 28 Apr 2026 13:07:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777345645;
	cv=none; b=W/CnIQSJmRX11yEiHScHV0z92uUrmrkSOmPhZy2OoA/KuNG91DpS3Db13ng48F0FHhXXPGu/nWOGy61EmlFrTP2c/rpH7IreczzkG4B/lYE+tfmpiTYJH/I9gpTTeip8blmAxbXDAXU8V8Nk0P2xTX1Z4iQSQuf9eih6QwFGW7vOdjnvAJ105NK59+xjK4tFwyQe4VJlcxrHMC8izG4Zo6cOqz6UHuvVax5NZwM7pmA+CUem4Zbb63Xqj7dyyNWakebxsOlBaf0q0wdDVniblUPx+FzaHlIgdSGFiFj4ttTJPrYwg076bG8njsMsb8u3HJDB7b+TtyGRkVbmSLZDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777345645; c=relaxed/relaxed;
	bh=xy+tm9bENqCqZp9SYs+pOo5djm/sVYYFvKa2wEp3fzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hlCwxYy1oDIkdUzOg9zNsQ1UyLatI28Z3ApJJtR1bj64QAxq6faxWiaFF9hvyIjNfjOPBJnrYlTVvVkHCpnKr59xgNOw76/AzvhtqC20PqqgRargw0ZRzj03MOBP5no8kLE8O4wmp0n7DSVq6GOtfVVOfmcQHK7b4w8twgxEWNtyGU4+/DyQGLx/++icWSoSrnLyt3xK2Gqmsrz0PzKhpfDAmt80uGnvfJTxI1aeLVfhysb5kCtu3sYDnjPB/lzw3IBtcO2aFHXft14BgUVOWTWV/urGNnwrBeHzAj011qvA/JRQPhdprbhOMKal9x+iMhI9rHh2Nb1P6ZynbA1Sug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWxElCeO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWxElCeO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4QMv6NBLz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 13:07:22 +1000 (AEST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-79a60975dc5so116227527b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777345640; x=1777950440; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xy+tm9bENqCqZp9SYs+pOo5djm/sVYYFvKa2wEp3fzY=;
        b=cWxElCeOZlWlg9V7Bo8Ogu6ABYI/uvbWiexf75UPAswBojONAxj8uEFXcu2nr2iVPe
         NmYOY5fllGvOXfq7KRUzHWL2rw+XuReZa8iUmTwUTzkLD3L9rhhS2w/WnFPTOtiI4Jnu
         6Mgq+7dhA5xqulHT7dlwEBgqxURPCpSiLVyMNlIkYe2biZZNrwEAzA622hjhNPzYqTFF
         6/rkr1a9f2ZnSv89zOPsESqEvGgoYBZZQXsIu7MIxeAqE2jC0O3DwNZoVnZuFDf/WtRX
         qAFNg1VpuhHfnlTHJRXBnS3UPgm/4Gu68OY6xAIXF71PiWCdJDTDomGHOA4fMBfVnoNk
         8xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345640; x=1777950440;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xy+tm9bENqCqZp9SYs+pOo5djm/sVYYFvKa2wEp3fzY=;
        b=s6IKO2DzuRDEYNgipzWEzx4UjO3/9SUA5D/SmOkYeq2Q0VVMjw3xpPmK1GAGN9kLuC
         ciive5bIvZm8dc4VjC1oWTdpQqkVhB/BU+YQoZGM/Bu2HKqHWtUl9gwX3rFdok+KefuY
         Gp8epDFCIXHYPvcY8v0iqsCKRwVazJP/YPdLFYhezRJzCVioRH5hsfnY0P0NjfKQ4UVj
         0VxgANt2tkaIc727KWIVJtlL9mayi7hTkLTJpuHJFU0V2rqpuAtB6kyuJLSottNCsbi/
         hLdoOJF5CTZw0UydcM+UzdfYw7e6mNPeylvCjEEsykdKVDPovMritXPHG4wJX8+GMe9c
         rPCA==
X-Forwarded-Encrypted: i=1; AFNElJ8Odqrw74LBCX+P2TIeFM6n984AsfEoR3BVL5SSb/foLDvttbtkc4V7SgRcsvVXHbjjOLzNNLm+nf2KwKY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyF0SqijBLtMZ0lwjl3YAU+UXCy8U7eDuxOvvVnlFMMDvdVVpcw
	49+nqf7FRMA7yKgtChrATgjKbrRVqul9eUPFF8xYByT8PRIRACQG2Spyn0P7WJ9d
X-Gm-Gg: AeBDievYkRw3rL/EvIvMexMEqV0MrDy3eKjFW73NjDMja/+UF3hp6128XISsy+SUt6L
	IrrnEsfpeKTRzj3WNzCHO+qWHHBQMSrfsUmWOVT+j2Kifxkkhate8S5jTpu7rbAlsJDbCb+4xqP
	MUe8qAfzVxYOuUZeWjD6q1IIGQNMPF5TqQJ6T168sEFBUzOvOQT4bYliYd3SOQXaTLA3Idi3/fB
	f+FsBWoadjZyfOf4rpmOPLTZtfNQ3Mj30+N+TXC/X76dT/nSzqtKBedZRSTpEMXtuIM8vDIVIcr
	kFCJvNTkAscWt5OHUN3dc1AXFp7VS8pFyGKjNjdM89Nee5a3eqFcYQRNmEroJZKFIN9YbSlAoA2
	abz5K8uCsLdXaIOiQALmZyhRcHuxM542Gk3TcjWDJG5EaGFuFZVHeF1TrZkseqto5WueCHFC1L6
	tvYxo8+3NiNg3dqiAiOzhP43xHfO8tr0EMu69V55lgk2HyZqywdwO2/Ec8eHBNWq6Byk1qnOFtH
	vZynbf68j/P
X-Received: by 2002:a05:690c:c24d:b0:7ba:eefe:9fa1 with SMTP id 00721157ae682-7bcf52207camr11515787b3.6.1777345639900;
        Mon, 27 Apr 2026 20:07:19 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e622esm8834257b3.17.2026.04.27.20.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:07:19 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 28 Apr 2026 00:07:08 -0300
Subject: [PATCH] ASoC: fsl_xcvr: Fix event generation for cached controls
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
Message-Id: <20260428-asoc-fsl-xcvr-event-generation-v1-1-f21cf0812c4f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMBCE4Vcpe3ahRmvVVxEPcTupEUllN4ZC6
 bsb9fgd5p+FDBphdG4WUpRocUoV201DcvdpBMehmlzrDu3e9extEg725FmKMgpS5hEJ6nOdsgt
 dL93uNMAdqUZeihDn38Hl+re9bw9I/lZpXT8IVeqlggAAAA==
X-Change-ID: 20260427-asoc-fsl-xcvr-event-generation-2f57c539de28
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Viorel Suman <viorel.suman@nxp.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=M/DH4mZdkREffdwKLGoyCTZnaJGwxzLtvZ0z5kxN6cI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkfVJKXHzPrqixb3+9XfsVgqkItf7+RfpXZtTP9Deq/S
 jZfifPrKGVhEONikBVTZFmdtMhyT9eDq/VxKzxg5rAygQxh4OIUgIm8tGdk2Lwz0nZ2ey1L96Iz
 u3XPnJoS4KWwbMpO/92bpKpvuPkHSjH8d2rKLBb46RjkuLldvGmG3OGflg65Mp08TbM53vQbC1c
 yAQA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

ALSA controls should return 1 from a put callback when the control
value changes. fsl_xcvr_capds_put() and fsl_xcvr_tx_cs_put() both
update cached control data but always return 0, so ALSA suppresses
change notifications for the Capabilities Data Structure and playback
IEC958 channel status controls.

Compare the old and new cached values before copying the new data,
and return whether the control value changed.

Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/fsl/fsl_xcvr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index ee16cf681488..6677d3bf36ec 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -228,10 +228,14 @@ static int fsl_xcvr_capds_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
+	int changed;
 
-	memcpy(xcvr->cap_ds, ucontrol->value.bytes.data, FSL_XCVR_CAPDS_SIZE);
+	changed = memcmp(xcvr->cap_ds, ucontrol->value.bytes.data,
+			 sizeof(xcvr->cap_ds)) != 0;
+	memcpy(xcvr->cap_ds, ucontrol->value.bytes.data,
+	       sizeof(xcvr->cap_ds));
 
-	return 0;
+	return changed;
 }
 
 static struct snd_kcontrol_new fsl_xcvr_earc_capds_kctl = {
@@ -1040,10 +1044,15 @@ static int fsl_xcvr_tx_cs_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
+	int changed;
 
-	memcpy(xcvr->tx_iec958.status, ucontrol->value.iec958.status, 24);
+	changed = memcmp(xcvr->tx_iec958.status,
+			 ucontrol->value.iec958.status,
+			 sizeof(xcvr->tx_iec958.status)) != 0;
+	memcpy(xcvr->tx_iec958.status, ucontrol->value.iec958.status,
+	       sizeof(xcvr->tx_iec958.status));
 
-	return 0;
+	return changed;
 }
 
 static struct snd_kcontrol_new fsl_xcvr_rx_ctls[] = {

---
base-commit: 98421d94a1a6dcc3e8582eb62bedeccecda93339
change-id: 20260427-asoc-fsl-xcvr-event-generation-2f57c539de28

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


