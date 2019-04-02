Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E5FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:56:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86CD20833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWfpYMa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86CD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKkv4hy6zDqHH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:56:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tWfpYMa9"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKBp3DQWzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:32:34 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id j26so6025126pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K6TR0MKKqFzv/JFHfNJSn6dvEeDvf9PGgMl6oDHsxv8=;
 b=tWfpYMa96jMsAtI81uTIs8XCZhfcLaS9GLo3Dd7VzEK6cFQ/WIuOeMD0Nkb2AT+Oyr
 3itfZf9n5FTWIsKsP8SDdbhoMElcO8dxM23B8Fu2bJvUXGqzpSgq0+A64JOP1gxyUalV
 5s2VuiyIDl+wusnIn5wMUfuEKyWs33YFC2UoREMWi1xwRVcXlgSr5jfM5lN/WJG14ukc
 dHGeuSTjZwpGnK5vfWlr0XHy936RKfCewLVP4MLil/9Ksbe4JtK9Kits9FFXZS2V9vZn
 SsSQ4XwTQbna90UmjOiXxdUwahdDmtxjbYS411OCZINncA1cIS4jgHUJJWxYF9dygxyg
 6y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K6TR0MKKqFzv/JFHfNJSn6dvEeDvf9PGgMl6oDHsxv8=;
 b=tTzHjWKBXrVZMs9sZhPPer+atICjTMzhZrVwQzG7pNVJf4q6vjyL8CPl5eETEwMP6c
 6heetugKTokW9LnMECN13tQiIKqpA0mW/pWW0ob77Pa4wnvEnxpXBNGQrePqAx+aV2zJ
 TY+X1u/i9gEGee57agwa+LwZZ9Oo2BAfaSthPtG1Yr3vN+lY7VyN6fsWcyBh7ujiOBtT
 aJEeuAtLxdupNGxtkhbw6r2LFtCnIWRA4ZeeT4buvN9nPUVfSCQapgjqk1sB9egnGHbW
 /SNHHzcmDq7r1SkSAtDn6nfo2fpja9Z/GboHJ0kSV/ho8IiXyzvFjbCcSCqMh3tcIu3m
 PM9w==
X-Gm-Message-State: APjAAAU7DozDS4Qp5Wev2VWLdyLhMG1p7YQmRdlxsiQC6I2frzp7oaij
 H4jmaAVPykzBYdjyVqJVeJE=
X-Google-Smtp-Source: APXvYqxUCf1DUO7AHQFTZnrD2AGP+LDmUH4BvwkVqG3BeFLDf7eDaNAqWzFjlu69dzeioMteXtkqHg==
X-Received: by 2002:a63:e14e:: with SMTP id h14mr63716873pgk.184.1554186752567; 
 Mon, 01 Apr 2019 23:32:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:32:32 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 14/18] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
Date: Tue,  2 Apr 2019 15:30:49 +0900
Message-Id: <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 William Breathitt Gray <vilhelm.gray@gmail.com>, robh+dt@kernel.org,
 tglx@linutronix.de, fabrice.gasnier@st.com, esben@haabendal.dk,
 shawnguo@kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 knaack.h@gmx.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Patrick Havelange <patrick.havelange@essensium.com>

Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
this file.
Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
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
2.21.0

