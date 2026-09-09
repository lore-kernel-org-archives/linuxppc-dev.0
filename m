Return-Path: <linuxppc-dev+bounces-26932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5B0C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:23:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1j14r6sz30gS;
	Wed, 09 Sep 2026 23:23:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960213;
	cv=none; b=D1auQNG/21NG0jPteyJZQsYazjBNWCY+mnRHNAGIKu0IVMGZcIYMvggFRdnVkfSY+BURDOhFJveU0qhvrZ/QsLcb0B6clQRu9KDgVrczcJnuIwAGZE2t3HrRXZiHrxfCAljbZyZw1jTMIoUV7fFCVMzFoXhTBqK4yoXfS2sKbDRVCeDYmBQh65FE7ZnJE125bvPHyw5ERoNzSYrsU87WVypm5lvfliGf0ol/a6BRLOX8N9FKIE0EhDgL9PloUNgDxkgtU/At83R3fChPVcfQno3teVGqTyppiXwRGy3sQVwExgh0DGzgM2KzxZQEEttfNbJVYxDcRDMlnN9DZMtopg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960213; c=relaxed/relaxed;
	bh=iBwLDdkV0sGJ+KZn9/rYZCz+Ea5WOA44xoCHpPzQZhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+wvh0ppBYZ2KlRiMHjfyHLSeLm8vilxcGPRkLTfg5vNvt6F9r7RHIaSHouI3hE6jucSMMa2KGUmX/feeoMo8PQLWNVkQICM02A2H5kfuF36XQpR1xa5XfxEtpxpm+CXqSVn6TdozfdQpWUaVVVoFNL+h+/6LH5YAGpv57/VN9bdbJ51OCbkRL9CmUmPiMwu559+lGfAiFsYKfkcrIMY1LJDBLEF5kYvxeuoOv1IMJQSbF0K+eHDDaMGfbukLW9j3QU6w4S+I3Y3WfAWsXPZwLwOyLk4mfNvelyq69W8fKpcDp4nQLtPegbr0936iM7oMgxqpyPhSYHFZyswG9SHRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImlwPdT2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImlwPdT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1j00j7pz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:23:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F031060219;
	Wed,  9 Sep 2026 13:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6591F00A3F;
	Wed,  9 Sep 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960209;
	bh=iBwLDdkV0sGJ+KZn9/rYZCz+Ea5WOA44xoCHpPzQZhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImlwPdT2AktB1xteiqmpsC4ryHbeaCHKiwPAiLsezjZ3MiKfzj2ESSI4ZbqaFCYry
	 9YK/BCGd6yfkRp4VCmnHH/sTo7H11cjC2muIsA19Q7WjuOXzp8MXYTCcjMWkcJsTtB
	 30FNx1w7JJqBROt7CxZ9cjgXIonMpxTpCXCmWycdU+cDNJ30AQjjiaBkCsbDxlHYQ2
	 OlxX8R+XvyxKsIXVH5ZCL6eDF720Q/8hpef4WzB/HtHwsVcAiDXE9IFqzsOQQLXvVM
	 HBsCoHhXNEF2+mNOnvvmrsc8TboO8rPq85KWh7nJQAKtmlUkRLSoOMlPv9YJutiTVs
	 w/JGwsh0wdQgQ==
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
Subject: [PATCH 08/14] mfd: remove unused aat2870 driver
Date: Wed,  9 Sep 2026 15:21:45 +0200
Message-ID: <20260909132153.1596191-9-arnd@kernel.org>
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

This driver was apparently never used, as it has has no devicetree
support and never had corresponding platform_data definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig                   |  12 -
 drivers/mfd/Makefile                  |   1 -
 drivers/mfd/aat2870-core.c            | 458 --------------------------
 drivers/regulator/Kconfig             |   7 -
 drivers/regulator/Makefile            |   1 -
 drivers/regulator/aat2870-regulator.c | 201 -----------
 drivers/video/backlight/Kconfig       |   7 -
 drivers/video/backlight/Makefile      |   1 -
 drivers/video/backlight/aat2870_bl.c  | 206 ------------
 include/linux/mfd/aat2870.h           | 164 ---------
 10 files changed, 1058 deletions(-)
 delete mode 100644 drivers/mfd/aat2870-core.c
 delete mode 100644 drivers/regulator/aat2870-regulator.c
 delete mode 100644 drivers/video/backlight/aat2870_bl.c
 delete mode 100644 include/linux/mfd/aat2870.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 09e400e1f4b0..b0c7df448445 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -115,18 +115,6 @@ config MFD_AS3722
 	  controllers, 11 LDOs, RTC, automatic battery, temperature and
 	  over current monitoring, GPIOs, ADC and a watchdog.
 
-config MFD_AAT2870_CORE
-	bool "AnalogicTech AAT2870"
-	select MFD_CORE
-	depends on I2C=y
-	depends on GPIOLIB || COMPILE_TEST
-	depends on GPIOLIB_LEGACY
-	help
-	  If you say yes here you get support for the AAT2870.
-	  This driver provides common support for accessing the device,
-	  additional drivers must be enabled in order to use the
-	  functionality of the device.
-
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e3fe998c3513..cf3c70364538 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -206,7 +206,6 @@ obj-$(CONFIG_MFD_QCOM_RPM)	+= qcom_rpm.o
 obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
-obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
 obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
deleted file mode 100644
index 0d56cd6fbc6a..000000000000
--- a/drivers/mfd/aat2870-core.c
+++ /dev/null
@@ -1,458 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/mfd/aat2870-core.c
- *
- * Copyright (c) 2011, NVIDIA Corporation.
- * Author: Jin Park <jinyoungp@nvidia.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/debugfs.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
-#include <linux/gpio/legacy.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/aat2870.h>
-#include <linux/regulator/machine.h>
-
-static struct aat2870_register aat2870_regs[AAT2870_REG_NUM] = {
-	/* readable, writeable, value */
-	{ 0, 1, 0x00 },	/* 0x00 AAT2870_BL_CH_EN */
-	{ 0, 1, 0x16 },	/* 0x01 AAT2870_BLM */
-	{ 0, 1, 0x16 },	/* 0x02 AAT2870_BLS */
-	{ 0, 1, 0x56 },	/* 0x03 AAT2870_BL1 */
-	{ 0, 1, 0x56 },	/* 0x04 AAT2870_BL2 */
-	{ 0, 1, 0x56 },	/* 0x05 AAT2870_BL3 */
-	{ 0, 1, 0x56 },	/* 0x06 AAT2870_BL4 */
-	{ 0, 1, 0x56 },	/* 0x07 AAT2870_BL5 */
-	{ 0, 1, 0x56 },	/* 0x08 AAT2870_BL6 */
-	{ 0, 1, 0x56 },	/* 0x09 AAT2870_BL7 */
-	{ 0, 1, 0x56 },	/* 0x0A AAT2870_BL8 */
-	{ 0, 1, 0x00 },	/* 0x0B AAT2870_FLR */
-	{ 0, 1, 0x03 },	/* 0x0C AAT2870_FM */
-	{ 0, 1, 0x03 },	/* 0x0D AAT2870_FS */
-	{ 0, 1, 0x10 },	/* 0x0E AAT2870_ALS_CFG0 */
-	{ 0, 1, 0x06 },	/* 0x0F AAT2870_ALS_CFG1 */
-	{ 0, 1, 0x00 },	/* 0x10 AAT2870_ALS_CFG2 */
-	{ 1, 0, 0x00 },	/* 0x11 AAT2870_AMB */
-	{ 0, 1, 0x00 },	/* 0x12 AAT2870_ALS0 */
-	{ 0, 1, 0x00 },	/* 0x13 AAT2870_ALS1 */
-	{ 0, 1, 0x00 },	/* 0x14 AAT2870_ALS2 */
-	{ 0, 1, 0x00 },	/* 0x15 AAT2870_ALS3 */
-	{ 0, 1, 0x00 },	/* 0x16 AAT2870_ALS4 */
-	{ 0, 1, 0x00 },	/* 0x17 AAT2870_ALS5 */
-	{ 0, 1, 0x00 },	/* 0x18 AAT2870_ALS6 */
-	{ 0, 1, 0x00 },	/* 0x19 AAT2870_ALS7 */
-	{ 0, 1, 0x00 },	/* 0x1A AAT2870_ALS8 */
-	{ 0, 1, 0x00 },	/* 0x1B AAT2870_ALS9 */
-	{ 0, 1, 0x00 },	/* 0x1C AAT2870_ALSA */
-	{ 0, 1, 0x00 },	/* 0x1D AAT2870_ALSB */
-	{ 0, 1, 0x00 },	/* 0x1E AAT2870_ALSC */
-	{ 0, 1, 0x00 },	/* 0x1F AAT2870_ALSD */
-	{ 0, 1, 0x00 },	/* 0x20 AAT2870_ALSE */
-	{ 0, 1, 0x00 },	/* 0x21 AAT2870_ALSF */
-	{ 0, 1, 0x00 },	/* 0x22 AAT2870_SUB_SET */
-	{ 0, 1, 0x00 },	/* 0x23 AAT2870_SUB_CTRL */
-	{ 0, 1, 0x00 },	/* 0x24 AAT2870_LDO_AB */
-	{ 0, 1, 0x00 },	/* 0x25 AAT2870_LDO_CD */
-	{ 0, 1, 0x00 },	/* 0x26 AAT2870_LDO_EN */
-};
-
-static struct mfd_cell aat2870_devs[] = {
-	{
-		.name = "aat2870-backlight",
-		.id = AAT2870_ID_BL,
-		.pdata_size = sizeof(struct aat2870_bl_platform_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOA,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOB,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOC,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOD,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-};
-
-static int __aat2870_read(struct aat2870_data *aat2870, u8 addr, u8 *val)
-{
-	int ret;
-
-	if (addr >= AAT2870_REG_NUM) {
-		dev_err(aat2870->dev, "Invalid address, 0x%02x\n", addr);
-		return -EINVAL;
-	}
-
-	if (!aat2870->reg_cache[addr].readable) {
-		*val = aat2870->reg_cache[addr].value;
-		goto out;
-	}
-
-	ret = i2c_master_send(aat2870->client, &addr, 1);
-	if (ret < 0)
-		return ret;
-	if (ret != 1)
-		return -EIO;
-
-	ret = i2c_master_recv(aat2870->client, val, 1);
-	if (ret < 0)
-		return ret;
-	if (ret != 1)
-		return -EIO;
-
-out:
-	dev_dbg(aat2870->dev, "read: addr=0x%02x, val=0x%02x\n", addr, *val);
-	return 0;
-}
-
-static int __aat2870_write(struct aat2870_data *aat2870, u8 addr, u8 val)
-{
-	u8 msg[2];
-	int ret;
-
-	if (addr >= AAT2870_REG_NUM) {
-		dev_err(aat2870->dev, "Invalid address, 0x%02x\n", addr);
-		return -EINVAL;
-	}
-
-	if (!aat2870->reg_cache[addr].writeable) {
-		dev_err(aat2870->dev, "Address 0x%02x is not writeable\n",
-			addr);
-		return -EINVAL;
-	}
-
-	msg[0] = addr;
-	msg[1] = val;
-	ret = i2c_master_send(aat2870->client, msg, 2);
-	if (ret < 0)
-		return ret;
-	if (ret != 2)
-		return -EIO;
-
-	aat2870->reg_cache[addr].value = val;
-
-	dev_dbg(aat2870->dev, "write: addr=0x%02x, val=0x%02x\n", addr, val);
-	return 0;
-}
-
-static int aat2870_read(struct aat2870_data *aat2870, u8 addr, u8 *val)
-{
-	int ret;
-
-	mutex_lock(&aat2870->io_lock);
-	ret = __aat2870_read(aat2870, addr, val);
-	mutex_unlock(&aat2870->io_lock);
-
-	return ret;
-}
-
-static int aat2870_write(struct aat2870_data *aat2870, u8 addr, u8 val)
-{
-	int ret;
-
-	mutex_lock(&aat2870->io_lock);
-	ret = __aat2870_write(aat2870, addr, val);
-	mutex_unlock(&aat2870->io_lock);
-
-	return ret;
-}
-
-static int aat2870_update(struct aat2870_data *aat2870, u8 addr, u8 mask,
-			  u8 val)
-{
-	int change;
-	u8 old_val, new_val;
-	int ret;
-
-	mutex_lock(&aat2870->io_lock);
-
-	ret = __aat2870_read(aat2870, addr, &old_val);
-	if (ret)
-		goto out_unlock;
-
-	new_val = (old_val & ~mask) | (val & mask);
-	change = old_val != new_val;
-	if (change)
-		ret = __aat2870_write(aat2870, addr, new_val);
-
-out_unlock:
-	mutex_unlock(&aat2870->io_lock);
-
-	return ret;
-}
-
-static inline void aat2870_enable(struct aat2870_data *aat2870)
-{
-	if (aat2870->en_pin >= 0)
-		gpio_set_value(aat2870->en_pin, 1);
-
-	aat2870->is_enable = 1;
-}
-
-static inline void aat2870_disable(struct aat2870_data *aat2870)
-{
-	if (aat2870->en_pin >= 0)
-		gpio_set_value(aat2870->en_pin, 0);
-
-	aat2870->is_enable = 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-static ssize_t aat2870_dump_reg(struct aat2870_data *aat2870, char *buf)
-{
-	u8 addr, val;
-	ssize_t count = 0;
-	int ret;
-
-	count += sprintf(buf, "aat2870 registers\n");
-	for (addr = 0; addr < AAT2870_REG_NUM; addr++) {
-		count += snprintf(buf + count, PAGE_SIZE - count, "0x%02x: ", addr);
-		if (count >= PAGE_SIZE - 1)
-			break;
-
-		ret = aat2870->read(aat2870, addr, &val);
-		if (ret == 0)
-			count += snprintf(buf + count, PAGE_SIZE - count,
-					  "0x%02x", val);
-		else
-			count += snprintf(buf + count, PAGE_SIZE - count,
-					  "<read fail: %d>", ret);
-
-		if (count >= PAGE_SIZE - 1)
-			break;
-
-		count += snprintf(buf + count, PAGE_SIZE - count, "\n");
-		if (count >= PAGE_SIZE - 1)
-			break;
-	}
-
-	/* Truncate count; min() would cause a warning */
-	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
-
-	return count;
-}
-
-static ssize_t aat2870_reg_read_file(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct aat2870_data *aat2870 = file->private_data;
-	char *buf;
-	ssize_t ret;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = aat2870_dump_reg(aat2870, buf);
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
-	kfree(buf);
-
-	return ret;
-}
-
-static ssize_t aat2870_reg_write_file(struct file *file,
-				      const char __user *user_buf, size_t count,
-				      loff_t *ppos)
-{
-	struct aat2870_data *aat2870 = file->private_data;
-	char buf[32];
-	ssize_t buf_size;
-	char *start = buf;
-	unsigned long addr, val;
-	int ret;
-
-	buf_size = min(count, (size_t)(sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size)) {
-		dev_err(aat2870->dev, "Failed to copy from user\n");
-		return -EFAULT;
-	}
-	buf[buf_size] = 0;
-
-	while (*start == ' ')
-		start++;
-
-	ret = kstrtoul(start, 16, &addr);
-	if (ret)
-		return ret;
-
-	if (addr >= AAT2870_REG_NUM) {
-		dev_err(aat2870->dev, "Invalid address, 0x%lx\n", addr);
-		return -EINVAL;
-	}
-
-	while (*start == ' ')
-		start++;
-
-	ret = kstrtoul(start, 16, &val);
-	if (ret)
-		return ret;
-
-	ret = aat2870->write(aat2870, (u8)addr, (u8)val);
-	if (ret)
-		return ret;
-
-	return buf_size;
-}
-
-static const struct file_operations aat2870_reg_fops = {
-	.open = simple_open,
-	.read = aat2870_reg_read_file,
-	.write = aat2870_reg_write_file,
-};
-
-static void aat2870_init_debugfs(struct aat2870_data *aat2870)
-{
-	debugfs_create_file("regs", 0644, aat2870->client->debugfs, aat2870,
-			    &aat2870_reg_fops);
-}
-
-#else
-static inline void aat2870_init_debugfs(struct aat2870_data *aat2870)
-{
-}
-#endif /* CONFIG_DEBUG_FS */
-
-static int aat2870_i2c_probe(struct i2c_client *client)
-{
-	struct aat2870_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct aat2870_data *aat2870;
-	int i, j;
-	int ret = 0;
-
-	aat2870 = devm_kzalloc(&client->dev, sizeof(struct aat2870_data),
-				GFP_KERNEL);
-	if (!aat2870)
-		return -ENOMEM;
-
-	aat2870->dev = &client->dev;
-	aat2870->client = client;
-	i2c_set_clientdata(client, aat2870);
-
-	aat2870->reg_cache = aat2870_regs;
-
-	if (pdata->en_pin < 0)
-		aat2870->en_pin = -1;
-	else
-		aat2870->en_pin = pdata->en_pin;
-
-	aat2870->init = pdata->init;
-	aat2870->uninit = pdata->uninit;
-	aat2870->read = aat2870_read;
-	aat2870->write = aat2870_write;
-	aat2870->update = aat2870_update;
-
-	mutex_init(&aat2870->io_lock);
-
-	if (aat2870->init)
-		aat2870->init(aat2870);
-
-	if (aat2870->en_pin >= 0) {
-		ret = devm_gpio_request_one(&client->dev, aat2870->en_pin,
-					GPIOF_OUT_INIT_HIGH, "aat2870-en");
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"Failed to request GPIO %d\n", aat2870->en_pin);
-			return ret;
-		}
-	}
-
-	aat2870_enable(aat2870);
-
-	for (i = 0; i < pdata->num_subdevs; i++) {
-		for (j = 0; j < ARRAY_SIZE(aat2870_devs); j++) {
-			if ((pdata->subdevs[i].id == aat2870_devs[j].id) &&
-					!strcmp(pdata->subdevs[i].name,
-						aat2870_devs[j].name)) {
-				aat2870_devs[j].platform_data =
-					pdata->subdevs[i].platform_data;
-				break;
-			}
-		}
-	}
-
-	ret = mfd_add_devices(aat2870->dev, 0, aat2870_devs,
-			      ARRAY_SIZE(aat2870_devs), NULL, 0, NULL);
-	if (ret != 0) {
-		dev_err(aat2870->dev, "Failed to add subdev: %d\n", ret);
-		goto out_disable;
-	}
-
-	aat2870_init_debugfs(aat2870);
-
-	return 0;
-
-out_disable:
-	aat2870_disable(aat2870);
-	return ret;
-}
-
-static int aat2870_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct aat2870_data *aat2870 = i2c_get_clientdata(client);
-
-	aat2870_disable(aat2870);
-
-	return 0;
-}
-
-static int aat2870_i2c_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct aat2870_data *aat2870 = i2c_get_clientdata(client);
-	struct aat2870_register *reg = NULL;
-	int i;
-
-	aat2870_enable(aat2870);
-
-	/* restore registers */
-	for (i = 0; i < AAT2870_REG_NUM; i++) {
-		reg = &aat2870->reg_cache[i];
-		if (reg->writeable)
-			aat2870->write(aat2870, i, reg->value);
-	}
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
-				aat2870_i2c_resume);
-
-static const struct i2c_device_id aat2870_i2c_id_table[] = {
-	{ "aat2870" },
-	{ }
-};
-
-static struct i2c_driver aat2870_i2c_driver = {
-	.driver = {
-		.name			= "aat2870",
-		.pm			= pm_sleep_ptr(&aat2870_pm_ops),
-		.suppress_bind_attrs	= true,
-	},
-	.probe		= aat2870_i2c_probe,
-	.id_table	= aat2870_i2c_id_table,
-};
-
-static int __init aat2870_init(void)
-{
-	return i2c_add_driver(&aat2870_i2c_driver);
-}
-subsys_initcall(aat2870_init);
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4b90d1cb045c..12d883e729bc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -132,13 +132,6 @@ config REGULATOR_ANATOP
 	  regulators. It is recommended that this option be
 	  enabled on i.MX6 platform.
 
