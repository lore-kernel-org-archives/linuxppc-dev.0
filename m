Return-Path: <linuxppc-dev+bounces-21682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6754CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:14:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRZNm19bMz2yQH;
	Fri, 29 May 2026 17:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780038872;
	cv=none; b=TnCCvKmaMAo/BelPwhzvq/VFJZsspPuzueREoWiTdsQRL2SZ4KJgKu2tqVI1CpX4BrAnMTPiWaZ+YgCfbcoRPhB16RXBZy03QRitd16CYqf2L8+tzDdYWdogm6VJz4jvJrXk0HfidIJdjbcFL3RI2I9SDnwxfCsXMkVpX9szJ8+Eaob2+ltRf2rPMw208rgvVPEb7HjeZ5ubgWYWAIbb6dFmAARQS8wURi4ZE3VGzuer0b9CePNjK5hdXZfU0TL8/8H7ewnqQXMdTNJpBCrxzLvw9gsdq1Q2pjoX9426UmlKk/URMeojRRIVuJHQBl5HOLnQW6ToJWq8yXRvi0tYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780038872; c=relaxed/relaxed;
	bh=/ehr5A2spRRQLM6AkQvxbsShMePVQtTYUHFq4y4sUq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm3U1vtSODfZ1aNjL1OJe9WvpMZUvp/hn7MUPknJxN0Fjb0cco/x08RmMy5JEh12qgIYzdk1vo05a/skXtkkS9oLcjG3P+iRlWsQ4vubMQP94b8YL/ei5CWM+Ol5MDBoQkdGISwcIuoEkoMyIz8qkMhSIO3CJhJ9zw77s3d5nCicAduQNwa2JFguWTehHLKJZvg6wLZHwHazu/LWf6EB789Ma+Sh3PbhESw1BLrZVP5VA1Da+g/+J6An7PxAYsJDhi+p98erqcCOKn21+ZsuaIF62OSbQmr9IBiwq5dLchui2bReQs8mPysfrXICrkQvo2VqXDV9fk3foeyIOO822Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VGQ4NdB/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VGQ4NdB/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRZNl2PXzz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:14:31 +1000 (AEST)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-137bd9ed2b1so419722c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038869; x=1780643669; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ehr5A2spRRQLM6AkQvxbsShMePVQtTYUHFq4y4sUq0=;
        b=VGQ4NdB/WkWHuns+GC3RTKE9O/NbP9QRdyVwNp3ncxtMxzBj8TSvGFJvK4Bfv23OvS
         N4s4iqos+IzLsd3I2K7Ou6ENiG8eoiptm+UQ6Cf5JubYrMTatmhhx46TaQZaNDEgF+Lu
         RvyyeqIZNlQaBbYTcyhRAwuNATgTEw2QhSujhLgDkWx/Ukaod18WalQEEdNvw84Xe8AM
         ZtGa+Ro9VJ/5eXzOymshGgGjBQNtLkBcWXqlB7p31nmCNXqVxrVwHrRn6xTA+yUX3IN3
         FvTHlCSK5ILT5diSUMluHc8ZC1TwvZBr5EGGugH0uDZQGvqmGL1Vc9PRlGrQ+BK9/7+f
         4dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038869; x=1780643669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ehr5A2spRRQLM6AkQvxbsShMePVQtTYUHFq4y4sUq0=;
        b=KHX+wrKPezJt8s41J8xheKZYbsq7urmsQEl1HCkxBOvHtX4W9FXoYc4QbtIRza4xrF
         RiEdD59BGRIuGUIv3lAXLq+hkemPUHlxa2ABrjncft7jbyWvD4GKLljL82vNBs0p0y50
         FTNJrcCgGGUhy2cL9//T4Y7t42i7MlRA/Cy4/Y9sx1u1lSM98zp45Y2Mi10NOngc7RL6
         lmPyRg+nXWu5U7UKHO+zDOGsXrTHYQwRICG7zu/Q9SkEkg26g8YWaP/ugmeMa0xmhvU9
         5QI0unZML5K2Qi78cNufSd8DLBtHGv2eMOfwiOXY2JKLNbXNBEXtzi/ka+iPyVxhzOYY
         Gl5w==
X-Gm-Message-State: AOJu0Yyud8fEXuQBbQChmlIGmfnBUHFHY6CVKziWVIsvZRYhKnSUnO+F
	HEUIgW4tLSvQU4nnvwhGFguUdQ8hHFd5ZXTXaA4djwz3XN5VeNAPSggjBbwSm8Dq
