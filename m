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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA74C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:54:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D60206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkYoDdQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D60206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJBg2K1qzDqQy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:54:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nkYoDdQ8"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6R4GnLzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:39 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id s15so7579668wra.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=apVZzohEFjAx188m1C/O81lsXu0DC3YBEkwMIH0+clM=;
 b=nkYoDdQ8jPf6ADAJIBtCb5DBeFENQdusec1E3cBQbdsTnWLKL38NaAxvM0wDBE+kUT
 aXjvHzbq1Md4TxjX80JFdGGhP813wt0zorr7sKlg8VJvJj0jIRB9E8oIJaLutgk7ZFlY
 FpPCIyAV+JGiy54CepCQg+9zSGQFtgB+GlcwCYRS7KbzstcLdCq0NJz00fSUSDzeIZ7V
 VpxFBhvMtgYJ/UF5ayfaky3ukAAJubr3ShLVH+07U8Pp6P0DQm7zM/JELZVOPQRbfimx
 GW3oeWvXH8lf7NFeYNN67vSpUlM8H9GGlIVCGRmTfz8lM9Ql7KmvqWgLRvfvGk+v8TcK
 u1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=apVZzohEFjAx188m1C/O81lsXu0DC3YBEkwMIH0+clM=;
 b=X/jQjnqDlRVj6/GcSU6+n3xT2zmJkyBqUeIjQNcjQWHI6eZ+zDxr3SkIdKfBhASaWF
 erntZxUwQXLFQ1ot9i/HPyv6ZSyLm4FKs42CLmj7TWX709B15kJAgyE9lEbGxYtwsE0i
 9x9JxCFrfSS3iJMwioI9zkK5rWMoFXDvTTcQ9QdSW0fHD41DemArh+/eO/gO7bpeiLq6
 nkMDZ0NoaalNl7FRlRuxF+Ysp8nv/AIljxu7J8ATcHKePSkstGdFprbixDwm0/uIR7+V
 qm/O5y80v/J+NT/MRL4u8sNidKJ23Z4fNBtQ9cLaAWnCBNUBdahkGyrv557CUtCSqEWC
 wO4A==
X-Gm-Message-State: APjAAAUmQh1X5sLeiu6ibuEBUnnQwFs9HCi7pd8+jdJ0O0p3ZGM/cfSp
 dr2lVmp0Orut4qiaVsvV8aY=
X-Google-Smtp-Source: APXvYqxl7t0t4oCjNKlEERtxsQUKK3k5zVjxxop+uOoikQg3sVc00uhaZ0zWydOy2MA1no93pSnA6A==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr8513251wrw.82.1554465035675;
 Fri, 05 Apr 2019 04:50:35 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:35 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] ASoC: imx-pcm: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:51 +0300
Message-Id: <20190405115010.28838-2-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-pcm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 133c4470acad..5dd406774d3e 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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

