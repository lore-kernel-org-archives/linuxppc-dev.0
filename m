Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65A92B7F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:23:58 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A0377DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 07:23:57 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Wed,  9 Sep 2009 23:22:49 +0200
Message-Id: <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
Cc: linux-mips@linux-mips.org, Bart Van Assche <bart.vanassche@gmail.com>,
	linuxppc-dev@ozlabs.org, Jean Delvare <khali@linux-fr.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pcf8575-driver in drivers/i2c/chips which just exports its register to
sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses the gpiolib.
As this driver has been deprecated for more than a year, finally remove it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 Documentation/i2c/chips/pcf8575 |   69 --------------
 drivers/i2c/chips/Kconfig       |   18 ----
 drivers/i2c/chips/Makefile      |    1 -
 drivers/i2c/chips/pcf8575.c     |  198 ---------------------------------------
 4 files changed, 0 insertions(+), 286 deletions(-)
 delete mode 100644 Documentation/i2c/chips/pcf8575
 delete mode 100644 drivers/i2c/chips/pcf8575.c

diff --git a/Documentation/i2c/chips/pcf8575 b/Documentation/i2c/chips/pcf8575
deleted file mode 100644
index 40b268e..0000000
--- a/Documentation/i2c/chips/pcf8575
+++ /dev/null
@@ -1,69 +0,0 @@
-About the PCF8575 chip and the pcf8575 kernel driver
-====================================================
-
-The PCF8575 chip is produced by the following manufacturers:
-
-  * Philips NXP
-    http://www.nxp.com/#/pip/cb=[type=product,path=50807/41735/41850,final=PCF8575_3]|pip=[pip=PCF8575_3][0]
-
-  * Texas Instruments
-    http://focus.ti.com/docs/prod/folders/print/pcf8575.html
-
-
-Some vendors sell small PCB's with the PCF8575 mounted on it. You can connect
-such a board to a Linux host via e.g. an USB to I2C interface. Examples of
-PCB boards with a PCF8575:
-
-  * SFE Breakout Board for PCF8575 I2C Expander by RobotShop
-    http://www.robotshop.ca/home/products/robot-parts/electronics/adapters-converters/sfe-pcf8575-i2c-expander-board.html
-
-  * Breakout Board for PCF8575 I2C Expander by Spark Fun Electronics
-    http://www.sparkfun.com/commerce/product_info.php?products_id=8130
-
-
-Description
------------
-The PCF8575 chip is a 16-bit I/O expander for the I2C bus. Up to eight of
-these chips can be connected to the same I2C bus. You can find this
-chip on some custom designed hardware, but you won't find it on PC
-motherboards.
-
-The PCF8575 chip consists of a 16-bit quasi-bidirectional port and an I2C-bus
-interface. Each of the sixteen I/O's can be independently used as an input or
-an output. To set up an I/O pin as an input, you have to write a 1 to the
-corresponding output.
-
-For more information please see the datasheet.
-
-
-Detection
----------
-
-There is no method known to detect whether a chip on a given I2C address is
-a PCF8575 or whether it is any other I2C device, so you have to pass the I2C
-bus and address of the installed PCF8575 devices explicitly to the driver at
-load time via the force=... parameter.
-
-/sys interface
---------------
-
-For each address on which a PCF8575 chip was found or forced the following
-files will be created under /sys:
-* /sys/bus/i2c/devices/<bus>-<address>/read
-* /sys/bus/i2c/devices/<bus>-<address>/write
-where bus is the I2C bus number (0, 1, ...) and address is the four-digit
-hexadecimal representation of the 7-bit I2C address of the PCF8575
-(0020 .. 0027).
-
-The read file is read-only. Reading it will trigger an I2C read and will hence
-report the current input state for the pins configured as inputs, and the
-current output value for the pins configured as outputs.
-
-The write file is read-write. Writing a value to it will configure all pins
-as output for which the corresponding bit is zero. Reading the write file will
-return the value last written, or -EAGAIN if no value has yet been written to
-the write file.
-
-On module initialization the configuration of the chip is not changed -- the
-chip is left in the state it was already configured in through either power-up
-or through previous I2C write actions.
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 02d746c..1b5455e 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -33,24 +33,6 @@ config SENSORS_PCF8574
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
-config PCF8575
-	tristate "Philips PCF8575 (DEPRECATED)"
-	default n
-	depends on GPIO_PCF857X = "n"
-	help
-	  If you say yes here you get support for Philips PCF8575 chip.
-	  This chip is a 16-bit I/O expander for the I2C bus.  Several other
-	  chip manufacturers sell equivalent chips, e.g. Texas Instruments.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called pcf8575.
-
-	  This driver is deprecated and will be dropped soon. Use
-	  drivers/gpio/pcf857x.c instead.
-
-	  This device is hard to detect and is rarely found on mainstream
-	  hardware.  If unsure, say N.
-
 config SENSORS_PCA9539
 	tristate "Philips PCA9539 16-bit I/O port (DEPRECATED)"
 	depends on EXPERIMENTAL && GPIO_PCA953X = "n"
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index f4680d1..fceb377 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -13,7 +13,6 @@
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
-obj-$(CONFIG_PCF8575)		+= pcf8575.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
diff --git a/drivers/i2c/chips/pcf8575.c b/drivers/i2c/chips/pcf8575.c
deleted file mode 100644
index 07fd7cb..0000000
--- a/drivers/i2c/chips/pcf8575.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
-  pcf8575.c
-
-  About the PCF8575 chip: the PCF8575 is a 16-bit I/O expander for the I2C bus
-  produced by a.o. Philips Semiconductors.
-
-  Copyright (C) 2006 Michael Hennerich, Analog Devices Inc.
-  <hennerich@blackfin.uclinux.org>
-  Based on pcf8574.c.
-
-  Copyright (c) 2007 Bart Van Assche <bart.vanassche@gmail.com>.
-  Ported this driver from ucLinux to the mainstream Linux kernel.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of the GNU General Public License as published by
-  the Free Software Foundation; either version 2 of the License, or
-  (at your option) any later version.
-
-  This program is distributed in the hope that it will be useful,
-  but WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-  GNU General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/slab.h>  /* kzalloc() */
-#include <linux/sysfs.h> /* sysfs_create_group() */
-
-/* Addresses to scan: none, device can't be detected */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD;
-
-
-/* Each client has this additional data */
-struct pcf8575_data {
-	int write;		/* last written value, or error code */
-};
-
-/* following are the sysfs callback functions */
-static ssize_t show_read(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	u16 val;
-	u8 iopin_state[2];
-
-	i2c_master_recv(client, iopin_state, 2);
-
-	val = iopin_state[0];
-	val |= iopin_state[1] << 8;
-
-	return sprintf(buf, "%u\n", val);
-}
-
-static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
-
-static ssize_t show_write(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct pcf8575_data *data = dev_get_drvdata(dev);
-	if (data->write < 0)
-		return data->write;
-	return sprintf(buf, "%d\n", data->write);
-}
-
-static ssize_t set_write(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8575_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-	u8 iopin_state[2];
-
-	if (val > 0xffff)
-		return -EINVAL;
-
-	data->write = val;
-
-	iopin_state[0] = val & 0xFF;
-	iopin_state[1] = val >> 8;
-
-	i2c_master_send(client, iopin_state, 2);
-
-	return count;
-}
-
-static DEVICE_ATTR(write, S_IWUSR | S_IRUGO, show_write, set_write);
-
-static struct attribute *pcf8575_attributes[] = {
-	&dev_attr_read.attr,
-	&dev_attr_write.attr,
-	NULL
-};
-
-static const struct attribute_group pcf8575_attr_group = {
-	.attrs = pcf8575_attributes,
-};
-
-/*
- * Real code
- */
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int pcf8575_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
-		return -ENODEV;
-
-	/* This is the place to detect whether the chip at the specified
-	   address really is a PCF8575 chip. However, there is no method known
-	   to detect whether an I2C chip is a PCF8575 or any other I2C chip. */
-
-	strlcpy(info->type, "pcf8575", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int pcf8575_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct pcf8575_data *data;
-	int err;
-
-	data = kzalloc(sizeof(struct pcf8575_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	i2c_set_clientdata(client, data);
-	data->write = -EAGAIN;
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &pcf8575_attr_group);
-	if (err)
-		goto exit_free;
-
-	return 0;
-
-exit_free:
-	kfree(data);
-exit:
-	return err;
-}
-
-static int pcf8575_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &pcf8575_attr_group);
-	kfree(i2c_get_clientdata(client));
-	return 0;
-}
-
-static const struct i2c_device_id pcf8575_id[] = {
-	{ "pcf8575", 0 },
-	{ }
-};
-
-static struct i2c_driver pcf8575_driver = {
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= "pcf8575",
-	},
-	.probe		= pcf8575_probe,
-	.remove		= pcf8575_remove,
-	.id_table	= pcf8575_id,
-
-	.detect		= pcf8575_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init pcf8575_init(void)
-{
-	return i2c_add_driver(&pcf8575_driver);
-}
-
-static void __exit pcf8575_exit(void)
-{
-	i2c_del_driver(&pcf8575_driver);
-}
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>, "
-	      "Bart Van Assche <bart.vanassche@gmail.com>");
-MODULE_DESCRIPTION("pcf8575 driver");
-MODULE_LICENSE("GPL");
-
-module_init(pcf8575_init);
-module_exit(pcf8575_exit);
-- 
1.6.3.3