-config REGULATOR_AAT2870
-	tristate "AnalogicTech AAT2870 Regulators"
-	depends on MFD_AAT2870_CORE
-	help
-	  If you have a AnalogicTech AAT2870 say Y to enable the
-	  regulator driver.
-
 config REGULATOR_AB8500
 	bool "ST-Ericsson AB8500 Power Regulators"
 	depends on AB8500_CORE
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index fe0f099c217b..321c6ea73ee0 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_88PM886) += 88pm886-regulator.o
 obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
-obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
 obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500-ext.o ab8500.o
 obj-$(CONFIG_REGULATOR_ACT8865) += act8865-regulator.o
 obj-$(CONFIG_REGULATOR_ACT8945A) += act8945a-regulator.o
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
deleted file mode 100644
index 970d86f2bbb8..000000000000
--- a/drivers/regulator/aat2870-regulator.c
+++ /dev/null
@@ -1,201 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/regulator/aat2870-regulator.c
- *
- * Copyright (c) 2011, NVIDIA Corporation.
- * Author: Jin Park <jinyoungp@nvidia.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/mfd/aat2870.h>
-
-struct aat2870_regulator {
-	struct aat2870_data *aat2870;
-	struct regulator_desc desc;
-
-	u8 enable_addr;
-	u8 enable_shift;
-	u8 enable_mask;
-
-	u8 voltage_addr;
-	u8 voltage_shift;
-	u8 voltage_mask;
-};
-
-static int aat2870_ldo_set_voltage_sel(struct regulator_dev *rdev,
-				       unsigned selector)
-{
-	struct aat2870_regulator *ri = rdev_get_drvdata(rdev);
-	struct aat2870_data *aat2870 = ri->aat2870;
-
-	return aat2870->update(aat2870, ri->voltage_addr, ri->voltage_mask,
-			       selector << ri->voltage_shift);
-}
-
-static int aat2870_ldo_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct aat2870_regulator *ri = rdev_get_drvdata(rdev);
-	struct aat2870_data *aat2870 = ri->aat2870;
-	u8 val;
-	int ret;
-
-	ret = aat2870->read(aat2870, ri->voltage_addr, &val);
-	if (ret)
-		return ret;
-
-	return (val & ri->voltage_mask) >> ri->voltage_shift;
-}
-
-static int aat2870_ldo_enable(struct regulator_dev *rdev)
-{
-	struct aat2870_regulator *ri = rdev_get_drvdata(rdev);
-	struct aat2870_data *aat2870 = ri->aat2870;
-
-	return aat2870->update(aat2870, ri->enable_addr, ri->enable_mask,
-			       ri->enable_mask);
-}
-
-static int aat2870_ldo_disable(struct regulator_dev *rdev)
-{
-	struct aat2870_regulator *ri = rdev_get_drvdata(rdev);
-	struct aat2870_data *aat2870 = ri->aat2870;
-
-	return aat2870->update(aat2870, ri->enable_addr, ri->enable_mask, 0);
-}
-
-static int aat2870_ldo_is_enabled(struct regulator_dev *rdev)
-{
-	struct aat2870_regulator *ri = rdev_get_drvdata(rdev);
-	struct aat2870_data *aat2870 = ri->aat2870;
-	u8 val;
-	int ret;
-
-	ret = aat2870->read(aat2870, ri->enable_addr, &val);
-	if (ret)
-		return ret;
-
-	return val & ri->enable_mask ? 1 : 0;
-}
-
-static const struct regulator_ops aat2870_ldo_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
-	.set_voltage_sel = aat2870_ldo_set_voltage_sel,
-	.get_voltage_sel = aat2870_ldo_get_voltage_sel,
-	.enable = aat2870_ldo_enable,
-	.disable = aat2870_ldo_disable,
-	.is_enabled = aat2870_ldo_is_enabled,
-};
-
-static const unsigned int aat2870_ldo_voltages[] = {
-	1200000, 1300000, 1500000, 1600000,
-	1800000, 2000000, 2200000, 2500000,
-	2600000, 2700000, 2800000, 2900000,
-	3000000, 3100000, 3200000, 3300000,
-};
-
-#define AAT2870_LDO(ids)				\
-	{						\
-		.desc = {				\
-			.name = #ids,			\
-			.id = AAT2870_ID_##ids,		\
-			.n_voltages = ARRAY_SIZE(aat2870_ldo_voltages),	\
-			.volt_table = aat2870_ldo_voltages, \
-			.ops = &aat2870_ldo_ops,	\
-			.type = REGULATOR_VOLTAGE,	\
-			.owner = THIS_MODULE,		\
-		},					\
-	}
-
-static struct aat2870_regulator aat2870_regulators[] = {
-	AAT2870_LDO(LDOA),
-	AAT2870_LDO(LDOB),
-	AAT2870_LDO(LDOC),
-	AAT2870_LDO(LDOD),
-};
-
-static struct aat2870_regulator *aat2870_get_regulator(int id)
-{
-	struct aat2870_regulator *ri = NULL;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aat2870_regulators); i++) {
-		ri = &aat2870_regulators[i];
-		if (ri->desc.id == id)
-			break;
-	}
-
-	if (i == ARRAY_SIZE(aat2870_regulators))
-		return NULL;
-
-	ri->enable_addr = AAT2870_LDO_EN;
-	ri->enable_shift = id - AAT2870_ID_LDOA;
-	ri->enable_mask = 0x1 << ri->enable_shift;
-
-	ri->voltage_addr = (id - AAT2870_ID_LDOA) / 2 ?
-			   AAT2870_LDO_CD : AAT2870_LDO_AB;
-	ri->voltage_shift = (id - AAT2870_ID_LDOA) % 2 ? 0 : 4;
-	ri->voltage_mask = 0xF << ri->voltage_shift;
-
-	return ri;
-}
-
-static int aat2870_regulator_probe(struct platform_device *pdev)
-{
-	struct aat2870_regulator *ri;
-	struct regulator_config config = { };
-	struct regulator_dev *rdev;
-
-	ri = aat2870_get_regulator(pdev->id);
-	if (!ri) {
-		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
-		return -EINVAL;
-	}
-	ri->aat2870 = dev_get_drvdata(pdev->dev.parent);
-
-	config.dev = &pdev->dev;
-	config.driver_data = ri;
-	config.init_data = dev_get_platdata(&pdev->dev);
-
-	rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&pdev->dev, "Failed to register regulator %s\n",
-			ri->desc.name);
-		return PTR_ERR(rdev);
-	}
-	platform_set_drvdata(pdev, rdev);
-
-	return 0;
-}
-
-static struct platform_driver aat2870_regulator_driver = {
-	.driver = {
-		.name	= "aat2870-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe	= aat2870_regulator_probe,
-};
-
-static int __init aat2870_regulator_init(void)
-{
-	return platform_driver_register(&aat2870_regulator_driver);
-}
-subsys_initcall(aat2870_regulator_init);
-
-static void __exit aat2870_regulator_exit(void)
-{
-	platform_driver_unregister(&aat2870_regulator_driver);
-}
-module_exit(aat2870_regulator_exit);
-
-MODULE_DESCRIPTION("AnalogicTech AAT2870 Regulator");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jin Park <jinyoungp@nvidia.com>");
-MODULE_ALIAS("platform:aat2870-regulator");
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 2c206d2713e3..4acbac1bbb9e 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -388,13 +388,6 @@ config BACKLIGHT_88PM860X
 	help
 	  Say Y to enable the backlight driver for Marvell 88PM8606.
 
-config BACKLIGHT_AAT2870
-	tristate "AnalogicTech AAT2870 Backlight"
-	depends on MFD_AAT2870_CORE
-	help
-	  If you have a AnalogicTech AAT2870 say Y to enable the
-	  backlight driver.
-
 config BACKLIGHT_LM3509
 	tristate "Backlight Driver for LM3509"
 	depends on I2C
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 0497eaa639cd..e11175bdd500 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_LCD_TDO24M)		+= tdo24m.o
 obj-$(CONFIG_LCD_VGG2432A4)		+= vgg2432a4.o
 
 obj-$(CONFIG_BACKLIGHT_88PM860X)	+= 88pm860x_bl.o
