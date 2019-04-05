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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B7C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:24:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521C8218AE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTLf8ikW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521C8218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJs228t5zDq7n
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:24:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uTLf8ikW"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7B02BGzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:17 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id h4so7633578wre.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z4hOLEy1KAA39sFWNk89CJxULZaItnMmPfy0ZrsUguQ=;
 b=uTLf8ikWgZGaU5U704onyfDUodYw6lCqifcV6omsTrKn4JHBdcCZAZLs5gpSrH6twO
 4EjX+jRArj24uk1brErJRDIG4EN/cx05I+NdmSAfe5uKOsFUKhUdFLhMnEeEYR6XSDID
 IeKbRIGSwopflQDoyfj1SLCLXwtw7NhEWiYA3vww9V/xPmvsrPnFEEUvkYo6KumHCvso
 vkSG63fdjibxtbBTGyoCMn4wQn7nUXEASDSEL0PKl8qJM6jxmkMW2HdNN+XxskN3IAbX
 KSHoYDihVRStp+vKqC2EEo7wTdVDdcEIOSekPMfpdJAfRj1LTs8UXqdghcsOxganz87W
 cOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z4hOLEy1KAA39sFWNk89CJxULZaItnMmPfy0ZrsUguQ=;
 b=kx7Qv9WLorJLB7fDjsiY1S4n6Zjgly9qkrISXKREldjwKqPbLr9CnnrZITJmYHqDRX
 EQA0gcn0OKPO8VsUdQ0HvY7bLUJk51zumR3IF3PSJVCWaJheid3rAfS/RF1r7viLJS75
 fPxnjpkpXrd+tFq4c8/l3u9dBligVKn3Un74GWidYxBeQ/GPzE/eZHKC/Y/+TUrNDXmx
 8LiLUkkH3G8DRKFy/1aE8oOBzFbyKrX+rfFrJuxBkv/w4AA1E9v/2tzGB/dYUTqaBwJ/
 i1Jvxmajg5nVCIio2PVz2xDhLaQZAFnBz+SS6npQjXgkiFtNQ+Mr3TmDRTcKQyCrjvr+
 vrvQ==
X-Gm-Message-State: APjAAAV3WtQdnFJzLZw8sjIk13m5LJt67GtgJbFfLWM4T7RkIldojt1p
 mLgjKAm441sDh7dvTZY1Vs8=
X-Google-Smtp-Source: APXvYqzXXzPbcrL114rjzAe/hUC5/G0u+3qzwTXWsA6V4W4RWDRI+5ISLM+d1K9vaj7I6i0v+FmTbw==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr8008718wro.216.1554465074869; 
 Fri, 05 Apr 2019 04:51:14 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:14 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] ASoC: mpc8610_hpcd: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:04 +0300
Message-Id: <20190405115010.28838-15-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc8610_hpcd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a639b52c16f6..f6261a3eeb0f 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,14 +1,10 @@
-/**
- * Freescale MPC8610HPCD ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale MPC8610HPCD ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.11.0

