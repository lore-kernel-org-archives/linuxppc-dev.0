Return-Path: <linuxppc-dev+bounces-23804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06660C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWv1knXz3c3x;
	Wed, 08 Jul 2026 20:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505771;
	cv=none; b=e3iyzmU72pwMSy4kw+voeQpO3OHvWKnXSgvfUXH5sKXNLwxti2wTJ5hiT4Vlq37zUnsx5FgfPxyBjUrds9OooDwTKUZbsj7kQ+iNMwxxCjpd78EGnhQiJ2t0XXYWaT/+4UrjFNyH+/Dt7UFaGn53+BUKBur9ZIP1TTq7juFPtFsx4Kje3GLZkXjQnkqstulZOnJqjcMxBGwHKztUuWBts3bS3Dug42Zn/cIrAYnwznHSkxax+fJauPL4vaiyaTctZIhTGO83OrRc1gefBWshCFHtHKoAzq17lffLkOkA33UwNJHnEjoJ9F8O1LgCf9cJ9uRDPaU3LiEcNl0Y/Y2x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505771; c=relaxed/relaxed;
	bh=Qadg2bKcBCZki//uobbEy5MLY0VFB6w3J0kBGnJdHgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+wQ/uqDA8QfYke5qcndpU4bAfa304Usyul1dqrKRjKJY2ZLZY2Sx6ud9ygEF39vCT+cfLDTzkiv/PRr8UEsTSWVB+AnrMH+5AP8C9Zj220lqFURWuUwEBfJfW5OM4//aiXMztuIXsb9AUoaRebTYMU97FLNLnpJP267qDsReCDOAgaZ9m2rWAj9hluAGd1vSbtGyHMr9gwvMDGClyuEyku3n8/g9NwuY/YZvJ8P0AB1zjE0avT1UMSZi7lNejDh5/30YiOkRvfRffvwGwzKlQV/wNHrgc1ltb5arCkhN/y1ONQf1dHpNJmls7tEJp6vqftp1vw8M7YFk7MiN9i8cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LLEBkXRz; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LLEBkXRz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWt1xbNz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:10 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E2B681A0EDD;
	Wed,  8 Jul 2026 10:16:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B719160337;
	Wed,  8 Jul 2026 10:16:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E39F11BC3441;
	Wed,  8 Jul 2026 12:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Qadg2bKcBCZki//uobbEy5MLY0VFB6w3J0kBGnJdHgY=;
	b=LLEBkXRzNYn0Bk7u5ijbpYCGog03MdICeT52N+u9/QVGAA2EdTr75iO5F6KoSVflK9W92v
	G5kJ4SzIiBA+klFpg2Ix/NRD+cDPmsAUZGEdlfhEoX8hyDYLAoLiFjQyvYEkQfMp4SNzjh
	6AWB8uUVe6MtCo2B3mt6gsg63QzgPc/YgDLU7+6jRmeLH5uphv9GePaGXdrh1fBbwZFYnF
	wn6JwewOURipCkgpHNZAf/Es1fIutSJJHq7AUlNPgHdhYRN7eUyAluy93skTjddAJ4MCBN
	0vulpIL26Pohw06Sg9Ovn/g+upnptfaRZvTAoC/dgKaXvsoNKcanbsORpTANYg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:21 +0200
