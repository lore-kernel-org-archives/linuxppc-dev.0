Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A341606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaGvHSfG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMpVZ39SNz2y8W;
	Sun, 08 Nov 2026 21:07:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794132422;
	cv=pass; b=MkDuGFr7+Fia0WpTtJDHqUfRsx3ZgSd8tKRvgNlH6rD4jKeNwI9vxdg+M5tTv+0Qf4XJwXtoPyLL892MhRT9BiDvAY4T4oOnMDkIvosnI3X5zaKORnp80xVHydB1fV80A27rARbCon6NlB4s/ryxhCkSrpZnj4npuTwEQ1e9PdJDJ5OhZojpBaVtrSWI/75IWsiaJBZoaD1E3T7AWiWA/rrjJFvYZQiM5PYlKG5F7BkF8m/GyvImhJKg3e+x5xPu2KrR8v16Ez7dWvxHuzRPDuOFrddLMlcLqnuXRzLiQW1xdElXzJoeVsFdeavv4T0JWHkdeHuNRcvrsvl5YXS32g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794132422; c=relaxed/relaxed;
	bh=edxB4mQnAjtUadl5l6d1Dd7PL0hyvnmmPnOOOTv4+0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nISiZj7gzKk4T3bWJ4oFx7URdZAPXqMerA4iXBRCefLg79c6pLMAgQIAsgUp3RVFU68TUIvzFcW3CMINEsgoSWyjL8k25tGdrY5NwbCh8RwNhLqI918TWjhyFHUplqijFBFdb04OacM1p9rg3kaCbFKUIcqwhlNr3So0OxlEU2QgGnI7fwbRQHA+khbdY5tTSjCmu00KoXpo1SgSVzHS6o0pYm5u9iobqnjjdYyr3WGPtuqEz/sS1pnSHjIGa0OtYQhBz6ePcWYhlN3AmK/abvhu2eiefbqVxzlR8Gc4VnmtNhETQZEjmV0nZIgkYfNEJgIEbxAI0/vwqmWx7lS9eA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaGvHSfG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaGvHSfG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMpVV57H7z2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 21:06:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F20E6154D;
	Sun,  8 Nov 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794132415;
	b=aElomuRtITJOvNav1WbHLkEIgNkAaKyMollUpfjxgjcK01XS2ilaT/kfplEMik8egE42
	 oahUrEMP4YbDapWR0Z2AJt1bMHCgWHyXEECJtE1leN4FDqvlSJsOs3UkhD/iC7CQNj4pl
	 6q3YXd6yUpn8SK6qF8XTGnJSPqtJlYZ9EpZ+9zaeNgHvl/9lDWoDD07LsKnY2CzMcIX15
	 ug25QSM+wR4D7A24GpxwneNE6d141ncC1l653rsMNbSZDdPEqzuNQXYjCsR03Se3kTQPI
	 QlvkfT9QSs8WbSiQMm1V78H241Q2ocAPADnN4uZcZB3j5YXo4wukK/7AjWKSJ9f6TNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794132415;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=edxB4mQnAjtUadl5l6d1Dd7PL0hyvnmmPnOOOTv4+0A=;
	b=dWfMs9eKZDgS/3JYGJ2L4kShOATEcROHS7cC45pbnh5PGz+K9AFZiwXm0W3VSXCtGrKX
	 YePO9FWeiAs78i5bHEvDotDBDz5meMRorumArltrOx2jZKhZAACc5L3HSYUxXLYBHMQ0M
	 zMpFRe3YoVamqTtVc4h59RN36m8bGG/3BLjjq9BsqCsUGHC/5d8MI/3xJCOYli0OrFZMo
	 6l4DUGhfFQL/T5Y4dLDvnx76KGti53ASDCHp55KIf7m0lksW0ZV4HqcMvVsIxt55HE6wg
	 Q2W0NiA8QJ/NgmoCUk39tQO/ZfdwoERbu7G/pThjOtHRHWg0z1AEAVL7yD7GICOWAyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 871A81F008A2;
	Sun,  8 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794132415;
	bh=edxB4mQnAjtUadl5l6d1Dd7PL0hyvnmmPnOOOTv4+0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZaGvHSfGRh2A60mRhochXI9J+azugWC/sbD/iV8PPn+PGSdngESxeJmByEnXXhQ9r
	 gnZjRk9OHKWJIA72R6sUTZDARqgJOf8YeyoH3GGgUSX2oKuhjRrRA7zLe1KvIc/JCk
	 tVwiM2yIvJCWkZIc+a7OZL3egoo9pfitj4uVLraYR7B4O4HzY8l4tGXA6wFg7oU2vi
	 TyEozW4FfViQPCx21ZwvFQOfZ9ZTV27w4Zvff698iTXKPrlE1k5ldeXYJHqgl6R+3M
	 Xr0tXpT7bdStQkywKBJoYrLFAfapNkXQ/WASuKSNvpFvgRWBO8DwXwm91pc+yniUe2
	 +ojGF8PA1p6Tg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F22B847EBE;
	Sun,  8 Nov 2026 10:06:52 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Sun, 08 Nov 2026 11:06:49 +0100
