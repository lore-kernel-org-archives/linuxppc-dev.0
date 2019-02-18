Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:27:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053852064C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="IsB2vKUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053852064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JQH5Y9PzDqJQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:27:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="IsB2vKUQ"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FR25YRzDq67
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:50 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id p27so6365480edc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=C7LfhrPnx4nAAVgxwo9NlyGkJiC6uZjQ0aP5k7jZulQ=;
 b=IsB2vKUQ0fFFZ3Si03pp+C3YnEwIGfiap8SKOQSLsqp4xuu3XfOVwg7fS4wRCKDkQE
 OLbC93ZPgfinbdENjBY13fGRfsVOXYmWZMIvCSNjAjwJ/sXxaUa5ojgt9KK1UuKQYO8h
 J79qQcugI6ovrMgtNAZEgOiapw8Y/bCxMzOhI3luA6lQt1ihP1n13m1SxJ1g3sNASLa8
 nsBt5b9wjpatlE8nuWNvOSCk+Yk6MQptaJ6/19HWYHgNZOYJDLjOAzmo2BDsVnCRx2nR
 y0XD07OFkIXEAJU15ujUJyhmbdp7FEDw9YapXo1H/XWzsEPNetMGdGgJmzijzH0lqEKK
 igpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=C7LfhrPnx4nAAVgxwo9NlyGkJiC6uZjQ0aP5k7jZulQ=;
 b=rfqlRiP/Y0oh7Gh5LCkr0w5bolmiQ+v4g7LGL4eDG8/Ecsy74kVuXpeP3DtDTTk2dc
 RTdw9muy5OWQJqgdt5knbHjjSOilysGpNaUHaHWALAvXs1pm3CPg7S4zQ8PZ09+HPiff
 Zu5MqSSTtNvCQWkUijL2y6k8Mn6YBtOa37ZH+PF0WAEt2/C2gcYVjl06H3019UwFcmJ+
 v1+RKnsAtaoA9ZBBZca7gm/28bXdsRfaCCqBc1sM1d9bG6Qdy0mT+LFNOHL2dyN7g4Ze
 u0Fla8vKkgUIfRNMjByQz8DpnFo70/WsGTzg8EDi45DWpl8Z3JrkpLeMiha88sXxwCLD
 zfdw==
X-Gm-Message-State: AHQUAuZzN0Lb1wAabn5Q/BlxOVuiuTPqABRIDBDdIlU9ABfL0cun4JBH
 gSkjxVfAauCYoLCWCZX9IfMIAQ==
X-Google-Smtp-Source: AHgI3Ia0x1ktlXNUOXQ9qmej4UWt8bjITH2AKcym466NvP3q2IEYPeYewvhp2d01vHGZ6OHrFmkucQ==
X-Received: by 2002:a17:906:381:: with SMTP id
 b1mr16659937eja.67.1550498627933; 
 Mon, 18 Feb 2019 06:03:47 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:47 -0800 (PST)
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
Subject: [PATCH 1/8] include/fsl: add common FlexTimer #defines in a separate
 header.
Date: Mon, 18 Feb 2019 15:03:14 +0100
Message-Id: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
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
 include/linux/fsl/ftm.h | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/fsl/ftm.h

