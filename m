Return-Path: <linuxppc-dev+bounces-23517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F6C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQcY1YQhz2ygL;
	Sat, 04 Jul 2026 06:40:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085951;
	cv=none; b=LfaM3m6y9/e6olSK09+cnoOLwTbPxdceWsf3YzvDA2f6kWuqAQWlJ0Dp/IGaJkabWXjsbL0mFP7RgY/EBIJpxTLSq0rsnmZ4/fUv+oUfFnZ/hy5aEOBfADJF+T4eaPVjLAUw/SLcrjeaLKbSI/Gv0avgVDybbEPiZ9L1alfGCEPhauLDhqFdaM3xx6HOzfz8wDRTpR/aSogtqyHniKMttGevDYUamiE1QDr0pZXsNwaKuIA5I0AD3rsgtukm4KpaXdj45xo14gwPUs9rvaMu+nBgxaeTHT8efjDXW8R/Gr5mFxXN6wV05HM46nOvs9C1GYXFIDI1Kx2+TEsBsEL1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085951; c=relaxed/relaxed;
	bh=x0twSIpE7m4cPj3Ig88g1zIACZePCnPv6bKNCD++fr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxfHS087ausaTlgDnqzb8Gh7j2ruoZLj/BnHaHjkibBp44Kls6vSkhfUnEpIUYrFsSHbnAVgSQLXlrCSlr9ZI/JHVgx8N2l/xCZbALpRpG3keYR4exm9kWlmkHlMc/V3lYBoXhyHIwnLM2ZZuZsZn1QGre5EWEk7PbTzwVnva3O8TA9Ty8s3+veHXiq7ITMpbwTN/us4mT3y7NwEk25FLSSGkmDgfsoYUAsrk8hKflWlv0pfK8ao6YFwQqO2tzSn0HmcoLl1/Xaqn4mhSLSxDWe+1+usQCV6EoqiMrEugVfJ43zqQDpXb/25jUR9mxre3oOfOr7H5eYgGeky47Pqbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uS9Up6Nh; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uS9Up6Nh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFGR0xjNz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:39:11 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F305A1A0E28;
	Fri,  3 Jul 2026 13:30:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5F9E60300;
	Fri,  3 Jul 2026 13:30:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09D26104C95A9;
	Fri,  3 Jul 2026 15:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x0twSIpE7m4cPj3Ig88g1zIACZePCnPv6bKNCD++fr8=;
	b=uS9Up6NhEfglz7sia9B2B1y50iyxi4yn1pKfYp0g3FKsaHuOB/ETRKhSTX+Aa83ZKqUbKz
	TWt/TopuxusBfVwkb4gamT0LQ2CaCt5W/Eb1VzC5RdUkRo9n0hrqexHsIEsfQ8k2WtDEHu
	GubKMy0XTbuOLRiamCv7DcCotTR2K9LgGhv930WQOBGm8a47xxET1GjhykWSyAabZ0nOr1
	9B4Bq4Bgd5w6OFbzxyURdObSxsbRspPJbsDYoAoAXv55Odadctm86cDUkhG1KCh++NNLIv
	6MOwL0TTpxcaZBg24553aX+fwXbaGOdEInJyJpqlPrJt0jrzRO1tqwoANFqxtg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:16 +0200
Subject: [PATCH 08/12] soc: fsl: qe: Convert to generic IRQ chip
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
Message-Id: <20260703-qe-pic-gpios-v1-8-6c3e706e27dc@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=6648;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=KQ/8zR92O33jF8u7KItWauZlD5mu9z5Gq4G8xVUNdy8=;
 b=85BWRIYuoXfDZLoVu0OK8zlBEh3fbHEO5zRJByLQkj0tGo2xkWJXC01UjyzuRp/rGU3daP2h0
 13nPcFA5bk/BxtAcGA2K93qcsHjBQnEEvHZLgvImuiJkRt/FcnWIVp3
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The generic IRQ chip framework is available to handle IRQ chips. Using
this framework for the QE interrupt controller allows to simplify the
driver. Indeed, the framework internally handles operations coded
directly in the driver.

Add a select dependency to GENERIC_IRQ_CHIP in the PPC platform Kconfig.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 arch/powerpc/platforms/Kconfig   |   1 +
 drivers/soc/fsl/qe/qe_ports_ic.c | 103 ++++++++++++++++++++++++++-------------
 2 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index c4e61843d9d9..b0b3a80f8cde 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -232,6 +232,7 @@ config QE_GPIO
 	bool "QE GPIO support"
 	depends on QUICC_ENGINE
 	select GPIOLIB
+	select GENERIC_IRQ_CHIP
 	help
 	  Say Y here if you're going to use hardware that connects to the
 	  QE GPIOs.
diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index c8b73b0aa233..d022aa224f6d 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -20,63 +20,65 @@ struct qepic_data {
 	void __iomem *reg;
 	struct irq_domain *host;
 	int irq;
+	struct irq_chip_generic *gc;
 };
 
 static void qepic_mask(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
-	clrbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
+	clrbits32(gc->reg_base + ct->regs.mask, d->mask);
 }
 
 static void qepic_unmask(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
-	setbits32(data->reg + CEPIMR, 1 << (31 - irqd_to_hwirq(d)));
+	setbits32(gc->reg_base + ct->regs.mask, d->mask);
 }
 
 static void qepic_end(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
-	out_be32(data->reg + CEPIER, 1 << (31 - irqd_to_hwirq(d)));
+	out_be32(gc->reg_base + ct->regs.eoi, d->mask);
+}
+
+static void qepic_calc_mask(struct irq_data *d)
+{
+	d->mask = 1 << (31 - irqd_to_hwirq(d));
 }
 
 static int qepic_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
-	unsigned int vec = (unsigned int)irqd_to_hwirq(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
 	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
-		setbits32(data->reg + CEPICR, 1 << (31 - vec));
+		setbits32(gc->reg_base + ct->regs.type, d->mask);
 		return 0;
 	case IRQ_TYPE_EDGE_BOTH:
 	case IRQ_TYPE_NONE:
-		clrbits32(data->reg + CEPICR, 1 << (31 - vec));
+		clrbits32(gc->reg_base + ct->regs.type, d->mask);
 		return 0;
 	}
 	return -EINVAL;
 }
 
-static struct irq_chip qepic = {
-	.name = "QEPIC",
-	.irq_mask = qepic_mask,
-	.irq_unmask = qepic_unmask,
-	.irq_eoi = qepic_end,
-	.irq_set_type = qepic_set_type,
-};
-
 static void qepic_cascade(struct irq_desc *desc)
 {
 	struct qepic_data *data = irq_desc_get_handler_data(desc);
+	struct irq_chip_type *ct = data->gc->chip_types;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long event, bit;
 
 	chained_irq_enter(chip, desc);
 
-	event = in_be32(data->reg + CEPIER);
+	event = in_be32(data->gc->reg_base + ct->regs.eoi);
 	if (!event) {
 		handle_bad_irq(desc);
 		goto out;
@@ -89,33 +91,64 @@ static void qepic_cascade(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int qepic_host_map(struct irq_domain *h, unsigned int virq, irq_hw_number_t hw)
+static int qepic_chip_init(struct irq_chip_generic *gc)
 {
-	irq_set_chip_data(virq, h->host_data);
-	irq_set_chip_and_handler(virq, &qepic, handle_fasteoi_irq);
+	struct irq_chip_type *ct = gc->chip_types;
+
+	ct->regs.mask = CEPIMR;
+	ct->chip.irq_mask = qepic_mask;
+	ct->chip.irq_unmask = qepic_unmask;
+	ct->regs.eoi = CEPIER;
+	ct->chip.irq_eoi = qepic_end;
+	ct->regs.type = CEPICR;
+	ct->chip.irq_set_type = qepic_set_type;
+	ct->chip.irq_calc_mask = qepic_calc_mask;
+
 	return 0;
 }
 
-static const struct irq_domain_ops qepic_host_ops = {
-	.map = qepic_host_map,
-};
+static int qepic_domain_init(struct irq_domain *d)
+{
+	struct qepic_data *data = d->host_data;
 
-static void qepic_remove(void *res)
+	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
+
+	return 0;
+}
+
+static void qepic_domain_exit(struct irq_domain *d)
 {
-	struct qepic_data *data = res;
+	struct qepic_data *data = d->host_data;
 
 	irq_set_chained_handler_and_data(data->irq, NULL, NULL);
-	irq_domain_remove(data->host);
 }
 
 static int qepic_probe(struct platform_device *pdev)
 {
+	struct irq_domain_chip_generic_info dgc_info = {
+		.name		= "QEPIC",
+		.handler	= handle_fasteoi_irq,
+		.irqs_per_chip	= 32,
+		.num_ct		= 1,
+		.init		= qepic_chip_init,
+	};
+	struct irq_domain_info d_info = {
+		.fwnode		= of_fwnode_handle(pdev->dev.of_node),
+		.domain_flags	= IRQ_DOMAIN_FLAG_DESTROY_GC,
+		.size		= 32,
+		.hwirq_max	= 32,
+		.ops		= &irq_generic_chip_ops,
+		.dgc_info	= &dgc_info,
+		.init		= qepic_domain_init,
+		.exit		= qepic_domain_exit,
+	};
 	struct device *dev = &pdev->dev;
 	struct qepic_data *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	d_info.host_data = data;
 
 	data->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->reg))
@@ -125,14 +158,16 @@ static int qepic_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	data->host = irq_domain_create_linear(dev_fwnode(dev), 32, &qepic_host_ops, data);
-	if (!data->host)
-		return -ENODEV;
+	data->host = devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(data->host))
+		return PTR_ERR(data->host);
 
-	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
-
-	return devm_add_action_or_reset(dev, qepic_remove, data);
+	data->gc = irq_get_domain_generic_chip(data->host, 0);
+	if (!data->gc)
+		return -ENODEV;
+	data->gc->reg_base = data->reg;
 
+	return 0;
 }
 
 static const struct of_device_id qepic_match[] = {

-- 
2.55.0


