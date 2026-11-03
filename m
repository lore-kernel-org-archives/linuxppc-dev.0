Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83376606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJi0zXMv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxWf15Csz2xjM;
	Wed, 04 Nov 2026 05:13:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729582;
	cv=pass; b=QU5i9+UYLy50ncyWwplq+uo9cwh+D+E3629JYd7DGkPuuULqaNVZxiCdlxLEWR9u/ApoRpXiMrmN6QbTiGtAAzwetLte7+MW7WUcII4BoLV4DiiEfG4S8iB7Sxyg6zj1lqfCMfiT5KEUbOzBZ3ZQ6bd941I+9mMUdz7VZaON2NTlgku2V1fOLfLwk3v5KqAic1MsrP8mRN801GtCUxBE1YEk73LbvjVRbWl6HyLj9zK6YLDgc2Dbjd5xWmnaab+bxvJCVvNxqAGyP3EAzx/3x2jh0qosUbTHxPZutGmPmGkoZxWr/XOO0m3mh97q2nIiEZe1pacnGtCXuBaPY9sRTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729582; c=relaxed/relaxed;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzvvRpJgJRaf4jo0J3zroqqnQbcRvj8zaq4gWNA+tFiabT3j4Hc0KTmId1q3zdz9k0V40HNS8HVH97HYYCoB7rzGWAUy+AkG918jdBp1iuoHVHFdRKnP4om/gHG+mLfW1ODit6WyEM4WcIpugfAgX8dtg7y+dkVsFjGwkd/69Q75J8Efg94BS2lqp0jQzio+o0/YZcOC8bjx5Y1u4j0rmQbi6OYCIvIhVZ+TbyQGbf86aJ5qooVOYPLAIlZ/BcnScIZgDDPvotiqHoY5bJB9XlDlFwe+YvIk9muKOGYZw1N/hbwPlpXvGS5T3KF/+eTHKKPe9qXYSQDwjUEotODeLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJi0zXMv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJi0zXMv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxWZ6142z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:12:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D15EA6022B;
	Tue,  3 Nov 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793729575;
	b=Kcab7kIHKWSY5OR2wy+5jn+DT5z0hkvp/hqb1mZkfThZGaOVnDqJw0r8f6vmzOKJd5tD
	 warCxGkxHNldeWFGslyNDarukCSLv5+9GpoIPWYksyL2AJoB6AwUHW5Nc0u6A6dK2ZYdi
	 bXGavUZbQetXYpWEm4mIcL5vZr8tDOR+8Bii9Z/De0uBSNmGUYa3N/o7kzD/QuRFdcDpG
	 y7LRRCG0GM9XHGP8D7bfTIaQFCWwALQKALW7Nw17hCooAtXuwvIp8KpdUwk3RKrm58Kmb
	 e9WiIJIahqfuNTz6Apjj8N4Z7tbyq8gFeFl4T7IrMKvgRfyBn6fIwFxQSyF31Q5+Oyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729575;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	b=HgCuoLB6IQdRvscUKvVX776/IVk7H/d7FXS6DmoWQxJoeoBsm8p34sLfTnMirhnY+HQ4
	 BoM1txCjrlbWbFR0jHN98Ahuia3cxp01+ZsxIP6TiitJvWeKdGqpbd7PBzdUZN7dVyzsX
	 VZFaShvhG35kGKLk3wIt5dUQodQULzGXoBDUxW/V93yNbei0lQQ0ajeVRZrvTrAGsOlKF
	 WQWNdoRbE3US2IQB+70owdgKkZ7YSQKnMMORYTkCYd4On/gy8dxN6pE+VTsMFil4lkGRT
	 UNYs4rBqF8YbPE0W5JpySu/81xcgQHvvK26xbkK6dj2bpfkJwi7IxtdlmsBx915skhw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8DDDD1F00A1C;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729575;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OJi0zXMvZEbFNQR744kZZclXuAaOdLgDzcnRoyCWuQEGbddkvJjoW0kdfjcTaNL8k
	 kyzc5WVPyHPLHpnLRpykJlH7NNk2Jg6YM20hl15YGSivge/Wb6BrGh4Tlmi3YwGzQR
	 /MpU8u53wEXOBqIyA3UG8AX5JXPlOVsA5Mtz6FmAVKk4AzHP7IdcSdA3l06EwRxsTJ
	 EdfKqm89Cc7UuSi3IuE66zhhmE/wghdkbSGnIViZZSkwrxpTGmosW15pYU+4Ao/YNK
	 rh/g0SmwcC+TPM7NlII58Jj054tQq0IDJXoFr75c3/+WG7nHpIRiQs4pYniC6IhPVL
	 bsI5BLAIlE9Bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1E91046A75;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 03 Nov 2026 19:12:10 +0100
Subject: [PATCH v2 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
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
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-2-3aad0860b984@free.fr>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793729572; l=1598;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=YA2Jv1p1SkYZyf+rDzE5uX5RrqHER8WNy18Uw1BptA0=;
 b=BuYXFKVa7bzqfQNlLlL/JpWV4nMUvbYRC0qmNKHkyzhAszW8PB0bokvLsaF+vQSiSGNzvmZlg
 89PcYFMXPqgAHrg/pg8G5LGavtJrFyt3QTheTm3eXX5Oq0SPWpZKSH2
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

On the LX2160A the DCFG node holds the pad mux, overridden through its
DCSR view. Allow fsl,lx2160a-dcfg with simple-mfd, so that the child is
populated, and the pinctrl child, on the LX2160A only.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index fc14fd0bf84b..dd6a00ba04eb 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -32,6 +32,7 @@ properties:
       - items:
           - enum:
               - fsl,ls1028a-dcfg
+              - fsl,lx2160a-dcfg
           - const: syscon
           - const: simple-mfd
 
@@ -62,6 +63,12 @@ properties:
 
   ranges: true
 
+  pinctrl:
+    $ref: /schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
+    description:
+      The pad muxes of the RCW on the LX2160A, overridden through the DCSR
+      view of this block.
+
 patternProperties:
   "^clock-controller@[0-9a-f]+$":
     $ref: /schemas/clock/fsl,flexspi-clock.yaml#
@@ -70,6 +77,17 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: fsl,lx2160a-dcfg
+    then:
+      properties:
+        pinctrl: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0



