Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DD28CB7DC4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 07:24:08 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2D079DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 07:24:08 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Wed,  9 Sep 2009 23:22:51 +0200
Message-Id: <1252531371-14866-5-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 4/4] i2c/chips: Remove deprecated pcf8574-driver
Cc: linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Jean Delvare <khali@linux-fr.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Aurelien Jarno <aurelien@aurel32.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pcf8574-driver in drivers/i2c/chips which just exports its register to
sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses the gpiolib.
As this driver has been deprecated for more than a year, finally remove it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 Documentation/i2c/chips/pcf8574 |   65 ------------
 drivers/i2c/chips/Kconfig       |   17 ---
 drivers/i2c/chips/Makefile      |    1 -
 drivers/i2c/chips/pcf8574.c     |  215 ---------------------------------------
 4 files changed, 0 insertions(+), 298 deletions(-)
 delete mode 100644 Documentation/i2c/chips/pcf8574
 delete mode 100644 drivers/i2c/chips/pcf8574.c

diff --git a/Documentation/i2c/chips/pcf8574 b/Documentation/i2c/chips/pcf8574
deleted file mode 100644
index 235815c..0000000
--- a/Documentation/i2c/chips/pcf8574
+++ /dev/null
@@ -1,65 +0,0 @@
-Kernel driver pcf8574
-=====================
-
-Supported chips:
-  * Philips PCF8574
-    Prefix: 'pcf8574'
-    Addresses scanned: none
-    Datasheet: Publicly available at the Philips Semiconductors website
-               http://www.semiconductors.philips.com/pip/PCF8574P.html
-
- * Philips PCF8574A
-    Prefix: 'pcf8574a'
-    Addresses scanned: none
-    Datasheet: Publicly available at the Philips Semiconductors website
-               http://www.semiconductors.philips.com/pip/PCF8574P.html
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Dan Eaton <dan.eaton@rocketlogix.com>,
-        Aurelien Jarno <aurelien@aurel32.net>,
-        Jean Delvare <khali@linux-fr.org>,
-
-
-Description
------------
-The PCF8574(A) is an 8-bit I/O expander for the I2C bus produced by Philips
-Semiconductors. It is designed to provide a byte I2C interface to up to 16
-separate devices (8 x PCF8574 and 8 x PCF8574A).
-
-This device consists of a quasi-bidirectional port. Each of the eight I/Os
-can be independently used as an input or output. To setup an I/O as an
-input, you have to write a 1 to the corresponding output.
-
-For more informations see the datasheet.
-
-
-Accessing PCF8574(A) via /sys interface
--------------------------------------
-
-The PCF8574(A) is plainly impossible to detect ! Stupid chip.
-So, you have to pass the I2C bus and address of the installed PCF857A
-and PCF8574A devices explicitly to the driver at load time via the
-force=... parameter.
-
-On detection (i.e. insmod, modprobe et al.), directories are being
-created for each detected PCF8574(A):
-
-/sys/bus/i2c/devices/<0>-<1>/
-where <0> is the bus the chip was detected on (e. g. i2c-0)
-and <1> the chip address ([20..27] or [38..3f]):
-
-(example: /sys/bus/i2c/devices/1-0020/)
-
-Inside these directories, there are two files each:
-read and write (and one file with chip name).
-
-The read file is read-only. Reading gives you the current I/O input
-if the corresponding output is set as 1, otherwise the current output
-value, that is to say 0.
-
-The write file is read/write. Writing a value outputs it on the I/O
-port. Reading returns the last written value. As it is not possible
-to read this value from the chip, you need to write at least once to
-this file before you can read back from it.
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 8cd1a7f..f9618f4 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -16,23 +16,6 @@ config DS1682
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1682.
 
