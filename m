Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF75606D808
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDUICWX2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkPm49NKz2ygW;
	Tue, 03 Nov 2026 20:52:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793699532;
	cv=pass; b=cuh8NkdTTrfZmziGprIrXrXgLLbzWxyZLWae41fW0zmBacM7aQxjOOb5BK98RaQYC9I50Yys9KhfdpXTx6VwtOaCAysND6Ah1rRKWflm2A3cjVKibbcY+GCfTqSGoEtLbBw31KdjTLx6qovZSTxgu4kNyywOqrUQlB5ZchY59+uHkIm8+bbX7xtyMUwYr5nDi5cTKgYwc7t0R9koKcYEYHWw4sg20wfI62ItwTTetJFu45v6bgYdlpdLIKg8onpbUFFepAJlX5ntrVHEPkITJK4QVmjwK3kjlbx8sM4ry2n/EpoNXtTy3JCOWSG8kiYWLDy6b6x4GTBrSRdvKgcm4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793699532; c=relaxed/relaxed;
	bh=ks78ZYfGZWAqwGYnqJnA2JTTyTpL+DFgUmaVSYHG0Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTz27MOi2HBgDneRIgdRJdIPo2WNHl1qNQaan+AsTsTc2y8RD6si0iLhft1QTN9d/aH6WozP30E+KgFN8Nm3isnRdkVcl07Wl0fgXeXrxarFT92Oj4ay51CFIgNzVjLN+s9mlyaKMmVa6RbUoB3L5PleKRPOQDoO6bHFiXTVe6ILiZW4hBEl/FwFOdD7HnYPJmLxGk5rdA6VZX2hs+oh6O1qxk527Wn4lqu43H0X52dgFeiD1ygEX89HDPSg+VskKBE0QmIuHxuTsan7ZpZXoklff1F/Xxaq07v0iWmyYhhnZK/51mRarjKpVqpRhHZo2+GeOZknMH4FYehyW5X+Pw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDUICWX2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDUICWX2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkPj2l0Tz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:52:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81D2443CB1;
	Tue,  3 Nov 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793699527;
	b=IVbjEumCAzupwFu/C1ysLjRaG//pvkfRKah09J1wNbn9im9AtMhVr94Dx3IG9cpUK67H
	 VpoO83HGQt74yYl4DVpYIN8rrZPbNJZxFUmkhh2UhbmBk27Et75Tk4DS+eDLOis3sNqgf
	 OFSYFjdhzUK+jRdbzMuaMnZWdbEg26FOjy+S1sX7CL1CyxW6Debd1A27Lno8Ww+cNhtYE
	 uOqy2owQft9kvtvzLQyeC2UauITUUzTaqNO1/kIUKPDgOr4nx1obPzzuLkydI1Fwtd0IT
	 4Ju3fkZ2pquSrQzsLsx4S5qFTTt0nkn26MwMndgSlCLqsAuwU8DDhLomtANPpXgTkug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699527;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ks78ZYfGZWAqwGYnqJnA2JTTyTpL+DFgUmaVSYHG0Rs=;
	b=dtfKseu/andytB05aHLkgkwxq1Y4bxbf1764BYX1naBTF1lLUSxy0cOVAD/jqEVnflRX
	 Sm74DynxEofWEo2pe9OuK//PtbEdi9ClKy+RhPXTLEC+z+76+K3WZleowgb5gXL+IfwIV
	 N22zA+iz7URKdUiijFIHPsuVGpg2Df73kx/DlN53BOmQsIJtlwlqD6sCekpTKMiKqcR6s
	 40K5sthLuQRii0FPuloH1tPldvEY30ascvwdyHgeBaC+VY7VQn3A2x106hPcza/IX026U
	 GzjQ8/Bf4FUDwvo9XxfvLAVEFr6kzAv/qNs+mrtRPs8bK7oO9rCIZeR3Md/5HaTDL4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C15B41F00919;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699527;
	bh=ks78ZYfGZWAqwGYnqJnA2JTTyTpL+DFgUmaVSYHG0Rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XDUICWX2RYaBLrieMwPrWbv2bcoxBHM+VxoFGlVSiYf3OfbkA/EvIG2+DrY0VSZPK
	 hN31VKy+P2aeohGBYr17c/9A0a5PkIYNWWzHetyGiHVdqpR6axAliGPjLhp1xiZkTR
	 Q1REQHh277WII30fJQijxGkDaOmzqGHh7gSR/JSqEdnGVYNmsCcW2RGziTYb4rxWGq
	 +eEPYeHAxQw1ZwqEr6PanO0tek0l74mnk+fBNLvymL5jILztM1xE+KVOjQSr0VgHrL
	 ttvb0/j4NMP3B1NUlZj+6RTPPPd8GEumJs9WDugNNjG64H0RzmiCV5RReJaPnKWDP5
	 HStmkGNIkJprA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49E6746866;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 03 Nov 2026 10:51:54 +0100
Subject: [PATCH 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
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
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-1-0a61a9837744@free.fr>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr>
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699524; l=2926;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=tNHs1pTPz8qxuYkM82BrgXyboaLkIILn2mYEh52LsHw=;
 b=dA/O4LqPjsNLLumpBLPR/vHI862aAUqFH2QP4bR2sEnZ73pQrc1Nyq/AytEMDhJJjTgmoOEfc
 1TJ+yG+Wd/CD5bx8JxwzztWq5r546kEjqUsAMkMSNdWvWV9jM3cwWua
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

Describe the pad mux as a node without registers, a child of DCFG: one
group per RCW field, one function per encoding.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
new file mode 100644
index 000000000000..d79edcb077f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
@@ -0,0 +1,71 @@
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
+  of DCFG, and changed at runtime by writing the RCW override registers in
+  the DCSR view of DCFG. The node is a child of the DCFG node, which owns both
+  views, and needs no registers of its own. A pad group is one field, named
+  from its pads. A board selects a state of its own with the usual
+  pinctrl-0 on this node, a hog.
+
+properties:
+  compatible:
+    const: fsl,lx2160a-rcw-pinmux
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
+required:
+  - compatible
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pinctrl {
+        compatible = "fsl,lx2160a-rcw-pinmux";
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



