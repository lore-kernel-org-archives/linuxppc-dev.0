Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D478C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B1C206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 11:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca6nLxHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B1C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJHH51ltzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ca6nLxHC"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ6T2swpzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:50:41 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id g3so7606456wrx.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rQj8PuuZentu2XrU7HxdJRdnsCGuNjbn3VjTmF5ty2Q=;
 b=ca6nLxHCGKyID5DoD5tSyX7baDMUYrCaBg/hUAalVUUz24hicnDyEPvUjHa8Hf3HnW
 hhGPZKgDQcQCUzkC8ic8k2Drdm0d9JkmsptyJ+WviQMMZZVC1O5+Nf9y1C6fpDTgEtUN
 8djaRsqbP+iGseohY/E7rR1O8bUNJ+bk7EHRgvP3NUOJGJJkoVkeQgIBz9KuhWx6o4UG
 BXWzjtmltNN1uYnwG4Fa7eCuZPU2FBXGvjn6JdDSkfcnt/LGag3NpZ0IpwyoGFOhx7c0
 c3JrxlqaKBtFubxYHvKhY44wvxKybf3egpSzRX6Ts00GvMWgqCPFDg6D2S9h7xrqi5Ju
 OIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rQj8PuuZentu2XrU7HxdJRdnsCGuNjbn3VjTmF5ty2Q=;
 b=TPr6DY9GAW40g6BA1T58xzY7lvl63t1NQURXcUNQ2mGgJKNK6Dsy3XJvXJMf20CDlT
 M/C/TO51sEVeRep68b2xgPATqElPaDz+SnFUEAG7Q1WIgEdYXZXX6cg1zm1A/3FeWD5F
 vE0vizNaKsAORUiKw3fH+F5OKedKMrZ4hpF5TZPQZxWh2ES+wZKGi8ZyvYjbO18pZvAG
 pAA6VDZYr9ahhPIc5JNcjxG8I41pucVcqACJ4yKvvQmiDfRejQCCt73pV8RCMgyAD0MX
 biyDi7oPxb1GzINT8DRRDrVS60bcVJVVjOoMOEHA/vPcOnj+5Dyv70mb5HpJChllu9Re
 f9Kw==
X-Gm-Message-State: APjAAAVGyVFcVXUuetX6d447XGxY+7kmvMpP0JdVIJN2ykdMiz/G9Dif
 GlfXfl2Fr2TTQ01UfaNMKd4=
X-Google-Smtp-Source: APXvYqweXrqvYqw1SXr6ywgBo8ZPVYoZgCyzZk0sYZHg5vmlGQ70RzHCUjsy6XDTTeJVXAz2uEQMoQ==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr8407553wro.180.1554465038256; 
 Fri, 05 Apr 2019 04:50:38 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:50:37 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:52 +0300
Message-Id: <20190405115010.28838-3-andradanciu1997@gmail.com>
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
 sound/soc/fsl/efika-audio-fabric.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index 667f4215dfc0..3e832902fc99 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -1,14 +1,9 @@
-/*
- * Efika driver for the PSC of the Freescale MPC52xx
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
+// Efika driver for the PSC of the Freescale MPC52xx
+// configured as AC97 interface
+//
+// Copyright 2008 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.11.0

