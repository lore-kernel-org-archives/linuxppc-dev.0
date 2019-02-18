Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB97C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:25:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F902176F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="lPdVLPON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F902176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JNQ4qHzzDqJX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:25:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="lPdVLPON"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FR6HJPzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:52 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id b3so13960718ede.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
 b=lPdVLPONMX15tVFEdOGTWdO0qWE/4jq/BAze0ALMLuA0nMhYdTscqDSDouBdQJMKI+
 9P9j1Oo5wGvSlAFqwJ5MbsxrTSd68gxajlZug9ZW4tzsNll+n461GjbggeOeqUQpgDm7
 W1pyYQRMbpuwsNn1TXoxIgHxqzMBLkEm6z/Mm2OFJDHKy3mdBVweK2p66YcDrrpeiyKy
 popuvplA8CMeHuToUOieTP7qkuHWUthsRGN5rVdQwprYyfywzPhUboAT3lTaCfKDFUXD
 GZCmTGPgJsVS9ZBLdp8t6SAGMuf9SNrpjtxDkSgWKiN8DRRDgz3mzZ/37doMnbxznzr/
 OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
 b=emaeQmX8nFBnwANMPNezcdW635BXL0zu7aGrzpOCnxfLxKKxr5pr9LzyrghE4RbMa+
 /rmxYkWTgjMqRkRWiReGCoSIYa8IAPbblfqt2Bsm8ezV8U5e6cWZbk6ZCnQsLyZWK6tt
 B/1chyStfISWRWWx6flaVK/PqV9fh98S6BenL6bWqMV89gtMBGTl0AokX5mRQ+UEWH37
 VfEecBLMJruuyQ5wU8UiQ1ioB6RZvlh5GniZC1WumusUv80hMKpvN+QvN9y9GGdb6lts
 V5GGaH9RYBkSDxzF1mIyJIqBm9N7a+MFWnuYSyzk80UuAzkwT0b6+zR/C14zUCfNpBGZ
 phNA==
X-Gm-Message-State: AHQUAuYR8SylMDnYRn0xGz1ItuksvrLlKoR3YzZBOOrow53dwxcjNocQ
 5/mwqL+aNJurcd3zmmBg346/6g==
X-Google-Smtp-Source: AHgI3IZ8OLgKjAeX/g4O2478yycvuHIzPgfc0uD5abEOkLT1aY3Iky8/UzyD7nuf/AReqmoOjyDzEw==
X-Received: by 2002:a17:906:791:: with SMTP id
 l17mr13001446ejc.1.1550498630266; 
 Mon, 18 Feb 2019 06:03:50 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:49 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header for
 FlexTimer #defines
Date: Mon, 18 Feb 2019 15:03:16 +0100
Message-Id: <20190218140321.19166-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-Mailman-Approved-At: Tue, 19 Feb 2019 09:22:41 +1100
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

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
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
2.17.1

