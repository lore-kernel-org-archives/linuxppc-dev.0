Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD01606A89F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MluOXwsf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTSR14dxQz2yMn;
	Wed, 18 Nov 2026 01:53:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794927213;
	cv=pass; b=hcIpslyNFrnpsP3XSgpTznCwSPWRu/Z4v/fT9OzjAZd8qwm9EywiwKlRZyF23PT9LdiF5BbeRLPzGHcA932BDeXT5tyt6+T2sdrSkJsq9YnDTaoS0gBXfdY3gJ/pCnYGeLE5BxgzCVkPXDtoN1P8LtVCDNQN5r6toQLvevK3P1SiOees4bn+siZTEp4Erj+XEftbqCeB7W1rxI2+328ksyWgFtgPo1RzByuqe8/cir6LBRWJTu4iwvZ8sW3CzWP40KMSqt3g1va4CPwnQNnTsOc6x/W0azunsB06pzb/atO4+9QV4tk9hXmJhCAGg2n5MhIRC3Qgu1bAGPBo7OSXZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794927213; c=relaxed/relaxed;
	bh=fpqSGpmdyyYCjiBPVdjFQhsXwDWBzCj/U0WQlWQ2C1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9vQwDq5UEMGPGH0kbMjBaZA+RLHs1oA2uViO6GlqecJYjNxK/mPCT6Pp+OdCKlp+jS1OJ3NaZwCYEKVqEBU7U/w7j/kL+AGiuEJBRq/INjaYjPVtqc/r5KAL7SqQXMbvQfvlt+9RyA8PpMTm1QaZOa3suczH6iHTXKzlWu32NSLkUNLp4zDIoNZEjSTTEdDnDveB59gonrD709vun+9CoTFJISVeaOkTRl/fNitaKXuomrq2yg3pbmbWcEI2Zh2efnTpUPxhKpkKPLboFgUaov06DjmQYiSNcPAE1+3ztPtM4gZfrIXgPly8C2Z40Y9JQmeDkt/HpKgW4+QRY+jfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MluOXwsf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MluOXwsf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTSQz06PXz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:53:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 685A862600;
	Tue, 17 Nov 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794927208;
	b=xYOz53OJGgSOnQLI7PU70jQO3ie1zWrioS9QgCmrF7P/mORWE+Ke4rf1JVnRVK7+h1Ou
	 IEn7VCblin7o/sL093kRM0T+cwTUpHxqbdw8Fwdk/Tq34LIk+13D9nth1BHOWb8boxqxB
	 ztyzakDBZOgU37veH2iTTr9m+RtV+DHz1FGu/2ipJ9PsUtuaSo6AUCcqlI3l4LkkhF9XB
	 SAERAwzwz/eQhqjgpDrRZ39g0yHEdKf+4OkuS1Aa780dQ2mbYcSb1y+M9R/NrkCx8nJ13
	 ENJQchI9KbRE3PDCZT3uwIs3aj9roojCU/GNrRFTlXfSJqPJnw2SJpfvKknP0reNZyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fpqSGpmdyyYCjiBPVdjFQhsXwDWBzCj/U0WQlWQ2C1k=;
	b=zTi/m6I1gF/etVOdB5lSUK0N6C6xMThpRBBh+cLUKNmQUIKoUMB5Pg9y8ce7YCOBV0j4
	 3/0EMWkAXVyZaSHn8uBMdWuUg2Gib1W8lOZNPPCAlTbgo2ND7GnU8UxbYUAhHUHY+tMTw
	 CKtgO1OUr76skp/J0gF/udQqMxdb4sZCO2mARj2QmmfsYswv+0Qmk56KRBwBambvINg0b
	 KE0eM7ii7TZ6DQnn+82TZFzROpyQGgRiU+Z5sWboaXJLHx9H/9Pe6L0wAaao+vpV/+wLq
	 VtYrhct9ktbLu9cLtgaW4I+EtzwUNcAVbByWk39kX8UaRivT5fls1AbcPou05d0N5Jw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1CC9D1F000C5;
	Tue, 17 Nov 2026 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927208;
	bh=fpqSGpmdyyYCjiBPVdjFQhsXwDWBzCj/U0WQlWQ2C1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MluOXwsfqa6ONPppmBwIforfSAsn8PV8dHEMrvqFYP7qxhfo8Cn+r12fEHU3U4u8s
	 OkqNlN+a5nxU9J8ns4OS50eLlLe14l2YojMq82kT/ACVrFa1DnenNGw6QEcGPt93iE
	 ob9vZTioG11H+LU+DU8gJMIJQwYssWgzPA4jayNlnRnOLJGmV+k9Uk2Ldj4bNJpc0e
	 zuWVk/q02x4aPCe19RF1Z0/YSJXGNjx6fQVk9jCrRFnlezGE3RuSrqRjLzs2ekO6uA
	 FSgahNBD1EHnQdHtBT1eRPj9u5XzBLZNtCiZ2KiN95XbETbeZjameWQfzOxG8KU/6w
	 R5AcLxokZa12Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 912A04A9B4;
	Tue, 17 Nov 2026 14:53:26 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 17 Nov 2026 15:53:11 +0100