Subject: [PATCH v2 08/10] soc: fsl: qe: Convert to generic IRQ chip
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
Message-Id: <20260708-qe-pic-gpios-v2-8-1972044cfbd1@bootlin.com>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
In-Reply-To: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
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
 Herve Codina <herve.codina@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=6809;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=2fU5qgzI067+YKsW5U6XhpL6PROn/SmAkPi2/0Y1X4E=;
 b=Sogx0Kfqnx0YsIBHXourwPbb83lbMeVKM7SwyB95fn0masdYi5WdafxfWg3vMq7aDRYxYN+Ts
 siKndxjXUCLDjFNvbYcABkEJvsre2fhsuTXSrarHEMnpYQnarU8t93K
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The generic IRQ chip framework is available to handle IRQ chips. Using
this framework for the QE interrupt controller allows to simplify the
driver. Indeed, the framework internally handles operations coded
directly in the driver.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/Kconfig       |   1 +
 drivers/soc/fsl/qe/qe_ports_ic.c | 116 +++++++++++++++++++++++++--------------
 2 files changed, 76 insertions(+), 41 deletions(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index b35a8fd30ebf..87cd1662e168 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -71,6 +71,7 @@ config QE_USB
 config QE_GPIO
 	bool "QE GPIO support"
 	depends on QUICC_ENGINE
+	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	help
 	  Say Y here if you're going to use hardware that connects to the
diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 29f4334db5a0..4f6b75439f9f 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -18,107 +18,144 @@
 
 struct qepic_data {
 	void __iomem *reg;
-	struct irq_domain *host;
 	int irq;
 };
 
 static void qepic_mask(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
-	u32 val = ioread32be(data->reg + CEPIMR);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 val;
 
-	iowrite32be(val & ~(1 << (31 - irqd_to_hwirq(d))), data->reg + CEPIMR);
+	guard(raw_spinlock)(&gc->lock);
+
+	val = ioread32be(gc->reg_base + CEPIMR);
+	iowrite32be(val & ~d->mask, gc->reg_base + CEPIMR);
 }
 
 static void qepic_unmask(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
-	u32 val = ioread32be(data->reg + CEPIMR);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 val;
+
+	guard(raw_spinlock)(&gc->lock);
 
-	iowrite32be(val | 1 << (31 - irqd_to_hwirq(d)), data->reg + CEPIMR);
+	val = ioread32be(gc->reg_base + CEPIMR);
+	iowrite32be(val | d->mask, gc->reg_base + CEPIMR);
 }
 
 static void qepic_end(struct irq_data *d)
 {
-	struct qepic_data *data = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-	iowrite32be(1 << (31 - irqd_to_hwirq(d)), data->reg + CEPIER);
+	iowrite32be(d->mask, gc->reg_base + CEPIER);
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
-	u32 val = ioread32be(data->reg + CEPICR);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 val;
 
+	guard(raw_spinlock)(&gc->lock);
+
+	val = ioread32be(gc->reg_base + CEPICR);
 	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
-		iowrite32be(val | 1 << (31 - vec), data->reg + CEPICR);
+		iowrite32be(val | d->mask, gc->reg_base + CEPICR);
 		return 0;
 	case IRQ_TYPE_EDGE_BOTH:
 	case IRQ_TYPE_NONE:
-		iowrite32be(val & ~(1 << (31 - vec)), data->reg + CEPICR);
+		iowrite32be(val & ~d->mask, gc->reg_base + CEPICR);
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
-	struct qepic_data *data = irq_desc_get_handler_data(desc);
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long event, bit;
 
 	chained_irq_enter(chip, desc);
 
-	event = ioread32be(data->reg + CEPIER);
+	event = ioread32be(gc->reg_base + CEPIER);
 	if (!event) {
 		handle_bad_irq(desc);
 		goto out;
 	}
 
 	for_each_set_bit(bit, &event, 32)
-		generic_handle_domain_irq(data->host, 31 - bit);
+		generic_handle_domain_irq(domain, 31 - bit);
 
 out:
 	chained_irq_exit(chip, desc);
 }
 
-static int qepic_host_map(struct irq_domain *h, unsigned int virq, irq_hw_number_t hw)
+static int qepic_chip_init(struct irq_chip_generic *gc)
 {
-	irq_set_chip_data(virq, h->host_data);
-	irq_set_chip_and_handler(virq, &qepic, handle_fasteoi_irq);
+	struct qepic_data *data = gc->domain->host_data;
+	struct irq_chip_type *ct = gc->chip_types;
+
+	gc->reg_base = data->reg;
+
+	ct->chip.irq_mask = qepic_mask;
+	ct->chip.irq_unmask = qepic_unmask;
+	ct->chip.irq_eoi = qepic_end;
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
+
+	irq_set_chained_handler_and_data(data->irq, qepic_cascade, d);
+
+	return 0;
+}
 
-static void qepic_remove(void *res)
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
+		.name = "QEPIC",
+		.handler = handle_fasteoi_irq,
+		.irqs_per_chip = 32,
+		.num_ct = 1,
+		.init = qepic_chip_init,
+	};
+	struct irq_domain_info d_info = {
+		.fwnode = of_fwnode_handle(pdev->dev.of_node),
+		.domain_flags = IRQ_DOMAIN_FLAG_DESTROY_GC,
+		.size = 32,
+		.hwirq_max = 32,
+		.ops = &irq_generic_chip_ops,
+		.dgc_info = &dgc_info,
+		.init = qepic_domain_init,
+		.exit = qepic_domain_exit,
+	};
 	struct device *dev = &pdev->dev;
+	struct irq_domain *domain;
 	struct qepic_data *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	d_info.host_data = data;
 
 	data->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->reg))
@@ -128,14 +165,11 @@ static int qepic_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	data->host = irq_domain_create_linear(dev_fwnode(dev), 32, &qepic_host_ops, data);
-	if (!data->host)
-		return -ENODEV;
-
-	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
-
-	return devm_add_action_or_reset(dev, qepic_remove, data);
+	domain = devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
 
+	return 0;
 }
 
 static const struct of_device_id qepic_match[] = {

-- 
2.55.0


