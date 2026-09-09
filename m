Return-Path: <linuxppc-dev+bounces-26924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED0C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:22:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1h22WTbz2yqd;
	Wed, 09 Sep 2026 23:22:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960162;
	cv=none; b=Uvkzl5SzCrqLXKZJvlGJdENZim5tHIFzWAUAiGjxQbIJq/r1zZr3wYEVoUcKOjin3qDmEqKo7Y+lyBGdKJQ3SOhE6zLKrM4p1XZU0oLMc1JhwQZofXwtTv11YMSvdxPyqmGqRc6GXWA00tuJc9EsFEv89VKHusoW0ovWpu2hTGPfzdy1QLKl94XnD2fP4hv20ioO8yGlxV+IMBHxab0b4sCBxaIlcW8yfQN3ZbHXead8VrYCTVdWqLRTE4CXjp1F/xuNHvXgHVu36jlH7KPcPwGiCA70KP+uL11NwhrfgiwX5ES3aggeE6UaHtWK9HcRSGklxRZ+pxrf+YHBSS8Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960162; c=relaxed/relaxed;
	bh=ytCTVJC78RvZfpnbXXDMjNU0CoWta7ySAj32OlMds3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCK6X9SMFXRAanR0mwIdJ22QbePOxwBMZxCfV3knxHaAJDeUUC98RGCMJTH2E3qQc4ORp7ZHFNXu6VH6OGLdI6MCyjLvaeViP/qcqb4JO4IEl+YIYu/fPIqVPtW5WE7K170EdvR2p6qWru7K6iKhtw0ziyBVQvlZGEv+HKxjMI7mzYIl+HQCtfghB7YocVaOW9o5PlZ5PS89zDWqUfTwrKbeKpWV3psOXQrAP/1xrfki5p8BylFhUQOBvqo5hHl8Jsb2F5JzhWUqOv9ajJQC31bGavP7NsuHyaMLXfPdtX2mwDAcPk5xtUurVrvPnACDVy7QWtxOfFRRnoeD/oNAcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZ3XrbWA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZ3XrbWA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1h10vPrz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:22:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C34E60214;
	Wed,  9 Sep 2026 13:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67FF1F00A3D;
	Wed,  9 Sep 2026 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960158;
	bh=ytCTVJC78RvZfpnbXXDMjNU0CoWta7ySAj32OlMds3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZ3XrbWAruz0c65mIiohZZiGInR2N5YR8XIOgMPxaCS/DjwMfpXo3HmS+ISep3zYk
	 gfbsIOFjy0m+FcU3qnTm3yeF28MblWlNGpxwp0D9pnb/ilNZTl8k6a7eayws2lnh4V
	 xlzmkgQaT1THUszto77ROzSKEv9JvQFo0voYdlSAypDk6gbynHXJcz5TsBqkkHDOso
	 n8WNlWxSBeNn2uqtEseJFrPlFhxYu2vrpF2LLBCMskqWg9z+VjSDCN0Bs5GhKu2ETj
	 4sfLq7ZedyXCpYQkHAvwbXtUEMBLI49zx9GKIXhjatT/dtEJnBsXfu0ng+qfK1+j0C
	 z0XakIx4tkbLg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
Date: Wed,  9 Sep 2026 15:21:39 +0200
Message-ID: <20260909132153.1596191-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The rdc321x was a 486-class SoC developed by RDC. While RDC's later
products closely resemble the DM&P Vortex86 product line and are still
sold under both names, I checked the datasheets for those and found that
the GPIO and WDT blocks on them are incompatible with the rtc321x.

