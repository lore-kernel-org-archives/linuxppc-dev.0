Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D727C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14E6218AE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK/yz/qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14E6218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJp61rVCzDq7n
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:21:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gK/yz/qG"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ775hfpzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:15 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id j9so7632457wrn.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eVtJaCRQkL06Lgj4cYGTrwycXVpfjWzOTw0Y4T0ycL4=;
 b=gK/yz/qGLluaLr0VEbpy4b/NOkCKfLa23Mq3oyuyjXjAd+BmnANAhTrMPaVhd9kmXW
 q7KA7hjlTjKhk6vEyrs2q7BEsCTNmBtk7QParQgv9OZMB4dq+xOeZTfdzDKghG0nVorA
 bZYCe6PlcaDffA5MyIx4MsIeumV8T+/PpYoRcd3iS+FH/uJTz4Ja1yAbS0KnbKFih6tU
 ZTI3fQvu/9lnbtJM3oA1mowkFRJTAWC3GuziGZAE9uJIHs0JGnep/C3vD3GmcMFdC6oH
 7N+UMqqe2D1QrIJc3E4IQYMhw3BL2576iDieyfpQXySvudn5McQ4I2TXMEVW9uu9DScf
 ILBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eVtJaCRQkL06Lgj4cYGTrwycXVpfjWzOTw0Y4T0ycL4=;
 b=AeDD+jPFEtMGxbQXgJbg26Fwa1r7Zc4TSy86do3N81D/0ogcQltBH3mbpSyRrT68xQ
 HPxgjYpNqx9qoqfauwf9L4vAkj0XOoXzSE79NmtWZV9AuXhHjKTgf+32CUkSVunFKhOV
 f1IWS4TwcGbKK2z+4QrG1Fgu0/bXXR8RIrGLHmVp+jd1sUyK0WN4BJHhn0p8Kl6QFfmr
 eQiXU0DB0EsMQ6C1Ze1YI2fCHKmVpRZ/I8kCNfxMo60AeEDevJnD2UpVJNlRHDczm4O9
 T3uHz+YmhNGYab43E5dKH7LaZTeK3B3anGUDA/+ciOYnLQdK5oBSYY61lSwgIDS3vS6M
 MZAw==
X-Gm-Message-State: APjAAAU6Oa+rV6NY+xmUorzUe7jCCMkK7aoGPsBwu54GB7r6XBzSuBGh
 BtUHRL/vX7Q+eRvYEOifTEI=
X-Google-Smtp-Source: APXvYqxsNu+QSOxKTRBs+pDbZjipKEmZVsheIqMIax4sUKKoTDW5BJEcsbARSm+yBpfjBkMmYYM6+A==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr6380191wrs.155.1554465072316; 
 Fri, 05 Apr 2019 04:51:12 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:11 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] ASoC: mpc5200_psc_i2s: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:03 +0300
Message-Id: <20190405115010.28838-14-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc5200_psc_i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index d8232943ccb6..6de97461ba25 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,10 +1,10 @@
-/*
- * Freescale MPC5200 PSC in I2S mode
- * ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2008 Secret Lab Technologies Ltd.
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- */
+// SPDX-License-Identifier: GPL
+//
+// Freescale MPC5200 PSC in I2S mode
+// ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2008 Secret Lab Technologies Ltd.
+// Copyright (C) 2009 Jon Smirl, Digispeaker
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

