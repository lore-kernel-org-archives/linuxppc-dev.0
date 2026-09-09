Return-Path: <linuxppc-dev+bounces-26928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13555C79FBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:23:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1hZ4pYJz2yth;
	Wed, 09 Sep 2026 23:23:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960190;
	cv=none; b=efQ5yYKhV2KiebCZc/peXb9FJy+/WLlTQ/6816O7SoQPGGNEJlF1aQ2r6eIcC+jlfFyoHSjv/zGJHMaRgLIq9Gs156tiliX0YpB0cLpP9th9bDl2NCInLvS33KrX73m6ce2SRvhwaFnXcgSlupDg1GB6yJ3MH3Qb/iejh8ZrfJVmmL4M6MvVbQUqcpPGKKI0C/MdHi7NL4Bhqu7bitpqWBKD47Svdh3g0hcYm5ZPRO0M+XL+W5mrkqqcV9LOzEuVatGoqjtGtifl7Vp+vJTSik0BRiMtSwOykpBvPinNFZWj5J5Q4K2yPFZIMUPpEjeFYKqdW1pigJT+/7EF4O1nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960190; c=relaxed/relaxed;
	bh=5M/ZyONg7YqyTq0oJuJrrswfof23+2KRGmIuMGVHTGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAsPBkZY0Vp8MX9ml8l6PiyVpMmnlmtQrHngotGn2BT8ByR53JGhVdymF6Bb5TGq93DpefpIy810Zp9jOV8AxmdyJOM2KMNMtixjyb76OfY+oX9qEbtgp0RxiOFb25lz+L8vZu1ES4y8xAr39lys+CCV0ZeOJstwcOneR9tb7No71eWmM1KNO2pXWrMzGNuLpUZwCmVxYhFxpOhnvOEMtxebhEYcya+TFZBnwd65DCEb4vuH3pRpEPIXJVaJw9E1tl8txY2swkZ+5TyezUxQtnDXr2ZDlJ6GkuNARlQQ8+OohbbmJg2gWXtf7761PUyce8OBhSp47THzgoiQdbXckA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yhg3hdAI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yhg3hdAI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1hV1zmlz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:23:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72F8641FBC;
	Wed,  9 Sep 2026 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656001F00ACA;
	Wed,  9 Sep 2026 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960184;
	bh=5M/ZyONg7YqyTq0oJuJrrswfof23+2KRGmIuMGVHTGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yhg3hdAI0jDDmk0EhyaXGTaNVBYLyGGjHv745DBGpFB4z8R+QN3qfHrZ0/4SQELHt
	 gdn2oxziemo7yjqUpFFsTy2KVnTiBb47NrOn3AqLRaLWbvj1dFB5HMIXaOBKVFn+iM
	 pPkUE29vb+EM57M9lEHGHjwvcW4xfc+st/IM/aiwFGwS3RqX64hshXW+xUPnvfvR/d
	 RvHBBwb4MFs8BsJytWNBy/qp2ODnKBLYLw4qAFej0cCxjsHbF82yilZ0CMj1+ya/ba
	 cTQ//nLaB76d4M+MnFM1s+R6EvLWiwjG5e7N77T2dTDzNudrpFzH7u4Op0vv8Ue5jv
	 CeoPI1164Dolg==
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
Subject: [PATCH 05/14] mfd: remove unused adp5520 driver
Date: Wed,  9 Sep 2026 15:21:42 +0200
Message-ID: <20260909132153.1596191-6-arnd@kernel.org>
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

This driver requires the use of platform_data definitions rather than
devicetree, but that was last used on the blackfin architecture in
2018 and nothing could have used it upstream since.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../ABI/testing/sysfs-class-backlight         |  11 -
 MAINTAINERS                                   |  11 -
 drivers/gpio/Kconfig                          |   7 -
 drivers/gpio/Makefile                         |   1 -
 drivers/gpio/gpio-adp5520.c                   | 169 --------
 drivers/input/keyboard/Kconfig                |  10 -
 drivers/input/keyboard/Makefile               |   1 -
 drivers/input/keyboard/adp5520-keys.c         | 191 ---------
 drivers/leds/Kconfig                          |  11 -
 drivers/leds/Makefile                         |   1 -
 drivers/leds/leds-adp5520.c                   | 195 ---------
 drivers/mfd/Kconfig                           |  10 -
 drivers/mfd/Makefile                          |   1 -
 drivers/mfd/adp5520.c                         | 346 ----------------
 drivers/video/backlight/Kconfig               |  10 -
 drivers/video/backlight/Makefile              |   1 -
 drivers/video/backlight/adp5520_bl.c          | 385 ------------------
 include/linux/mfd/adp5520.h                   | 298 --------------
 18 files changed, 1659 deletions(-)
 delete mode 100644 drivers/gpio/gpio-adp5520.c
 delete mode 100644 drivers/input/keyboard/adp5520-keys.c
 delete mode 100644 drivers/leds/leds-adp5520.c
 delete mode 100644 drivers/mfd/adp5520.c
 delete mode 100644 drivers/video/backlight/adp5520_bl.c
 delete mode 100644 include/linux/mfd/adp5520.h

diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
index c453646b06e2..b73d66942fbb 100644
--- a/Documentation/ABI/testing/sysfs-class-backlight
+++ b/Documentation/ABI/testing/sysfs-class-backlight
@@ -97,17 +97,6 @@ Description:
 
 		The <ambient light zone> is device-driver specific:
 
-		For ADP5520 and ADP5501, <ambient light zone> can be:
-
-		===========  ================================================
-		Ambient      sysfs entry
-		light zone
-		===========  ================================================
-		daylight     /sys/class/backlight/<backlight>/daylight_max
-		office       /sys/class/backlight/<backlight>/office_max
-		dark         /sys/class/backlight/<backlight>/dark_max
-		===========  ================================================
-
 		For ADP8860, <ambient light zone> can be:
 
 		===========  ================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index c5e2140cdac0..86df3fadba87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -550,17 +550,6 @@ F:	Documentation/devicetree/bindings/media/i2c/adi,adp1653.txt
 F:	drivers/media/i2c/adp1653.c
 F:	include/media/i2c/adp1653.h
 
-ADP5520 BACKLIGHT DRIVER WITH IO EXPANDER (ADP5520/ADP5501)
-M:	Michael Hennerich <michael.hennerich@analog.com>
-S:	Supported
-W:	http://wiki.analog.com/ADP5520
-W:	https://ez.analog.com/linux-software-drivers
-F:	drivers/gpio/gpio-adp5520.c
-F:	drivers/input/keyboard/adp5520-keys.c
-F:	drivers/leds/leds-adp5520.c
-F:	drivers/mfd/adp5520.c
-F:	drivers/video/backlight/adp5520_bl.c
-
 ADP5585 GPIO EXPANDER, PWM AND KEYPAD CONTROLLER DRIVER
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index aef0db9fe101..98b9931c59ff 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1325,13 +1325,6 @@ endmenu
 
 menu "MFD GPIO expanders"
 
-config GPIO_ADP5520
-	tristate "GPIO Support for ADP5520 PMIC"
-	depends on PMIC_ADP5520
-	help
-	  This option enables support for on-chip GPIO found
-	  on Analog Devices ADP5520 PMICs.
-
 config GPIO_ADP5585
 	tristate "GPIO Support for ADP5585"
 	depends on MFD_ADP5585
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 2e3a14688b59..1fafd15d3fa6 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_GPIO_104_IDIO_16)		+= gpio-104-idio-16.o
 obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
-obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_ADP5585)		+= gpio-adp5585.o
 obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