Subject: [PATCH v7 1/6] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
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
Message-Id: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
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
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794927205; l=9751;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=RRDfedLMI5Jpmb2ot5AacBnPK1KGkBxHWAorYWrSE3g=;
 b=JMlerGCgFrmszOhYj44kKzYW9R2eMhjbme9dw+HPv8dX4Rjn0fR7dOFb3lq2j5AVghJmwEZkH
 TvOGddt8EhSD3cK05SjAzF3V8FUoB1ydIHSZtqZ9WxSWNiMYmdPLJUc
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ, EVT, EC and USB pads
from fields of the RCW: read-only in RCWSR12..14 and RCWSR27 of DCFG,
changed at runtime through the override registers of its DCSR view.

Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14 and
RCWSR27 windows: the override registers are at the same offsets of the
DCSR view of the parent. One group per RCW field, one function per
encoding.

Each function lists the groups that take it, so a pair the driver
would refuse, such as can on iic1, is refused by the schema.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 326 +++++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
new file mode 100644
index 0000000000000..e19b05efa01fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
@@ -0,0 +1,326 @@
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
+  The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ, EVT, EC and USB pads based
+  on its RCW. The related fields are from the read-only RCWSR12 to RCWSR14 and
+  RCWSR27 registers of DCFG, and can be changed at runtime by writing the RCW
+  override registers in the DCSR view of DCFG. The node is a child of the DCFG
+  node, which owns both views. Its reg are the RCWSR12 to RCWSR14 and the
+  RCWSR27 windows of the CCSR view, and the override registers are at the same
+  offsets of the DCSR view.
+
+  Each group is one RCW field, and selecting a function switches all the pads
+  of the group at once. Some functions carry the signals of two controllers.
+  For example, i2c on sdhc2-data74 gives both IIC7 and IIC8, and flextimer on
+  iic2 gives FTM1_CH0 and FTM2_CH0. Such a group has a single owner, so the
+  pads of one of those controllers cannot be switched alone, as an I2C bus
+  recovery would need.
+
+properties:
+  compatible:
+    const: fsl,lx2160a-rcw-pinmux
+
+  reg:
+    items:
+      - description: RCWSR12 to RCWSR14
+      - description: RCWSR27
+
+patternProperties:
+  '-pins$':
+    type: object
+    $ref: pinmux-node.yaml#
+    additionalProperties: false
+
+    properties:
+      function:
+        enum: [ asleep, can, clk-out, evt, flexspi, flextimer, gpio, gtx-clk,
+                i2c, irq, reset-req, rgmii, sdhc, sdhc-clk, sdhc-data,
+                sdhc-data4, sdhc-spi, spi, tsec-1588, uart, uart3, uart4, usb ]
+
+      groups:
+        items:
+          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
+                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
+                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
+                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
+                  evt4-3, evt2-0, clk-out, asleep, reset-req, ec1, ec2,
+                  usb-ext, gtx-clk, sdhc1-ds ]
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
+              const: clk-out
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ clk-out ]
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
+                        asleep, reset-req, iic1, ec1, ec2, usb-ext, gtx-clk,
+                        sdhc1-ds ]
+
+      - if:
+          properties:
+            function:
+              const: gtx-clk
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ gtx-clk ]
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
+              const: rgmii
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ ec1, ec2 ]
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
+                        sdhc2-base, sdhc1-ds ]
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
+                enum: [ iic5, sdhc1-base, sdhc1-dir, sdhc2-base, sdhc1-ds ]
+
+      - if:
+          properties:
+            function:
+              const: tsec-1588
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ ec2 ]
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
+      - if:
+          properties:
+            function:
+              const: usb
+        then:
+          properties:
+            groups:
+              items:
+                enum: [ usb-ext ]
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
+        reg = <0x12c 0xc>, <0x168 0x4>;
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



