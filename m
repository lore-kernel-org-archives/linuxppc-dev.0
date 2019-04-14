Return-Path: <SRS0=tcMx=SQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF3C10F13
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:18:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFFA20850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0spRslg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFFA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j1cl22zMzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 05:18:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T0spRslg"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j1YD1tf5zDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 05:15:12 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id c1so17727590wml.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mNEsHRaFH3bUiAbsBbfcV45O7daG+K3xE7YuRVVXNPk=;
 b=T0spRslgLJbgcplq0dNL1CcImHfhgGK+gAi6nYwJva8YY1xcEPAGeMxhXW1yzxean5
 4t7Ea7LHj+Li+9zaVJ0cJ079DQ3VIbdWc5qrZ2nx7Y3R71ZsgAuOQXe2kbghx5XNLcwc
 5BQtXKitkEsQmdkvjQ/GftLCAbHHFBu2Vbj4ymJwicnni5wS5o37sfhIiHny3AF1QFiy
 SUOUIo1U6M66Vw4Wn9Vsnk+FuHD3+dbAlE26NjLBueAZOfTB4pZ+1eQhqdW+wEjaEJE6
 UU3jmVoVZAaMYu3mv2lKq8tH9PGAZtuVt3x0wFHBKXtI1blNUZMNtch5BVztxGu9x+IY
 Hzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mNEsHRaFH3bUiAbsBbfcV45O7daG+K3xE7YuRVVXNPk=;
 b=e10UhW2mlfR+iak1cnrIGM80PilhBs1tO+aW/4wiIh4PTHjMfFO/DAVsK0RyLTfBMJ
 a6DpROegy+j76ntHI6esf7smIGkbbrDj3oT9eiOU9fqKJBPwSgrYB+DsH0o3wAmYQLyu
 xj0Sk5OcrpiAqinl5LP8B1llrQ/IJlI2Dj9jVYiiGkh+00xOU1yHw2WUgwDTXIOpN6YI
 1shHaYncJGfxL/zr9VnKRt5UkVyVodwIBco6GzUnJgE8Ve9b1rb6VcQ+G/Z8/pvM68JX
 aq8d7L1Au2EDIgGVZY7tz34kd0GnAYJBGJn6yPo2ct5ye67JJHZjr8V5li4/FBF0ccG9
 dEMg==
X-Gm-Message-State: APjAAAUZ/ZmXoEko7Ewz6RK6iuH4JJKi9VhVHqAv5uLJn+t/ZypQCD/8
 Z8PhAreUxRjbklWRPZvbw3w=
X-Google-Smtp-Source: APXvYqxNw7Oej+ztm3MeI0gGZ3/lctXa61YeRHdJ3cSbZaM3vzek6YVKZgIe0kqYPCu+oR+9/1luuQ==
X-Received: by 2002:a1c:a010:: with SMTP id j16mr18708650wme.40.1555269309146; 
 Sun, 14 Apr 2019 12:15:09 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
 by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Apr 2019 12:15:08 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
Date: Sun, 14 Apr 2019 22:14:49 +0300
Message-Id: <20190414191450.18377-2-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414191450.18377-1-andradanciu1997@gmail.com>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
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
Cc: tglx@linutronix.de, daniel.baluta@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 4396442c2fdd..ccf9301889fe 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC DMA
 // ALSA SoC Platform driver
-- 
2.11.0

