Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7196C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CB72186A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msVcIcmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CB72186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bK2S085XzDq6M
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:32:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="msVcIcmc"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7M5RtgzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:27 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id c1so6328321wml.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j0LHszZ06ydUWsHWSBiBJiyy+zVHgOm4jnvb8gHVHMM=;
 b=msVcIcmcHgTh3ren7+o6qm3lDBHeyslORbE48nhEch5MwT5Q8nIEJf8Md1RidM/iWH
 1o7w+gaoPwmhYsybBc+HhNp2l0LEOj9odH0yCDXTMm3kwa/yidX4pjv0/cDxPVYkfY7k
 gfJRlpqXSYkF+BlTE2HgEVCFNAnCiayfI1g80r0MDX5RzRGQE51fZOe6SMRayaulDipL
 B3l6Ca+OJNUBYzHu8J84M4ZjchfmC7Csf2Jfk6VuhAcIUfAKdN8BRkXbrMIwv5/et68K
 ij9ZIBi5sG0R+ccB3y7H9DHOxLCWfjJ1in2iQAFNLrpTkAhTSYfcJmjAu9t6nKfPN6Jr
 nDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j0LHszZ06ydUWsHWSBiBJiyy+zVHgOm4jnvb8gHVHMM=;
 b=ioXXRj7i/Cy+9+Z2vnPXWSw/pOuFiX17SWk/wcbFIITE9/6XzyUWYPNGmB84jLyVdB
 aL/TadlgvwU8YJQexuyfEdPsrHq5JByJVG0TbOG7mTnX5EWG/ZtkTRmErbyHSKXES8aL
 icLtectBYUuvwKz2f7CSP4KaH3E0sAiIvwXzNbVWmvEc2ZxruCZSrcZ8mJAe1nzNDS+8
 HS4p/vqSEjvpZxhmf5DBasdbHkr+ju/dN9pk3s/kKKab1fZbsNM6qZB5oI+w944RfHIg
 7LiZxOUDpqiGEnRxco9Ws1sZ1Kdjqnn2xvZtEOYBHae/FX0PRjxpPo8Q67KDuBVNwyb1
 qgmg==
X-Gm-Message-State: APjAAAXhM3LKiq7wkMKn5cv6URYztFJxevkGHXn4j0KmHdTtdmktCLpk
 zNWR2O/24uh3LizV0lN/UUs=
X-Google-Smtp-Source: APXvYqxdlO8sb27pw1jKTb0T6g/S++ganD951Y9ouO45N2CXdOTMBdH7uFY9vPmo74ZGrnaEqwEcOw==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr7481119wmb.85.1554465084799; 
 Fri, 05 Apr 2019 04:51:24 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:24 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] ASoC: pcm030-audio-fabric: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:08 +0300
Message-Id: <20190405115010.28838-19-andradanciu1997@gmail.com>
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
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index e339f36cea95..a7fe4ad25c52 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -1,14 +1,10 @@
-/*
- * Phytec pcm030 driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Phytec pcm030 driver for the PSC of the Freescale MPC52xx
+// configured as AC97 interface
+//
+// Copyright 2008 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.11.0

