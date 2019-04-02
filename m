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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC04C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:50:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40DD20833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCU4LuYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40DD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKbX3hx1zDqNm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:50:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCU4LuYE"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKB20shQzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:31:54 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so3851885plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e5lI6Cm8DXQohzRLyyRrBDvhGKUFb9mSBAgeXH8Sbbw=;
 b=PCU4LuYE1RQ8Nd35Pecg9oBVn2EQCZLJD6UIdwPRo/EiPdfnjGbRGhHB2yblcUMytF
 zJOAvZ4ubqtfTb9MoJX8WsWCUaKOAhmPdD6ZLduhK0O8N7GYSdQ48BtcnaZb2SVBGpbZ
 dPijpKmdL1+9Tx7KnC9AhQ+AzBOc8QyKT6K18UWEHIgK19NVCuAXvYGzPWWI4b+i/uwr
 IKdR1Z4nQR2PtsZJ022W9aV0SyVd5zXA2NKApxPTI5KCsLdaI4PkNgTe0SJcdhidcf5o
 Jetzj30fCnrF9ryGuzul3CUqHZxr4K0S63Ki8FvL9AdGyiFzpjqu3qjz7iUS8zzYQLjQ
 6jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e5lI6Cm8DXQohzRLyyRrBDvhGKUFb9mSBAgeXH8Sbbw=;
 b=ccUZH7DJsBxlRopAt6VWiQFw+yhLFjYr8hZvaGoF6g6y7ksONVX7NEEmftFqTYUBXG
 nA3akcu+fUxX7GIOMUklSlD9kFlGbWU4DqiYsMQ0EWDelH+GmDEzYEp6lmTzGPc1koMa
 N+9XtLt1BhD7ChAjkVAE2q3Vn4DX1vdKaCPKI5+VD2rV1os6Sg9YErB9a4rAXTeczYk/
 Zsj1MtxbDNu5sVkXgglVu4D8Cx57pk/g/oRpgcYjsx/SmndSHqcfwbV/ZZpL92ANcuGb
 wM9IjQ6fAjx6cT01btxbdh+Jgb+3rAY4OAVXXiXYPeGDHoqkEUNRaEFjJfo7mhGOAxjn
 iuyw==
X-Gm-Message-State: APjAAAW+L575j1GFIp7qT9lZDREdm7VZdnDVuZwREq1IL0jUifcPmCz1
 j85w+ND2LpcVDbhRIIT8duY=
X-Google-Smtp-Source: APXvYqwYR6LdnL4uy6cbUMrLOBM+U76iG5CPQ/aGeUxQ5Zjp147mg64//+odVU3qjvqueQET6xOLow==
X-Received: by 2002:a17:902:b706:: with SMTP id
 d6mr32862396pls.250.1554186712458; 
 Mon, 01 Apr 2019 23:31:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:31:51 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 10/18] dt-bindings: counter: Adjust dt-bindings for STM32
 lptimer move
Date: Tue,  2 Apr 2019 15:30:45 +0900
Message-Id: <2aaee83992bcc1d29080ef6921ae6ad56856389f.1554184734.git.vilhelm.gray@gmail.com>
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
 thierry.reding@gmail.com, pmeerw@pmeerw.net, Rob Herring <robh@kernel.org>,
 lars@metafoo.de, daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 david@lechnology.com, William Breathitt Gray <vilhelm.gray@gmail.com>,
 robh+dt@kernel.org, tglx@linutronix.de, fabrice.gasnier@st.com,
 esben@haabendal.dk, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, knaack.h@gmx.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Fabrice Gasnier <fabrice.gasnier@st.com>

The STM32 LP Timer counter driver now resides under the Counter
subsystem. This patch adjusts dt-bindings to account for the STM32
lptimer driver move.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
-- 
2.21.0

