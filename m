Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:08:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3578221871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQToVb8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3578221871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJWB1LtBzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iQToVb8W"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6r0xkHzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:59 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id n25so6854895wmk.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=utJGoRmoCt1Yac5uZqSPuhhOnZaRHyvqQEV4XOPwu9o=;
 b=iQToVb8WaIhnC0kFylFioMF2Y9UqvJrZT3P6RyY9oir8Vgl5sB19XtviB6yuAE7oDm
 FYNp67IebAZFj68B7FE2+QhvL2Z8WuTFOOeG6VfgCkUXKI/QRdh3TsE2sB6BJdKNNPtv
 82+ODDhd8AP2EzpgFR77ymPF5vl5d78MkU0yI0cJZhtFCOKUGZ4BKppQfwcbyY+f3szf
 SMxIE6Rc9NARa+qRt+iWhauQIzdI0oEIxuKqil+oDQMZBByBsSjOAZ3x5ZWBsNZol2pq
 iAU2ZzyM3Olp6h1xHc3JRG4/jcPqnFEa6e7s3bga5naetU143x54BdFnrlsEDhVyrxEK
 wzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=utJGoRmoCt1Yac5uZqSPuhhOnZaRHyvqQEV4XOPwu9o=;
 b=TUg4Sozy0rfMipXIaFAEH+mjqhzbSPr9SwIw4b5Sgy+jpEnwMKQY+68zwCiHQQ3kXb
 fKzyXahQ3CTUCeNmkF4/QtVZNkxwsw9YcsetfG3Uo9mKHTdIIZ1UNcx7Ntz5dzgDLfx6
 is/jtWcnGY6L0hZXrYu+niQHEW30qPbb7AP/5z5YQJrKeUGjNIQiZc2jRrSJ8QVWswMn
 wEwewyagzoiVEOwdn0xSqzrFvaFc3Kcoh6UsQIOJgPgLT+Q1Uu1M1dGSESi11P8p5rQJ
 Dd1/ciH20PlY6cbVj2WMfC3GMFdeo8fs8HAvtg3dTDB1M8G9Xd8aKyD0tYQMZ9kQ94hJ
 RadA==
X-Gm-Message-State: APjAAAVSsILTAFdEHDqi8EJACQSM5j6bfmsCzU5BCW/jfDJPrllqCRtq
 dEZhlc94oRVCLW2NAaqr8bE=
X-Google-Smtp-Source: APXvYqwTeKzT4qf+7/FYVUNWvvkVTEMxThnfCNcy69yPA3QINTDt4y04btghmlO+O+nhMq0z0ijpkw==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr7588888wmf.118.1554465057276; 
 Fri, 05 Apr 2019 04:50:57 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:56 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] ASoC: imx-mc13783: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:57 +0300
Message-Id: <20190405115010.28838-8-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-mc13783.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9d19b808f634..545815a27074 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -1,17 +1,11 @@
-/*
- * imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
- *
- * Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
- *
- * Heavly based on phycore-mc13783:
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
+//
+// Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
+//
+// Heavly based on phycore-mc13783:
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

