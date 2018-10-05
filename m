Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBDBC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBD0213A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBD0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcKh5kk7zF3br
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:33:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZS2YzszF3TY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:12 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so13350028otl.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7IXpfPQDP0ZoNfR+xycIt5dHNa3FBYx05kaWJs5b62w=;
 b=KNCNN+LUDXteGb24ALdn26wVrx7qYAZPcLCBXy5PGvOglw58C8ubGByRXtEej0Q5dF
 XIRfo21BOgNwrFBiKU5/8ldH+GlymKGlARN7APNuggrNm/wAJblwaw4QnjsQvKZHB0mS
 cOsXKpeLMDEdTU3sbhuawtGgFJA8EDNGIzuS7dPeBbDwN8KStL+owih0xbacXm2DMyHB
 BvzLMdAeVgE6W9ePnLxvMsGTzdfuzoU5jFeP4OmG7BU5eLJiX9vKidEwWPJQA2uJ2lUr
 MslXNCjkbOL3y0C4xzst7cg1GK/W/uUb3bhQXhKbxmElyClm/20M7yGNM1E9A13S2u5q
 wDsA==
X-Gm-Message-State: ABuFfoi5QSIpLyTAXrPWhw7mei8rINXJpNuHBwILyq1ebsV+mTtxS4DS
 ReJNhZYsSwGXpV20dLKzQQ==
X-Google-Smtp-Source: ACcGV62y84gF+WXQcXzmZFx2UcPi8oimIamA4EXCcSiLd+lxi6k7xEOfE25/6gSSthBDMBcLWQFz7A==
X-Received: by 2002:a9d:538c:: with SMTP id w12mr1623009otg.139.1538758750406; 
 Fri, 05 Oct 2018 09:59:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:09 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/36] dt-bindings: arm: Convert primecell binding to
 json-schema
Date: Fri,  5 Oct 2018 11:58:26 -0500
Message-Id: <20181005165848.3474-15-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ARM Primecell binding to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/primecell.txt     | 46 -------------------
 .../devicetree/bindings/arm/primecell.yaml    | 35 ++++++++++++++
 2 files changed, 35 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.yaml

diff --git a/Documentation/devicetree/bindings/arm/primecell.txt b/Documentation/devicetree/bindings/arm/primecell.txt
deleted file mode 100644
index 0df6acacfaea..000000000000
--- a/Documentation/devicetree/bindings/arm/primecell.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* ARM Primecell Peripherals
-
-ARM, Ltd. Primecell peripherals have a standard id register that can be used to
-identify the peripheral type, vendor, and revision. This value can be used for
-driver matching.
-
-Required properties:
-
-- compatible : should be a specific name for the peripheral and
-               "arm,primecell".  The specific name will match the ARM
-               engineering name for the logic block in the form: "arm,pl???"
-
-Optional properties:
-
-- arm,primecell-periphid : Value to override the h/w value with
-- clocks : From common clock binding. First clock is phandle to clock for apb
-	pclk. Additional clocks are optional and specific to those peripherals.
-- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
-- dmas : From common DMA binding. If present, refers to one or more dma channels.
-- dma-names : From common DMA binding, needs to match the 'dmas' property.
-              Devices with exactly one receive and transmit channel shall name
-              these "rx" and "tx", respectively.
-- pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
-- pinctrl-names : Names corresponding to the numbered pinctrl states
-- interrupts : one or more interrupt specifiers
-- interrupt-names : names corresponding to the interrupts properties
-
-Example:
-
-serial@fff36000 {
-	compatible = "arm,pl011", "arm,primecell";
-	arm,primecell-periphid = <0x00341011>;
-
-	clocks = <&pclk>;
-	clock-names = "apb_pclk";
-
-	dmas = <&dma-controller 4>, <&dma-controller 5>;
-	dma-names = "rx", "tx";	
-
-	pinctrl-0 = <&uart0_default_mux>, <&uart0_default_mode>;
-	pinctrl-1 = <&uart0_sleep_mode>;
-	pinctrl-names = "default","sleep";
-
-	interrupts = <0 11 0x4>;
-};
-
diff --git a/Documentation/devicetree/bindings/arm/primecell.yaml b/Documentation/devicetree/bindings/arm/primecell.yaml
new file mode 100644
index 000000000000..d8097521dc7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/primecell.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/primecell.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Primecell Peripherals
+
+maintainers:
+  - Grant Likely <grant.likely@secretlab.ca>
+description: |+
+  ARM, Ltd. Primecell peripherals have a standard id register that can be used to
+  identify the peripheral type, vendor, and revision. This value can be used for
+  driver matching.
+
+properties:
+  compatible:
+    contains:
+      const: arm,primecell
+    description:
+      Should be a specific name for the peripheral followed by "arm,primecell".
+      The specific name will match the ARM engineering name for the logic block
+      in the form "arm,pl???"
+
+  arm,primecell-periphid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Value to override the h/w ID value
+  clocks:
+    minItems: 1
+    maxItems: 32
+  clock-names:
+    contains:
+      const: apb_pclk
+    additionalItems: true
+...
-- 
2.17.1

