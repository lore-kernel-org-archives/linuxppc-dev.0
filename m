Return-Path: <linuxppc-dev+bounces-21837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC52CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzG73rjXz3btT;
	Tue, 02 Jun 2026 15:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376527;
	cv=none; b=Fc7gFOxsioNmApa7uQoLBOchvXJjEFvSoONCOJ+y1cpSGQihL5JyB4xC0t7Ef9rhZGuuFKtHAVTAMSFfwcUKw7wRVKibU0Eq0XJTLMbvG3l+/elmjlJ0ZCFnBKCR9VX1L8IJvRv5bLNmIzGFL0TPZJCPYnKH5o+ui84/D4AphhH4tNKRGQCUHL3fNpnKxLB88ptU6zKuGT4db7E2AXNlTjFFVP9LBFBKOQpLOm9v8k3TLfL1VAmjvI2SUMoanvryct3LtuQagLTmw9u8FSyNGIsc+z4VSNBW6iFgq6wO/SLl0AblG2Kqd24NZIYOlBUooVzox44VB0EfOj2rhvW6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376527; c=relaxed/relaxed;
	bh=gM2FIUryBRQiEGRMHtydSbfKjl7tClJ0BToQ5C2TWsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToUSrjTZP6/CBc80pp6PaY+i39g/ugyEcxF+ZNEvwcX7Ik4iw7g5ehUOJFC6KmL2GKV3xIKpiHNc0OO53avi/q24xmeo10ddZJPf9Eh6vmnsqaxDqqMEMgVJUhRcOSWNLcXr7Ero20ju8ZLZ/dVUFlFLREs9IfST98yrGHDtXsGrliPkp9PcXjCi3Ix3YzOsVcnsMfgiMMo4b4EvYvY9tH2QnFr6TTKUjdKcPpxAaw3akwbJ7LEwanZDjqCE4QGfP/rMVmh4tZ9VgK8gzrTprH25qjUpWmK5wuvo4S0YPe1VbuuLMN8hR6V/bK2YDydtFKGTs6UVADXGlRl9/UDL3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6VqMevs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6VqMevs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzG60mSnz3btq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:02:05 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36baec934b6so2143636a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376524; x=1780981324; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM2FIUryBRQiEGRMHtydSbfKjl7tClJ0BToQ5C2TWsg=;
        b=C6VqMevsdYNWFZiRGkzU7JjGt0eg7A1efEGDhlqGiYWWfC6BJ57wNIs4912ecXgLjL
         QrcrWMBjC9OMcFUWzSJfvEcceyuGT5GBiSvNfai4QYwAett3oDImrANnMFV1AVYi/QbD
         K/Y3HilP8JOS3z+v+yLn+607EErNf60E7F3GkKKe1Haj5MQR4xz322DxRn61Um18RIOC
         MT3hD7jB9zhIIMb6Xx5+DlN6dd7SRvIBiTYh+B6SVIuO774pfM7/1X61kQblC+mn88Ln
         HBsLrpVHhqOr/9SxoSSGUVXdYjyw90Bebz2EkDM1X/im/1VdNyPtt6EuhLr1H4o2XXSR
         RByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376524; x=1780981324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gM2FIUryBRQiEGRMHtydSbfKjl7tClJ0BToQ5C2TWsg=;
        b=cpV5LXfQWYyjwePCUl1BqxjS6v8LHGojQ0VA4AXkKD18JoVsZ9vXZfhiOr1JdDIQ0E
         l6SznTDl0mb9/dwJ1jfRNAa8k5G0gnc8zurk6pR7drujluMx4AI94Cz4DRcKmCkazBc/
         HPrVPVYOjgFr8CJd7087Mcho72FDCfcwYEHomOugVc6Iii2i8ryzuGZ3lXsFSvqvyMQM
         cx5Q09ILxLUX2/iTI3U7LeJXf3hPTpuKQ51TxyX5VF474PhTJcDS3PZyEJB8XSHwlTHq
         JnJgsSeb7IldD/ZdSFukrFxRM1bhOUOQ1vJe9slqHDhxlgLtfLQgYPmGDRqL6IL5lD8p
         6s+A==