diff --git a/include/linux/fsl/ftm.h b/include/linux/fsl/ftm.h
new file mode 100644
index 000000000000..d59011acf66c
--- /dev/null
+++ b/include/linux/fsl/ftm.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __FSL_FTM_H__
+#define __FSL_FTM_H__
+
+#define FTM_SC       0x0 /* Status And Control */
+#define FTM_CNT      0x4 /* Counter */
+#define FTM_MOD      0x8 /* Modulo */
+
+#define FTM_CNTIN    0x4C /* Counter Initial Value */
+#define FTM_STATUS   0x50 /* Capture And Compare Status */
+#define FTM_MODE     0x54 /* Features Mode Selection */
+#define FTM_SYNC     0x58 /* Synchronization */
+#define FTM_OUTINIT  0x5C /* Initial State For Channels Output */
+#define FTM_OUTMASK  0x60 /* Output Mask */
+#define FTM_COMBINE  0x64 /* Function For Linked Channels */
+#define FTM_DEADTIME 0x68 /* Deadtime Insertion Control */
+#define FTM_EXTTRIG  0x6C /* FTM External Trigger */
+#define FTM_POL      0x70 /* Channels Polarity */
+#define FTM_FMS      0x74 /* Fault Mode Status */
+#define FTM_FILTER   0x78 /* Input Capture Filter Control */
+#define FTM_FLTCTRL  0x7C /* Fault Control */
+#define FTM_QDCTRL   0x80 /* Quadrature Decoder Control And Status */
+#define FTM_CONF     0x84 /* Configuration */
+#define FTM_FLTPOL   0x88 /* FTM Fault Input Polarity */
+#define FTM_SYNCONF  0x8C /* Synchronization Configuration */
+#define FTM_INVCTRL  0x90 /* FTM Inverting Control */
+#define FTM_SWOCTRL  0x94 /* FTM Software Output Control */
+#define FTM_PWMLOAD  0x98 /* FTM PWM Load */
+
+#define FTM_SC_CLK_MASK_SHIFT	3
+#define FTM_SC_CLK_MASK		(3 << FTM_SC_CLK_MASK_SHIFT)
+#define FTM_SC_TOF		0x80
+#define FTM_SC_TOIE		0x40
+#define FTM_SC_CPWMS		0x20
+#define FTM_SC_CLKS		0x18
+#define FTM_SC_PS_1		0x0
+#define FTM_SC_PS_2		0x1
+#define FTM_SC_PS_4		0x2
+#define FTM_SC_PS_8		0x3
+#define FTM_SC_PS_16		0x4
+#define FTM_SC_PS_32		0x5
+#define FTM_SC_PS_64		0x6
+#define FTM_SC_PS_128		0x7
+#define FTM_SC_PS_MASK		0x7
+
+#define FTM_MODE_FAULTIE	0x80
+#define FTM_MODE_FAULTM		0x60
+#define FTM_MODE_CAPTEST	0x10
+#define FTM_MODE_PWMSYNC	0x8
+#define FTM_MODE_WPDIS		0x4
+#define FTM_MODE_INIT		0x2
+#define FTM_MODE_FTMEN		0x1
+
+/* NXP Errata: The PHAFLTREN and PHBFLTREN bits are tide to zero internally
+ * and these bits cannot be set. Flextimer cannot use Filter in
+ * Quadrature Decoder Mode.
+ * https://community.nxp.com/thread/467648#comment-1010319
+ */
+#define FTM_QDCTRL_PHAFLTREN	0x80
+#define FTM_QDCTRL_PHBFLTREN	0x40
+#define FTM_QDCTRL_PHAPOL	0x20
+#define FTM_QDCTRL_PHBPOL	0x10
+#define FTM_QDCTRL_QUADMODE	0x8
+#define FTM_QDCTRL_QUADDIR	0x4
+#define FTM_QDCTRL_TOFDIR	0x2
+#define FTM_QDCTRL_QUADEN	0x1
+
+#define FTM_FMS_FAULTF		0x80
+#define FTM_FMS_WPEN		0x40
+#define FTM_FMS_FAULTIN		0x10
+#define FTM_FMS_FAULTF3		0x8
+#define FTM_FMS_FAULTF2		0x4
+#define FTM_FMS_FAULTF1		0x2
+#define FTM_FMS_FAULTF0		0x1
+
+#define FTM_CSC_BASE		0xC
+#define FTM_CSC_MSB		0x20
+#define FTM_CSC_MSA		0x10
+#define FTM_CSC_ELSB		0x8
+#define FTM_CSC_ELSA		0x4
+#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
+
+#define FTM_CV_BASE		0x10
+#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
+
+#define FTM_PS_MAX		7
+
+#endif
-- 
2.17.1