Remove this driver, as there is no way to run Linux any more on the
older chips after i486 support has been removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig              |   8 -
 drivers/gpio/Makefile             |   1 -
 drivers/gpio/gpio-rdc321x.c       | 199 ---------------------
 drivers/mfd/Kconfig               |   9 -
 drivers/mfd/Makefile              |   1 -
 drivers/mfd/rdc321x-southbridge.c |  96 ----------
 drivers/watchdog/Kconfig          |  11 --
 drivers/watchdog/Makefile         |   1 -
 drivers/watchdog/rdc321x_wdt.c    | 281 ------------------------------
 include/linux/mfd/rdc321x.h       |  27 ---
 10 files changed, 634 deletions(-)
 delete mode 100644 drivers/gpio/gpio-rdc321x.c
 delete mode 100644 drivers/mfd/rdc321x-southbridge.c
 delete mode 100644 drivers/watchdog/rdc321x_wdt.c
 delete mode 100644 include/linux/mfd/rdc321x.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a48586bb8edb..aef0db9fe101 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1946,14 +1946,6 @@ config GPIO_PCIE_IDIO_24
 	  Input filter control is not supported by this driver, and the input
 	  filters are deactivated by this driver.
 
-config GPIO_RDC321X
-	tristate "RDC R-321x GPIO support"
-	select MFD_CORE
-	select MFD_RDC321X
-	help
-	  Support for the RDC R321x SoC GPIOs over southbridge
-	  PCI configuration space.
-
 config GPIO_SODAVILLE
 	bool "Intel Sodaville GPIO support"
 	depends on X86 && OF
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index dc9e6d643b5b..2e3a14688b59 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -156,7 +156,6 @@ obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_RC5T583)		+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RCAR)			+= gpio-rcar.o
 obj-$(CONFIG_GPIO_RDA)			+= gpio-rda.o
-obj-$(CONFIG_GPIO_RDC321X)		+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_REALTEK_OTTO)		+= gpio-realtek-otto.o
 obj-$(CONFIG_GPIO_REG)			+= gpio-reg.o
 obj-$(CONFIG_GPIO_ROCKCHIP)	+= gpio-rockchip.o
