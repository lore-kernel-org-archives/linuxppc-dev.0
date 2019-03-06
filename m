Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE1C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:21:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F85220661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="guHZcbpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F85220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Drth3926zDqD1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="guHZcbpB"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhL4TsSzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:34 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id j89so9990822edb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cDSuoyKdNV1HV5DOgGi6pj2N/BJT3JWfpiGnrduNvUU=;
 b=guHZcbpBM7nvUcaZ6yVNVW194npw7ZDkaCs6IDJ/YAGhiSft9/UWwaATplFk/Y4Hd3
 HzYmIYIFBtjWG5uQVqJnl5fA+FH1ft3rBfGfonIraRKRjLPS0b59lUftY0G234rmRPsS
 8EfdQtHuSGKEi9SGFEHCekmLSrEaoOVtN9aai5C6VLjLolPid1GfIdXZgfpk7flXPQ7m
 W2KyD9Mdfji0CuW3VD9R4KTc+8BfIUcpSz6412Ez2P00vw4CUce94ZzCt02NtwpRLOTf
 AtBsPfLsCzOEod6NYuFJi4rGd2sHbSdqUHiAsSsrb7BXb+ZDTvSSXZeao3IdfCyncFDb
 KkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cDSuoyKdNV1HV5DOgGi6pj2N/BJT3JWfpiGnrduNvUU=;
 b=FAZ2CVO5z4m1kE0vDeVFMGKA3LgJ4mYTBCngYHAaQJae44//ZYUXDObi3xckICbyxL
 PtQw8Au/jB00SEzESfNreiReJRQauMxQUTYITU70Fc3xhMrKdonkdsbsuSAv2Xpr39BU
 e6gToCGx2WHVxSAOTiJQYQHsURs71tV15imHKeNVU8griGzYxA3atAup9I1/4gq/kA8S
 6jBvytqGZrJe6pm9/KI0dWeAmQIze62BZ3D6EUQ2VJwMqfaU626zPP7KFs2sTZ49paxN
 OqeOI0L88nAtrvs0O5qRynGqbj0qQQwzOciY4WZe4dnCZfYciSOgz8aunZ13KB/TCCWS
 IUGg==
X-Gm-Message-State: APjAAAWw5WeSQkDfEUiib3l9j67nwqcDnMPMdR08Ozm0jhFlbrpH3xOm
 spXtNFZZ2j/0eWXW72W+pkFW2w==
X-Google-Smtp-Source: APXvYqxy3t4cZ+G/kwi2CriFtp5sfmhj9QiM++r4mVpAGkRt16u6ZgmHIwrc9WwxsbWYeGbi/hInpg==
X-Received: by 2002:a05:6402:1490:: with SMTP id
 e16mr22862133edv.201.1551870751292; 
 Wed, 06 Mar 2019 03:12:31 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:30 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 3/7] drivers/clocksource: timer-fsl-ftm: use common header
 for FlexTimer #defines
Date: Wed,  6 Mar 2019 12:12:04 +0100
Message-Id: <20190306111208.7454-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
this file.
Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.19.1