X-Forwarded-Encrypted: i=1; AFNElJ+06mI4UZb+gJzlCpl2IekCRhxJigf5LgSHRW3EW34pBjAr1F9rKkYlV+v9wyjYvSdQ7vgDgVSIckXpLxE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxPlZkq9gooinKK0+Fy6jmqXhY0fIdiUNNIck4VpsT/01CI4rQ
	B9KQ1LsQW0CnVfS3tMY/F577VREFWkIHzyOXp3Qa3PMWFsElGERFYbve
X-Gm-Gg: Acq92OFy7b+D347LROdt7USvmpI3NFjt32GA0a7O2FybdahA9gDj1Dgmq09mPhruUxz
	MEi3CxkqEY/m2ajyLLAhm41ytjEX9YRluejBly3NhoCUYa/HjJpQTlCXoF5NnX/9w1eyYQEHXHq
	u5Et8qWjfQvoNQf6MQBmXAdCeKN8cQ1hj2SkuirDx8sDX8VxdCz3gGl3pA58xUvuuywcoTPKWvt
	ibBDtRLk5JCmltfvfb7CwaWI/s8b8AxBgKcJozLJRDjFN1LqTwPjK2jbq/tVr2aKjyDV+0m7EHK
	FjXXRkQdkaBPVg+WgT4aYl+Zqvs1YrtSrTpGg0atz/Zzpje+LJIcv5N/SKbKVzyluqgL5YxEWHC
	KgeduJYVNN0HHzSP3zdpYJv0lAJ+2HQo9j+a2P8h5lZl138yXX/R2CVsKYe+y3mO4veX+v3CMWV
	sg7CG76CyTt3zJzqT8+YnzIuXjverSZjICjoejX7WQG20xRlCcjQ2pnKCi+uQ2AHfJ27yoIhPwn
	gGpDA82dlcisYp8JGkVSnMgoVcbVnSw8s968wNzr/3q1Q==
X-Received: by 2002:a05:6a20:c998:b0:3a2:d53f:691c with SMTP id adf61e73a8af0-3b478d11b1bmr2304417637.26.1780376524097;
        Mon, 01 Jun 2026 22:02:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/7] gpio: ppc44x: drop PPC-specific IO helpers and rename to ppc44x
Date: Mon,  1 Jun 2026 22:01:30 -0700
Message-ID: <20260602050131.856789-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
References: <20260602050131.856789-1-rosenp@gmail.com>
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

Replace PPC-specific clrbits32()/setbits32() with local helpers using
ioread32be()/iowrite32be() which are equivalent on PPC since commit
894fa235eb4c ("powerpc: inline iomap accessors"). This allows the
driver to be compiled on any architecture with COMPILE_TEST.

- Changed Kconfig dependency to depends on 44x || COMPILE_TEST

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/Kconfig       |  3 +-
 drivers/gpio/gpio-ppc44x.c | 88 ++++++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 77991da43ec1..7374f82b7040 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -595,9 +595,8 @@ config GPIO_POLARFIRE_SOC
 
 config GPIO_PPC44X
 	tristate "PPC44x GPIO support"
-	depends on 44x
+	depends on 44x || COMPILE_TEST
 	select GPIO_GENERIC
-	select GPIOLIB
 	help
 	  Enable gpiolib support for ppc440 based boards.
 
diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 6b4814ed12b5..cc7796e0cfbd 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * PPC4xx gpio driver
+ * PPC44x gpio driver
  *
  * Copyright (c) 2008 Harris Corporation
  * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
@@ -22,7 +22,7 @@
 #define GPIO_MASK2(gpio)	(0xc0000000 >> ((gpio) * 2))
 
 /* Physical GPIO register layout */
