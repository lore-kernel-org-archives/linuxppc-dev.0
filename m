Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095BEC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FD5217D4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHTVfm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FD5217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bK5417dlzDq9V
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:34:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODHTVfm8"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7P5774zDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:29 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id y13so7657581wrd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dxBrociOZFoM+5+G6/1SJONXjwRav3ZwO+z6b4WcMWY=;
 b=ODHTVfm8phZ6v28JJZiATVCm9BSw0H0lhSWvNOSudoXCOldCxzzbibC7riYnccRfOx
 RUmAOj8XWobuMfVfNu+o1LT7G5kcuRi5SEHBUbqgiVCguYODXgH+BTpXTx5sWl4W/L6j
 DzAZwmjJ1P8fHQPAC7xwP/tCKmxv6lFvHuYPCwTgZYsQGM6gxpcUiB33lOIQC/aAUb66
 Z+KHEOQ2JOYGAwQgwP2thPWZOt2y6ha3BcDvkGNzBEvZR32hamtiT8voNV5VGN360Uft
 tnJ/aZqC1WQQpTUuQwB+6UwLLwX3Vziy3uzKgejwjnH1bzwBUJlNiYx6WEaly7n6Nx3G
 h+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dxBrociOZFoM+5+G6/1SJONXjwRav3ZwO+z6b4WcMWY=;
 b=MBoDwHP+ts8V5Tcu3L+QxQKlMUkkwVsd5uCnbFnkjwpVR4juxjDMQ3T8XzVhuq6gKx
 AVL6346sHqLBywsBQcqRxXxgXrLw9YGlhzhlcnxE8ZcrsDs0gwpjStUbV9a/uimumwgZ
 yBp6gSTFB3czAdH3cPlfiVboGpmH4noo2pIVaHwKf0shZNXSk3nHSBJeSf/ccArhTjWE
 Y5skww8xu1JVeweWcXItWVPUjo3By2fWl9P4GaAP6CjFzND8/VOAkQkF9ceuUMfiAFly
 RlEFeeMJE0OsCRLvnlOQHt6IkkhZPjx6z2DRbW8nywG6DJi2qBryPXY/4qW9yQrthFdT
 gSfg==
X-Gm-Message-State: APjAAAWNTFPmf2tic3Ksjs/WlyqJkmLXRmsXEGnNHho2paaaSEfN+xQ5
 piSkME7ycBN5yvY6JPjSZXI=
X-Google-Smtp-Source: APXvYqxTRIMzJY6NWNsw0vEX//ook9rzUfILFZxglnXL9GEtBRN5aVlR1vCok6kytBZ+7Y8AH4IaAA==
X-Received: by 2002:a05:6000:1111:: with SMTP id
 z17mr5474588wrw.103.1554465087193; 
 Fri, 05 Apr 2019 04:51:27 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:26 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] ASoC: phycore-ac97: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:09 +0300
Message-Id: <20190405115010.28838-20-andradanciu1997@gmail.com>
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
 sound/soc/fsl/phycore-ac97.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index 66fb6c4614d2..fe7ba6db7c96 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -1,14 +1,8 @@
-/*
- * phycore-ac97.c  --  SoC audio for imx_phycore in AC97 mode
- *
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// phycore-ac97.c  --  SoC audio for imx_phycore in AC97 mode
+//
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

