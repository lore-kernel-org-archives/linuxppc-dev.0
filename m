Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11115C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8069820883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILDqsSxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8069820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKMY4JMgzDqL9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:40:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ILDqsSxy"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK8v3gn0zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:30:55 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id w23so2781957ply.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aNedWm3Hz3KKze8HS2QeLEYl8kQ1q+G71sLG9i3ZRic=;
 b=ILDqsSxyB02bx9BVIh9Q+V6ahH1FtKycYJdcDWYBcuhkZuyWTkKwWMHegUoTHYL083
 KhpHR1vYrBzG5hCwiVWzTKsKIek2jmlfYKPLhIJL63gAa3llh1jtWrJdAiuDErRdw9d+
 ntgurJRKRgu+i5hlA+uVWyLiS+lzl9EB2jvvsWyENnvEGH6Ya7YxQT9bpKVmq5rY5BIP
 sm4+OX4Lu0zQ+bJNfJ5Y5NjOtG3QrBwlRk6xxkx56Kn56FfRLeINM7yWEGjreqUDSxJi
 Ye3nXJuvtLWkE3dggxILMsil8LjKGgK4g2OFj1aZRnJcj0MxvjHuZXgBbrOtiuBLaV+u
 G++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aNedWm3Hz3KKze8HS2QeLEYl8kQ1q+G71sLG9i3ZRic=;
 b=iD7Liyba7W5ux0tijwWkA7Lu4nyjWrULupdQc1XZnE2r6H8Gp2Z7SNzEwKGeJEKvbC
 yg7oR6HeRh3YbW9WVvYfHvwBAz8559ri8Mk0EpOs7Gc+PKHzY1H0CfeF5dfwe88QZnfj
 5cm8/7e7vJdUas1xnMQ99pL+OOUOprBsmwUHQNvxRosnUR8/neTzxXi690qt/dxsv2fm
 IbaPt6QgxcEo+1ELH/25YPSmYh5iRZqrbcNnHiktmBs32XyEV0vXq+g8NqWmZaaBeq4F
 vDPlX89eHYCsUsMJXXjjm+SyX5YHiSEXEC6ldoWVXKJDi1KLzUUWrFrW9cCT2lCX5Pcj
 VUgQ==
X-Gm-Message-State: APjAAAVzW1aOEaNrcKUGRoJHPBJDf3GnezdKxdEfGt/wT7fVktaD3Lh7
 XYp2vZdeoKjzoWd8p2vPyaU=
X-Google-Smtp-Source: APXvYqxpx5VONZZMdLqSroCuHbE6BH9Rd3clDwrowABSUBtP+YUH+S3IPSsfGnO/djWOf39TRGfdqQ==
X-Received: by 2002:a17:902:2ba7:: with SMTP id
 l36mr69293700plb.237.1554186652921; 
 Mon, 01 Apr 2019 23:30:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:30:52 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 04/18] iio: 104-quad-8: Update license boilerplate
Date: Tue,  2 Apr 2019 15:30:39 +0900
Message-Id: <a2c4ce0bc824738e682ca544f937151da11786de.1554184734.git.vilhelm.gray@gmail.com>
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

This patch simplifies the boilerplate license text by making use of a
SPDX license identifier line.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7735..72b6352e09f0 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
-- 
2.21.0

