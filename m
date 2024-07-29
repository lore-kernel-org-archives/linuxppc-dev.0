Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B593C3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2024 14:32:17 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=duk3dFdA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXgmb5vvPz3cNB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2024 00:32:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=duk3dFdA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.193; helo=relay1-d.mail.gandi.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXgX83nLpz3cZ5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2024 00:21:28 +1000 (AEST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 6579224000A;
	Mon, 29 Jul 2024 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaXjEZNpUJnLB3rQBWEOUhhIwVLHy+ulcMNJJs5r5ug=;
	b=duk3dFdAoHtb+xzohumqm4Wi0pQgaItSUni7pV2kqg6o93Y4xJJ6xNdLRNclU4Oid4pLPh
	nT/o9v8wKGK8CkfaHkxY82/nYDvQNaprtuLkmVGhMP35XQrNPcnUNzkqZvQ2x0C45GMcim
	WYFpwl/c5EmI/OuBBgxNtlkyfM/tR5xDXjaCXRNuBeDzTzbna7dnY4wk75tjeTWFY2v2Vd
	ofigj+cFD0uQD8yrHShwrRqbJeKQ8kiONbc0+dd0mWo7MsMY/sAAWns4rEH4poXJ5o+xCk
	ZcQyVeP8sPgerFZnA5og2nKyjWB57uQTXrHPIMfC5wJT96dHwiKU9cKxfWGnow==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 15/36] MAINTAINERS: Add QE files related to the Freescale TSA controller
Date: Mon, 29 Jul 2024 16:20:44 +0200
Message-ID: <20240729142107.104574-16-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Freescale TSA controller driver supports both QE and CPM1.

Add the newly introduced QE files to the existing entry.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..1d32d38f2247 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9011,9 +9011,11 @@ M:	Herve Codina <herve.codina@bootlin.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
 F:	drivers/soc/fsl/qe/tsa.c
 F:	drivers/soc/fsl/qe/tsa.h
 F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
+F:	include/dt-bindings/soc/qe-fsl,tsa.h
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 L:	netdev@vger.kernel.org
-- 
2.45.0