X-Gm-Gg: Acq92OHEcgDcyNII9Y9HW/wEPxuVkMJQlJ9FDxVEots6504YiNFOOtLpkQptvm13hAe
	uFrBrUokXFAUmyxgfYpvw9+caE2sc+ZuXymsAZdt1+V1NyYs0Bdu+1jFpabI8ii05l/5xTKylc4
	iLgagp6HVF/F7KzAAng78IA5HLUqESuuuwniKvEoD5LCsqYedUxBsWEo8VwhDv5kWOatyAUqs9y
	1ZitIFHBVT22YytHhHOJkeZUI0BchLPI5WffYviW0XnVJYuQfUZ0B00PCjzCMbZmiP2y/1kBv74
	BRTib7efZodsThDWdQQun6HRzWFnNyfhB4flTvhkJE1TQYVDnQfSRAw30wKVlTL/g7GV2DL+CGb
	av1DYjrj8gaMhaEChaFTF90jkbfUPXc69ZvJaJZKK7z9EwuTCTthgf++SVCIS4ggcDsABN2bKs4
	LHj6eshT9Wn+ea4ruETlAgjARlWT95Oa3XtuXUpV2YTe81lPBHXq4acufTozkj6qgNZ61lxcbrq
	P55m6wFLYYo48DOILn0S/JqXkgovSu4VpQhJFx1uTd8nMnvyYr2e/g5
X-Received: by 2002:a05:7023:b86:b0:12a:68cc:3efb with SMTP id a92af1059eb24-137aea9a20bmr708048c88.16.1780038868473;
        Fri, 29 May 2026 00:14:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm950680c88.0.2026.05.29.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:14:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM)
Subject: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
Date: Fri, 29 May 2026 00:14:08 -0700
Message-ID: <20260529071408.38689-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
drivers/gpio/gpio-ppc44x.c. The driver follows the same pattern as
other PowerPC GPIO drivers already in drivers/gpio/ (e.g.
gpio-mpc8xxx, gpio-mpc5200).

- Replace PPC-specific clrbits32()/setbits32() with local helpers
  using ioread32be()/iowrite32be() so the driver can be built on
  any architecture with COMPILE_TEST
- Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC44X (40x was
  removed in 47d13a269bbd, only 44x remains)
- Rename symbols in the driver with 44x instead of 4xx to reflect the
  absense of 40x.
- Changed dependency to depends on 44x || COMPILE_TEST
- Updated ppc44x_defconfig and warp_defconfig to use the new symbol
- Marked the new option as tristate (was bool) since the driver
  supports module build via module_platform_driver()

Assisted-by: OpenCode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: COMPILE_TEST everywhere
 arch/powerpc/configs/44x/warp_defconfig       |  2 +-
 arch/powerpc/configs/ppc44x_defconfig         |  2 +-
 arch/powerpc/platforms/44x/Kconfig            |  8 --
 arch/powerpc/platforms/44x/Makefile           |  1 -
 drivers/gpio/Kconfig                          |  7 ++
 drivers/gpio/Makefile                         |  1 +
 .../44x/gpio.c => drivers/gpio/gpio-ppc44x.c  | 88 +++++++++++--------
 7 files changed, 62 insertions(+), 47 deletions(-)
 rename arch/powerpc/platforms/44x/gpio.c => drivers/gpio/gpio-ppc44x.c (61%)

diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 5757625469c4..d6014b9c5708 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_WARP=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC44X=y
 CONFIG_HZ_1000=y
 CONFIG_CMDLINE="ip=on"
 # CONFIG_PCI is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 41c930f74ed4..b0c7ad8c6d9b 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -22,7 +22,7 @@ CONFIG_GLACIER=y
 CONFIG_REDWOOD=y
 CONFIG_EIGER=y
 CONFIG_YOSEMITE=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC44X=y
 CONFIG_MATH_EMULATION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index d9717bf04a3f..150813cea945 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -227,14 +227,6 @@ config PPC44x_SIMPLE
 	help
 	  This option enables the simple PowerPC 44x platform support.

-config PPC4xx_GPIO
-	bool "PPC4xx GPIO support"
-	depends on 44x
-	select GPIO_GENERIC
-	select GPIOLIB
-	help
-	  Enable gpiolib support for ppc440 based boards
-
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index ca7b1bb442d9..179468a00f5e 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -15,4 +15,3 @@ obj-$(CONFIG_FSP2)	+= fsp2.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
-obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 89c77ec6c205..7374f82b7040 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -593,6 +593,13 @@ config GPIO_POLARFIRE_SOC
 	help
 	  Say yes here to support the GPIO controllers on Microchip FPGAs.

+config GPIO_PPC44X
+	tristate "PPC44x GPIO support"
+	depends on 44x || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Enable gpiolib support for ppc440 based boards.
+
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 8ec03c9aec20..9e8c9ca1d3fb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+= gpio-pcie-idio-24.o
 obj-$(CONFIG_GPIO_PCI_IDIO_16)		+= gpio-pci-idio-16.o
 obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
+obj-$(CONFIG_GPIO_PPC44X)		+= gpio-ppc44x.o
 obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
 obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
 obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc44x.c
similarity index 61%
rename from arch/powerpc/platforms/44x/gpio.c
rename to drivers/gpio/gpio-ppc44x.c
index 6b4814ed12b5..cc7796e0cfbd 100644
--- a/arch/powerpc/platforms/44x/gpio.c
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