diff --git a/drivers/gpio/gpio-adp5520.c b/drivers/gpio/gpio-adp5520.c
deleted file mode 100644
index 6305c8b7dc05..000000000000
--- a/drivers/gpio/gpio-adp5520.c
+++ /dev/null
@@ -1,169 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * GPIO driver for Analog Devices ADP5520 MFD PMICs
- *
- * Copyright 2009 Analog Devices Inc.
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/adp5520.h>
-#include <linux/gpio/driver.h>
-
-struct adp5520_gpio {
-	struct device *master;
-	struct gpio_chip gpio_chip;
-	unsigned char lut[ADP5520_MAXGPIOS];
-	unsigned long output;
-};
-
-static int adp5520_gpio_get_value(struct gpio_chip *chip, unsigned off)
-{
-	struct adp5520_gpio *dev;
-	uint8_t reg_val;
-
-	dev = gpiochip_get_data(chip);
-
-	/*
-	 * There are dedicated registers for GPIO IN/OUT.
-	 * Make sure we return the right value, even when configured as output
-	 */
-
-	if (test_bit(off, &dev->output))
-		adp5520_read(dev->master, ADP5520_GPIO_OUT, &reg_val);
-	else
-		adp5520_read(dev->master, ADP5520_GPIO_IN, &reg_val);
-
-	return !!(reg_val & dev->lut[off]);
-}
-
-static int adp5520_gpio_set_value(struct gpio_chip *chip,
-				  unsigned int off, int val)
-{
-	struct adp5520_gpio *dev;
-	dev = gpiochip_get_data(chip);
-
-	if (val)
-		return adp5520_set_bits(dev->master, ADP5520_GPIO_OUT,
-					dev->lut[off]);
-	else
-		return adp5520_clr_bits(dev->master, ADP5520_GPIO_OUT,
-					dev->lut[off]);
-}
-
-static int adp5520_gpio_direction_input(struct gpio_chip *chip, unsigned off)
-{
-	struct adp5520_gpio *dev;
-	dev = gpiochip_get_data(chip);
-
-	clear_bit(off, &dev->output);
-
-	return adp5520_clr_bits(dev->master, ADP5520_GPIO_CFG_2,
-				dev->lut[off]);
-}
-
-static int adp5520_gpio_direction_output(struct gpio_chip *chip,
-		unsigned off, int val)
-{
-	struct adp5520_gpio *dev;
-	int ret = 0;
-	dev = gpiochip_get_data(chip);
-
-	set_bit(off, &dev->output);
-
-	if (val)
-		ret |= adp5520_set_bits(dev->master, ADP5520_GPIO_OUT,
-					dev->lut[off]);
-	else
-		ret |= adp5520_clr_bits(dev->master, ADP5520_GPIO_OUT,
-					dev->lut[off]);
-
-	ret |= adp5520_set_bits(dev->master, ADP5520_GPIO_CFG_2,
-					dev->lut[off]);
-
-	return ret;
-}
-
-static int adp5520_gpio_probe(struct platform_device *pdev)
-{
-	struct adp5520_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct adp5520_gpio *dev;
-	struct gpio_chip *gc;
-	int ret, i, gpios;
-	unsigned char ctl_mask = 0;
-
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -ENODEV;
-	}
-
-	if (pdev->id != ID_ADP5520) {
-		dev_err(&pdev->dev, "only ADP5520 supports GPIO\n");
-		return -ENODEV;
-	}
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL)
-		return -ENOMEM;
-
-	dev->master = pdev->dev.parent;
-
-	for (gpios = 0, i = 0; i < ADP5520_MAXGPIOS; i++)
-		if (pdata->gpio_en_mask & (1 << i))
-			dev->lut[gpios++] = 1 << i;
-
-	if (gpios < 1)
-		return -EINVAL;
-
-	gc = &dev->gpio_chip;
-	gc->direction_input  = adp5520_gpio_direction_input;
-	gc->direction_output = adp5520_gpio_direction_output;
-	gc->get = adp5520_gpio_get_value;
-	gc->set = adp5520_gpio_set_value;
-	gc->can_sleep = true;
-
-	gc->base = pdata->gpio_start;
-	gc->ngpio = gpios;
-	gc->label = pdev->name;
-	gc->owner = THIS_MODULE;
-
-	ret = adp5520_clr_bits(dev->master, ADP5520_GPIO_CFG_1,
-		pdata->gpio_en_mask);
-
-	if (pdata->gpio_en_mask & ADP5520_GPIO_C3)
-		ctl_mask |= ADP5520_C3_MODE;
-
-	if (pdata->gpio_en_mask & ADP5520_GPIO_R3)
-		ctl_mask |= ADP5520_R3_MODE;
-
-	if (ctl_mask)
-		ret = adp5520_set_bits(dev->master, ADP5520_LED_CONTROL,
-			ctl_mask);
-
-	ret |= adp5520_set_bits(dev->master, ADP5520_GPIO_PULLUP,
-		pdata->gpio_pullup_mask);
-
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write\n");
-		return ret;
-	}
-
-	return devm_gpiochip_add_data(&pdev->dev, &dev->gpio_chip, dev);
-}
-
-static struct platform_driver adp5520_gpio_driver = {
-	.driver	= {
-		.name	= "adp5520-gpio",
-	},
-	.probe		= adp5520_gpio_probe,
-};
-
-module_platform_driver(adp5520_gpio_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("GPIO ADP5520 Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:adp5520-gpio");
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8c64f333462..ec3fe4632d8d 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -27,16 +27,6 @@ config KEYBOARD_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called adc_keys.
 
-config KEYBOARD_ADP5520
-	tristate "Keypad Support for ADP5520 PMIC"
-	depends on PMIC_ADP5520
-	help
-	  This option enables support for the keypad scan matrix
-	  on Analog Devices ADP5520 PMICs.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called adp5520-keys.
-
 config KEYBOARD_ADP5585
 	tristate "ADP558x keypad support"
 	depends on MFD_ADP5585
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 60bb7baf802f..c1a443c64962 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -6,7 +6,6 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_KEYBOARD_ADC)		+= adc-keys.o
-obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
deleted file mode 100644
index 980d739e45b8..000000000000
--- a/drivers/input/keyboard/adp5520-keys.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Keypad driver for Analog Devices ADP5520 MFD PMICs
- *
- * Copyright 2009 Analog Devices Inc.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/mfd/adp5520.h>
-#include <linux/slab.h>
-#include <linux/device.h>
-
-struct adp5520_keys {
-	struct input_dev *input;
-	struct notifier_block notifier;
-	struct device *master;
-	unsigned short keycode[ADP5520_KEYMAPSIZE];
-};
-
-static void adp5520_keys_report_event(struct adp5520_keys *dev,
-					unsigned short keymask, int value)
-{
-	int i;
-
-	for (i = 0; i < ADP5520_MAXKEYS; i++)
-		if (keymask & (1 << i))
-			input_report_key(dev->input, dev->keycode[i], value);
-
-	input_sync(dev->input);
-}
-
-static int adp5520_keys_notifier(struct notifier_block *nb,
-				 unsigned long event, void *data)
-{
-	struct adp5520_keys *dev;
-	uint8_t reg_val_lo, reg_val_hi;
-	unsigned short keymask;
-
-	dev = container_of(nb, struct adp5520_keys, notifier);
-
-	if (event & ADP5520_KP_INT) {
-		adp5520_read(dev->master, ADP5520_KP_INT_STAT_1, &reg_val_lo);
-		adp5520_read(dev->master, ADP5520_KP_INT_STAT_2, &reg_val_hi);
-
-		keymask = (reg_val_hi << 8) | reg_val_lo;
-		/* Read twice to clear */
-		adp5520_read(dev->master, ADP5520_KP_INT_STAT_1, &reg_val_lo);
-		adp5520_read(dev->master, ADP5520_KP_INT_STAT_2, &reg_val_hi);
-		keymask |= (reg_val_hi << 8) | reg_val_lo;
-		adp5520_keys_report_event(dev, keymask, 1);
-	}
-
-	if (event & ADP5520_KR_INT) {
-		adp5520_read(dev->master, ADP5520_KR_INT_STAT_1, &reg_val_lo);
-		adp5520_read(dev->master, ADP5520_KR_INT_STAT_2, &reg_val_hi);
-
-		keymask = (reg_val_hi << 8) | reg_val_lo;
-		/* Read twice to clear */
-		adp5520_read(dev->master, ADP5520_KR_INT_STAT_1, &reg_val_lo);
-		adp5520_read(dev->master, ADP5520_KR_INT_STAT_2, &reg_val_hi);
-		keymask |= (reg_val_hi << 8) | reg_val_lo;
-		adp5520_keys_report_event(dev, keymask, 0);
-	}
-
-	return 0;
-}
-
-static int adp5520_keys_probe(struct platform_device *pdev)
-{
-	struct adp5520_keys_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct input_dev *input;
-	struct adp5520_keys *dev;
-	int ret, i;
-	unsigned char en_mask, ctl_mask = 0;
-
-	if (pdev->id != ID_ADP5520) {
-		dev_err(&pdev->dev, "only ADP5520 supports Keypad\n");
-		return -EINVAL;
-	}
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -EINVAL;
-	}
-
-	if (!(pdata->rows_en_mask && pdata->cols_en_mask))
-		return -EINVAL;
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev, "failed to alloc memory\n");
-		return -ENOMEM;
-	}
-
-	input = devm_input_allocate_device(&pdev->dev);
-	if (!input)
-		return -ENOMEM;
-
-	dev->master = pdev->dev.parent;
-	dev->input = input;
-
-	input->name = pdev->name;
-	input->phys = "adp5520-keys/input0";
-	input->dev.parent = &pdev->dev;
-
-	input->id.bustype = BUS_I2C;
-	input->id.vendor = 0x0001;
-	input->id.product = 0x5520;
-	input->id.version = 0x0001;
-
-	input->keycodesize = sizeof(dev->keycode[0]);
-	input->keycodemax = pdata->keymapsize;
-	input->keycode = dev->keycode;
-
-	memcpy(dev->keycode, pdata->keymap,
-		pdata->keymapsize * input->keycodesize);
-
-	/* setup input device */
-	__set_bit(EV_KEY, input->evbit);
-
-	if (pdata->repeat)
-		__set_bit(EV_REP, input->evbit);
-
-	for (i = 0; i < input->keycodemax; i++)
-		__set_bit(dev->keycode[i], input->keybit);
-	__clear_bit(KEY_RESERVED, input->keybit);
-
-	ret = input_register_device(input);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register input device\n");
-		return ret;
-	}
-
-	en_mask = pdata->rows_en_mask | pdata->cols_en_mask;
-
-	ret = adp5520_set_bits(dev->master, ADP5520_GPIO_CFG_1, en_mask);
-
-	if (en_mask & ADP5520_COL_C3)
-		ctl_mask |= ADP5520_C3_MODE;
-
-	if (en_mask & ADP5520_ROW_R3)
-		ctl_mask |= ADP5520_R3_MODE;
-
-	if (ctl_mask)
-		ret |= adp5520_set_bits(dev->master, ADP5520_LED_CONTROL,
-			ctl_mask);
-
-	ret |= adp5520_set_bits(dev->master, ADP5520_GPIO_PULLUP,
-		pdata->rows_en_mask);
-
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write\n");
-		return -EIO;
-	}
-
-	dev->notifier.notifier_call = adp5520_keys_notifier;
-	ret = adp5520_register_notifier(dev->master, &dev->notifier,
-			ADP5520_KP_IEN | ADP5520_KR_IEN);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register notifier\n");
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, dev);
-	return 0;
-}
-
-static void adp5520_keys_remove(struct platform_device *pdev)
-{
-	struct adp5520_keys *dev = platform_get_drvdata(pdev);
-
-	adp5520_unregister_notifier(dev->master, &dev->notifier,
-				ADP5520_KP_IEN | ADP5520_KR_IEN);
-}
-
-static struct platform_driver adp5520_keys_driver = {
-	.driver	= {
-		.name	= "adp5520-keys",
-	},
-	.probe		= adp5520_keys_probe,
-	.remove		= adp5520_keys_remove,
-};
-module_platform_driver(adp5520_keys_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Keys ADP5520 Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:adp5520-keys");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index d0d3182236be..5d6fc2a06016 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -718,17 +718,6 @@ config LEDS_LT3593
 	  LT3593 controller. This controller uses a special one-wire pulse
 	  coding protocol to set the brightness.
 
-config LEDS_ADP5520
-	tristate "LED Support for ADP5520/ADP5501 PMIC"
-	depends on LEDS_CLASS
-	depends on PMIC_ADP5520
-	help
-	  This option enables support for on-chip LED drivers found
-	  on Analog Devices ADP5520/ADP5501 PMICs.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called leds-adp5520.
-
 config LEDS_MAX5970
 	tristate "LED Support for Maxim 5970"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index a68244bd50fb..96deebbca9d5 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_LEDS_KUNIT_TEST)		+= led-test.o
 # LED Platform Drivers (keep this sorted, M-| sort)
 obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
 obj-$(CONFIG_LEDS_ACER_A500)		+= leds-acer-a500.o
-obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
diff --git a/drivers/leds/leds-adp5520.c b/drivers/leds/leds-adp5520.c
deleted file mode 100644
index 13e5bc80e56e..000000000000
--- a/drivers/leds/leds-adp5520.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * LEDs driver for Analog Devices ADP5520/ADP5501 MFD PMICs
- *
- * Copyright 2009 Analog Devices Inc.
- *
- * Loosely derived from leds-da903x:
- * Copyright (C) 2008 Compulab, Ltd.
- *	Mike Rapoport <mike@compulab.co.il>
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- *	Eric Miao <eric.miao@marvell.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/mfd/adp5520.h>
-#include <linux/slab.h>
-
-struct adp5520_led {
-	struct led_classdev	cdev;
-	struct device		*master;
-	int			id;
-	int			flags;
-};
-
-static int adp5520_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
-{
-	struct adp5520_led *led;
-
-	led = container_of(led_cdev, struct adp5520_led, cdev);
-	return adp5520_write(led->master, ADP5520_LED1_CURRENT + led->id - 1,
-			 value >> 2);
-}
-
-static int adp5520_led_setup(struct adp5520_led *led)
-{
-	struct device *dev = led->master;
-	int flags = led->flags;
-	int ret = 0;
-
-	switch (led->id) {
-	case FLAG_ID_ADP5520_LED1_ADP5501_LED0:
-		ret |= adp5520_set_bits(dev, ADP5520_LED_TIME,
-					(flags >> ADP5520_FLAG_OFFT_SHIFT) &
-					ADP5520_FLAG_OFFT_MASK);
-		ret |= adp5520_set_bits(dev, ADP5520_LED_CONTROL,
-					ADP5520_LED1_EN);
-		break;
-	case FLAG_ID_ADP5520_LED2_ADP5501_LED1:
-		ret |= adp5520_set_bits(dev,  ADP5520_LED_TIME,
-					((flags >> ADP5520_FLAG_OFFT_SHIFT) &
-					ADP5520_FLAG_OFFT_MASK) << 2);
-		ret |= adp5520_clr_bits(dev, ADP5520_LED_CONTROL,
-					 ADP5520_R3_MODE);
-		ret |= adp5520_set_bits(dev, ADP5520_LED_CONTROL,
-					ADP5520_LED2_EN);
-		break;
-	case FLAG_ID_ADP5520_LED3_ADP5501_LED2:
-		ret |= adp5520_set_bits(dev,  ADP5520_LED_TIME,
-					((flags >> ADP5520_FLAG_OFFT_SHIFT) &
-					ADP5520_FLAG_OFFT_MASK) << 4);
-		ret |= adp5520_clr_bits(dev, ADP5520_LED_CONTROL,
-					ADP5520_C3_MODE);
-		ret |= adp5520_set_bits(dev, ADP5520_LED_CONTROL,
-					ADP5520_LED3_EN);
-		break;
-	}
-
-	return ret;
-}
-
-static int adp5520_led_prepare(struct platform_device *pdev)
-{
-	struct adp5520_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device *dev = pdev->dev.parent;
-	int ret = 0;
-
-	ret |= adp5520_write(dev, ADP5520_LED1_CURRENT, 0);
-	ret |= adp5520_write(dev, ADP5520_LED2_CURRENT, 0);
-	ret |= adp5520_write(dev, ADP5520_LED3_CURRENT, 0);
-	ret |= adp5520_write(dev, ADP5520_LED_TIME, pdata->led_on_time << 6);
-	ret |= adp5520_write(dev, ADP5520_LED_FADE, FADE_VAL(pdata->fade_in,
-		 pdata->fade_out));
-
-	return ret;
-}
-
-static int adp5520_led_probe(struct platform_device *pdev)
-{
-	struct adp5520_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct adp5520_led *led, *led_dat;
-	struct led_info *cur_led;
-	int ret, i;
-
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -ENODEV;
-	}
-
-	if (pdata->num_leds > ADP5520_01_MAXLEDS) {
-		dev_err(&pdev->dev, "can't handle more than %d LEDS\n",
-				 ADP5520_01_MAXLEDS);
-		return -EFAULT;
-	}
-
-	led = devm_kcalloc(&pdev->dev, pdata->num_leds, sizeof(*led),
-				GFP_KERNEL);
-	if (!led)
-		return -ENOMEM;
-
-	ret = adp5520_led_prepare(pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to write\n");
-		return ret;
-	}
-
-	for (i = 0; i < pdata->num_leds; ++i) {
-		cur_led = &pdata->leds[i];
-		led_dat = &led[i];
-
-		led_dat->cdev.name = cur_led->name;
-		led_dat->cdev.default_trigger = cur_led->default_trigger;
-		led_dat->cdev.brightness_set_blocking = adp5520_led_set;
-		led_dat->cdev.brightness = LED_OFF;
-
-		if (cur_led->flags & ADP5520_FLAG_LED_MASK)
-			led_dat->flags = cur_led->flags;
-		else
-			led_dat->flags = i + 1;
-
-		led_dat->id = led_dat->flags & ADP5520_FLAG_LED_MASK;
-
-		led_dat->master = pdev->dev.parent;
-
-		ret = led_classdev_register(led_dat->master, &led_dat->cdev);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register LED %d\n",
-				led_dat->id);
-			goto err;
-		}
-
-		ret = adp5520_led_setup(led_dat);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to write\n");
-			i++;
-			goto err;
-		}
-	}
-
-	platform_set_drvdata(pdev, led);
-	return 0;
-
-err:
-	if (i > 0) {
-		for (i = i - 1; i >= 0; i--)
-			led_classdev_unregister(&led[i].cdev);
-	}
-
-	return ret;
-}
-
-static void adp5520_led_remove(struct platform_device *pdev)
-{
-	struct adp5520_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct adp5520_led *led;
-	int i;
-
-	led = platform_get_drvdata(pdev);
-
-	adp5520_clr_bits(led->master, ADP5520_LED_CONTROL,
-		 ADP5520_LED1_EN | ADP5520_LED2_EN | ADP5520_LED3_EN);
-
-	for (i = 0; i < pdata->num_leds; i++) {
-		led_classdev_unregister(&led[i].cdev);
-	}
-}
-
-static struct platform_driver adp5520_led_driver = {
-	.driver	= {
-		.name	= "adp5520-led",
-	},
-	.probe		= adp5520_led_probe,
-	.remove		= adp5520_led_remove,
-};
-
-module_platform_driver(adp5520_led_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("LEDS ADP5520(01) Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:adp5520-led");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b621a77619c..5126bae8e61f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -115,16 +115,6 @@ config MFD_AS3722
 	  controllers, 11 LDOs, RTC, automatic battery, temperature and
 	  over current monitoring, GPIOs, ADC and a watchdog.
 
-config PMIC_ADP5520
-	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
-	depends on I2C=y
-	help
-	  Say yes here to add support for Analog Devices ADP5520 and ADP5501,
-	  Multifunction Power Management IC. This includes
-	  the I2C driver and the core APIs _only_, you have to select
-	  individual components like LCD backlight, LEDs, GPIOs and Kepad
-	  under the corresponding menus.
-
 config MFD_AAT2870_CORE
 	bool "AnalogicTech AAT2870"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 36f0ab039b77..a6cc4fcc3e1d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -193,7 +193,6 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 # ab8500-core need to come after db8500-prcmu (which provides the channel)
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
-obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
 obj-$(CONFIG_MFD_ADP5585)	+= adp5585.o
 obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
deleted file mode 100644
index bd6f4965ebc8..000000000000
--- a/drivers/mfd/adp5520.c
+++ /dev/null
@@ -1,346 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Base driver for Analog Devices ADP5520/ADP5501 MFD PMICs
- * LCD Backlight: drivers/video/backlight/adp5520_bl
- * LEDs		: drivers/led/leds-adp5520
- * GPIO		: drivers/gpio/adp5520-gpio (ADP5520 only)
- * Keys		: drivers/input/keyboard/adp5520-keys (ADP5520 only)
- *
- * Copyright 2009 Analog Devices Inc.
- *
- * Author: Michael Hennerich <michael.hennerich@analog.com>
- *
- * Derived from da903x:
- * Copyright (C) 2008 Compulab, Ltd.
- *	Mike Rapoport <mike@compulab.co.il>
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- *	Eric Miao <eric.miao@marvell.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-
-#include <linux/mfd/adp5520.h>
-
-struct adp5520_chip {
-	struct i2c_client *client;
-	struct device *dev;
-	struct mutex lock;
-	struct blocking_notifier_head notifier_list;
-	int irq;
-	unsigned long id;
-	uint8_t mode;
-};
-
-static int __adp5520_read(struct i2c_client *client,
-				int reg, uint8_t *val)
-{
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed reading at 0x%02x\n", reg);
-		return ret;
-	}
-
-	*val = (uint8_t)ret;
-	return 0;
-}
-
-static int __adp5520_write(struct i2c_client *client,
-				 int reg, uint8_t val)
-{
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(client, reg, val);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed writing 0x%02x to 0x%02x\n",
-				val, reg);
-		return ret;
-	}
-	return 0;
-}
-
-static int __adp5520_ack_bits(struct i2c_client *client, int reg,
-			      uint8_t bit_mask)
-{
-	struct adp5520_chip *chip = i2c_get_clientdata(client);
-	uint8_t reg_val;
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = __adp5520_read(client, reg, &reg_val);
-
-	if (!ret) {
-		reg_val |= bit_mask;
-		ret = __adp5520_write(client, reg, reg_val);
-	}
-
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-
-int adp5520_write(struct device *dev, int reg, uint8_t val)
-{
-	return __adp5520_write(to_i2c_client(dev), reg, val);
-}
-EXPORT_SYMBOL_GPL(adp5520_write);
-
-int adp5520_read(struct device *dev, int reg, uint8_t *val)
-{
-	return __adp5520_read(to_i2c_client(dev), reg, val);
-}
-EXPORT_SYMBOL_GPL(adp5520_read);
-
-int adp5520_set_bits(struct device *dev, int reg, uint8_t bit_mask)
-{
-	struct adp5520_chip *chip = dev_get_drvdata(dev);
-	uint8_t reg_val;
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = __adp5520_read(chip->client, reg, &reg_val);
-
-	if (!ret && ((reg_val & bit_mask) != bit_mask)) {
-		reg_val |= bit_mask;
-		ret = __adp5520_write(chip->client, reg, reg_val);
-	}
-
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(adp5520_set_bits);
-
-int adp5520_clr_bits(struct device *dev, int reg, uint8_t bit_mask)
-{
-	struct adp5520_chip *chip = dev_get_drvdata(dev);
-	uint8_t reg_val;
-	int ret;
-
-	mutex_lock(&chip->lock);
-
-	ret = __adp5520_read(chip->client, reg, &reg_val);
-
-	if (!ret && (reg_val & bit_mask)) {
-		reg_val &= ~bit_mask;
-		ret = __adp5520_write(chip->client, reg, reg_val);
-	}
-
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(adp5520_clr_bits);
-
-int adp5520_register_notifier(struct device *dev, struct notifier_block *nb,
-				unsigned int events)
-{
-	struct adp5520_chip *chip = dev_get_drvdata(dev);
-
-	if (chip->irq) {
-		adp5520_set_bits(chip->dev, ADP5520_INTERRUPT_ENABLE,
-			events & (ADP5520_KP_IEN | ADP5520_KR_IEN |
-			ADP5520_OVP_IEN | ADP5520_CMPR_IEN));
-
-		return blocking_notifier_chain_register(&chip->notifier_list,
-			 nb);
-	}
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(adp5520_register_notifier);
-
-int adp5520_unregister_notifier(struct device *dev, struct notifier_block *nb,
-				unsigned int events)
-{
-	struct adp5520_chip *chip = dev_get_drvdata(dev);
-
-	adp5520_clr_bits(chip->dev, ADP5520_INTERRUPT_ENABLE,
-		events & (ADP5520_KP_IEN | ADP5520_KR_IEN |
-		ADP5520_OVP_IEN | ADP5520_CMPR_IEN));
-
-	return blocking_notifier_chain_unregister(&chip->notifier_list, nb);
-}
-EXPORT_SYMBOL_GPL(adp5520_unregister_notifier);
-
-static irqreturn_t adp5520_irq_thread(int irq, void *data)
-{
-	struct adp5520_chip *chip = data;
-	unsigned int events;
-	uint8_t reg_val;
-	int ret;
-
-	ret = __adp5520_read(chip->client, ADP5520_MODE_STATUS, &reg_val);
-	if (ret)
-		goto out;
-
-	events =  reg_val & (ADP5520_OVP_INT | ADP5520_CMPR_INT |
-		ADP5520_GPI_INT | ADP5520_KR_INT | ADP5520_KP_INT);
-
-	blocking_notifier_call_chain(&chip->notifier_list, events, NULL);
-	/* ACK, Sticky bits are W1C */
-	__adp5520_ack_bits(chip->client, ADP5520_MODE_STATUS, events);
-
-out:
-	return IRQ_HANDLED;
-}
-
-static int __remove_subdev(struct device *dev, void *unused)
-{
-	platform_device_unregister(to_platform_device(dev));
-	return 0;
-}
-
-static int adp5520_remove_subdevs(struct adp5520_chip *chip)
-{
-	return device_for_each_child(chip->dev, NULL, __remove_subdev);
-}
-
-static int adp5520_probe(struct i2c_client *client)
-{
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct adp5520_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct platform_device *pdev;
-	struct adp5520_chip *chip;
-	int ret;
-
-	if (!i2c_check_functionality(client->adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&client->dev, "SMBUS Word Data not Supported\n");
-		return -EIO;
-	}
-
-	if (pdata == NULL) {
-		dev_err(&client->dev, "missing platform data\n");
-		return -ENODEV;
-	}
-
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, chip);
-	chip->client = client;
-
-	chip->dev = &client->dev;
-	chip->irq = client->irq;
-	chip->id = id->driver_data;
-	mutex_init(&chip->lock);
-
-	if (chip->irq) {
-		BLOCKING_INIT_NOTIFIER_HEAD(&chip->notifier_list);
-
-		ret = request_threaded_irq(chip->irq, NULL, adp5520_irq_thread,
-				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-				"adp5520", chip);
-		if (ret) {
-			dev_err(&client->dev, "failed to request irq %d\n",
-					chip->irq);
-			return ret;
-		}
-	}
-
-	ret = adp5520_write(chip->dev, ADP5520_MODE_STATUS, ADP5520_nSTNBY);
-	if (ret) {
-		dev_err(&client->dev, "failed to write\n");
-		goto out_free_irq;
-	}
-
-	if (pdata->keys) {
-		pdev = platform_device_register_data(chip->dev, "adp5520-keys",
-				chip->id, pdata->keys, sizeof(*pdata->keys));
-		if (IS_ERR(pdev)) {
-			ret = PTR_ERR(pdev);
-			goto out_remove_subdevs;
-		}
-	}
-
-	if (pdata->gpio) {
-		pdev = platform_device_register_data(chip->dev, "adp5520-gpio",
-				chip->id, pdata->gpio, sizeof(*pdata->gpio));
-		if (IS_ERR(pdev)) {
-			ret = PTR_ERR(pdev);
-			goto out_remove_subdevs;
-		}
-	}
-
-	if (pdata->leds) {
-		pdev = platform_device_register_data(chip->dev, "adp5520-led",
-				chip->id, pdata->leds, sizeof(*pdata->leds));
-		if (IS_ERR(pdev)) {
-			ret = PTR_ERR(pdev);
-			goto out_remove_subdevs;
-		}
-	}
-
-	if (pdata->backlight) {
-		pdev = platform_device_register_data(chip->dev,
-						"adp5520-backlight",
-						chip->id,
-						pdata->backlight,
-						sizeof(*pdata->backlight));
-		if (IS_ERR(pdev)) {
-			ret = PTR_ERR(pdev);
-			goto out_remove_subdevs;
-		}
-	}
-
-	return 0;
-
-out_remove_subdevs:
-	adp5520_remove_subdevs(chip);
-
-out_free_irq:
-	if (chip->irq)
-		free_irq(chip->irq, chip);
-
-	return ret;
-}
-
-static int adp5520_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adp5520_chip *chip = dev_get_drvdata(&client->dev);
-
-	adp5520_read(chip->dev, ADP5520_MODE_STATUS, &chip->mode);
-	/* All other bits are W1C */
-	chip->mode &= ADP5520_BL_EN | ADP5520_DIM_EN | ADP5520_nSTNBY;
-	adp5520_write(chip->dev, ADP5520_MODE_STATUS, 0);
-	return 0;
-}
-
-static int adp5520_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adp5520_chip *chip = dev_get_drvdata(&client->dev);
-
-	adp5520_write(chip->dev, ADP5520_MODE_STATUS, chip->mode);
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend, adp5520_resume);
-
-static const struct i2c_device_id adp5520_id[] = {
-	{ "pmic-adp5520", ID_ADP5520 },
-	{ "pmic-adp5501", ID_ADP5501 },
-	{ }
-};
-
-static struct i2c_driver adp5520_driver = {
-	.driver = {
-		.name			= "adp5520",
-		.pm			= pm_sleep_ptr(&adp5520_pm),
-		.suppress_bind_attrs	= true,
-	},
-	.probe		= adp5520_probe,
-	.id_table	= adp5520_id,
-};
-builtin_i2c_driver(adp5520_driver);
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index dbf4ca23a9b6..63e5059563b4 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -365,16 +365,6 @@ config BACKLIGHT_WM831X
 	  If you have a backlight driven by the ISINK and DCDC of a
 	  WM831x PMIC say y to enable the backlight driver for it.
 
-config BACKLIGHT_ADP5520
-	tristate "Backlight Driver for ADP5520/ADP5501 using WLED"
-	depends on PMIC_ADP5520
-	help
-	  If you have a LCD backlight connected to the BST/BL_SNK output of
-	  ADP5520 or ADP5501, say Y here to enable this driver.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called adp5520_bl.
-
 config BACKLIGHT_ADP8860
 	tristate "Backlight Driver for ADP8860/ADP8861/ADP8863 using WLED"
 	depends on I2C
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 34469711c6cd..1a6bef13430b 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_LCD_VGG2432A4)		+= vgg2432a4.o
 
 obj-$(CONFIG_BACKLIGHT_88PM860X)	+= 88pm860x_bl.o
 obj-$(CONFIG_BACKLIGHT_AAT2870)		+= aat2870_bl.o