diff --git a/drivers/gpio/gpio-rdc321x.c b/drivers/gpio/gpio-rdc321x.c
deleted file mode 100644
index ba62b81aa8ae..000000000000
--- a/drivers/gpio/gpio-rdc321x.c
+++ /dev/null
@@ -1,199 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDC321x GPIO driver
- *
- * Copyright (C) 2008, Volker Weiss <dev@tintuc.de>
- * Copyright (C) 2007-2010 Florian Fainelli <florian@openwrt.org>
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/gpio/driver.h>
-#include <linux/mfd/rdc321x.h>
-#include <linux/slab.h>
-
-struct rdc321x_gpio {
-	spinlock_t		lock;
-	struct pci_dev		*sb_pdev;
-	u32			data_reg[2];
-	int			reg1_ctrl_base;
-	int			reg1_data_base;
-	int			reg2_ctrl_base;
-	int			reg2_data_base;
-	struct gpio_chip	chip;
-};
-
-/* read GPIO pin */
-static int rdc_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-{
-	struct rdc321x_gpio *gpch;
-	u32 value = 0;
-	int reg;
-
-	gpch = gpiochip_get_data(chip);
-	reg = gpio < 32 ? gpch->reg1_data_base : gpch->reg2_data_base;
-
-	spin_lock(&gpch->lock);
-	pci_write_config_dword(gpch->sb_pdev, reg,
-					gpch->data_reg[gpio < 32 ? 0 : 1]);
-	pci_read_config_dword(gpch->sb_pdev, reg, &value);
-	spin_unlock(&gpch->lock);
-
-	return (1 << (gpio & 0x1f)) & value ? 1 : 0;
-}
-
-static void rdc_gpio_set_value_impl(struct gpio_chip *chip,
-				unsigned gpio, int value)
-{
-	struct rdc321x_gpio *gpch;
-	int reg = (gpio < 32) ? 0 : 1;
-
-	gpch = gpiochip_get_data(chip);
-
-	if (value)
-		gpch->data_reg[reg] |= 1 << (gpio & 0x1f);
-	else
-		gpch->data_reg[reg] &= ~(1 << (gpio & 0x1f));
-
-	pci_write_config_dword(gpch->sb_pdev,
-			reg ? gpch->reg2_data_base : gpch->reg1_data_base,
-			gpch->data_reg[reg]);
-}
-
-/* set GPIO pin to value */
-static int rdc_gpio_set_value(struct gpio_chip *chip, unsigned int gpio,
-			      int value)
-{
-	struct rdc321x_gpio *gpch;
-
-	gpch = gpiochip_get_data(chip);
-	spin_lock(&gpch->lock);
-	rdc_gpio_set_value_impl(chip, gpio, value);
-	spin_unlock(&gpch->lock);
-
-	return 0;
-}
-
-static int rdc_gpio_config(struct gpio_chip *chip,
-				unsigned gpio, int value)
-{
-	struct rdc321x_gpio *gpch;
-	int err;
-	u32 reg;
-
-	gpch = gpiochip_get_data(chip);
-
-	spin_lock(&gpch->lock);
-	err = pci_read_config_dword(gpch->sb_pdev, gpio < 32 ?
-			gpch->reg1_ctrl_base : gpch->reg2_ctrl_base, &reg);
-	if (err)
-		goto unlock;
-
-	reg |= 1 << (gpio & 0x1f);
-
-	err = pci_write_config_dword(gpch->sb_pdev, gpio < 32 ?
-			gpch->reg1_ctrl_base : gpch->reg2_ctrl_base, reg);
-	if (err)
-		goto unlock;
-
-	rdc_gpio_set_value_impl(chip, gpio, value);
-
-unlock:
-	spin_unlock(&gpch->lock);
-
-	return pcibios_err_to_errno(err);
-}
-
-/* configure GPIO pin as input */
-static int rdc_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	return rdc_gpio_config(chip, gpio, 1);
-}
-
-/*
- * Cache the initial value of both GPIO data registers
- */
-static int rdc321x_gpio_probe(struct platform_device *pdev)
-{
-	int err;
-	struct resource *r;
-	struct rdc321x_gpio *rdc321x_gpio_dev;
-	struct rdc321x_gpio_pdata *pdata;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data supplied\n");
-		return -ENODEV;
-	}
-
-	rdc321x_gpio_dev = devm_kzalloc(&pdev->dev, sizeof(struct rdc321x_gpio),
-					GFP_KERNEL);
-	if (!rdc321x_gpio_dev)
-		return -ENOMEM;
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IO, "gpio-reg1");
-	if (!r) {
-		dev_err(&pdev->dev, "failed to get gpio-reg1 resource\n");
-		return -ENODEV;
-	}
-
-	spin_lock_init(&rdc321x_gpio_dev->lock);
-	rdc321x_gpio_dev->sb_pdev = pdata->sb_pdev;
-	rdc321x_gpio_dev->reg1_ctrl_base = r->start;
-	rdc321x_gpio_dev->reg1_data_base = r->start + 0x4;
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IO, "gpio-reg2");
-	if (!r) {
-		dev_err(&pdev->dev, "failed to get gpio-reg2 resource\n");
-		return -ENODEV;
-	}
-
-	rdc321x_gpio_dev->reg2_ctrl_base = r->start;
-	rdc321x_gpio_dev->reg2_data_base = r->start + 0x4;
-
-	rdc321x_gpio_dev->chip.label = "rdc321x-gpio";
-	rdc321x_gpio_dev->chip.owner = THIS_MODULE;
-	rdc321x_gpio_dev->chip.direction_input = rdc_gpio_direction_input;
-	rdc321x_gpio_dev->chip.direction_output = rdc_gpio_config;
-	rdc321x_gpio_dev->chip.get = rdc_gpio_get_value;
-	rdc321x_gpio_dev->chip.set = rdc_gpio_set_value;
-	rdc321x_gpio_dev->chip.base = 0;
-	rdc321x_gpio_dev->chip.ngpio = pdata->max_gpios;
-
-	platform_set_drvdata(pdev, rdc321x_gpio_dev);
-
-	/* This might not be, what others (BIOS, bootloader, etc.)
-	   wrote to these registers before, but it's a good guess. Still
-	   better than just using 0xffffffff. */
-	err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
-					rdc321x_gpio_dev->reg1_data_base,
-					&rdc321x_gpio_dev->data_reg[0]);
-	if (err)
-		return pcibios_err_to_errno(err);
-
-	err = pci_read_config_dword(rdc321x_gpio_dev->sb_pdev,
-					rdc321x_gpio_dev->reg2_data_base,
-					&rdc321x_gpio_dev->data_reg[1]);
-	if (err)
-		return pcibios_err_to_errno(err);
-
-	dev_info(&pdev->dev, "registering %d GPIOs\n",
-					rdc321x_gpio_dev->chip.ngpio);
-	return devm_gpiochip_add_data(&pdev->dev, &rdc321x_gpio_dev->chip,
-				      rdc321x_gpio_dev);
-}
-
-static struct platform_driver rdc321x_gpio_driver = {
-	.driver.name	= "rdc321x-gpio",
-	.probe		= rdc321x_gpio_probe,
-};
-
-module_platform_driver(rdc321x_gpio_driver);
-
-MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-MODULE_DESCRIPTION("RDC321x GPIO driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:rdc321x-gpio");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index de81d2bb4917..ce0c39b50af7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1289,15 +1289,6 @@ config MFD_SY7636A
 	  To enable support for building sub-devices as modules,
 	  choose M here.
 
