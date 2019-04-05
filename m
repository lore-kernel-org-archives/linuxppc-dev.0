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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6813C10F00
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F9B21871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7WJ5lCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F9B21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJKC1B6TzDqDb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:59:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u7WJ5lCS"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6X2ZNXzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:44 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id k11so7649555wro.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=95CAJLAF/PMh3aeIKltAlThBxHYZ7/UK1SaFatHO998=;
 b=u7WJ5lCS7iL4lqzM3ecwPPol6uZTsc7v7KTXVWiciGyixt9FpS4PoywAhrXFrJWhOa
 WReiXf3shgTK5AB3fYs7eLGzO1ZosLvTjFLyli7sdGkqk/JEH4zjA0GEZXzxGOgE9r1S
 CYMUHqlAJuwOUTGpeXdD3YxUcvWMjMBNocKn4tuFRDT0ARxlH5KqfC2rIpxVEgl3Igle
 TaBB7Efs1SLjxaweWRhyV7QBtS9eVjECqdGgIpROtrLi3J9Nc7U8WNB+D5GYB0TMtlVl
 aqQ0ryTGfkEziO+ThyheDASjpCCJb55WeAMYtxACZMHRPEKuPI/c/v2QN9VNb0Y+I3Ku
 k/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=95CAJLAF/PMh3aeIKltAlThBxHYZ7/UK1SaFatHO998=;
 b=UvGLkygSgskQgq26XrFNpI1W7cG+uIUgHAJ+hIJONl6JC0VM+gNTBc2x3qtMpnHB4g
 ee+K2p+mKzN2FRlH4iJdUXcmnXMkb8rXMVaQWsH5u2enTwjP2MKMhrg7EuXOl4U3tpvg
 KAUMMahLcXH4WN+7N/rgbXNYsAmjrmnBkKtqI9pVl9Cl18CcqpwzuiFWnJmL6mW8I6uM
 lsFFFTmvPLkWpLGe4Zd0U3yia1LXvUtEDKgt/ij7mXbJnDpJpczX03WmBiG6z9SH1Y2T
 3ixrxxQ272HFXBLpS4R0+HQlgCwvnE2waTv7O8vaw7WlvWLn1kdWmKQWo/sQ6LTtjbcs
 IapQ==
X-Gm-Message-State: APjAAAXZHPynd4763HcmtvLwNQV7xbWGQ0RgFKHTJ+UhnY7wwgs6QJgI
 2fqNVgVTsKB0Wo9ZO2fqW48=
X-Google-Smtp-Source: APXvYqxuFJwAJF+0VqitwVMow9oRZU7BpMGSQ8snglUrvCMtCwk1TGPZIjFoQdZzmKvcJszT9eAgQA==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr8339985wru.215.1554465041835; 
 Fri, 05 Apr 2019 04:50:41 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:41 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] ASoC: eukrea-tlv320: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:53 +0300
Message-Id: <20190405115010.28838-4-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 sound/soc/fsl/eukrea-tlv320.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 30a3d68b5c03..d648268cb454 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -1,19 +1,13 @@
-/*
- * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
- *
- * Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
- *
- * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- * which is Copyright 2009 Simtec Electronics
- * and on sound/soc/imx/phycore-ac97.c which is
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
+// eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
+//
+// Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
+//
+// based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+// which is Copyright 2009 Simtec Electronics
+// and on sound/soc/imx/phycore-ac97.c which is
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/errno.h>
 #include <linux/module.h>
-- 
2.11.0

