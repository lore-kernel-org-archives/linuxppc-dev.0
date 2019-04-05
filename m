Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE653C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:19:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC3C21872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVoxKxkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC3C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJlk06glzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:19:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OVoxKxkj"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ742pRxzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:12 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id s15so7581652wra.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cZ2Eh8nPw5NozYwIo7t9ZHAY0mdcKQwnuOcnp67UPzE=;
 b=OVoxKxkj8B96yrWm7JVvuaRWaFhcSnGecIO4ZJA9Q3U0iudg8mqJvstNdf9OCWepdx
 8vQaxrPXV0yj28goSjbqV1NblFDB5vV+cNtkxBou4BXHrN5Ui6lZ1jj5HVgqR0h2O7kO
 OIZklqibGur4wOpAaKrbYvEnF8O+Hc2mR/prJvz1h0dyYR00nIALrWg4DZb0LoFigfaF
 O3xeHHytblQF5ysFn2lNoxs6yL0BTs0RYCtib+J6+1eevxclcMD4WHT+sFeFp5eYBtY3
 8OqFpEPH+apkI06+saNp8zS6VvhMNUns/uikLjxFOu2YefRqy6HxfQeZdb7ob0fyinL0
 KkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cZ2Eh8nPw5NozYwIo7t9ZHAY0mdcKQwnuOcnp67UPzE=;
 b=EFz4h9r1I7CWAhyPEG5SeBFnbbnq1g68EkxMxJWr1g1eM7gJDnvz28IbR/nz8KQlLi
 zeIZgA2AmE3jw225ksoGeyijEgYpQhhAbhWjmUjwK8mYAtCp+hn0wbYRF+0qoeAWHnXX
 RVWx2WLm2+jFITSMKbFC53EICZKfLkQawiS3xLgKUnUO77q/TptTRiD12PDfW8jj1Ab+
 oHjQ8/+ncJM+YBkXNdK6AGjc8N4WkSYSQYUvETt632US31TtPvFrBuYt7HvZFT6GkZxs
 a2o7xor5Bmdk4fw8nBwiQXBAqhccmRcfDRE1GErJfIY4fHo2pxTBOHwaAIWHbAJr3lOb
 JwtA==
X-Gm-Message-State: APjAAAV3yBbffDBSQLn3hNzAYLAVyoVEvv5LL6UtsFJAMo/DUzD7FipG
 vDXFzcoExXU9cpBPTkKDE1s=
X-Google-Smtp-Source: APXvYqxEhgbZvCol9ZhROcY/Z0+1bqWFNApeJ3p7e5cSeHL6F7oEa1m08Xo3gEHPs14NohPvNIFfOw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr8020892wrr.275.1554465069868; 
 Fri, 05 Apr 2019 04:51:09 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:09 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] ASoC: mpc5200_psc_ac97: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:02 +0300
Message-Id: <20190405115010.28838-13-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc5200_psc_ac97.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 07ee355ee385..e5b9c04d1565 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -1,13 +1,9 @@
-/*
- * linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
- *
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
+//
+// Copyright (C) 2009 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

