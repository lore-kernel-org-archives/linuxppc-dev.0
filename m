Return-Path: <SRS0=tcMx=SQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF95C10F13
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCE420850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2kwauP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j1fN6l45zDqL2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 05:19:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="E2kwauP9"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j1YG1MpmzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 05:15:14 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id r186so4582944wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IVWF5VbXq88Oe2XailmJT797hCzhKaf4Udl5bCUersw=;
 b=E2kwauP9kAv6Vek9iveRlBPfygNSsknEEmkxfwpoNpkp1USB3nYhRie3JcVP6mBEcU
 OvsC7buj8sI7kYXo9BEXOakenYHbfqh6FWNyy6NsKdu1cVMhIfa9gypEvuy19tpO8iV4
 2m0Zw+FVVadWO0rION1dJrwpHk4sLsSf/4BtHVpa15w5t+1WWTHS5/y8UIdih9pTxK7q
 vwfig9RJKrR9ur3xucSvMAmQJOIyxyvtYcviBytgn/mDiHfq5WsPewnH2xWoxR8Zjsze
 t3rUzbucj7QFRoThDY3I8fN+k8SDbFhyY5PffDPyqGZH+slLdW4ctPNOfmY0HWA+59AJ
 UsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IVWF5VbXq88Oe2XailmJT797hCzhKaf4Udl5bCUersw=;
 b=ZCGZBOPFsi1Or/PMBo4gVik6O36K2lz1TU6wVwsTm/G9cWxsCiXyeftdKVh/w93wIz
 7d5IZfn6x/yBWOfMtuDGbGlxYntvIOFR1iUvNFfm2bqzWZ3EWBFsVO4PzzcNvD0Ne6jC
 dsXSTHH9BcFRxHh03eQo5vykMa2NnPlq1GQGpQrwjmeV2Ju4j1zZw+xBYTcR43MooZLl
 eAmCFsRTWt4iT826szJcBD1HWsFj073601fk9Eoq8SuAbih2vKmisaUjyQ3F6G0tDMbg
 LTc9pg58U+EMNlFUQwuudRpcX9QWduRH9vQ4xYjNBtsT35xVJfPlzVRgJ7DwxsFYqL19
 cudg==
X-Gm-Message-State: APjAAAVZO8c6ZPr4z2M11FX83isfpCsppqbvL2Wfb58rMoGFpuuowgbC
 92e6xwYvI4k78HwK2ZJdCPY=
X-Google-Smtp-Source: APXvYqw9xtJOlYdm8kIIjs3GPTe1nPDZwu8LxNodAniOJpc5iVOjx7iA8wLMBdWjxLBImhYSqo6AHg==
X-Received: by 2002:a1c:a742:: with SMTP id q63mr18522874wme.133.1555269311048; 
 Sun, 14 Apr 2019 12:15:11 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
 by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Apr 2019 12:15:10 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: mpc5200_psc_i2s: Fix invalid license ID
Date: Sun, 14 Apr 2019 22:14:50 +0300
Message-Id: <20190414191450.18377-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414191450.18377-1-andradanciu1997@gmail.com>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
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
Cc: tglx@linutronix.de, daniel.baluta@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 864a8472c4412 ("ASoC: mpc5200_psc_i2s: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 6de97461ba25..9bc01f374b39 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC in I2S mode
 // ALSA SoC Digital Audio Interface (DAI) driver
-- 
2.11.0

