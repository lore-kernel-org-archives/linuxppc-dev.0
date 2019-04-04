Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:31:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7500C2075E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXaXfid+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7500C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zj3c4f4KzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:31:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXaXfid+"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZhCx1ZS9zDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 22:53:13 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id 4so2700950wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=vc8JhnKR4Bcfb3mi4PgaRMI/IBnv1Y7aronixVijIxU=;
 b=jXaXfid+eOF4AjlaE9LiXCJE31BRlyI7H9ydNwUXVh5/i//nAA3oofBRJCBGYTGafL
 uyX2IMpYXuwni6tvqjaejowU+KGbX+U1ceeEHJANRyDz+LnhE4HTfvabiVtT11AZ5viG
 8EDq335r6XVi3WHni1ZLPW0hNWFd1PwGp+zJlGA/pxRYdsIi2+xpNaLbm0XAtktycYqG
 uTNm/qNQzaKwPYouyxebaPKqAb0v+canAUuZoevgWUCrd0+0oXi7u4S5eJG87DDd6l2E
 +XOlRZrD+s1MI5DyP+mwbl9+D9dHmuv4gJfsUUx8YKNBaDvXyOdeInGZr9AAi2nFz9In
 7frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vc8JhnKR4Bcfb3mi4PgaRMI/IBnv1Y7aronixVijIxU=;
 b=iJQWqZI6t1SOJnSFjkYz+ll6cH0n1UJs6C1vMzDMKMOZRblO0k3051dWcZ3sbwP3cO
 q3Mf3e8awyRZTvMcSt81K+Xcyp9iMySLx2u6CuQjriavev1X0yan+MN7mSatSwG7YPAR
 QpOcaXW5W5fbKiEhlZBloctdg9NJKi8DdxPqWGLSA/+WZumvQfBIcbrLKb+WxUx2VhyD
 XJS3NyUW7y5FqBY2mkg3IF0FOgSosPv72uaTAz99b2YwfqZvGYk4gCYHL0C2X1U1Xb02
 ErW3HYflqhyJCC/v1rZOcJh2ZCn8Aha/62iTRIlu20ObxDmP20/sEVFEiA7Ej47h9G5V
 DK8A==
X-Gm-Message-State: APjAAAW1nzt+7UMnDz4bAXysQMyaADgadd2rfoetNdrcK/HzswfivLAO
 DGrlkgROXfpcVoIyX62gWQI=
X-Google-Smtp-Source: APXvYqxHXNCxc/Bz8SuAoxRpukx5J2vcHCvfzJUi2tin4bPMy6/e3ffPERh3+HK9RWk5mSxhxelnrA==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr3745219wmh.93.1554378790075; 
 Thu, 04 Apr 2019 04:53:10 -0700 (PDT)
Received: from localhost.localdomain ([178.138.32.90])
 by smtp.gmail.com with ESMTPSA id e9sm30366457wrp.35.2019.04.04.04.53.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Apr 2019 04:53:09 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-pcm-dma: Switch to SPDX identifier
Date: Thu,  4 Apr 2019 14:52:52 +0300
Message-Id: <20190404115252.29230-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Thu, 04 Apr 2019 23:28:59 +1100
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
Cc: Andra Danciu <andradanciu1997@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-pcm-dma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 314814ddd2b0..6c495761f33c 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -1,16 +1,12 @@
-/*
- * imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This code is based on code copyrighted by Freescale,
- * Liam Girdwood, Javier Martin and probably others.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
-- 
2.11.0

