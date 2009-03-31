Return-Path: <wg@denx.de>
Message-Id: <20090331124035.427262955@denx.de>
Date: Tue, 31 Mar 2009 14:37:29 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] [PATCH 01/28] RTC: Add support for RX8025 chip.
References: <20090331123727.853787299@denx.de>
Cc: Sergei Poselenov <sposelenov@emcraft.com>, devicetree-discuss@ozlabs.org,
	Matthias Fuchs <matthias.fuchs@esd.eu>, Dmitry Rakhchev <rda@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the Epson RX-8025SA/NB RTC chips. It
includes support for alarms update interrupts (1 Hz) and clock
precision adjustment.

For clock precision adjustment, the SYSFS file "clock_adjust_ppb" gets
created in "/sys/class/rtc/rtcX/device". It permits to set and get the
clock adjustment in ppb (parts per billion), e.g.:

  # echo -183000 > /sys/class/rtc/rtc0/device/clock_adjust_ppb
  # cat /sys/class/rtc/rtc0/device/clock_adjust_ppb
  -183000

This allows to compensate temperature dependent clock drifts. According
to the RX8025 SA/NB application manual the frequency and temperature 
charateristics can be approximated using the following equation:

  df = a * (ut - t)**2

  df: Frequency deviation in any temperature
  a : Coefficient = (-35 +-5) * 10**-9  
  ut: Ultimate temperature in degree = +25 +-5 degree  
  t : Any temperature in degree  


Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Dmitry Rakhchev <rda@emcraft.com>
Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
---
 drivers/rtc/Kconfig      |    9 
 drivers/rtc/Makefile     |    1 
 drivers/rtc/rtc-rx8025.c |  891 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 901 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx8025.c

Index: linux-2.6/drivers/rtc/Kconfig
===================================================================
--- linux-2.6.orig/drivers/rtc/Kconfig
+++ linux-2.6/drivers/rtc/Kconfig
@@ -295,6 +295,15 @@ config RTC_DRV_RX8581
 	  This driver can also be built as a module. If so the module
 	  will be called rtc-rx8581.
 
+config RTC_DRV_RX8025
+	tristate "Epson RX-8025SA/NB"
+	help
+	  If you say yes here you get support for the Epson
+	  RX-8025SA/NB RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-rx8025.
+
 endif # I2C
 
 comment "SPI RTC drivers"
Index: linux-2.6/drivers/rtc/Makefile
===================================================================
--- linux-2.6.orig/drivers/rtc/Makefile
+++ linux-2.6/drivers/rtc/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701
 obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
 obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
+obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
 obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
 obj-$(CONFIG_RTC_DRV_S35390A)	+= rtc-s35390a.o
 obj-$(CONFIG_RTC_DRV_S3C)	+= rtc-s3c.o
