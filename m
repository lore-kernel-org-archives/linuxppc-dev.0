Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD174C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAED21871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbHDLtbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAED21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJN44mfHzDqCX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:02:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbHDLtbW"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6c3lbSzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:48 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id r186so9551185wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=shxp5QccDgvm7RtJoZA9C9TvzP7d0bo8vYGaOaufb+8=;
 b=EbHDLtbWQQPwQ5+zVtN5sPff0W0FDb8kf4if9Jhhndqtf0OV2p47KxUYLisTCXkhnh
 uHbbEiKhhIC/KMF1HBkX+iFCdexPC3k8xEnAKn78Cwx31hLzvd7Ukx5oLkIRUc+z/3nS
 2Q81fNc8S5rLG1xNa5dZDcf4Z+I1TNxLK07qjFVwjzJuCvFUNvitsenoZiwbqNI9cVCG
 Aeyt61aQz6P3W+rUJJ0Jmu6c8pASb2YBJZ1u6yy32g02ndY/afgIvwiHO/RoctAMLh7b
 tfFOigxNdTrgpsRwzOgcFYjS9RxVKFturDIzH9n42oi0p991iJWLhZNfUcl2ehvIDvTA
 eHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=shxp5QccDgvm7RtJoZA9C9TvzP7d0bo8vYGaOaufb+8=;
 b=O82tFCNDD6MiQUq33u9W7U2ZBhyjb5d/toYtrO0nulhXWQ8XrT9lSPeCTKtfZvbBzO
 gMBfGlhXCzRPKQn/8DV3z+MjlrI/B7HO0muimNfnbWPakyaj8h0Cd6RsRcv79CXEKeLP
 ZYn7AvnbCueKPNjAENupUulSukfd1Co4nYhsBST70arSaOqgHXJ5CEPIACmoumtHnCWI
 knYAjs4HVrgo2usn6A4E8JAzyZ/P5fQISi+P4sXUZpMJ6nJSsJjYzzpfHwM1pmkELw6g
 OvlOwpsfBWMiyTM92JVVN6Mz7GiwmgZ+Y5u/iwZOXt50MXqI7rChElCfsekmk4IN1y8u
 jyMQ==
X-Gm-Message-State: APjAAAVP/vYDIPttRDY+E6GkwVpR6SfsbxA8hX7X6sLeayMJe9LX2ojp
 9UzUoxvLUU0yXt26fbRb3pM=
X-Google-Smtp-Source: APXvYqx9gP4WQb4WHpGF+ef+aOaJ/jWklMyCaVluOZumL8v3mJ9HlAbHFbKHZo6NDqiHE2x3gszVWg==
X-Received: by 2002:a05:600c:2118:: with SMTP id
 u24mr7732009wml.24.1554465045260; 
 Fri, 05 Apr 2019 04:50:45 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:44 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] ASoC: fsl-dma: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:54 +0300
Message-Id: <20190405115010.28838-5-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
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

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/fsl_dma.c | 26 +++++++++++---------------
 sound/soc/fsl/fsl_dma.h |  5 +----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 78871de35086..e22508301412 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -1,18 +1,14 @@
-/*
- * Freescale DMA ALSA SoC PCM driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * This driver implements ASoC support for the Elo DMA controller, which is
- * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
- * the PCM driver is what handles the DMA buffer.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale DMA ALSA SoC PCM driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// This driver implements ASoC support for the Elo DMA controller, which is
+// the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
+// the PCM driver is what handles the DMA buffer.
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 78fee97e8036..f19ae765b656 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mpc8610-pcm.h - ALSA PCM interface for the Freescale MPC8610 SoC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _MPC8610_PCM_H
-- 
2.11.0

