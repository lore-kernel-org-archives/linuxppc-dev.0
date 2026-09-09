Return-Path: <linuxppc-dev+bounces-26925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98AC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:22:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1h54fpwz2yrr;
	Wed, 09 Sep 2026 23:22:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960165;
	cv=none; b=a0pj1QnZaQmUa1iZceVn+hHRIVbrz0Tq2uM6oSrTGG6VWPTjFsS+Et0KcK/rE57LBHTHX4OGnwZbLEvDnsTlhD7tTy1lJbATTZAFRE1nRDvYyQ8uOhSiJfVFUNcuzIqgnNjkDcZvbbEmwt7w4dC5+hFl38fI5vGng0dKiXj6OXFWTB68F2Z3Mzp9grk/npETjbWZE0P/Ne+UBO1Sbvb7dPMJZfnhpyIm0u3kwbg71m8kf8JXdq6ZBuA8sLhuaeZVkuTPfutq5U0hQWUOeE0SjYY52Cy26CqiyswBbxzLzQ61fIzOgD8wOQ7yB4MPLkB64G3Nm+z++9KfINnGwMsUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960165; c=relaxed/relaxed;
	bh=RLj9JAvIYk4hhwXmR1Zy6vSDP+yyZsL5VLptCNd+Xu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT9S4Yl/JKYILmxbDi5J6mEkfxd8PRaDW6YYTeZuhR7Oav4g77p9rxKd7nrPx4PcxET2l+qjfBZG/HAzyUgO3JG0uKaSXuF+GP4ekeb7oVHXef9FyQHwYXyCQ1fTest/S8kz2Y8du3XDAR9smiCTamZKGZHvVv4CGvnkwz3E0Aw/Y8NyUYDkVcFuxHNnE6i696bBLtwAwLBoF85hoaGWZNB6xEYfhQP74hjzvvS/BodHZu/2TdvBBlWxxjiLkUcBWP5AcJYe6oSsg/iVjZNdHIs0YVm2e4EDiOb/41ZC64QigSf3CZIR9vEUfYH+238dkdKpFf/49mSoCoAmUCoCbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X66sx3Rg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X66sx3Rg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1gx16Cxz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:22:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7950A43251;
	Wed,  9 Sep 2026 13:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFD91F00A3A;
	Wed,  9 Sep 2026 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960150;
	bh=RLj9JAvIYk4hhwXmR1Zy6vSDP+yyZsL5VLptCNd+Xu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X66sx3RgfDt6T3dCAmSe8hUNdGz9RKOB5ncKjWnr21qac+TVIT55c2Tf1V6gDTIAm
	 I6/i/fMvWFc4YRUmh8Z3/jJIdUoZQtb5XnViO06OcQaKUnL6eSXBjFKFhCH8jn699g
	 EqV+g8NNqwBNgWbbpzbe0dODtyNSZuKQ4dMAuFMvqdCj+1o3pP5TJjNq2kKyxUFTYL
	 FfKVbXnQX+W5b/mvwjPccuZHSbXN0R/jIWcmzu5EW4/G0d4hh1EhOdg+nlCRsSq6j7
	 iyCd1vwKU/raxjxNRKIIRv+IvUv5QC43Lr5ff2H5qS9rONJaqCFCIlWlvqWl4fNH71
	 v3GlnRwP1SUvA==
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
Subject: [PATCH 01/14] mfd: remove unused 88pm80x driver
Date: Wed,  9 Sep 2026 15:21:38 +0200
Message-ID: <20260909132153.1596191-2-arnd@kernel.org>
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

This pair of drivers was originally added as companion chips for pxa/mmp
SoCs, but the corresponding platform code was never merged, so it has
been unused the entire time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/regulator/88pm800.txt |  38 --
 drivers/input/misc/88pm80x_onkey.c            | 152 -----
 drivers/input/misc/Kconfig                    |  10 -
 drivers/input/misc/Makefile                   |   1 -
 drivers/mfd/88pm800.c                         | 619 ------------------
 drivers/mfd/88pm805.c                         | 275 --------
 drivers/mfd/88pm80x.c                         | 159 -----
 drivers/mfd/Kconfig                           |  24 -
 drivers/mfd/Makefile                          |   2 -
 drivers/regulator/88pm800-regulator.c         | 287 --------
 drivers/regulator/Kconfig                     |  10 -
 drivers/regulator/Makefile                    |   1 -
 drivers/rtc/Kconfig                           |  10 -
 drivers/rtc/Makefile                          |   1 -
 drivers/rtc/rtc-88pm80x.c                     | 340 ----------
 include/linux/mfd/88pm80x.h                   | 370 -----------
 16 files changed, 2299 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/88pm800.txt
 delete mode 100644 drivers/input/misc/88pm80x_onkey.c
 delete mode 100644 drivers/mfd/88pm800.c
 delete mode 100644 drivers/mfd/88pm805.c
 delete mode 100644 drivers/mfd/88pm80x.c
 delete mode 100644 drivers/regulator/88pm800-regulator.c
 delete mode 100644 drivers/rtc/rtc-88pm80x.c
 delete mode 100644 include/linux/mfd/88pm80x.h

