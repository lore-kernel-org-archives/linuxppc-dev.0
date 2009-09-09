Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DE8EB80AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:24:04 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8445ADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 07:24:03 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Wed,  9 Sep 2009 23:22:50 +0200
Message-Id: <1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 3/4] i2c/chips: Remove deprecated pca9539-driver
Cc: linux-mips@linux-mips.org, Ben Gardner <gardner.ben@gmail.com>,
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

The pca9539-driver in drivers/i2c/chips which just exports its registers to
sysfs is superseeded by drivers/gpio/pca953x.c which properly uses the gpiolib.
As this driver has been deprecated for more than a year, finally remove it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Ben Gardner <gardner.ben@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 Documentation/i2c/chips/pca9539 |   58 ---------------
 drivers/i2c/chips/Kconfig       |   13 ----
 drivers/i2c/chips/Makefile      |    1 -
 drivers/i2c/chips/pca9539.c     |  152 ---------------------------------------
 4 files changed, 0 insertions(+), 224 deletions(-)
 delete mode 100644 Documentation/i2c/chips/pca9539
 delete mode 100644 drivers/i2c/chips/pca9539.c

diff --git a/Documentation/i2c/chips/pca9539 b/Documentation/i2c/chips/pca9539
deleted file mode 100644
index 6aff890..0000000
--- a/Documentation/i2c/chips/pca9539
+++ /dev/null
@@ -1,58 +0,0 @@
-Kernel driver pca9539
-=====================
-
-NOTE: this driver is deprecated and will be dropped soon, use
-drivers/gpio/pca9539.c instead.
-
-Supported chips:
-  * Philips PCA9539
-    Prefix: 'pca9539'
-    Addresses scanned: none
-    Datasheet:
-        http://www.semiconductors.philips.com/acrobat/datasheets/PCA9539_2.pdf
-
-Author: Ben Gardner <bgardner@wabtec.com>
-
-
-Description
------------
-
-The Philips PCA9539 is a 16 bit low power I/O device.
-All 16 lines can be individually configured as an input or output.
-The input sense can also be inverted.
-The 16 lines are split between two bytes.
-
-
-Detection
----------
-
-The PCA9539 is difficult to detect and not commonly found in PC machines,
-so you have to pass the I2C bus and address of the installed PCA9539
-devices explicitly to the driver at load time via the force=... parameter.
-
-
-Sysfs entries
--------------
-
-Each is a byte that maps to the 8 I/O bits.
-A '0' suffix is for bits 0-7, while '1' is for bits 8-15.
-
-input[01]     - read the current value
-output[01]    - sets the output value
-direction[01] - direction of each bit: 1=input, 0=output
-invert[01]    - toggle the input bit sense
-
-input reads the actual state of the line and is always available.
-The direction defaults to input for all channels.
-
-
-General Remarks
----------------
-
-Note that each output, direction, and invert entry controls 8 lines.
-You should use the read, modify, write sequence.
-For example. to set output bit 0 of 1.
-  val=$(cat output0)
-  val=$(( $val | 1 ))
-  echo $val > output0
-
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 1b5455e..8cd1a7f 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -33,19 +33,6 @@ config SENSORS_PCF8574
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
-config SENSORS_PCA9539
-	tristate "Philips PCA9539 16-bit I/O port (DEPRECATED)"
-	depends on EXPERIMENTAL && GPIO_PCA953X = "n"
-	help
-	  If you say yes here you get support for the Philips PCA9539
-	  16-bit I/O port.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called pca9539.
-
-	  This driver is deprecated and will be dropped soon. Use
-	  drivers/gpio/pca953x.c instead.
-
 config SENSORS_TSL2550
 	tristate "Taos TSL2550 ambient light sensor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index fceb377..8cd778d 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,7 +11,6 @@
 #
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
-obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
deleted file mode 100644
index 270de4e..0000000
--- a/drivers/i2c/chips/pca9539.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
-    pca9539.c - 16-bit I/O port with interrupt and reset
-
-    Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; version 2 of the License.
-*/
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/hwmon-sysfs.h>
-
-/* Addresses to scan: none, device is not autodetected */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(pca9539);
-
-enum pca9539_cmd
-{
-	PCA9539_INPUT_0		= 0,
-	PCA9539_INPUT_1		= 1,
-	PCA9539_OUTPUT_0	= 2,
-	PCA9539_OUTPUT_1	= 3,
-	PCA9539_INVERT_0	= 4,
-	PCA9539_INVERT_1	= 5,
-	PCA9539_DIRECTION_0	= 6,
-	PCA9539_DIRECTION_1	= 7,
-};
-
-/* following are the sysfs callback functions */
-static ssize_t pca9539_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(client,
-							     psa->index));
-}
-
-static ssize_t pca9539_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
-{
-	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	unsigned long val = simple_strtoul(buf, NULL, 0);
-	if (val > 0xff)
-		return -EINVAL;
-	i2c_smbus_write_byte_data(client, psa->index, val);
-	return count;
-}
-
-/* Define the device attributes */
-
-#define PCA9539_ENTRY_RO(name, cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, pca9539_show, NULL, cmd_idx)
-
-#define PCA9539_ENTRY_RW(name, cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, pca9539_show, \
-				  pca9539_store, cmd_idx)
-
-PCA9539_ENTRY_RO(input0, PCA9539_INPUT_0);
-PCA9539_ENTRY_RO(input1, PCA9539_INPUT_1);
-PCA9539_ENTRY_RW(output0, PCA9539_OUTPUT_0);
-PCA9539_ENTRY_RW(output1, PCA9539_OUTPUT_1);
-PCA9539_ENTRY_RW(invert0, PCA9539_INVERT_0);
-PCA9539_ENTRY_RW(invert1, PCA9539_INVERT_1);
-PCA9539_ENTRY_RW(direction0, PCA9539_DIRECTION_0);
-PCA9539_ENTRY_RW(direction1, PCA9539_DIRECTION_1);
-
-static struct attribute *pca9539_attributes[] = {
-	&sensor_dev_attr_input0.dev_attr.attr,
-	&sensor_dev_attr_input1.dev_attr.attr,
-	&sensor_dev_attr_output0.dev_attr.attr,
-	&sensor_dev_attr_output1.dev_attr.attr,
-	&sensor_dev_attr_invert0.dev_attr.attr,
-	&sensor_dev_attr_invert1.dev_attr.attr,
-	&sensor_dev_attr_direction0.dev_attr.attr,
-	&sensor_dev_attr_direction1.dev_attr.attr,
-	NULL
-};
-
-static struct attribute_group pca9539_defattr_group = {
-	.attrs = pca9539_attributes,
-};
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int pca9539_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
-
-	strlcpy(info->type, "pca9539", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int pca9539_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	/* Register sysfs hooks */
-	return sysfs_create_group(&client->dev.kobj,
-				  &pca9539_defattr_group);
-}
-
-static int pca9539_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &pca9539_defattr_group);
-	return 0;
-}
-
-static const struct i2c_device_id pca9539_id[] = {
-	{ "pca9539", 0 },
-	{ }
-};
-
-static struct i2c_driver pca9539_driver = {
-	.driver = {
-		.name	= "pca9539",
-	},
-	.probe		= pca9539_probe,
-	.remove		= pca9539_remove,
-	.id_table	= pca9539_id,
-
-	.detect		= pca9539_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init pca9539_init(void)
-{
-	return i2c_add_driver(&pca9539_driver);
-}
-
-static void __exit pca9539_exit(void)
-{
-	i2c_del_driver(&pca9539_driver);
-}
-
-MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
-MODULE_DESCRIPTION("PCA9539 driver");
-MODULE_LICENSE("GPL");
-
-module_init(pca9539_init);
-module_exit(pca9539_exit);
-
-- 
1.6.3.3
