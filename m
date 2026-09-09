Return-Path: <linuxppc-dev+bounces-26933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B9DC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:23:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1jN4msqz2yvG;
	Wed, 09 Sep 2026 23:23:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960232;
	cv=none; b=hzWWqrCmjqpjAEuXWtE8DaiYsQMHEP/a7S4gqzewbLYcMkpO96IbUXgMm2e+GbnDXktSr3YKCWrGRFe98Br0euwN0MDE594es7mHNz3oAQM5xsHIy3zdWTvJTQDrCXww6hT7L661yN/ghTp2PD2xxtM/JnAU5MZv68v/6lTxv1DS1mfTpjwKB+L/hHT6OALlXOsv14EUMetBqba7cRkykGDFi/crU/NZ3Ms1Z+HboF7MoFSv39+N7CgHObtJ0fKX05fPD9MDxSZ2Tf0A8ucSo3T2UszfkUaq6+ltAySLwz3IDbiHwSHj0aV4P5UIPybNXAAwIVCrA1bjnjDnEApXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960232; c=relaxed/relaxed;
	bh=Rzqj9n9ksmFbc/J8Q4xJvrVQ5z2IsqWrXw7zLxE+N3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5/Sb7ajWxWqJgpfhR8qc3inSw31ZXmFqhoW0LhWy7JcIYCZiUe+njoaifNbZnc5MCemW3gGnav3dMXns9NiSLXriyVpU7ART0oDvE68C28mlnQUg7zgh8Wq58XCBhnrlPKiqpxobSRi57GXgWaykcxzxT+dJsmOXv3p+nSUAaS/MghdFdTW6fGoArEnnq7Q5AOlUl+b5D2R4ojyUmCh9bZ2W9QONZjFag5FTiM0kAhYu3QV1UwpxTRFdStw6ua/4GSGs8PYLRncm2SM9oICOU+wby0wHvyx6aQNEnnXkU3SMtQQzqFFLcPlRfctyfyL6OKigY6lJjOgYn7p90sqmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmmFcvSg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmmFcvSg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1jJ6v4mz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:23:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF65E60237;
	Wed,  9 Sep 2026 13:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46DE1F00A3A;
	Wed,  9 Sep 2026 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960226;
	bh=Rzqj9n9ksmFbc/J8Q4xJvrVQ5z2IsqWrXw7zLxE+N3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmmFcvSgOFU1+pKyl8+XWfB/vmc70tmASxMPKANKt5lqbG3zO6xSTC/Yx5fppIkXd
	 2aRvzVX5uFoGccjw/RMJ5USJsvUaBasCAReZ3nY15y35A5qZz//VyG3zDi7JONsknq
	 F/W5FBSuv5t1grV/l2pL0R9AMbX6IOb7e7yNHYcEWFSBbMstgNbmbw9qJ71Jp6Jzz2
	 7Z8RYFE4Zj9GXVQJFT2lH7xo+xdSOTfZwc0Yskps7h7fMOnCBFEBaN+a5V5xnbXkg3
	 phzKE9UiaX9y+tmHE6nye3CXCo4eyx9H4XzQyz1kYyqOt6R4M7iSqxIbTBttKBxbTk
	 Xp0xEg8PVwQbQ==
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
Subject: [PATCH 10/14] mfd: remove unused rc5t583 driver
Date: Wed,  9 Sep 2026 15:21:47 +0200
Message-ID: <20260909132153.1596191-11-arnd@kernel.org>
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

Ricoh RC5T583 support was added in 2012, but no upstream code ever
defined the corresponding platform_data, and there is no devicetree
support, so this is all dead code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig                   |  14 -
 drivers/mfd/Makefile                  |   1 -
 drivers/mfd/rc5t583-irq.c             | 383 --------------------------
 drivers/mfd/rc5t583.c                 | 299 --------------------
 drivers/regulator/Kconfig             |  10 -
 drivers/regulator/Makefile            |   1 -
 drivers/regulator/rc5t583-regulator.c | 171 ------------
 drivers/rtc/Kconfig                   |  10 -
 drivers/rtc/Makefile                  |   1 -
 drivers/rtc/rtc-rc5t583.c             | 312 ---------------------
 include/linux/mfd/rc5t583.h           | 369 -------------------------
 11 files changed, 1571 deletions(-)
 delete mode 100644 drivers/mfd/rc5t583-irq.c
 delete mode 100644 drivers/mfd/rc5t583.c
 delete mode 100644 drivers/regulator/rc5t583-regulator.c
 delete mode 100644 drivers/rtc/rtc-rc5t583.c
 delete mode 100644 include/linux/mfd/rc5t583.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2cb2efafa8a4..fbcc45d2b0c4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1291,20 +1291,6 @@ config MFD_RT5120
 	  is targeted at providing the CPU voltage, memory, I/O and peripheral
 	  power rails in home entertainment devices.
 
-config MFD_RC5T583
-	bool "Ricoh RC5T583 Power Management system device"
-	depends on I2C=y
-	select MFD_CORE
-	select REGMAP_I2C
-	help
-	  Select this option to get support for the RICOH583 Power
-	  Management system device.
-	  This driver provides common support for accessing the device
-	  through i2c interface. The device supports multiple sub-devices
-	  like GPIO, interrupts, RTC, LDO and DCDC regulators, onkey.
-	  Additional drivers must be enabled in order to use the
-	  different functionality of the device.
-
 config MFD_RK8XX
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8bd4c3e218bb..7aaad5855681 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -217,7 +217,6 @@ obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
-obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
 obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
