Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905260A261B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU9p2Po0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTSQy35kSz2xmk;
	Wed, 18 Nov 2026 01:53:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794927210;
	cv=pass; b=RQpv9CfstF0QzaiGvcUp1UMUL2z4e2l4lGfDZU8aUV9xnxzzEjVsTHS8sQfWATQ6aXR/SIeZZ0oD+YUr8TvY2JLA0qUw60gvYZ23NurYQm9dy6h9kcb1PC5zhdmgNFfQKItLHYCYbDNLBqDtalTaWuA7gLM1eN86XZjLdIFP9L3n6EngW+IVi2mWEVusN4InkdwYGMUn8k1asmK4Ora5mBgtXk1SRGDXN+xyOfwG3TVn0k7humshUHe00jyaWBdhqeZr2jr5rxXp6VakKnh6tcJfXUO48ykNNt3Kb6iYuTvqQZNHaHgd9KO87u1q6IZhtJMKbAdzl+snyVb631106w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794927210; c=relaxed/relaxed;
	bh=a4PoB+1aicRpvLxDE1/KgNnpi1kOiDP2CU5f5EIZbKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0vQUoe0d8l3SLvoOieQyvsip5mvEKVPC+Dqv7OyVuhGwC1O4GuL+0eiTLHaUM1x1BoBJGpwZqM4QlJCCrx0enys2SIZY9tG7+KJSd6NRC/6iVoqUT3F5gZ/+NcsInnhGu2CNKYCJW3l6aEcea4hWQKdiw0xOICR7iER+dqmOTSzFSVYxzQsWYmFVYcic2qkmXhLuQXkzMhgM8MZBDa79bk2cSjPQDQMe9vtDnzW4D6nEJetwDgh186TZq/hQrweZ77wVgutq3xv4pWG9OAPXAFD31Dcv62voVZreddZcRseR0NXeZ4UZ36ihgOGiJwO9uXn8ghmIEhHG4aZG/47zQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU9p2Po0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU9p2Po0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTSQx3yPZz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:53:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DFC0E448BC;
	Tue, 17 Nov 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794927207;
	b=upivYtpT+0o4hcWruKtyF209lGJ149JXD2zC/OTKiZcQQavyeMFJjYqggYNKpVEI7QD8
	 bNH1eQ5p3wtphFUuinjuLXjTwL1QUnDT49QVG9hF7zSSOmWLVTyoTOMOXk1V1Fw/LX9qv
	 K8a7WGP2dSPzyy86G97hTFtkN6gGD/1AJuHLgIyXsVrawxD7fWVJnESfLtrnZvtKv5BSn
	 bkcu/pnLSwiIkdqYy8VLJfp+NzpuTEpJU8szzGegyDcSkhoMVwoDpR1DGxKJHTVeCZWXn
	 ed6gnJt33LdbrGmCitgEQiPWFqwbx35msReq8+hm/OZlMmS9ZwXdavudobnlJ+zqa0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927207;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=a4PoB+1aicRpvLxDE1/KgNnpi1kOiDP2CU5f5EIZbKM=;
	b=ctlWwBiiYhq3DuuTLoI9UVYY6mBTGrXIsBqE6/d6mYpBS8iU9jMM9g+4sZ6bTZSeDRed
	 sedo0Ovaz4BhRQPpsaruPLvIoQrpITtaeo5M9mpNrhCxTSH6QyqmNSA6jlEcaJHHKAx1Q
	 GsyREc+xw0Sd2MaTCLDj3IcrabYpGjSnF8QO4UEdt2CLgGa8cvFIbpSfWWAHGBz2e3OKN
	 QiVBc4apXxQdKc88w9zguTYtJfrztLiMCr/CaFx74KNoww8SYp06NOxdQi9m5H9p5z8Cc
	 uo+0kKcaF9SrXzGpjxp/ev3gHtDh075QrhQGGMdpzvWiQBj1NBSMQJO0P3znOFaLEfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 271611F000C9;
	Tue, 17 Nov 2026 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927207;
	bh=a4PoB+1aicRpvLxDE1/KgNnpi1kOiDP2CU5f5EIZbKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CU9p2Po0+oGDABryw3jRmJpihX9FvjjZl3Y5Ci/+pv4v3je6o1E1jB+eegn8s6bxy
	 jnKXh4koh9Vd7DS19G+bgBzUare3Utc6MWkm6ZTiZfgEc9Poi8Lw8eGEWX72kr/P3v
	 6mHfBT5BYmfDJxx+aXTLuLONtm1U4tyQJA0Yu/frOIUNzIT1bgVzhNf14vaNZFEv2N
	 MZLnhuLzc0I3X2wgvuSlzLVpxCOO9XPiEeoTxGQ1rGKmYXbtdEZxCAil1L5IKnFX6V
	 ipEzaqLwMmPCxCE2NEiXyJgHRTRTx615KsZeaTT8RdU1oY2WLxOUrJCW7G2lbHFaFo
	 wE7u/+yhdjXRg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AAC4E4A9C8;
	Tue, 17 Nov 2026 14:53:26 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 17 Nov 2026 15:53:12 +0100
Subject: [PATCH v7 2/6] dt-bindings: soc: fsl: layerscape-dcfg: add the
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
Message-Id: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-2-5d7201970629@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794927205; l=1719;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=CVizR3NF8jRDqX6EvvjxDP8c9Q4ToahcqGl3Dh7PyAk=;
 b=3TPhrYj6d+1xEf11drbCP6wqDTqz8ph4uhtqO3Ieji2ssW1alXM+tDr6BIAJnQq3/T5pLc0sW
 bSelyra8Y0eASYPzOB+S0UcAtUvi+qH3H7H9TBHnyeIqds7wgQ0ncWP
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index fc14fd0bf84b1..bb9dbcfec1881 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -32,6 +32,7 @@ properties:
       - items:
           - enum:
               - fsl,ls1028a-dcfg
+              - fsl,lx2160a-dcfg
           - const: syscon
           - const: simple-mfd
 
@@ -66,10 +67,27 @@ patternProperties:
   "^clock-controller@[0-9a-f]+$":
     $ref: /schemas/clock/fsl,flexspi-clock.yaml#
 
+  "^pinctrl@[0-9a-f]+$":
+    $ref: /schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
+    description:
+      The pad muxes of the RCW on the LX2160A, at their RCWSR12 to RCWSR14
+      and RCWSR27 windows, overridden through the DCSR view of this block.
+
 required:
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
+      patternProperties:
+        "^pinctrl@[0-9a-f]+$": false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0