-config MFD_RDC321X
-	tristate "RDC R-321x southbridge"
-	select MFD_CORE
-	depends on PCI
-	help
-	  Say yes here if you want to have support for the RDC R-321x SoC
-	  southbridge which provides access to GPIOs and Watchdog using the
-	  southbridge PCI device configuration space.
-
 config MFD_RT4831
 	tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index fe7156a5187a..a54eb18af56a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -200,7 +200,6 @@ obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
 obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
-obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
 obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
 obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
 obj-$(CONFIG_MFD_VX855)		+= vx855.o
diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
deleted file mode 100644
index c44a76285147..000000000000
--- a/drivers/mfd/rdc321x-southbridge.c
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDC321x MFD southbridge driver
- *
- * Copyright (C) 2007-2010 Florian Fainelli <florian@openwrt.org>
- * Copyright (C) 2010 Bernhard Loos <bernhardloos@googlemail.com>
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/rdc321x.h>
-
-static struct rdc321x_wdt_pdata rdc321x_wdt_pdata;
-
-static const struct resource rdc321x_wdt_resource[] = {
-	{
-		.name	= "wdt-reg",
-		.start	= RDC321X_WDT_CTRL,
-		.end	= RDC321X_WDT_CTRL + 0x3,
-		.flags	= IORESOURCE_IO,
-	}
-};
-
-static struct rdc321x_gpio_pdata rdc321x_gpio_pdata = {
-	.max_gpios	= RDC321X_NUM_GPIO,
-};
-
-static const struct resource rdc321x_gpio_resources[] = {
-	{
-		.name	= "gpio-reg1",
-		.start	= RDC321X_GPIO_CTRL_REG1,
-		.end	= RDC321X_GPIO_CTRL_REG1 + 0x7,
-		.flags	= IORESOURCE_IO,
-	}, {
-		.name	= "gpio-reg2",
-		.start	= RDC321X_GPIO_CTRL_REG2,
-		.end	= RDC321X_GPIO_CTRL_REG2 + 0x7,
-		.flags	= IORESOURCE_IO,
-	}
-};
-
-static const struct mfd_cell rdc321x_sb_cells[] = {
-	{
-		.name		= "rdc321x-wdt",
-		.resources	= rdc321x_wdt_resource,
-		.num_resources	= ARRAY_SIZE(rdc321x_wdt_resource),
-		.platform_data	= &rdc321x_wdt_pdata,
-		.pdata_size	= sizeof(rdc321x_wdt_pdata),
-	}, {
-		.name		= "rdc321x-gpio",
-		.resources	= rdc321x_gpio_resources,
-		.num_resources	= ARRAY_SIZE(rdc321x_gpio_resources),
-		.platform_data	= &rdc321x_gpio_pdata,
-		.pdata_size	= sizeof(rdc321x_gpio_pdata),
-	},
-};
-
-static int rdc321x_sb_probe(struct pci_dev *pdev,
-					const struct pci_device_id *ent)
-{
-	int err;
-
-	err = pci_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable device\n");
-		return err;
-	}
-
-	rdc321x_gpio_pdata.sb_pdev = pdev;
-	rdc321x_wdt_pdata.sb_pdev = pdev;
-
-	return devm_mfd_add_devices(&pdev->dev, -1,
-				    rdc321x_sb_cells,
-				    ARRAY_SIZE(rdc321x_sb_cells),
-				    NULL, 0, NULL);
-}
-
-static const struct pci_device_id rdc321x_sb_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_RDC, PCI_DEVICE_ID_RDC_R6030) },
-	{}
-};
-MODULE_DEVICE_TABLE(pci, rdc321x_sb_table);
-
-static struct pci_driver rdc321x_sb_driver = {
-	.name		= "RDC321x Southbridge",
-	.id_table	= rdc321x_sb_table,
-	.probe		= rdc321x_sb_probe,
-};
-
-module_pci_driver(rdc321x_sb_driver);
-
-MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("RDC R-321x MFD southbridge driver");
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ddf88b07ce34..7832cb8b2e7a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1572,17 +1572,6 @@ config NV_TCO
 	  To compile this driver as a module, choose M here: the
 	  module will be called nv_tco.
 
