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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00728C10F00
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:06:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A14E218A6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js6wQDtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A14E218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJSz0rGPzDq8M
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:06:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="js6wQDtV"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6m6gyMzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:56 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id q1so7666989wrp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j/G+Q6ryO5QD2klIAN3tHHLuG2QV/gS3koPfNp4bcRs=;
 b=js6wQDtVU2nDddmV7dXvCTKNRa/y/ndS4+ea9fmqr/w5sg6eMJZVW7rbeXQmGks7t3
 DbEtUuQOrWw/Lz7jVoeU3MG71AUYz9RN9ClxkYYqnvdclL0+1xN8NNZ4NiMFzuvWw45m
 53Y2RCXSnh4WIaBRWYybjqvYHy/WLSJt7ws9SxB8b5EowrDOS5g1ZHJ8H+78D0LIi79/
 PaPAl2TqPfa7tSemODxMoWaW5Sn15nRz9tgfc8gkA0YPMy9FPpgkgfFi9BgzC0ER4Eld
 UeasmiJDwRZq5HUxF+m6mho6y5zdjiPINjoYkMHuOdxBs1HEwsK4a5Ld7qEPvcSclf+Q
 Jyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j/G+Q6ryO5QD2klIAN3tHHLuG2QV/gS3koPfNp4bcRs=;
 b=n/1ebMJjEqHaKWENw6Lj6p1AhcGB/nUjwJusB7mjVnQPtpIH4Cz3YaNXcyMj8dhAV/
 jm9g0Od4TvXoEmier5VovwrxmQhwFvmqZt1M7x92Omk7PHdXnBsJ7BCzdoCtPoZYAdlU
 AzpKGctt06HiAy6udiLJUHj/rQy1z5qhZEyIQ+s5gsicmaSdJIGNxfBkzlVdwwIgIneV
 F5k0h3XQyZ5LDDPxqhwTKhwrX6RQmsk9kYnv6gIC6GAZPggaEMP59KR9xy2hCpbVGKX2
 HzPjIl3oMFmLK16TN++NlgZA8IbqoKLVmlWYmdnNqWnBQA3xYeDxPis0Fr583t5mCrRw
 SILw==
X-Gm-Message-State: APjAAAUxP79d8FwF6T4Km6buSivJvkP7x0cYg+UV2LHOIa5k3XmBdDUN
 IpvMQoc0kfxWRxDHfxm7e6w=
X-Google-Smtp-Source: APXvYqzDUpZcwDBcQbPYSpsa5G5tlghd4vZrHUHPbGiJZws4jMXKgcJbhOiwhWclw9PLaKPzP8M9HA==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr8341942wrp.268.1554465054410; 
 Fri, 05 Apr 2019 04:50:54 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:53 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] ASoC: imx-es8328: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:56 +0300
Message-Id: <20190405115010.28838-7-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-es8328.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 9953438086e4..c9d8739b04a9 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -1,14 +1,7 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
 
 #include <linux/gpio.h>
 #include <linux/module.h>
-- 
2.11.0