-obj-$(CONFIG_BACKLIGHT_ADP5520)		+= adp5520_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP8860)		+= adp8860_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP8870)		+= adp8870_bl.o
 obj-$(CONFIG_BACKLIGHT_APPLE)		+= apple_bl.o
diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
deleted file mode 100644
index 81c40d355aae..000000000000
--- a/drivers/video/backlight/adp5520_bl.c
+++ /dev/null
@@ -1,385 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Backlight driver for Analog Devices ADP5520/ADP5501 MFD PMICs
- *
- * Copyright 2009 Analog Devices Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/backlight.h>
-#include <linux/mfd/adp5520.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-
-struct adp5520_bl {
-	struct device *master;
-	struct adp5520_backlight_platform_data *pdata;
-	struct mutex lock;
-	unsigned long cached_daylight_max;
-	int id;
-	int current_brightness;
-};
-
-static int adp5520_bl_set(struct backlight_device *bl, int brightness)
-{
-	struct adp5520_bl *data = bl_get_data(bl);
-	struct device *master = data->master;
-	int ret = 0;
-
-	if (data->pdata->en_ambl_sens) {
-		if ((brightness > 0) && (brightness < ADP5020_MAX_BRIGHTNESS)) {
-			/* Disable Ambient Light auto adjust */
-			ret |= adp5520_clr_bits(master, ADP5520_BL_CONTROL,
-					ADP5520_BL_AUTO_ADJ);
-			ret |= adp5520_write(master, ADP5520_DAYLIGHT_MAX,
-					brightness);
-		} else {
-			/*
-			 * MAX_BRIGHTNESS -> Enable Ambient Light auto adjust
-			 * restore daylight l3 sysfs brightness
-			 */
-			ret |= adp5520_write(master, ADP5520_DAYLIGHT_MAX,
-					 data->cached_daylight_max);
-			ret |= adp5520_set_bits(master, ADP5520_BL_CONTROL,
-					 ADP5520_BL_AUTO_ADJ);
-		}
-	} else {
-		ret |= adp5520_write(master, ADP5520_DAYLIGHT_MAX, brightness);
-	}
-
-	if (data->current_brightness && brightness == 0)
-		ret |= adp5520_set_bits(master,
-				ADP5520_MODE_STATUS, ADP5520_DIM_EN);
-	else if (data->current_brightness == 0 && brightness)
-		ret |= adp5520_clr_bits(master,
-				ADP5520_MODE_STATUS, ADP5520_DIM_EN);
-
-	if (!ret)
-		data->current_brightness = brightness;
-
-	return ret;
-}
-
-static int adp5520_bl_update_status(struct backlight_device *bl)
-{
-	return adp5520_bl_set(bl, backlight_get_brightness(bl));
-}
-
-static int adp5520_bl_get_brightness(struct backlight_device *bl)
-{
-	struct adp5520_bl *data = bl_get_data(bl);
-	int error;
-	uint8_t reg_val;
-
-	error = adp5520_read(data->master, ADP5520_BL_VALUE, &reg_val);
-
-	return error ? data->current_brightness : reg_val;
-}
-
-static const struct backlight_ops adp5520_bl_ops = {
-	.update_status	= adp5520_bl_update_status,
-	.get_brightness	= adp5520_bl_get_brightness,
-};
-
-static int adp5520_bl_setup(struct backlight_device *bl)
-{
-	struct adp5520_bl *data = bl_get_data(bl);
-	struct device *master = data->master;
-	struct adp5520_backlight_platform_data *pdata = data->pdata;
-	int ret = 0;
-
-	ret |= adp5520_write(master, ADP5520_DAYLIGHT_MAX,
-				pdata->l1_daylight_max);
-	ret |= adp5520_write(master, ADP5520_DAYLIGHT_DIM,
-				pdata->l1_daylight_dim);
-
-	if (pdata->en_ambl_sens) {
-		data->cached_daylight_max = pdata->l1_daylight_max;
-		ret |= adp5520_write(master, ADP5520_OFFICE_MAX,
-				pdata->l2_office_max);
-		ret |= adp5520_write(master, ADP5520_OFFICE_DIM,
-				pdata->l2_office_dim);
-		ret |= adp5520_write(master, ADP5520_DARK_MAX,
-				pdata->l3_dark_max);
-		ret |= adp5520_write(master, ADP5520_DARK_DIM,
-				pdata->l3_dark_dim);
-		ret |= adp5520_write(master, ADP5520_L2_TRIP,
-				pdata->l2_trip);
-		ret |= adp5520_write(master, ADP5520_L2_HYS,
-				pdata->l2_hyst);
-		ret |= adp5520_write(master, ADP5520_L3_TRIP,
-				 pdata->l3_trip);
-		ret |= adp5520_write(master, ADP5520_L3_HYS,
-				pdata->l3_hyst);
-		ret |= adp5520_write(master, ADP5520_ALS_CMPR_CFG,
-				ALS_CMPR_CFG_VAL(pdata->abml_filt,
-				ADP5520_L3_EN));
-	}
-
-	ret |= adp5520_write(master, ADP5520_BL_CONTROL,
-			BL_CTRL_VAL(pdata->fade_led_law,
-					pdata->en_ambl_sens));
-
-	ret |= adp5520_write(master, ADP5520_BL_FADE, FADE_VAL(pdata->fade_in,
-			pdata->fade_out));
-
-	ret |= adp5520_set_bits(master, ADP5520_MODE_STATUS,
-			ADP5520_BL_EN | ADP5520_DIM_EN);
-
-	return ret;
-}
-
-static ssize_t adp5520_show(struct device *dev, char *buf, int reg)
-{
-	struct adp5520_bl *data = dev_get_drvdata(dev);
-	int ret;
-	uint8_t reg_val;
-
-	mutex_lock(&data->lock);
-	ret = adp5520_read(data->master, reg, &reg_val);
-	mutex_unlock(&data->lock);
-
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%u\n", reg_val);
-}
-
-static ssize_t adp5520_store(struct device *dev, const char *buf,
-			 size_t count, int reg)
-{
-	struct adp5520_bl *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&data->lock);
-	adp5520_write(data->master, reg, val);
-	mutex_unlock(&data->lock);
-
-	return count;
-}
-
-static ssize_t adp5520_bl_dark_max_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_DARK_MAX);
-}
-
-static ssize_t adp5520_bl_dark_max_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	return adp5520_store(dev, buf, count, ADP5520_DARK_MAX);
-}
-static DEVICE_ATTR(dark_max, 0664, adp5520_bl_dark_max_show,
-			adp5520_bl_dark_max_store);
-
-static ssize_t adp5520_bl_office_max_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_OFFICE_MAX);
-}
-
-static ssize_t adp5520_bl_office_max_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	return adp5520_store(dev, buf, count, ADP5520_OFFICE_MAX);
-}
-static DEVICE_ATTR(office_max, 0664, adp5520_bl_office_max_show,
-			adp5520_bl_office_max_store);
-
-static ssize_t adp5520_bl_daylight_max_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_DAYLIGHT_MAX);
-}
-
-static ssize_t adp5520_bl_daylight_max_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	struct adp5520_bl *data = dev_get_drvdata(dev);
-	int ret;
-
-	ret = kstrtoul(buf, 10, &data->cached_daylight_max);
-	if (ret < 0)
-		return ret;
-
-	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);
-}
-static DEVICE_ATTR(daylight_max, 0664, adp5520_bl_daylight_max_show,
-			adp5520_bl_daylight_max_store);
-
-static ssize_t adp5520_bl_dark_dim_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_DARK_DIM);
-}
-
-static ssize_t adp5520_bl_dark_dim_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	return adp5520_store(dev, buf, count, ADP5520_DARK_DIM);
-}
-static DEVICE_ATTR(dark_dim, 0664, adp5520_bl_dark_dim_show,
-			adp5520_bl_dark_dim_store);
-
-static ssize_t adp5520_bl_office_dim_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_OFFICE_DIM);
-}
-
-static ssize_t adp5520_bl_office_dim_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	return adp5520_store(dev, buf, count, ADP5520_OFFICE_DIM);
-}
-static DEVICE_ATTR(office_dim, 0664, adp5520_bl_office_dim_show,
-			adp5520_bl_office_dim_store);
-
-static ssize_t adp5520_bl_daylight_dim_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	return adp5520_show(dev, buf, ADP5520_DAYLIGHT_DIM);
-}
-
-static ssize_t adp5520_bl_daylight_dim_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_DIM);
-}
-static DEVICE_ATTR(daylight_dim, 0664, adp5520_bl_daylight_dim_show,
-			adp5520_bl_daylight_dim_store);
-
-static struct attribute *adp5520_bl_attributes[] = {
-	&dev_attr_dark_max.attr,
-	&dev_attr_dark_dim.attr,
-	&dev_attr_office_max.attr,
-	&dev_attr_office_dim.attr,
-	&dev_attr_daylight_max.attr,
-	&dev_attr_daylight_dim.attr,
-	NULL
-};
-
-static const struct attribute_group adp5520_bl_attr_group = {
-	.attrs = adp5520_bl_attributes,
-};
-
-static int adp5520_bl_probe(struct platform_device *pdev)
-{
-	struct backlight_properties props;
-	struct backlight_device *bl;
-	struct adp5520_bl *data;
-	int ret = 0;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
-	data->master = pdev->dev.parent;
-	data->pdata = dev_get_platdata(&pdev->dev);
-
-	if (data->pdata  == NULL) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -ENODEV;
-	}
-
-	data->id = pdev->id;
-	data->current_brightness = 0;
-
-	mutex_init(&data->lock);
-
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = ADP5020_MAX_BRIGHTNESS;
-	bl = devm_backlight_device_register(&pdev->dev, pdev->name,
-					data->master, data, &adp5520_bl_ops,
-					&props);
-	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
-		return PTR_ERR(bl);
-	}
-
-	bl->props.brightness = ADP5020_MAX_BRIGHTNESS;
-	if (data->pdata->en_ambl_sens)
-		ret = sysfs_create_group(&bl->dev.kobj,
-			&adp5520_bl_attr_group);
-
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register sysfs\n");
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, bl);
-	ret = adp5520_bl_setup(bl);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to setup\n");
-		if (data->pdata->en_ambl_sens)
-			sysfs_remove_group(&bl->dev.kobj,
-					&adp5520_bl_attr_group);
-		return ret;
-	}
-
-	backlight_update_status(bl);
-
-	return 0;
-}
-
-static void adp5520_bl_remove(struct platform_device *pdev)
-{
-	struct backlight_device *bl = platform_get_drvdata(pdev);
-	struct adp5520_bl *data = bl_get_data(bl);
-
-	adp5520_clr_bits(data->master, ADP5520_MODE_STATUS, ADP5520_BL_EN);
-
-	if (data->pdata->en_ambl_sens)
-		sysfs_remove_group(&bl->dev.kobj,
-				&adp5520_bl_attr_group);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int adp5520_bl_suspend(struct device *dev)
-{
-	struct backlight_device *bl = dev_get_drvdata(dev);
-
-	return adp5520_bl_set(bl, 0);
-}
-
-static int adp5520_bl_resume(struct device *dev)
-{
-	struct backlight_device *bl = dev_get_drvdata(dev);
-
-	backlight_update_status(bl);
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(adp5520_bl_pm_ops, adp5520_bl_suspend,
-			adp5520_bl_resume);
-
-static struct platform_driver adp5520_bl_driver = {
-	.driver		= {
-		.name	= "adp5520-backlight",
-		.pm	= &adp5520_bl_pm_ops,
-	},
-	.probe		= adp5520_bl_probe,
-	.remove		= adp5520_bl_remove,
-};
-
-module_platform_driver(adp5520_bl_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("ADP5520(01) Backlight Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:adp5520-backlight");
diff --git a/include/linux/mfd/adp5520.h b/include/linux/mfd/adp5520.h
deleted file mode 100644
index 9a14f80ec4ad..000000000000
--- a/include/linux/mfd/adp5520.h
+++ /dev/null
@@ -1,298 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Definitions and platform data for Analog Devices
- * ADP5520/ADP5501 MFD PMICs (Backlight, LED, GPIO and Keys)
- *
- * Copyright 2009 Analog Devices Inc.
- */
-
-
-#ifndef __LINUX_MFD_ADP5520_H
-#define __LINUX_MFD_ADP5520_H
-
-#define ID_ADP5520		5520
-#define ID_ADP5501		5501
-
-/*
- * ADP5520/ADP5501 Register Map
- */
-
-#define ADP5520_MODE_STATUS 		0x00
-#define ADP5520_INTERRUPT_ENABLE 	0x01
-#define ADP5520_BL_CONTROL 		0x02
-#define ADP5520_BL_TIME 		0x03
-#define ADP5520_BL_FADE 		0x04
-#define ADP5520_DAYLIGHT_MAX 		0x05
-#define ADP5520_DAYLIGHT_DIM 		0x06
-#define ADP5520_OFFICE_MAX 		0x07
-#define ADP5520_OFFICE_DIM 		0x08
-#define ADP5520_DARK_MAX 		0x09
-#define ADP5520_DARK_DIM 		0x0A
-#define ADP5520_BL_VALUE 		0x0B
-#define ADP5520_ALS_CMPR_CFG 		0x0C
-#define ADP5520_L2_TRIP 		0x0D
-#define ADP5520_L2_HYS 			0x0E
-#define ADP5520_L3_TRIP 		0x0F
-#define ADP5520_L3_HYS 			0x10
-#define ADP5520_LED_CONTROL 		0x11
-#define ADP5520_LED_TIME 		0x12
-#define ADP5520_LED_FADE 		0x13
-#define ADP5520_LED1_CURRENT 		0x14
-#define ADP5520_LED2_CURRENT 		0x15
-#define ADP5520_LED3_CURRENT 		0x16
-
-/*
- * ADP5520 Register Map
- */
-
-#define ADP5520_GPIO_CFG_1 		0x17
-#define ADP5520_GPIO_CFG_2 		0x18
-#define ADP5520_GPIO_IN 		0x19
-#define ADP5520_GPIO_OUT 		0x1A
-#define ADP5520_GPIO_INT_EN 		0x1B
-#define ADP5520_GPIO_INT_STAT 		0x1C
-#define ADP5520_GPIO_INT_LVL 		0x1D
-#define ADP5520_GPIO_DEBOUNCE 		0x1E
-#define ADP5520_GPIO_PULLUP 		0x1F
-#define ADP5520_KP_INT_STAT_1 		0x20
-#define ADP5520_KP_INT_STAT_2 		0x21
-#define ADP5520_KR_INT_STAT_1 		0x22
-#define ADP5520_KR_INT_STAT_2 		0x23
-#define ADP5520_KEY_STAT_1 		0x24
-#define ADP5520_KEY_STAT_2 		0x25
-
-/*
- * MODE_STATUS bits
- */
-
-#define ADP5520_nSTNBY		(1 << 7)
-#define ADP5520_BL_EN           (1 << 6)
-#define ADP5520_DIM_EN          (1 << 5)
-#define ADP5520_OVP_INT         (1 << 4)
-#define ADP5520_CMPR_INT        (1 << 3)
-#define ADP5520_GPI_INT         (1 << 2)
-#define ADP5520_KR_INT          (1 << 1)
-#define ADP5520_KP_INT          (1 << 0)
-
-/*
- * INTERRUPT_ENABLE bits
- */
-
-#define ADP5520_AUTO_LD_EN      (1 << 4)
-#define ADP5520_CMPR_IEN        (1 << 3)
-#define ADP5520_OVP_IEN         (1 << 2)
-#define ADP5520_KR_IEN          (1 << 1)
-#define ADP5520_KP_IEN          (1 << 0)
-
-/*
- * BL_CONTROL bits
- */
-
-#define ADP5520_BL_LVL          ((x) << 5)
-#define ADP5520_BL_LAW          ((x) << 4)
-#define ADP5520_BL_AUTO_ADJ     (1 << 3)
-#define ADP5520_OVP_EN          (1 << 2)
-#define ADP5520_FOVR            (1 << 1)
-#define ADP5520_KP_BL_EN        (1 << 0)
-
-/*
- * ALS_CMPR_CFG bits
- */
-
-#define ADP5520_L3_OUT		(1 << 3)
-#define ADP5520_L2_OUT		(1 << 2)
-#define ADP5520_L3_EN		(1 << 1)
-
-#define ADP5020_MAX_BRIGHTNESS	0x7F
-
-#define FADE_VAL(in, out)	((0xF & (in)) | ((0xF & (out)) << 4))
-#define BL_CTRL_VAL(law, auto)	(((1 & (auto)) << 3) | ((0x3 & (law)) << 4))
-#define ALS_CMPR_CFG_VAL(filt, l3_en)	(((0x7 & filt) << 5) | l3_en)
-
-/*
- * LEDs subdevice bits and masks
- */
-
-#define ADP5520_01_MAXLEDS 3
-
-#define ADP5520_FLAG_LED_MASK 		0x3
-#define ADP5520_FLAG_OFFT_SHIFT 	8
-#define ADP5520_FLAG_OFFT_MASK 		0x3
-
-#define ADP5520_R3_MODE		(1 << 5)
-#define ADP5520_C3_MODE		(1 << 4)
-#define ADP5520_LED_LAW		(1 << 3)
-#define ADP5520_LED3_EN		(1 << 2)
-#define ADP5520_LED2_EN		(1 << 1)
-#define ADP5520_LED1_EN		(1 << 0)
-
-/*
- * GPIO subdevice bits and masks
- */
-
-#define ADP5520_MAXGPIOS	8
-
-#define ADP5520_GPIO_C3		(1 << 7)	/* LED2 or GPIO7 aka C3 */
-#define ADP5520_GPIO_C2		(1 << 6)
-#define ADP5520_GPIO_C1		(1 << 5)
-#define ADP5520_GPIO_C0		(1 << 4)
-#define ADP5520_GPIO_R3		(1 << 3)	/* LED3 or GPIO3 aka R3 */
-#define ADP5520_GPIO_R2		(1 << 2)
-#define ADP5520_GPIO_R1		(1 << 1)
-#define ADP5520_GPIO_R0		(1 << 0)
-
-struct adp5520_gpio_platform_data {
-	unsigned gpio_start;
-	u8 gpio_en_mask;
-	u8 gpio_pullup_mask;
-};
-
-/*
- * Keypad subdevice bits and masks
- */
-
-#define ADP5520_MAXKEYS	16
-
-#define ADP5520_COL_C3 		(1 << 7)	/* LED2 or GPIO7 aka C3 */
-#define ADP5520_COL_C2		(1 << 6)
-#define ADP5520_COL_C1		(1 << 5)
-#define ADP5520_COL_C0		(1 << 4)
-#define ADP5520_ROW_R3		(1 << 3)	/* LED3 or GPIO3 aka R3 */
-#define ADP5520_ROW_R2		(1 << 2)
-#define ADP5520_ROW_R1		(1 << 1)
-#define ADP5520_ROW_R0		(1 << 0)
-
-#define ADP5520_KEY(row, col) (col + row * 4)
-#define ADP5520_KEYMAPSIZE	ADP5520_MAXKEYS
-
-struct adp5520_keys_platform_data {
-	int rows_en_mask;		/* Number of rows */
-	int cols_en_mask;		/* Number of columns */
-	const unsigned short *keymap;	/* Pointer to keymap */
-	unsigned short keymapsize;	/* Keymap size */
-	unsigned repeat:1;		/* Enable key repeat */
-};
-
-
-/*
- * LEDs subdevice platform data
- */
-
-#define FLAG_ID_ADP5520_LED1_ADP5501_LED0 	1	/* ADP5520 PIN ILED */
-#define FLAG_ID_ADP5520_LED2_ADP5501_LED1 	2	/* ADP5520 PIN C3 */
-#define FLAG_ID_ADP5520_LED3_ADP5501_LED2 	3	/* ADP5520 PIN R3 */
-
-#define ADP5520_LED_DIS_BLINK	(0 << ADP5520_FLAG_OFFT_SHIFT)
-#define ADP5520_LED_OFFT_600ms	(1 << ADP5520_FLAG_OFFT_SHIFT)
-#define ADP5520_LED_OFFT_800ms	(2 << ADP5520_FLAG_OFFT_SHIFT)
-#define ADP5520_LED_OFFT_1200ms	(3 << ADP5520_FLAG_OFFT_SHIFT)
-
-#define ADP5520_LED_ONT_200ms	0
-#define ADP5520_LED_ONT_600ms	1
-#define ADP5520_LED_ONT_800ms	2
-#define ADP5520_LED_ONT_1200ms	3
-
-struct adp5520_leds_platform_data {
-	int num_leds;
-	struct led_info	*leds;
-	u8 fade_in;		/* Backlight Fade-In Timer */
-	u8 fade_out;		/* Backlight Fade-Out Timer */
-	u8 led_on_time;
-};
-
-/*
- * Backlight subdevice platform data
- */
-
-#define ADP5520_FADE_T_DIS	0	/* Fade Timer Disabled */
-#define ADP5520_FADE_T_300ms	1	/* 0.3 Sec */
-#define ADP5520_FADE_T_600ms	2
-#define ADP5520_FADE_T_900ms	3
-#define ADP5520_FADE_T_1200ms	4
-#define ADP5520_FADE_T_1500ms	5
-#define ADP5520_FADE_T_1800ms	6
-#define ADP5520_FADE_T_2100ms	7
-#define ADP5520_FADE_T_2400ms	8
-#define ADP5520_FADE_T_2700ms	9
-#define ADP5520_FADE_T_3000ms	10
-#define ADP5520_FADE_T_3500ms	11
-#define ADP5520_FADE_T_4000ms	12
-#define ADP5520_FADE_T_4500ms	13
-#define ADP5520_FADE_T_5000ms	14
-#define ADP5520_FADE_T_5500ms	15	/* 5.5 Sec */
-
-#define ADP5520_BL_LAW_LINEAR 	0
-#define ADP5520_BL_LAW_SQUARE 	1
-#define ADP5520_BL_LAW_CUBIC1 	2
-#define ADP5520_BL_LAW_CUBIC2 	3
-
-#define ADP5520_BL_AMBL_FILT_80ms 	0	/* Light sensor filter time */
-#define ADP5520_BL_AMBL_FILT_160ms 	1
-#define ADP5520_BL_AMBL_FILT_320ms 	2
-#define ADP5520_BL_AMBL_FILT_640ms 	3
-#define ADP5520_BL_AMBL_FILT_1280ms 	4
-#define ADP5520_BL_AMBL_FILT_2560ms 	5
-#define ADP5520_BL_AMBL_FILT_5120ms 	6
-#define ADP5520_BL_AMBL_FILT_10240ms 	7	/* 10.24 sec */
-
-	/*
-	 * Blacklight current 0..30mA
-	 */
-#define ADP5520_BL_CUR_mA(I)		((I * 127) / 30)
-
-	/*
-	 * L2 comparator current 0..1000uA
-	 */
-#define ADP5520_L2_COMP_CURR_uA(I)	((I * 255) / 1000)
-
-	/*
-	 * L3 comparator current 0..127uA
-	 */
-#define ADP5520_L3_COMP_CURR_uA(I)	((I * 255) / 127)
-
-struct adp5520_backlight_platform_data {
-	u8 fade_in;		/* Backlight Fade-In Timer */
-	u8 fade_out;		/* Backlight Fade-Out Timer */
-	u8 fade_led_law;	/* fade-on/fade-off transfer characteristic */
-
-	u8 en_ambl_sens;	/* 1 = enable ambient light sensor */
-	u8 abml_filt;		/* Light sensor filter time */
-	u8 l1_daylight_max;	/* use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l1_daylight_dim;	/* typ = 0, use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l2_office_max;	/* use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l2_office_dim;	/* typ = 0, use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l3_dark_max;		/* use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l3_dark_dim;		/* typ = 0, use BL_CUR_mA(I) 0 <= I <= 30 mA */
-	u8 l2_trip;		/* use L2_COMP_CURR_uA(I) 0 <= I <= 1000 uA */
-	u8 l2_hyst;		/* use L2_COMP_CURR_uA(I) 0 <= I <= 1000 uA */
-	u8 l3_trip;		/* use L3_COMP_CURR_uA(I) 0 <= I <= 127 uA */
-	u8 l3_hyst;		/* use L3_COMP_CURR_uA(I) 0 <= I <= 127 uA */
-};
-
-/*
- * MFD chip platform data
- */
-
-struct adp5520_platform_data {
-	struct adp5520_keys_platform_data *keys;
-	struct adp5520_gpio_platform_data *gpio;
-	struct adp5520_leds_platform_data *leds;
-	struct adp5520_backlight_platform_data *backlight;
-};
-
-/*
- * MFD chip functions
- */
-
-extern int adp5520_read(struct device *dev, int reg, uint8_t *val);
-extern int adp5520_write(struct device *dev, int reg, u8 val);
-extern int adp5520_clr_bits(struct device *dev, int reg, uint8_t bit_mask);
-extern int adp5520_set_bits(struct device *dev, int reg, uint8_t bit_mask);
-
-extern int adp5520_register_notifier(struct device *dev,
-		 struct notifier_block *nb, unsigned int events);
-
-extern int adp5520_unregister_notifier(struct device *dev,
-		struct notifier_block *nb, unsigned int events);
-
-#endif /* __LINUX_MFD_ADP5520_H */
-- 
2.53.0


