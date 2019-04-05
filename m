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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:13:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6592E20449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWOBojNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6592E20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJcs0n7szDqLv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWOBojNR"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6w6jcWzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:04 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id h4so7632821wre.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BeL1g4bbVVRk0NSIcnI5lqtabiN5icdMHgTYrfaRgdc=;
 b=MWOBojNRBOQnXZn9gwu5L+RaMvmE5KeVWfJW+4FgzUoO5SFHtiVo8GetomTjphJXe/
 e2j7Qo01PUgu4WdtI4yVpRfaEMfSJnWiWZpVLBwXP7uA6NoR5xvq2uV+9hxbnfmRRwdV
 dfvhzDlTzh9wn5cn3YY/+CUwHBSTN+HdoFRA1XXEbbKBZ8DAYjS8eQt9E+xo82HGEV2v
 H37yqLNIP8r3CvRkQtYxoUhsVYysXnLg1Rg7FAfSB6Ukp/dpkmXcUaVfRXNmcWNx6oI9
 gC82e5675B/Jof+VQKgCSJF9B8wtoWLiNMwCsL0N6mCHTpIJXDpI6Cq+tsHDHkj8ON5M
 Vxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BeL1g4bbVVRk0NSIcnI5lqtabiN5icdMHgTYrfaRgdc=;
 b=FY1JWKXMoi8UoIyRXEDph6RxX184NC/GTj1cg/h8SE/ugU00ATDa/Vd/UyOjbFhLSb
 ItZsgoHhRHdHMhtplENg/284bmDsGORlF6UXXeZYjiuk0BgIwI+zKbwvAOvVgQ7MFAZL
 eTM4vtb68MKhZlv5mtbXE2RljnDYHpm6FGMjFNCXiMJlTeNLf8FnvbLpJSA989SN9XSv
 GiV/ki2TpHn+FALCVPtLsdNB5gE4iqiiQrhWCB6OPe4ZUql+tVzy8HFoB2aaTCRU6hTA
 +Cn/bAU/fMaU5MokSoahqJHkbLA3VwMHHLceBPX50CRdq0J7wdIeEbIvpPA4Imdah+XD
 bHMQ==
X-Gm-Message-State: APjAAAX2qk+zn9wjdMQSPoP1kftUxMi0QyOkF2lHpTaeERpic8x1g/6F
 Xru7imS+T7/jA5VUNk6PmpE=
X-Google-Smtp-Source: APXvYqyELna0ZxQmwoCxXIuHdwnj0hHGcki9RhhBcD9pj35dmjw7DJaeek0IVPuiT92eBM8vhWD1uA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr8045901wrn.270.1554465062410; 
 Fri, 05 Apr 2019 04:51:02 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:01 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] ASoC: imx-spdif: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:59 +0300
Message-Id: <20190405115010.28838-10-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-spdif.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 797d66e43d49..4f7f210beb18 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -1,13 +1,6 @@
-/*
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
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
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/of_platform.h>
-- 
2.11.0

