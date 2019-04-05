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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE9C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E73220663
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCConTvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJQG5yRbzDqCD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eCConTvS"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6g2LDHzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:51 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id a184so6324694wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5asv/MMYgaT3vlOnBG4Dw1w/S6VrgPjfjegRPmtGsPM=;
 b=eCConTvSb7AtK58n0Df+uaIqd4+v8mj3krxRh+M1NjPa3BIXzvJC0lKUikEFLPu9c/
 u/3ZNVP1G6+MJve5Hj8UDyaWxAZ14UfYj+vEuyRrKwz5FIyDGQn4APYxFyjyjz3QmvPg
 TThMVPReH6VZKhwZeUm/vUG5KRcgxRBeukfOZ2EQrGQbT+gbE8KmHrqUSnk6OYCEYuHa
 A6/iBmlME3RfBeHwK5k9kp8CSvsva860jHBmKebcwi8um93NAiLe21p3y8R+Fbagt2L8
 tJBb+1JGndrZBWRnEWtFfTnekqSHlxRFooRsqtKnhW8qIXcW6kaJR/5RXIebUzchHLKm
 rgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5asv/MMYgaT3vlOnBG4Dw1w/S6VrgPjfjegRPmtGsPM=;
 b=V9LFAV9Bg0NTVaYvkgDJI5QkQe7eqB6cN6yIiQzxeWY23LpQclV9HKerrRuj8BwwQ9
 cI0ssuKs0fMrzLWyrKsCdEKSxjqqcZ0hjt5BhVBexuuKZiTq6sLlcVst6G7Xoq/TwtRT
 APj/W7DgXFg2n/XjNlpSv0t+gu/vYO0ZI78nAdYb/zBPKyLgDo2jvilg+F9YFzf64g6r
 +EHaco1Y1lNdrj8HdsWjDc59ER6GFccNQ9qwIenKUlg0203nhswsxMdYnUaMWe2dUP2I
 n/peqTL3SpDbFpNyfwMYzkD4BN45tjAmobhXNkJ7JTb/2paaW/PhvMp3NJjREqbVffR3
 wcbw==
X-Gm-Message-State: APjAAAVOTyctpFlPOcCwB5by1MPLFZwe4tUMbVS/cB8ykw6tggFxWxLB
 q636P8kKjWr6DQF6LroKgGs=
X-Google-Smtp-Source: APXvYqw8hkwRw3wCb1GQ+HDlwT/I55ykrChmpfn2wnpPr+ajoYDMDFk263jAmBxPUG8SKiK0Ppz8ig==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr7549383wmj.60.1554465048087; 
 Fri, 05 Apr 2019 04:50:48 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:47 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] ASoC: imx-audmux: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:55 +0300
Message-Id: <20190405115010.28838-6-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-audmux.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 99e07b01a2ce..04e59e66711d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -1,21 +1,11 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
+// Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+//
+// Initial development of this code was funded by
+// Phytec Messtechnik GmbH, http://www.phytec.de
 
 #include <linux/clk.h>
 #include <linux/debugfs.h>
-- 
2.11.0

