Return-Path: <linuxppc-dev+bounces-19329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C0CE64013
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:48:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXM15Zxwz2ybQ;
	Sun, 05 Apr 2026 22:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775328333;
	cv=none; b=VzOHBX4cg9mmvzjaZt0Kg2wLlJC5BobEAhs+j8OrR8nL0cAdjrwhWF2BkDXFQkGTvjaCk9LrW6j41jgzipGuq0l5vdQuQ4plncfLAURB+LcTEs89Ez7EQCBK5K+WEy0uzRgyq0U5wPdf5erxOSE6tGp15hMHPxWPMusWh3DMW9NWMSAXfG7aBSVjbcROTnmvzPCLYdW1H92EqlNX7xfGQBPIIz454tnhMMRKpUNJSoohYteBEvTl7GwB+qpOKk3OgnEm/XKqUYsX+cTCpj4UjfsFKlmGzHzvDFiyk/V4It67x34o+2plXupcoj3YwSC4VWo+lV3SCIAFrEFKxEaddA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775328333; c=relaxed/relaxed;
	bh=URBiisKpj/4VMst9ixL/iGdh8JIZ79ieZDT72gpFozg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLpDceeAV1vKI/+9NniOrvVAK+MKrUrDTTSRbuEqZl6dYHKxnXFXubEhkm3CdsRZT3Khy66xmtZ2XqTTxA/EUPj1a9puH4OA1IerPwFmCr/Ml31/I93XzjmkRO9Ir1VGczT3S16WCiM9/f8sFH4ku30NsKIWll7jk01qgD9vMYiiYjXRwc9r/UiPqi+QYQaSAO8qvBZDYzTmv3q/O3cxIgdfyJbKZTMGd8K6XfwhWdSvYO+verv5Pj6Dr+0cCuzH9b79sk1InGjbWRJ2r5U4OHc9UfLt/3IS3RvNLOx16tmT5XaDZWY1eWfmU7pKJCFKjijuji0a+JUU6o0AszedoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cgCWUasD; dkim-atps=neutral; spf=pass (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cgCWUasD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 562 seconds by postgrey-1.37 at boromir; Sun, 05 Apr 2026 04:45:29 AEST
Received: from mx.nabladev.com (mx.nabladev.com [IPv6:2a00:f820:417:0:178:251:229:89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp4KP6R0Pz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 04:45:29 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4B4A10D7E3;
	Sat,  4 Apr 2026 20:35:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775327755; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=URBiisKpj/4VMst9ixL/iGdh8JIZ79ieZDT72gpFozg=;
	b=cgCWUasDQ68qUJFqRIMhHNay3iSRHeThhK5wB5F+Yu0gW1+hMlnFBaDThvyqJqBX3bl23k
	rCF3I1ZFCIlZlWYMRnryBW9/XqFiY8ZaT3lZdOUOLrUvm7+bbBdkwvwj+diePw8HUdIArk
	1tVhnWnExWVDjSH63hX2BkVERZxDPQwTIeYxM/fI5snh7iZjXLHNpnjCrW2ZOgSyTsc671
	wpTI9Gi3iHUvUXHB3ySpR1FiuiLR7zmO2qd5MVP/KSiQ8EmzsFNurujJjVR7yeANr9zTI3
	QQfbojaWIAvmmAdgXGayEceLytHAtp5uyEHYCDc/G0I8afSY8nX6/EcsuF38Fw==
From: Marek Vasut <marex@nabladev.com>
To: linux-sound@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK swap support
Date: Sat,  4 Apr 2026 20:35:00 +0200
Message-ID: <20260404183547.46509-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Document support for setting the Bit Clock Swap bit in CR2 register
via new "fsl,sai-bit-clock-swap" DT property. This bit swaps the
bit clock used by the transmitter or receiver in asynchronous mode,
i.e. makes transmitter use RX_BCLK and TX_SYNC, and vice versa,
makes receiver use TX_BCLK and RX_SYNC.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
V2: - Drop | from description
    - Update email, rebase on next
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 83b5ea5f3d70e..ba65b3f3d0662 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -162,6 +162,13 @@ properties:
       of transmitter.
     type: boolean
 
+  fsl,sai-bit-clock-swap:
+    description:
+      Enable Bit Clock Swap, which swaps the bit clock used by the transmitter
+      or receiver in asynchronous mode, i.e. makes transmitter use RX_BCLK and
+      TX_SYNC, and vice versa, makes receiver use TX_BCLK and RX_SYNC.
+    type: boolean
+
   fsl,shared-interrupt:
     description: Interrupt is shared with other modules.
     type: boolean
-- 
2.53.0