-obj-$(CONFIG_BACKLIGHT_AAT2870)		+= aat2870_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP8860)		+= adp8860_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP8870)		+= adp8870_bl.o
 obj-$(CONFIG_BACKLIGHT_APPLE)		+= apple_bl.o
diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
deleted file mode 100644
index 8b790df1e842..000000000000
--- a/drivers/video/backlight/aat2870_bl.c
+++ /dev/null
@@ -1,206 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/video/backlight/aat2870_bl.c
- *
- * Copyright (c) 2011, NVIDIA Corporation.
- * Author: Jin Park <jinyoungp@nvidia.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/backlight.h>
-#include <linux/mfd/aat2870.h>
-
-struct aat2870_bl_driver_data {
-	struct platform_device *pdev;
-	struct backlight_device *bd;
-
-	int channels;
-	int max_current;
-	int brightness; /* current brightness */
-};
-
-static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
-				     int brightness)
-{
-	struct backlight_device *bd = aat2870_bl->bd;
-	int val;
-
-	val = brightness * (aat2870_bl->max_current - 1);
-	val /= bd->props.max_brightness;
-
-	return val;
-}
-
-static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat2870_bl)
-{
-	struct aat2870_data *aat2870
-			= dev_get_drvdata(aat2870_bl->pdev->dev.parent);
-
-	return aat2870->write(aat2870, AAT2870_BL_CH_EN,
-			      (u8)aat2870_bl->channels);
-}
-
-static inline int aat2870_bl_disable(struct aat2870_bl_driver_data *aat2870_bl)
-{
-	struct aat2870_data *aat2870
-			= dev_get_drvdata(aat2870_bl->pdev->dev.parent);
-
-	return aat2870->write(aat2870, AAT2870_BL_CH_EN, 0x0);
-}
-
-static int aat2870_bl_update_status(struct backlight_device *bd)
-{
-	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
-	struct aat2870_data *aat2870 =
-			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
-	int brightness = backlight_get_brightness(bd);
-	int ret;
-
-	if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
-		dev_err(&bd->dev, "invalid brightness, %d\n", brightness);
-		return -EINVAL;
-	}
-
-	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
-		 bd->props.brightness, bd->props.power, bd->props.state);
-
-	ret = aat2870->write(aat2870, AAT2870_BLM,
-			     (u8)aat2870_brightness(aat2870_bl, brightness));
-	if (ret < 0)
-		return ret;
-
-	if (brightness == 0) {
-		ret = aat2870_bl_disable(aat2870_bl);
-		if (ret < 0)
-			return ret;
-	} else if (aat2870_bl->brightness == 0) {
-		ret = aat2870_bl_enable(aat2870_bl);
-		if (ret < 0)
-			return ret;
-	}
-
-	aat2870_bl->brightness = brightness;
-
-	return 0;
-}
-
-static const struct backlight_ops aat2870_bl_ops = {
-	.options = BL_CORE_SUSPENDRESUME,
-	.update_status = aat2870_bl_update_status,
-};
-
-static int aat2870_bl_probe(struct platform_device *pdev)
-{
-	struct aat2870_bl_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct aat2870_bl_driver_data *aat2870_bl;
-	struct backlight_device *bd;
-	struct backlight_properties props;
-	int ret = 0;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		ret = -ENXIO;
-		goto out;
-	}
-
-	if (pdev->id != AAT2870_ID_BL) {
-		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	aat2870_bl = devm_kzalloc(&pdev->dev,
-				  sizeof(struct aat2870_bl_driver_data),
-				  GFP_KERNEL);
-	if (!aat2870_bl) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	memset(&props, 0, sizeof(struct backlight_properties));
-
-	props.type = BACKLIGHT_RAW;
-	bd = devm_backlight_device_register(&pdev->dev, "aat2870-backlight",
-					&pdev->dev, aat2870_bl, &aat2870_bl_ops,
-					&props);
-	if (IS_ERR(bd)) {
-		dev_err(&pdev->dev,
-			"Failed allocate memory for backlight device\n");
-		ret = PTR_ERR(bd);
-		goto out;
-	}
-
-	aat2870_bl->pdev = pdev;
-	platform_set_drvdata(pdev, aat2870_bl);
-
-	aat2870_bl->bd = bd;
-
-	if (pdata->channels > 0)
-		aat2870_bl->channels = pdata->channels;
-	else
-		aat2870_bl->channels = AAT2870_BL_CH_ALL;
-
-	if (pdata->max_current > 0)
-		aat2870_bl->max_current = pdata->max_current;
-	else
-		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
-
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
-	else
-		bd->props.max_brightness = 255;
-
-	aat2870_bl->brightness = 0;
-	bd->props.power = BACKLIGHT_POWER_ON;
-	bd->props.brightness = bd->props.max_brightness;
-
-	ret = aat2870_bl_update_status(bd);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to initialize\n");
-		return ret;
-	}
-
-	return 0;
-
-out:
-	return ret;
-}
-
-static void aat2870_bl_remove(struct platform_device *pdev)
-{
-	struct aat2870_bl_driver_data *aat2870_bl = platform_get_drvdata(pdev);
-	struct backlight_device *bd = aat2870_bl->bd;
-
-	bd->props.power = BACKLIGHT_POWER_OFF;
-	bd->props.brightness = 0;
-	backlight_update_status(bd);
-}
-
-static struct platform_driver aat2870_bl_driver = {
-	.driver = {
-		.name	= "aat2870-backlight",
-	},
-	.probe		= aat2870_bl_probe,
-	.remove		= aat2870_bl_remove,
-};
-
-static int __init aat2870_bl_init(void)
-{
-	return platform_driver_register(&aat2870_bl_driver);
-}
-subsys_initcall(aat2870_bl_init);
-
-static void __exit aat2870_bl_exit(void)
-{
-	platform_driver_unregister(&aat2870_bl_driver);
-}
-module_exit(aat2870_bl_exit);
-
-MODULE_DESCRIPTION("AnalogicTech AAT2870 Backlight");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jin Park <jinyoungp@nvidia.com>");
diff --git a/include/linux/mfd/aat2870.h b/include/linux/mfd/aat2870.h
deleted file mode 100644
index c7a3c53eba68..000000000000
--- a/include/linux/mfd/aat2870.h
+++ /dev/null
@@ -1,164 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * linux/include/linux/mfd/aat2870.h
- *
- * Copyright (c) 2011, NVIDIA Corporation.
- * Author: Jin Park <jinyoungp@nvidia.com>
- */
-
-#ifndef __LINUX_MFD_AAT2870_H
-#define __LINUX_MFD_AAT2870_H
-
-#include <linux/debugfs.h>
-#include <linux/i2c.h>
-
-/* Register offsets */
-#define AAT2870_BL_CH_EN	0x00
-#define AAT2870_BLM		0x01
-#define AAT2870_BLS		0x02
-#define AAT2870_BL1		0x03
-#define AAT2870_BL2		0x04
-#define AAT2870_BL3		0x05
-#define AAT2870_BL4		0x06
-#define AAT2870_BL5		0x07
-#define AAT2870_BL6		0x08
-#define AAT2870_BL7		0x09
-#define AAT2870_BL8		0x0A
-#define AAT2870_FLR		0x0B
-#define AAT2870_FM		0x0C
-#define AAT2870_FS		0x0D
-#define AAT2870_ALS_CFG0	0x0E
-#define AAT2870_ALS_CFG1	0x0F
-#define AAT2870_ALS_CFG2	0x10
-#define AAT2870_AMB		0x11
-#define AAT2870_ALS0		0x12
-#define AAT2870_ALS1		0x13
-#define AAT2870_ALS2		0x14
-#define AAT2870_ALS3		0x15
-#define AAT2870_ALS4		0x16
-#define AAT2870_ALS5		0x17
-#define AAT2870_ALS6		0x18
-#define AAT2870_ALS7		0x19
-#define AAT2870_ALS8		0x1A
-#define AAT2870_ALS9		0x1B
-#define AAT2870_ALSA		0x1C
-#define AAT2870_ALSB		0x1D
-#define AAT2870_ALSC		0x1E
-#define AAT2870_ALSD		0x1F
-#define AAT2870_ALSE		0x20
-#define AAT2870_ALSF		0x21
-#define AAT2870_SUB_SET		0x22
-#define AAT2870_SUB_CTRL	0x23
-#define AAT2870_LDO_AB		0x24
-#define AAT2870_LDO_CD		0x25
-#define AAT2870_LDO_EN		0x26
-#define AAT2870_REG_NUM		0x27
-
-/* Device IDs */
-enum aat2870_id {
-	AAT2870_ID_BL,
-	AAT2870_ID_LDOA,
-	AAT2870_ID_LDOB,
-	AAT2870_ID_LDOC,
-	AAT2870_ID_LDOD
-};
-
-/* Backlight channels */
-#define AAT2870_BL_CH1		0x01
-#define AAT2870_BL_CH2		0x02
-#define AAT2870_BL_CH3		0x04
-#define AAT2870_BL_CH4		0x08
-#define AAT2870_BL_CH5		0x10
-#define AAT2870_BL_CH6		0x20
-#define AAT2870_BL_CH7		0x40
-#define AAT2870_BL_CH8		0x80
-#define AAT2870_BL_CH_ALL	0xFF
-
-/* Backlight current magnitude (mA) */
-enum aat2870_current {
-	AAT2870_CURRENT_0_45 = 1,
-	AAT2870_CURRENT_0_90,
-	AAT2870_CURRENT_1_80,
-	AAT2870_CURRENT_2_70,
-	AAT2870_CURRENT_3_60,
-	AAT2870_CURRENT_4_50,
-	AAT2870_CURRENT_5_40,
-	AAT2870_CURRENT_6_30,
-	AAT2870_CURRENT_7_20,
-	AAT2870_CURRENT_8_10,
-	AAT2870_CURRENT_9_00,
-	AAT2870_CURRENT_9_90,
-	AAT2870_CURRENT_10_8,
-	AAT2870_CURRENT_11_7,
-	AAT2870_CURRENT_12_6,
-	AAT2870_CURRENT_13_5,
-	AAT2870_CURRENT_14_4,
-	AAT2870_CURRENT_15_3,
-	AAT2870_CURRENT_16_2,
-	AAT2870_CURRENT_17_1,
-	AAT2870_CURRENT_18_0,
-	AAT2870_CURRENT_18_9,
-	AAT2870_CURRENT_19_8,
-	AAT2870_CURRENT_20_7,
-	AAT2870_CURRENT_21_6,
-	AAT2870_CURRENT_22_5,
-	AAT2870_CURRENT_23_4,
-	AAT2870_CURRENT_24_3,
-	AAT2870_CURRENT_25_2,
-	AAT2870_CURRENT_26_1,
-	AAT2870_CURRENT_27_0,
-	AAT2870_CURRENT_27_9
-};
-
-struct aat2870_register {
-	bool readable;
-	bool writeable;
-	u8 value;
-};
-
-struct aat2870_data {
-	struct device *dev;
-	struct i2c_client *client;
-
-	struct mutex io_lock;
-	struct aat2870_register *reg_cache; /* register cache */
-	int en_pin; /* enable GPIO pin (if < 0, ignore this value) */
-	bool is_enable;
-
-	/* init and uninit for platform specified */
-	int (*init)(struct aat2870_data *aat2870);
-	void (*uninit)(struct aat2870_data *aat2870);
-
-	/* i2c io funcntions */
-	int (*read)(struct aat2870_data *aat2870, u8 addr, u8 *val);
-	int (*write)(struct aat2870_data *aat2870, u8 addr, u8 val);
-	int (*update)(struct aat2870_data *aat2870, u8 addr, u8 mask, u8 val);
-};
-
-struct aat2870_subdev_info {
-	int id;
-	const char *name;
-	void *platform_data;
-};
-
-struct aat2870_platform_data {
-	int en_pin; /* enable GPIO pin (if < 0, ignore this value) */
-
-	struct aat2870_subdev_info *subdevs;
-	int num_subdevs;
-
-	/* init and uninit for platform specified */
-	int (*init)(struct aat2870_data *aat2870);
-	void (*uninit)(struct aat2870_data *aat2870);
-};
-
-struct aat2870_bl_platform_data {
-	/* backlight channels, default is AAT2870_BL_CH_ALL */
-	int channels;
-	/* backlight current magnitude, default is AAT2870_CURRENT_27_9 */
-	int max_current;
-	/* maximum brightness, default is 255 */
-	int max_brightness;
-};
-
-#endif /* __LINUX_MFD_AAT2870_H */
-- 
2.53.0