-struct ppc4xx_gpio {
+struct ppc44x_gpio {
 	__be32 or;
 	__be32 tcr;
 	__be32 osrl;
@@ -43,11 +43,27 @@ struct ppc4xx_gpio {
 	__be32 isr3h;
 };
 
-struct ppc4xx_gpio_chip {
+struct ppc44x_gpio_chip {
 	struct gpio_generic_chip chip;
 	void __iomem *regs;
 };
 
+static inline void ppc44x_clrbits32(void __iomem *addr, u32 mask)
+{
+	u32 val = ioread32be(addr);
+
+	val &= ~mask;
+	iowrite32be(val, addr);
+}
+
+static inline void ppc44x_setbits32(void __iomem *addr, u32 mask)
+{
+	u32 val = ioread32be(addr);
+
+	val |= mask;
+	iowrite32be(val, addr);
+}
+
 /*
  * GPIO LIB API implementation for GPIOs
  *
@@ -55,9 +71,9 @@ struct ppc4xx_gpio_chip {
  */
 
 static inline void
-__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+__ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
 	struct gpio_generic_chip *gen_gc = &chip->chip;
 
 	if (val)
@@ -68,29 +84,29 @@ __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	gpio_generic_write_reg(gen_gc, gen_gc->reg_set, gen_gc->sdata);
 }
 
-static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
 	struct gpio_generic_chip *gen_gc = &chip->chip;
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
 	gpio_generic_chip_lock_irqsave(gen_gc, flags);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Float the pin */
-	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->tcr, GPIO_MASK(gpio));
 	gen_gc->sdir &= ~GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
@@ -99,32 +115,32 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 }
 
 static int
-ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
 	struct gpio_generic_chip *gen_gc = &chip->chip;
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
 	gpio_generic_chip_lock_irqsave(gen_gc, flags);
 
 	/* First set initial value */
-	__ppc4xx_gpio_set(gc, gpio, val);
+	__ppc44x_gpio_set(gc, gpio, val);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Drive the pin */
-	setbits32(&regs->tcr, GPIO_MASK(gpio));
+	ppc44x_setbits32(&regs->tcr, GPIO_MASK(gpio));
 	gen_gc->sdir |= GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
@@ -134,14 +150,14 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int ppc4xx_gpio_probe(struct platform_device *ofdev)
+static int ppc44x_gpio_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
-	struct ppc4xx_gpio_chip *chip;
+	struct ppc44x_gpio_chip *chip;
 	struct gpio_generic_chip_config config;
 	struct gpio_chip *gc;
-	struct ppc4xx_gpio __iomem *regs;
+	struct ppc44x_gpio __iomem *regs;
 	int ret;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -169,8 +185,8 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 
 	gc = &chip->chip.gc;
 	gc->fwnode = dev_fwnode(dev);
-	gc->direction_input = ppc4xx_gpio_dir_in;
-	gc->direction_output = ppc4xx_gpio_dir_out;
+	gc->direction_input = ppc44x_gpio_dir_in;
+	gc->direction_output = ppc44x_gpio_dir_out;
 
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 	if (!gc->label)
@@ -179,20 +195,20 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	return devm_gpiochip_add_data(dev, gc, chip);
 }
 
-static const struct of_device_id ppc4xx_gpio_match[] = {
+static const struct of_device_id ppc44x_gpio_match[] = {
 	{
 		.compatible = "ibm,ppc4xx-gpio",
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, ppc4xx_gpio_match);
+MODULE_DEVICE_TABLE(of, ppc44x_gpio_match);
 
-static struct platform_driver ppc4xx_gpio_driver = {
-	.probe		= ppc4xx_gpio_probe,
+static struct platform_driver ppc44x_gpio_driver = {
+	.probe		= ppc44x_gpio_probe,
 	.driver		= {
-		.name	= "ppc4xx-gpio",
-		.of_match_table	= ppc4xx_gpio_match,
+		.name	= "ppc44x-gpio",
+		.of_match_table	= ppc44x_gpio_match,
 	},
 };
 
-module_platform_driver(ppc4xx_gpio_driver);
+module_platform_driver(ppc44x_gpio_driver);
-- 
2.54.0


