Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252F606A8A7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6sINKU0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRT162SXTz2ygp;
	Sat, 14 Nov 2026 20:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794647562;
	cv=pass; b=X14THOpJKzk4kqewfTdUfPJBc28R6iyDoJa0wbx6ZZP9CQ6ZyGlqkNT3L19+VMvPRiJ4ZnMhfcOJ5MVqg4Jo8seSHqD2KgcaX0LaWEXPmAXVLeIJYNM9cOonfbde5rZ4tPJqxoeVHSERLML4GzZHncv8Rwo4n3B5jP4ytXj1RrZ0GhlqzYjlGmuwFPXY+NRKfcVINOyv8cFjeZP7W4TGKcqEoQrhyqI7ts5s0xSsFzE4BVmUaVqh3jgR6jDIyt10o4cz4D+Gdy/hxKJXhZBpHmE93uOz6P8MkcbF4UkogNO1+ywD19ie2TwbcLzQJcN4xpz/81yYWOujdopfrjB4Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794647562; c=relaxed/relaxed;
	bh=1HmPxNcC5h5Z+poiYPyHoJvZUob7IYj5py5ybpq1DpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7IjCWZ0RDsVj60o/wSZoDzA7Fwh6DblOAZ/7iS2/ABxfbA3f4BntzJrKOAPCE8qAV/P/OjLO9WEzLArez6tihQhC/l2DjZAKo7llvx/UutxpS/HScZfQMjg79Q1vSgaRqwwbozne/SAsKt60DlAros4dEDVz/M8oAcZ1kaC8liaHAZPDoQAOkXyIeSfUzcaDmOGASKBPQeFc11IfoBc1tGgk6y25lkuqCUgcJaMTBArfBDanSohI0N9FaMdjV6VCuS+D3aBoazdLE9c0GOy5hhV5m2NYXqYQA62+GnXjYiCGf+KGouupWEo0O7N/hDxfr4HTRvA61eNqhcI/Y0Rfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6sINKU0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6sINKU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRT120B6bz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:12:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4394546341;
	Sat, 14 Nov 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794647556;
	b=rZCLe0HFq+7aykuvj+t3iTtWT36H7IebQ8BxagqCGd5kV1InW2LwNux42FxLr3cEEjR3
	 XO5dpNRQyVJp4TRVnwcFnmZn+XthkPj7CFcYc5pvqPfT19syztK+keIc1ULI7xOjP9hXR
	 fW79jNB0CQgoqjxsHyPBhdkXFNCjWA1IDRwb2AYOUKZgKb0xt71uwpnFL7N3zZWneOsUY
	 djbJEp6t4H0jkKj3A69sDIeP4NVGwxJviAhhyhmV6zB6r5kAxMCTj0wrWfxP++em6GlQq
	 YxGkv7jMbktv2cgpyahCSB9ByX9M7SCp6d+g5XKZ7+Y4OnZKAU5SV/V5VGRtV6jCBBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647556;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1HmPxNcC5h5Z+poiYPyHoJvZUob7IYj5py5ybpq1DpY=;
	b=jc1MNirikhdl+He6U75GDpn/z9KSN7wp9W53LUxQILm/CgU4tLeC/4FODNx+bhFKbMAI
	 HMvlan0ppKnbPZm4Hc2Ho+tufia2Sng00wWc0uefs9mUMzOfr6jhjC6QmdYgFr4Fz2NHH
	 Z4KQpJT5ml09NR/KtYrd3svwZ+C9Gt7YJS2PDc5TYrcTPpMScGXLrrvbq2F+lE0/aXul7
	 /50T3cJZgURqzdLNdSQ+n/XIJ3cRdiVBPCrss47KbzRpYKTnyDq87d41NYej3y2ZFGpLN
	 tVewIoV+M/mrFeM8SN76otiTxiNl1cxZdCLbZfA8544FwP0ODupV/V77n/wxLMMgQgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52A5D1F000CA;
	Sat, 14 Nov 2026 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794647556;
	bh=1HmPxNcC5h5Z+poiYPyHoJvZUob7IYj5py5ybpq1DpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=T6sINKU0T0eu9aq0FQg03io4hzFXO0s/OS4NRp4hV9DRRXum6U2fipsSoRPwdx5a8
	 QA/4HepGNDpCcdLJcWYdWA3GMOdXHLE9vHk7ZzfDOjz3OjY+woNAMBMUX13f3cKKtX
	 /aKpVP5tRr1pn3f0omiLI8muNNEBtMd9wgnx6ZnweodazBGPzJeoee6EydbU6S+cuE
	 a2sZIVATacqll51pkJzb2lMKOg+rGQdbGWImy6A5Rfsh7I5jY/excbpYXBjy81Bxp4
	 eMFomoOcRViadrmOu0I7zRY/sjYevjXIjzMnX04F+0UAdhRwITMoWRcz9iGcZ2ZKuj
	 WKNweqBIzhvlg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C1CE349D0A;
	Sat, 14 Nov 2026 09:12:33 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Sat, 14 Nov 2026 10:12:28 +0100
Subject: [PATCH v4 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
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
Message-Id: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-1-eefcea066a55@free.fr>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
In-Reply-To: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794647552; l=7949;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=R4TmEm1LLxqWdwqJt3KI4iBHK65rYx8frtZO+ZBgiN8=;
 b=n8ILXGIQxnCBdXgROJU5zgFrMlpl8K2wBA1oelVuZxQpKEQF1oO5zgKgSf7XV42O2q8jFGrod
 c+NoU7rN8Y/BMtnizZjPKe/rYFc5CMIaRDy3YH0tpFaZqMArHLg1yGV
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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



