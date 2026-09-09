Return-Path: <linuxppc-dev+bounces-26930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57CEC79FBE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1hj4FLDz2ytx;
	Wed, 09 Sep 2026 23:23:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960197;
	cv=none; b=CfgCtAnytKlGgIaieRuKYxlKi9pEE6u8AIJRPYfXRPL58+59LUh274EpxzYBBF9GmUajWXWInDrPHpchONX6h3QKXY5mB4nmphAyHGjq0B81w+aDg3UPhl3I8gWDPHxSNsFutxOKsmJnZReQYyub+IiDSYlAZXWFKSfVeuVUgk28dvDduWBJenYkfrA9mGL0Zmy0i3z0w6i7x1s8WH7+ZI4IoaU2Zz617Xa1ZEmMJD8XLW32Yp0qEaVnw56ZpQPW8j+p1bf1/pZQ+MqyUO+bzzzm/DFRiZATuPSt32LeqceNTXviJvJMvUCvuEu57K5HXIXm+HCVOGX+4Xojj4fGig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960197; c=relaxed/relaxed;
	bh=dyjKpiFdd7qow6743A52LrPpjhddYZz0iA/sauK4rRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF8Al/Fv0Q6G239rZq5h7jrvl3ZqEI7h16Zx/PH7Oxo94L4UXcYIQg+Cfm/XiRAgdl9aUW6KOYD7YhrLqxVSys9ukFgWEALpr7PF5YrcSYADl1yM3vGMYu7y/qFKgmq2ljNoW9ycaNzOpJjug9WgWt8H0cGuY8M9zWAcAEgpwBLBOWk/9stcKwL6l5vVkFw/BraJ3/dS6VJ8u7Jd+/FvjhXXH1lxMYpdQ/bR9T1EEwDraaXemfZfSiJBjk7CqR3bndIEH1toI6IMFYJODkTr9Qq7KuohreRFmtkHLHUr285pdBk/oJEtutEJkYIL7ceXb7QeGkJ2hHBbYeNwsabiSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XA6KA7dr; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XA6KA7dr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1hg0knCz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:23:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1508460214;
	Wed,  9 Sep 2026 13:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEA61F00A3A;
	Wed,  9 Sep 2026 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960192;
	bh=dyjKpiFdd7qow6743A52LrPpjhddYZz0iA/sauK4rRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XA6KA7drEe9OLkgcd0At3525IWBG8dOfo1vgNzZ9beG6pu3d9dD6bPL8t1zEIfuPC
	 LSZKfX391MTGk7dkaNN9neQb85WgY8Cs3f9BxI6cPYkDAdcwyBRxmzNT4N2m823srO
	 5NRfx96pxo/7QlxcV1LsoFv/KhEdhMpqgpT4/4LQ+EOa2o0yjV4jzBwAibEgSvoQe4
	 X7CNwfJmR6BQtma2GKttvI4NkzWSOpIvAT8eJi6EuyYmE9NQr9GDnwbAMrcwEHKNkQ
	 AdWvlFpkdljB80PNybr7vezhqIUD7iGJ6I+5rBRqkuycO/OWsIBAvzIMCMAIymr9g5
	 JSZ9J6TLrVL8w==
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
Subject: [PATCH 06/14] mfd: remove unused da903x driver
Date: Wed,  9 Sep 2026 15:21:43 +0200
Message-ID: <20260909132153.1596191-7-arnd@kernel.org>
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

This driver was used on a handful of ARM/PXA boards until those
got removed a few years ago. Without devicetree support, there is
no way to use them upstream.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                           |   1 -
 drivers/input/touchscreen/Kconfig     |  13 -
 drivers/input/touchscreen/Makefile    |   1 -
 drivers/input/touchscreen/da9034-ts.c | 365 ----------------
 drivers/leds/Kconfig                  |   8 -
 drivers/leds/Makefile                 |   1 -
 drivers/leds/leds-da903x.c            | 145 -------
 drivers/mfd/Kconfig                   |  11 -
 drivers/mfd/Makefile                  |   2 -
 drivers/mfd/da903x.c                  | 565 -------------------------
 drivers/power/supply/Kconfig          |   7 -
 drivers/power/supply/Makefile         |   1 -
 drivers/power/supply/da9030_battery.c | 581 --------------------------
 drivers/regulator/Kconfig             |   8 -
 drivers/regulator/Makefile            |   1 -
 drivers/regulator/da903x-regulator.c  | 495 ----------------------
 drivers/video/backlight/Kconfig       |   7 -
 drivers/video/backlight/Makefile      |   1 -
 drivers/video/backlight/da903x_bl.c   | 160 -------
 19 files changed, 2373 deletions(-)
 delete mode 100644 drivers/input/touchscreen/da9034-ts.c
 delete mode 100644 drivers/leds/leds-da903x.c
 delete mode 100644 drivers/mfd/da903x.c
 delete mode 100644 drivers/power/supply/da9030_battery.c
 delete mode 100644 drivers/regulator/da903x-regulator.c
 delete mode 100644 drivers/video/backlight/da903x_bl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 86df3fadba87..360655cce7d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7509,7 +7509,6 @@ F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-F:	drivers/mfd/da903x.c
 F:	drivers/mfd/da90??-*.c
 F:	drivers/mfd/da91??-*.c
 F:	drivers/pinctrl/pinctrl-da90??.c
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..80bffbead88b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -282,19 +282,6 @@ config TOUCHSCREEN_CYTTSP5
 	  To compile this driver as a module, choose M here: the
 	  module will be called cyttsp5.
 
-config TOUCHSCREEN_DA9034
-	tristate "Touchscreen support for Dialog Semiconductor DA9034"
-	depends on PMIC_DA903X
-	default y
-	help
-	  Say Y here to enable the support for the touchscreen found
-	  on Dialog Semiconductor DA9034 PMIC.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called da9034-ts.
-
 config TOUCHSCREEN_DA9052
 	tristate "Dialog DA9052/DA9053 TSI"
 	depends on PMIC_DA9052
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d..31ebdce6d09f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp_core.o
 obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)	+= cyttsp_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_CYTTSP_SPI)	+= cyttsp_spi.o
 obj-$(CONFIG_TOUCHSCREEN_CYTTSP5)	+= cyttsp5.o
-obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
deleted file mode 100644
index 2943f6a58388..000000000000
--- a/drivers/input/touchscreen/da9034-ts.c
+++ /dev/null
@@ -1,365 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Touchscreen driver for Dialog Semiconductor DA9034
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- *	Fengwei Yin <fengwei.yin@marvell.com>
- *	Bin Yang  <bin.yang@marvell.com>
- *	Eric Miao <eric.miao@marvell.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/workqueue.h>
-#include <linux/mfd/da903x.h>
-#include <linux/slab.h>
-
-#define DA9034_MANUAL_CTRL	0x50
-#define DA9034_LDO_ADC_EN	(1 << 4)
-
-#define DA9034_AUTO_CTRL1	0x51
-
-#define DA9034_AUTO_CTRL2	0x52
-#define DA9034_AUTO_TSI_EN	(1 << 3)
-#define DA9034_PEN_DETECT	(1 << 4)
-
-#define DA9034_TSI_CTRL1	0x53
-#define DA9034_TSI_CTRL2	0x54
-#define DA9034_TSI_X_MSB	0x6c
-#define DA9034_TSI_Y_MSB	0x6d
-#define DA9034_TSI_XY_LSB	0x6e
-
-enum {
-	STATE_IDLE,	/* wait for pendown */
-	STATE_BUSY,	/* TSI busy sampling */
-	STATE_STOP,	/* sample available */
-	STATE_WAIT,	/* Wait to start next sample */
-};
-
-enum {
-	EVENT_PEN_DOWN,
-	EVENT_PEN_UP,
-	EVENT_TSI_READY,
-	EVENT_TIMEDOUT,
-};
-
-struct da9034_touch {
-	struct device		*da9034_dev;
-	struct input_dev	*input_dev;
-
-	struct delayed_work	tsi_work;
-	struct notifier_block	notifier;
-
-	int	state;
-
-	int	interval_ms;
-	int	x_inverted;
-	int	y_inverted;
-
-	int	last_x;
-	int	last_y;
-};
-
-static inline int is_pen_down(struct da9034_touch *touch)
-{
-	return da903x_query_status(touch->da9034_dev, DA9034_STATUS_PEN_DOWN);
-}
-
-static inline int detect_pen_down(struct da9034_touch *touch, int on)
-{
-	if (on)
-		return da903x_set_bits(touch->da9034_dev,
-				DA9034_AUTO_CTRL2, DA9034_PEN_DETECT);
-	else
-		return da903x_clr_bits(touch->da9034_dev,
-				DA9034_AUTO_CTRL2, DA9034_PEN_DETECT);
-}
-
-static int read_tsi(struct da9034_touch *touch)
-{
-	uint8_t _x, _y, _v;
-	int ret;
-
-	ret = da903x_read(touch->da9034_dev, DA9034_TSI_X_MSB, &_x);
-	if (ret)
-		return ret;
-
-	ret = da903x_read(touch->da9034_dev, DA9034_TSI_Y_MSB, &_y);
-	if (ret)
-		return ret;
-
-	ret = da903x_read(touch->da9034_dev, DA9034_TSI_XY_LSB, &_v);
-	if (ret)
-		return ret;
-
-	touch->last_x = ((_x << 2) & 0x3fc) | (_v & 0x3);
-	touch->last_y = ((_y << 2) & 0x3fc) | ((_v & 0xc) >> 2);
-
-	return 0;
-}
-
-static inline int start_tsi(struct da9034_touch *touch)
-{
-	return da903x_set_bits(touch->da9034_dev,
-			DA9034_AUTO_CTRL2, DA9034_AUTO_TSI_EN);
-}
-
-static inline int stop_tsi(struct da9034_touch *touch)
-{
-	return da903x_clr_bits(touch->da9034_dev,
-			DA9034_AUTO_CTRL2, DA9034_AUTO_TSI_EN);
-}
-
-static inline void report_pen_down(struct da9034_touch *touch)
-{
-	int x = touch->last_x;
-	int y = touch->last_y;
-
-	x &= 0xfff;
-	if (touch->x_inverted)
-		x = 1024 - x;
-	y &= 0xfff;
-	if (touch->y_inverted)
-		y = 1024 - y;
-
-	input_report_abs(touch->input_dev, ABS_X, x);
-	input_report_abs(touch->input_dev, ABS_Y, y);
-	input_report_key(touch->input_dev, BTN_TOUCH, 1);
-
-	input_sync(touch->input_dev);
-}
-
-static inline void report_pen_up(struct da9034_touch *touch)
-{
-	input_report_key(touch->input_dev, BTN_TOUCH, 0);
-	input_sync(touch->input_dev);
-}
-
-static void da9034_event_handler(struct da9034_touch *touch, int event)
-{
-	int err;
-
-	switch (touch->state) {
-	case STATE_IDLE:
-		if (event != EVENT_PEN_DOWN)
-			break;
-
-		/* Enable auto measurement of the TSI, this will
-		 * automatically disable pen down detection
-		 */
-		err = start_tsi(touch);
-		if (err)
-			goto err_reset;
-
-		touch->state = STATE_BUSY;
-		break;
-
-	case STATE_BUSY:
-		if (event != EVENT_TSI_READY)
-			break;
-
-		err = read_tsi(touch);
-		if (err)
-			goto err_reset;
-
-		/* Disable auto measurement of the TSI, so that
-		 * pen down status will be available
-		 */
-		err = stop_tsi(touch);
-		if (err)
-			goto err_reset;
-
-		touch->state = STATE_STOP;
-
-		/* FIXME: PEN_{UP/DOWN} events are expected to be
-		 * available by stopping TSI, but this is found not
-		 * always true, delay and simulate such an event
-		 * here is more reliable
-		 */
-		mdelay(1);
-		da9034_event_handler(touch,
-				     is_pen_down(touch) ? EVENT_PEN_DOWN :
-							  EVENT_PEN_UP);
-		break;
-
-	case STATE_STOP:
-		if (event == EVENT_PEN_DOWN) {
-			report_pen_down(touch);
-			schedule_delayed_work(&touch->tsi_work,
-				msecs_to_jiffies(touch->interval_ms));
-			touch->state = STATE_WAIT;
-		}
-
-		if (event == EVENT_PEN_UP) {
-			report_pen_up(touch);
-			touch->state = STATE_IDLE;
-		}
-		break;
-
-	case STATE_WAIT:
-		if (event != EVENT_TIMEDOUT)
-			break;
-
-		if (is_pen_down(touch)) {
-			start_tsi(touch);
-			touch->state = STATE_BUSY;
-		} else {
-			report_pen_up(touch);
-			touch->state = STATE_IDLE;
-		}
-		break;
-	}
-	return;
-
-err_reset:
-	touch->state = STATE_IDLE;
-	stop_tsi(touch);
-	detect_pen_down(touch, 1);
-}
-
-static void da9034_tsi_work(struct work_struct *work)
-{
-	struct da9034_touch *touch =
-		container_of(work, struct da9034_touch, tsi_work.work);
-
-	da9034_event_handler(touch, EVENT_TIMEDOUT);
-}
-
-static int da9034_touch_notifier(struct notifier_block *nb,
-				 unsigned long event, void *data)
-{
-	struct da9034_touch *touch =
-		container_of(nb, struct da9034_touch, notifier);
-
-	if (event & DA9034_EVENT_TSI_READY)
-		da9034_event_handler(touch, EVENT_TSI_READY);
-
-	if ((event & DA9034_EVENT_PEN_DOWN) && touch->state == STATE_IDLE)
-		da9034_event_handler(touch, EVENT_PEN_DOWN);
-
-	return 0;
-}
-
-static int da9034_touch_open(struct input_dev *dev)
-{
-	struct da9034_touch *touch = input_get_drvdata(dev);
-	int ret;
-
-	ret = da903x_register_notifier(touch->da9034_dev, &touch->notifier,
-			DA9034_EVENT_PEN_DOWN | DA9034_EVENT_TSI_READY);
-	if (ret)
-		return -EBUSY;
-
-	/* Enable ADC LDO */
-	ret = da903x_set_bits(touch->da9034_dev,
-			DA9034_MANUAL_CTRL, DA9034_LDO_ADC_EN);
-	if (ret)
-		return ret;
-
-	/* TSI_DELAY: 3 slots, TSI_SKIP: 3 slots */
-	ret = da903x_write(touch->da9034_dev, DA9034_TSI_CTRL1, 0x1b);
-	if (ret)
-		return ret;
-
-	ret = da903x_write(touch->da9034_dev, DA9034_TSI_CTRL2, 0x00);
-	if (ret)
-		return ret;
-
-	touch->state = STATE_IDLE;
-	detect_pen_down(touch, 1);
-
-	return 0;
-}
-
-static void da9034_touch_close(struct input_dev *dev)
-{
-	struct da9034_touch *touch = input_get_drvdata(dev);
-
-	da903x_unregister_notifier(touch->da9034_dev, &touch->notifier,
-			DA9034_EVENT_PEN_DOWN | DA9034_EVENT_TSI_READY);
-
-	cancel_delayed_work_sync(&touch->tsi_work);
-
-	touch->state = STATE_IDLE;
-	stop_tsi(touch);
-	detect_pen_down(touch, 0);
-
-	/* Disable ADC LDO */
-	da903x_clr_bits(touch->da9034_dev,
-			DA9034_MANUAL_CTRL, DA9034_LDO_ADC_EN);
-}
-
-
-static int da9034_touch_probe(struct platform_device *pdev)
-{
-	struct da9034_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct da9034_touch *touch;
-	struct input_dev *input_dev;
-	int error;
-
-	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
-			     GFP_KERNEL);
-	if (!touch) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		return -ENOMEM;
-	}
-
-	touch->da9034_dev = pdev->dev.parent;
-
-	if (pdata) {
-		touch->interval_ms	= pdata->interval_ms;
-		touch->x_inverted	= pdata->x_inverted;
-		touch->y_inverted	= pdata->y_inverted;
-	} else {
-		/* fallback into default */
-		touch->interval_ms	= 10;
-	}
-
-	INIT_DELAYED_WORK(&touch->tsi_work, da9034_tsi_work);
-	touch->notifier.notifier_call = da9034_touch_notifier;
-
-	input_dev = devm_input_allocate_device(&pdev->dev);
-	if (!input_dev) {
-		dev_err(&pdev->dev, "failed to allocate input device\n");
-		return -ENOMEM;
-	}
-
-	input_dev->name		= pdev->name;
-	input_dev->open		= da9034_touch_open;
-	input_dev->close	= da9034_touch_close;
-	input_dev->dev.parent	= &pdev->dev;
-
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(ABS_X, input_dev->absbit);
-	__set_bit(ABS_Y, input_dev->absbit);
-	input_set_abs_params(input_dev, ABS_X, 0, 1023, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, 1023, 0, 0);
-
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
-
-	touch->input_dev = input_dev;
-	input_set_drvdata(input_dev, touch);
-
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
-
-	return 0;
-}
-
-static struct platform_driver da9034_touch_driver = {
-	.driver	= {
-		.name	= "da9034-touch",
-	},
-	.probe		= da9034_touch_probe,
-};
-module_platform_driver(da9034_touch_driver);
-
-MODULE_DESCRIPTION("Touchscreen driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>, Bin Yang <bin.yang@marvell.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:da9034-touch");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 5d6fc2a06016..5aab4765d6d7 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -638,14 +638,6 @@ config LEDS_WM8350
 	  This option enables support for LEDs driven by the Wolfson
 	  Microelectronics WM8350 AudioPlus PMIC.
 
-config LEDS_DA903X
-	tristate "LED Support for DA9030/DA9034 PMIC"
-	depends on LEDS_CLASS
-	depends on PMIC_DA903X
-	help
-	  This option enables support for on-chip LED drivers found
-	  on Dialog Semiconductor DA9030/DA9034 PMICs.
-
 config LEDS_DA9052
 	tristate "Dialog DA9052/DA9053 LEDS"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 96deebbca9d5..148301cf4865 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_LEDS_COBALT_QUBE)		+= leds-cobalt-qube.o
 obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_CPCAP)		+= leds-cpcap.o
 obj-$(CONFIG_LEDS_CROS_EC)		+= leds-cros_ec.o
-obj-$(CONFIG_LEDS_DA903X)		+= leds-da903x.o
 obj-$(CONFIG_LEDS_DA9052)		+= leds-da9052.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
 obj-$(CONFIG_LEDS_GPIO_REGISTER)	+= leds-gpio-register.o
