Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99366606D83C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbOFfUez
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkPk0xK0z2xSZ;
	Tue, 03 Nov 2026 20:52:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793699530;
	cv=pass; b=HVyehPhWlE/wPEQ66LrPvpMc0H0MtPtK+RiVGVDUYCdEg0DX/H9b1GEJHHJMuIuaVpTEG+DGfWHfex00seBCFPKJFy7gy+53alSNyw7IkKZsViVXDGA07merZp60W1yhN+OJMphxSmJ42V/gIflBx4INqv53q60D0jcsFKXvGB+zOKxSbsJIdS4tM5GaREbaCSRmpCpMrufOgR/0PhGLFntKBe5eEfQfsNIsI54D/BiR7lMihwKfF3GBISdnfsMxhW+TyxvMHG9taXiAHfyA7QoP3PpbZUA2RBSpOv816wGmkfxumlGcKpmVbt0AHu30TLqucSuBOBLnLND4MXWBUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793699530; c=relaxed/relaxed;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEVPEUtoA2Z7+I8s1wAlUtUE3gn86a9lGf2r2WVuskvgZbtslrndVbjh4scN94r7HfK03YdGFX7enxktOURFZXC2qf3NJQG3J1476YssU2nh1LQcHPaW9t8bmWgxrR0TSajxB7QRxaKx5r4IOkVxliqEejfs+qErpr8Diuzfm92NcqqCok0nrH9q3xbN5lCqvftgQgC9XD6qBnijQBRw6jz30MIkg/V84mB0tJArTDwhkFEn9fo0Gi2etEfs1ZprKqU10XFbA+ph+kAA74qiIpoEwLoxH4RfmY/X8mNYMqf08mNBot6J/8JGr/IroM4tWkAVIB4zTDPmCHCsu+K5eA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbOFfUez; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbOFfUez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkPj1NZwz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:52:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F35D843A62;
	Tue,  3 Nov 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793699526;
	b=yYzCDZBHP9SgAY3AJmqYGbdh0kLkBATLOrQIEII8AfQcgBWmArbtDHADdzGTqXIbcTXG
	 cbTwamGrQoIRtTzlUenfoxJGKbq4661GQDSofOqeDPkPCJMCAE5znGvXjEcckMC/ycGka
	 h/HvhpbtEJSxx1kbNeL8Jq3abe9MzoArYNfhroweO8fY/wu9TA/C3GIg6+kPFYNvMAtnx
	 gohL5MVAO7W1Vb68aL5XrK5lKQGTgUqS1vPbLkxyWYYEzMcQSfGD6+s2Gtd44Nls2G2xD
	 JUZIld8XWJIme+i73ECvuWb2RZdo/cPmMddxt8xXI57OT/Jf9sEduMRwrLID5u4VWzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699526;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	b=aB3OL/bQRX/XoZnsrDzwZA4dXKtMMSWv1k/2YKygSJ5Qv8R1RDZKB6UySkLILTmzpNRy
	 gfVrQv7gk8Tv7Kz47S9/3hhnksehKfTegXcy2gy8ABctcJrItNdRWcce4rM2hEENGnjIO
	 9lOPR9WzZtyRbw6FfCvhJhH/5cypTLsUO3Fq5zicyFKmbOQGBJry2xAONFShrAHirMWmB
	 CxTCw23OpfrPv4RddEqNkZarzklAX4wN8X/gr17QBiNPTAbnMpBiV3bHNJVqlOPlvqIDw
	 +nwOYh7FW2Bu+s21xDndK7s6YIr/bLTyzy4y7tNTBL6N78aOxpsUGN/OkSuusRykOTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC4B31F00A02;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699526;
	bh=Ja/5Mv/Gop/oCSkbd+7+q5gBCpKe4wRAQI2mzWh3K/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dbOFfUezpnk7sC/851nVF55QRryXpdK5vTc/MRPQ87EFAgPIZQTRrzNzn+8SK/UGm
	 +zSe3dtHuyZQUDpSUSQOAToxA/JUQGpqc4RBLVVNpTaY+R82faAQD0oryO4MQU2b6x
	 b+ZAbDcL+J/48D9eqsTgzprF8AaHX44M0BpK2jzuVdET2Aw3kPcLqnv/2MERJgEJsw
	 gVhTGbLZmjCv6nStkaQH/rqA0gUn1gHF9Tp2Ge3ECKEcMSVwhSfYjvhe6OOEertxg8
	 OebhPtK16cmehcZvCE+FeDcnCSiXqL0vgCx5h6c63xXpbm5vk0rnmioQ94MgjyA+7h
	 8mvXUdDy8N3MQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 575E24687A;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 03 Nov 2026 10:51:55 +0100
Subject: [PATCH 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
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
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-2-0a61a9837744@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699524; l=1598;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=YA2Jv1p1SkYZyf+rDzE5uX5RrqHER8WNy18Uw1BptA0=;
 b=ZXjr6TLClRSMRHPl8Bpx+2YT1KbdYn98T0AHwx9HoAB2MM5R3E1uhwn7qemfm1Ua/RvRg9I7k
 at+soShAM/aCr1TnInmOHASyf9ia0ghTrtNNwHV23QMted2/YqM8ALh
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



