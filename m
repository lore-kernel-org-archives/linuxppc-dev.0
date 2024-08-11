Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A64C52D7B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Aug 2024 15:36:02 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zEkJ75tb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WhhZ90QJpz2xMQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Aug 2024 01:36:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zEkJ75tb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WhhYN1Zgwz2xFq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2024 01:35:17 +1000 (AEST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so34069871fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Aug 2024 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723390512; x=1723995312; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h512tKUzrukolR3pPpaZsPrCSEQtmis2nYDZ65tFXrc=;
        b=zEkJ75tbY+OvnrkOWwOjtWpSYI2d04dthBB6T85rABeG26avwduic6vDvYKdB1zKiy
         15LP7tw8VCJbIUMLARR7xrRB+RBtX3mUSO62HbV1/W6tbhejMphQ6rxs+KVGllmiLDkw
         du8mhegrSDOximCk/qFEXPEFx7b6oz5XJWwZRoTNuqDMalacuSg4XHsFz9UZ82wGMByE
         OodUsIUrt6zeoATkUL4y/MXX4nvWtOLEyDP9zSwlIrZFtBA9s1a/B7bgDElMAPZO0bF/
         flAxBnIRQPYLsYzh+9mxcOlHIstM+dCX4xhUqI2LW62asITTC/RqN2hANhGAGoy6L+Dw
         XZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723390512; x=1723995312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h512tKUzrukolR3pPpaZsPrCSEQtmis2nYDZ65tFXrc=;
        b=I7A4h3+JmCnCs0hylK0/fi72pC9BerIHtTldpDunEPxQyMNzovPI6f1v44rPl+Sqdq
         xbCXGY8IWpK8dnUblHmB20DILqOnVGyTdlEBLgel9kDctRnZ2uCjXbsASuMck1sqOQIM
         /wbo8ETEscYE8w4nG4nHqhjBnG3lSCxyIrvs8hiOORE+r1THHHQbcxdBaFQA2lBA51z5
         w2F7LR7G2LJX1kHjlEXLTYnwwUbZvgQAn8TvrZjd28KqMSbdJKmcs2LtVqjue2AxqEjp
         qPd0WLYjOe1uEXvfCCj4QDRpF6cVl6JtRU+DWv60gL+OecylJ9n6kNtX4nSDNpWQzasi
         14FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSfgAnyfJpjfaXFgCWRXmWYd3BtBdpvc/oIOhHa4vBlCaS+SAgK7h9gRUUassOEBjWKYGQIlRjhsg+bcC8cdgFvHqD0jIGSo+QhIVNbA==
X-Gm-Message-State: AOJu0YyeYsllQxCErHAS8E547Jm0dsDhavfdPNUSc0XxUMdnAhHSmmXg
	Q3LYkymqQLgUpF3K7o0GO5HEN9HtZSZNMVXtXHP7PN8l9eLd8mcO4BIT2OD7btE=
X-Google-Smtp-Source: AGHT+IElBSdZkuVW6lgNALLxjJCeoQbC1iMNNU5r3lu53hIis8YE+kgaeavVnIQrSshX/1V7GzgJ9Q==
X-Received: by 2002:a2e:611:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2f1a6d3201amr44316581fa.32.1723390511583;
        Sun, 11 Aug 2024 08:35:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d69esm158276625e9.5.2024.08.11.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:35:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fsl: fsl,rcpm: fix unevaluated fsl,rcpm-wakeup property
Date: Sun, 11 Aug 2024 17:35:07 +0200
Message-ID: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Drop the RCPM consumer example from the binding (LPUART device node),
because:
1. Using phandles is typical syntax, thus explaining it is not needed in
   the provider binding,
2. It has 'fsl,rcpm-wakeup' property which is not allowed by LPUART
   binding so it causes dt_binding_check warning:

   fsl,rcpm.example.dtb: serial@2950000: Unevaluated properties are not allowed ('fsl,rcpm-wakeup' was unexpected)
     from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#

Alternatively, this property could be added to LPUART binding
(fsl-lpuart.yaml), but it looks like none of in-tree DTS use it.

Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/fsl/fsl,rcpm.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
index a7db0aad2b25..03d71ab930d7 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
@@ -80,17 +80,8 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    rcpm: global-utilities@e2000 {
+    global-utilities@e2000 {
           compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
           reg = <0xe2000 0x1000>;
           #fsl,rcpm-wakeup-cells = <2>;
     };
-
-    serial@2950000 {
-         compatible = "fsl,ls1021a-lpuart";
-         reg = <0x2950000 0x1000>;
-         interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-         clocks = <&sysclk>;
-         clock-names = "ipg";
-         fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
-    };
-- 
2.43.0

