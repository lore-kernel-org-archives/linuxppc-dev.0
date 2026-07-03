Return-Path: <linuxppc-dev+bounces-23509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E929C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQbZ3J2vz2yf5;
	Sat, 04 Jul 2026 06:39:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085812;
	cv=none; b=UiRMT4mAzILqhJ6fZSTS53NdVF1fT2rU2a2oIssSMCNkSZfv9v3eGAfK9Gholt8T/H429H4EGq5nrZLn8X+ILo8UjR4LcWjpNSzbGTUGchbgNM36MySYMQZs0cr4QQJ7Tkd5cZiD0qUkpCvUZ8fwwR/GC1UOC6MYEaiqcTar5jA/iAEf9ZaKYxEzpZb+m8e6dIL2RYasLgNsXqu2NmVujEEAF4P5rcuNXfC+oz7JFxa+sPth5RKBZ+foTttRxXSP2yllDuGXydwW5I1CR+c9Hp09Bw7xJj+VwmfuUkXQqq3DnCKKWI/ZVC5h5XCIkTftkZ7e6Q7YQIXPmUGxn5CG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085812; c=relaxed/relaxed;
	bh=n9bPyS/0uNi6wXJqgrGX5cVcsYuuWD9wtysaxkT+Dt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6eAjjQWMafS5Xulq/AlgTnZsHCGs9zZ3V7Hb3BhlHn6gDM6MtKDiqmu1GBUEFgvpNFXMKfE16IlDySn/Pb1z3NMSHW/hWF1D94R47Tf5sKdKNeqEspIJ6X0m1Ij9HSED7+VHjXSa8EuAcHPlkQkMeH0BzD2LjwBU5P84DT/mzHjeGxoDfAoIffSKQRNHbfvk2EXOugu4IZZA30b6V/idTyg9VUnpqgleAm5jnOfBRGZYjFc8VocWQPgTuafNaAt93bU+DWWwio0oy8a5htpZ9JZSKZqWvVCM5WZP/CCF2Nno3uCrkZx2agCwMBcIub8717L1ZaA54WUYIOgZ+0V1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QXaAzfOJ; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QXaAzfOJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 374 seconds by postgrey-1.37 at boromir; Fri, 03 Jul 2026 23:36:51 AEST
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFCl6Dxkz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:36:51 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C94EC49F61;
	Fri,  3 Jul 2026 13:31:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C24660300;
	Fri,  3 Jul 2026 13:30:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 388B5104C95AC;
	Fri,  3 Jul 2026 15:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n9bPyS/0uNi6wXJqgrGX5cVcsYuuWD9wtysaxkT+Dt4=;
	b=QXaAzfOJIpi/uOaJ6u/UgTYwunCe5bV9Fm7RPLZs4LjoS8ZAO5GapEmJ1pDc5hjTTFtDDa
	5cTLLZbs2gsqgYBMzkGY2BaWUX7P0czD+wbLJD/U/5lTtF4MDwOunIknti8z/6IsFTWiWe
	otFTFFdXt3R0jU8l91bAzGqXpT+jnOdhHLbY0HZPQZR3BexF9pwGnp7IoKKmX9/66v2XTS
	cx3VBR/pvXj+w0K3umrGdIlSTUScE3CPltrvv0MXKGUPPi4cweL+zLNQ8Ad193+0EgMBc6
	Hmj1oeQpolqdXNAzThanud+z8Oqh14OBmSb/VqtyM5E6MdC0DOOJZLbwsfSA8g==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:20 +0200
Subject: [PATCH 12/12] soc: fsl: qe: Add support of IRQs in QE GPIO
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
Message-Id: <20260703-qe-pic-gpios-v1-12-6c3e706e27dc@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=2410;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=uU4iuMohvv17IiIgOuFnj9w2k+ZovOe5eFIHeMSDjt4=;
 b=hNx7S/9Lk8zefyWMtjb/HRlT/T9Bq5wS3kVedzZyJ1n5LRDAihpruvvGSJm5Li7vBBareHst+
 bqggNYIbt96CsUzNAiJy5UEsQIIQkuAgz6vMaGlCucqiEWHZcqkKCyJ
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Some QE GPIO pins have an associated interrupt line in the QE PIC to
signal state changes on the pin.

Because the GPIO controller does not perform any interrupt handling
itself, a nexus node (interrupt-map) is used to map each GPIO line
supporting IRQ to the parent QE PIC interrupt domain.

Add the to_irq() method in the corresponding GPIO controller driver,
that uses the nexus node to perform the translation.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/gpio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 66828f2a3577..f8919642f40d 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 #include <soc/fsl/qe/qe.h>
@@ -23,6 +24,7 @@
 #define PIN_MASK(gpio) (1UL << (QE_PIO_PINS - 1 - (gpio)))
 
 struct qe_gpio_chip {
+	struct device_node *np;
 	struct gpio_chip gc;
 	void __iomem *regs;
 	spinlock_t lock;
@@ -135,6 +137,29 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
+static int qe_gpio_to_irq(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct qe_gpio_chip *qe_gc = gpiochip_get_data(gc);
+	struct of_phandle_args oirq;
+	struct irq_domain *domain;
+	int ret;
+
+	oirq.np = qe_gc->np;
+	oirq.args_count = 2;
+	oirq.args[0] = gpio;
+	oirq.args[1] = 0;
+
+	ret = of_irq_parse_raw(NULL, &oirq);
+	if (ret)
+		return ret;
+
+	domain = irq_find_host(oirq.np);
+	if (!domain)
+		return -EPROBE_DEFER;
+
+	return irq_create_of_mapping(&oirq);
+}
+
 struct qe_pin {
 	/*
 	 * The qe_gpio_chip name is unfortunate, we should change that to
@@ -299,7 +324,7 @@ static int qe_gpio_probe(struct platform_device *ofdev)
 	qe_gc = devm_kzalloc(dev, sizeof(*qe_gc), GFP_KERNEL);
 	if (!qe_gc)
 		return -ENOMEM;
-
+	qe_gc->np = np;
 	spin_lock_init(&qe_gc->lock);
 
 	gc = &qe_gc->gc;
@@ -311,6 +336,7 @@ static int qe_gpio_probe(struct platform_device *ofdev)
 	gc->get = qe_gpio_get;
 	gc->set = qe_gpio_set;
 	gc->set_multiple = qe_gpio_set_multiple;
+	gc->to_irq = qe_gpio_to_irq;
 	gc->parent = dev;
 	gc->owner = THIS_MODULE;
 

-- 
2.55.0


