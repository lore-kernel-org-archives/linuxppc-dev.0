Return-Path: <linuxppc-dev+bounces-23507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3112AC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQbN2K8Nz2xF8;
	Sat, 04 Jul 2026 06:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085776;
	cv=none; b=jtO/fwByV4zTCeEn9wfreFvaBK0MxCA8MtvjvCgTdu80yn7RGyMdyHK0m1fYi7x/+LcGZK+2ObvyGKCzDJSzDQIvC/wljMJj/MEqLemnzsPq/5Z7MqASqa+gv2NRAwGSX1qKIjhVHtZ40B5qv7JTptk9AmRdb86hBXJw9zz7GHdsNHcryU22D6t3XV2cIkh37ZNX1dGPFM4im1/J4D3WVEtUQ85P9U/pHX+e9jxbUiyMlgaJ/4Q9svYrdR4B6uQG6owN0VyNCECNnTSmkIdx5v1lkaFRBI3d8gzRaF+/XC5by+EYgc/JXet2szlocMX7yAYT25EDEBsLwhgu0c21PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085776; c=relaxed/relaxed;
	bh=AoKBaP8I7DCsUzrZ1dbqYwFIa5Zd5tckcAk7zMSaww4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGyLlGXsMuBXK2DiOLhplZk/3nwAIPWsAWpN5ybDXsW04M28XP0a050jXciij4S9e54ULernyne/TEBHVVavcjsyQrfp9rfuNt4iDS4zZ1udBm12e7rqxgMlJIJDvLYFWNx0ur+1Xgk4JGOyRs1ym6osmLZhsmoQLDSWhOx2oloASZWxMW66NDBX9b0xuYdCF1EOqvAC2GXU5EkRGlLe9snev8mnqt2/+87QiOOgV9+yc45JiYIo3jbuSMrHGFab6f2qjCOQjUQwspL33fm+TYDIaCaNHRcnlqE8LWSDwPTef90pf7+FYNhx00eVYqIsgYcGvU4RJpnHwQo7T1Ofvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FrT/rVHx; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FrT/rVHx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFC24R36z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:36:13 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 27B054E40C69;
	Fri,  3 Jul 2026 13:30:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFA8360300;
	Fri,  3 Jul 2026 13:30:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2B19104C9464;
	Fri,  3 Jul 2026 15:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AoKBaP8I7DCsUzrZ1dbqYwFIa5Zd5tckcAk7zMSaww4=;
	b=FrT/rVHxgt8LHTWxo9gj5m3P8VNmtKGnwgl6+ZQXHOMfykXdajkdqpJn6oTM69J9kFnCwP
	yIo6b92cVCUm4BeQ9Dxfex0an5r/r2wnUksOi2M28dCfxnZb9g67EQCdaun0sRsN+hNUXD
	Q29TiGdx7IGpy/rIOLooJsMj3L7WjlPQcMf1+CRf+HJaga2E2oINMffFbB8E+BAbMxe8xp
	TiSTmzt1iacoP+9DThkKFw2twDFVGAx9iswWGO92w2kwOosgwqU+0bxSroeKT2q56gEptS
	tsHkZC+IXwie4IaZJTaYMoF18wUI2NHV3tnJWcp7F82N68kecO7xWIjSOaOL1A==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:09 +0200
Subject: [PATCH 01/12] soc: fsl: qe: Add chained_irq_{enter,exit}() calls
 in cascade handler
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qe-pic-gpios-v1-1-6c3e706e27dc@bootlin.com>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
In-Reply-To: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=1181;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=nmg1nGhf5vcHeC3TZyEy0wOxu/Qq+uIbQ5ztZQX88WA=;
 b=W+UGoggbgRlZFApVLXokPSIY4M5hwAJDGBFxHS6Lu9RNR8FHFGDp2lBmmBNa/av9MoI/RPEl6
 CR+yR0S7BSZB6cq6yjTRBZyiro2uqv7j2EK31Xj3EfPG/xLvonX2cbD
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Wrap the cascade handler body with chained_irq_{enter,exit}() to
properly inform the parent IRQ chip that a chained interrupt is being
serviced.

Fixes: f0bcd784e1b76 ("soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
Cc: stable@kernel.org
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 9b0bba64e91e..73a77763210d 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 
@@ -79,7 +80,13 @@ static int qepic_get_irq(struct irq_desc *desc)
 
 static void qepic_cascade(struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
 	generic_handle_irq(qepic_get_irq(desc));
+
+	chained_irq_exit(chip, desc);
 }
 
 static int qepic_host_map(struct irq_domain *h, unsigned int virq, irq_hw_number_t hw)

-- 
2.55.0


