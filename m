Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0372C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:17:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD7F21871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ9izbld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD7F21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJjn36dCzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:17:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJ9izbld"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ723QyXzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:10 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id c1so6327455wml.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6CKd2aDJsgP2hWOqiDkLKniTsVcnzpZOMdyBGV6fEio=;
 b=pJ9izbldDPFDxl4JmV3u49KvY6DGq5hrRchRNguSR7cK7MJxbXa4E5bT/v1K3gY7f1
 tJpH2ZnV8do1FB8pylSVXDHZd4XWOXPEVy+lPB1bUcE4jFA8nEm2bee0VdSO/R523b4n
 qh5ZHodPJWAFbPqGBd9eCOOhNkdVPrGRrYD9CrBGGG5YNXyGg87ezNkU1JhSl3q+jqAx
 hMyYw49oRmJDzLFY1JbTKJ6D3APmZVYiqEXtT7jpJRwm3jFMkCuC3NiPxV9XG0pMEiE7
 QOJhiCCyUg6QHpZ+1IICmG19aEW+IkNin5NL8+T0+MOoCtcqoN9zuHewi4oxySIxWnBB
 GonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6CKd2aDJsgP2hWOqiDkLKniTsVcnzpZOMdyBGV6fEio=;
 b=JM9+r31wRn7rfqnqW2C1IVmft2NESQvlfPALv3DH/bkYyMVgGihmrq2UuSDi50b14y
 +/2GAiSzu5F0bIU9yzslegHKsdzOJNTRzAKgja4lkniU+rxdpzyEC8/nYUpaqg/GWYH5
 XMKt0SYeF06wO72mPWI7TgUKDM6G8AxntyWqcLT1HFCPZ5gZLKUIqQXyvSnK7u7BgGNV
 i7kqgHIWeXi1PqtX5mSBTH1wDkJjSsR9Zz0WsncbD5El6ofUp6g45BAL71brbwHua6eg
 FKWZBW0ekU0y2Q9zJvSyIPjoS6qkq1W9nHi+PsUe04KBHm2wvNG8JTFGsS+iH02rpn9O
 A3PQ==
X-Gm-Message-State: APjAAAUPM+EEADZMuYJaZY+lKUtmyOcVyP3H8n7xG384P0YFNB3LRjri
 Pe6iQ9X4VHFBmcREhZEswGA=
X-Google-Smtp-Source: APXvYqyTxHpLYLeysm/HlV+n+VZ5SRSwzCKz1yAWWQvIC9Rgxe8rbSJZItE9HKUY7VwOMlezU+y7SA==
X-Received: by 2002:a1c:14:: with SMTP id 20mr7358086wma.66.1554465067303;
 Fri, 05 Apr 2019 04:51:07 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:06 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] ASoC: mpc5200_dma: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:01 +0300
Message-Id: <20190405115010.28838-12-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mpc5200_dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index c1a4544eb16b..4396442c2fdd 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,10 +1,10 @@
-/*
- * Freescale MPC5200 PSC DMA
- * ALSA SoC Platform driver
- *
- * Copyright (C) 2008 Secret Lab Technologies Ltd.
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- */
+// SPDX-License-Identifier: GPL
+//
+// Freescale MPC5200 PSC DMA
+// ALSA SoC Platform driver
+//
+// Copyright (C) 2008 Secret Lab Technologies Ltd.
+// Copyright (C) 2009 Jon Smirl, Digispeaker
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

