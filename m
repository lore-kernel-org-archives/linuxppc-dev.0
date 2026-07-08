Return-Path: <linuxppc-dev+bounces-23806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB88DC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:17:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDX04bj6z3c5X;
	Wed, 08 Jul 2026 20:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505776;
	cv=none; b=oAewt/ctJhTBpX84gsZBA85zN1VJ2l7+uVzXRNzJ+VSTa+1xEGlaRe3q7CKgMRKyYxL8Fu8WhlrnCcae3v+o2xjkFo/dRL1K4X3Xvcw+1P0ESkOrAEtv96IPhHKo38QUXh9anSEYJpqvn5kYBfKDWrfmmzAiGsJfjhVYi/727tbwT+/rY3YZu4KGYm+/P8z6/ZTgPNszqG6YIqflT7T2Spg6Of4fPKF+XI8LsPGM+0XZuw8cGGMY14EMQgSpuOXFEccgnijGCkT1FgIAf8tL4YKCO1CcSzH+6PNKNApy6uRmQmym19AJ/YIhAbVc9UtM1hQwzY4i2lgCFE5NaxufIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505776; c=relaxed/relaxed;
	bh=n9bPyS/0uNi6wXJqgrGX5cVcsYuuWD9wtysaxkT+Dt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwtJ2fJec6Uxcvnec7tf8ZJvK2Upr952VL6chBDc8uFgaXPFCFh6FGBeqYs1xb3cbbb0RCA7lRQexsBcPWqlN7oOAWX6vTCJ2JwlSqNdGd9NEqQcZXZ76IjpjpbBxb+biHJLRmftOVzapxAPxVPlDhObTQIUQ38MYtWGusmwyEBLzn6g3WUiqKg8drFlLl2OGNwp3k4uKuLDqtqcGCAxJmfahy7Wr60JXYoGkXk5iZ7akyubYSjbq0zhrjpmmJ1z77a/hfF1kOzou1nOJ9A9SrTHvuw4WkeKT4u7f0IBBo4Dw44PM6yE/uMhNhjL1TXzLeF+dQHhCKASgHKOu1SXcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zaicWlvS; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zaicWlvS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWz6ThXz308H
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:15 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 95C691A0EDC;
	Wed,  8 Jul 2026 10:16:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62F1A60337;
	Wed,  8 Jul 2026 10:16:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E1FF11BC3442;
	Wed,  8 Jul 2026 12:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n9bPyS/0uNi6wXJqgrGX5cVcsYuuWD9wtysaxkT+Dt4=;
	b=zaicWlvSnJ8KaBt2L3nIl6XSz2ynYRpyDz3pmG3CzCaCyM/Tww6m7GGulF4nWE64cWdbXC
	3bH8svQman3+sIlahuSZhWXrGMOFEKDPGqF2QjFb36JARhjDyLldiNnHAQd1xmr1GVPNuu
	6DCB6entbZIOGH7sXnljsiI/VdLuilBc1EZehSj4Ngmu1h7fbKGhEtbfFH1EIzo67uiIzG
	p5HvcnBYLT4i9Dv9fISCE4R5i9F8WVnWwqK/S+NWUs4k+GCAYDP3SBfnz3i7cAU6EXIlfS
	/4+iWAahrr/33ONRABTFvDK7BpeiYWqXyJE3Lv+eoa4nNIt0Ff9/vkV2FLpKQg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:23 +0200
Subject: [PATCH v2 10/10] soc: fsl: qe: Add support of IRQs in QE GPIO
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
Message-Id: <20260708-qe-pic-gpios-v2-10-1972044cfbd1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=2410;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=uU4iuMohvv17IiIgOuFnj9w2k+ZovOe5eFIHeMSDjt4=;
 b=/DxI+WVs9+OZyT+vFropDWk4THWwrhFGWAHwsSAJ8i9eNw71s6vgOdatacAE9eNosgwjKitj0
 ILwZaxa6CxbA8hhMVzdimCjePID/pTjnSN5w2t2vMJldkgoJPziHcdY
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