-config RDC321X_WDT
-	tristate "RDC R-321x SoC watchdog"
-	depends on X86_32 || COMPILE_TEST
-	depends on PCI
-	help
-	  This is the driver for the built in hardware watchdog
-	  in the RDC R-321x SoC.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rdc321x_wdt.
-
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
 	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677aba..460be2a566c4 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -138,7 +138,6 @@ obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_PC87413_WDT) += pc87413_wdt.o
 obj-$(CONFIG_NV_TCO) += nv_tco.o
-obj-$(CONFIG_RDC321X_WDT) += rdc321x_wdt.o
 obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_SBC7240_WDT) += sbc7240_wdt.o
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
deleted file mode 100644
index 8955177072fa..000000000000
--- a/drivers/watchdog/rdc321x_wdt.c
+++ /dev/null
@@ -1,281 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDC321x watchdog driver
- *
- * Copyright (C) 2007-2010 Florian Fainelli <florian@openwrt.org>
- *
- * This driver is highly inspired from the cpu5_wdt driver
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/miscdevice.h>
-#include <linux/fs.h>
-#include <linux/ioport.h>
-#include <linux/timer.h>
-#include <linux/completion.h>
-#include <linux/jiffies.h>
-#include <linux/platform_device.h>
-#include <linux/watchdog.h>
-#include <linux/io.h>
-#include <linux/uaccess.h>
-#include <linux/mfd/rdc321x.h>
-
-#define RDC_WDT_MASK	0x80000000 /* Mask */
-#define RDC_WDT_EN	0x00800000 /* Enable bit */
-#define RDC_WDT_WTI	0x00200000 /* Generate CPU reset/NMI/WDT on timeout */
-#define RDC_WDT_RST	0x00100000 /* Reset bit */
-#define RDC_WDT_WIF	0x00040000 /* WDT IRQ Flag */
-#define RDC_WDT_IRT	0x00000100 /* IRQ Routing table */
-#define RDC_WDT_CNT	0x00000001 /* WDT count */
-
-#define RDC_CLS_TMR	0x80003844 /* Clear timer */
-
-#define RDC_WDT_INTERVAL	(HZ/10+1)
-
-static int ticks = 1000;
-
-/* some device data */
-
-static struct {
-	struct completion stop;
-	int running;
-	struct timer_list timer;
-	int queue;
-	int default_ticks;
-	unsigned long inuse;
-	spinlock_t lock;
-	struct pci_dev *sb_pdev;
-	int base_reg;
-} rdc321x_wdt_device;
-
-/* generic helper functions */
-
-static void rdc321x_wdt_trigger(struct timer_list *unused)
-{
-	unsigned long flags;
-	u32 val;
-
-	if (rdc321x_wdt_device.running)
-		ticks--;
-
-	/* keep watchdog alive */
-	spin_lock_irqsave(&rdc321x_wdt_device.lock, flags);
-	pci_read_config_dword(rdc321x_wdt_device.sb_pdev,
-					rdc321x_wdt_device.base_reg, &val);
-	val |= RDC_WDT_EN;
-	pci_write_config_dword(rdc321x_wdt_device.sb_pdev,
-					rdc321x_wdt_device.base_reg, val);
-	spin_unlock_irqrestore(&rdc321x_wdt_device.lock, flags);
-
-	/* requeue?? */
-	if (rdc321x_wdt_device.queue && ticks)
-		mod_timer(&rdc321x_wdt_device.timer,
-				jiffies + RDC_WDT_INTERVAL);
-	else {
-		/* ticks doesn't matter anyway */
-		complete(&rdc321x_wdt_device.stop);
-	}
-
-}
-
-static void rdc321x_wdt_reset(void)
-{
-	ticks = rdc321x_wdt_device.default_ticks;
-}
-
-static void rdc321x_wdt_start(void)
-{
-	unsigned long flags;
-
-	if (!rdc321x_wdt_device.queue) {
-		rdc321x_wdt_device.queue = 1;
-
-		/* Clear the timer */
-		spin_lock_irqsave(&rdc321x_wdt_device.lock, flags);
-		pci_write_config_dword(rdc321x_wdt_device.sb_pdev,
-				rdc321x_wdt_device.base_reg, RDC_CLS_TMR);
-
-		/* Enable watchdog and set the timeout to 81.92 us */
-		pci_write_config_dword(rdc321x_wdt_device.sb_pdev,
-					rdc321x_wdt_device.base_reg,
-					RDC_WDT_EN | RDC_WDT_CNT);
-		spin_unlock_irqrestore(&rdc321x_wdt_device.lock, flags);
-
-		mod_timer(&rdc321x_wdt_device.timer,
-				jiffies + RDC_WDT_INTERVAL);
-	}
-
-	/* if process dies, counter is not decremented */
-	rdc321x_wdt_device.running++;
-}
-
-static int rdc321x_wdt_stop(void)
-{
-	if (rdc321x_wdt_device.running)
-		rdc321x_wdt_device.running = 0;
-
-	ticks = rdc321x_wdt_device.default_ticks;
-
-	return -EIO;
-}
-
-/* filesystem operations */
-static int rdc321x_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &rdc321x_wdt_device.inuse))
-		return -EBUSY;
-
-	return stream_open(inode, file);
-}
-
-static int rdc321x_wdt_release(struct inode *inode, struct file *file)
-{
-	clear_bit(0, &rdc321x_wdt_device.inuse);
-	return 0;
-}
-
-static long rdc321x_wdt_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	u32 value;
-	static const struct watchdog_info ident = {
-		.options = WDIOF_CARDRESET,
-		.identity = "RDC321x WDT",
-	};
-	unsigned long flags;
-
-	switch (cmd) {
-	case WDIOC_KEEPALIVE:
-		rdc321x_wdt_reset();
-		break;
-	case WDIOC_GETSTATUS:
-		/* Read the value from the DATA register */
-		spin_lock_irqsave(&rdc321x_wdt_device.lock, flags);
-		pci_read_config_dword(rdc321x_wdt_device.sb_pdev,
-					rdc321x_wdt_device.base_reg, &value);
-		spin_unlock_irqrestore(&rdc321x_wdt_device.lock, flags);
-		if (copy_to_user(argp, &value, sizeof(u32)))
-			return -EFAULT;
-		break;
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &ident, sizeof(ident)))
-			return -EFAULT;
-		break;
-	case WDIOC_SETOPTIONS:
-		if (copy_from_user(&value, argp, sizeof(int)))
-			return -EFAULT;
-		switch (value) {
-		case WDIOS_ENABLECARD:
-			rdc321x_wdt_start();
-			break;
-		case WDIOS_DISABLECARD:
-			return rdc321x_wdt_stop();
-		default:
-			return -EINVAL;
-		}
-		break;
-	default:
-		return -ENOTTY;
-	}
-	return 0;
-}
-
-static ssize_t rdc321x_wdt_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	if (!count)
-		return -EIO;
-
-	rdc321x_wdt_reset();
-
-	return count;
-}
-
-static const struct file_operations rdc321x_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= rdc321x_wdt_ioctl,
-	.compat_ioctl	= compat_ptr_ioctl,
-	.open		= rdc321x_wdt_open,
-	.write		= rdc321x_wdt_write,
-	.release	= rdc321x_wdt_release,
-};
-
-static struct miscdevice rdc321x_wdt_misc = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &rdc321x_wdt_fops,
-};
-
-static int rdc321x_wdt_probe(struct platform_device *pdev)
-{
-	int err;
-	struct resource *r;
-	struct rdc321x_wdt_pdata *pdata;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data supplied\n");
-		return -ENODEV;
-	}
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IO, "wdt-reg");
-	if (!r) {
-		dev_err(&pdev->dev, "failed to get wdt-reg resource\n");
-		return -ENODEV;
-	}
-
-	rdc321x_wdt_device.sb_pdev = pdata->sb_pdev;
-	rdc321x_wdt_device.base_reg = r->start;
-	rdc321x_wdt_device.queue = 0;
-	rdc321x_wdt_device.default_ticks = ticks;
-
-	err = misc_register(&rdc321x_wdt_misc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "misc_register failed\n");
-		return err;
-	}
-
-	spin_lock_init(&rdc321x_wdt_device.lock);
-
-	/* Reset the watchdog */
-	pci_write_config_dword(rdc321x_wdt_device.sb_pdev,
-				rdc321x_wdt_device.base_reg, RDC_WDT_RST);
-
-	init_completion(&rdc321x_wdt_device.stop);
-
-	clear_bit(0, &rdc321x_wdt_device.inuse);
-
-	timer_setup(&rdc321x_wdt_device.timer, rdc321x_wdt_trigger, 0);
-
-	dev_info(&pdev->dev, "watchdog init success\n");
-
-	return 0;
-}
-
-static void rdc321x_wdt_remove(struct platform_device *pdev)
-{
-	if (rdc321x_wdt_device.queue) {
-		rdc321x_wdt_device.queue = 0;
-		wait_for_completion(&rdc321x_wdt_device.stop);
-	}
-
-	misc_deregister(&rdc321x_wdt_misc);
-}
-
-static struct platform_driver rdc321x_wdt_driver = {
-	.probe = rdc321x_wdt_probe,
-	.remove = rdc321x_wdt_remove,
-	.driver = {
-		.name = "rdc321x-wdt",
-	},
-};
-
-module_platform_driver(rdc321x_wdt_driver);
-
-MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-MODULE_DESCRIPTION("RDC321x watchdog driver");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rdc321x.h b/include/linux/mfd/rdc321x.h
deleted file mode 100644
index 697933b2227b..000000000000
--- a/include/linux/mfd/rdc321x.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RDC321X_MFD_H
-#define __RDC321X_MFD_H
-
-#include <linux/types.h>
-#include <linux/pci.h>
-
-/* Offsets to be accessed in the southbridge PCI
- * device configuration register */
-#define RDC321X_WDT_CTRL	0x44
-#define RDC321X_GPIO_CTRL_REG1	0x48
-#define RDC321X_GPIO_DATA_REG1	0x4c
-#define RDC321X_GPIO_CTRL_REG2	0x84
-#define RDC321X_GPIO_DATA_REG2	0x88
-
-#define RDC321X_NUM_GPIO	59
-
-struct rdc321x_gpio_pdata {
-	struct pci_dev *sb_pdev;
-	unsigned max_gpios;
-};
-
-struct rdc321x_wdt_pdata {
-	struct pci_dev *sb_pdev;
-};
-
-#endif /* __RDC321X_MFD_H */
-- 
2.53.0


