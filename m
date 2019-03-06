Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA448C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:23:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3402020661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="ohMKKSde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3402020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DrwR2V6zzDqDP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="ohMKKSde"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhL74ZWzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:34 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id j89so9990869edb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ou+uYUfe21KQvShwFfjSgk1lTlPUbyeUE0c8BFU5pzA=;
 b=ohMKKSdeSm8YddG5u+fHRRu+AsNlEbFGI7ONNyiR6e+siGjEpc8D8UP4Leq3JYTvkX
 PkPOf4P+oJqBWTlkDXnAONiSnP3/t6muPkybKtqOsHzSw14gP33djGLKMLWZoEAaXKJZ
 y1tJhqCERXBU4Bhf8JtLBbk4nZS0gT0715vQ84V/qVIX8aQH9x1hjL8zlPlOE6H6+VKb
 PA4Hc2yaFHkvwyuTxuxmNckb94mxvv0n/BZGGK4YOMaOIS/TbUbq0d6LEUCzAZDNdXOE
 DmbPWnv0BtkO+QiVVSn04QkWA62rLQkBFkKcIiaiVfe5Vu/tXs4IlyBfIVnZwOtvxtjE
 EhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ou+uYUfe21KQvShwFfjSgk1lTlPUbyeUE0c8BFU5pzA=;
 b=l0kk14KmZ9/m9MSLmcpab414gw8e7/kz8PFuWtC/L6EomE8bSaqlC2RNM1w2Ly0NiE
 GSvX26MUmUvocmeM7tvXBOfHff760uksFs6WcYIFg2Drx5lZoBVTJn3mcW2m0tH6jdgK
 EjOO/1Nc/zpiZK1ObMKPwlIQjvh/zDek2SqNuuCltZL6zQxzLcuXN5/UPihOMxzf6S5m
 an7DqegvnW660MdlokNm6F2I2XnX254GyMUbDOcEbUIsocXWUcaoXoZ5kWMlhMuJhEdt
 WOYt8yo2NtrBp88+j0YKEG/8unHlNJSOjDF9C5Pwn0QShKpsk5JMponoZOb7boBYsyXp
 ketw==
X-Gm-Message-State: APjAAAXxJlIdw0Cqw+JzEdJdH7kP1UYQDQ+b6Scbn1R3dUrw3onTLwtp
 m9nHkGmkVBwOvfnXoBGZvGdHXA==
X-Google-Smtp-Source: APXvYqwCCv7csnNhvhQhNOkqqUxyDvM29KCOy6mdzZIMpqluneX2ZReFH8S6i7ABQ32vYSsw29sF1A==
X-Received: by 2002:a50:b4db:: with SMTP id x27mr23421357edd.90.1551870752427; 
 Wed, 06 Mar 2019 03:12:32 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:31 -0800 (PST)
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
Subject: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Date: Wed,  6 Mar 2019 12:12:05 +0100
Message-Id: <20190306111208.7454-5-patrick.havelange@essensium.com>
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

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.19.1

