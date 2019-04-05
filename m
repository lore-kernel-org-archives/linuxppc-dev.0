Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A7AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:29:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029F5217D4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqGh6yZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029F5217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJzQ0C4VzDq5W
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jqGh6yZ6"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7J6HW5zDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:24 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id t17so7570106wrw.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=reV3+apEIiV+cf8d5UskOEI3OYpnKbwiiVSFEL+GB3o=;
 b=jqGh6yZ69s6rGwwFDqV1Y0+fXnzNjM25uGDoe6FZdhZs2wIwC0GmaLMNpymGzebE6C
 GIuYp2S8KWOve2NWe+FosoJtHU+gtrENwCa+7WO/neMyDjj4g4zyVuoJCdtulukeAjmI
 XAV61KTsLdQUORdiqjepAsTDHo94qke5OzcASEIYtffsM33YkgIlfYJ0Q+Du21pcw1mR
 MKQ6Z3cdrZ6sBy34XbTTOWY5pp/th9LohqUDubWfl3cJpMMLzqmO5dSMNksjKAfo4PbY
 2MpWlEp2zeu3HzIFl7JDt/UD2maaxKmehmw6uMytLLVu1C+WsxrTsrdWB823J58l2mgx
 +rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=reV3+apEIiV+cf8d5UskOEI3OYpnKbwiiVSFEL+GB3o=;
 b=b8v7S3wpVRCb3mLIP+YS2jdQMLq8sa9E/R8mh09VEje+YDIwU7yl9vcN1bqRVZI4YK
 62KbQiGZ+fjjwMsUQPhgvrIw6DjF+RiKnGg+R//dYcZlZmSkLDFYkg+/bpWlpkDciaaC
 tMOXDYQlnIp2GCq3Vz5tJAbqXtROkmlCBntesQ+XxAzP1gviBoz2TgKm+8W2Rb6FH87U
 vw21mdvfCnivkU7pkwUDJPUy0nOswjfhDVlCfhdNNgs9kVowBRq7gmeL+bh0BwCmovp/
 TLsWLcERHkWJwP1mkZc4ESB6LXLU81LZN8lokb30Ln91drRnrZV+0Nkd3PKuyZZwj9yK
 s+ig==
X-Gm-Message-State: APjAAAU/QTtq+bV+veGyVxfke5L7UWVR8jJ73WJCqNLFTt0ratZRCoMF
 NQzon2VLv1xUh9nmBUHC/XY=
X-Google-Smtp-Source: APXvYqwes1A4L+aLyptK4y25SsxHUA3Xhyg4RTDeYO8I2b1kNaQ/lzBEttymiA+5M773gf3nhfWZ2g==
X-Received: by 2002:a5d:424b:: with SMTP id s11mr1033160wrr.158.1554465082294; 
 Fri, 05 Apr 2019 04:51:22 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:21 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] ASoC: p1022_rdk: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:07 +0300
Message-Id: <20190405115010.28838-18-andradanciu1997@gmail.com>
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
 sound/soc/fsl/p1022_rdk.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 4afbdd610bfa..1c32c2d8c6b0 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -1,21 +1,17 @@
-/**
- * Freescale P1022RDK ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * Note: in order for audio to work correctly, the output controls need
- * to be enabled, because they control the clock.  So for playback, for
- * example:
- *
- *      amixer sset 'Left Output Mixer PCM' on
- *      amixer sset 'Right Output Mixer PCM' on
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022RDK ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+//
+// Note: in order for audio to work correctly, the output controls need
+// to be enabled, because they control the clock.  So for playback, for
+// example:
+//
+//      amixer sset 'Left Output Mixer PCM' on
+//      amixer sset 'Right Output Mixer PCM' on
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.11.0