Subject: [PATCH v3 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-1-5a0063f1da9e@free.fr>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794132412; l=7863;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=WJEu6Kut0xVF/KDjBMf//ysc0ClXUnn5Bm43TSeWmfA=;
 b=IpNDce5x8e6DnaVw4ejAFhEwC1YAQrx4LohykmQ/W18gOWIX2GpoDq5LE0fEa+crVvG0NUQxN
 yS0RCnwfuuTCU//58QPTs9x+HstcUisy714uwo5Kw/e70OUC4Vt7+Xh
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
fields of the RCW: read-only in RCWSR12..14 of DCFG, changed at runtime
through the override registers of its DCSR view.

Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14
window: the override registers are at the same offset of the DCSR view
of the parent. One group per RCW field, one function per encoding.

Each function lists the groups that take it, so a pair the driver
would refuse, such as can on iic1, is refused by the schema.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 264 +++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
new file mode 100644
index 000000000000..6bd21c27a00c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
@@ -0,0 +1,264 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LX2160A RCW pad muxes
+
+maintainers:
+  - Vincent Jardin <vjardin@free.fr>
+
+description:
+  The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads based on its
+  RCW. The related fields are from the read-only RCWSR12 to RCWSR14 registers
+  of DCFG, and can be changed at runtime by writing the RCW override registers
+  in the DCSR view of DCFG. The node is a child of the DCFG node, which owns
+  both views. Its reg is the RCWSR12 to RCWSR14 window of the CCSR view, and
+  the override registers are at the same offset of the DCSR view.
+
+properties:
+  compatible:
+    const: fsl,lx2160a-rcw-pinmux
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    type: object
+    $ref: pinmux-node.yaml#
+    additionalProperties: false
+
+    properties:
+      function:
+        enum: [ asleep, can, evt, flexspi, flextimer, gpio, i2c, irq,
+                reset-req, sdhc, sdhc-clk, sdhc-data, sdhc-data4, sdhc-spi,
+                spi, uart, uart3, uart4 ]
+
+      groups:
+        items:
+          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
+                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
+                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
+                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
+                  evt4-3, evt2-0, clk-out, asleep, reset-req ]
+
+    required:
+      - function
+      - groups
+
+    allOf:
+      - if:
+          properties:
+            function:
+              const: asleep
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ asleep ]
+
+      - if:
+          properties:
+            function:
+              const: can
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic3, iic4 ]
+
+      - if:
+          properties:
+            function:
+              const: evt
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic3, iic4, evt4-3, evt2-0, asleep ]
+
+      - if:
+          properties:
+            function:
+              const: flexspi
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ xspi1-data74, xspi1-data30, xspi1-base,
+                        sdhc2-data74, sdhc2-base ]
+
+      - if:
+          properties:
+            function:
+              const: flextimer
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic2, irq7-4, irq3-0, evt4-3, evt2-0, clk-out ]
+
+      - if:
+          properties:
+            function:
+              const: gpio
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic2, iic3, iic4, iic5, iic6, xspi1-data74,
+                        xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
+                        sdhc2-data74, sdhc2-base, uart1-soutsin,
+                        uart1-rtscts, uart2-soutsin, uart2-rtscts,
+                        irq11-8, irq7-4, irq3-0, evt4-3, evt2-0, clk-out,
+                        asleep, reset-req, iic1 ]
+
+      - if:
+          properties:
+            function:
+              const: i2c
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic2, iic3, iic4, iic5, iic6, sdhc2-data74, iic1 ]
+
+      - if:
+          properties:
+            function:
+              const: irq
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ irq11-8, irq7-4, irq3-0 ]
+
+      - if:
+          properties:
+            function:
+              const: reset-req
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ reset-req ]
+
+      - if:
+          properties:
+            function:
+              const: sdhc
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic2, sdhc1-base, sdhc1-dir, sdhc2-data74,
+                        sdhc2-base ]
+
+      - if:
+          properties:
+            function:
+              const: sdhc-clk
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic5, iic6 ]
+
+      - if:
+          properties:
+            function:
+              const: sdhc-data
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ sdhc1-dir ]
+
+      - if:
+          properties:
+            function:
+              const: sdhc-data4
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ sdhc1-base ]
+
+      - if:
+          properties:
+            function:
+              const: sdhc-spi
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ sdhc1-base ]
+
+      - if:
+          properties:
+            function:
+              const: spi
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ iic5, sdhc1-base, sdhc1-dir, sdhc2-base ]
+
+      - if:
+          properties:
+            function:
+              const: uart
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ uart1-soutsin, uart1-rtscts, uart2-soutsin,
+                        uart2-rtscts ]
+
+      - if:
+          properties:
+            function:
+              const: uart3
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ uart1-rtscts ]
+
+      - if:
+          properties:
+            function:
+              const: uart4
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ uart2-rtscts ]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pinctrl@12c {
+        compatible = "fsl,lx2160a-rcw-pinmux";
+        reg = <0x12c 0xc>;
+
+        iic3-i2c-pins {
+            function = "i2c";
+            groups = "iic3";
+        };
+
+        iic3-gpio-pins {
+            function = "gpio";
+            groups = "iic3";
+        };
+    };

-- 
2.43.0



