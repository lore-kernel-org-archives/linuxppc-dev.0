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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB14C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:27:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887FC2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0U7o2qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887FC2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJxL3S4NzDqC7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:27:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h0U7o2qk"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7G2NpyzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:22 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id k17so7599028wrx.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gZNUFVuK2Ip7Na6VoAF8VrYLolRGJOUaAHxJxLV2fxQ=;
 b=h0U7o2qkomaUsnyU5u/DMoTV/vKWJq1BYNKOlbZGj8KA+lHIZ4uUd2zOPNFsKfOkng
 bCXqaqc5Higp7eSDX1Ll84Q9vQs49Ijn1di2EkQRBGQd9FPV5LsKUpOl3GUj6mdkG5Ra
 uRjenwN/QiS/G0nQzjnp4BNi74HGm5pEnafUCQDgKmQyX517VFEwjMeeH64CWz2YWWNU
 AkBKIowDy9xDiDYmu/rTHOwG8e/Wx9ujcMqh0Ga48cFxSFxedbY3KQOtoKzJ7G/z+9jG
 YffJSpUONHg6pEQHvJ7RBPbqidyV3XUHZb7ygusQV6BTA4UpNa4widr5DpOk2O16ickr
 e0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gZNUFVuK2Ip7Na6VoAF8VrYLolRGJOUaAHxJxLV2fxQ=;
 b=Q9apqx6G73VRljYI/V6SlBPhiCXy70hp2UF+1Cyqb5b6ovuu8zpNL7SkuhRxnajAzY
 T/gre4OkClFLUANgaia0lG0GsKnA9OGk4eRz2HmezvsikoEapLW1Zy46lQDL12xnA7c0
 8e1RdqERJ6cvzdFRHs2zwR7q8mmPHSF5hXEp1ZQLVadPZIg413Fwt8OfddtjDmMDXrlJ
 mJqOpWtXMwcdQXcSVz5DgNsbZdhV89rYchApB27NADUykcNEosIl+FjMoR1SiaLzghc2
 gdsEVdPe15w73OVh9lt0E2zcOnwugpLtarhTO+hUCu/443CMTg0tWrUV7b3C9O2yyW0v
 GF3Q==
X-Gm-Message-State: APjAAAXQlTWSkmSNR2oPM9o2tVhxwIdiE2+YS9Oqi8PTCiEQ30S14abo
 1a9OKhAknNbWLfHWxaKRsCw=
X-Google-Smtp-Source: APXvYqxmQjiuc5lPmpCVW/t03gCutNrhBUicA92cYZvj8lDyFHa1XDF2y0mPr3vgs3SwmIi7aLDtIA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr7950780wrq.94.1554465079801; 
 Fri, 05 Apr 2019 04:51:19 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:19 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] ASoC: p1022_ds: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:06 +0300
Message-Id: <20190405115010.28838-17-andradanciu1997@gmail.com>
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
 sound/soc/fsl/p1022_ds.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 41c623c55c16..80384f70878d 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -1,14 +1,10 @@
-/**
- * Freescale P1022DS ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022DS ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.11.0