diff --git a/drivers/leds/leds-da903x.c b/drivers/leds/leds-da903x.c
deleted file mode 100644
index 71209b3c8f1e..000000000000
--- a/drivers/leds/leds-da903x.c
+++ /dev/null
@@ -1,145 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * LEDs driver for Dialog Semiconductor DA9030/DA9034
- *
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
-#include <linux/mfd/da903x.h>
-#include <linux/slab.h>
-
-#define DA9030_LED1_CONTROL	0x20
-#define DA9030_LED2_CONTROL	0x21
-#define DA9030_LED3_CONTROL	0x22
-#define DA9030_LED4_CONTROL	0x23
-#define DA9030_LEDPC_CONTROL	0x24
-#define DA9030_MISC_CONTROL_A	0x26	/* Vibrator Control */
-
-#define DA9034_LED1_CONTROL	0x35
-#define DA9034_LED2_CONTROL	0x36
-#define DA9034_VIBRA		0x40
-
-struct da903x_led {
-	struct led_classdev	cdev;
-	struct device		*master;
-	int			id;
-	int			flags;
-};
-
-#define DA9030_LED_OFFSET(id)	((id) - DA9030_ID_LED_1)
-#define DA9034_LED_OFFSET(id)	((id) - DA9034_ID_LED_1)
-
-static int da903x_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
-{
-	struct da903x_led *led =
-			container_of(led_cdev, struct da903x_led, cdev);
-	uint8_t val;
-	int offset, ret = -EINVAL;
-
-	switch (led->id) {
-	case DA9030_ID_LED_1:
-	case DA9030_ID_LED_2:
-	case DA9030_ID_LED_3:
-	case DA9030_ID_LED_4:
-	case DA9030_ID_LED_PC:
-		offset = DA9030_LED_OFFSET(led->id);
-		val = led->flags & ~0x87;
-		val |= value ? 0x80 : 0; /* EN bit */
-		val |= (0x7 - (value >> 5)) & 0x7; /* PWM<2:0> */
-		ret = da903x_write(led->master, DA9030_LED1_CONTROL + offset,
-				   val);
-		break;
-	case DA9030_ID_VIBRA:
-		val = led->flags & ~0x80;
-		val |= value ? 0x80 : 0; /* EN bit */
-		ret = da903x_write(led->master, DA9030_MISC_CONTROL_A, val);
-		break;
-	case DA9034_ID_LED_1:
-	case DA9034_ID_LED_2:
-		offset = DA9034_LED_OFFSET(led->id);
-		val = (value * 0x5f / LED_FULL) & 0x7f;
-		val |= (led->flags & DA9034_LED_RAMP) ? 0x80 : 0;
-		ret = da903x_write(led->master, DA9034_LED1_CONTROL + offset,
-				   val);
-		break;
-	case DA9034_ID_VIBRA:
-		val = value & 0xfe;
-		ret = da903x_write(led->master, DA9034_VIBRA, val);
-		break;
-	}
-
-	return ret;
-}
-
-static int da903x_led_probe(struct platform_device *pdev)
-{
-	struct led_info *pdata = dev_get_platdata(&pdev->dev);
-	struct da903x_led *led;
-	int id, ret;
-
-	if (pdata == NULL)
-		return 0;
-
-	id = pdev->id;
-
-	if (!((id >= DA9030_ID_LED_1 && id <= DA9030_ID_VIBRA) ||
-	      (id >= DA9034_ID_LED_1 && id <= DA9034_ID_VIBRA))) {
-		dev_err(&pdev->dev, "invalid LED ID (%d) specified\n", id);
-		return -EINVAL;
-	}
-
-	led = devm_kzalloc(&pdev->dev, sizeof(struct da903x_led), GFP_KERNEL);
-	if (!led)
-		return -ENOMEM;
-
-	led->cdev.name = pdata->name;
-	led->cdev.default_trigger = pdata->default_trigger;
-	led->cdev.brightness_set_blocking = da903x_led_set;
-	led->cdev.brightness = LED_OFF;
-
-	led->id = id;
-	led->flags = pdata->flags;
-	led->master = pdev->dev.parent;
-
-	ret = led_classdev_register(led->master, &led->cdev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register LED %d\n", id);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, led);
-
-	return 0;
-}
-
-static void da903x_led_remove(struct platform_device *pdev)
-{
-	struct da903x_led *led = platform_get_drvdata(pdev);
-
-	led_classdev_unregister(&led->cdev);
-}
-
-static struct platform_driver da903x_led_driver = {
-	.driver	= {
-		.name	= "da903x-led",
-	},
-	.probe		= da903x_led_probe,
-	.remove		= da903x_led_remove,
-};
-
-module_platform_driver(da903x_led_driver);
-
-MODULE_DESCRIPTION("LEDs driver for Dialog Semiconductor DA9030/DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:da903x-led");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5126bae8e61f..fda9d7ad5743 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -408,17 +408,6 @@ config MFD_TN48M_CPLD
 	  for the SFP slots as well as power supply related information.
 	  SFP support depends on the GPIO driver being selected.
 
-config PMIC_DA903X
-	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
-	depends on I2C=y
-	help
-	  Say yes here to add support for Dialog Semiconductor DA9030 (a.k.a
-	  ARAVA) and DA9034 (a.k.a MICCO), these are Power Management IC
-	  usually found on PXA processors-based platforms. This includes
-	  the I2C driver and the core APIs _only_, you have to select
-	  individual components like LCD backlight, voltage regulators,
-	  LEDs and battery-charger under the corresponding menus.
-
 config PMIC_DA9052
 	bool
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a6cc4fcc3e1d..82795e65cbe7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -139,8 +139,6 @@ ifeq ($(CONFIG_SA1100_ASSABET),y)
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-assabet.o
 endif
 
-obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
-
 obj-$(CONFIG_PMIC_DA9052)	+= da9052-irq.o
 obj-$(CONFIG_PMIC_DA9052)	+= da9052-core.o
 obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
deleted file mode 100644
index e86b39de3303..000000000000
--- a/drivers/mfd/da903x.c
+++ /dev/null
@@ -1,565 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Base driver for Dialog Semiconductor DA9030/DA9034
- *
- * Copyright (C) 2008 Compulab, Ltd.
- *	Mike Rapoport <mike@compulab.co.il>
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- *	Eric Miao <eric.miao@marvell.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/mfd/da903x.h>
-#include <linux/slab.h>
-
-#define DA9030_CHIP_ID		0x00
-#define DA9030_EVENT_A		0x01
-#define DA9030_EVENT_B		0x02
-#define DA9030_EVENT_C		0x03
-#define DA9030_STATUS		0x04
-#define DA9030_IRQ_MASK_A	0x05
-#define DA9030_IRQ_MASK_B	0x06
-#define DA9030_IRQ_MASK_C	0x07
-#define DA9030_SYS_CTRL_A	0x08
-#define DA9030_SYS_CTRL_B	0x09
-#define DA9030_FAULT_LOG	0x0a
-
-#define DA9034_CHIP_ID		0x00
-#define DA9034_EVENT_A		0x01
-#define DA9034_EVENT_B		0x02
-#define DA9034_EVENT_C		0x03
-#define DA9034_EVENT_D		0x04
-#define DA9034_STATUS_A		0x05
-#define DA9034_STATUS_B		0x06
-#define DA9034_IRQ_MASK_A	0x07
-#define DA9034_IRQ_MASK_B	0x08
-#define DA9034_IRQ_MASK_C	0x09
-#define DA9034_IRQ_MASK_D	0x0a
-#define DA9034_SYS_CTRL_A	0x0b
-#define DA9034_SYS_CTRL_B	0x0c
-#define DA9034_FAULT_LOG	0x0d
-
-struct da903x_chip;
-
-struct da903x_chip_ops {
-	int	(*init_chip)(struct da903x_chip *);
-	int	(*unmask_events)(struct da903x_chip *, unsigned int events);
-	int	(*mask_events)(struct da903x_chip *, unsigned int events);
-	int	(*read_events)(struct da903x_chip *, unsigned int *events);
-	int	(*read_status)(struct da903x_chip *, unsigned int *status);
-};
-
-struct da903x_chip {
-	struct i2c_client	*client;
-	struct device		*dev;
-	const struct da903x_chip_ops *ops;
-
-	int			type;
-	uint32_t		events_mask;
-
-	struct mutex		lock;
-	struct work_struct	irq_work;
-
-	struct blocking_notifier_head notifier_list;
-};
-
-static inline int __da903x_read(struct i2c_client *client,
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
-static inline int __da903x_reads(struct i2c_client *client, int reg,
-				 int len, uint8_t *val)
-{
-	int ret;
-
-	ret = i2c_smbus_read_i2c_block_data(client, reg, len, val);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed reading from 0x%02x\n", reg);
-		return ret;
-	}
-	return 0;
-}
-
-static inline int __da903x_write(struct i2c_client *client,
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
-static inline int __da903x_writes(struct i2c_client *client, int reg,
-				  int len, uint8_t *val)
-{
-	int ret;
-
-	ret = i2c_smbus_write_i2c_block_data(client, reg, len, val);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed writings to 0x%02x\n", reg);
-		return ret;
-	}
-	return 0;
-}
-
-int da903x_register_notifier(struct device *dev, struct notifier_block *nb,
-				unsigned int events)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-
-	chip->ops->unmask_events(chip, events);
-	return blocking_notifier_chain_register(&chip->notifier_list, nb);
-}
-EXPORT_SYMBOL_GPL(da903x_register_notifier);
-
-int da903x_unregister_notifier(struct device *dev, struct notifier_block *nb,
-				unsigned int events)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-
-	chip->ops->mask_events(chip, events);
-	return blocking_notifier_chain_unregister(&chip->notifier_list, nb);
-}
-EXPORT_SYMBOL_GPL(da903x_unregister_notifier);
-
-int da903x_write(struct device *dev, int reg, uint8_t val)
-{
-	return __da903x_write(to_i2c_client(dev), reg, val);
-}
-EXPORT_SYMBOL_GPL(da903x_write);
-
-int da903x_writes(struct device *dev, int reg, int len, uint8_t *val)
-{
-	return __da903x_writes(to_i2c_client(dev), reg, len, val);
-}
-EXPORT_SYMBOL_GPL(da903x_writes);
-
-int da903x_read(struct device *dev, int reg, uint8_t *val)
-{
-	return __da903x_read(to_i2c_client(dev), reg, val);
-}
-EXPORT_SYMBOL_GPL(da903x_read);
-
-int da903x_reads(struct device *dev, int reg, int len, uint8_t *val)
-{
-	return __da903x_reads(to_i2c_client(dev), reg, len, val);
-}
-EXPORT_SYMBOL_GPL(da903x_reads);
-
-int da903x_set_bits(struct device *dev, int reg, uint8_t bit_mask)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-	uint8_t reg_val;
-	int ret = 0;
-
-	mutex_lock(&chip->lock);
-
-	ret = __da903x_read(chip->client, reg, &reg_val);
-	if (ret)
-		goto out;
-
-	if ((reg_val & bit_mask) != bit_mask) {
-		reg_val |= bit_mask;
-		ret = __da903x_write(chip->client, reg, reg_val);
-	}
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(da903x_set_bits);
-
-int da903x_clr_bits(struct device *dev, int reg, uint8_t bit_mask)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-	uint8_t reg_val;
-	int ret = 0;
-
-	mutex_lock(&chip->lock);
-
-	ret = __da903x_read(chip->client, reg, &reg_val);
-	if (ret)
-		goto out;
-
-	if (reg_val & bit_mask) {
-		reg_val &= ~bit_mask;
-		ret = __da903x_write(chip->client, reg, reg_val);
-	}
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(da903x_clr_bits);
-
-int da903x_update(struct device *dev, int reg, uint8_t val, uint8_t mask)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-	uint8_t reg_val;
-	int ret = 0;
-
-	mutex_lock(&chip->lock);
-
-	ret = __da903x_read(chip->client, reg, &reg_val);
-	if (ret)
-		goto out;
-
-	if ((reg_val & mask) != val) {
-		reg_val = (reg_val & ~mask) | val;
-		ret = __da903x_write(chip->client, reg, reg_val);
-	}
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(da903x_update);
-
-int da903x_query_status(struct device *dev, unsigned int sbits)
-{
-	struct da903x_chip *chip = dev_get_drvdata(dev);
-	unsigned int status = 0;
-
-	chip->ops->read_status(chip, &status);
-	return ((status & sbits) == sbits);
-}
-EXPORT_SYMBOL(da903x_query_status);
-
-static int da9030_init_chip(struct da903x_chip *chip)
-{
-	uint8_t chip_id;
-	int err;
-
-	err = __da903x_read(chip->client, DA9030_CHIP_ID, &chip_id);
-	if (err)
-		return err;
-
-	err = __da903x_write(chip->client, DA9030_SYS_CTRL_A, 0xE8);
-	if (err)
-		return err;
-
-	dev_info(chip->dev, "DA9030 (CHIP ID: 0x%02x) detected\n", chip_id);
-	return 0;
-}
-
-static int da9030_unmask_events(struct da903x_chip *chip, unsigned int events)
-{
-	uint8_t v[3];
-
-	chip->events_mask &= ~events;
-
-	v[0] = (chip->events_mask & 0xff);
-	v[1] = (chip->events_mask >> 8) & 0xff;
-	v[2] = (chip->events_mask >> 16) & 0xff;
-
-	return __da903x_writes(chip->client, DA9030_IRQ_MASK_A, 3, v);
-}
-
-static int da9030_mask_events(struct da903x_chip *chip, unsigned int events)
-{
-	uint8_t v[3];
-
-	chip->events_mask |= events;
-
-	v[0] = (chip->events_mask & 0xff);
-	v[1] = (chip->events_mask >> 8) & 0xff;
-	v[2] = (chip->events_mask >> 16) & 0xff;
-
-	return __da903x_writes(chip->client, DA9030_IRQ_MASK_A, 3, v);
-}
-
-static int da9030_read_events(struct da903x_chip *chip, unsigned int *events)
-{
-	uint8_t v[3] = {0, 0, 0};
-	int ret;
-
-	ret = __da903x_reads(chip->client, DA9030_EVENT_A, 3, v);
-	if (ret < 0)
-		return ret;
-
-	*events = (v[2] << 16) | (v[1] << 8) | v[0];
-	return 0;
-}
-
-static int da9030_read_status(struct da903x_chip *chip, unsigned int *status)
-{
-	return __da903x_read(chip->client, DA9030_STATUS, (uint8_t *)status);
-}
-
-static int da9034_init_chip(struct da903x_chip *chip)
-{
-	uint8_t chip_id;
-	int err;
-
-	err = __da903x_read(chip->client, DA9034_CHIP_ID, &chip_id);
-	if (err)
-		return err;
-
-	err = __da903x_write(chip->client, DA9034_SYS_CTRL_A, 0xE8);
-	if (err)
-		return err;
-
-	/* avoid SRAM power off during sleep*/
-	__da903x_write(chip->client, 0x10, 0x07);
-	__da903x_write(chip->client, 0x11, 0xff);
-	__da903x_write(chip->client, 0x12, 0xff);
-
-	/* Enable the ONKEY power down functionality */
-	__da903x_write(chip->client, DA9034_SYS_CTRL_B, 0x20);
-	__da903x_write(chip->client, DA9034_SYS_CTRL_A, 0x60);
-
-	/* workaround to make LEDs work */
-	__da903x_write(chip->client, 0x90, 0x01);
-	__da903x_write(chip->client, 0xB0, 0x08);
-
-	/* make ADTV1 and SDTV1 effective */
-	__da903x_write(chip->client, 0x20, 0x00);
-
-	dev_info(chip->dev, "DA9034 (CHIP ID: 0x%02x) detected\n", chip_id);
-	return 0;
-}
-
-static int da9034_unmask_events(struct da903x_chip *chip, unsigned int events)
-{
-	uint8_t v[4];
-
-	chip->events_mask &= ~events;
-
-	v[0] = (chip->events_mask & 0xff);
-	v[1] = (chip->events_mask >> 8) & 0xff;
-	v[2] = (chip->events_mask >> 16) & 0xff;
-	v[3] = (chip->events_mask >> 24) & 0xff;
-
-	return __da903x_writes(chip->client, DA9034_IRQ_MASK_A, 4, v);
-}
-
-static int da9034_mask_events(struct da903x_chip *chip, unsigned int events)
-{
-	uint8_t v[4];
-
-	chip->events_mask |= events;
-
-	v[0] = (chip->events_mask & 0xff);
-	v[1] = (chip->events_mask >> 8) & 0xff;
-	v[2] = (chip->events_mask >> 16) & 0xff;
-	v[3] = (chip->events_mask >> 24) & 0xff;
-
-	return __da903x_writes(chip->client, DA9034_IRQ_MASK_A, 4, v);
-}
-
-static int da9034_read_events(struct da903x_chip *chip, unsigned int *events)
-{
-	uint8_t v[4] = {0, 0, 0, 0};
-	int ret;
-
-	ret = __da903x_reads(chip->client, DA9034_EVENT_A, 4, v);
-	if (ret < 0)
-		return ret;
-
-	*events = (v[3] << 24) | (v[2] << 16) | (v[1] << 8) | v[0];
-	return 0;
-}
-
-static int da9034_read_status(struct da903x_chip *chip, unsigned int *status)
-{
-	uint8_t v[2] = {0, 0};
-	int ret = 0;
-
-	ret = __da903x_reads(chip->client, DA9034_STATUS_A, 2, v);
-	if (ret)
-		return ret;
-
-	*status = (v[1] << 8) | v[0];
-	return 0;
-}
-
-static void da903x_irq_work(struct work_struct *work)
-{
-	struct da903x_chip *chip =
-		container_of(work, struct da903x_chip, irq_work);
-	unsigned int events = 0;
-
-	while (1) {
-		if (chip->ops->read_events(chip, &events))
-			break;
-
-		events &= ~chip->events_mask;
-		if (events == 0)
-			break;
-
-		blocking_notifier_call_chain(
-				&chip->notifier_list, events, NULL);
-	}
-	enable_irq(chip->client->irq);
-}
-
-static irqreturn_t da903x_irq_handler(int irq, void *data)
-{
-	struct da903x_chip *chip = data;
-
-	disable_irq_nosync(irq);
-	(void)schedule_work(&chip->irq_work);
-
-	return IRQ_HANDLED;
-}
-
-static const struct da903x_chip_ops da903x_ops[] = {
-	[0] = {
-		.init_chip	= da9030_init_chip,
-		.unmask_events	= da9030_unmask_events,
-		.mask_events	= da9030_mask_events,
-		.read_events	= da9030_read_events,
-		.read_status	= da9030_read_status,
-	},
-	[1] = {
-		.init_chip	= da9034_init_chip,
-		.unmask_events	= da9034_unmask_events,
-		.mask_events	= da9034_mask_events,
-		.read_events	= da9034_read_events,
-		.read_status	= da9034_read_status,
-	}
-};
-
-static const struct i2c_device_id da903x_id_table[] = {
-	{ "da9030", 0 },
-	{ "da9034", 1 },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, da903x_id_table);
-
-static int __remove_subdev(struct device *dev, void *unused)
-{
-	platform_device_unregister(to_platform_device(dev));
-	return 0;
-}
-
-static int da903x_remove_subdevs(struct da903x_chip *chip)
-{
-	return device_for_each_child(chip->dev, NULL, __remove_subdev);
-}
-
-static int da903x_add_subdevs(struct da903x_chip *chip,
-					struct da903x_platform_data *pdata)
-{
-	struct da903x_subdev_info *subdev;
-	struct platform_device *pdev;
-	int i, ret = 0;
-
-	for (i = 0; i < pdata->num_subdevs; i++) {
-		subdev = &pdata->subdevs[i];
-
-		pdev = platform_device_alloc(subdev->name, subdev->id);
-		if (!pdev) {
-			ret = -ENOMEM;
-			goto failed;
-		}
-
-		pdev->dev.parent = chip->dev;
-		pdev->dev.platform_data = subdev->platform_data;
-
-		ret = platform_device_add(pdev);
-		if (ret) {
-			platform_device_put(pdev);
-			goto failed;
-		}
-	}
-	return 0;
-
-failed:
-	da903x_remove_subdevs(chip);
-	return ret;
-}
-
-static int da903x_probe(struct i2c_client *client)
-{
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct da903x_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct da903x_chip *chip;
-	unsigned int tmp;
-	int ret;
-
-	chip = devm_kzalloc(&client->dev, sizeof(struct da903x_chip),
-				GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
-	chip->client = client;
-	chip->dev = &client->dev;
-	chip->ops = &da903x_ops[id->driver_data];
-
-	mutex_init(&chip->lock);
-	INIT_WORK(&chip->irq_work, da903x_irq_work);
-	BLOCKING_INIT_NOTIFIER_HEAD(&chip->notifier_list);
-
-	i2c_set_clientdata(client, chip);
-
-	ret = chip->ops->init_chip(chip);
-	if (ret)
-		return ret;
-
-	/* mask and clear all IRQs */
-	chip->events_mask = 0xffffffff;
-	chip->ops->mask_events(chip, chip->events_mask);
-	chip->ops->read_events(chip, &tmp);
-
-	ret = devm_request_irq(&client->dev, client->irq, da903x_irq_handler,
-			IRQF_TRIGGER_FALLING,
-			"da903x", chip);
-	if (ret) {
-		dev_err(&client->dev, "failed to request irq %d\n",
-				client->irq);
-		return ret;
-	}
-
-	return da903x_add_subdevs(chip, pdata);
-}
-
-static void da903x_remove(struct i2c_client *client)
-{
-	struct da903x_chip *chip = i2c_get_clientdata(client);
-
-	da903x_remove_subdevs(chip);
-}
-
-static struct i2c_driver da903x_driver = {
-	.driver	= {
-		.name	= "da903x",
-	},
-	.probe		= da903x_probe,
-	.remove		= da903x_remove,
-	.id_table	= da903x_id_table,
-};
-
-static int __init da903x_init(void)
-{
-	return i2c_add_driver(&da903x_driver);
-}
-subsys_initcall(da903x_init);
-
-static void __exit da903x_exit(void)
-{
-	i2c_del_driver(&da903x_driver);
-}
-module_exit(da903x_exit);
-
-MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index b89ef40df7f8..a492c86e879a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -345,13 +345,6 @@ config BATTERY_BQ27XXX_DT_UPDATES_NVM
 	  general-purpose kernels, as this can cause misconfiguration of a
 	  smart battery with embedded NVM/flash.
 
-config BATTERY_DA9030
-	tristate "DA9030 battery driver"
-	depends on PMIC_DA903X
-	help
-	  Say Y here to enable support for batteries charger integrated into
-	  DA9030 PMIC.
-
 config BATTERY_DA9052
 	tristate "Dialog DA9052 Battery"
 	depends on PMIC_DA9052
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3c0d1006c1a..380546080112 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_MANAGER_SBS)	+= sbs-manager.o
 obj-$(CONFIG_BATTERY_BQ27XXX)	+= bq27xxx_battery.o
 obj-$(CONFIG_BATTERY_BQ27XXX_I2C) += bq27xxx_battery_i2c.o
 obj-$(CONFIG_BATTERY_BQ27XXX_HDQ) += bq27xxx_battery_hdq.o
-obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
 obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
 obj-$(CONFIG_CHARGER_DA9150)	+= da9150-charger.o
 obj-$(CONFIG_BATTERY_DA9150)	+= da9150-fg.o
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
deleted file mode 100644
index d25279c26030..000000000000
--- a/drivers/power/supply/da9030_battery.c
+++ /dev/null
@@ -1,581 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Battery charger driver for Dialog Semiconductor DA9030
- *
- * Copyright (C) 2008 Compulab, Ltd.
- * 	Mike Rapoport <mike@compulab.co.il>
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/workqueue.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/power_supply.h>
-#include <linux/string_choices.h>
-#include <linux/mfd/da903x.h>
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/notifier.h>
-
-#define DA9030_FAULT_LOG		0x0a
-#define DA9030_FAULT_LOG_OVER_TEMP	(1 << 7)
-#define DA9030_FAULT_LOG_VBAT_OVER	(1 << 4)
-
-#define DA9030_CHARGE_CONTROL		0x28
-#define DA9030_CHRG_CHARGER_ENABLE	(1 << 7)
-
-#define DA9030_ADC_MAN_CONTROL		0x30
-#define DA9030_ADC_TBATREF_ENABLE	(1 << 5)
-#define DA9030_ADC_LDO_INT_ENABLE	(1 << 4)
-
-#define DA9030_ADC_AUTO_CONTROL		0x31
-#define DA9030_ADC_TBAT_ENABLE		(1 << 5)
-#define DA9030_ADC_VBAT_IN_TXON		(1 << 4)
-#define DA9030_ADC_VCH_ENABLE		(1 << 3)
-#define DA9030_ADC_ICH_ENABLE		(1 << 2)
-#define DA9030_ADC_VBAT_ENABLE		(1 << 1)
-#define DA9030_ADC_AUTO_SLEEP_ENABLE	(1 << 0)
-
-#define DA9030_VBATMON		0x32
-#define DA9030_VBATMONTXON	0x33
-#define DA9030_TBATHIGHP	0x34
-#define DA9030_TBATHIGHN	0x35
-#define DA9030_TBATLOW		0x36
-
-#define DA9030_VBAT_RES		0x41
-#define DA9030_VBATMIN_RES	0x42
-#define DA9030_VBATMINTXON_RES	0x43
-#define DA9030_ICHMAX_RES	0x44
-#define DA9030_ICHMIN_RES	0x45
-#define DA9030_ICHAVERAGE_RES	0x46
-#define DA9030_VCHMAX_RES	0x47
-#define DA9030_VCHMIN_RES	0x48
-#define DA9030_TBAT_RES		0x49
-
-struct da9030_adc_res {
-	uint8_t vbat_res;
-	uint8_t vbatmin_res;
-	uint8_t vbatmintxon;
-	uint8_t ichmax_res;
-	uint8_t ichmin_res;
-	uint8_t ichaverage_res;
-	uint8_t vchmax_res;
-	uint8_t vchmin_res;
-	uint8_t tbat_res;
-	uint8_t adc_in4_res;
-	uint8_t adc_in5_res;
-};
-
-struct da9030_battery_thresholds {
-	int tbat_low;
-	int tbat_high;
-	int tbat_restart;
-
-	int vbat_low;
-	int vbat_crit;
-	int vbat_charge_start;
-	int vbat_charge_stop;
-	int vbat_charge_restart;
-
-	int vcharge_min;
-	int vcharge_max;
-};
-
-struct da9030_charger {
-	struct power_supply *psy;
-	struct power_supply_desc psy_desc;
-
-	struct device *master;
-
-	struct da9030_adc_res adc;
-	struct delayed_work work;
-	unsigned int interval;
-
-	struct power_supply_info *battery_info;
-
-	struct da9030_battery_thresholds thresholds;
-
-	unsigned int charge_milliamp;
-	unsigned int charge_millivolt;
-
-	/* charger status */
-	bool chdet;
-	uint8_t fault;
-	int mA;
-	int mV;
-	bool is_on;
-
-	struct notifier_block nb;
-
-	/* platform callbacks for battery low and critical events */
-	void (*battery_low)(void);
-	void (*battery_critical)(void);
-
-	struct dentry *debug_file;
-};
-
-static inline int da9030_reg_to_mV(int reg)
-{
-	return ((reg * 2650) >> 8) + 2650;
-}
-
-static inline int da9030_millivolt_to_reg(int mV)
-{
-	return ((mV - 2650) << 8) / 2650;
-}
-
-static inline int da9030_reg_to_mA(int reg)
-{
-	return ((reg * 24000) >> 8) / 15;
-}
-
-#ifdef CONFIG_DEBUG_FS
-static int bat_debug_show(struct seq_file *s, void *data)
-{
-	struct da9030_charger *charger = s->private;
-
-	seq_printf(s, "charger is %s\n", str_on_off(charger->is_on));
-	if (charger->chdet) {
-		seq_printf(s, "iset = %dmA, vset = %dmV\n",
-			   charger->mA, charger->mV);
-	}
-
-	seq_printf(s, "vbat_res = %d (%dmV)\n",
-		   charger->adc.vbat_res,
-		   da9030_reg_to_mV(charger->adc.vbat_res));
-	seq_printf(s, "vbatmin_res = %d (%dmV)\n",
-		   charger->adc.vbatmin_res,
-		   da9030_reg_to_mV(charger->adc.vbatmin_res));
-	seq_printf(s, "vbatmintxon = %d (%dmV)\n",
-		   charger->adc.vbatmintxon,
-		   da9030_reg_to_mV(charger->adc.vbatmintxon));
-	seq_printf(s, "ichmax_res = %d (%dmA)\n",
-		   charger->adc.ichmax_res,
-		   da9030_reg_to_mV(charger->adc.ichmax_res));
-	seq_printf(s, "ichmin_res = %d (%dmA)\n",
-		   charger->adc.ichmin_res,
-		   da9030_reg_to_mA(charger->adc.ichmin_res));
-	seq_printf(s, "ichaverage_res = %d (%dmA)\n",
-		   charger->adc.ichaverage_res,
-		   da9030_reg_to_mA(charger->adc.ichaverage_res));
-	seq_printf(s, "vchmax_res = %d (%dmV)\n",
-		   charger->adc.vchmax_res,
-		   da9030_reg_to_mA(charger->adc.vchmax_res));
-	seq_printf(s, "vchmin_res = %d (%dmV)\n",
-		   charger->adc.vchmin_res,
-		   da9030_reg_to_mV(charger->adc.vchmin_res));
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(bat_debug);
-
-static struct dentry *da9030_bat_create_debugfs(struct da9030_charger *charger)
-{
-	charger->debug_file = debugfs_create_file("charger", 0666, NULL,
-						  charger, &bat_debug_fops);
-	return charger->debug_file;
-}
-
-static void da9030_bat_remove_debugfs(struct da9030_charger *charger)
-{
-	debugfs_remove(charger->debug_file);
-}
-#else
-static inline struct dentry *da9030_bat_create_debugfs(struct da9030_charger *charger)
-{
-	return NULL;
-}
-static inline void da9030_bat_remove_debugfs(struct da9030_charger *charger)
-{
-}
-#endif
-
-static inline void da9030_read_adc(struct da9030_charger *charger,
-				   struct da9030_adc_res *adc)
-{
-	da903x_reads(charger->master, DA9030_VBAT_RES,
-		     sizeof(*adc), (uint8_t *)adc);
-}
-
-static void da9030_charger_update_state(struct da9030_charger *charger)
-{
-	uint8_t val;
-
-	da903x_read(charger->master, DA9030_CHARGE_CONTROL, &val);
-	charger->is_on = (val & DA9030_CHRG_CHARGER_ENABLE) ? 1 : 0;
-	charger->mA = ((val >> 3) & 0xf) * 100;
-	charger->mV = (val & 0x7) * 50 + 4000;
-
-	da9030_read_adc(charger, &charger->adc);
-	da903x_read(charger->master, DA9030_FAULT_LOG, &charger->fault);
-	charger->chdet = da903x_query_status(charger->master,
-						     DA9030_STATUS_CHDET);
-}
-
-static void da9030_set_charge(struct da9030_charger *charger, int on)
-{
-	uint8_t val;
-
-	if (on) {
-		val = DA9030_CHRG_CHARGER_ENABLE;
-		val |= (charger->charge_milliamp / 100) << 3;
-		val |= (charger->charge_millivolt - 4000) / 50;
-		charger->is_on = 1;
-	} else {
-		val = 0;
-		charger->is_on = 0;
-	}
-
-	da903x_write(charger->master, DA9030_CHARGE_CONTROL, val);
-
-	power_supply_changed(charger->psy);
-}
-
-static void da9030_charger_check_state(struct da9030_charger *charger)
-{
-	da9030_charger_update_state(charger);
-
-	/* we wake or boot with external power on */
-	if (!charger->is_on) {
-		if ((charger->chdet) &&
-		    (charger->adc.vbat_res <
-		     charger->thresholds.vbat_charge_start)) {
-			da9030_set_charge(charger, 1);
-		}
-	} else {
-		/* Charger has been pulled out */
-		if (!charger->chdet) {
-			da9030_set_charge(charger, 0);
-			return;
-		}
-
-		if (charger->adc.vbat_res >=
-		    charger->thresholds.vbat_charge_stop) {
-			da9030_set_charge(charger, 0);
-			da903x_write(charger->master, DA9030_VBATMON,
-				       charger->thresholds.vbat_charge_restart);
-		} else if (charger->adc.vbat_res >
-			   charger->thresholds.vbat_low) {
-			/* we are charging and passed LOW_THRESH,
-			   so upate DA9030 VBAT threshold
-			 */
-			da903x_write(charger->master, DA9030_VBATMON,
-				     charger->thresholds.vbat_low);
-		}
-		if (charger->adc.vchmax_res > charger->thresholds.vcharge_max ||
-		    charger->adc.vchmin_res < charger->thresholds.vcharge_min ||
-		    /* Temperature readings are negative */
-		    charger->adc.tbat_res < charger->thresholds.tbat_high ||
-		    charger->adc.tbat_res > charger->thresholds.tbat_low) {
-			/* disable charger */
-			da9030_set_charge(charger, 0);
-		}
-	}
-}
-
-static void da9030_charging_monitor(struct work_struct *work)
-{
-	struct da9030_charger *charger;
-
-	charger = container_of(work, struct da9030_charger, work.work);
-
-	da9030_charger_check_state(charger);
-
-	/* reschedule for the next time */
-	schedule_delayed_work(&charger->work, charger->interval);
-}
-
-static enum power_supply_property da9030_battery_props[] = {
-	POWER_SUPPLY_PROP_MODEL_NAME,
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_AVG,
-};
-
-static void da9030_battery_check_status(struct da9030_charger *charger,
-				    union power_supply_propval *val)
-{
-	if (charger->chdet) {
-		if (charger->is_on)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	} else {
-		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-	}
-}
-
-static void da9030_battery_check_health(struct da9030_charger *charger,
-				    union power_supply_propval *val)
-{
-	if (charger->fault & DA9030_FAULT_LOG_OVER_TEMP)
-		val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
-	else if (charger->fault & DA9030_FAULT_LOG_VBAT_OVER)
-		val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-	else
-		val->intval = POWER_SUPPLY_HEALTH_GOOD;
-}
-
-static int da9030_battery_get_property(struct power_supply *psy,
-				   enum power_supply_property psp,
-				   union power_supply_propval *val)
-{
-	struct da9030_charger *charger = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		da9030_battery_check_status(charger, val);
-		break;
-	case POWER_SUPPLY_PROP_HEALTH:
-		da9030_battery_check_health(charger, val);
-		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = charger->battery_info->technology;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = charger->battery_info->voltage_max_design;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = charger->battery_info->voltage_min_design;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = da9030_reg_to_mV(charger->adc.vbat_res) * 1000;
-		break;
-	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		val->intval =
-			da9030_reg_to_mA(charger->adc.ichaverage_res) * 1000;
-		break;
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = charger->battery_info->name;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static void da9030_battery_vbat_event(struct da9030_charger *charger)
-{
-	da9030_read_adc(charger, &charger->adc);
-
-	if (charger->is_on)
-		return;
-
-	if (charger->adc.vbat_res < charger->thresholds.vbat_low) {
-		/* set VBAT threshold for critical */
-		da903x_write(charger->master, DA9030_VBATMON,
-			     charger->thresholds.vbat_crit);
-		if (charger->battery_low)
-			charger->battery_low();
-	} else if (charger->adc.vbat_res <
-		   charger->thresholds.vbat_crit) {
-		/* notify the system of battery critical */
-		if (charger->battery_critical)
-			charger->battery_critical();
-	}
-}
-
-static int da9030_battery_event(struct notifier_block *nb, unsigned long event,
-				void *data)
-{
-	struct da9030_charger *charger =
-		container_of(nb, struct da9030_charger, nb);
-
-	switch (event) {
-	case DA9030_EVENT_CHDET:
-		cancel_delayed_work_sync(&charger->work);
-		schedule_work(&charger->work.work);
-		break;
-	case DA9030_EVENT_VBATMON:
-		da9030_battery_vbat_event(charger);
-		break;
-	case DA9030_EVENT_CHIOVER:
-	case DA9030_EVENT_TBAT:
-		da9030_set_charge(charger, 0);
-		break;
-	}
-
-	return 0;
-}
-
-static void da9030_battery_convert_thresholds(struct da9030_charger *charger,
-					      struct da9030_battery_info *pdata)
-{
-	charger->thresholds.tbat_low = pdata->tbat_low;
-	charger->thresholds.tbat_high = pdata->tbat_high;
-	charger->thresholds.tbat_restart  = pdata->tbat_restart;
-
-	charger->thresholds.vbat_low =
-		da9030_millivolt_to_reg(pdata->vbat_low);
-	charger->thresholds.vbat_crit =
-		da9030_millivolt_to_reg(pdata->vbat_crit);
-	charger->thresholds.vbat_charge_start =
-		da9030_millivolt_to_reg(pdata->vbat_charge_start);
-	charger->thresholds.vbat_charge_stop =
-		da9030_millivolt_to_reg(pdata->vbat_charge_stop);
-	charger->thresholds.vbat_charge_restart =
-		da9030_millivolt_to_reg(pdata->vbat_charge_restart);
-
-	charger->thresholds.vcharge_min =
-		da9030_millivolt_to_reg(pdata->vcharge_min);
-	charger->thresholds.vcharge_max =
-		da9030_millivolt_to_reg(pdata->vcharge_max);
-}
-
-static void da9030_battery_setup_psy(struct da9030_charger *charger)
-{
-	struct power_supply_desc *psy_desc = &charger->psy_desc;
-	struct power_supply_info *info = charger->battery_info;
-
-	psy_desc->name = info->name;
-	psy_desc->use_for_apm = info->use_for_apm;
-	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
-	psy_desc->get_property = da9030_battery_get_property;
-
-	psy_desc->properties = da9030_battery_props;
-	psy_desc->num_properties = ARRAY_SIZE(da9030_battery_props);
-};
-
-static int da9030_battery_charger_init(struct da9030_charger *charger)
-{
-	char v[5];
-	int ret;
-
-	v[0] = v[1] = charger->thresholds.vbat_low;
-	v[2] = charger->thresholds.tbat_high;
-	v[3] = charger->thresholds.tbat_restart;
-	v[4] = charger->thresholds.tbat_low;
-
-	ret = da903x_writes(charger->master, DA9030_VBATMON, 5, v);
-	if (ret)
-		return ret;
-
-	/*
-	 * Enable reference voltage supply for ADC from the LDO_INTERNAL
-	 * regulator. Must be set before ADC measurements can be made.
-	 */
-	ret = da903x_write(charger->master, DA9030_ADC_MAN_CONTROL,
-			   DA9030_ADC_LDO_INT_ENABLE |
-			   DA9030_ADC_TBATREF_ENABLE);
-	if (ret)
-		return ret;
-
-	/* enable auto ADC measurements */
-	return da903x_write(charger->master, DA9030_ADC_AUTO_CONTROL,
-			    DA9030_ADC_TBAT_ENABLE | DA9030_ADC_VBAT_IN_TXON |
-			    DA9030_ADC_VCH_ENABLE | DA9030_ADC_ICH_ENABLE |
-			    DA9030_ADC_VBAT_ENABLE |
-			    DA9030_ADC_AUTO_SLEEP_ENABLE);
-}
-
-static int da9030_battery_probe(struct platform_device *pdev)
-{
-	struct da9030_charger *charger;
-	struct power_supply_config psy_cfg = {};
-	struct da9030_battery_info *pdata = pdev->dev.platform_data;
-	int ret;
-
-	if (pdata == NULL)
-		return -EINVAL;
-
-	if (pdata->charge_milliamp >= 1500 ||
-	    pdata->charge_millivolt < 4000 ||
-	    pdata->charge_millivolt > 4350)
-		return -EINVAL;
-
-	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
-	if (charger == NULL)
-		return -ENOMEM;
-
-	charger->master = pdev->dev.parent;
-
-	/* 10 seconds between monitor runs unless platform defines other
-	   interval */
-	charger->interval = secs_to_jiffies(pdata->batmon_interval ? : 10);
-
-	charger->charge_milliamp = pdata->charge_milliamp;
-	charger->charge_millivolt = pdata->charge_millivolt;
-	charger->battery_info = pdata->battery_info;
-	charger->battery_low = pdata->battery_low;
-	charger->battery_critical = pdata->battery_critical;
-
-	da9030_battery_convert_thresholds(charger, pdata);
-
-	ret = da9030_battery_charger_init(charger);
-	if (ret)
-		goto err_charger_init;
-
-	INIT_DELAYED_WORK(&charger->work, da9030_charging_monitor);
-	schedule_delayed_work(&charger->work, charger->interval);
-
-	charger->nb.notifier_call = da9030_battery_event;
-	ret = da903x_register_notifier(charger->master, &charger->nb,
-				       DA9030_EVENT_CHDET |
-				       DA9030_EVENT_VBATMON |
-				       DA9030_EVENT_CHIOVER |
-				       DA9030_EVENT_TBAT);
-	if (ret)
-		goto err_notifier;
-
-	da9030_battery_setup_psy(charger);
-	psy_cfg.drv_data = charger;
-	charger->psy = devm_power_supply_register(&pdev->dev,
-						  &charger->psy_desc,
-						  &psy_cfg);
-	if (IS_ERR(charger->psy)) {
-		ret = PTR_ERR(charger->psy);
-		goto err_ps_register;
-	}
-
-	charger->debug_file = da9030_bat_create_debugfs(charger);
-	platform_set_drvdata(pdev, charger);
-	return 0;
-
-err_ps_register:
-	da903x_unregister_notifier(charger->master, &charger->nb,
-				   DA9030_EVENT_CHDET | DA9030_EVENT_VBATMON |
-				   DA9030_EVENT_CHIOVER | DA9030_EVENT_TBAT);
-err_notifier:
-	cancel_delayed_work(&charger->work);
-
-err_charger_init:
-	return ret;
-}
-
-static void da9030_battery_remove(struct platform_device *dev)
-{
-	struct da9030_charger *charger = platform_get_drvdata(dev);
-
-	da9030_bat_remove_debugfs(charger);
-
-	da903x_unregister_notifier(charger->master, &charger->nb,
-				   DA9030_EVENT_CHDET | DA9030_EVENT_VBATMON |
-				   DA9030_EVENT_CHIOVER | DA9030_EVENT_TBAT);
-	cancel_delayed_work_sync(&charger->work);
-	da9030_set_charge(charger, 0);
-}
-
-static struct platform_driver da903x_battery_driver = {
-	.driver	= {
-		.name	= "da903x-battery",
-	},
-	.probe = da9030_battery_probe,
-	.remove = da9030_battery_remove,
-};
-
-module_platform_driver(da903x_battery_driver);
-
-MODULE_DESCRIPTION("DA9030 battery charger driver");
-MODULE_AUTHOR("Mike Rapoport, CompuLab");
-MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4869a1d5041b..7d587ffc0a89 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -312,14 +312,6 @@ config REGULATOR_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called cros-ec-regulator.
 
-config REGULATOR_DA903X
-	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
-	depends on PMIC_DA903X
-	depends on !CC_IS_CLANG # https://llvm.org/pr38789
-	help
-	  Say y here to support the BUCKs and LDOs regulators found on
-	  Dialog Semiconductor DA9030/DA9034 PMIC.
-
 config REGULATOR_DA9052
 	tristate "Dialog Semiconductor DA9052/DA9053 regulators"
 	depends on PMIC_DA9052
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 86b5afcc974e..a1344d3c3fd3 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_BD957XMUF) += bd9576-regulator.o
 obj-$(CONFIG_REGULATOR_BQ257XX) += bq257xx-regulator.o
-obj-$(CONFIG_REGULATOR_DA903X)	+= da903x-regulator.o
 obj-$(CONFIG_REGULATOR_BD96801) += bd96801-regulator.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
 obj-$(CONFIG_REGULATOR_DA9055)	+= da9055-regulator.o
diff --git a/drivers/regulator/da903x-regulator.c b/drivers/regulator/da903x-regulator.c
deleted file mode 100644
index 2f85897183b3..000000000000
--- a/drivers/regulator/da903x-regulator.c
+++ /dev/null
@@ -1,495 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Regulators driver for Dialog Semiconductor DA903x
-//
-// Copyright (C) 2006-2008 Marvell International Ltd.
-// Copyright (C) 2008 Compulab Ltd.
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/mfd/da903x.h>
-
-/* DA9030 Registers */
-#define DA9030_INVAL		(-1)
-#define DA9030_LDO1011		(0x10)
-#define DA9030_LDO15		(0x11)
-#define DA9030_LDO1416		(0x12)
-#define DA9030_LDO1819		(0x13)
-#define DA9030_LDO17		(0x14)
-#define DA9030_BUCK2DVM1	(0x15)
-#define DA9030_BUCK2DVM2	(0x16)
-#define DA9030_RCTL11		(0x17)
-#define DA9030_RCTL21		(0x18)
-#define DA9030_LDO1		(0x90)
-#define DA9030_LDO23		(0x91)
-#define DA9030_LDO45		(0x92)
-#define DA9030_LDO6		(0x93)
-#define DA9030_LDO78		(0x94)
-#define DA9030_LDO912		(0x95)
-#define DA9030_BUCK		(0x96)
-#define DA9030_RCTL12		(0x97)
-#define DA9030_RCTL22		(0x98)
-#define DA9030_LDO_UNLOCK	(0xa0)
-#define DA9030_LDO_UNLOCK_MASK	(0xe0)
-#define DA9034_OVER1		(0x10)
-
-/* DA9034 Registers */
-#define DA9034_INVAL		(-1)
-#define DA9034_OVER2		(0x11)
-#define DA9034_OVER3		(0x12)
-#define DA9034_LDO643		(0x13)
-#define DA9034_LDO987		(0x14)
-#define DA9034_LDO1110		(0x15)
-#define DA9034_LDO1312		(0x16)
-#define DA9034_LDO1514		(0x17)
-#define DA9034_VCC1		(0x20)
-#define DA9034_ADTV1		(0x23)
-#define DA9034_ADTV2		(0x24)
-#define DA9034_AVRC		(0x25)
-#define DA9034_CDTV1		(0x26)
-#define DA9034_CDTV2		(0x27)
-#define DA9034_CVRC		(0x28)
-#define DA9034_SDTV1		(0x29)
-#define DA9034_SDTV2		(0x2a)
-#define DA9034_SVRC		(0x2b)
-#define DA9034_MDTV1		(0x32)
-#define DA9034_MDTV2		(0x33)
-#define DA9034_MVRC		(0x34)
-
-/* DA9035 Registers. DA9034 Registers are compatible to DA9035. */
-#define DA9035_OVER3		(0x12)
-#define DA9035_VCC2		(0x1f)
-#define DA9035_3DTV1		(0x2c)
-#define DA9035_3DTV2		(0x2d)
-#define DA9035_3VRC		(0x2e)
-#define DA9035_AUTOSKIP		(0x2f)
-
-struct da903x_regulator_info {
-	struct regulator_desc desc;
-
-	int	max_uV;
-	int	vol_reg;
-	int	vol_shift;
-	int	vol_nbits;
-	int	update_reg;
-	int	update_bit;
-	int	enable_reg;
-	int	enable_bit;
-};
-
-static inline struct device *to_da903x_dev(struct regulator_dev *rdev)
-{
-	return rdev_get_dev(rdev)->parent->parent;
-}
-
-static inline int check_range(struct da903x_regulator_info *info,
-				int min_uV, int max_uV)
-{
-	if (min_uV < info->desc.min_uV || min_uV > info->max_uV)
-		return -EINVAL;
-
-	return 0;
-}
-
-/* DA9030/DA9034 common operations */
-static int da903x_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-	uint8_t val, mask;
-
-	if (rdev->desc->n_voltages == 1)
-		return -EINVAL;
-
-	val = selector << info->vol_shift;
-	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;
-
-	return da903x_update(da9034_dev, info->vol_reg, val, mask);
-}
-
-static int da903x_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-	uint8_t val, mask;
-	int ret;
-
-	if (rdev->desc->n_voltages == 1)
-		return 0;
-
-	ret = da903x_read(da9034_dev, info->vol_reg, &val);
-	if (ret)
-		return ret;
-
-	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;
-	val = (val & mask) >> info->vol_shift;
-
-	return val;
-}
-
-static int da903x_enable(struct regulator_dev *rdev)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-
-	return da903x_set_bits(da9034_dev, info->enable_reg,
-					1 << info->enable_bit);
-}
-
-static int da903x_disable(struct regulator_dev *rdev)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-
-	return da903x_clr_bits(da9034_dev, info->enable_reg,
-					1 << info->enable_bit);
-}
-
-static int da903x_is_enabled(struct regulator_dev *rdev)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-	uint8_t reg_val;
-	int ret;
-
-	ret = da903x_read(da9034_dev, info->enable_reg, &reg_val);
-	if (ret)
-		return ret;
-
-	return !!(reg_val & (1 << info->enable_bit));
-}
-
-/* DA9030 specific operations */
-static int da9030_set_ldo1_15_voltage_sel(struct regulator_dev *rdev,
-					  unsigned selector)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da903x_dev = to_da903x_dev(rdev);
-	uint8_t val, mask;
-	int ret;
-
-	val = selector << info->vol_shift;
-	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;
-	val |= DA9030_LDO_UNLOCK; /* have to set UNLOCK bits */
-	mask |= DA9030_LDO_UNLOCK_MASK;
-
-	/* write twice */
-	ret = da903x_update(da903x_dev, info->vol_reg, val, mask);
-	if (ret)
-		return ret;
-
-	return da903x_update(da903x_dev, info->vol_reg, val, mask);
-}
-
-static int da9030_map_ldo14_voltage(struct regulator_dev *rdev,
-				    int min_uV, int max_uV)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	int thresh, sel;
-
-	if (check_range(info, min_uV, max_uV)) {
-		pr_err("invalid voltage range (%d, %d) uV\n", min_uV, max_uV);
-		return -EINVAL;
-	}
-
-	thresh = (info->max_uV + info->desc.min_uV) / 2;
-	if (min_uV < thresh) {
-		sel = DIV_ROUND_UP(thresh - min_uV, info->desc.uV_step);
-		sel |= 0x4;
-	} else {
-		sel = DIV_ROUND_UP(min_uV - thresh, info->desc.uV_step);
-	}
-
-	return sel;
-}
-
-static int da9030_list_ldo14_voltage(struct regulator_dev *rdev,
-				     unsigned selector)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	int volt;
-
-	if (selector & 0x4)
-		volt = rdev->desc->min_uV +
-		       rdev->desc->uV_step * (3 - (selector & ~0x4));
-	else
-		volt = (info->max_uV + rdev->desc->min_uV) / 2 +
-		       rdev->desc->uV_step * (selector & ~0x4);
-
-	if (volt > info->max_uV)
-		return -EINVAL;
-
-	return volt;
-}
-
-/* DA9034 specific operations */
-static int da9034_set_dvc_voltage_sel(struct regulator_dev *rdev,
-				      unsigned selector)
-{
-	struct da903x_regulator_info *info = rdev_get_drvdata(rdev);
-	struct device *da9034_dev = to_da903x_dev(rdev);
-	uint8_t val, mask;
-	int ret;
-
-	val = selector << info->vol_shift;
-	mask = ((1 << info->vol_nbits) - 1)  << info->vol_shift;
-
-	ret = da903x_update(da9034_dev, info->vol_reg, val, mask);
-	if (ret)
-		return ret;
-
-	ret = da903x_set_bits(da9034_dev, info->update_reg,
-					1 << info->update_bit);
-	return ret;
-}
-
-static const struct linear_range da9034_ldo12_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 50000),
-	REGULATOR_LINEAR_RANGE(2700000, 8, 15, 50000),
-};
-
-static const struct regulator_ops da903x_regulator_ldo_ops = {
-	.set_voltage_sel = da903x_set_voltage_sel,
-	.get_voltage_sel = da903x_get_voltage_sel,
-	.list_voltage	= regulator_list_voltage_linear,
-	.map_voltage	= regulator_map_voltage_linear,
-	.enable		= da903x_enable,
-	.disable	= da903x_disable,
-	.is_enabled	= da903x_is_enabled,
-};
-
-/* NOTE: this is dedicated for the insane DA9030 LDO14 */
-static const struct regulator_ops da9030_regulator_ldo14_ops = {
-	.set_voltage_sel = da903x_set_voltage_sel,
-	.get_voltage_sel = da903x_get_voltage_sel,
-	.list_voltage	= da9030_list_ldo14_voltage,
-	.map_voltage	= da9030_map_ldo14_voltage,
-	.enable		= da903x_enable,
-	.disable	= da903x_disable,
-	.is_enabled	= da903x_is_enabled,
-};
-
-/* NOTE: this is dedicated for the DA9030 LDO1 and LDO15 that have locks  */
-static const struct regulator_ops da9030_regulator_ldo1_15_ops = {
-	.set_voltage_sel = da9030_set_ldo1_15_voltage_sel,
-	.get_voltage_sel = da903x_get_voltage_sel,
-	.list_voltage	= regulator_list_voltage_linear,
-	.map_voltage	= regulator_map_voltage_linear,
-	.enable		= da903x_enable,
-	.disable	= da903x_disable,
-	.is_enabled	= da903x_is_enabled,
-};
-
-static const struct regulator_ops da9034_regulator_dvc_ops = {
-	.set_voltage_sel = da9034_set_dvc_voltage_sel,
-	.get_voltage_sel = da903x_get_voltage_sel,
-	.list_voltage	= regulator_list_voltage_linear,
-	.map_voltage	= regulator_map_voltage_linear,
-	.enable		= da903x_enable,
-	.disable	= da903x_disable,
-	.is_enabled	= da903x_is_enabled,
-};
-
-/* NOTE: this is dedicated for the insane LDO12 */
-static const struct regulator_ops da9034_regulator_ldo12_ops = {
-	.set_voltage_sel = da903x_set_voltage_sel,
-	.get_voltage_sel = da903x_get_voltage_sel,
-	.list_voltage	= regulator_list_voltage_linear_range,
-	.map_voltage	= regulator_map_voltage_linear_range,
-	.enable		= da903x_enable,
-	.disable	= da903x_disable,
-	.is_enabled	= da903x_is_enabled,
-};
-
-#define DA903x_LDO(_pmic, _id, min, max, step, vreg, shift, nbits, ereg, ebit)	\
-{									\
-	.desc	= {							\
-		.name	= "LDO" #_id,					\
-		.ops	= &da903x_regulator_ldo_ops,			\
-		.type	= REGULATOR_VOLTAGE,				\
-		.id	= _pmic##_ID_LDO##_id,				\
-		.n_voltages = (step) ? ((max - min) / step + 1) : 1,	\
-		.owner	= THIS_MODULE,					\
-		.min_uV	 = (min) * 1000,				\
-		.uV_step = (step) * 1000,				\
-	},								\
-	.max_uV		= (max) * 1000,					\
-	.vol_reg	= _pmic##_##vreg,				\
-	.vol_shift	= (shift),					\
-	.vol_nbits	= (nbits),					\
-	.enable_reg	= _pmic##_##ereg,				\
-	.enable_bit	= (ebit),					\
-}
-
-#define DA903x_DVC(_pmic, _id, min, max, step, vreg, nbits, ureg, ubit, ereg, ebit) \
-{									\
-	.desc	= {							\
-		.name	= #_id,						\
-		.ops	= &da9034_regulator_dvc_ops,			\
-		.type	= REGULATOR_VOLTAGE,				\
-		.id	= _pmic##_ID_##_id,				\
-		.n_voltages = (step) ? ((max - min) / step + 1) : 1,	\
-		.owner	= THIS_MODULE,					\
-		.min_uV = (min) * 1000,					\
-		.uV_step = (step) * 1000,				\
-	},								\
-	.max_uV		= (max) * 1000,					\
-	.vol_reg	= _pmic##_##vreg,				\
-	.vol_shift	= (0),						\
-	.vol_nbits	= (nbits),					\
-	.update_reg	= _pmic##_##ureg,				\
-	.update_bit	= (ubit),					\
-	.enable_reg	= _pmic##_##ereg,				\
-	.enable_bit	= (ebit),					\
-}
-
-#define DA9034_LDO(_id, min, max, step, vreg, shift, nbits, ereg, ebit)	\
-	DA903x_LDO(DA9034, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
-
-#define DA9030_LDO(_id, min, max, step, vreg, shift, nbits, ereg, ebit)	\
-	DA903x_LDO(DA9030, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
-
-#define DA9030_DVC(_id, min, max, step, vreg, nbits, ureg, ubit, ereg, ebit) \
-	DA903x_DVC(DA9030, _id, min, max, step, vreg, nbits, ureg, ubit, \
-		   ereg, ebit)
-
-#define DA9034_DVC(_id, min, max, step, vreg, nbits, ureg, ubit, ereg, ebit) \
-	DA903x_DVC(DA9034, _id, min, max, step, vreg, nbits, ureg, ubit, \
-		   ereg, ebit)
-
-#define DA9035_DVC(_id, min, max, step, vreg, nbits, ureg, ubit, ereg, ebit) \
-	DA903x_DVC(DA9035, _id, min, max, step, vreg, nbits, ureg, ubit, \
-		   ereg, ebit)
-
-static struct da903x_regulator_info da903x_regulator_info[] = {
-	/* DA9030 */
-	DA9030_DVC(BUCK2, 850, 1625, 25, BUCK2DVM1, 5, BUCK2DVM1, 7, RCTL11, 0),
-
-	DA9030_LDO( 1, 1200, 3200, 100,    LDO1, 0, 5, RCTL12, 1),
-	DA9030_LDO( 2, 1800, 3200, 100,   LDO23, 0, 4, RCTL12, 2),
-	DA9030_LDO( 3, 1800, 3200, 100,   LDO23, 4, 4, RCTL12, 3),
-	DA9030_LDO( 4, 1800, 3200, 100,   LDO45, 0, 4, RCTL12, 4),
-	DA9030_LDO( 5, 1800, 3200, 100,   LDO45, 4, 4, RCTL12, 5),
-	DA9030_LDO( 6, 1800, 3200, 100,    LDO6, 0, 4, RCTL12, 6),
-	DA9030_LDO( 7, 1800, 3200, 100,   LDO78, 0, 4, RCTL12, 7),
-	DA9030_LDO( 8, 1800, 3200, 100,   LDO78, 4, 4, RCTL22, 0),
-	DA9030_LDO( 9, 1800, 3200, 100,  LDO912, 0, 4, RCTL22, 1),
-	DA9030_LDO(10, 1800, 3200, 100, LDO1011, 0, 4, RCTL22, 2),
-	DA9030_LDO(11, 1800, 3200, 100, LDO1011, 4, 4, RCTL22, 3),
-	DA9030_LDO(12, 1800, 3200, 100,  LDO912, 4, 4, RCTL22, 4),
-	DA9030_LDO(14, 2760, 2940,  30, LDO1416, 0, 3, RCTL11, 4),
-	DA9030_LDO(15, 1100, 2650,  50,	  LDO15, 0, 5, RCTL11, 5),
-	DA9030_LDO(16, 1100, 2650,  50, LDO1416, 3, 5, RCTL11, 6),
-	DA9030_LDO(17, 1800, 3200, 100,   LDO17, 0, 4, RCTL11, 7),
-	DA9030_LDO(18, 1800, 3200, 100, LDO1819, 0, 4, RCTL21, 2),
-	DA9030_LDO(19, 1800, 3200, 100, LDO1819, 4, 4, RCTL21, 1),
-	DA9030_LDO(13, 2100, 2100, 0, INVAL, 0, 0, RCTL11, 3), /* fixed @2.1V */
-
-	/* DA9034 */
-	DA9034_DVC(BUCK1, 725, 1500, 25, ADTV2, 5, VCC1, 0, OVER1, 0),
-	DA9034_DVC(BUCK2, 725, 1500, 25, CDTV2, 5, VCC1, 2, OVER1, 1),
-	DA9034_DVC(LDO2,  725, 1500, 25, SDTV2, 5, VCC1, 4, OVER1, 2),
-	DA9034_DVC(LDO1, 1700, 2075, 25, MDTV1, 4, VCC1, 6, OVER3, 4),
-
-	DA9034_LDO( 3, 1800, 3300, 100,  LDO643, 0, 4, OVER3, 5),
-	DA9034_LDO( 4, 1800, 2900,1100,  LDO643, 4, 1, OVER3, 6),
-	DA9034_LDO( 6, 2500, 2850,  50,  LDO643, 5, 3, OVER2, 0),
-	DA9034_LDO( 7, 2700, 3050,  50,  LDO987, 0, 3, OVER2, 1),
-	DA9034_LDO( 8, 2700, 2850,  50,  LDO987, 3, 2, OVER2, 2),
-	DA9034_LDO( 9, 2700, 3050,  50,  LDO987, 5, 3, OVER2, 3),
-	DA9034_LDO(10, 2700, 3050,  50, LDO1110, 0, 3, OVER2, 4),
-	DA9034_LDO(11, 1800, 3300, 100, LDO1110, 4, 4, OVER2, 5),
-	DA9034_LDO(12, 1700, 3050,  50, LDO1312, 0, 4, OVER3, 6),
-	DA9034_LDO(13, 1800, 3300, 100, LDO1312, 4, 4, OVER2, 7),
-	DA9034_LDO(14, 1800, 3300, 100, LDO1514, 0, 4, OVER3, 0),
-	DA9034_LDO(15, 1800, 3300, 100, LDO1514, 4, 4, OVER3, 1),
-	DA9034_LDO(5, 3100, 3100, 0, INVAL, 0, 0, OVER3, 7), /* fixed @3.1V */
-
-	/* DA9035 */
-	DA9035_DVC(BUCK3, 1800, 2200, 100, 3DTV1, 3, VCC2, 0, OVER3, 3),
-};
-
-static inline struct da903x_regulator_info *find_regulator_info(int id)
-{
-	struct da903x_regulator_info *ri;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(da903x_regulator_info); i++) {
-		ri = &da903x_regulator_info[i];
-		if (ri->desc.id == id)
-			return ri;
-	}
-	return NULL;
-}
-
-static int da903x_regulator_probe(struct platform_device *pdev)
-{
-	struct da903x_regulator_info *ri = NULL;
-	struct regulator_dev *rdev;
-	struct regulator_config config = { };
-
-	ri = find_regulator_info(pdev->id);
-	if (ri == NULL) {
-		dev_err(&pdev->dev, "invalid regulator ID specified\n");
-		return -EINVAL;
-	}
-
-	/* Workaround for the weird LDO12 voltage setting */
-	if (ri->desc.id == DA9034_ID_LDO12) {
-		ri->desc.ops = &da9034_regulator_ldo12_ops;
-		ri->desc.n_voltages = 16;
-		ri->desc.linear_ranges = da9034_ldo12_ranges;
-		ri->desc.n_linear_ranges = ARRAY_SIZE(da9034_ldo12_ranges);
-	}
-
-	if (ri->desc.id == DA9030_ID_LDO14)
-		ri->desc.ops = &da9030_regulator_ldo14_ops;
-
-	if (ri->desc.id == DA9030_ID_LDO1 || ri->desc.id == DA9030_ID_LDO15)
-		ri->desc.ops = &da9030_regulator_ldo1_15_ops;
-
-	config.dev = &pdev->dev;
-	config.init_data = dev_get_platdata(&pdev->dev);
-	config.driver_data = ri;
-
-	rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&pdev->dev, "failed to register regulator %s\n",
-				ri->desc.name);
-		return PTR_ERR(rdev);
-	}
-
-	platform_set_drvdata(pdev, rdev);
-	return 0;
-}
-
-static struct platform_driver da903x_regulator_driver = {
-	.driver	= {
-		.name	= "da903x-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe		= da903x_regulator_probe,
-};
-
-static int __init da903x_regulator_init(void)
-{
-	return platform_driver_register(&da903x_regulator_driver);
-}
-subsys_initcall(da903x_regulator_init);
-
-static void __exit da903x_regulator_exit(void)
-{
-	platform_driver_unregister(&da903x_regulator_driver);
-}
-module_exit(da903x_regulator_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>"
-	      "Mike Rapoport <mike@compulab.co.il>");
-MODULE_DESCRIPTION("Regulator Driver for Dialog Semiconductor DA903X PMIC");
-MODULE_ALIAS("platform:da903x-regulator");
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 63e5059563b4..413ed6c38b53 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -277,13 +277,6 @@ config BACKLIGHT_CGBC
 	  backlight subsystem. It communicates with the board controller to
 	  adjust LCD backlight using PWM signals.
 
-config BACKLIGHT_DA903X
-	tristate "Backlight Driver for DA9030/DA9034 using WLED"
-	depends on PMIC_DA903X
-	help
-	  If you have a LCD backlight connected to the WLED output of DA9030
-	  or DA9034 WLED output, say Y here to enable this driver.
-
 config BACKLIGHT_DA9052
 	tristate "Dialog DA9052/DA9053 WLED"
 	depends on PMIC_DA9052
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 1a6bef13430b..3dc3580d82c7 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_BACKLIGHT_AW99706)		+= aw99706.o
 obj-$(CONFIG_BACKLIGHT_BD6107)		+= bd6107.o
 obj-$(CONFIG_BACKLIGHT_CGBC)		+= cgbc_bl.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
-obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
 obj-$(CONFIG_BACKLIGHT_DA9052)		+= da9052_bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)		+= ep93xx_bl.o
 obj-$(CONFIG_BACKLIGHT_GPIO)		+= gpio_backlight.o
diff --git a/drivers/video/backlight/da903x_bl.c b/drivers/video/backlight/da903x_bl.c
deleted file mode 100644
index 81ff42bec0ad..000000000000
--- a/drivers/video/backlight/da903x_bl.c
+++ /dev/null
@@ -1,160 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Backlight driver for Dialog Semiconductor DA9030/DA9034
- *
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
-#include <linux/backlight.h>
-#include <linux/mfd/da903x.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-
-#define DA9030_WLED_CONTROL	0x25
-#define DA9030_WLED_CP_EN	(1 << 6)
-#define DA9030_WLED_TRIM(x)	((x) & 0x7)
-
-#define DA9034_WLED_CONTROL1	0x3C
-#define DA9034_WLED_CONTROL2	0x3D
-#define DA9034_WLED_ISET(x)	((x) & 0x1f)
-
-#define DA9034_WLED_BOOST_EN	(1 << 5)
-
-#define DA9030_MAX_BRIGHTNESS	7
-#define DA9034_MAX_BRIGHTNESS	0x7f
-
-struct da903x_backlight_data {
-	struct device *da903x_dev;
-	int id;
-	int current_brightness;
-};
-
-static int da903x_backlight_set(struct backlight_device *bl, int brightness)
-{
-	struct da903x_backlight_data *data = bl_get_data(bl);
-	struct device *dev = data->da903x_dev;
-	uint8_t val;
-	int ret = 0;
-
-	switch (data->id) {
-	case DA9034_ID_WLED:
-		ret = da903x_update(dev, DA9034_WLED_CONTROL1,
-				brightness, 0x7f);
-		if (ret)
-			return ret;
-
-		if (data->current_brightness && brightness == 0)
-			ret = da903x_clr_bits(dev,
-					DA9034_WLED_CONTROL2,
-					DA9034_WLED_BOOST_EN);
-
-		if (data->current_brightness == 0 && brightness)
-			ret = da903x_set_bits(dev,
-					DA9034_WLED_CONTROL2,
-					DA9034_WLED_BOOST_EN);
-		break;
-	case DA9030_ID_WLED:
-		val = DA9030_WLED_TRIM(brightness);
-		val |= brightness ? DA9030_WLED_CP_EN : 0;
-		ret = da903x_write(dev, DA9030_WLED_CONTROL, val);
-		break;
-	}
-
-	if (ret)
-		return ret;
-
-	data->current_brightness = brightness;
-	return 0;
-}
-
-static int da903x_backlight_update_status(struct backlight_device *bl)
-{
-	return da903x_backlight_set(bl, backlight_get_brightness(bl));
-}
-
-static int da903x_backlight_get_brightness(struct backlight_device *bl)
-{
-	struct da903x_backlight_data *data = bl_get_data(bl);
-
-	return data->current_brightness;
-}
-
-static const struct backlight_ops da903x_backlight_ops = {
-	.options	= BL_CORE_SUSPENDRESUME,
-	.update_status	= da903x_backlight_update_status,
-	.get_brightness	= da903x_backlight_get_brightness,
-};
-
-static int da903x_backlight_probe(struct platform_device *pdev)
-{
-	struct da9034_backlight_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct da903x_backlight_data *data;
-	struct backlight_device *bl;
-	struct backlight_properties props;
-	int max_brightness;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
-	switch (pdev->id) {
-	case DA9030_ID_WLED:
-		max_brightness = DA9030_MAX_BRIGHTNESS;
-		break;
-	case DA9034_ID_WLED:
-		max_brightness = DA9034_MAX_BRIGHTNESS;
-		break;
-	default:
-		dev_err(&pdev->dev, "invalid backlight device ID(%d)\n",
-				pdev->id);
-		return -EINVAL;
-	}
-
-	data->id = pdev->id;
-	data->da903x_dev = pdev->dev.parent;
-	data->current_brightness = 0;
-
-	/* adjust the WLED output current */
-	if (pdata)
-		da903x_write(data->da903x_dev, DA9034_WLED_CONTROL2,
-				DA9034_WLED_ISET(pdata->output_current));
-
-	memset(&props, 0, sizeof(props));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = max_brightness;
-	bl = devm_backlight_device_register(&pdev->dev, pdev->name,
-					data->da903x_dev, data,
-					&da903x_backlight_ops, &props);
-	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
-		return PTR_ERR(bl);
-	}
-
-	bl->props.brightness = max_brightness;
-
-	platform_set_drvdata(pdev, bl);
-	backlight_update_status(bl);
-	return 0;
-}
-
-static struct platform_driver da903x_backlight_driver = {
-	.driver		= {
-		.name	= "da903x-backlight",
-	},
-	.probe		= da903x_backlight_probe,
-};
-
-module_platform_driver(da903x_backlight_driver);
-
-MODULE_DESCRIPTION("Backlight Driver for Dialog Semiconductor DA9030/DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:da903x-backlight");
-- 
2.53.0


