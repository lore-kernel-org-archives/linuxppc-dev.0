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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A754C10F0F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D646920449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW6g/tH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D646920449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJYG3BfLzDq77
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OW6g/tH1"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6t4x3BzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:02 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so9562542wmi.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SYxt71K5cDuYYPDOLPDo0W42xN9f7ymOpTx0siZ9uFE=;
 b=OW6g/tH1grTVYgYEYMkJQbGS2cn6t1AC3p2IKqubQ54EQizIAuwEvs5JXVE4lGt/CR
 6nc8o/065laVyJN1qVxfbX0FjRuuQoFeswJO0AI1pGzl2lJ6fdzIt9g2KpfTNRL3CNc+
 Z+zSN86+hb/+/F80dpHjBNdJJdnTD2i/dVJLvQqcTbZ31khy40hMJPvsURuz9lWoj6Om
 YBstLXaN8thPL23pihpdzG1E7H6E6wSR1jYXrGY18usTK0koOjV7CctYYxnkd2/H163Z
 79GJuot18wl/YGx+KrtdW5wuaDT5y6KaQ/UxjgDaGhi/W78tSGfFOFgvdCKu1PNmY8FX
 homA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SYxt71K5cDuYYPDOLPDo0W42xN9f7ymOpTx0siZ9uFE=;
 b=Q9W2jhTVBd0/ik/JIuWuH0uHZUBv6ah23DgRKUxxNK6UVIEyYn40lpK9Hqn2uz9sbO
 7Gu2JoeDz3y/KHnQAzLxavu+gqQ+qqepkCxVVFQdeH9K86ihC4k1047J/TlAcd+9dgl7
 nAcnJTLYfCs7X31ApKNTh4SlK40UmpSb09kz55TfE0P4A7kIJXWZ/fCpIQlpqXGDs37S
 dpC3/Ps6bpog0kHLpl8oQ0oeyx94/gExQAskbqDpoISkEY2Lb8v5kfGO+Qo6Q6bEJSHa
 y3erpkO2/J/fdXxW2LhsPZwk1BIFVWfJHKpYvFrs4zKs1EAPP2Q1kAW/scUjCEzOrp52
 DMDA==
X-Gm-Message-State: APjAAAUJcCW+RJLU+qpovCpI/2pL2x4D6wiOakWzqBxReGspWqx+cyHq
 Mcrhr39rmyhn9mvITTThiQk=
X-Google-Smtp-Source: APXvYqwxNkQmVZrUi1vsYyK/2xnLgyg9ZpKXI/epAYR9GMay32GRo4cEV01N9SqKEx6qeF1Eb2HGPQ==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr8042987wmb.101.1554465059942; 
 Fri, 05 Apr 2019 04:50:59 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:59 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] ASoC: imx-pcm-fiq: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:58 +0300
Message-Id: <20190405115010.28838-9-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-pcm-fiq.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 0578f3486847..c49aea4fba56 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -1,16 +1,11 @@
-/*
- * imx-pcm-fiq.c  --  ALSA Soc Audio Layer
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
+// imx-pcm-fiq.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-- 
2.11.0

