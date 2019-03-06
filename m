Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A730C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:19:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D3A20661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="jQJjtG85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D3A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DrrN1DzdzDq5b
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:19:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="jQJjtG85"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhK4rD7zDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:33 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id p27so9987477edc.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eb8QqYRrz4udMhES1PQQVcFV8QXyv6ZjH+to8xVEkfQ=;
 b=jQJjtG85mLXrsJnvSxav5RIgquH5GW9mfXb8hLBzuRXca455TiuI7Y/Nr3GeOos5Ik
 ECEtC+SqM4DuZ3Or45muV3FFQIe87uNu7VI2U8s3b35xxh7jCtMuifd0yvtxvDlCFWtA
 xeh7SF39xYl/UIq6C3c0MYtJdvr47+xzywI6fS5GQl8JgY1EGOJOHWeopNUEMOLAFjgL
 IznuVIOelkZVXy9zQSQNr0fjR/gRghG/0bWHzoYRCBcwslzh2ZKARiWxyHHDikJhHN/0
 BVVqz7Huonn6ProZBX5t6Y5W99dCDhwN4doI8SZLIs1mchAlpfHWAp5f+L6HizCNBx6u
 PNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eb8QqYRrz4udMhES1PQQVcFV8QXyv6ZjH+to8xVEkfQ=;
 b=H8nBRZhpa+8r1VLl/w3Qd4yf0PbeVLPZDO+L1kGjR8kDJjA0aV8gFz7a8oum59zk0Y
 r77Jz7cnqA9qXU1PZu0O70jBSQ1N7uOmAyYdlV5pni/Qd5yv43lbVzhtkwQkPGYE3uBN
 OiOwxkKupk4COBOy/12Va9/WWMfpmYr+0jQxjtXfhRfeQQ2nowp5kiMQOEyNMoZtAEGB
 w1zb+Nn6RYrght9ymAmDYKlX2bad8BPyJXYRk2MsAt5V6cQJmKOyWTUNTaxDWQ+f3iJC
 68ASyIe45c5Feb7Yd4zRJkZTIF/w88S5gt7HJezGi5v6WN0Cyk9ZouPuNSbqx8gFwVOv
 WsFg==
X-Gm-Message-State: APjAAAVuAjVH9MF8GJ42id/87mLshn918TiMmcAMImxjFA2uq1k25uZ7
 oNjAlnNDDjshkDpHDDfjQAYV0A==
X-Google-Smtp-Source: APXvYqy+UBtAM38g9GKS03KWMHt12mMimEbDT3GdfxQSX/lJLAovXdY1Wl+OiNa9aZbCQqM2Es1/3g==
X-Received: by 2002:a05:6402:184f:: with SMTP id
 v15mr23541935edy.133.1551870750172; 
 Wed, 06 Mar 2019 03:12:30 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:29 -0800 (PST)
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
Subject: [PATCH v2 2/7] drivers/pwm: pwm-fsl-ftm: use common header for
 FlexTimer #defines
Date: Wed,  6 Mar 2019 12:12:03 +0100
Message-Id: <20190306111208.7454-3-patrick.havelange@essensium.com>
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

This also fixes the wrong value for the previously defined
FTM_MODE_INIT macro (it was not used).

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 drivers/pwm/pwm-fsl-ftm.c | 44 +--------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 883378d055c6..f21ea1b97116 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -22,51 +22,9 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_MASK_SHIFT	3
-#define FTM_SC_CLK_MASK	(3 << FTM_SC_CLK_MASK_SHIFT)
 #define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_MASK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-
-#define FTM_CSC_BASE	0x0C
-#define FTM_CSC_MSB	BIT(5)
-#define FTM_CSC_MSA	BIT(4)
-#define FTM_CSC_ELSB	BIT(3)
-#define FTM_CSC_ELSA	BIT(2)
-#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
-
-#define FTM_CV_BASE	0x10
-#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
-
-#define FTM_CNTIN	0x4C
-#define FTM_STATUS	0x50
-
-#define FTM_MODE	0x54
-#define FTM_MODE_FTMEN	BIT(0)
-#define FTM_MODE_INIT	BIT(2)
-#define FTM_MODE_PWMSYNC	BIT(3)
-
-#define FTM_SYNC	0x58
-#define FTM_OUTINIT	0x5C
-#define FTM_OUTMASK	0x60
-#define FTM_COMBINE	0x64
-#define FTM_DEADTIME	0x68
-#define FTM_EXTTRIG	0x6C
-#define FTM_POL		0x70
-#define FTM_FMS		0x74
-#define FTM_FILTER	0x78
-#define FTM_FLTCTRL	0x7C
-#define FTM_QDCTRL	0x80
-#define FTM_CONF	0x84
-#define FTM_FLTPOL	0x88
-#define FTM_SYNCONF	0x8C
-#define FTM_INVCTRL	0x90
-#define FTM_SWOCTRL	0x94
-#define FTM_PWMLOAD	0x98
 
 enum fsl_pwm_clk {
 	FSL_PWM_CLK_SYS,
-- 
2.19.1

