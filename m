Return-Path: <linuxppc-dev+bounces-29609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30506CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5wJH2m5qz2ylm;
	Sat, 17 Oct 2026 06:39:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792179599;
	cv=none; b=LzFMcaPevM1ZoghxlC3jfQNT8w5cag8YG/eZ3gsVnc5d62ZmjVAYvqQJbhtVvSaN8AeDyTW3OE2dN0qVirMzrdJMcocRxIQyc0ysEwWpig3rq6TOPfUg95c8ZzgTRz9CJ3RfJpJIDanqL0uhb9gBYZMb1cMCEWpi3IkHFcbzpCOcMNGvJ5U18RGmaDQAiKWhnvPki1AMLexhZAPdMq5PN1yM7Sy02PjYhEJnxeSpYdz8NIO601972lQPBvO4HgybRmRcx1Q5fCGT+/JK8HoGrs7bwiND57vTJOVUL631lwKzWHyLakAwJyYHcAuaVS2jt4fD86QSF6DZ9uU8FtZ2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792179599; c=relaxed/relaxed;
	bh=eA1Bhd/Xb+LpW3/jwkYBUSYVO6nQGoBeNGE5Gx0OvK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bt6n99tljoOfxC84UNp/Jq/0I+KFCF+iG6t8SAyRKoG3wRCfdYs84HaeciSpclSO2Q2vDU3PQ1U7P73JMK6lOEgWZlsGalFUSVU/FSEGFetFBjyIexb+ZXxa3E1bXh5Afen6vsIeHbg54xcEXSsSJCtEZcjmpZMPy3Y2AJYrMhn0EpMDASGOY0eVun+NpvjnoidpC1tE6u65ErkIdOXxGSnNnU/WKZTbLf99Yh4Hv9Fv4HtZkAFoxdei8duflRHrDvn94H/XulzU3ExfnPbbD1wgyHT4rMJydGM21gW/NkN/LxZcqlsw59Ramif8NYzRE3gvTs7lZfaEGVB2pK3AXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=KmKcW7WI; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=KmKcW7WI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5wJD5nnBz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 06:39:56 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 531F1105B53;
	Fri, 16 Oct 2026 21:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792179231; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=eA1Bhd/Xb+LpW3/jwkYBUSYVO6nQGoBeNGE5Gx0OvK4=;
	b=KmKcW7WITYcPBPo+5Ad0ac9Hr1oGhvkv+4Prnn2AViB/jsyv5tQoBYAMilSusmNF8EGh1x
	XpWhMKEo4DVJahSJOf8RAFwUs7gLxwQ+m9Qzis3k+Lpay5fsM6Zx5kJ8Mfy8O8SR1bId68
	hcpxTOc7BirR0r/ss7gC/BCxWEFeFpXDSylpY++tJqnNKtuNXjm6Ic11f/Xy/P42iLbgCU
	uE3SWYtbagPWfUwlYaZXVkWyJhRzpcKn7WE/xrnskoiTlFccsYyphGujXgqPDbXVH6APY1
	e1NLMUHMpXEvmKy1ZzRAZY+8FRHCs/lPMyg5jf3K202WClN6RB2Z1aonL6oVAw==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [net-next,PATCH 1/2] dt-bindings: net: enetc-mdio: Document optional MDC clock
Date: Fri, 16 Oct 2026 21:32:00 +0200
Message-ID: <20261016193344.115518-1-marex@nabladev.com>
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

Document clock from which the MDIO MDC clock are derived from.
While those clock are always present in every SoC, they are not
described in legacy DTs, make them optional. The clock-frequency
DT property is not described here, it is already part of mdio.yaml .

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: UNGLinuxDriver@microchip.com
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: netdev@vger.kernel.org
---
 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index 71c43ece82954..708d410187baa 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -31,6 +31,11 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: A reference to the input clock of the controller
+          from which the MDC frequency is derived.
+
 required:
   - compatible
   - reg
-- 
2.53.0


