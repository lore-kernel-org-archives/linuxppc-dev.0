Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51627C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:56:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9A8206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS90n7M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9A8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJF64Gg9zDqS6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lS90n7M0"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6R52skzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:39 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id a184so6323746wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4vA423L0B512xMUlryz6tq1OFnDQMAXtE1k4y9JTwU8=;
 b=lS90n7M0sIJmX7378Mlz1DffDMeuP7nsstODg05YV2EbsaPm4nNU3KJpDHXWzaIXPr
 u6BwJmnXogDkgdA07PegcKKmUp6YCdPT7tOss+AOzoyMDOarhk9PZJKu6ihaXhUBzBQL
 S38Q3k8Znd/pZnCXaQ9qMyHJq0ib0FlVsD9FuAMFnBkc+hosdjKDbHkOcM+qYDeoHG8o
 IYl1hiFdL3+wXX81p1/JZV6KyEboZotMJc1dofcK7JsxLjbxOtKW3GzADTc8J9/29HPI
 9jEhLqPwmX69OpH29al9vrbtf0WFaxJ/ZBQHNGUsOVaxAYg88ErvpX/I3pAbWu8VfMIe
 O7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4vA423L0B512xMUlryz6tq1OFnDQMAXtE1k4y9JTwU8=;
 b=tQI37bCOAxZXAAl2JzaEcCXpUmnWs70Y+fOHXlL05WY5UPgc1LmVNKrSuJB7SxkJFl
 8Iu8T6G+5SEkPVATcI+Q/GtzXYMZ6Cs7cG5hS9AizV+yF/XZo3JKycuwZebYRgSp3FM2
 DS6xxsVb2TruzroferBNekc99Z3wg2ceAi3Kf7gMXqKgbYSypQtUCJSQkDwNfmLk5TEM
 h0aCwU3deBhtstZ6YD77o2VrEA8GGRjT3gI8nNnn+Khq3kJPQbEx4i3yA3o09GjiXwR6
 GrmWHYTT5ujkf0zfH8Y2MrXO2lGtLFZl1TVboX96nM1xpG1WERDBob0Q5CoXSwvPeRAW
 8FXw==
X-Gm-Message-State: APjAAAVhGJbN2xryYsmReJVA8D/Y32UG1R958OWxFPoUKrm0MLbJwVPe
 WU/TMmx85bmUopVkO0xhA4s=
X-Google-Smtp-Source: APXvYqx9Z2lotprdS0f7CAgDP62VLBrh+tflNBNFTwLPW4sxxK1RN4/7CCyU+7WRBw65MpzQfZVdgg==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr7556344wmh.134.1554465032373; 
 Fri, 05 Apr 2019 04:50:32 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:31 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:50 +0300
Message-Id: <20190405115010.28838-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
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
Cc: Andra Danciu <andradanciu1997@gmail.com>, daniel.baluta@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch set switches to SPDX identifier inside the fsl directory.

Andra Danciu (20):
  ASoC: imx-pcm: Switch to SPDX identifier
  ASoC: efika-audio-fabric.c: Switch to SPDX identifier
  ASoC: eukrea-tlv320: Switch to SPDX identifier
  ASoC: fsl-dma: Switch to SPDX identifier
  ASoC: imx-audmux: Switch to SPDX identifier
  ASoC: imx-es8328: Switch to SPDX identifier
  ASoC: imx-mc13783: Switch to SPDX identifier
  ASoC: imx-pcm-fiq: Switch to SPDX identifier
  ASoC: imx-spdif: Switch to SPDX identifier
  ASoC: imx-ssi: Switch to SPDX identifier
  ASoC: mpc5200_dma: Switch to SPDX identifier
  ASoC: mpc5200_psc_ac97: Switch to SPDX identifier
  ASoC: mpc5200_psc_i2s: Switch to SPDX identifier
  ASoC: mpc8610_hpcd: Switch to SPDX identifier
  ASoC: mx27vis-aic32x4: Switch to SPDX identifier
  ASoC: p1022_ds: Switch to SPDX identifier
  ASoC: p1022_rdk: Switch to SPDX identifier
  ASoC: pcm030-audio-fabric: Switch to SPDX identifier
  ASoC: phycore-ac97: Switch to SPDX identifier
  ASoC: wm1133-ev1: Switch to SPDX identifier

 sound/soc/fsl/efika-audio-fabric.c  | 17 ++++-------
 sound/soc/fsl/eukrea-tlv320.c       | 26 +++++++----------
 sound/soc/fsl/fsl_dma.c             | 26 +++++++----------
 sound/soc/fsl/fsl_dma.h             |  5 +---
 sound/soc/fsl/imx-audmux.c          | 26 ++++++-----------
 sound/soc/fsl/imx-es8328.c          | 15 +++-------
 sound/soc/fsl/imx-mc13783.c         | 22 ++++++--------
 sound/soc/fsl/imx-pcm-fiq.c         | 21 ++++++--------
 sound/soc/fsl/imx-pcm.h             |  6 +---
 sound/soc/fsl/imx-spdif.c           | 13 ++-------
 sound/soc/fsl/imx-ssi.c             | 57 ++++++++++++++++---------------------
 sound/soc/fsl/imx-ssi.h             |  6 +---
 sound/soc/fsl/mpc5200_dma.c         | 14 ++++-----
 sound/soc/fsl/mpc5200_psc_ac97.c    | 16 ++++-------
 sound/soc/fsl/mpc5200_psc_i2s.c     | 14 ++++-----
 sound/soc/fsl/mpc8610_hpcd.c        | 18 +++++-------
 sound/soc/fsl/mx27vis-aic32x4.c     | 29 +++++--------------
 sound/soc/fsl/p1022_ds.c            | 18 +++++-------
 sound/soc/fsl/p1022_rdk.c           | 32 +++++++++------------
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++-------
 sound/soc/fsl/phycore-ac97.c        | 16 ++++-------
 sound/soc/fsl/wm1133-ev1.c          | 21 ++++++--------
 22 files changed, 161 insertions(+), 275 deletions(-)

-- 
2.11.0

