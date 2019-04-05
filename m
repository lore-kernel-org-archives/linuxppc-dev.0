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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:26:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA83218A6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDFmTs46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA83218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bJvD40Y3zDq6N
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:26:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDFmTs46"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJ7C4vl0zDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 22:51:19 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id z24so6899422wmi.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2x51jPIH0NpTAZwd31yHCUn90dvk+fsja0ZQlVXpmSo=;
 b=nDFmTs46L0+WI6A3YT9/47BbL7eFFMUPGOridJqHcPWw7SzJkXp+Lja6JlMdsrxceP
 sNR0NtVKOyTm52rxqvnvhuB2GxwevorkKoFFLwYvr0wOHB1E2IWNesH08sT9ZM7h4ivy
 ciQwK99X6VH3MsF8YoUZDBljHIEoJaGvFwiF5vvQeaz6kZefdBbZtgeQYQKJqSnmsR1+
 3VqeXSNpBoTASHm/VY51ktLNFJHKfN47RWD3F0VnnOhK3wMBgd0mJ3gFCkQlsGcbiLbx
 nonwov5GXgpeL9rj55uyKCmDZ/HcfhLspYSseGR7/NBLQNvnPtLt9LPn1xa7bm+B6yQF
 89Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2x51jPIH0NpTAZwd31yHCUn90dvk+fsja0ZQlVXpmSo=;
 b=o8y5RGpf8MnBjjaAWYp7/dcztzW97QfyqEhTAdJ0AXk9KV3g7z3OQfFdbRjjF14m5p
 Mkgt+3oWD8vt3RQfiUguSvsJ/a502uCQZAZ51n2OpT2DjaQ56fl0oUmSgvWNVhAuOfJ1
 kyL9vD/zvJPZx2cY/s/xKF0l6jDWUdZXMvFyxrZWOJ+T57TY9PlCrNz8bZGlSeSmMOdE
 gLfwJ8+cKAgAO7iSeqPkpAEWPZcZEwuywi/rE30ZoKmcV0ZEgOhuWixXz6uDMZxX5TbX
 zZiNGejcvBsL9RtOWz2WmpAL3TFXCcHqXQmoa6gwNhW+AbbX3PKvdECrJMkJXVvza0Yh
 pJxA==
X-Gm-Message-State: APjAAAUCn0WLhqroXNNybYypr5Buv7eioYN5rhpVPKsxGK7S9o8D2b1O
 O/ijOkdnLpzTnKtUvjFkKbU=
X-Google-Smtp-Source: APXvYqwUdMHMsHxcn6/slTQiQuYvpjaiOMopOrkv83+I9j98fnppMMtAfD9bfMu3zYD2K0jK4Yrh9g==
X-Received: by 2002:a1c:a00a:: with SMTP id j10mr8063071wme.15.1554465077155; 
 Fri, 05 Apr 2019 04:51:17 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
 by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2019 04:51:16 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] ASoC: mx27vis-aic32x4: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:05 +0300
Message-Id: <20190405115010.28838-16-andradanciu1997@gmail.com>
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
 sound/soc/fsl/mx27vis-aic32x4.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index d7ec3d20065c..37a4520aef62 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -1,25 +1,10 @@
-/*
- * mx27vis-aic32x4.c
- *
- * Copyright 2011 Vista Silicon S.L.
- *
- * Author: Javier Martin <javier.martin@vista-silicon.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// mx27vis-aic32x4.c
+//
+// Copyright 2011 Vista Silicon S.L.
+//
+// Author: Javier Martin <javier.martin@vista-silicon.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