diff --git a/drivers/mfd/rc5t583-irq.c b/drivers/mfd/rc5t583-irq.c
deleted file mode 100644
index 97f52b671520..000000000000
--- a/drivers/mfd/rc5t583-irq.c
+++ /dev/null
@@ -1,383 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Interrupt driver for RICOH583 power management chip.
- *
- * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
- * Author: Laxman dewangan <ldewangan@nvidia.com>
- *
- * based on code
- *      Copyright (C) 2011 RICOH COMPANY,LTD
- */
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mfd/rc5t583.h>
-
-enum int_type {
-	SYS_INT  = 0x1,
-	DCDC_INT = 0x2,
-	RTC_INT  = 0x4,
-	ADC_INT  = 0x8,
-	GPIO_INT = 0x10,
-};
-
-static int gpedge_add[] = {
-	RC5T583_GPIO_GPEDGE2,
-	RC5T583_GPIO_GPEDGE2
-};
-
-static int irq_en_add[] = {
-	RC5T583_INT_EN_SYS1,
-	RC5T583_INT_EN_SYS2,
-	RC5T583_INT_EN_DCDC,
-	RC5T583_INT_EN_RTC,
-	RC5T583_INT_EN_ADC1,
-	RC5T583_INT_EN_ADC2,
-	RC5T583_INT_EN_ADC3,
-	RC5T583_GPIO_EN_INT
-};
-
-static int irq_mon_add[] = {
-	RC5T583_INT_MON_SYS1,
-	RC5T583_INT_MON_SYS2,
-	RC5T583_INT_MON_DCDC,
-	RC5T583_INT_MON_RTC,
-	RC5T583_INT_IR_ADCL,
-	RC5T583_INT_IR_ADCH,
-	RC5T583_INT_IR_ADCEND,
-	RC5T583_INT_IR_GPIOF,
-	RC5T583_INT_IR_GPIOR
-};
-
-static int irq_clr_add[] = {
-	RC5T583_INT_IR_SYS1,
-	RC5T583_INT_IR_SYS2,
-	RC5T583_INT_IR_DCDC,
-	RC5T583_INT_IR_RTC,
-	RC5T583_INT_IR_ADCL,
-	RC5T583_INT_IR_ADCH,
-	RC5T583_INT_IR_ADCEND,
-	RC5T583_INT_IR_GPIOF,
-	RC5T583_INT_IR_GPIOR
-};
-
-static int main_int_type[] = {
-	SYS_INT,
-	SYS_INT,
-	DCDC_INT,
-	RTC_INT,
-	ADC_INT,
-	ADC_INT,
-	ADC_INT,
-	GPIO_INT,
-	GPIO_INT,
-};
-
-struct rc5t583_irq_data {
-	u8	int_type;
-	u8	master_bit;
-	u8	int_en_bit;
-	u8	mask_reg_index;
-	int	grp_index;
-};
-
-#define RC5T583_IRQ(_int_type, _master_bit, _grp_index, \
-			_int_bit, _mask_ind)		\
-	{						\
-		.int_type	= _int_type,		\
-		.master_bit	= _master_bit,		\
-		.grp_index	= _grp_index,		\
-		.int_en_bit	= _int_bit,		\
-		.mask_reg_index	= _mask_ind,		\
-	}
-
-static const struct rc5t583_irq_data rc5t583_irqs[RC5T583_MAX_IRQS] = {
-	[RC5T583_IRQ_ONKEY]		= RC5T583_IRQ(SYS_INT,  0, 0, 0, 0),
-	[RC5T583_IRQ_ACOK]		= RC5T583_IRQ(SYS_INT,  0, 1, 1, 0),
-	[RC5T583_IRQ_LIDOPEN]		= RC5T583_IRQ(SYS_INT,  0, 2, 2, 0),
-	[RC5T583_IRQ_PREOT]		= RC5T583_IRQ(SYS_INT,  0, 3, 3, 0),
-	[RC5T583_IRQ_CLKSTP]		= RC5T583_IRQ(SYS_INT,  0, 4, 4, 0),
-	[RC5T583_IRQ_ONKEY_OFF]		= RC5T583_IRQ(SYS_INT,  0, 5, 5, 0),
-	[RC5T583_IRQ_WD]		= RC5T583_IRQ(SYS_INT,  0, 7, 7, 0),
-	[RC5T583_IRQ_EN_PWRREQ1]	= RC5T583_IRQ(SYS_INT,  0, 8, 0, 1),
-	[RC5T583_IRQ_EN_PWRREQ2]	= RC5T583_IRQ(SYS_INT,  0, 9, 1, 1),
-	[RC5T583_IRQ_PRE_VINDET]	= RC5T583_IRQ(SYS_INT,  0, 10, 2, 1),
-
-	[RC5T583_IRQ_DC0LIM]		= RC5T583_IRQ(DCDC_INT, 1, 0, 0, 2),
-	[RC5T583_IRQ_DC1LIM]		= RC5T583_IRQ(DCDC_INT, 1, 1, 1, 2),
-	[RC5T583_IRQ_DC2LIM]		= RC5T583_IRQ(DCDC_INT, 1, 2, 2, 2),
-	[RC5T583_IRQ_DC3LIM]		= RC5T583_IRQ(DCDC_INT, 1, 3, 3, 2),
-
-	[RC5T583_IRQ_CTC]		= RC5T583_IRQ(RTC_INT,  2, 0, 0, 3),
-	[RC5T583_IRQ_YALE]		= RC5T583_IRQ(RTC_INT,  2, 5, 5, 3),
-	[RC5T583_IRQ_DALE]		= RC5T583_IRQ(RTC_INT,  2, 6, 6, 3),
-	[RC5T583_IRQ_WALE]		= RC5T583_IRQ(RTC_INT,  2, 7, 7, 3),
-
-	[RC5T583_IRQ_AIN1L]		= RC5T583_IRQ(ADC_INT,  3, 0, 0, 4),
-	[RC5T583_IRQ_AIN2L]		= RC5T583_IRQ(ADC_INT,  3, 1, 1, 4),
-	[RC5T583_IRQ_AIN3L]		= RC5T583_IRQ(ADC_INT,  3, 2, 2, 4),
-	[RC5T583_IRQ_VBATL]		= RC5T583_IRQ(ADC_INT,  3, 3, 3, 4),
-	[RC5T583_IRQ_VIN3L]		= RC5T583_IRQ(ADC_INT,  3, 4, 4, 4),
-	[RC5T583_IRQ_VIN8L]		= RC5T583_IRQ(ADC_INT,  3, 5, 5, 4),
-	[RC5T583_IRQ_AIN1H]		= RC5T583_IRQ(ADC_INT,  3, 6, 0, 5),
-	[RC5T583_IRQ_AIN2H]		= RC5T583_IRQ(ADC_INT,  3, 7, 1, 5),
-	[RC5T583_IRQ_AIN3H]		= RC5T583_IRQ(ADC_INT,  3, 8, 2, 5),
-	[RC5T583_IRQ_VBATH]		= RC5T583_IRQ(ADC_INT,  3, 9, 3, 5),
-	[RC5T583_IRQ_VIN3H]		= RC5T583_IRQ(ADC_INT,  3, 10, 4, 5),
-	[RC5T583_IRQ_VIN8H]		= RC5T583_IRQ(ADC_INT,  3, 11, 5, 5),
-	[RC5T583_IRQ_ADCEND]		= RC5T583_IRQ(ADC_INT,  3, 12, 0, 6),
-
-	[RC5T583_IRQ_GPIO0]		= RC5T583_IRQ(GPIO_INT, 4, 0, 0, 7),
-	[RC5T583_IRQ_GPIO1]		= RC5T583_IRQ(GPIO_INT, 4, 1, 1, 7),
-	[RC5T583_IRQ_GPIO2]		= RC5T583_IRQ(GPIO_INT, 4, 2, 2, 7),
-	[RC5T583_IRQ_GPIO3]		= RC5T583_IRQ(GPIO_INT, 4, 3, 3, 7),
-	[RC5T583_IRQ_GPIO4]		= RC5T583_IRQ(GPIO_INT, 4, 4, 4, 7),
-	[RC5T583_IRQ_GPIO5]		= RC5T583_IRQ(GPIO_INT, 4, 5, 5, 7),
-	[RC5T583_IRQ_GPIO6]		= RC5T583_IRQ(GPIO_INT, 4, 6, 6, 7),
-	[RC5T583_IRQ_GPIO7]		= RC5T583_IRQ(GPIO_INT, 4, 7, 7, 7),
-};
-
-static void rc5t583_irq_lock(struct irq_data *irq_data)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	mutex_lock(&rc5t583->irq_lock);
-}
-
-static void rc5t583_irq_unmask(struct irq_data *irq_data)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	unsigned int __irq = irq_data->irq - rc5t583->irq_base;
-	const struct rc5t583_irq_data *data = &rc5t583_irqs[__irq];
-
-	rc5t583->group_irq_en[data->grp_index] |= 1 << data->grp_index;
-	rc5t583->intc_inten_reg |= 1 << data->master_bit;
-	rc5t583->irq_en_reg[data->mask_reg_index] |= 1 << data->int_en_bit;
-}
-
-static void rc5t583_irq_mask(struct irq_data *irq_data)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	unsigned int __irq = irq_data->irq - rc5t583->irq_base;
-	const struct rc5t583_irq_data *data = &rc5t583_irqs[__irq];
-
-	rc5t583->group_irq_en[data->grp_index] &= ~(1 << data->grp_index);
-	if (!rc5t583->group_irq_en[data->grp_index])
-		rc5t583->intc_inten_reg &= ~(1 << data->master_bit);
-
-	rc5t583->irq_en_reg[data->mask_reg_index] &= ~(1 << data->int_en_bit);
-}
-
-static int rc5t583_irq_set_type(struct irq_data *irq_data, unsigned int type)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	unsigned int __irq = irq_data->irq - rc5t583->irq_base;
-	const struct rc5t583_irq_data *data = &rc5t583_irqs[__irq];
-	int val = 0;
-	int gpedge_index;
-	int gpedge_bit_pos;
-
-	/* Supporting only trigger level inetrrupt */
-	if ((data->int_type & GPIO_INT) && (type & IRQ_TYPE_EDGE_BOTH)) {
-		gpedge_index = data->int_en_bit / 4;
-		gpedge_bit_pos = data->int_en_bit % 4;
-
-		if (type & IRQ_TYPE_EDGE_FALLING)
-			val |= 0x2;
-
-		if (type & IRQ_TYPE_EDGE_RISING)
-			val |= 0x1;
-
-		rc5t583->gpedge_reg[gpedge_index] &= ~(3 << gpedge_bit_pos);
-		rc5t583->gpedge_reg[gpedge_index] |= (val << gpedge_bit_pos);
-		rc5t583_irq_unmask(irq_data);
-		return 0;
-	}
-	return -EINVAL;
-}
-
-static void rc5t583_irq_sync_unlock(struct irq_data *irq_data)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	int i;
-	int ret;
-
-	for (i = 0; i < ARRAY_SIZE(rc5t583->gpedge_reg); i++) {
-		ret = rc5t583_write(rc5t583->dev, gpedge_add[i],
-				rc5t583->gpedge_reg[i]);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				gpedge_add[i], ret);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(rc5t583->irq_en_reg); i++) {
-		ret = rc5t583_write(rc5t583->dev, irq_en_add[i],
-					rc5t583->irq_en_reg[i]);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				irq_en_add[i], ret);
-	}
-
-	ret = rc5t583_write(rc5t583->dev, RC5T583_INTC_INTEN,
-				rc5t583->intc_inten_reg);
-	if (ret < 0)
-		dev_warn(rc5t583->dev,
-			"Error in writing reg 0x%02x error: %d\n",
-			RC5T583_INTC_INTEN, ret);
-
-	mutex_unlock(&rc5t583->irq_lock);
-}
-
-static int rc5t583_irq_set_wake(struct irq_data *irq_data, unsigned int on)
-{
-	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
-	return irq_set_irq_wake(rc5t583->chip_irq, on);
-}
-
-static irqreturn_t rc5t583_irq(int irq, void *data)
-{
-	struct rc5t583 *rc5t583 = data;
-	uint8_t int_sts[RC5T583_MAX_INTERRUPT_MASK_REGS];
-	uint8_t master_int = 0;
-	int i;
-	int ret;
-	unsigned int rtc_int_sts = 0;
-
-	/* Clear the status */
-	for (i = 0; i < RC5T583_MAX_INTERRUPT_MASK_REGS; i++)
-		int_sts[i] = 0;
-
-	ret  = rc5t583_read(rc5t583->dev, RC5T583_INTC_INTMON, &master_int);
-	if (ret < 0) {
-		dev_err(rc5t583->dev,
-			"Error in reading reg 0x%02x error: %d\n",
-			RC5T583_INTC_INTMON, ret);
-		return IRQ_HANDLED;
-	}
-
-	for (i = 0; i < RC5T583_MAX_INTERRUPT_MASK_REGS; ++i) {
-		if (!(master_int & main_int_type[i]))
-			continue;
-
-		ret = rc5t583_read(rc5t583->dev, irq_mon_add[i], &int_sts[i]);
-		if (ret < 0) {
-			dev_warn(rc5t583->dev,
-				"Error in reading reg 0x%02x error: %d\n",
-				irq_mon_add[i], ret);
-			int_sts[i] = 0;
-			continue;
-		}
-
-		if (main_int_type[i] & RTC_INT) {
-			rtc_int_sts = 0;
-			if (int_sts[i] & 0x1)
-				rtc_int_sts |= BIT(6);
-			if (int_sts[i] & 0x2)
-				rtc_int_sts |= BIT(7);
-			if (int_sts[i] & 0x4)
-				rtc_int_sts |= BIT(0);
-			if (int_sts[i] & 0x8)
-				rtc_int_sts |= BIT(5);
-		}
-
-		ret = rc5t583_write(rc5t583->dev, irq_clr_add[i],
-				~int_sts[i]);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in reading reg 0x%02x error: %d\n",
-				irq_clr_add[i], ret);
-
-		if (main_int_type[i] & RTC_INT)
-			int_sts[i] = rtc_int_sts;
-	}
-
-	/* Merge gpio interrupts for rising and falling case*/
-	int_sts[7] |= int_sts[8];
-
-	/* Call interrupt handler if enabled */
-	for (i = 0; i < RC5T583_MAX_IRQS; ++i) {
-		const struct rc5t583_irq_data *data = &rc5t583_irqs[i];
-		if ((int_sts[data->mask_reg_index] & (1 << data->int_en_bit)) &&
-			(rc5t583->group_irq_en[data->master_bit] &
-					(1 << data->grp_index)))
-			handle_nested_irq(rc5t583->irq_base + i);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irq_chip rc5t583_irq_chip = {
-	.name = "rc5t583-irq",
-	.irq_mask = rc5t583_irq_mask,
-	.irq_unmask = rc5t583_irq_unmask,
-	.irq_bus_lock = rc5t583_irq_lock,
-	.irq_bus_sync_unlock = rc5t583_irq_sync_unlock,
-	.irq_set_type = rc5t583_irq_set_type,
-	.irq_set_wake = pm_sleep_ptr(rc5t583_irq_set_wake),
-};
-
-int rc5t583_irq_init(struct rc5t583 *rc5t583, int irq, int irq_base)
-{
-	int i, ret;
-
-	if (!irq_base) {
-		dev_warn(rc5t583->dev, "No interrupt support on IRQ base\n");
-		return -EINVAL;
-	}
-
-	mutex_init(&rc5t583->irq_lock);
-
-	/* Initailize all int register to 0 */
-	for (i = 0; i < RC5T583_MAX_INTERRUPT_EN_REGS; i++)  {
-		ret = rc5t583_write(rc5t583->dev, irq_en_add[i],
-				rc5t583->irq_en_reg[i]);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				irq_en_add[i], ret);
-	}
-
-	for (i = 0; i < RC5T583_MAX_GPEDGE_REG; i++)  {
-		ret = rc5t583_write(rc5t583->dev, gpedge_add[i],
-				rc5t583->gpedge_reg[i]);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				gpedge_add[i], ret);
-	}
-
-	ret = rc5t583_write(rc5t583->dev, RC5T583_INTC_INTEN, 0x0);
-	if (ret < 0)
-		dev_warn(rc5t583->dev,
-			"Error in writing reg 0x%02x error: %d\n",
-			RC5T583_INTC_INTEN, ret);
-
-	/* Clear all interrupts in case they woke up active. */
-	for (i = 0; i < RC5T583_MAX_INTERRUPT_MASK_REGS; i++)  {
-		ret = rc5t583_write(rc5t583->dev, irq_clr_add[i], 0);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				irq_clr_add[i], ret);
-	}
-
-	rc5t583->irq_base = irq_base;
-	rc5t583->chip_irq = irq;
-
-	for (i = 0; i < RC5T583_MAX_IRQS; i++) {
-		int __irq = i + rc5t583->irq_base;
-		irq_set_chip_data(__irq, rc5t583);
-		irq_set_chip_and_handler(__irq, &rc5t583_irq_chip,
-					 handle_simple_irq);
-		irq_set_nested_thread(__irq, 1);
-		irq_clear_status_flags(__irq, IRQ_NOREQUEST);
-	}
-
-	ret = devm_request_threaded_irq(rc5t583->dev, irq, NULL, rc5t583_irq,
-					IRQF_ONESHOT, "rc5t583", rc5t583);
-	if (ret < 0)
-		dev_err(rc5t583->dev,
-			"Error in registering interrupt error: %d\n", ret);
-	return ret;
-}
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
deleted file mode 100644
index 2c0e8e9630f7..000000000000
--- a/drivers/mfd/rc5t583.c
+++ /dev/null
@@ -1,299 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Core driver access RC5T583 power management chip.
- *
- * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
- * Author: Laxman dewangan <ldewangan@nvidia.com>
- *
- * Based on code
- *	Copyright (C) 2011 RICOH COMPANY,LTD
- */
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/rc5t583.h>
-#include <linux/regmap.h>
-
-#define RICOH_ONOFFSEL_REG	0x10
-#define RICOH_SWCTL_REG		0x5E
-
-struct deepsleep_control_data {
-	u8 reg_add;
-	u8 ds_pos_bit;
-};
-
-#define DEEPSLEEP_INIT(_id, _reg, _pos)		\
-	{					\
-		.reg_add = RC5T583_##_reg,	\
-		.ds_pos_bit = _pos,		\
-	}
-
-static struct deepsleep_control_data deepsleep_data[] = {
-	DEEPSLEEP_INIT(DC0, SLPSEQ1, 0),
-	DEEPSLEEP_INIT(DC1, SLPSEQ1, 4),
-	DEEPSLEEP_INIT(DC2, SLPSEQ2, 0),
-	DEEPSLEEP_INIT(DC3, SLPSEQ2, 4),
-	DEEPSLEEP_INIT(LDO0, SLPSEQ3, 0),
-	DEEPSLEEP_INIT(LDO1, SLPSEQ3, 4),
-	DEEPSLEEP_INIT(LDO2, SLPSEQ4, 0),
-	DEEPSLEEP_INIT(LDO3, SLPSEQ4, 4),
-	DEEPSLEEP_INIT(LDO4, SLPSEQ5, 0),
-	DEEPSLEEP_INIT(LDO5, SLPSEQ5, 4),
-	DEEPSLEEP_INIT(LDO6, SLPSEQ6, 0),
-	DEEPSLEEP_INIT(LDO7, SLPSEQ6, 4),
-	DEEPSLEEP_INIT(LDO8, SLPSEQ7, 0),
-	DEEPSLEEP_INIT(LDO9, SLPSEQ7, 4),
-	DEEPSLEEP_INIT(PSO0, SLPSEQ8, 0),
-	DEEPSLEEP_INIT(PSO1, SLPSEQ8, 4),
-	DEEPSLEEP_INIT(PSO2, SLPSEQ9, 0),
-	DEEPSLEEP_INIT(PSO3, SLPSEQ9, 4),
-	DEEPSLEEP_INIT(PSO4, SLPSEQ10, 0),
-	DEEPSLEEP_INIT(PSO5, SLPSEQ10, 4),
-	DEEPSLEEP_INIT(PSO6, SLPSEQ11, 0),
-	DEEPSLEEP_INIT(PSO7, SLPSEQ11, 4),
-};
-
-#define EXT_PWR_REQ		\
-	(RC5T583_EXT_PWRREQ1_CONTROL | RC5T583_EXT_PWRREQ2_CONTROL)
-
-static const struct mfd_cell rc5t583_subdevs[] = {
-	{.name = "rc5t583-gpio",},
-	{.name = "rc5t583-regulator",},
-	{.name = "rc5t583-rtc",      },
-	{.name = "rc5t583-key",      }
-};
-
-static int __rc5t583_set_ext_pwrreq1_control(struct device *dev,
-	int id, int ext_pwr, int slots)
-{
-	int ret;
-	uint8_t sleepseq_val = 0;
-	unsigned int en_bit;
-	unsigned int slot_bit;
-
-	if (id == RC5T583_DS_DC0) {
-		dev_err(dev, "PWRREQ1 is invalid control for rail %d\n", id);
-		return -EINVAL;
-	}
-
-	en_bit = deepsleep_data[id].ds_pos_bit;
-	slot_bit = en_bit + 1;
-	ret = rc5t583_read(dev, deepsleep_data[id].reg_add, &sleepseq_val);
-	if (ret < 0) {
-		dev_err(dev, "Error in reading reg 0x%x\n",
-				deepsleep_data[id].reg_add);
-		return ret;
-	}
-
-	sleepseq_val &= ~(0xF << en_bit);
-	sleepseq_val |= BIT(en_bit);
-	sleepseq_val |= ((slots & 0x7) << slot_bit);
-	ret = rc5t583_set_bits(dev, RICOH_ONOFFSEL_REG, BIT(1));
-	if (ret < 0) {
-		dev_err(dev, "Error in updating the 0x%02x register\n",
-				RICOH_ONOFFSEL_REG);
-		return ret;
-	}
-
-	ret = rc5t583_write(dev, deepsleep_data[id].reg_add, sleepseq_val);
-	if (ret < 0) {
-		dev_err(dev, "Error in writing reg 0x%x\n",
-				deepsleep_data[id].reg_add);
-		return ret;
-	}
-
-	if (id == RC5T583_DS_LDO4) {
-		ret = rc5t583_write(dev, RICOH_SWCTL_REG, 0x1);
-		if (ret < 0)
-			dev_err(dev, "Error in writing reg 0x%x\n",
-				RICOH_SWCTL_REG);
-	}
-	return ret;
-}
-
-static int __rc5t583_set_ext_pwrreq2_control(struct device *dev,
-	int id, int ext_pwr)
-{
-	int ret;
-
-	if (id != RC5T583_DS_DC0) {
-		dev_err(dev, "PWRREQ2 is invalid control for rail %d\n", id);
-		return -EINVAL;
-	}
-
-	ret = rc5t583_set_bits(dev, RICOH_ONOFFSEL_REG, BIT(2));
-	if (ret < 0)
-		dev_err(dev, "Error in updating the ONOFFSEL 0x10 register\n");
-	return ret;
-}
-
-int rc5t583_ext_power_req_config(struct device *dev, int ds_id,
-	int ext_pwr_req, int deepsleep_slot_nr)
-{
-	if ((ext_pwr_req & EXT_PWR_REQ) == EXT_PWR_REQ)
-		return -EINVAL;
-
-	if (ext_pwr_req & RC5T583_EXT_PWRREQ1_CONTROL)
-		return __rc5t583_set_ext_pwrreq1_control(dev, ds_id,
-				ext_pwr_req, deepsleep_slot_nr);
-
-	if (ext_pwr_req & RC5T583_EXT_PWRREQ2_CONTROL)
-		return __rc5t583_set_ext_pwrreq2_control(dev,
-			ds_id, ext_pwr_req);
-	return 0;
-}
-EXPORT_SYMBOL(rc5t583_ext_power_req_config);
-
-static int rc5t583_clear_ext_power_req(struct rc5t583 *rc5t583,
-	struct rc5t583_platform_data *pdata)
-{
-	int ret;
-	int i;
-	uint8_t on_off_val = 0;
-
-	/*  Clear ONOFFSEL register */
-	if (pdata->enable_shutdown)
-		on_off_val = 0x1;
-
-	ret = rc5t583_write(rc5t583->dev, RICOH_ONOFFSEL_REG, on_off_val);
-	if (ret < 0)
-		dev_warn(rc5t583->dev, "Error in writing reg %d error: %d\n",
-					RICOH_ONOFFSEL_REG, ret);
-
-	ret = rc5t583_write(rc5t583->dev, RICOH_SWCTL_REG, 0x0);
-	if (ret < 0)
-		dev_warn(rc5t583->dev, "Error in writing reg %d error: %d\n",
-					RICOH_SWCTL_REG, ret);
-
-	/* Clear sleep sequence register */
-	for (i = RC5T583_SLPSEQ1; i <= RC5T583_SLPSEQ11; ++i) {
-		ret = rc5t583_write(rc5t583->dev, i, 0x0);
-		if (ret < 0)
-			dev_warn(rc5t583->dev,
-				"Error in writing reg 0x%02x error: %d\n",
-				i, ret);
-	}
-	return 0;
-}
-
-static bool volatile_reg(struct device *dev, unsigned int reg)
-{
-	/* Enable caching in interrupt registers */
-	switch (reg) {
-	case RC5T583_INT_EN_SYS1:
-	case RC5T583_INT_EN_SYS2:
-	case RC5T583_INT_EN_DCDC:
-	case RC5T583_INT_EN_RTC:
-	case RC5T583_INT_EN_ADC1:
-	case RC5T583_INT_EN_ADC2:
-	case RC5T583_INT_EN_ADC3:
-	case RC5T583_GPIO_GPEDGE1:
-	case RC5T583_GPIO_GPEDGE2:
-	case RC5T583_GPIO_EN_INT:
-		return false;
-
-	case RC5T583_GPIO_MON_IOIN:
-		/* This is gpio input register */
-		return true;
-
-	default:
-		/* Enable caching in gpio registers */
-		if ((reg >= RC5T583_GPIO_IOSEL) &&
-				(reg <= RC5T583_GPIO_GPOFUNC))
-			return false;
-
-		/* Enable caching in sleep seq registers */
-		if ((reg >= RC5T583_SLPSEQ1) && (reg <= RC5T583_SLPSEQ11))
-			return false;
-
-		/* Enable caching of regulator registers */
-		if ((reg >= RC5T583_REG_DC0CTL) && (reg <= RC5T583_REG_SR3CTL))
-			return false;
-		if ((reg >= RC5T583_REG_LDOEN1) &&
-					(reg <= RC5T583_REG_LDO9DAC_DS))
-			return false;
-
-		break;
-	}
-
-	return true;
-}
-
-static const struct regmap_config rc5t583_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.volatile_reg = volatile_reg,
-	.max_register = RC5T583_MAX_REG,
-	.num_reg_defaults_raw = RC5T583_NUM_REGS,
-	.cache_type = REGCACHE_MAPLE,
-};
-
-static int rc5t583_i2c_probe(struct i2c_client *i2c)
-{
-	struct rc5t583 *rc5t583;
-	struct rc5t583_platform_data *pdata = dev_get_platdata(&i2c->dev);
-	int ret;
-
-	if (!pdata) {
-		dev_err(&i2c->dev, "Err: Platform data not found\n");
-		return -EINVAL;
-	}
-
-	rc5t583 = devm_kzalloc(&i2c->dev, sizeof(*rc5t583), GFP_KERNEL);
-	if (!rc5t583)
-		return -ENOMEM;
-
-	rc5t583->dev = &i2c->dev;
-	i2c_set_clientdata(i2c, rc5t583);
-
-	rc5t583->regmap = devm_regmap_init_i2c(i2c, &rc5t583_regmap_config);
-	if (IS_ERR(rc5t583->regmap)) {
-		ret = PTR_ERR(rc5t583->regmap);
-		dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = rc5t583_clear_ext_power_req(rc5t583, pdata);
-	if (ret < 0)
-		return ret;
-
-	if (i2c->irq) {
-		ret = rc5t583_irq_init(rc5t583, i2c->irq, pdata->irq_base);
-		/* Still continue with warning, if irq init fails */
-		if (ret)
-			dev_warn(&i2c->dev, "IRQ init failed: %d\n", ret);
-	}
-
-	ret = devm_mfd_add_devices(rc5t583->dev, -1, rc5t583_subdevs,
-				   ARRAY_SIZE(rc5t583_subdevs), NULL, 0, NULL);
-	if (ret) {
-		dev_err(&i2c->dev, "add mfd devices failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct i2c_device_id rc5t583_i2c_id[] = {
-	{.name = "rc5t583", .driver_data = 0},
-	{}
-};
-
-static struct i2c_driver rc5t583_i2c_driver = {
-	.driver = {
-		   .name = "rc5t583",
-		   },
-	.probe = rc5t583_i2c_probe,
-	.id_table = rc5t583_i2c_id,
-};
-
-static int __init rc5t583_i2c_init(void)
-{
-	return i2c_add_driver(&rc5t583_i2c_driver);
-}
-subsys_initcall(rc5t583_i2c_init);
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 12d883e729bc..2d5eb954d122 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1214,16 +1214,6 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2
 	  unit. The regulator is used to enable power to the display and to
 	  control backlight PWM.
 
-config REGULATOR_RC5T583
-	tristate "RICOH RC5T583 Power regulators"
-	depends on MFD_RC5T583
-	help
-	  Select this option to enable the power regulator of RICOH
-	  PMIC RC5T583.
-	  This driver supports the control of different power rails of device
-	  through regulator interface. The device supports multiple DCDC/LDO
-	  outputs which can be controlled by i2c communication.
-
 config REGULATOR_RK808
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power regulators"
 	depends on MFD_RK8XX
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 321c6ea73ee0..861f86c30c73 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -140,7 +140,6 @@ obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
 obj-$(CONFIG_REGULATOR_RAA215300) += raa215300.o
 obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY)  += rpi-panel-attiny-regulator.o
 obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2)  += rpi-panel-v2-regulator.o
-obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
 obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
deleted file mode 100644
index a25a141e86c4..000000000000
--- a/drivers/regulator/rc5t583-regulator.c
+++ /dev/null
@@ -1,171 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Regulator driver for RICOH RC5T583 power management chip.
- *
- * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
- * Author: Laxman dewangan <ldewangan@nvidia.com>
- *
- * based on code
- *      Copyright (C) 2011 RICOH COMPANY,LTD
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/mfd/rc5t583.h>
-
-struct rc5t583_regulator_info {
-	int			deepsleep_id;
-
-	/* Regulator register address.*/
-	uint8_t			reg_disc_reg;
-	uint8_t			disc_bit;
-	uint8_t			deepsleep_reg;
-
-	/* Regulator specific turn-on delay  and voltage settling time*/
-	int			enable_uv_per_us;
-
-	/* Used by regulator core */
-	struct regulator_desc	desc;
-};
-
-static int rc5t583_regulator_enable_time(struct regulator_dev *rdev)
-{
-	struct rc5t583_regulator_info *reg_info = rdev_get_drvdata(rdev);
-	int vsel = regulator_get_voltage_sel_regmap(rdev);
-	int curr_uV = regulator_list_voltage_linear(rdev, vsel);
-
-	return DIV_ROUND_UP(curr_uV, reg_info->enable_uv_per_us);
-}
-
-static const struct regulator_ops rc5t583_ops = {
-	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.enable_time		= rc5t583_regulator_enable_time,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
-	.map_voltage		= regulator_map_voltage_linear,
-	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-};
-
-#define RC5T583_REG(_id, _en_reg, _en_bit, _disc_reg, _disc_bit, \
-		_vout_mask, _min_mv, _max_mv, _step_uV, _enable_mv) \
-{								\
-	.reg_disc_reg	= RC5T583_REG_##_disc_reg,		\
-	.disc_bit	= _disc_bit,				\
-	.deepsleep_reg	= RC5T583_REG_##_id##DAC_DS,		\
-	.enable_uv_per_us = _enable_mv * 1000,			\
-	.deepsleep_id	= RC5T583_DS_##_id,			\
-	.desc = {						\
-		.name = "rc5t583-regulator-"#_id,		\
-		.id = RC5T583_REGULATOR_##_id,			\
-		.n_voltages = (_max_mv - _min_mv) * 1000 / _step_uV + 1, \
-		.ops = &rc5t583_ops,				\
-		.type = REGULATOR_VOLTAGE,			\
-		.owner = THIS_MODULE,				\
-		.vsel_reg = RC5T583_REG_##_id##DAC,		\
-		.vsel_mask = _vout_mask,			\
-		.enable_reg = RC5T583_REG_##_en_reg,		\
-		.enable_mask = BIT(_en_bit),			\
-		.min_uV	= _min_mv * 1000,			\
-		.uV_step = _step_uV,				\
-		.ramp_delay = 40 * 1000,			\
-	},							\
-}
-
-static struct rc5t583_regulator_info rc5t583_reg_info[RC5T583_REGULATOR_MAX] = {
-	RC5T583_REG(DC0, DC0CTL, 0, DC0CTL, 1, 0x7F, 700, 1500, 12500, 4),
-	RC5T583_REG(DC1, DC1CTL, 0, DC1CTL, 1, 0x7F, 700, 1500, 12500, 14),
-	RC5T583_REG(DC2, DC2CTL, 0, DC2CTL, 1, 0x7F, 900, 2400, 12500, 14),
-	RC5T583_REG(DC3, DC3CTL, 0, DC3CTL, 1, 0x7F, 900, 2400, 12500, 14),
-	RC5T583_REG(LDO0, LDOEN2, 0, LDODIS2, 0, 0x7F, 900, 3400, 25000, 160),
-	RC5T583_REG(LDO1, LDOEN2, 1, LDODIS2, 1, 0x7F, 900, 3400, 25000, 160),
-	RC5T583_REG(LDO2, LDOEN2, 2, LDODIS2, 2, 0x7F, 900, 3400, 25000, 160),
-	RC5T583_REG(LDO3, LDOEN2, 3, LDODIS2, 3, 0x7F, 900, 3400, 25000, 160),
-	RC5T583_REG(LDO4, LDOEN2, 4, LDODIS2, 4, 0x3F, 750, 1500, 12500, 133),
-	RC5T583_REG(LDO5, LDOEN2, 5, LDODIS2, 5, 0x7F, 900, 3400, 25000, 267),
-	RC5T583_REG(LDO6, LDOEN2, 6, LDODIS2, 6, 0x7F, 900, 3400, 25000, 133),
-	RC5T583_REG(LDO7, LDOEN2, 7, LDODIS2, 7, 0x7F, 900, 3400, 25000, 233),
-	RC5T583_REG(LDO8, LDOEN1, 0, LDODIS1, 0, 0x7F, 900, 3400, 25000, 233),
-	RC5T583_REG(LDO9, LDOEN1, 1, LDODIS1, 1, 0x7F, 900, 3400, 25000, 133),
-};
-
-static int rc5t583_regulator_probe(struct platform_device *pdev)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
-	struct rc5t583_platform_data *pdata = dev_get_platdata(rc5t583->dev);
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-	struct rc5t583_regulator_info *ri;
-	int ret;
-	int id;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data, exiting...\n");
-		return -ENODEV;
-	}
-
-	for (id = 0; id < RC5T583_REGULATOR_MAX; ++id) {
-		ri = &rc5t583_reg_info[id];
-
-		if (ri->deepsleep_id == RC5T583_DS_NONE)
-			goto skip_ext_pwr_config;
-
-		ret = rc5t583_ext_power_req_config(rc5t583->dev,
-				ri->deepsleep_id,
-				pdata->regulator_ext_pwr_control[id],
-				pdata->regulator_deepsleep_slot[id]);
-		/*
-		 * Configuring external control is not a major issue,
-		 * just give warning.
-		 */
-		if (ret < 0)
-			dev_warn(&pdev->dev,
-				"Failed to configure ext control %d\n", id);
-
-skip_ext_pwr_config:
-		config.dev = &pdev->dev;
-		config.init_data = pdata->reg_init_data[id];
-		config.driver_data = ri;
-		config.regmap = rc5t583->regmap;
-
-		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
-		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev, "Failed to register regulator %s\n",
-						ri->desc.name);
-			return PTR_ERR(rdev);
-		}
-	}
-	return 0;
-}
-
-static struct platform_driver rc5t583_regulator_driver = {
-	.driver	= {
-		.name	= "rc5t583-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe		= rc5t583_regulator_probe,
-};
-
-static int __init rc5t583_regulator_init(void)
-{
-	return platform_driver_register(&rc5t583_regulator_driver);
-}
-subsys_initcall(rc5t583_regulator_init);
-
-static void __exit rc5t583_regulator_exit(void)
-{
-	platform_driver_unregister(&rc5t583_regulator_driver);
-}
-module_exit(rc5t583_regulator_exit);
-
-MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_DESCRIPTION("RC5T583 regulator driver");
-MODULE_ALIAS("platform:rc5t583-regulator");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c201948b4d5b..c71398368f6d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -630,16 +630,6 @@ config RTC_DRV_TPS65910
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-tps65910.
 
-config RTC_DRV_RC5T583
-	tristate "RICOH 5T583 RTC driver"
-	depends on MFD_RC5T583
-	help
-	  If you say yes here you get support for the RTC on the
-	  RICOH 5T583 chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-rc5t583.
-
 config RTC_DRV_RC5T619
 	tristate "RICOH RC5T619 RTC driver"
 	depends on MFD_RN5T618
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 84bb2af5849e..b8fc1a17d27f 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -143,7 +143,6 @@ obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
 obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
-obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
 obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
 obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
 obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
deleted file mode 100644
index 8ba9cda74acf..000000000000
--- a/drivers/rtc/rtc-rc5t583.c
+++ /dev/null
@@ -1,312 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * rtc-rc5t583.c -- RICOH RC5T583 Real Time Clock
- *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- * Author: Venu Byravarasu <vbyravarasu@nvidia.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/mfd/rc5t583.h>
-
-struct rc5t583_rtc {
-	struct rtc_device	*rtc;
-	/* To store the list of enabled interrupts, during system suspend */
-	u32 irqen;
-};
-
-/* Total number of RTC registers needed to set time*/
-#define NUM_TIME_REGS	(RC5T583_RTC_YEAR - RC5T583_RTC_SEC + 1)
-
-/* Total number of RTC registers needed to set Y-Alarm*/
-#define NUM_YAL_REGS	(RC5T583_RTC_AY_YEAR - RC5T583_RTC_AY_MIN + 1)
-
-/* Set Y-Alarm interrupt */
-#define SET_YAL BIT(5)
-
-/* Get Y-Alarm interrupt status*/
-#define GET_YAL_STATUS BIT(3)
-
-static int rc5t583_rtc_alarm_irq_enable(struct device *dev, unsigned enabled)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	u8 val;
-
-	/* Set Y-Alarm, based on 'enabled' */
-	val = enabled ? SET_YAL : 0;
-
-	return regmap_update_bits(rc5t583->regmap, RC5T583_RTC_CTL1, SET_YAL,
-		val);
-}
-
-/*
- * Gets current rc5t583 RTC time and date parameters.
- *
- * The RTC's time/alarm representation is not what gmtime(3) requires
- * Linux to use:
- *
- *  - Months are 1..12 vs Linux 0-11
- *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
- */
-static int rc5t583_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	u8 rtc_data[NUM_TIME_REGS];
-	int ret;
-
-	ret = regmap_bulk_read(rc5t583->regmap, RC5T583_RTC_SEC, rtc_data,
-		NUM_TIME_REGS);
-	if (ret < 0) {
-		dev_err(dev, "RTC read time failed with err:%d\n", ret);
-		return ret;
-	}
-
-	tm->tm_sec = bcd2bin(rtc_data[0]);
-	tm->tm_min = bcd2bin(rtc_data[1]);
-	tm->tm_hour = bcd2bin(rtc_data[2]);
-	tm->tm_wday = bcd2bin(rtc_data[3]);
-	tm->tm_mday = bcd2bin(rtc_data[4]);
-	tm->tm_mon = bcd2bin(rtc_data[5]) - 1;
-	tm->tm_year = bcd2bin(rtc_data[6]) + 100;
-
-	return ret;
-}
-
-static int rc5t583_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	unsigned char rtc_data[NUM_TIME_REGS];
-	int ret;
-
-	rtc_data[0] = bin2bcd(tm->tm_sec);
-	rtc_data[1] = bin2bcd(tm->tm_min);
-	rtc_data[2] = bin2bcd(tm->tm_hour);
-	rtc_data[3] = bin2bcd(tm->tm_wday);
-	rtc_data[4] = bin2bcd(tm->tm_mday);
-	rtc_data[5] = bin2bcd(tm->tm_mon + 1);
-	rtc_data[6] = bin2bcd(tm->tm_year - 100);
-
-	ret = regmap_bulk_write(rc5t583->regmap, RC5T583_RTC_SEC, rtc_data,
-		NUM_TIME_REGS);
-	if (ret < 0) {
-		dev_err(dev, "RTC set time failed with error %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
-static int rc5t583_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	unsigned char alarm_data[NUM_YAL_REGS];
-	u32 interrupt_enable;
-	int ret;
-
-	ret = regmap_bulk_read(rc5t583->regmap, RC5T583_RTC_AY_MIN, alarm_data,
-		NUM_YAL_REGS);
-	if (ret < 0) {
-		dev_err(dev, "rtc_read_alarm error %d\n", ret);
-		return ret;
-	}
-
-	alm->time.tm_sec = 0;
-	alm->time.tm_min = bcd2bin(alarm_data[0]);
-	alm->time.tm_hour = bcd2bin(alarm_data[1]);
-	alm->time.tm_mday = bcd2bin(alarm_data[2]);
-	alm->time.tm_mon = bcd2bin(alarm_data[3]) - 1;
-	alm->time.tm_year = bcd2bin(alarm_data[4]) + 100;
-
-	ret = regmap_read(rc5t583->regmap, RC5T583_RTC_CTL1, &interrupt_enable);
-	if (ret < 0)
-		return ret;
-
-	/* check if YALE is set */
-	if (interrupt_enable & SET_YAL)
-		alm->enabled = 1;
-
-	return ret;
-}
-
-static int rc5t583_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	unsigned char alarm_data[NUM_YAL_REGS];
-	int ret;
-
-	ret = rc5t583_rtc_alarm_irq_enable(dev, 0);
-	if (ret)
-		return ret;
-
-	alarm_data[0] = bin2bcd(alm->time.tm_min);
-	alarm_data[1] = bin2bcd(alm->time.tm_hour);
-	alarm_data[2] = bin2bcd(alm->time.tm_mday);
-	alarm_data[3] = bin2bcd(alm->time.tm_mon + 1);
-	alarm_data[4] = bin2bcd(alm->time.tm_year - 100);
-
-	ret = regmap_bulk_write(rc5t583->regmap, RC5T583_RTC_AY_MIN, alarm_data,
-		NUM_YAL_REGS);
-	if (ret) {
-		dev_err(dev, "rtc_set_alarm error %d\n", ret);
-		return ret;
-	}
-
-	if (alm->enabled)
-		ret = rc5t583_rtc_alarm_irq_enable(dev, 1);
-
-	return ret;
-}
-
-static irqreturn_t rc5t583_rtc_interrupt(int irq, void *rtc)
-{
-	struct device *dev = rtc;
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	struct rc5t583_rtc *rc5t583_rtc = dev_get_drvdata(dev);
-	unsigned long events = 0;
-	int ret;
-	u32 rtc_reg;
-
-	ret = regmap_read(rc5t583->regmap, RC5T583_RTC_CTL2, &rtc_reg);
-	if (ret < 0)
-		return IRQ_NONE;
-
-	if (rtc_reg & GET_YAL_STATUS) {
-		events = RTC_IRQF | RTC_AF;
-		/* clear pending Y-alarm interrupt bit */
-		rtc_reg &= ~GET_YAL_STATUS;
-	}
-
-	ret = regmap_write(rc5t583->regmap, RC5T583_RTC_CTL2, rtc_reg);
-	if (ret)
-		return IRQ_NONE;
-
-	/* Notify RTC core on event */
-	rtc_update_irq(rc5t583_rtc->rtc, 1, events);
-
-	return IRQ_HANDLED;
-}
-
-static const struct rtc_class_ops rc5t583_rtc_ops = {
-	.read_time	= rc5t583_rtc_read_time,
-	.set_time	= rc5t583_rtc_set_time,
-	.read_alarm	= rc5t583_rtc_read_alarm,
-	.set_alarm	= rc5t583_rtc_set_alarm,
-	.alarm_irq_enable = rc5t583_rtc_alarm_irq_enable,
-};
-
-static int rc5t583_rtc_probe(struct platform_device *pdev)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
-	struct rc5t583_rtc *ricoh_rtc;
-	struct rc5t583_platform_data *pmic_plat_data;
-	int ret;
-	int irq;
-
-	ricoh_rtc = devm_kzalloc(&pdev->dev, sizeof(struct rc5t583_rtc),
-			GFP_KERNEL);
-	if (!ricoh_rtc)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, ricoh_rtc);
-
-	/* Clear pending interrupts */
-	ret = regmap_write(rc5t583->regmap, RC5T583_RTC_CTL2, 0);
-	if (ret < 0)
-		return ret;
-
-	/* clear RTC Adjust register */
-	ret = regmap_write(rc5t583->regmap, RC5T583_RTC_ADJ, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to program rtc_adjust reg\n");
-		return -EBUSY;
-	}
-
-	pmic_plat_data = dev_get_platdata(rc5t583->dev);
-	irq = pmic_plat_data->irq_base;
-	if (irq <= 0) {
-		dev_warn(&pdev->dev, "Wake up is not possible as irq = %d\n",
-			irq);
-		return ret;
-	}
-
-	irq += RC5T583_IRQ_YALE;
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		rc5t583_rtc_interrupt, IRQF_TRIGGER_LOW,
-		"rtc-rc5t583", &pdev->dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "IRQ is not free.\n");
-		return ret;
-	}
-	device_init_wakeup(&pdev->dev, true);
-
-	ricoh_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-		&rc5t583_rtc_ops, THIS_MODULE);
-	if (IS_ERR(ricoh_rtc->rtc)) {
-		ret = PTR_ERR(ricoh_rtc->rtc);
-		dev_err(&pdev->dev, "RTC device register: err %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-/*
- * Disable rc5t583 RTC interrupts.
- * Sets status flag to free.
- */
-static void rc5t583_rtc_remove(struct platform_device *pdev)
-{
-	struct rc5t583_rtc *rc5t583_rtc = platform_get_drvdata(pdev);
-
-	rc5t583_rtc_alarm_irq_enable(&rc5t583_rtc->rtc->dev, 0);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int rc5t583_rtc_suspend(struct device *dev)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	struct rc5t583_rtc *rc5t583_rtc = dev_get_drvdata(dev);
-	int ret;
-
-	/* Store current list of enabled interrupts*/
-	ret = regmap_read(rc5t583->regmap, RC5T583_RTC_CTL1,
-		&rc5t583_rtc->irqen);
-	return ret;
-}
-
-static int rc5t583_rtc_resume(struct device *dev)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev->parent);
-	struct rc5t583_rtc *rc5t583_rtc = dev_get_drvdata(dev);
-
-	/* Restore list of enabled interrupts before suspend */
-	return regmap_write(rc5t583->regmap, RC5T583_RTC_CTL1,
-		rc5t583_rtc->irqen);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(rc5t583_rtc_pm_ops, rc5t583_rtc_suspend,
-			rc5t583_rtc_resume);
-
-static struct platform_driver rc5t583_rtc_driver = {
-	.probe		= rc5t583_rtc_probe,
-	.remove		= rc5t583_rtc_remove,
-	.driver		= {
-		.name	= "rtc-rc5t583",
-		.pm	= &rc5t583_rtc_pm_ops,
-	},
-};
-
-module_platform_driver(rc5t583_rtc_driver);
-MODULE_ALIAS("platform:rtc-rc5t583");
-MODULE_AUTHOR("Venu Byravarasu <vbyravarasu@nvidia.com>");
-MODULE_DESCRIPTION("RICOH 5T583 RTC driver");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/rc5t583.h b/include/linux/mfd/rc5t583.h
deleted file mode 100644
index 4f220146cc02..000000000000
--- a/include/linux/mfd/rc5t583.h
+++ /dev/null
@@ -1,369 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Core driver interface to access RICOH_RC5T583 power management chip.
- *
- * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
- * Author: Laxman dewangan <ldewangan@nvidia.com>
- *
- * Based on code
- *      Copyright (C) 2011 RICOH COMPANY,LTD
- */
-
-#ifndef __LINUX_MFD_RC5T583_H
-#define __LINUX_MFD_RC5T583_H
-
-#include <linux/mutex.h>
-#include <linux/types.h>
-#include <linux/regmap.h>
-
-/* Maximum number of main interrupts */
-#define MAX_MAIN_INTERRUPT		5
-#define RC5T583_MAX_GPEDGE_REG		2
-#define RC5T583_MAX_INTERRUPT_EN_REGS	8
-#define RC5T583_MAX_INTERRUPT_MASK_REGS	9
-
-/* Interrupt enable register */
-#define RC5T583_INT_EN_SYS1	0x19
-#define RC5T583_INT_EN_SYS2	0x1D
-#define RC5T583_INT_EN_DCDC	0x41
-#define RC5T583_INT_EN_RTC	0xED
-#define RC5T583_INT_EN_ADC1	0x90
-#define RC5T583_INT_EN_ADC2	0x91
-#define RC5T583_INT_EN_ADC3	0x92
-
-/* Interrupt status registers (monitor regs in Ricoh)*/
-#define RC5T583_INTC_INTPOL	0xAD
-#define RC5T583_INTC_INTEN	0xAE
-#define RC5T583_INTC_INTMON	0xAF
-
-#define RC5T583_INT_MON_GRP	0xAF
-#define RC5T583_INT_MON_SYS1	0x1B
-#define RC5T583_INT_MON_SYS2	0x1F
-#define RC5T583_INT_MON_DCDC	0x43
-#define RC5T583_INT_MON_RTC	0xEE
-
-/* Interrupt clearing registers */
-#define RC5T583_INT_IR_SYS1	0x1A
-#define RC5T583_INT_IR_SYS2	0x1E
-#define RC5T583_INT_IR_DCDC	0x42
-#define RC5T583_INT_IR_RTC	0xEE
-#define RC5T583_INT_IR_ADCL	0x94
-#define RC5T583_INT_IR_ADCH	0x95
-#define RC5T583_INT_IR_ADCEND	0x96
-#define RC5T583_INT_IR_GPIOR	0xA9
-#define RC5T583_INT_IR_GPIOF	0xAA
-
-/* Sleep sequence registers */
-#define RC5T583_SLPSEQ1		0x21
-#define RC5T583_SLPSEQ2		0x22
-#define RC5T583_SLPSEQ3		0x23
-#define RC5T583_SLPSEQ4		0x24
-#define RC5T583_SLPSEQ5		0x25
-#define RC5T583_SLPSEQ6		0x26
-#define RC5T583_SLPSEQ7		0x27
-#define RC5T583_SLPSEQ8		0x28
-#define RC5T583_SLPSEQ9		0x29
-#define RC5T583_SLPSEQ10	0x2A
-#define RC5T583_SLPSEQ11	0x2B
-
-/* Regulator registers */
-#define RC5T583_REG_DC0CTL	0x30
-#define RC5T583_REG_DC0DAC	0x31
-#define RC5T583_REG_DC0LATCTL	0x32
-#define RC5T583_REG_SR0CTL	0x33
-
-#define RC5T583_REG_DC1CTL	0x34
-#define RC5T583_REG_DC1DAC	0x35
-#define RC5T583_REG_DC1LATCTL	0x36
-#define RC5T583_REG_SR1CTL	0x37
-
-#define RC5T583_REG_DC2CTL	0x38
-#define RC5T583_REG_DC2DAC	0x39
-#define RC5T583_REG_DC2LATCTL	0x3A
-#define RC5T583_REG_SR2CTL	0x3B
-
-#define RC5T583_REG_DC3CTL	0x3C
-#define RC5T583_REG_DC3DAC	0x3D
-#define RC5T583_REG_DC3LATCTL	0x3E
-#define RC5T583_REG_SR3CTL	0x3F
-
-
-#define RC5T583_REG_LDOEN1	0x50
-#define RC5T583_REG_LDOEN2	0x51
-#define RC5T583_REG_LDODIS1	0x52
-#define RC5T583_REG_LDODIS2	0x53
-
-#define RC5T583_REG_LDO0DAC	0x54
-#define RC5T583_REG_LDO1DAC	0x55
-#define RC5T583_REG_LDO2DAC	0x56
-#define RC5T583_REG_LDO3DAC	0x57
-#define RC5T583_REG_LDO4DAC	0x58
-#define RC5T583_REG_LDO5DAC	0x59
-#define RC5T583_REG_LDO6DAC	0x5A
-#define RC5T583_REG_LDO7DAC	0x5B
-#define RC5T583_REG_LDO8DAC	0x5C
-#define RC5T583_REG_LDO9DAC	0x5D
-
-#define RC5T583_REG_DC0DAC_DS	0x60
-#define RC5T583_REG_DC1DAC_DS	0x61
-#define RC5T583_REG_DC2DAC_DS	0x62
-#define RC5T583_REG_DC3DAC_DS	0x63
-
-#define RC5T583_REG_LDO0DAC_DS	0x64
-#define RC5T583_REG_LDO1DAC_DS	0x65
-#define RC5T583_REG_LDO2DAC_DS	0x66
-#define RC5T583_REG_LDO3DAC_DS	0x67
-#define RC5T583_REG_LDO4DAC_DS	0x68
-#define RC5T583_REG_LDO5DAC_DS	0x69
-#define RC5T583_REG_LDO6DAC_DS	0x6A
-#define RC5T583_REG_LDO7DAC_DS	0x6B
-#define RC5T583_REG_LDO8DAC_DS	0x6C
-#define RC5T583_REG_LDO9DAC_DS	0x6D
-
-/* GPIO register base address */
-#define RC5T583_GPIO_IOSEL	0xA0
-#define RC5T583_GPIO_PDEN	0xA1
-#define RC5T583_GPIO_IOOUT	0xA2
-#define RC5T583_GPIO_PGSEL	0xA3
-#define RC5T583_GPIO_GPINV	0xA4
-#define RC5T583_GPIO_GPDEB	0xA5
-#define RC5T583_GPIO_GPEDGE1	0xA6
-#define RC5T583_GPIO_GPEDGE2	0xA7
-#define RC5T583_GPIO_EN_INT	0xA8
-#define RC5T583_GPIO_MON_IOIN	0xAB
-#define RC5T583_GPIO_GPOFUNC	0xAC
-
-/* RTC registers */
-#define RC5T583_RTC_SEC		0xE0
-#define RC5T583_RTC_MIN		0xE1
-#define RC5T583_RTC_HOUR	0xE2
-#define RC5T583_RTC_WDAY	0xE3
-#define RC5T583_RTC_DAY		0xE4
-#define RC5T583_RTC_MONTH	0xE5
-#define RC5T583_RTC_YEAR	0xE6
-#define RC5T583_RTC_ADJ		0xE7
-#define RC5T583_RTC_AW_MIN	0xE8
-#define RC5T583_RTC_AW_HOUR	0xE9
-#define RC5T583_RTC_AW_WEEK	0xEA
-#define RC5T583_RTC_AD_MIN	0xEB
-#define RC5T583_RTC_AD_HOUR	0xEC
-#define RC5T583_RTC_CTL1	0xED
-#define RC5T583_RTC_CTL2	0xEE
-#define RC5T583_RTC_AY_MIN	0xF0
-#define RC5T583_RTC_AY_HOUR	0xF1
-#define RC5T583_RTC_AY_DAY	0xF2
-#define RC5T583_RTC_AY_MONTH 0xF3
-#define RC5T583_RTC_AY_YEAR	0xF4
-
-#define RC5T583_MAX_REG		0xF7
-#define RC5T583_NUM_REGS	(RC5T583_MAX_REG + 1)
-
-/* RICOH_RC5T583 IRQ definitions */
-enum {
-	RC5T583_IRQ_ONKEY,
-	RC5T583_IRQ_ACOK,
-	RC5T583_IRQ_LIDOPEN,
-	RC5T583_IRQ_PREOT,
-	RC5T583_IRQ_CLKSTP,
-	RC5T583_IRQ_ONKEY_OFF,
-	RC5T583_IRQ_WD,
-	RC5T583_IRQ_EN_PWRREQ1,
-	RC5T583_IRQ_EN_PWRREQ2,
-	RC5T583_IRQ_PRE_VINDET,
-
-	RC5T583_IRQ_DC0LIM,
-	RC5T583_IRQ_DC1LIM,
-	RC5T583_IRQ_DC2LIM,
-	RC5T583_IRQ_DC3LIM,
-
-	RC5T583_IRQ_CTC,
-	RC5T583_IRQ_YALE,
-	RC5T583_IRQ_DALE,
-	RC5T583_IRQ_WALE,
-
-	RC5T583_IRQ_AIN1L,
-	RC5T583_IRQ_AIN2L,
-	RC5T583_IRQ_AIN3L,
-	RC5T583_IRQ_VBATL,
-	RC5T583_IRQ_VIN3L,
-	RC5T583_IRQ_VIN8L,
-	RC5T583_IRQ_AIN1H,
-	RC5T583_IRQ_AIN2H,
-	RC5T583_IRQ_AIN3H,
-	RC5T583_IRQ_VBATH,
-	RC5T583_IRQ_VIN3H,
-	RC5T583_IRQ_VIN8H,
-	RC5T583_IRQ_ADCEND,
-
-	RC5T583_IRQ_GPIO0,
-	RC5T583_IRQ_GPIO1,
-	RC5T583_IRQ_GPIO2,
-	RC5T583_IRQ_GPIO3,
-	RC5T583_IRQ_GPIO4,
-	RC5T583_IRQ_GPIO5,
-	RC5T583_IRQ_GPIO6,
-	RC5T583_IRQ_GPIO7,
-
-	/* Should be last entry */
-	RC5T583_MAX_IRQS,
-};
-
-/* Ricoh583 gpio definitions */
-enum {
-	RC5T583_GPIO0,
-	RC5T583_GPIO1,
-	RC5T583_GPIO2,
-	RC5T583_GPIO3,
-	RC5T583_GPIO4,
-	RC5T583_GPIO5,
-	RC5T583_GPIO6,
-	RC5T583_GPIO7,
-
-	/* Should be last entry */
-	RC5T583_MAX_GPIO,
-};
-
-enum {
-	RC5T583_DS_NONE,
-	RC5T583_DS_DC0,
-	RC5T583_DS_DC1,
-	RC5T583_DS_DC2,
-	RC5T583_DS_DC3,
-	RC5T583_DS_LDO0,
-	RC5T583_DS_LDO1,
-	RC5T583_DS_LDO2,
-	RC5T583_DS_LDO3,
-	RC5T583_DS_LDO4,
-	RC5T583_DS_LDO5,
-	RC5T583_DS_LDO6,
-	RC5T583_DS_LDO7,
-	RC5T583_DS_LDO8,
-	RC5T583_DS_LDO9,
-	RC5T583_DS_PSO0,
-	RC5T583_DS_PSO1,
-	RC5T583_DS_PSO2,
-	RC5T583_DS_PSO3,
-	RC5T583_DS_PSO4,
-	RC5T583_DS_PSO5,
-	RC5T583_DS_PSO6,
-	RC5T583_DS_PSO7,
-
-	/* Should be last entry */
-	RC5T583_DS_MAX,
-};
-
-/*
- * Ricoh pmic RC5T583 supports sleep through two external controls.
- * The output of gpios and regulator can be enable/disable through
- * this external signals.
- */
-enum {
-	RC5T583_EXT_PWRREQ1_CONTROL = 0x1,
-	RC5T583_EXT_PWRREQ2_CONTROL = 0x2,
-};
-
-enum {
-	RC5T583_REGULATOR_DC0,
-	RC5T583_REGULATOR_DC1,
-	RC5T583_REGULATOR_DC2,
-	RC5T583_REGULATOR_DC3,
-	RC5T583_REGULATOR_LDO0,
-	RC5T583_REGULATOR_LDO1,
-	RC5T583_REGULATOR_LDO2,
-	RC5T583_REGULATOR_LDO3,
-	RC5T583_REGULATOR_LDO4,
-	RC5T583_REGULATOR_LDO5,
-	RC5T583_REGULATOR_LDO6,
-	RC5T583_REGULATOR_LDO7,
-	RC5T583_REGULATOR_LDO8,
-	RC5T583_REGULATOR_LDO9,
-
-	/* Should be last entry */
-	RC5T583_REGULATOR_MAX,
-};
-
-struct rc5t583 {
-	struct device	*dev;
-	struct regmap	*regmap;
-	int		chip_irq;
-	int		irq_base;
-	struct mutex	irq_lock;
-	unsigned long	group_irq_en[MAX_MAIN_INTERRUPT];
-
-	/* For main interrupt bits in INTC */
-	uint8_t		intc_inten_reg;
-
-	/* For group interrupt bits and address */
-	uint8_t		irq_en_reg[RC5T583_MAX_INTERRUPT_EN_REGS];
-
-	/* For gpio edge */
-	uint8_t		gpedge_reg[RC5T583_MAX_GPEDGE_REG];
-};
-
-/*
- * rc5t583_platform_data: Platform data for ricoh rc5t583 pmu.
- * The board specific data is provided through this structure.
- * @irq_base: Irq base number on which this device registers their interrupts.
- * @gpio_base: GPIO base from which gpio of this device will start.
- * @enable_shutdown: Enable shutdown through the input pin "shutdown".
- * @regulator_deepsleep_slot: The slot number on which device goes to sleep
- *		in device sleep mode.
- * @regulator_ext_pwr_control: External power request regulator control. The
- *		regulator output enable/disable is controlled by the external
- *		power request input state.
- * @reg_init_data: Regulator init data.
- */
-
-struct rc5t583_platform_data {
-	int		irq_base;
-	int		gpio_base;
-	bool		enable_shutdown;
-	int		regulator_deepsleep_slot[RC5T583_REGULATOR_MAX];
-	unsigned long	regulator_ext_pwr_control[RC5T583_REGULATOR_MAX];
-	struct regulator_init_data *reg_init_data[RC5T583_REGULATOR_MAX];
-};
-
-static inline int rc5t583_write(struct device *dev, uint8_t reg, uint8_t val)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev);
-	return regmap_write(rc5t583->regmap, reg, val);
-}
-
-static inline int rc5t583_read(struct device *dev, uint8_t reg, uint8_t *val)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev);
-	unsigned int ival;
-	int ret;
-	ret = regmap_read(rc5t583->regmap, reg, &ival);
-	if (!ret)
-		*val = (uint8_t)ival;
-	return ret;
-}
-
-static inline int rc5t583_set_bits(struct device *dev, unsigned int reg,
-			unsigned int bit_mask)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev);
-	return regmap_update_bits(rc5t583->regmap, reg, bit_mask, bit_mask);
-}
-
-static inline int rc5t583_clear_bits(struct device *dev, unsigned int reg,
-			unsigned int bit_mask)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev);
-	return regmap_update_bits(rc5t583->regmap, reg, bit_mask, 0);
-}
-
-static inline int rc5t583_update(struct device *dev, unsigned int reg,
-		unsigned int val, unsigned int mask)
-{
-	struct rc5t583 *rc5t583 = dev_get_drvdata(dev);
-	return regmap_update_bits(rc5t583->regmap, reg, mask, val);
-}
-
-int rc5t583_ext_power_req_config(struct device *dev, int deepsleep_id,
-	int ext_pwr_req, int deepsleep_slot_nr);
-int rc5t583_irq_init(struct rc5t583 *rc5t583, int irq, int irq_base);
-int rc5t583_irq_exit(struct rc5t583 *rc5t583);
-
-#endif
-- 
2.53.0


