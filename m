Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A81C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4531B21738
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkB1Jmea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4531B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bK7T1kR0zDq77
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkB1Jmea"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7S68B3zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:32 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id k17so7599688wrx.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W+OTpVZBA8uEEjVrhe1iZlVCIOZYr2qeStkCdhTpd78=;
 b=SkB1JmeavbeT/kTYfi6qOrpvDBimlKj4KDGXksXabW1ICIC7apPTZIiMAG33Wiz4bI
 IOHJANsNqGrY3SbYCcCSYI2/fSkx95TaZTPXS+Nsf7V3DTZjvguJlMQgyQgHa6nmJCTc
 SsJuqX1ZBxXo0Mv+1Cr6GNeyanJxYNZ05tAH5FRztqFehOTA4nq/xLPcIWBoT0sdNoiz
 UUULkWWlSqDKhdymFVh7XruwJmIEVZz/xaF6CfK4K/G9DcUrEcn73sR0ulpV1JuMesAe
 KHQX928kMa5IdIfW4R/4fFE0o3xPLaxLgcU+Zi09QDFtFGXLB6WVno4Exu4v9BHcw8s1
 m3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W+OTpVZBA8uEEjVrhe1iZlVCIOZYr2qeStkCdhTpd78=;
 b=fIkmxVkEjeirneEDKgRdlcN+JrN3oQARFDW913XpMBbZwQ+/iksvdXHwPfoiqEknxo
 dloBJ3jugHZ2Enf6cq0J+8hIlMKOctPuv9A+fZnfl/kQs+3dYK0FcpP76qg1BF0S+qv6
 8Useo4WXZQFYTUWdngDtYs48QUzd64esO0Q5W2pHzTXdH6IqXaUSofPLvmFhv6V2lU6o
 qjZFxPbcpyUQ5NWlFMjP98NzZhJ8Jkz2osc+PByYsITcJ87R5xj6CXdsWLKGBhWG9OIx
 jmZECzwS/rv85jJqI+No8LPiqn8dsvARhzDKiv3kAMQWuJrpuNa7C/nChke+TYcv+ggJ
 59VQ==
X-Gm-Message-State: APjAAAUJb/axNxiKzIMX9gSWGW8VLAUFzhJO2Du3R/V6mLw6CecXX1KS
 rRjlHlZxlJVkxzUJexWFsyY=
X-Google-Smtp-Source: APXvYqxE3rwFGHbzDjKb2cE59TTOK+BEkT/DHYg9VnVuBEFYoT+927OS9xrZVXgngpKGGf7W2qIcbQ==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr7890715wrv.70.1554465089746;
 Fri, 05 Apr 2019 04:51:29 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:29 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] ASoC: wm1133-ev1: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:10 +0300
Message-Id: <20190405115010.28838-21-andradanciu1997@gmail.com>
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
 sound/soc/fsl/wm1133-ev1.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 2f80b21b2921..aad24ccbef90 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -1,16 +1,11 @@
-/*
- *  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
- *
- *  Copyright (c) 2010 Wolfson Microelectronics plc
- *  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  Based on an earlier driver for the same hardware by Liam Girdwood.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
+//
+//  Copyright (c) 2010 Wolfson Microelectronics plc
+//  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+//
+//  Based on an earlier driver for the same hardware by Liam Girdwood.
 
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-- 
2.11.0