diff --git a/Documentation/devicetree/bindings/regulator/88pm800.txt b/Documentation/devicetree/bindings/regulator/88pm800.txt
deleted file mode 100644
index e8a54c2a5821..000000000000
--- a/Documentation/devicetree/bindings/regulator/88pm800.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Marvell 88PM800 regulator
-
-Required properties:
-- compatible: "marvell,88pm800"
-- reg: I2C slave address
-- regulators: A node that houses a sub-node for each regulator within the
-  device. Each sub-node is identified using the node's name (or the deprecated
-  regulator-compatible property if present), with valid values listed below.
-  The content of each sub-node is defined by the standard binding for
-  regulators; see regulator.txt.
-
-The valid names for regulators are:
-
-  buck1, buck2, buck3, buck4, buck5, ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7,
-  ldo8, ldo9, ldo10, ldo11, ldo12, ldo13, ldo14, ldo15, ldo16, ldo17, ldo18, ldo19
-
-Example:
-
-	pmic: 88pm800@31 {
-		compatible = "marvell,88pm800";
-		reg = <0x31>;
-
-		regulators {
-			buck1 {
-			        regulator-min-microvolt = <600000>;
-			        regulator-max-microvolt = <3950000>;
-			        regulator-boot-on;
-			        regulator-always-on;
-			};
-			ldo1 {
-			        regulator-min-microvolt = <600000>;
-			        regulator-max-microvolt = <15000000>;
-			        regulator-boot-on;
-			        regulator-always-on;
-			};
-...
-		};
-	};
diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
deleted file mode 100644
index fee28e537898..000000000000
--- a/drivers/input/misc/88pm80x_onkey.c
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Marvell 88PM80x ONKEY driver
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Haojian Zhuang <haojian.zhuang@marvell.com>
- * Qiao Zhou <zhouqiao@marvell.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-
-#define PM800_LONG_ONKEY_EN		(1 << 0)
-#define PM800_LONG_KEY_DELAY		(8)	/* 1 .. 16 seconds */
-#define PM800_LONKEY_PRESS_TIME		((PM800_LONG_KEY_DELAY-1) << 4)
-#define PM800_LONKEY_PRESS_TIME_MASK	(0xF0)
-#define PM800_SW_PDOWN			(1 << 5)
-
-struct pm80x_onkey_info {
-	struct input_dev *idev;
-	struct pm80x_chip *pm80x;
-	struct regmap *map;
-	int irq;
-};
-
-/* 88PM80x gives us an interrupt when ONKEY is held */
-static irqreturn_t pm80x_onkey_handler(int irq, void *data)
-{
-	struct pm80x_onkey_info *info = data;
-	int ret = 0;
-	unsigned int val;
-
-	ret = regmap_read(info->map, PM800_STATUS_1, &val);
-	if (ret < 0) {
-		dev_err(info->idev->dev.parent, "failed to read status: %d\n", ret);
-		return IRQ_NONE;
-	}
-	val &= PM800_ONKEY_STS1;
-
-	input_report_key(info->idev, KEY_POWER, val);
-	input_sync(info->idev);
-
-	return IRQ_HANDLED;
-}
-
-static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
-			 pm80x_dev_resume);
-
-static int pm80x_onkey_probe(struct platform_device *pdev)
-{
-
-	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm80x_onkey_info *info;
-	int err;
-
-	info = kzalloc_obj(*info);
-	if (!info)
-		return -ENOMEM;
-
-	info->pm80x = chip;
-
-	info->irq = platform_get_irq(pdev, 0);
-	if (info->irq < 0) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	info->map = info->pm80x->regmap;
-	if (!info->map) {
-		dev_err(&pdev->dev, "no regmap!\n");
-		err = -EINVAL;
-		goto out;
-	}
-
-	info->idev = input_allocate_device();
-	if (!info->idev) {
-		dev_err(&pdev->dev, "Failed to allocate input dev\n");
-		err = -ENOMEM;
-		goto out;
-	}
-
-	info->idev->name = "88pm80x_on";
-	info->idev->phys = "88pm80x_on/input0";
-	info->idev->id.bustype = BUS_I2C;
-	info->idev->dev.parent = &pdev->dev;
-	info->idev->evbit[0] = BIT_MASK(EV_KEY);
-	__set_bit(KEY_POWER, info->idev->keybit);
-
-	err = pm80x_request_irq(info->pm80x, info->irq, pm80x_onkey_handler,
-					    IRQF_ONESHOT, "onkey", info);
-	if (err < 0) {
-		dev_err(&pdev->dev, "Failed to request IRQ: #%d: %d\n",
-			info->irq, err);
-		goto out_reg;
-	}
-
-	err = input_register_device(info->idev);
-	if (err) {
-		dev_err(&pdev->dev, "Can't register input device: %d\n", err);
-		goto out_irq;
-	}
-
-	platform_set_drvdata(pdev, info);
-
-	/* Enable long onkey detection */
-	regmap_update_bits(info->map, PM800_RTC_MISC4, PM800_LONG_ONKEY_EN,
-			   PM800_LONG_ONKEY_EN);
-	/* Set 8-second interval */
-	regmap_update_bits(info->map, PM800_RTC_MISC3,
-			   PM800_LONKEY_PRESS_TIME_MASK,
-			   PM800_LONKEY_PRESS_TIME);
-
-	device_init_wakeup(&pdev->dev, 1);
-	return 0;
-
-out_irq:
-	pm80x_free_irq(info->pm80x, info->irq, info);
-out_reg:
-	input_free_device(info->idev);
-out:
-	kfree(info);
-	return err;
-}
-
-static void pm80x_onkey_remove(struct platform_device *pdev)
-{
-	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
-
-	pm80x_free_irq(info->pm80x, info->irq, info);
-	input_unregister_device(info->idev);
-	kfree(info);
-}
-
-static struct platform_driver pm80x_onkey_driver = {
-	.driver = {
-		   .name = "88pm80x-onkey",
-		   .pm = &pm80x_onkey_pm_ops,
-		   },
-	.probe = pm80x_onkey_probe,
-	.remove = pm80x_onkey_remove,
-};
-
-module_platform_driver(pm80x_onkey_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Marvell 88PM80x ONKEY driver");
-MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-MODULE_ALIAS("platform:88pm80x-onkey");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 169768e3d5bb..013ae22311ee 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -23,16 +23,6 @@ config INPUT_88PM860X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm860x_onkey.
 
-config INPUT_88PM80X_ONKEY
-	tristate "88PM80x ONKEY support"
-	depends on MFD_88PM800
-	help
-	  Support the ONKEY of Marvell 88PM80x PMICs as an input device
-	  reporting power button status.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called 88pm80x_onkey.
-
 config INPUT_88PM886_ONKEY
 	tristate "Marvell 88PM886 onkey support"
 	depends on MFD_88PM886_PMIC
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1339619f0769..b120799b05eb 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -6,7 +6,6 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
-obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
 obj-$(CONFIG_INPUT_88PM886_ONKEY)	+= 88pm886-onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
deleted file mode 100644
index e9941da58b18..000000000000
--- a/drivers/mfd/88pm800.c
+++ /dev/null
@@ -1,619 +0,0 @@
-/*
- * Base driver for Marvell 88PM800
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Haojian Zhuang <haojian.zhuang@marvell.com>
- * Joseph(Yossi) Hanin <yhanin@marvell.com>
- * Qiao Zhou <zhouqiao@marvell.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/slab.h>
-
-/* Interrupt Registers */
-#define PM800_INT_STATUS1		(0x05)
-#define PM800_ONKEY_INT_STS1		(1 << 0)
-#define PM800_EXTON_INT_STS1		(1 << 1)
-#define PM800_CHG_INT_STS1			(1 << 2)
-#define PM800_BAT_INT_STS1			(1 << 3)
-#define PM800_RTC_INT_STS1			(1 << 4)
-#define PM800_CLASSD_OC_INT_STS1	(1 << 5)
-
-#define PM800_INT_STATUS2		(0x06)
-#define PM800_VBAT_INT_STS2		(1 << 0)
-#define PM800_VSYS_INT_STS2		(1 << 1)
-#define PM800_VCHG_INT_STS2		(1 << 2)
-#define PM800_TINT_INT_STS2		(1 << 3)
-#define PM800_GPADC0_INT_STS2	(1 << 4)
-#define PM800_TBAT_INT_STS2		(1 << 5)
-#define PM800_GPADC2_INT_STS2	(1 << 6)
-#define PM800_GPADC3_INT_STS2	(1 << 7)
-
-#define PM800_INT_STATUS3		(0x07)
-
-#define PM800_INT_STATUS4		(0x08)
-#define PM800_GPIO0_INT_STS4		(1 << 0)
-#define PM800_GPIO1_INT_STS4		(1 << 1)
-#define PM800_GPIO2_INT_STS4		(1 << 2)
-#define PM800_GPIO3_INT_STS4		(1 << 3)
-#define PM800_GPIO4_INT_STS4		(1 << 4)
-
-#define PM800_INT_ENA_1		(0x09)
-#define PM800_ONKEY_INT_ENA1		(1 << 0)
-#define PM800_EXTON_INT_ENA1		(1 << 1)
-#define PM800_CHG_INT_ENA1			(1 << 2)
-#define PM800_BAT_INT_ENA1			(1 << 3)
-#define PM800_RTC_INT_ENA1			(1 << 4)
-#define PM800_CLASSD_OC_INT_ENA1	(1 << 5)
-
-#define PM800_INT_ENA_2		(0x0A)
-#define PM800_VBAT_INT_ENA2		(1 << 0)
-#define PM800_VSYS_INT_ENA2		(1 << 1)
-#define PM800_VCHG_INT_ENA2		(1 << 2)
-#define PM800_TINT_INT_ENA2		(1 << 3)
-
-#define PM800_INT_ENA_3		(0x0B)
-#define PM800_GPADC0_INT_ENA3		(1 << 0)
-#define PM800_GPADC1_INT_ENA3		(1 << 1)
-#define PM800_GPADC2_INT_ENA3		(1 << 2)
-#define PM800_GPADC3_INT_ENA3		(1 << 3)
-#define PM800_GPADC4_INT_ENA3		(1 << 4)
-
-#define PM800_INT_ENA_4		(0x0C)
-#define PM800_GPIO0_INT_ENA4		(1 << 0)
-#define PM800_GPIO1_INT_ENA4		(1 << 1)
-#define PM800_GPIO2_INT_ENA4		(1 << 2)
-#define PM800_GPIO3_INT_ENA4		(1 << 3)
-#define PM800_GPIO4_INT_ENA4		(1 << 4)
-
-/* number of INT_ENA & INT_STATUS regs */
-#define PM800_INT_REG_NUM			(4)
-
-/* Interrupt Number in 88PM800 */
-enum {
-	PM800_IRQ_ONKEY,	/*EN1b0 *//*0 */
-	PM800_IRQ_EXTON,	/*EN1b1 */
-	PM800_IRQ_CHG,		/*EN1b2 */
-	PM800_IRQ_BAT,		/*EN1b3 */
-	PM800_IRQ_RTC,		/*EN1b4 */
-	PM800_IRQ_CLASSD,	/*EN1b5 *//*5 */
-	PM800_IRQ_VBAT,		/*EN2b0 */
-	PM800_IRQ_VSYS,		/*EN2b1 */
-	PM800_IRQ_VCHG,		/*EN2b2 */
-	PM800_IRQ_TINT,		/*EN2b3 */
-	PM800_IRQ_GPADC0,	/*EN3b0 *//*10 */
-	PM800_IRQ_GPADC1,	/*EN3b1 */
-	PM800_IRQ_GPADC2,	/*EN3b2 */
-	PM800_IRQ_GPADC3,	/*EN3b3 */
-	PM800_IRQ_GPADC4,	/*EN3b4 */
-	PM800_IRQ_GPIO0,	/*EN4b0 *//*15 */
-	PM800_IRQ_GPIO1,	/*EN4b1 */
-	PM800_IRQ_GPIO2,	/*EN4b2 */
-	PM800_IRQ_GPIO3,	/*EN4b3 */
-	PM800_IRQ_GPIO4,	/*EN4b4 *//*19 */
-	PM800_MAX_IRQ,
-};
-
-/* PM800: generation identification number */
-#define PM800_CHIP_GEN_ID_NUM	0x3
-
-static const struct i2c_device_id pm80x_id_table[] = {
-	{ "88PM800" },
-	{} /* NULL terminated */
-};
-MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
-
-static const struct resource rtc_resources[] = {
-	DEFINE_RES_IRQ_NAMED(PM800_IRQ_RTC, "88pm80x-rtc"),
-};
-
-static struct mfd_cell rtc_devs[] = {
-	{
-	 .name = "88pm80x-rtc",
-	 .num_resources = ARRAY_SIZE(rtc_resources),
-	 .resources = &rtc_resources[0],
-	 .id = -1,
-	 },
-};
-
-static struct resource onkey_resources[] = {
-	DEFINE_RES_IRQ_NAMED(PM800_IRQ_ONKEY, "88pm80x-onkey"),
-};
-
-static const struct mfd_cell onkey_devs[] = {
-	{
-	 .name = "88pm80x-onkey",
-	 .num_resources = 1,
-	 .resources = &onkey_resources[0],
-	 .id = -1,
-	 },
-};
-
-static const struct mfd_cell regulator_devs[] = {
-	{
-	 .name = "88pm80x-regulator",
-	 .id = -1,
-	},
-};
-
-static const struct regmap_irq pm800_irqs[] = {
-	/* INT0 */
-	[PM800_IRQ_ONKEY] = {
-		.mask = PM800_ONKEY_INT_ENA1,
-	},
-	[PM800_IRQ_EXTON] = {
-		.mask = PM800_EXTON_INT_ENA1,
-	},
-	[PM800_IRQ_CHG] = {
-		.mask = PM800_CHG_INT_ENA1,
-	},
-	[PM800_IRQ_BAT] = {
-		.mask = PM800_BAT_INT_ENA1,
-	},
-	[PM800_IRQ_RTC] = {
-		.mask = PM800_RTC_INT_ENA1,
-	},
-	[PM800_IRQ_CLASSD] = {
-		.mask = PM800_CLASSD_OC_INT_ENA1,
-	},
-	/* INT1 */
-	[PM800_IRQ_VBAT] = {
-		.reg_offset = 1,
-		.mask = PM800_VBAT_INT_ENA2,
-	},
-	[PM800_IRQ_VSYS] = {
-		.reg_offset = 1,
-		.mask = PM800_VSYS_INT_ENA2,
-	},
-	[PM800_IRQ_VCHG] = {
-		.reg_offset = 1,
-		.mask = PM800_VCHG_INT_ENA2,
-	},
-	[PM800_IRQ_TINT] = {
-		.reg_offset = 1,
-		.mask = PM800_TINT_INT_ENA2,
-	},
-	/* INT2 */
-	[PM800_IRQ_GPADC0] = {
-		.reg_offset = 2,
-		.mask = PM800_GPADC0_INT_ENA3,
-	},
-	[PM800_IRQ_GPADC1] = {
-		.reg_offset = 2,
-		.mask = PM800_GPADC1_INT_ENA3,
-	},
-	[PM800_IRQ_GPADC2] = {
-		.reg_offset = 2,
-		.mask = PM800_GPADC2_INT_ENA3,
-	},
-	[PM800_IRQ_GPADC3] = {
-		.reg_offset = 2,
-		.mask = PM800_GPADC3_INT_ENA3,
-	},
-	[PM800_IRQ_GPADC4] = {
-		.reg_offset = 2,
-		.mask = PM800_GPADC4_INT_ENA3,
-	},
-	/* INT3 */
-	[PM800_IRQ_GPIO0] = {
-		.reg_offset = 3,
-		.mask = PM800_GPIO0_INT_ENA4,
-	},
-	[PM800_IRQ_GPIO1] = {
-		.reg_offset = 3,
-		.mask = PM800_GPIO1_INT_ENA4,
-	},
-	[PM800_IRQ_GPIO2] = {
-		.reg_offset = 3,
-		.mask = PM800_GPIO2_INT_ENA4,
-	},
-	[PM800_IRQ_GPIO3] = {
-		.reg_offset = 3,
-		.mask = PM800_GPIO3_INT_ENA4,
-	},
-	[PM800_IRQ_GPIO4] = {
-		.reg_offset = 3,
-		.mask = PM800_GPIO4_INT_ENA4,
-	},
-};
-
-static int device_gpadc_init(struct pm80x_chip *chip,
-				       struct pm80x_platform_data *pdata)
-{
-	struct pm80x_subchip *subchip = chip->subchip;
-	struct regmap *map = subchip->regmap_gpadc;
-	int data = 0, mask = 0, ret = 0;
-
-	if (!map) {
-		dev_warn(chip->dev,
-			 "Warning: gpadc regmap is not available!\n");
-		return -EINVAL;
-	}
-	/*
-	 * initialize GPADC without activating it turn on GPADC
-	 * measurments
-	 */
-	ret = regmap_update_bits(map,
-				 PM800_GPADC_MISC_CONFIG2,
-				 PM800_GPADC_MISC_GPFSM_EN,
-				 PM800_GPADC_MISC_GPFSM_EN);
-	if (ret < 0)
-		goto out;
-	/*
-	 * This function configures the ADC as requires for
-	 * CP implementation.CP does not "own" the ADC configuration
-	 * registers and relies on AP.
-	 * Reason: enable automatic ADC measurements needed
-	 * for CP to get VBAT and RF temperature readings.
-	 */
-	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN1,
-				 PM800_MEAS_EN1_VBAT, PM800_MEAS_EN1_VBAT);
-	if (ret < 0)
-		goto out;
-	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN2,
-				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN),
-				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN));
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * the defult of PM800 is GPADC operates at 100Ks/s rate
-	 * and Number of GPADC slots with active current bias prior
-	 * to GPADC sampling = 1 slot for all GPADCs set for
-	 * Temprature mesurmants
-	 */
-	mask = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
-		PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
-
-	if (pdata && (pdata->batt_det == 0))
-		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
-			PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
-	else
-		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN2 |
-			PM800_GPADC_GP_BIAS_EN3);
-
-	ret = regmap_update_bits(map, PM800_GP_BIAS_ENA1, mask, data);
-	if (ret < 0)
-		goto out;
-
-	dev_info(chip->dev, "pm800 device_gpadc_init: Done\n");
-	return 0;
-
-out:
-	dev_info(chip->dev, "pm800 device_gpadc_init: Failed!\n");
-	return ret;
-}
-
-static int device_onkey_init(struct pm80x_chip *chip,
-				struct pm80x_platform_data *pdata)
-{
-	int ret;
-
-	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
-			      ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0,
-			      NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add onkey subdev\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int device_rtc_init(struct pm80x_chip *chip,
-				struct pm80x_platform_data *pdata)
-{
-	int ret;
-
-	if (pdata) {
-		rtc_devs[0].platform_data = pdata->rtc;
-		rtc_devs[0].pdata_size =
-				pdata->rtc ? sizeof(struct pm80x_rtc_pdata) : 0;
-	}
-	ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
-			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add rtc subdev\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int device_regulator_init(struct pm80x_chip *chip,
-					   struct pm80x_platform_data *pdata)
-{
-	int ret;
-
-	ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
-			      ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add regulator subdev\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int device_irq_init_800(struct pm80x_chip *chip)
-{
-	struct regmap *map = chip->regmap;
-	unsigned long flags = IRQF_ONESHOT;
-	int data, mask, ret = -EINVAL;
-
-	if (!map || !chip->irq) {
-		dev_err(chip->dev, "incorrect parameters\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * irq_mode defines the way of clearing interrupt. it's read-clear by
-	 * default.
-	 */
-	mask =
-	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
-	    PM800_WAKEUP2_INT_MASK;
-
-	data = PM800_WAKEUP2_INT_CLEAR;
-	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
-
-	if (ret < 0)
-		goto out;
-
-	ret =
-	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
-				chip->regmap_irq_chip, &chip->irq_data);
-
-out:
-	return ret;
-}
-
-static void device_irq_exit_800(struct pm80x_chip *chip)
-{
-	regmap_del_irq_chip(chip->irq, chip->irq_data);
-}
-
-static const struct regmap_irq_chip pm800_irq_chip = {
-	.name = "88pm800",
-	.irqs = pm800_irqs,
-	.num_irqs = ARRAY_SIZE(pm800_irqs),
-
-	.num_regs = 4,
-	.status_base = PM800_INT_STATUS1,
-	.unmask_base = PM800_INT_ENA_1,
-	.ack_base = PM800_INT_STATUS1,
-};
-
-static int pm800_pages_init(struct pm80x_chip *chip)
-{
-	struct pm80x_subchip *subchip;
-	struct i2c_client *client = chip->client;
-
-	int ret = 0;
-
-	subchip = chip->subchip;
-	if (!subchip || !subchip->power_page_addr || !subchip->gpadc_page_addr)
-		return -ENODEV;
-
-	/* PM800 block power page */
-	subchip->power_page = i2c_new_dummy_device(client->adapter,
-					    subchip->power_page_addr);
-	if (IS_ERR(subchip->power_page)) {
-		ret = PTR_ERR(subchip->power_page);
-		goto out;
-	}
-
-	subchip->regmap_power = devm_regmap_init_i2c(subchip->power_page,
-						     &pm80x_regmap_config);
-	if (IS_ERR(subchip->regmap_power)) {
-		ret = PTR_ERR(subchip->regmap_power);
-		dev_err(chip->dev,
-			"Failed to allocate regmap_power: %d\n", ret);
-		goto out;
-	}
-
-	i2c_set_clientdata(subchip->power_page, chip);
-
-	/* PM800 block GPADC */
-	subchip->gpadc_page = i2c_new_dummy_device(client->adapter,
-					    subchip->gpadc_page_addr);
-	if (IS_ERR(subchip->gpadc_page)) {
-		ret = PTR_ERR(subchip->gpadc_page);
-		goto out;
-	}
-
-	subchip->regmap_gpadc = devm_regmap_init_i2c(subchip->gpadc_page,
-						     &pm80x_regmap_config);
-	if (IS_ERR(subchip->regmap_gpadc)) {
-		ret = PTR_ERR(subchip->regmap_gpadc);
-		dev_err(chip->dev,
-			"Failed to allocate regmap_gpadc: %d\n", ret);
-		goto out;
-	}
-	i2c_set_clientdata(subchip->gpadc_page, chip);
-
-out:
-	return ret;
-}
-
-static void pm800_pages_exit(struct pm80x_chip *chip)
-{
-	struct pm80x_subchip *subchip;
-
-	subchip = chip->subchip;
-
-	if (subchip && subchip->power_page)
-		i2c_unregister_device(subchip->power_page);
-
-	if (subchip && subchip->gpadc_page)
-		i2c_unregister_device(subchip->gpadc_page);
-}
-
-static int device_800_init(struct pm80x_chip *chip,
-				     struct pm80x_platform_data *pdata)
-{
-	int ret;
-	unsigned int val;
-
-	/*
-	 * alarm wake up bit will be clear in device_irq_init(),
-	 * read before that
-	 */
-	ret = regmap_read(chip->regmap, PM800_RTC_CONTROL, &val);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read RTC register: %d\n", ret);
-		goto out;
-	}
-	if (val & PM800_ALARM_WAKEUP) {
-		if (pdata && pdata->rtc)
-			pdata->rtc->rtc_wakeup = 1;
-	}
-
-	ret = device_gpadc_init(chip, pdata);
-	if (ret < 0) {
-		dev_err(chip->dev, "[%s]Failed to init gpadc\n", __func__);
-		goto out;
-	}
-
-	chip->regmap_irq_chip = &pm800_irq_chip;
-
-	ret = device_irq_init_800(chip);
-	if (ret < 0) {
-		dev_err(chip->dev, "[%s]Failed to init pm800 irq\n", __func__);
-		goto out;
-	}
-
-	ret = device_onkey_init(chip, pdata);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add onkey subdev\n");
-		goto out_dev;
-	}
-
-	ret = device_rtc_init(chip, pdata);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add rtc subdev\n");
-		goto out;
-	}
-
-	ret = device_regulator_init(chip, pdata);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add regulators subdev\n");
-		goto out;
-	}
-
-	return 0;
-out_dev:
-	mfd_remove_devices(chip->dev);
-	device_irq_exit_800(chip);
-out:
-	return ret;
-}
-
-static int pm800_probe(struct i2c_client *client)
-{
-	int ret = 0;
-	struct pm80x_chip *chip;
-	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct pm80x_subchip *subchip;
-
-	ret = pm80x_init(client);
-	if (ret) {
-		dev_err(&client->dev, "pm800_init fail\n");
-		goto out_init;
-	}
-
-	chip = i2c_get_clientdata(client);
-
-	/* init subchip for PM800 */
-	subchip =
-	    devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
-			 GFP_KERNEL);
-	if (!subchip) {
-		ret = -ENOMEM;
-		goto err_subchip_alloc;
-	}
-
-	/* pm800 has 2 addtional pages to support power and gpadc. */
-	subchip->power_page_addr = client->addr + 1;
-	subchip->gpadc_page_addr = client->addr + 2;
-	chip->subchip = subchip;
-
-	ret = pm800_pages_init(chip);
-	if (ret) {
-		dev_err(&client->dev, "pm800_pages_init failed!\n");
-		goto err_device_init;
-	}
-
-	ret = device_800_init(chip, pdata);
-	if (ret) {
-		dev_err(chip->dev, "Failed to initialize 88pm800 devices\n");
-		goto err_device_init;
-	}
-
-	if (pdata && pdata->plat_config)
-		pdata->plat_config(chip, pdata);
-
-	return 0;
-
-err_device_init:
-	pm800_pages_exit(chip);
-err_subchip_alloc:
-	pm80x_deinit();
-out_init:
-	return ret;
-}
-
-static void pm800_remove(struct i2c_client *client)
-{
-	struct pm80x_chip *chip = i2c_get_clientdata(client);
-
-	mfd_remove_devices(chip->dev);
-	device_irq_exit_800(chip);
-
-	pm800_pages_exit(chip);
-	pm80x_deinit();
-}
-
-static struct i2c_driver pm800_driver = {
-	.driver = {
-		.name = "88PM800",
-		.pm = pm_sleep_ptr(&pm80x_pm_ops),
-		},
-	.probe = pm800_probe,
-	.remove = pm800_remove,
-	.id_table = pm80x_id_table,
-};
-
-static int __init pm800_i2c_init(void)
-{
-	return i2c_add_driver(&pm800_driver);
-}
-subsys_initcall(pm800_i2c_init);
-
-static void __exit pm800_i2c_exit(void)
-{
-	i2c_del_driver(&pm800_driver);
-}
-module_exit(pm800_i2c_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM800");
-MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
deleted file mode 100644
index f5d6663172ee..000000000000
--- a/drivers/mfd/88pm805.c
+++ /dev/null
@@ -1,275 +0,0 @@
-/*
- * Base driver for Marvell 88PM805
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Haojian Zhuang <haojian.zhuang@marvell.com>
- * Joseph(Yossi) Hanin <yhanin@marvell.com>
- * Qiao Zhou <zhouqiao@marvell.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-
-static const struct i2c_device_id pm80x_id_table[] = {
-	{ "88PM805" },
-	{} /* NULL terminated */
-};
-MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
-
-/* Interrupt Number in 88PM805 */
-enum {
-	PM805_IRQ_LDO_OFF,	/*0 */
-	PM805_IRQ_SRC_DPLL_LOCK,	/*1 */
-	PM805_IRQ_CLIP_FAULT,
-	PM805_IRQ_MIC_CONFLICT,
-	PM805_IRQ_HP2_SHRT,
-	PM805_IRQ_HP1_SHRT,	/*5 */
-	PM805_IRQ_FINE_PLL_FAULT,
-	PM805_IRQ_RAW_PLL_FAULT,
-	PM805_IRQ_VOLP_BTN_DET,
-	PM805_IRQ_VOLM_BTN_DET,
-	PM805_IRQ_SHRT_BTN_DET,	/*10 */
-	PM805_IRQ_MIC_DET,	/*11 */
-
-	PM805_MAX_IRQ,
-};
-
-static struct resource codec_resources[] = {
-	/* Headset microphone insertion or removal */
-	DEFINE_RES_IRQ_NAMED(PM805_IRQ_MIC_DET, "micin"),
-
-	/* Audio short HP1 */
-	DEFINE_RES_IRQ_NAMED(PM805_IRQ_HP1_SHRT, "audio-short1"),
-
-	/* Audio short HP2 */
-	DEFINE_RES_IRQ_NAMED(PM805_IRQ_HP2_SHRT, "audio-short2"),
-};
-
-static const struct mfd_cell codec_devs[] = {
-	{
-	 .name = "88pm80x-codec",
-	 .num_resources = ARRAY_SIZE(codec_resources),
-	 .resources = &codec_resources[0],
-	 .id = -1,
-	 },
-};
-
-static const struct regmap_irq pm805_irqs[] = {
-	/* INT0 */
-	[PM805_IRQ_LDO_OFF] = {
-		.mask = PM805_INT1_HP1_SHRT,
-	},
-	[PM805_IRQ_SRC_DPLL_LOCK] = {
-		.mask = PM805_INT1_HP2_SHRT,
-	},
-	[PM805_IRQ_CLIP_FAULT] = {
-		.mask = PM805_INT1_MIC_CONFLICT,
-	},
-	[PM805_IRQ_MIC_CONFLICT] = {
-		.mask = PM805_INT1_CLIP_FAULT,
-	},
-	[PM805_IRQ_HP2_SHRT] = {
-		.mask = PM805_INT1_LDO_OFF,
-	},
-	[PM805_IRQ_HP1_SHRT] = {
-		.mask = PM805_INT1_SRC_DPLL_LOCK,
-	},
-	/* INT1 */
-	[PM805_IRQ_FINE_PLL_FAULT] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_MIC_DET,
-	},
-	[PM805_IRQ_RAW_PLL_FAULT] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_SHRT_BTN_DET,
-	},
-	[PM805_IRQ_VOLP_BTN_DET] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_VOLM_BTN_DET,
-	},
-	[PM805_IRQ_VOLM_BTN_DET] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_VOLP_BTN_DET,
-	},
-	[PM805_IRQ_SHRT_BTN_DET] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_RAW_PLL_FAULT,
-	},
-	[PM805_IRQ_MIC_DET] = {
-		.reg_offset = 1,
-		.mask = PM805_INT2_FINE_PLL_FAULT,
-	},
-};
-
-static int device_irq_init_805(struct pm80x_chip *chip)
-{
-	struct regmap *map = chip->regmap;
-	unsigned long flags = IRQF_ONESHOT;
-	int data, mask, ret = -EINVAL;
-
-	if (!map || !chip->irq) {
-		dev_err(chip->dev, "incorrect parameters\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * irq_mode defines the way of clearing interrupt. it's read-clear by
-	 * default.
-	 */
-	mask =
-	    PM805_STATUS0_INT_CLEAR | PM805_STATUS0_INV_INT |
-	    PM800_STATUS0_INT_MASK;
-
-	data = PM805_STATUS0_INT_CLEAR;
-	ret = regmap_update_bits(map, PM805_INT_STATUS0, mask, data);
-	/*
-	 * PM805_INT_STATUS is under 32K clock domain, so need to
-	 * add proper delay before the next I2C register access.
-	 */
-	usleep_range(1000, 3000);
-
-	if (ret < 0)
-		goto out;
-
-	ret =
-	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
-				chip->regmap_irq_chip, &chip->irq_data);
-
-out:
-	return ret;
-}
-
-static void device_irq_exit_805(struct pm80x_chip *chip)
-{
-	regmap_del_irq_chip(chip->irq, chip->irq_data);
-}
-
-static const struct regmap_irq_chip pm805_irq_chip = {
-	.name = "88pm805",
-	.irqs = pm805_irqs,
-	.num_irqs = ARRAY_SIZE(pm805_irqs),
-
-	.num_regs = 2,
-	.status_base = PM805_INT_STATUS1,
-	.mask_base = PM805_INT_MASK1,
-	.ack_base = PM805_INT_STATUS1,
-};
-
-static int device_805_init(struct pm80x_chip *chip)
-{
-	int ret = 0;
-	struct regmap *map = chip->regmap;
-
-	if (!map) {
-		dev_err(chip->dev, "regmap is invalid\n");
-		return -EINVAL;
-	}
-
-	chip->regmap_irq_chip = &pm805_irq_chip;
-
-	ret = device_irq_init_805(chip);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to init pm805 irq!\n");
-		goto out_irq_init;
-	}
-
-	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
-			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0,
-			      NULL);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to add codec subdev\n");
-		goto out_codec;
-	} else
-		dev_info(chip->dev, "[%s]:Added mfd codec_devs\n", __func__);
-
-	return 0;
-
-out_codec:
-	device_irq_exit_805(chip);
-out_irq_init:
-	return ret;
-}
-
-static int pm805_probe(struct i2c_client *client)
-{
-	int ret = 0;
-	struct pm80x_chip *chip;
-	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
-
-	ret = pm80x_init(client);
-	if (ret) {
-		dev_err(&client->dev, "pm805_init fail!\n");
-		goto out_init;
-	}
-
-	chip = i2c_get_clientdata(client);
-
-	ret = device_805_init(chip);
-	if (ret) {
-		dev_err(chip->dev, "Failed to initialize 88pm805 devices\n");
-		goto err_805_init;
-	}
-
-	if (pdata && pdata->plat_config)
-		pdata->plat_config(chip, pdata);
-
-err_805_init:
-	pm80x_deinit();
-out_init:
-	return ret;
-}
-
-static void pm805_remove(struct i2c_client *client)
-{
-	struct pm80x_chip *chip = i2c_get_clientdata(client);
-
-	mfd_remove_devices(chip->dev);
-	device_irq_exit_805(chip);
-
-	pm80x_deinit();
-}
-
-static struct i2c_driver pm805_driver = {
-	.driver = {
-		.name = "88PM805",
-		.pm = pm_sleep_ptr(&pm80x_pm_ops),
-		},
-	.probe = pm805_probe,
-	.remove = pm805_remove,
-	.id_table = pm80x_id_table,
-};
-
-static int __init pm805_i2c_init(void)
-{
-	return i2c_add_driver(&pm805_driver);
-}
-subsys_initcall(pm805_i2c_init);
-
-static void __exit pm805_i2c_exit(void)
-{
-	i2c_del_driver(&pm805_driver);
-}
-module_exit(pm805_i2c_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM805");
-MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
deleted file mode 100644
index bbc1a87f0c8f..000000000000
--- a/drivers/mfd/88pm80x.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I2C driver for Marvell 88PM80x
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Haojian Zhuang <haojian.zhuang@marvell.com>
- * Joseph(Yossi) Hanin <yhanin@marvell.com>
- * Qiao Zhou <zhouqiao@marvell.com>
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <linux/err.h>
-
-/* 88pm80x chips have same definition for chip id register. */
-#define PM80X_CHIP_ID			(0x00)
-#define PM80X_CHIP_ID_NUM(x)		(((x) >> 5) & 0x7)
-#define PM80X_CHIP_ID_REVISION(x)	((x) & 0x1F)
-
-struct pm80x_chip_mapping {
-	unsigned int	id;
-	int		type;
-};
-
-static struct pm80x_chip_mapping chip_mapping[] = {
-	/* 88PM800 chip id number */
-	{0x3,	CHIP_PM800},
-	/* 88PM805 chip id number */
-	{0x0,	CHIP_PM805},
-	/* 88PM860 chip id number */
-	{0x4,	CHIP_PM860},
-};
-
-/*
- * workaround: some registers needed by pm805 are defined in pm800, so
- * need to use this global variable to maintain the relation between
- * pm800 and pm805. would remove it after HW chip fixes the issue.
- */
-static struct pm80x_chip *g_pm80x_chip;
-
-const struct regmap_config pm80x_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-EXPORT_SYMBOL_GPL(pm80x_regmap_config);
-
-
-int pm80x_init(struct i2c_client *client)
-{
-	struct pm80x_chip *chip;
-	struct regmap *map;
-	unsigned int val;
-	int i, ret = 0;
-
-	chip =
-	    devm_kzalloc(&client->dev, sizeof(struct pm80x_chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	map = devm_regmap_init_i2c(client, &pm80x_regmap_config);
-	if (IS_ERR(map)) {
-		ret = PTR_ERR(map);
-		dev_err(&client->dev, "Failed to allocate register map: %d\n",
-			ret);
-		return ret;
-	}
-
-	chip->client = client;
-	chip->regmap = map;
-
-	chip->irq = client->irq;
-
-	chip->dev = &client->dev;
-	i2c_set_clientdata(chip->client, chip);
-
-	ret = regmap_read(chip->regmap, PM80X_CHIP_ID, &val);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
-		return ret;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(chip_mapping); i++) {
-		if (chip_mapping[i].id == PM80X_CHIP_ID_NUM(val)) {
-			chip->type = chip_mapping[i].type;
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(chip_mapping)) {
-		dev_err(chip->dev,
-			"Failed to detect Marvell 88PM800:ChipID[0x%x]\n", val);
-		return -EINVAL;
-	}
-
-	device_init_wakeup(&client->dev, 1);
-
-	/*
-	 * workaround: set g_pm80x_chip to the first probed chip. if the
-	 * second chip is probed, just point to the companion to each
-	 * other so that pm805 can access those specific register. would
-	 * remove it after HW chip fixes the issue.
-	 */
-	if (!g_pm80x_chip)
-		g_pm80x_chip = chip;
-	else {
-		chip->companion = g_pm80x_chip->client;
-		g_pm80x_chip->companion = chip->client;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pm80x_init);
-
-int pm80x_deinit(void)
-{
-	/*
-	 * workaround: clear the dependency between pm800 and pm805.
-	 * would remove it after HW chip fixes the issue.
-	 */
-	if (g_pm80x_chip->companion)
-		g_pm80x_chip->companion = NULL;
-	else
-		g_pm80x_chip = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pm80x_deinit);
-
-static int pm80x_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pm80x_chip *chip = i2c_get_clientdata(client);
-
-	if (chip && chip->wu_flag)
-		if (device_may_wakeup(chip->dev))
-			enable_irq_wake(chip->irq);
-
-	return 0;
-}
-
-static int pm80x_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pm80x_chip *chip = i2c_get_clientdata(client);
-
-	if (chip && chip->wu_flag)
-		if (device_may_wakeup(chip->dev))
-			disable_irq_wake(chip->irq);
-
-	return 0;
-}
-
-EXPORT_GPL_SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
-
-MODULE_DESCRIPTION("I2C Driver for Marvell 88PM80x");
-MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e4fd4572472f..de81d2bb4917 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -858,30 +858,6 @@ config MFD_KEMPLD
 	  This driver can also be built as a module. If so, the module
 	  will be called kempld-core.
 
-config MFD_88PM800
-	tristate "Marvell 88PM800"
-	depends on I2C
-	select REGMAP_I2C
-	select REGMAP_IRQ
-	select MFD_CORE
-	help
-	  This supports for Marvell 88PM800 Power Management IC.
-	  This includes the I2C driver and the core APIs _only_, you have to
-	  select individual components like voltage regulators, RTC and
-	  battery-charger under the corresponding menus.
-
-config MFD_88PM805
-	tristate "Marvell 88PM805"
-	depends on I2C
-	select REGMAP_I2C
-	select REGMAP_IRQ
-	select MFD_CORE
-	help
-	  This supports for Marvell 88PM805 Power Management IC. This includes
-	  the I2C driver and the core APIs _only_, you have to select individual
-	  components like codec device, headset/Mic device under the
-	  corresponding menus.
-
 config MFD_88PM860X
 	bool "Marvell 88PM8606/88PM8607"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 72d3944b0ad8..fe7156a5187a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -5,8 +5,6 @@
 
 88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
-obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
-obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
diff --git a/drivers/regulator/88pm800-regulator.c b/drivers/regulator/88pm800-regulator.c
deleted file mode 100644
index 83e8860309dc..000000000000
--- a/drivers/regulator/88pm800-regulator.c
+++ /dev/null
@@ -1,287 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Regulators driver for Marvell 88PM800
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Joseph(Yossi) Hanin <yhanin@marvell.com>
- * Yi Zhang <yizhang@marvell.com>
- */
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/regmap.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/regulator/of_regulator.h>
-
-/* LDO1 with DVC[0..3] */
-#define PM800_LDO1_VOUT		(0x08) /* VOUT1 */
-#define PM800_LDO1_VOUT_2	(0x09)
-#define PM800_LDO1_VOUT_3	(0x0A)
-#define PM800_LDO2_VOUT		(0x0B)
-#define PM800_LDO3_VOUT		(0x0C)
-#define PM800_LDO4_VOUT		(0x0D)
-#define PM800_LDO5_VOUT		(0x0E)
-#define PM800_LDO6_VOUT		(0x0F)
-#define PM800_LDO7_VOUT		(0x10)
-#define PM800_LDO8_VOUT		(0x11)
-#define PM800_LDO9_VOUT		(0x12)
-#define PM800_LDO10_VOUT	(0x13)
-#define PM800_LDO11_VOUT	(0x14)
-#define PM800_LDO12_VOUT	(0x15)
-#define PM800_LDO13_VOUT	(0x16)
-#define PM800_LDO14_VOUT	(0x17)
-#define PM800_LDO15_VOUT	(0x18)
-#define PM800_LDO16_VOUT	(0x19)
-#define PM800_LDO17_VOUT	(0x1A)
-#define PM800_LDO18_VOUT	(0x1B)
-#define PM800_LDO19_VOUT	(0x1C)
-
-/* BUCK1 with DVC[0..3] */
-#define PM800_BUCK1		(0x3C)
-#define PM800_BUCK1_1		(0x3D)
-#define PM800_BUCK1_2		(0x3E)
-#define PM800_BUCK1_3		(0x3F)
-#define PM800_BUCK2		(0x40)
-#define PM800_BUCK3		(0x41)
-#define PM800_BUCK4		(0x42)
-#define PM800_BUCK4_1		(0x43)
-#define PM800_BUCK4_2		(0x44)
-#define PM800_BUCK4_3		(0x45)
-#define PM800_BUCK5		(0x46)
-
-#define PM800_BUCK_ENA		(0x50)
-#define PM800_LDO_ENA1_1	(0x51)
-#define PM800_LDO_ENA1_2	(0x52)
-#define PM800_LDO_ENA1_3	(0x53)
-
-#define PM800_LDO_ENA2_1	(0x56)
-#define PM800_LDO_ENA2_2	(0x57)
-#define PM800_LDO_ENA2_3	(0x58)
-
-#define PM800_BUCK1_MISC1	(0x78)
-#define PM800_BUCK3_MISC1	(0x7E)
-#define PM800_BUCK4_MISC1	(0x81)
-#define PM800_BUCK5_MISC1	(0x84)
-
-struct pm800_regulator_info {
-	struct regulator_desc desc;
-	int max_ua;
-};
-
-/*
- * vreg - the buck regs string.
- * ereg - the string for the enable register.
- * ebit - the bit number in the enable register.
- * amax - the current
- * Buck has 2 kinds of voltage steps. It is easy to find voltage by ranges,
- * not the constant voltage table.
- * n_volt - Number of available selectors
- */
-#define PM800_BUCK(match, vreg, ereg, ebit, amax, volt_ranges, n_volt)	\
-{									\
-	.desc	= {							\
-		.name			= #vreg,			\
-		.of_match		= of_match_ptr(#match),		\
-		.regulators_node	= of_match_ptr("regulators"),	\
-		.ops			= &pm800_volt_range_ops,	\
-		.type			= REGULATOR_VOLTAGE,		\
-		.id			= PM800_ID_##vreg,		\
-		.owner			= THIS_MODULE,			\
-		.n_voltages		= n_volt,			\
-		.linear_ranges		= volt_ranges,			\
-		.n_linear_ranges	= ARRAY_SIZE(volt_ranges),	\
-		.vsel_reg		= PM800_##vreg,			\
-		.vsel_mask		= 0x7f,				\
-		.enable_reg		= PM800_##ereg,			\
-		.enable_mask		= 1 << (ebit),			\
-	},								\
-	.max_ua	= (amax),						\
-}
-
-/*
- * vreg - the LDO regs string
- * ereg -  the string for the enable register.
- * ebit - the bit number in the enable register.
- * amax - the current
- * volt_table - the LDO voltage table
- * For all the LDOes, there are too many ranges. Using volt_table will be
- * simpler and faster.
- */
-#define PM800_LDO(match, vreg, ereg, ebit, amax, ldo_volt_table)	\
-{									\
-	.desc	= {							\
-		.name			= #vreg,			\
-		.of_match		= of_match_ptr(#match),		\
-		.regulators_node	= of_match_ptr("regulators"),	\
-		.ops			= &pm800_volt_table_ops,	\
-		.type			= REGULATOR_VOLTAGE,		\
-		.id			= PM800_ID_##vreg,		\
-		.owner			= THIS_MODULE,			\
-		.n_voltages		= ARRAY_SIZE(ldo_volt_table),	\
-		.vsel_reg		= PM800_##vreg##_VOUT,		\
-		.vsel_mask		= 0xf,				\
-		.enable_reg		= PM800_##ereg,			\
-		.enable_mask		= 1 << (ebit),			\
-		.volt_table		= ldo_volt_table,		\
-	},								\
-	.max_ua	= (amax),						\
-}
-
-/* Ranges are sorted in ascending order. */
-static const struct linear_range buck1_volt_range[] = {
-	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
-	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x54, 50000),
-};
-
-/* BUCK 2~5 have same ranges. */
-static const struct linear_range buck2_5_volt_range[] = {
-	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
-	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x72, 50000),
-};
-
-static const unsigned int ldo1_volt_table[] = {
-	600000,  650000,  700000,  750000,  800000,  850000,  900000,  950000,
-	1000000, 1050000, 1100000, 1150000, 1200000, 1300000, 1400000, 1500000,
-};
-
-static const unsigned int ldo2_volt_table[] = {
-	1700000, 1800000, 1900000, 2000000, 2100000, 2500000, 2700000, 2800000,
-};
-
-/* LDO 3~17 have same voltage table. */
-static const unsigned int ldo3_17_volt_table[] = {
-	1200000, 1250000, 1700000, 1800000, 1850000, 1900000, 2500000, 2600000,
-	2700000, 2750000, 2800000, 2850000, 2900000, 3000000, 3100000, 3300000,
-};
-
-/* LDO 18~19 have same voltage table. */
-static const unsigned int ldo18_19_volt_table[] = {
-	1700000, 1800000, 1900000, 2500000, 2800000, 2900000, 3100000, 3300000,
-};
-
-static int pm800_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pm800_regulator_info *info = rdev_get_drvdata(rdev);
-
-	return info->max_ua;
-}
-
-static const struct regulator_ops pm800_volt_range_ops = {
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.map_voltage		= regulator_map_voltage_linear_range,
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-	.get_current_limit	= pm800_get_current_limit,
-};
-
-static const struct regulator_ops pm800_volt_table_ops = {
-	.list_voltage		= regulator_list_voltage_table,
-	.map_voltage		= regulator_map_voltage_iterate,
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-	.get_current_limit	= pm800_get_current_limit,
-};
-
-/* The array is indexed by id(PM800_ID_XXX) */
-static struct pm800_regulator_info pm800_regulator_info[] = {
-	PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range, 0x55),
-	PM800_BUCK(buck2, BUCK2, BUCK_ENA, 1, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck3, BUCK3, BUCK_ENA, 2, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck4, BUCK4, BUCK_ENA, 3, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck5, BUCK5, BUCK_ENA, 4, 1200000, buck2_5_volt_range, 0x73),
-
-	PM800_LDO(ldo1, LDO1, LDO_ENA1_1, 0, 200000, ldo1_volt_table),
-	PM800_LDO(ldo2, LDO2, LDO_ENA1_1, 1, 10000, ldo2_volt_table),
-	PM800_LDO(ldo3, LDO3, LDO_ENA1_1, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo4, LDO4, LDO_ENA1_1, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo5, LDO5, LDO_ENA1_1, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo6, LDO6, LDO_ENA1_1, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo7, LDO7, LDO_ENA1_1, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo8, LDO8, LDO_ENA1_1, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo9, LDO9, LDO_ENA1_2, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo10, LDO10, LDO_ENA1_2, 1, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo11, LDO11, LDO_ENA1_2, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo12, LDO12, LDO_ENA1_2, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo13, LDO13, LDO_ENA1_2, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo14, LDO14, LDO_ENA1_2, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo15, LDO15, LDO_ENA1_2, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo16, LDO16, LDO_ENA1_2, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo17, LDO17, LDO_ENA1_3, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo18, LDO18, LDO_ENA1_3, 1, 200000, ldo18_19_volt_table),
-	PM800_LDO(ldo19, LDO19, LDO_ENA1_3, 2, 200000, ldo18_19_volt_table),
-};
-
-static int pm800_regulator_probe(struct platform_device *pdev)
-{
-	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm80x_platform_data *pdata = dev_get_platdata(pdev->dev.parent);
-	struct regulator_config config = { };
-	struct regulator_init_data *init_data;
-	int i, ret;
-
-	if (pdata && pdata->num_regulators) {
-		unsigned int count = 0;
-
-		/* Check whether num_regulator is valid. */
-		for (i = 0; i < ARRAY_SIZE(pdata->regulators); i++) {
-			if (pdata->regulators[i])
-				count++;
-		}
-		if (count != pdata->num_regulators)
-			return -EINVAL;
-	}
-
-	config.dev = chip->dev;
-	config.regmap = chip->subchip->regmap_power;
-	for (i = 0; i < PM800_ID_RG_MAX; i++) {
-		struct regulator_dev *regulator;
-
-		if (pdata && pdata->num_regulators) {
-			init_data = pdata->regulators[i];
-			if (!init_data)
-				continue;
-
-			config.init_data = init_data;
-		}
-
-		config.driver_data = &pm800_regulator_info[i];
-
-		regulator = devm_regulator_register(&pdev->dev,
-				&pm800_regulator_info[i].desc, &config);
-		if (IS_ERR(regulator)) {
-			ret = PTR_ERR(regulator);
-			dev_err(&pdev->dev, "Failed to register %s\n",
-					pm800_regulator_info[i].desc.name);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static struct platform_driver pm800_regulator_driver = {
-	.driver		= {
-		.name	= "88pm80x-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe		= pm800_regulator_probe,
-};
-
-module_platform_driver(pm800_regulator_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Joseph(Yossi) Hanin <yhanin@marvell.com>");
-MODULE_DESCRIPTION("Regulator Driver for Marvell 88PM800 PMIC");
-MODULE_ALIAS("platform:88pm800-regulator");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 89789ac7a786..73b43dc1b3be 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -75,16 +75,6 @@ config REGULATOR_88PG86X
 	  They provide two I2C-controlled DC/DC step-down converters with
 	  sleep mode and separate enable pins.
 
-config REGULATOR_88PM800
-	tristate "Marvell 88PM800 Power regulators"
-	depends on MFD_88PM800
-	help
-	  This driver supports Marvell 88PM800 voltage regulator chips.
-	  It delivers digitally programmable output,
-	  the voltage is programmed via I2C interface.
-	  It's suitable to support PXA988 chips to control VCC_MAIN and
-	  various voltages.
-
 config REGULATOR_88PM8607
 	tristate "Marvell 88PM8607 Power regulators"
 	depends on MFD_88PM860X=y
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8df8..972f105567b5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
-obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_88PM886) += 88pm886-regulator.o
 obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0636b9ead2c2..5674211afe91 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -172,16 +172,6 @@ config RTC_DRV_88PM860X
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-88pm860x.
 
-config RTC_DRV_88PM80X
-	tristate "Marvell 88PM80x"
-	depends on MFD_88PM800
-	help
-	  If you say yes here you get support for RTC function in Marvell
-	  88PM80x chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-88pm80x.
-
 config RTC_DRV_88PM886
 	tristate "Marvell 88PM886 RTC driver"
 	depends on MFD_88PM886_PMIC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..84bb2af5849e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= test_rtc_lib.o
 
 # Keep the list ordered.
 
-obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
 obj-$(CONFIG_RTC_DRV_88PM860X)	+= rtc-88pm860x.o
 obj-$(CONFIG_RTC_DRV_88PM886)	+= rtc-88pm886.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
deleted file mode 100644
index a3e52a5a708f..000000000000
--- a/drivers/rtc/rtc-88pm80x.c
+++ /dev/null
@@ -1,340 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Real Time Clock driver for Marvell 88PM80x PMIC
- *
- * Copyright (c) 2012 Marvell International Ltd.
- *  Wenzeng Chen<wzch@marvell.com>
- *  Qiao Zhou <zhouqiao@marvell.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/regmap.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/88pm80x.h>
-#include <linux/rtc.h>
-
-#define PM800_RTC_COUNTER1		(0xD1)
-#define PM800_RTC_COUNTER2		(0xD2)
-#define PM800_RTC_COUNTER3		(0xD3)
-#define PM800_RTC_COUNTER4		(0xD4)
-#define PM800_RTC_EXPIRE1_1		(0xD5)
-#define PM800_RTC_EXPIRE1_2		(0xD6)
-#define PM800_RTC_EXPIRE1_3		(0xD7)
-#define PM800_RTC_EXPIRE1_4		(0xD8)
-#define PM800_RTC_TRIM1			(0xD9)
-#define PM800_RTC_TRIM2			(0xDA)
-#define PM800_RTC_TRIM3			(0xDB)
-#define PM800_RTC_TRIM4			(0xDC)
-#define PM800_RTC_EXPIRE2_1		(0xDD)
-#define PM800_RTC_EXPIRE2_2		(0xDE)
-#define PM800_RTC_EXPIRE2_3		(0xDF)
-#define PM800_RTC_EXPIRE2_4		(0xE0)
-
-#define PM800_POWER_DOWN_LOG1	(0xE5)
-#define PM800_POWER_DOWN_LOG2	(0xE6)
-
-struct pm80x_rtc_info {
-	struct pm80x_chip *chip;
-	struct regmap *map;
-	struct rtc_device *rtc_dev;
-	struct device *dev;
-
-	int irq;
-};
-
-static irqreturn_t rtc_update_handler(int irq, void *data)
-{
-	struct pm80x_rtc_info *info = (struct pm80x_rtc_info *)data;
-	int mask;
-
-	mask = PM800_ALARM | PM800_ALARM_WAKEUP;
-	regmap_update_bits(info->map, PM800_RTC_CONTROL, mask | PM800_ALARM1_EN,
-			   mask);
-	rtc_update_irq(info->rtc_dev, 1, RTC_AF);
-	return IRQ_HANDLED;
-}
-
-static int pm80x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
-
-	if (enabled)
-		regmap_update_bits(info->map, PM800_RTC_CONTROL,
-				   PM800_ALARM1_EN, PM800_ALARM1_EN);
-	else
-		regmap_update_bits(info->map, PM800_RTC_CONTROL,
-				   PM800_ALARM1_EN, 0);
-	return 0;
-}
-
-/*
- * Calculate the next alarm time given the requested alarm time mask
- * and the current time.
- */
-static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
-				struct rtc_time *alrm)
-{
-	unsigned long next_time;
-	unsigned long now_time;
-
-	next->tm_year = now->tm_year;
-	next->tm_mon = now->tm_mon;
-	next->tm_mday = now->tm_mday;
-	next->tm_hour = alrm->tm_hour;
-	next->tm_min = alrm->tm_min;
-	next->tm_sec = alrm->tm_sec;
-
-	now_time = rtc_tm_to_time64(now);
-	next_time = rtc_tm_to_time64(next);
-
-	if (next_time < now_time) {
-		/* Advance one day */
-		next_time += 60 * 60 * 24;
-		rtc_time64_to_tm(next_time, next);
-	}
-}
-
-static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
-	unsigned char buf[4];
-	unsigned long ticks, base, data;
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
-	base = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
-
-	/* load 32-bit read-only counter */
-	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
-	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
-		base, data, ticks);
-	rtc_time64_to_tm(ticks, tm);
-	return 0;
-}
-
-static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
-	unsigned char buf[4];
-	unsigned long ticks, base, data;
-
-	ticks = rtc_tm_to_time64(tm);
-
-	/* load 32-bit read-only counter */
-	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
-	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	base = ticks - data;
-	dev_dbg(info->dev, "set base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
-		base, data, ticks);
-	buf[0] = base & 0xFF;
-	buf[1] = (base >> 8) & 0xFF;
-	buf[2] = (base >> 16) & 0xFF;
-	buf[3] = (base >> 24) & 0xFF;
-	regmap_raw_write(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
-
-	return 0;
-}
-
-static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
-	unsigned char buf[4];
-	unsigned long ticks, base, data;
-	int ret;
-
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
-	base = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
-
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
-	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
-		base, data, ticks);
-
-	rtc_time64_to_tm(ticks, &alrm->time);
-	regmap_read(info->map, PM800_RTC_CONTROL, &ret);
-	alrm->enabled = (ret & PM800_ALARM1_EN) ? 1 : 0;
-	alrm->pending = (ret & (PM800_ALARM | PM800_ALARM_WAKEUP)) ? 1 : 0;
-	return 0;
-}
-
-static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
-	struct rtc_time now_tm, alarm_tm;
-	unsigned long ticks, base, data;
-	unsigned char buf[4];
-	int mask;
-
-	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_ALARM1_EN, 0);
-
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
-	base = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
-
-	/* load 32-bit read-only counter */
-	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
-	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
-		(buf[1] << 8) | buf[0];
-	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
-		base, data, ticks);
-
-	rtc_time64_to_tm(ticks, &now_tm);
-	dev_dbg(info->dev, "%s, now time : %lu\n", __func__, ticks);
-	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
-	/* get new ticks for alarm in 24 hours */
-	ticks = rtc_tm_to_time64(&alarm_tm);
-	dev_dbg(info->dev, "%s, alarm time: %lu\n", __func__, ticks);
-	data = ticks - base;
-
-	buf[0] = data & 0xff;
-	buf[1] = (data >> 8) & 0xff;
-	buf[2] = (data >> 16) & 0xff;
-	buf[3] = (data >> 24) & 0xff;
-	regmap_raw_write(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
-	if (alrm->enabled) {
-		mask = PM800_ALARM | PM800_ALARM_WAKEUP | PM800_ALARM1_EN;
-		regmap_update_bits(info->map, PM800_RTC_CONTROL, mask, mask);
-	} else {
-		mask = PM800_ALARM | PM800_ALARM_WAKEUP | PM800_ALARM1_EN;
-		regmap_update_bits(info->map, PM800_RTC_CONTROL, mask,
-				   PM800_ALARM | PM800_ALARM_WAKEUP);
-	}
-	return 0;
-}
-
-static const struct rtc_class_ops pm80x_rtc_ops = {
-	.read_time = pm80x_rtc_read_time,
-	.set_time = pm80x_rtc_set_time,
-	.read_alarm = pm80x_rtc_read_alarm,
-	.set_alarm = pm80x_rtc_set_alarm,
-	.alarm_irq_enable = pm80x_rtc_alarm_irq_enable,
-};
-
-#ifdef CONFIG_PM_SLEEP
-static int pm80x_rtc_suspend(struct device *dev)
-{
-	return pm80x_dev_suspend(dev);
-}
-
-static int pm80x_rtc_resume(struct device *dev)
-{
-	return pm80x_dev_resume(dev);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(pm80x_rtc_pm_ops, pm80x_rtc_suspend, pm80x_rtc_resume);
-
-static int pm80x_rtc_probe(struct platform_device *pdev)
-{
-	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm80x_rtc_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct pm80x_rtc_info *info;
-	struct device_node *node = pdev->dev.of_node;
-	int ret;
-
-	if (!pdata && !node) {
-		dev_err(&pdev->dev,
-			"pm80x-rtc requires platform data or of_node\n");
-		return -EINVAL;
-	}
-
-	if (!pdata) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&pdev->dev, "failed to allocate memory\n");
-			return -ENOMEM;
-		}
-	}
-
-	info =
-	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-	info->irq = platform_get_irq(pdev, 0);
-	if (info->irq < 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	info->chip = chip;
-	info->map = chip->regmap;
-	if (!info->map) {
-		dev_err(&pdev->dev, "no regmap!\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	info->dev = &pdev->dev;
-	dev_set_drvdata(&pdev->dev, info);
-
-	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(info->rtc_dev))
-		return PTR_ERR(info->rtc_dev);
-
-	ret = pm80x_request_irq(chip, info->irq, rtc_update_handler,
-				IRQF_ONESHOT, "rtc", info);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
-			info->irq, ret);
-		goto out;
-	}
-
-	info->rtc_dev->ops = &pm80x_rtc_ops;
-	info->rtc_dev->range_max = U32_MAX;
-
-	ret = devm_rtc_register_device(info->rtc_dev);
-	if (ret)
-		goto out_rtc;
-
-	/*
-	 * enable internal XO instead of internal 3.25MHz clock since it can
-	 * free running in PMIC power-down state.
-	 */
-	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
-			   PM800_RTC1_USE_XO);
-
-	/* remember whether this power up is caused by PMIC RTC or not */
-	info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
-
-	device_init_wakeup(&pdev->dev, true);
-
-	return 0;
-out_rtc:
-	pm80x_free_irq(chip, info->irq, info);
-out:
-	return ret;
-}
-
-static void pm80x_rtc_remove(struct platform_device *pdev)
-{
-	struct pm80x_rtc_info *info = platform_get_drvdata(pdev);
-	pm80x_free_irq(info->chip, info->irq, info);
-}
-
-static struct platform_driver pm80x_rtc_driver = {
-	.driver = {
-		   .name = "88pm80x-rtc",
-		   .pm = &pm80x_rtc_pm_ops,
-		   },
-	.probe = pm80x_rtc_probe,
-	.remove = pm80x_rtc_remove,
-};
-
-module_platform_driver(pm80x_rtc_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Marvell 88PM80x RTC driver");
-MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
-MODULE_ALIAS("platform:88pm80x-rtc");
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
deleted file mode 100644
index 551ef1c367d6..000000000000
--- a/include/linux/mfd/88pm80x.h
+++ /dev/null
@@ -1,370 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Marvell 88PM80x Interface
- *
- * Copyright (C) 2012 Marvell International Ltd.
- * Qiao Zhou <zhouqiao@marvell.com>
- */
-
-#ifndef __LINUX_MFD_88PM80X_H
-#define __LINUX_MFD_88PM80X_H
-
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/regmap.h>
-#include <linux/atomic.h>
-
-enum {
-	CHIP_INVALID = 0,
-	CHIP_PM800,
-	CHIP_PM805,
-	CHIP_PM860,
-	CHIP_MAX,
-};
-
-enum {
-	PM800_ID_BUCK1 = 0,
-	PM800_ID_BUCK2,
-	PM800_ID_BUCK3,
-	PM800_ID_BUCK4,
-	PM800_ID_BUCK5,
-
-	PM800_ID_LDO1,
-	PM800_ID_LDO2,
-	PM800_ID_LDO3,
-	PM800_ID_LDO4,
-	PM800_ID_LDO5,
-	PM800_ID_LDO6,
-	PM800_ID_LDO7,
-	PM800_ID_LDO8,
-	PM800_ID_LDO9,
-	PM800_ID_LDO10,
-	PM800_ID_LDO11,
-	PM800_ID_LDO12,
-	PM800_ID_LDO13,
-	PM800_ID_LDO14,
-	PM800_ID_LDO15,
-	PM800_ID_LDO16,
-	PM800_ID_LDO17,
-	PM800_ID_LDO18,
-	PM800_ID_LDO19,
-
-	PM800_ID_RG_MAX,
-};
-#define PM800_MAX_REGULATOR	PM800_ID_RG_MAX	/* 5 Bucks, 19 LDOs */
-#define PM800_NUM_BUCK (5)	/*5 Bucks */
-#define PM800_NUM_LDO (19)	/*19 Bucks */
-
-/* page 0 basic: slave adder 0x60 */
-
-#define PM800_STATUS_1			(0x01)
-#define PM800_ONKEY_STS1		BIT(0)
-#define PM800_EXTON_STS1		BIT(1)
-#define PM800_CHG_STS1			BIT(2)
-#define PM800_BAT_STS1			BIT(3)
-#define PM800_VBUS_STS1			BIT(4)
-#define PM800_LDO_PGOOD_STS1		BIT(5)
-#define PM800_BUCK_PGOOD_STS1		BIT(6)
-
-#define PM800_STATUS_2			(0x02)
-#define PM800_RTC_ALARM_STS2		BIT(0)
-
-/* Wakeup Registers */
-#define PM800_WAKEUP1			(0x0D)
-
-#define PM800_WAKEUP2			(0x0E)
-#define PM800_WAKEUP2_INV_INT		BIT(0)
-#define PM800_WAKEUP2_INT_CLEAR		BIT(1)
-#define PM800_WAKEUP2_INT_MASK		BIT(2)
-
-#define PM800_POWER_UP_LOG		(0x10)
-
-/* Referance and low power registers */
-#define PM800_LOW_POWER1		(0x20)
-#define PM800_LOW_POWER2		(0x21)
-#define PM800_LOW_POWER_CONFIG3		(0x22)
-#define PM800_LOW_POWER_CONFIG4		(0x23)
-
-/* GPIO register */
-#define PM800_GPIO_0_1_CNTRL		(0x30)
-#define PM800_GPIO0_VAL			BIT(0)
-#define PM800_GPIO0_GPIO_MODE(x)	(x << 1)
-#define PM800_GPIO1_VAL			BIT(4)
-#define PM800_GPIO1_GPIO_MODE(x)	(x << 5)
-
-#define PM800_GPIO_2_3_CNTRL		(0x31)
-#define PM800_GPIO2_VAL			BIT(0)
-#define PM800_GPIO2_GPIO_MODE(x)	(x << 1)
-#define PM800_GPIO3_VAL			BIT(4)
-#define PM800_GPIO3_GPIO_MODE(x)	(x << 5)
-#define PM800_GPIO3_MODE_MASK		0x1F
-#define PM800_GPIO3_HEADSET_MODE	PM800_GPIO3_GPIO_MODE(6)
-
-#define PM800_GPIO_4_CNTRL		(0x32)
-#define PM800_GPIO4_VAL			BIT(0)
-#define PM800_GPIO4_GPIO_MODE(x)	(x << 1)
-
-#define PM800_HEADSET_CNTRL		(0x38)
-#define PM800_HEADSET_DET_EN		BIT(7)
-#define PM800_HSDET_SLP			BIT(1)
-/* PWM register */
-#define PM800_PWM1			(0x40)
-#define PM800_PWM2			(0x41)
-#define PM800_PWM3			(0x42)
-#define PM800_PWM4			(0x43)
-
-/* RTC Registers */
-#define PM800_RTC_CONTROL		(0xD0)
-#define PM800_RTC_MISC1			(0xE1)
-#define PM800_RTC_MISC2			(0xE2)
-#define PM800_RTC_MISC3			(0xE3)
-#define PM800_RTC_MISC4			(0xE4)
-#define PM800_RTC_MISC5			(0xE7)
-/* bit definitions of RTC Register 1 (0xD0) */
-#define PM800_ALARM1_EN			BIT(0)
-#define PM800_ALARM_WAKEUP		BIT(4)
-#define PM800_ALARM			BIT(5)
-#define PM800_RTC1_USE_XO		BIT(7)
-
-/* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
-
-/* buck registers */
-#define PM800_SLEEP_BUCK1		(0x30)
-
-/* BUCK Sleep Mode Register 1: BUCK[1..4] */
-#define PM800_BUCK_SLP1			(0x5A)
-#define PM800_BUCK1_SLP1_SHIFT		0
-#define PM800_BUCK1_SLP1_MASK		(0x3 << PM800_BUCK1_SLP1_SHIFT)
-
-/* page 2 GPADC: slave adder 0x02 */
-#define PM800_GPADC_MEAS_EN1		(0x01)
-#define PM800_MEAS_EN1_VBAT		BIT(2)
-#define PM800_GPADC_MEAS_EN2		(0x02)
-#define PM800_MEAS_EN2_RFTMP		BIT(0)
-#define PM800_MEAS_GP0_EN		BIT(2)
-#define PM800_MEAS_GP1_EN		BIT(3)
-#define PM800_MEAS_GP2_EN		BIT(4)
-#define PM800_MEAS_GP3_EN		BIT(5)
-#define PM800_MEAS_GP4_EN		BIT(6)
-
-#define PM800_GPADC_MISC_CONFIG1	(0x05)
-#define PM800_GPADC_MISC_CONFIG2	(0x06)
-#define PM800_GPADC_MISC_GPFSM_EN	BIT(0)
-#define PM800_GPADC_SLOW_MODE(x)	(x << 3)
-
-#define PM800_GPADC_MISC_CONFIG3	(0x09)
-#define PM800_GPADC_MISC_CONFIG4	(0x0A)
-
-#define PM800_GPADC_PREBIAS1		(0x0F)
-#define PM800_GPADC0_GP_PREBIAS_TIME(x)	(x << 0)
-#define PM800_GPADC_PREBIAS2		(0x10)
-
-#define PM800_GP_BIAS_ENA1		(0x14)
-#define PM800_GPADC_GP_BIAS_EN0		BIT(0)
-#define PM800_GPADC_GP_BIAS_EN1		BIT(1)
-#define PM800_GPADC_GP_BIAS_EN2		BIT(2)
-#define PM800_GPADC_GP_BIAS_EN3		BIT(3)
-
-#define PM800_GP_BIAS_OUT1		(0x15)
-#define PM800_BIAS_OUT_GP0		BIT(0)
-#define PM800_BIAS_OUT_GP1		BIT(1)
-#define PM800_BIAS_OUT_GP2		BIT(2)
-#define PM800_BIAS_OUT_GP3		BIT(3)
-
-#define PM800_GPADC0_LOW_TH		0x20
-#define PM800_GPADC1_LOW_TH		0x21
-#define PM800_GPADC2_LOW_TH		0x22
-#define PM800_GPADC3_LOW_TH		0x23
-#define PM800_GPADC4_LOW_TH		0x24
-
-#define PM800_GPADC0_UPP_TH		0x30
-#define PM800_GPADC1_UPP_TH		0x31
-#define PM800_GPADC2_UPP_TH		0x32
-#define PM800_GPADC3_UPP_TH		0x33
-#define PM800_GPADC4_UPP_TH		0x34
-
-#define PM800_VBBAT_MEAS1		0x40
-#define PM800_VBBAT_MEAS2		0x41
-#define PM800_VBAT_MEAS1		0x42
-#define PM800_VBAT_MEAS2		0x43
-#define PM800_VSYS_MEAS1		0x44
-#define PM800_VSYS_MEAS2		0x45
-#define PM800_VCHG_MEAS1		0x46
-#define PM800_VCHG_MEAS2		0x47
-#define PM800_TINT_MEAS1		0x50
-#define PM800_TINT_MEAS2		0x51
-#define PM800_PMOD_MEAS1		0x52
-#define PM800_PMOD_MEAS2		0x53
-
-#define PM800_GPADC0_MEAS1		0x54
-#define PM800_GPADC0_MEAS2		0x55
-#define PM800_GPADC1_MEAS1		0x56
-#define PM800_GPADC1_MEAS2		0x57
-#define PM800_GPADC2_MEAS1		0x58
-#define PM800_GPADC2_MEAS2		0x59
-#define PM800_GPADC3_MEAS1		0x5A
-#define PM800_GPADC3_MEAS2		0x5B
-#define PM800_GPADC4_MEAS1		0x5C
-#define PM800_GPADC4_MEAS2		0x5D
-
-#define PM800_GPADC4_AVG1		0xA8
-#define PM800_GPADC4_AVG2		0xA9
-
-/* 88PM805 Registers */
-#define PM805_MAIN_POWERUP		(0x01)
-#define PM805_INT_STATUS0		(0x02)	/* for ena/dis all interrupts */
-
-#define PM805_STATUS0_INT_CLEAR		(1 << 0)
-#define PM805_STATUS0_INV_INT		(1 << 1)
-#define PM800_STATUS0_INT_MASK		(1 << 2)
-
-#define PM805_INT_STATUS1		(0x03)
-
-#define PM805_INT1_HP1_SHRT		BIT(0)
-#define PM805_INT1_HP2_SHRT		BIT(1)
-#define PM805_INT1_MIC_CONFLICT		BIT(2)
-#define PM805_INT1_CLIP_FAULT		BIT(3)
-#define PM805_INT1_LDO_OFF		BIT(4)
-#define PM805_INT1_SRC_DPLL_LOCK	BIT(5)
-
-#define PM805_INT_STATUS2		(0x04)
-
-#define PM805_INT2_MIC_DET		BIT(0)
-#define PM805_INT2_SHRT_BTN_DET		BIT(1)
-#define PM805_INT2_VOLM_BTN_DET		BIT(2)
-#define PM805_INT2_VOLP_BTN_DET		BIT(3)
-#define PM805_INT2_RAW_PLL_FAULT	BIT(4)
-#define PM805_INT2_FINE_PLL_FAULT	BIT(5)
-
-#define PM805_INT_MASK1			(0x05)
-#define PM805_INT_MASK2			(0x06)
-#define PM805_SHRT_BTN_DET		BIT(1)
-
-/* number of status and int reg in a row */
-#define PM805_INT_REG_NUM		(2)
-
-#define PM805_MIC_DET1			(0x07)
-#define PM805_MIC_DET_EN_MIC_DET	BIT(0)
-#define PM805_MIC_DET2			(0x08)
-#define PM805_MIC_DET_STATUS1		(0x09)
-
-#define PM805_MIC_DET_STATUS3		(0x0A)
-#define PM805_AUTO_SEQ_STATUS1		(0x0B)
-#define PM805_AUTO_SEQ_STATUS2		(0x0C)
-
-#define PM805_ADC_SETTING1		(0x10)
-#define PM805_ADC_SETTING2		(0x11)
-#define PM805_ADC_SETTING3		(0x11)
-#define PM805_ADC_GAIN1			(0x12)
-#define PM805_ADC_GAIN2			(0x13)
-#define PM805_DMIC_SETTING		(0x15)
-#define PM805_DWS_SETTING		(0x16)
-#define PM805_MIC_CONFLICT_STS		(0x17)
-
-#define PM805_PDM_SETTING1		(0x20)
-#define PM805_PDM_SETTING2		(0x21)
-#define PM805_PDM_SETTING3		(0x22)
-#define PM805_PDM_CONTROL1		(0x23)
-#define PM805_PDM_CONTROL2		(0x24)
-#define PM805_PDM_CONTROL3		(0x25)
-
-#define PM805_HEADPHONE_SETTING		(0x26)
-#define PM805_HEADPHONE_GAIN_A2A	(0x27)
-#define PM805_HEADPHONE_SHORT_STATE	(0x28)
-#define PM805_EARPHONE_SETTING		(0x29)
-#define PM805_AUTO_SEQ_SETTING		(0x2A)
-
-struct pm80x_rtc_pdata {
-	int		vrtc;
-	int		rtc_wakeup;
-};
-
-struct pm80x_subchip {
-	struct i2c_client *power_page;	/* chip client for power page */
-	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
-	struct regmap *regmap_power;
-	struct regmap *regmap_gpadc;
-	unsigned short power_page_addr;	/* power page I2C address */
-	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
-};
-
-struct pm80x_chip {
-	struct pm80x_subchip *subchip;
-	struct device *dev;
-	struct i2c_client *client;
-	struct i2c_client *companion;
-	struct regmap *regmap;
-	const struct regmap_irq_chip *regmap_irq_chip;
-	struct regmap_irq_chip_data *irq_data;
-	int type;
-	int irq;
-	int irq_mode;
-	unsigned long wu_flag;
-	spinlock_t lock;
-};
-
-struct pm80x_platform_data {
-	struct pm80x_rtc_pdata *rtc;
-	/*
-	 * For the regulator not defined, set regulators[not_defined] to be
-	 * NULL. num_regulators are the number of regulators supposed to be
-	 * initialized. If all regulators are not defined, set num_regulators
-	 * to be 0.
-	 */
-	struct regulator_init_data *regulators[PM800_ID_RG_MAX];
-	unsigned int num_regulators;
-	int irq_mode;		/* Clear interrupt by read/write(0/1) */
-	int batt_det;		/* enable/disable */
-	int (*plat_config)(struct pm80x_chip *chip,
-				struct pm80x_platform_data *pdata);
-};
-
-extern const struct dev_pm_ops pm80x_pm_ops;
-extern const struct regmap_config pm80x_regmap_config;
-
-static inline int pm80x_request_irq(struct pm80x_chip *pm80x, int irq,
-				     irq_handler_t handler, unsigned long flags,
-				     const char *name, void *data)
-{
-	if (!pm80x->irq_data)
-		return -EINVAL;
-	return request_threaded_irq(regmap_irq_get_virq(pm80x->irq_data, irq),
-				    NULL, handler, flags, name, data);
-}
-
-static inline void pm80x_free_irq(struct pm80x_chip *pm80x, int irq, void *data)
-{
-	if (!pm80x->irq_data)
-		return;
-	free_irq(regmap_irq_get_virq(pm80x->irq_data, irq), data);
-}
-
-#ifdef CONFIG_PM
-static inline int pm80x_dev_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	int irq = platform_get_irq(pdev, 0);
-
-	if (device_may_wakeup(dev))
-		set_bit(irq, &chip->wu_flag);
-
-	return 0;
-}
-
-static inline int pm80x_dev_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	int irq = platform_get_irq(pdev, 0);
-
-	if (device_may_wakeup(dev))
-		clear_bit(irq, &chip->wu_flag);
-
-	return 0;
-}
-#endif
-
-extern int pm80x_init(struct i2c_client *client);
-extern int pm80x_deinit(void);
-#endif /* __LINUX_MFD_88PM80X_H */
-- 
2.53.0