Index: linux-2.6/drivers/rtc/rtc-rx8025.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/rtc/rtc-rx8025.c
@@ -0,0 +1,891 @@
+/*
+ * Driver for Epson's RTC module RX-8025 SA/NB
+ *
+ * Copyright (C) 2005 by Digi International Inc.
+ * All rights reserved.
+ *
+ * Modify by fengjh at rising.com.cn
+ * <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>
+ * 2006.11
+ *
+ * Code cleanup by Sergei Poselenov, <sposelenov@emcraft.com>
+ * Converted to new style by Wolfgang Grandegger <wg@grandegger.com>
+ * Alarm and periodic interrupt added by Dmitry Rakhchev <rda@emcraft.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+
+/* registers */
+#define RX8025_REG_SEC		0x00
+#define RX8025_REG_MIN		0x01
+#define RX8025_REG_HOUR		0x02
+#define RX8025_REG_WDAY		0x03
+#define RX8025_REG_MDAY		0x04
+#define RX8025_REG_MONTH	0x05
+#define RX8025_REG_YEAR		0x06
+#define RX8025_REG_DIGOFF	0x07
+#define RX8025_REG_ALWMIN	0x08
+#define RX8025_REG_ALWHOUR	0x09
+#define RX8025_REG_ALWWDAY	0x0a
+#define RX8025_REG_ALDMIN	0x0b
+#define RX8025_REG_ALDHOUR	0x0c
+/* 0x0d is reserved */
+#define RX8025_REG_CTRL1	0x0e
+#define RX8025_REG_CTRL2	0x0f
+
+#define RX8025_BIT_CTRL1_CT	(7 << 0)
+/* 1 Hz periodic level irq */
+#define RX8025_BIT_CTRL1_CT_1HZ	4
+#define RX8025_BIT_CTRL1_TEST	(1 << 3)
+#define RX8025_BIT_CTRL1_1224	(1 << 5)
+#define RX8025_BIT_CTRL1_DALE	(1 << 6)
+#define RX8025_BIT_CTRL1_WALE	(1 << 7)
+
+#define RX8025_BIT_CTRL2_DAFG	(1 << 0)
+#define RX8025_BIT_CTRL2_WAFG	(1 << 1)
+#define RX8025_BIT_CTRL2_CTFG	(1 << 2)
+#define RX8025_BIT_CTRL2_PON	(1 << 4)
+#define RX8025_BIT_CTRL2_XST	(1 << 5)
+#define RX8025_BIT_CTRL2_VDET	(1 << 6)
+
+/* Clock precision adjustment */
+#define RX8025_ADJ_RESOLUTION	3050 /* in ppb */
+#define RX8025_ADJ_DATA_MAX	62
+#define RX8025_ADJ_DATA_MIN	-62
+
+static const struct i2c_device_id rx8025_id[] = {
+	{ "rx8025", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rx8025_id);
+
+struct rx8025_data {
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+	struct work_struct work;
+	struct mutex mutex;
+	u8 ctrl1;
+	int exiting;
+};
+
+static irqreturn_t rx8025_irq(int irq, void *dev_id)
+{
+	struct i2c_client *client = dev_id;
+	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
+
+	disable_irq_nosync(irq);
+	schedule_work(&rx8025->work);
+	return IRQ_HANDLED;
+}
+
+static void rx8025_work(struct work_struct *work)
+{
+	struct rx8025_data *rx8025 = container_of(work,
+			struct rx8025_data, work);
+	struct i2c_client *client = rx8025->client;
+	u8 command[2] = {RX8025_REG_CTRL2 << 4 | 0x08,};
+	int ret;
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = command,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(command) - 1,
+			.buf = command + 1,
+		}
+	};
+	u8 status;
+
+	mutex_lock(&rx8025->mutex);
+
+	ret = i2c_transfer(to_i2c_adapter(client->dev.parent),
+			   msg, ARRAY_SIZE(msg));
+	if (ret < ARRAY_SIZE(msg)) {
+		ret = ret >= 0 ? -EIO : ret;
+		goto out;
+	}
+	status = command[1];
+	if (!(status & RX8025_BIT_CTRL2_XST)) {
+		dev_warn(&client->dev, "Oscillation stop was detected,"
+			 "you may have to readjust the clock\n");
+	}
+
+
+	if (status & RX8025_BIT_CTRL2_CTFG) {
+		/* periodic */
+		status &= ~RX8025_BIT_CTRL2_CTFG;
+		local_irq_disable();
+		rtc_update_irq(rx8025->rtc, 1, RTC_PF | RTC_IRQF);
+		local_irq_enable();
+	}
+
+	if (status & RX8025_BIT_CTRL2_DAFG) {
+		/* alarm */
+		status &= RX8025_BIT_CTRL2_DAFG;
+
+		command[0] = RX8025_REG_CTRL1 << 4;
+		command[1] = rx8025->ctrl1 & ~RX8025_BIT_CTRL1_DALE;
+
+
+		ret = i2c_master_send(client, command, sizeof(command));
+		if (ret < sizeof(command)) {
+			ret = ret >= 0 ? -EIO : ret;
+			goto out;
+		}
+		local_irq_disable();
+		rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
+		local_irq_enable();
+	}
+	/* acknowledge IRQ */
+	command[0] = RX8025_REG_CTRL2 << 4;
+	command[1] = status | RX8025_BIT_CTRL2_XST;
+
+	ret = i2c_master_send(client, command, sizeof(command));
+	if (ret < sizeof(command))
+		ret = ret >= 0 ? -EIO : ret;
+	else
+		ret = 0;
+
+
+out:
+	if (!rx8025->exiting)
+		enable_irq(client->irq);
+
+	mutex_unlock(&rx8025->mutex);
+}
+
+static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
+{
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	u8 command = (RX8025_REG_SEC << 4) | 0x08;
+	u8 result[7];
+	int ret;
+	struct i2c_msg msg[] = {
+		{
+			.addr = rx8025->client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &command,
+		},
+		{
+			.addr = rx8025->client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(result),
+			.buf = result,
+		}
+	};
+
+	ret = i2c_transfer(to_i2c_adapter(rx8025->client->dev.parent),
+			   msg, ARRAY_SIZE(msg));
+	if (ret < ARRAY_SIZE(msg))
+		return ret >= 0 ? -EIO : ret;
+
+	dev_dbg(dev, "%s: read 0x%02x 0x%02x "
+		"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", __func__,
+		result[0], result[1], result[2], result[3], result[4],
+		result[5], result[6]);
+
+	dt->tm_sec = bcd2bin(result[RX8025_REG_SEC] & 0x7f);
+	dt->tm_min = bcd2bin(result[RX8025_REG_MIN] & 0x7f);
+	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
+		dt->tm_hour = bcd2bin(result[RX8025_REG_HOUR] & 0x3f);
+	else
+		dt->tm_hour = bcd2bin(result[RX8025_REG_HOUR] & 0x1f) % 12
+			+ (result[RX8025_REG_HOUR] & 0x20 ? 12 : 0);
+
+	dt->tm_mday = bcd2bin(result[RX8025_REG_MDAY] & 0x3f);
+	dt->tm_mon = bcd2bin(result[RX8025_REG_MONTH] & 0x1f) - 1;
+	dt->tm_year = bcd2bin(result[RX8025_REG_YEAR]);
+
+	if (dt->tm_year < 70)
+		dt->tm_year += 100;
+
+	dev_dbg(dev, "%s: result: %ds %dm %dh %dmd %dm %dy\n",
+		__func__,
+		dt->tm_sec, dt->tm_min, dt->tm_hour,
+		dt->tm_mday, dt->tm_mon, dt->tm_year);
+
+	return rtc_valid_tm(dt);
+}
+
+static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
+{
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	u8 command[8] = {RX8025_REG_SEC << 4,};
+	int ret;
+
+	/*
+	 * BUG: The HW assumes every year that is a multiple of 4 to be a leap
+	 * year.  Next time this is wrong is 2100, which will not be a leap
+	 * year.
+	 */
+
+
+	/*
+	 * Here the read-only bits are written as "0".  I'm not sure if that
+	 * is sound.
+	 */
+	command[1 + RX8025_REG_SEC] = bin2bcd(dt->tm_sec);
+	command[1 + RX8025_REG_MIN] = bin2bcd(dt->tm_min);
+	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
+		command[1 + RX8025_REG_HOUR] = bin2bcd(dt->tm_hour);
+	else
+		command[1 + RX8025_REG_HOUR] = (dt->tm_hour >= 12 ? 0x20 : 0) |
+			bin2bcd((dt->tm_hour + 11) % 12 + 1);
+
+	command[1 + RX8025_REG_WDAY] = bin2bcd(dt->tm_wday);
+	command[1 + RX8025_REG_MDAY] = bin2bcd(dt->tm_mday);
+	command[1 + RX8025_REG_MONTH] = bin2bcd(dt->tm_mon + 1);
+	command[1 + RX8025_REG_YEAR] = bin2bcd(dt->tm_year % 100);
+
+	dev_dbg(dev, "%s: send 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
+		"0x%02x 0x%02x\n", __func__,
+		command[0], command[1], command[2], command[3],
+		command[4], command[5], command[6], command[7]);
+
+	ret = i2c_master_send(rx8025->client, command, sizeof(command));
+	if (ret < sizeof(command))
+		return ret >= 0 ? -EIO : ret;
+
+	return 0;
+
+}
+
+static int rx8025_init_client(struct i2c_client *client, int *need_reset)
+{
+	u8 command[3] = {RX8025_REG_CTRL1 << 4 | 0x08,};
+	int ret;
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = command,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(command) - 1,
+			.buf = command + 1,
+		}
+	};
+	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
+	int need_clear = 0;
+
+	ret = i2c_transfer(to_i2c_adapter(client->dev.parent),
+			   msg, ARRAY_SIZE(msg));
+	if (ret < ARRAY_SIZE(msg))
+		return ret >= 0 ? -EIO : ret;
+
+	/* Keep TEST bit zero ! */
+	rx8025->ctrl1 = command[1] & ~RX8025_BIT_CTRL1_TEST;
+
+	if (command[2] & RX8025_BIT_CTRL2_PON) {
+		dev_warn(&client->dev, "power-on reset was detected, "
+			 "you may have to readjust the clock\n");
+		*need_reset = 1;
+	}
+
+	if (command[2] & RX8025_BIT_CTRL2_VDET) {
+		dev_warn(&client->dev, "a power voltage drop was detected, "
+			 "you may have to readjust the clock\n");
+		*need_reset = 1;
+	}
+
+	if (!(command[2] & RX8025_BIT_CTRL2_XST)) {
+		dev_warn(&client->dev, "Oscillation stop was detected,"
+			 "you may have to readjust the clock\n");
+		*need_reset = 1;
+	}
+
+	if (command[2] & (RX8025_BIT_CTRL2_DAFG | RX8025_BIT_CTRL2_WAFG)) {
+		dev_warn(&client->dev, "Alarm was detected\n");
+		need_clear = 1;
+	}
+
+	if (!(command[2] & RX8025_BIT_CTRL2_CTFG))
+		need_clear = 1;
+
+	if (*need_reset || need_clear) {
+		command[1] &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET
+				| RX8025_BIT_CTRL2_CTFG | RX8025_BIT_CTRL2_WAFG
+				| RX8025_BIT_CTRL2_DAFG);
+		command[1] |= RX8025_BIT_CTRL2_XST;
+
+		command[0] = RX8025_REG_CTRL2 << 4;
+
+		ret = i2c_master_send(client, command, 2);
+		if (ret < 2)
+			return ret >= 0 ? -EIO : ret;
+	}
+
+	return 0;
+}
+
+/* Alarm support */
+static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	struct i2c_client *client = rx8025->client;
+	u8 command = (RX8025_REG_ALDMIN << 4) | 0x08;
+	u8 result[2];
+	int ret;
+	u8 ctrl2;
+	u8 ctrl2_cmd = (RX8025_REG_CTRL2 << 4) | 0x08;
+	struct i2c_msg ctrl2_msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &ctrl2_cmd,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(result),
+			.buf = &ctrl2,
+		}
+	};
+	struct i2c_msg msg[] = {
+		{
+			.addr = rx8025->client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &command,
+		},
+		{
+			.addr = rx8025->client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(result),
+			.buf = result,
+		}
+	};
+
+	if (client->irq < 0)
+		return -EINVAL;
+
+	mutex_lock(&rx8025->mutex);
+
+	ret = i2c_transfer(to_i2c_adapter(rx8025->client->dev.parent),
+			   msg, ARRAY_SIZE(msg));
+	if (ret < ARRAY_SIZE(msg)) {
+		ret = ret >= 0 ? -EIO : ret;
+		goto out;
+	}
+
+	ret = i2c_transfer(to_i2c_adapter(rx8025->client->dev.parent),
+			   ctrl2_msg, ARRAY_SIZE(ctrl2_msg));
+	if (ret < ARRAY_SIZE(ctrl2_msg)) {
+		ret = ret >= 0 ? -EIO : ret;
+		goto out;
+	}
+
+	dev_dbg(dev, "%s: read 0x%02x 0x%02x ctrl2: %02x\n", __func__,
+		result[0], result[1], ctrl2);
+
+	/* Hardware alarms precision is 1 minute! */
+	t->time.tm_sec = 0;
+	t->time.tm_min = bcd2bin(result[0] & 0x7f);
+	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
+		t->time.tm_hour = bcd2bin(result[1] & 0x3f);
+	else
+		t->time.tm_hour = bcd2bin(result[1] & 0x1f) % 12
+			+ (result[1] & 0x20 ? 12 : 0);
+
+	if (t->time.tm_min >= 60)
+		t->time.tm_min = -1;
+
+	if (t->time.tm_hour >= 24)
+		t->time.tm_hour = -1;
+
+	t->time.tm_wday = -1;
+	t->time.tm_mday = -1;
+	t->time.tm_mon = -1;
+	t->time.tm_year = -1;
+
+	dev_dbg(dev, "%s: result: %ds %dm %dh %dmd %dm %dy\n",
+		__func__,
+		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
+		t->time.tm_mday, t->time.tm_mon, t->time.tm_year);
+	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
+	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
+	ret = 0;
+out:
+	mutex_unlock(&rx8025->mutex);
+
+	return ret;
+}
+
+static int rx8025_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	u8 command[3] = {RX8025_REG_ALDMIN << 4,};
+	int ret;
+
+	if (client->irq < 0)
+		return -EINVAL;
+
+	if ((t->time.tm_min < 0) || (t->time.tm_min >= 60))
+		return -EINVAL;
+
+	if ((t->time.tm_hour < 0) || (t->time.tm_hour >= 24))
+		return -EINVAL;
+
+	/* Hardware alarms precision is 1 minute! */
+	command[1] = bin2bcd(t->time.tm_min);
+	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
+		command[2] = bin2bcd(t->time.tm_hour);
+	else
+		command[2] = (t->time.tm_hour >= 12 ? 0x20 : 0) |
+			bin2bcd((t->time.tm_hour + 11) % 12 + 1);
+
+	dev_dbg(dev, "%s: send 0x%02x 0x%02x 0x%02x\n", __func__,
+		command[0], command[1], command[2]);
+
+	mutex_lock(&rx8025->mutex);
+
+	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE) {
+		u8 command[2] = {RX8025_REG_CTRL1 << 4, };
+		rx8025->ctrl1 &= ~RX8025_BIT_CTRL1_DALE;
+		command[1] = rx8025->ctrl1;
+		ret = i2c_master_send(rx8025->client, command, sizeof(command));
+		if (ret < sizeof(command)) {
+			ret = ret >= 0 ? -EIO : ret;
+			goto out;
+		}
+	}
+	ret = i2c_master_send(rx8025->client, command, sizeof(command));
+	if (ret < sizeof(command)) {
+		ret = ret >= 0 ? -EIO : ret;
+		goto out;
+	}
+
+	if (t->enabled) {
+		u8 command[2] = {RX8025_REG_CTRL1 << 4, };
+		rx8025->ctrl1 |= RX8025_BIT_CTRL1_DALE;
+		command[1] = rx8025->ctrl1;
+		ret = i2c_master_send(rx8025->client, command, sizeof(command));
+		if (ret < sizeof(command)) {
+			ret = ret >= 0 ? -EIO : ret;
+			goto out;
+		}
+	}
+	ret = 0;
+out:
+	mutex_unlock(&rx8025->mutex);
+	return ret;
+}
+
+static int
+rx8025_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	u8 command[2] = {RX8025_REG_CTRL1 << 4,};
+	u8 reg;
+	int ret = 0;
+
+	mutex_lock(&rx8025->mutex);
+
+	reg = rx8025->ctrl1;
+	switch (cmd) {
+	/* AIE = Alarm Interrupt Enable */
+	case RTC_AIE_OFF:
+		reg &= ~RX8025_BIT_CTRL1_DALE;
+		break;
+	case RTC_AIE_ON:
+		reg |= RX8025_BIT_CTRL1_DALE;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+	}
+	if (ret == 0 && reg != rx8025->ctrl1) {
+		rx8025->ctrl1 = reg;
+		command[1] = rx8025->ctrl1;
+		ret = i2c_master_send(rx8025->client, command, sizeof(command));
+		if (ret < sizeof(command)) {
+			ret = ret >= 0 ? -EIO : ret;
+			goto out;
+		}
+	}
+out:
+	mutex_unlock(&rx8025->mutex);
+
+	return ret;
+}
+
+static int rx8025_irq_set_freq(struct device *dev, int freq)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq < 0)
+		return -ENXIO;
+
+	/* Hardware support 1Hz, 1/60Hz, 1/3600Hz and monthly
+	 * interrupts, but only 1Hz fits on 2^N requirement.
+	 *
+	 * There's also 2Hz 50% duty pulse mode, but it is difficult
+	 * to support as IRQ.
+	 */
+	/* Mark, that frequency can't be changed */
+	return -ENOTTY;
+}
+
+static int rx8025_irq_set_state(struct device *dev, int enabled)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
+	int	ret;
+	u8	reg;
+
+	if (client->irq < 0)
+		return -ENXIO;
+
+	mutex_lock(&rx8025->mutex);
+
+	reg = rx8025->ctrl1;
+	reg &= ~RX8025_BIT_CTRL1_CT;
+	if (enabled)
+		reg |= RX8025_BIT_CTRL1_CT_1HZ;
+	if (reg != rx8025->ctrl1) {
+		u8	command[2];
+
+		rx8025->ctrl1 = reg;
+		command[0] = RX8025_REG_CTRL1 << 4;
+		command[1] = rx8025->ctrl1;
+		ret = i2c_master_send(rx8025->client, command, sizeof(command));
+		if (ret < sizeof(command)) {
+			ret = ret >= 0 ? -EIO : ret;
+			goto out;
+		}
+	}
+	ret = 0;
+out:
+	mutex_unlock(&rx8025->mutex);
+
+	return ret;
+}
+
+static struct rtc_class_ops rx8025_rtc_ops = {
+	.ioctl		= rx8025_ioctl,
+	.read_time	= rx8025_get_time,
+	.set_time	= rx8025_set_time,
+	.read_alarm	= rx8025_read_alarm,
+	.set_alarm	= rx8025_set_alarm,
+	.irq_set_freq   = rx8025_irq_set_freq,
+	.irq_set_state  = rx8025_irq_set_state,
+
+};
+
+/*
+ * Clock precision adjustment support
+ *
+ * According to the RX8025 SA/NB application manual the frequency and
+ * temperature charateristics can be approximated using the following
+ * equation:
+ *
+ *   df = a * (ut - t)**2
+ *
+ *   df: Frequency deviation in any temperature
+ *   a : Coefficient = (-35 +-5) * 10**-9
+ *   ut: Ultimate temperature in degree = +25 +-5 degree
+ *   t : Any temperature in degree
+ *
+ * Note that the clock adjustment in ppb must be entered (which is
+ * the negative value of the deviation).
+ */
+static int rx8025_get_clock_adjust(struct device *dev, int *adj)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 command = RX8025_REG_DIGOFF << 4 | 0x08;
+	u8 result;
+	int ret;
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &command,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(result),
+			.buf = &result,
+		}
+	};
+
+	ret = i2c_transfer(to_i2c_adapter(client->dev.parent),
+			   msg, ARRAY_SIZE(msg));
+	if (ret < ARRAY_SIZE(msg)) {
+		ret = ret >= 0 ? -EIO : ret;
+		return ret;
+	}
+
+	*adj = result >= 64 ? result - 128 : result;
+	if (*adj > 0)
+		(*adj)--;
+	*adj *= -RX8025_ADJ_RESOLUTION;
+
+	return 0;
+}
+
+static int rx8025_set_clock_adjust(struct device *dev, int adj)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 command[2];
+	int ret;
+
+	adj /= -RX8025_ADJ_RESOLUTION;
+	if (adj > RX8025_ADJ_DATA_MAX)
+		adj = RX8025_ADJ_DATA_MAX;
+	else if (adj < RX8025_ADJ_DATA_MIN)
+		adj = RX8025_ADJ_DATA_MIN;
+	else if (adj > 0)
+		adj++;
+	else if (adj < 0)
+		adj += 128;
+
+	command[0] = RX8025_REG_DIGOFF << 4;
+	command[1] = adj;
+
+	dev_dbg(dev, "%s: send 0x%02x 0x%02x\n",
+		__func__, command[0], command[1]);
+
+	ret = i2c_master_send(client, command, sizeof(command));
+	if (ret < sizeof(command))
+		return ret >= 0 ? -EIO : ret;
+
+	return 0;
+}
+
+static ssize_t rx8025_sysfs_show_clock_adjust(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	int err, adj = 0;
+
+	err = rx8025_get_clock_adjust(dev, &adj);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", adj);
+}
+
+static ssize_t rx8025_sysfs_store_clock_adjust(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	int adj, err;
+
+	if (sscanf(buf, "%i", &adj) != 1)
+		return -EINVAL;
+
+	err = rx8025_set_clock_adjust(dev, adj);
+
+	return err ? err : count;
+}
+
+static DEVICE_ATTR(clock_adjust_ppb, S_IRUGO | S_IWUSR,
+		   rx8025_sysfs_show_clock_adjust,
+		   rx8025_sysfs_store_clock_adjust);
+
+static int rx8025_sysfs_register(struct device *dev)
+{
+	return device_create_file(dev, &dev_attr_clock_adjust_ppb);
+}
+
+static void rx8025_sysfs_unregister(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_clock_adjust_ppb);
+}
+
+static int __devinit rx8025_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct rx8025_data *rx8025;
+	int i, err, need_reset = 0;
+	u8 command = 0x08;
+	u8 result[RX8025_REG_YEAR + 1];
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &command,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(result),
+			.buf = result,
+		}
+	};
+	u8 zero_mask[] = {
+		0x80,	/* seconds */
+		0x80,	/* minutes */
+		0xC0,	/* hours */
+		0xF8,	/* days */
+		0xC0,	/* days */
+		0x60,	/* months */
+		0x00,	/* years */
+	};
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+		dev_err(&adapter->dev, "doesn't support full I2C\n");
+		err = -EIO;
+		goto errout;
+	}
+
+	rx8025 = kzalloc(sizeof(*rx8025), GFP_KERNEL);
+	if (!rx8025) {
+		dev_err(&adapter->dev, "failed to alloc memory\n");
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	rx8025->client = client;
+	i2c_set_clientdata(client, rx8025);
+	INIT_WORK(&rx8025->work, rx8025_work);
+	mutex_init(&rx8025->mutex);
+
+	err = i2c_transfer(adapter, msg, ARRAY_SIZE(msg));
+	if (err < ARRAY_SIZE(msg)) {
+		err = err >= 0 ? 0 : err;
+		goto errout_free;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(zero_mask); ++i) {
+		if (result[i] & zero_mask[i]) {
+			dev_dbg(&adapter->dev, "%s: register=0x%02x, "
+				"value=0x%02x\n", __func__,
+				i, result[i]);
+			err = -ENODEV;
+			goto errout_free;
+		}
+	}
+
+	err = rx8025_init_client(client, &need_reset);
+	if (err)
+		goto errout_free;
+
+	rx8025->rtc = rtc_device_register(client->name, &client->dev,
+					  &rx8025_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rx8025->rtc)) {
+		err = PTR_ERR(rx8025->rtc);
+		dev_err(&client->dev,
+			"unable to register the class device\n");
+		goto errout_free;
+	}
+
+	dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
+	if (client->irq >= 0) {
+		err = request_irq(client->irq, rx8025_irq, 0,
+			"rx8025", client);
+		if (err) {
+			dev_err(&client->dev, "unable to request IRQ\n");
+			goto errout_reg;
+		}
+	}
+
+
+	rx8025->rtc->irq_freq = 1;
+	rx8025->rtc->max_user_freq = 1;
+
+	err = rx8025_sysfs_register(&client->dev);
+	if (err)
+		goto errout_irq;
+
+	dev_info(&client->dev, "chip found\n");
+
+	if (need_reset) {
+		struct rtc_time tm;
+		dev_info(&client->dev,
+			 "Bad conditions detected, resetting date\n");
+		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
+		rx8025_set_time(&client->dev, &tm);
+	}
+	return 0;
+
+ errout_reg:
+	rtc_device_unregister(rx8025->rtc);
+
+ errout_irq:
+	if (client->irq >= 0)
+		free_irq(client->irq, client);
+
+ errout_free:
+	kfree(rx8025);
+
+ errout:
+	dev_err(&adapter->dev, "Probing for rx8025 failed\n");
+	return err;
+}
+
+static int __devexit rx8025_remove(struct i2c_client *client)
+{
+	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
+
+	if (client->irq >= 0) {
+		mutex_lock(&rx8025->mutex);
+		rx8025->exiting = 1;
+		mutex_unlock(&rx8025->mutex);
+
+		free_irq(client->irq, client);
+		flush_scheduled_work();
+	}
+
+	rx8025_sysfs_unregister(&client->dev);
+	rtc_device_unregister(rx8025->rtc);
+	i2c_set_clientdata(client, NULL);
+	kfree(rx8025);
+	return 0;
+}
+
+static struct i2c_driver rx8025_driver = {
+	.driver = {
+		.name = "rtc-rx8025",
+		.owner = THIS_MODULE,
+	},
+	.probe		= rx8025_probe,
+	.remove		= __devexit_p(rx8025_remove),
+	.id_table	= rx8025_id,
+};
+
+static int __init rx8025_init(void)
+{
+	return i2c_add_driver(&rx8025_driver);
+}
+
+static void __exit rx8025_exit(void)
+{
+	i2c_del_driver(&rx8025_driver);
+}
+
+MODULE_AUTHOR("Uwe Zeisberger <Uwe_Zeisberger <at> digi.com>"
+	      " and modified by fengjh <at> rising.com.cn");
+MODULE_DESCRIPTION("RX-8025 SA/NB RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(rx8025_init);
+module_exit(rx8025_exit);
