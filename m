Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E95C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:33:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8895C2075E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoab+KGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zj6Q6sdzzDqFC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:33:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uoab+KGa"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZhXC4xkBzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 23:07:21 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id p10so3507957wrq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=YhF7Yyp3NHJgHKxtsLDDJ4tfXEAoiWSbLHZVzljiCt0=;
 b=uoab+KGatCrUW1FrMyvvpx2NTLZlMCheQx8H+aZgmOO2503Z8AY/utFRnKYXUbnHj9
 zjScnwJnZlSvq0QsEIgqEB8EyARCheSHloSgKjRP7/udLU1i3s9SjPphG5CqHBZxSsZn
 b2clTnKeZCn8a/ZcdXBwQ+PGBKrpFzsVDsuxOsR4LKIBnEliSOBi/uOHBL19jcWinKLT
 35D6FGRqbEuqEvEt5+IMXP1GpDlI4Spdy57lEsvaU44JTQC/v4CVxFusm/ilPXl4ij/h
 TJWs9/cAE45naGMJQf5OADFbyRAuAt5ALzUGuNI5gcntIrnYMXaz2FDx7JirmmpnB5NH
 Xqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YhF7Yyp3NHJgHKxtsLDDJ4tfXEAoiWSbLHZVzljiCt0=;
 b=GdqThti6E0+0hC3DQPFTES3J8VnYzj9MaqGR50IB1ws1XPDLI736Q1CQTrH3fTSl+X
 qGWIF9yb+KR4BuumagjOLf6Nh6dWpumYx/w8LQ8Cfpjm8vzYMD5nRzFHzdheclTmvzD0
 63FxhSyUX3lW2RL0vOMKLya0DUv6tZFChEQ3QQ1rcjUv/w99FLhCbQcLJS6Naia6shfO
 T8VpREmpJOn/5fMNK7OR2gIdJ6LbFbS7bMvcSrt/5AuYQZa1hW4maolpU/aTZuXPRd4G
 jRqcGKgs3KuddIfR4qZjFzD8Nn6PpojCI1jutJnGhdSOz7GuHkNfqmzsrYtuGLq5dWjp
 vZMg==
X-Gm-Message-State: APjAAAXnenJZhaRlC8snyd7dYBeNGEzPZvmAjVCRRFd4co6ucBesFfOz
 woLmG0USrq+BgMLVYHzN8S4=
X-Google-Smtp-Source: APXvYqy6DulF6oVhg6R91bVpVFWhckPT2aBbbsP5xgFX0nbcXAvWzxUv+SCDpYqgnyaqse16W6zD4w==
X-Received: by 2002:adf:e84b:: with SMTP id d11mr3640453wrn.289.1554379637557; 
 Thu, 04 Apr 2019 05:07:17 -0700 (PDT)
Received: from localhost.localdomain ([178.138.32.90])
 by smtp.gmail.com with ESMTPSA id x192sm23965445wmf.48.2019.04.04.05.07.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Apr 2019 05:07:16 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier
Date: Thu,  4 Apr 2019 15:07:03 +0300
Message-Id: <20190404120703.30054-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Thu, 04 Apr 2019 23:29:00 +1100
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
 sound/soc/fsl/imx-pcm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 133c4470acad..3ce2f437e645 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
  *
  * This code is based on code copyrighted by Freescale,
  * Liam Girdwood, Javier Martin and probably others.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef _IMX_PCM_H
-- 
2.11.0

