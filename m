Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC7C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E12206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E12206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437z8Y1P8bzDqMS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:46:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrf2JtszDqFC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:34 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id u16so13120608otk.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8hHjlrgRb6o1Gybi9b4yXPPCrMqQy6hVm/Nzderzac=;
 b=YsYw5A7zGReE1Ggc49hbE+oRZalowidn6O2dhIh7YBdKnCVjYRm8CxLeTXXSH6lehw
 TRVoZRqf9QlzX/C6LC7+REIksNmMliX6duHPqYLqSM9EQEBVpBPiciibcTUNZkIAGBQw
 z1zJgv+qQyN0zhQ8BsQ9naMNtYkC8zB76FsluohV021G+08o9yZoYrWmGk4E8drehbFa
 ElOw0WSgdjxmfCQu21DmPFYVsR+B0KxtQh+8i78zwUXh4fvV5S9Ld8hFnNBc1IYKuJ40
 vI6pnBABssJXdoSgKyXQSLdmc9JE4RQF10Bi9VDlAPip0pDI09NKlQ5cw3vr6qSk6ccA
 Enpg==
X-Gm-Message-State: AA+aEWaBVb7FyEkjJOIJvzYYVqo8lDSaGvreFZ4KLuiT8r9iu/Zl1TPh
 RGw3TP9C4S7W3hgrj0qNvw==
X-Google-Smtp-Source: AFSGD/U1q5zdn1LQBvwIziKGdAO2KoR11z7owggnYBrzJQspi/AhLcah+Bq3pcrKybosnc7TgdH3gA==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr10582822otq.38.1543872751944; 
 Mon, 03 Dec 2018 13:32:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:31 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/34] dt-bindings: i2c: Convert i2c-gpio binding to
 json-schema
Date: Mon,  3 Dec 2018 15:31:54 -0600
Message-Id: <20181203213223.16986-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
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
Cc: Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert the i2c-gpio binding to DT schema format using json-schema. This
serves as an example of how to include other schema (i2c-controller.yaml
in this case).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-gpio.txt      | 46 ------------
 .../devicetree/bindings/i2c/i2c-gpio.yaml     | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
deleted file mode 100644
index 38a05562d1d2..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Device-Tree bindings for i2c gpio driver
-
-Required properties:
-	- compatible = "i2c-gpio";
-	- sda-gpios: gpio used for the sda signal, this should be flagged as
-	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
-	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
-	  open drain.
-	- scl-gpios: gpio used for the scl signal, this should be flagged as
-	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
-	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
-	  open drain.
-
-Optional properties:
-	- i2c-gpio,scl-output-only: scl as output only
-	- i2c-gpio,delay-us: delay between GPIO operations (may depend on each platform)
-	- i2c-gpio,timeout-ms: timeout to get data
-
-Deprecated properties, do not use in new device tree sources:
-	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios
-	- i2c-gpio,sda-open-drain: this means that something outside of our
-	  control has put the GPIO line used for SDA into open drain mode, and
-	  that something is not the GPIO chip. It is essentially an
-	  inconsistency flag.
-	- i2c-gpio,scl-open-drain: this means that something outside of our
-	  control has put the GPIO line used for SCL into open drain mode, and
-	  that something is not the GPIO chip. It is essentially an
-	  inconsistency flag.
-
-Example nodes:
-
-#include <dt-bindings/gpio/gpio.h>
-
-i2c@0 {
-	compatible = "i2c-gpio";
-	sda-gpios = <&pioA 23 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&pioA 24 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	rv3029c2@56 {
-		compatible = "rv3029c2";
-		reg = <0x56>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
new file mode 100644
index 000000000000..da6129090a8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for GPIO bitbanged I2C
+
+maintainers:
+  - Wolfram Sang <wolfram@the-dreams.de>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: i2c-gpio
+
+  sda-gpios:
+    description:
+      gpio used for the sda signal, this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is by definition
+      open drain.
+    maxItems: 1
+
+  scl-gpios:
+    description:
+      gpio used for the scl signal, this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is by definition
+      open drain.
+    maxItems: 1
+
+  i2c-gpio,scl-output-only:
+    description: scl as output only
+    type: boolean
+
+  i2c-gpio,delay-us:
+    description: delay between GPIO operations (may depend on each platform)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  i2c-gpio,timeout-ms:
+    description: timeout to get data
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  # Deprecated properties, do not use in new device tree sources:
+  gpios:
+    minItems: 2
+    maxItems: 2
+    description: sda and scl gpio, alternative for {sda,scl}-gpios
+
+  i2c-gpio,sda-open-drain:
+    # Generate a warning if present
+    not: true
+    description: this means that something outside of our control has put
+      the GPIO line used for SDA into open drain mode, and that something is
+      not the GPIO chip. It is essentially an inconsistency flag.
+
+  i2c-gpio,scl-open-drain:
+    # Generate a warning if present
+    not: true
+    description: this means that something outside of our control has put the
+      GPIO line used for SCL into open drain mode, and that something is not
+      the GPIO chip. It is essentially an inconsistency flag.
+
+required:
+  - compatible
+  - sda-gpios
+  - scl-gpios
+
+...
-- 
2.19.1

