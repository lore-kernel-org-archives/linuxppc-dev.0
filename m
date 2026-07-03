Return-Path: <linuxppc-dev+bounces-23510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D3C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQbj3kzWz2yVP;
	Sat, 04 Jul 2026 06:39:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085812;
	cv=none; b=E63/V8lg/u3DzTzHN6Xd9GHT7m8s3D+hnW5dsI1klzln4kVOiTlp8KGN2p9UJgj7VQrFLHCvhs5mBImt/Cb59nW88bMkb9b2toCUzba/ne+5SmOrq7ke4CiiYQQ1h9nTFGp+qguF+1gcecQu+uAwa8omjebQTK5BXGpp8BPP2+b53k26I1loqkQI9dO9v/Rcyq3Iy9AFcxKgRML7gs2oQTwo0aqAxDPGu/1Nn7VrmSXEE1NA5d7TBRTEM1FfFtDMnMLC0kdm8wGgQseEiGX74FZFw46ccz9catjZZpTJ85lwCL4F/Jb4YrYMeTBbC7f8GlBvzVaoXsNMtvrhv8aY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085812; c=relaxed/relaxed;
	bh=DYiPuRvE6Nwnxm1ayjjfGRCixDjRGX9XFfBMaqcehNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmUH26BJFpEjuF2IBxycdbQRqZDev4Eic8w3Yi5KUpmNPK4Y374w4mV0jd8kXTTLt17hYqUxnsE/6WGNAG8smN1O8OV/pJ9P8BCAym5jp/duaObKkKt8f+4K5Ubx8dl4hkNiCUROzMrYis1nOJDUH4X5LayUGcECvMqVgU2Nd7WL+OlFdCyVMx4g8gLF6+h13QLJ8l6q1sef/vFbseIRJaAg/jXKZiwy4yTvTsTowrWl3U0Lig1nVJZLPExTK0/hHHu5vZn6OifLJrZPskQJJ9UhzCD+FIaqIiKSTixWZRCrPXzRbEoK4gYfXPT62MpJLA4vaGHDQ/F4Fm9Xpq0Bgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TPFDubIO; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TPFDubIO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFCm0Mp3z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:36:51 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9B913C49F5E;
	Fri,  3 Jul 2026 13:31:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB6FA60300;
	Fri,  3 Jul 2026 13:30:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2806104C95AB;
	Fri,  3 Jul 2026 15:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DYiPuRvE6Nwnxm1ayjjfGRCixDjRGX9XFfBMaqcehNo=;
	b=TPFDubIOOd12n77ZxYKru+sNA7xfghnI7Q5u0bwp4fAQxtAEOXWdCwOjBuUJ6H/lVmev8p
	At01ZX3W66RGbqXG6frB42AukdRbTiqgf9Ne3YC5tw1lFV81K1EcbqbimuX1VgsLsFsJWn
	RgL3pNdq/GHpFeAJ7uzls9MGOI5yNN76s/TXzF09XOf0LcnI4uvnQqgvmkfrEwZXtNhtng
	F9iI2hXF9H/6d6dtDGHA1MZRs9g1pnlYftrTHfaN8Tm4mLwIG1GTtftPFd6+jRiN/ninp7
	+/TeZllHOaEtIknkmkI0euNQrkn31XiYid5PZ4uVeX2/UaR7O6aPY0+apyckgA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:19 +0200
Subject: [PATCH 11/12] soc: fsl: qe: Remove useless struct member
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
Message-Id: <20260703-qe-pic-gpios-v1-11-6c3e706e27dc@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=1530;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=lV6ixfVQUU+h5OFc6ks1zgWp1h40IUo5QKv+Bi6rpy4=;
 b=GTd53N1L6mieV9LlVEep06QMzjN/ESane6rFL5nBaGQzPhkH7cvOjjXeGy3noJBEpv8mlEyJD
 09JzWIAKFqZATFJ0g3rY981zqaR5bWzMCKPO8dxQ09la/CBBR6EG1Kf
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The reg member from the struct qepic_data is no longer needed, since it
is now embedded in reg_base of struct irq_chip_generic. Remove it.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 1bf2af087b78..6cf23a721ff3 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -17,7 +17,6 @@
 #define CEPICR		0x14
 
 struct qepic_data {
-	void __iomem *reg;
 	int parent_irq;
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
@@ -144,15 +143,16 @@ static int qepic_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct qepic_data *data;
+	void __iomem *reg;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	d_info.host_data = data;
 
-	data->reg = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->reg))
-		return PTR_ERR(data->reg);
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	data->parent_irq = platform_get_irq(pdev, 0);
 	if (data->parent_irq < 0)
@@ -165,7 +165,7 @@ static int qepic_probe(struct platform_device *pdev)
 	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	if (!data->gc)
 		return -ENODEV;
-	data->gc->reg_base = data->reg;
+	data->gc->reg_base = reg;
 
 	return 0;
 }

-- 
2.55.0


