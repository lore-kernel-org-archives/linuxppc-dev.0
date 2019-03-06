Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE322C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:17:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398BC20661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="gNltG2/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398BC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Drp51cLgzDqCc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:17:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="gNltG2/v"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhJ3PFzzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:32 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id m35so9981923ede.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UDGe8T7uTF1fS0LV360+rebuvgO6XlOWuD/srOZz6kA=;
 b=gNltG2/vMtp0zBc3u0alXu4S7dYzB3TXOypx/r6LxjqJJJiN4Zy5NdS9fOu+ogGv9/
 BKmzb0wR5oz2SEELAoJ++4XtWmXjdS96hY4iMAdhNE2FBWSGATmWcIovlZU6EeV7HKNz
 OEyKN0Bq+O2fW4dc63c4YMt2Akw1la+XrcoiX7X0XkLO8ybFH0fghOfyRNQTGL3BgYAC
 Rq8DIAxYP2c61dpatuPyaTyBuuup19Doi82hA+uC0ygQdiqgf2thoOcknujXqFxDKFDA
 vb4FZ2mG146hg65uqzLoRk4rYeO6HABhk/+SQmqE/otWVEXPCOM6Zi8kPfas/ZqOXWke
 dVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UDGe8T7uTF1fS0LV360+rebuvgO6XlOWuD/srOZz6kA=;
 b=FnfTMnzGyQKILAcHfoxYOmnqunowD4VvyXaez7g1KUKLf7hwhsEALkVXHYnhVPavTL
 yp4MvSi7tdUvlr11TaLylejt2HekGw8HQ+51yUnGPTI9aQ5QXjR00B1Mtz987f8fssB/
 /Qo7GM42+MGBnWQTa2DCICFPX5vi93xWBTxp5GDTBcf6WuumCZbW0vWPGAz/J4vdyhuz
 3O/jLDPfVXaN13Too5ThgAZmkAN2K4JWUSdZJlOj8Hl7/II0Z46pxJHdBGMajSWf3S6q
 bY1b0SWpmMEPhNXS6NHKhypDHktsHVNwMGeHsI2+/r2OeQcyRkSrLSD/5WD8mAEDopVu
 Cqrg==
X-Gm-Message-State: APjAAAUS4w/jZ0TPZ1g6UuXDOWT+wjvZ0rWXlH8WUR2Vu89xGc0YWZuP
 gkR/fxAbxuqe4vqonnX/ZLuRKg==
X-Google-Smtp-Source: APXvYqwYqCMsKkYQWZol5oxl8MNudtVNOddwqzr50VpN9hqC+6iKrexdzDbUUBdgMwFX4xiCo6Itqg==
X-Received: by 2002:a50:94d6:: with SMTP id t22mr23584689eda.232.1551870749143; 
 Wed, 06 Mar 2019 03:12:29 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:28 -0800 (PST)
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
Subject: [PATCH v2 1/7] include/fsl: add common FlexTimer #defines in a
 separate header.
Date: Wed,  6 Mar 2019 12:12:02 +0100
Message-Id: <20190306111208.7454-2-patrick.havelange@essensium.com>
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

Several files are/will be using the same #defines to use the Flextimer
module. Regroup them in a common file.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - Commit message
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
2.19.1