-config SENSORS_PCF8574
-	tristate "Philips PCF8574 and PCF8574A (DEPRECATED)"
-	depends on EXPERIMENTAL && GPIO_PCF857X = "n"
-	default n
-	help
-	  If you say yes here you get support for Philips PCF8574 and 
-	  PCF8574A chips. These chips are 8-bit I/O expanders for the I2C bus.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called pcf8574.
-
-	  This driver is deprecated and will be dropped soon. Use
-	  drivers/gpio/pcf857x.c instead.
-
-	  These devices are hard to detect and rarely found on mainstream
-	  hardware.  If unsure, say N.
-
 config SENSORS_TSL2550
 	tristate "Taos TSL2550 ambient light sensor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 8cd778d..749cf36 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,7 +11,6 @@
 #
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
-obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
deleted file mode 100644
index 6ec3098..0000000
--- a/drivers/i2c/chips/pcf8574.c
+++ /dev/null
@@ -1,215 +0,0 @@
-/*
-    Copyright (c) 2000  Frodo Looijaard <frodol@dds.nl>, 
-                        Philip Edelbrock <phil@netroedge.com>,
-                        Dan Eaton <dan.eaton@rocketlogix.com>
-    Ported to Linux 2.6 by Aurelien Jarno <aurel32@debian.org> with 
-    the help of Jean Delvare <khali@linux-fr.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-    
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-/* A few notes about the PCF8574:
-
-* The PCF8574 is an 8-bit I/O expander for the I2C bus produced by
-  Philips Semiconductors.  It is designed to provide a byte I2C
-  interface to up to 8 separate devices.
-  
-* The PCF8574 appears as a very simple SMBus device which can be
-  read from or written to with SMBUS byte read/write accesses.
-
-  --Dan
-
-*/
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-
-/* Addresses to scan: none, device can't be detected */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(pcf8574, pcf8574a);
-
-/* Each client has this additional data */
-struct pcf8574_data {
-	int write;			/* Remember last written value */
-};
-
-static void pcf8574_init_client(struct i2c_client *client);
-
-/* following are the sysfs callback functions */
-static ssize_t show_read(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	return sprintf(buf, "%u\n", i2c_smbus_read_byte(client));
-}
-
-static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
-
-static ssize_t show_write(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pcf8574_data *data = i2c_get_clientdata(to_i2c_client(dev));
-
-	if (data->write < 0)
-		return data->write;
-
-	return sprintf(buf, "%d\n", data->write);
-}
-
-static ssize_t set_write(struct device *dev, struct device_attribute *attr, const char *buf,
-			 size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-
-	if (val > 0xff)
-		return -EINVAL;
-
-	data->write = val;
-	i2c_smbus_write_byte(client, data->write);
-	return count;
-}
-
-static DEVICE_ATTR(write, S_IWUSR | S_IRUGO, show_write, set_write);
-
-static struct attribute *pcf8574_attributes[] = {
-	&dev_attr_read.attr,
-	&dev_attr_write.attr,
-	NULL
-};
-
-static const struct attribute_group pcf8574_attr_group = {
-	.attrs = pcf8574_attributes,
-};
-
-/*
- * Real code
- */
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int pcf8574_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	const char *client_name;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-		return -ENODEV;
-
-	/* Now, we would do the remaining detection. But the PCF8574 is plainly
-	   impossible to detect! Stupid chip. */
-
-	/* Determine the chip type */
-	if (kind <= 0) {
-		if (client->addr >= 0x38 && client->addr <= 0x3f)
-			kind = pcf8574a;
-		else
-			kind = pcf8574;
-	}
-
-	if (kind == pcf8574a)
-		client_name = "pcf8574a";
-	else
-		client_name = "pcf8574";
-	strlcpy(info->type, client_name, I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int pcf8574_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct pcf8574_data *data;
-	int err;
-
-	data = kzalloc(sizeof(struct pcf8574_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	i2c_set_clientdata(client, data);
-
-	/* Initialize the PCF8574 chip */
-	pcf8574_init_client(client);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &pcf8574_attr_group);
-	if (err)
-		goto exit_free;
-	return 0;
-
-      exit_free:
-	kfree(data);
-      exit:
-	return err;
-}
-
-static int pcf8574_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &pcf8574_attr_group);
-	kfree(i2c_get_clientdata(client));
-	return 0;
-}
-
-/* Called when we have found a new PCF8574. */
-static void pcf8574_init_client(struct i2c_client *client)
-{
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->write = -EAGAIN;
-}
-
-static const struct i2c_device_id pcf8574_id[] = {
-	{ "pcf8574", 0 },
-	{ "pcf8574a", 0 },
-	{ }
-};
-
-static struct i2c_driver pcf8574_driver = {
-	.driver = {
-		.name	= "pcf8574",
-	},
-	.probe		= pcf8574_probe,
-	.remove		= pcf8574_remove,
-	.id_table	= pcf8574_id,
-
-	.detect		= pcf8574_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init pcf8574_init(void)
-{
-	return i2c_add_driver(&pcf8574_driver);
-}
-
-static void __exit pcf8574_exit(void)
-{
-	i2c_del_driver(&pcf8574_driver);
-}
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, "
-     "Philip Edelbrock <phil@netroedge.com>, "
-     "Dan Eaton <dan.eaton@rocketlogix.com> "
-     "and Aurelien Jarno <aurelien@aurel32.net>");
-MODULE_DESCRIPTION("PCF8574 driver");
-MODULE_LICENSE("GPL");
-
-module_init(pcf8574_init);
-module_exit(pcf8574_exit);
-- 
1.6.3.3
