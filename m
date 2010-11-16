Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79817B7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 15:33:56 +1100 (EST)
Subject: Re: [PATCH] Move ams driver to macintosh
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20101005121043.08771994@endymion.delvare>
References: <20101005121043.08771994@endymion.delvare>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Nov 2010 15:33:25 +1100
Message-ID: <1289882005.2147.1489.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Stelian Pop <stelian@popies.net>, linuxppc-dev@lists.ozlabs.org,
	Guenter Roeck <guenter.roeck@ericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-05 at 12:10 +0200, Jean Delvare wrote:
> The ams driver isn't a hardware monitoring driver, so it shouldn't
> live under driver/hwmon. drivers/macintosh seems much more
> appropriate, as the driver is only useful on PowerBooks and iBooks.

Going through backlog... Do you want me to carry this in powerpc or
you'll deal with it directly ?

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Stelian Pop <stelian@popies.net>
> Cc: Michael Hanselmann <linux-kernel@hansmi.ch>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  MAINTAINERS                       |    2 
>  drivers/hwmon/Kconfig             |   26 ---
>  drivers/hwmon/Makefile            |    1 
>  drivers/hwmon/ams/Makefile        |    8 -
>  drivers/hwmon/ams/ams-core.c      |  250 ---------------------------------
>  drivers/hwmon/ams/ams-i2c.c       |  277 -------------------------------------
>  drivers/hwmon/ams/ams-input.c     |  157 --------------------
>  drivers/hwmon/ams/ams-pmu.c       |  201 --------------------------
>  drivers/hwmon/ams/ams.h           |   70 ---------
>  drivers/macintosh/Kconfig         |   26 +++
>  drivers/macintosh/Makefile        |    2 
>  drivers/macintosh/ams/Makefile    |    8 +
>  drivers/macintosh/ams/ams-core.c  |  250 +++++++++++++++++++++++++++++++++
>  drivers/macintosh/ams/ams-i2c.c   |  277 +++++++++++++++++++++++++++++++++++++
>  drivers/macintosh/ams/ams-input.c |  157 ++++++++++++++++++++
>  drivers/macintosh/ams/ams-pmu.c   |  201 ++++++++++++++++++++++++++
>  drivers/macintosh/ams/ams.h       |   70 +++++++++
>  17 files changed, 992 insertions(+), 991 deletions(-)
> 
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/Makefile	2010-08-02 00:11:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,8 +0,0 @@
> -#
> -# Makefile for Apple Motion Sensor driver
> -#
> -
> -ams-y					:= ams-core.o ams-input.o
> -ams-$(CONFIG_SENSORS_AMS_PMU)		+= ams-pmu.o
> -ams-$(CONFIG_SENSORS_AMS_I2C)		+= ams-i2c.o
> -obj-$(CONFIG_SENSORS_AMS)		+= ams.o
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/ams-core.c	2010-08-02 00:11:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,250 +0,0 @@
> -/*
> - * Apple Motion Sensor driver
> - *
> - * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> - * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/of_platform.h>
> -#include <asm/pmac_pfunc.h>
> -
> -#include "ams.h"
> -
> -/* There is only one motion sensor per machine */
> -struct ams ams_info;
> -
> -static unsigned int verbose;
> -module_param(verbose, bool, 0644);
> -MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
> -
> -/* Call with ams_info.lock held! */
> -void ams_sensors(s8 *x, s8 *y, s8 *z)
> -{
> -	u32 orient = ams_info.vflag? ams_info.orient1 : ams_info.orient2;
> -
> -	if (orient & 0x80)
> -		/* X and Y swapped */
> -		ams_info.get_xyz(y, x, z);
> -	else
> -		ams_info.get_xyz(x, y, z);
> -
> -	if (orient & 0x04)
> -		*z = ~(*z);
> -	if (orient & 0x02)
> -		*y = ~(*y);
> -	if (orient & 0x01)
> -		*x = ~(*x);
> -}
> -
> -static ssize_t ams_show_current(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	s8 x, y, z;
> -
> -	mutex_lock(&ams_info.lock);
> -	ams_sensors(&x, &y, &z);
> -	mutex_unlock(&ams_info.lock);
> -
> -	return snprintf(buf, PAGE_SIZE, "%d %d %d\n", x, y, z);
> -}
> -
> -static DEVICE_ATTR(current, S_IRUGO, ams_show_current, NULL);
> -
> -static void ams_handle_irq(void *data)
> -{
> -	enum ams_irq irq = *((enum ams_irq *)data);
> -
> -	spin_lock(&ams_info.irq_lock);
> -
> -	ams_info.worker_irqs |= irq;
> -	schedule_work(&ams_info.worker);
> -
> -	spin_unlock(&ams_info.irq_lock);
> -}
> -
> -static enum ams_irq ams_freefall_irq_data = AMS_IRQ_FREEFALL;
> -static struct pmf_irq_client ams_freefall_client = {
> -	.owner = THIS_MODULE,
> -	.handler = ams_handle_irq,
> -	.data = &ams_freefall_irq_data,
> -};
> -
> -static enum ams_irq ams_shock_irq_data = AMS_IRQ_SHOCK;
> -static struct pmf_irq_client ams_shock_client = {
> -	.owner = THIS_MODULE,
> -	.handler = ams_handle_irq,
> -	.data = &ams_shock_irq_data,
> -};
> -
> -/* Once hard disk parking is implemented in the kernel, this function can
> - * trigger it.
> - */
> -static void ams_worker(struct work_struct *work)
> -{
> -	unsigned long flags;
> -	u8 irqs_to_clear;
> -
> -	mutex_lock(&ams_info.lock);
> -
> -	spin_lock_irqsave(&ams_info.irq_lock, flags);
> -	irqs_to_clear = ams_info.worker_irqs;
> -
> -	if (ams_info.worker_irqs & AMS_IRQ_FREEFALL) {
> -		if (verbose)
> -			printk(KERN_INFO "ams: freefall detected!\n");
> -
> -		ams_info.worker_irqs &= ~AMS_IRQ_FREEFALL;
> -	}
> -
> -	if (ams_info.worker_irqs & AMS_IRQ_SHOCK) {
> -		if (verbose)
> -			printk(KERN_INFO "ams: shock detected!\n");
> -
> -		ams_info.worker_irqs &= ~AMS_IRQ_SHOCK;
> -	}
> -
> -	spin_unlock_irqrestore(&ams_info.irq_lock, flags);
> -
> -	ams_info.clear_irq(irqs_to_clear);
> -
> -	mutex_unlock(&ams_info.lock);
> -}
> -
> -/* Call with ams_info.lock held! */
> -int ams_sensor_attach(void)
> -{
> -	int result;
> -	const u32 *prop;
> -
> -	/* Get orientation */
> -	prop = of_get_property(ams_info.of_node, "orientation", NULL);
> -	if (!prop)
> -		return -ENODEV;
> -	ams_info.orient1 = *prop;
> -	ams_info.orient2 = *(prop + 1);
> -
> -	/* Register freefall interrupt handler */
> -	result = pmf_register_irq_client(ams_info.of_node,
> -			"accel-int-1",
> -			&ams_freefall_client);
> -	if (result < 0)
> -		return -ENODEV;
> -
> -	/* Reset saved irqs */
> -	ams_info.worker_irqs = 0;
> -
> -	/* Register shock interrupt handler */
> -	result = pmf_register_irq_client(ams_info.of_node,
> -			"accel-int-2",
> -			&ams_shock_client);
> -	if (result < 0)
> -		goto release_freefall;
> -
> -	/* Create device */
> -	ams_info.of_dev = of_platform_device_create(ams_info.of_node, "ams", NULL);
> -	if (!ams_info.of_dev) {
> -		result = -ENODEV;
> -		goto release_shock;
> -	}
> -
> -	/* Create attributes */
> -	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
> -	if (result)
> -		goto release_of;
> -
> -	ams_info.vflag = !!(ams_info.get_vendor() & 0x10);
> -
> -	/* Init input device */
> -	result = ams_input_init();
> -	if (result)
> -		goto release_device_file;
> -
> -	return result;
> -release_device_file:
> -	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
> -release_of:
> -	of_device_unregister(ams_info.of_dev);
> -release_shock:
> -	pmf_unregister_irq_client(&ams_shock_client);
> -release_freefall:
> -	pmf_unregister_irq_client(&ams_freefall_client);
> -	return result;
> -}
> -
> -int __init ams_init(void)
> -{
> -	struct device_node *np;
> -
> -	spin_lock_init(&ams_info.irq_lock);
> -	mutex_init(&ams_info.lock);
> -	INIT_WORK(&ams_info.worker, ams_worker);
> -
> -#ifdef CONFIG_SENSORS_AMS_I2C
> -	np = of_find_node_by_name(NULL, "accelerometer");
> -	if (np && of_device_is_compatible(np, "AAPL,accelerometer_1"))
> -		/* Found I2C motion sensor */
> -		return ams_i2c_init(np);
> -#endif
> -
> -#ifdef CONFIG_SENSORS_AMS_PMU
> -	np = of_find_node_by_name(NULL, "sms");
> -	if (np && of_device_is_compatible(np, "sms"))
> -		/* Found PMU motion sensor */
> -		return ams_pmu_init(np);
> -#endif
> -	return -ENODEV;
> -}
> -
> -void ams_sensor_detach(void)
> -{
> -	/* Remove input device */
> -	ams_input_exit();
> -
> -	/* Remove attributes */
> -	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
> -
> -	/* Flush interrupt worker
> -	 *
> -	 * We do this after ams_info.exit(), because an interrupt might
> -	 * have arrived before disabling them.
> -	 */
> -	flush_scheduled_work();
> -
> -	/* Remove device */
> -	of_device_unregister(ams_info.of_dev);
> -
> -	/* Remove handler */
> -	pmf_unregister_irq_client(&ams_shock_client);
> -	pmf_unregister_irq_client(&ams_freefall_client);
> -}
> -
> -static void __exit ams_exit(void)
> -{
> -	/* Shut down implementation */
> -	ams_info.exit();
> -}
> -
> -MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
> -MODULE_DESCRIPTION("Apple Motion Sensor driver");
> -MODULE_LICENSE("GPL");
> -
> -module_init(ams_init);
> -module_exit(ams_exit);
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/ams-i2c.c	2010-08-02 00:11:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,277 +0,0 @@
> -/*
> - * Apple Motion Sensor driver (I2C variant)
> - *
> - * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> - * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> - *
> - * Clean room implementation based on the reverse engineered Mac OS X driver by
> - * Johannes Berg <johannes@sipsolutions.net>, documentation available at
> - * http://johannes.sipsolutions.net/PowerBook/Apple_Motion_Sensor_Specification
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -
> -#include "ams.h"
> -
> -/* AMS registers */
> -#define AMS_COMMAND	0x00	/* command register */
> -#define AMS_STATUS	0x01	/* status register */
> -#define AMS_CTRL1	0x02	/* read control 1 (number of values) */
> -#define AMS_CTRL2	0x03	/* read control 2 (offset?) */
> -#define AMS_CTRL3	0x04	/* read control 3 (size of each value?) */
> -#define AMS_DATA1	0x05	/* read data 1 */
> -#define AMS_DATA2	0x06	/* read data 2 */
> -#define AMS_DATA3	0x07	/* read data 3 */
> -#define AMS_DATA4	0x08	/* read data 4 */
> -#define AMS_DATAX	0x20	/* data X */
> -#define AMS_DATAY	0x21	/* data Y */
> -#define AMS_DATAZ	0x22	/* data Z */
> -#define AMS_FREEFALL	0x24	/* freefall int control */
> -#define AMS_SHOCK	0x25	/* shock int control */
> -#define AMS_SENSLOW	0x26	/* sensitivity low limit */
> -#define AMS_SENSHIGH	0x27	/* sensitivity high limit */
> -#define AMS_CTRLX	0x28	/* control X */
> -#define AMS_CTRLY	0x29	/* control Y */
> -#define AMS_CTRLZ	0x2A	/* control Z */
> -#define AMS_UNKNOWN1	0x2B	/* unknown 1 */
> -#define AMS_UNKNOWN2	0x2C	/* unknown 2 */
> -#define AMS_UNKNOWN3	0x2D	/* unknown 3 */
> -#define AMS_VENDOR	0x2E	/* vendor */
> -
> -/* AMS commands - use with the AMS_COMMAND register */
> -enum ams_i2c_cmd {
> -	AMS_CMD_NOOP = 0,
> -	AMS_CMD_VERSION,
> -	AMS_CMD_READMEM,
> -	AMS_CMD_WRITEMEM,
> -	AMS_CMD_ERASEMEM,
> -	AMS_CMD_READEE,
> -	AMS_CMD_WRITEEE,
> -	AMS_CMD_RESET,
> -	AMS_CMD_START,
> -};
> -
> -static int ams_i2c_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id);
> -static int ams_i2c_remove(struct i2c_client *client);
> -
> -static const struct i2c_device_id ams_id[] = {
> -	{ "ams", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ams_id);
> -
> -static struct i2c_driver ams_i2c_driver = {
> -	.driver = {
> -		.name   = "ams",
> -		.owner  = THIS_MODULE,
> -	},
> -	.probe          = ams_i2c_probe,
> -	.remove         = ams_i2c_remove,
> -	.id_table       = ams_id,
> -};
> -
> -static s32 ams_i2c_read(u8 reg)
> -{
> -	return i2c_smbus_read_byte_data(ams_info.i2c_client, reg);
> -}
> -
> -static int ams_i2c_write(u8 reg, u8 value)
> -{
> -	return i2c_smbus_write_byte_data(ams_info.i2c_client, reg, value);
> -}
> -
> -static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
> -{
> -	s32 result;
> -	int count = 3;
> -
> -	ams_i2c_write(AMS_COMMAND, cmd);
> -	msleep(5);
> -
> -	while (count--) {
> -		result = ams_i2c_read(AMS_COMMAND);
> -		if (result == 0 || result & 0x80)
> -			return 0;
> -
> -		schedule_timeout_uninterruptible(HZ / 20);
> -	}
> -
> -	return -1;
> -}
> -
> -static void ams_i2c_set_irq(enum ams_irq reg, char enable)
> -{
> -	if (reg & AMS_IRQ_FREEFALL) {
> -		u8 val = ams_i2c_read(AMS_CTRLX);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_i2c_write(AMS_CTRLX, val);
> -	}
> -
> -	if (reg & AMS_IRQ_SHOCK) {
> -		u8 val = ams_i2c_read(AMS_CTRLY);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_i2c_write(AMS_CTRLY, val);
> -	}
> -
> -	if (reg & AMS_IRQ_GLOBAL) {
> -		u8 val = ams_i2c_read(AMS_CTRLZ);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_i2c_write(AMS_CTRLZ, val);
> -	}
> -}
> -
> -static void ams_i2c_clear_irq(enum ams_irq reg)
> -{
> -	if (reg & AMS_IRQ_FREEFALL)
> -		ams_i2c_write(AMS_FREEFALL, 0);
> -
> -	if (reg & AMS_IRQ_SHOCK)
> -		ams_i2c_write(AMS_SHOCK, 0);
> -}
> -
> -static u8 ams_i2c_get_vendor(void)
> -{
> -	return ams_i2c_read(AMS_VENDOR);
> -}
> -
> -static void ams_i2c_get_xyz(s8 *x, s8 *y, s8 *z)
> -{
> -	*x = ams_i2c_read(AMS_DATAX);
> -	*y = ams_i2c_read(AMS_DATAY);
> -	*z = ams_i2c_read(AMS_DATAZ);
> -}
> -
> -static int ams_i2c_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> -{
> -	int vmaj, vmin;
> -	int result;
> -
> -	/* There can be only one */
> -	if (unlikely(ams_info.has_device))
> -		return -ENODEV;
> -
> -	ams_info.i2c_client = client;
> -
> -	if (ams_i2c_cmd(AMS_CMD_RESET)) {
> -		printk(KERN_INFO "ams: Failed to reset the device\n");
> -		return -ENODEV;
> -	}
> -
> -	if (ams_i2c_cmd(AMS_CMD_START)) {
> -		printk(KERN_INFO "ams: Failed to start the device\n");
> -		return -ENODEV;
> -	}
> -
> -	/* get version/vendor information */
> -	ams_i2c_write(AMS_CTRL1, 0x02);
> -	ams_i2c_write(AMS_CTRL2, 0x85);
> -	ams_i2c_write(AMS_CTRL3, 0x01);
> -
> -	ams_i2c_cmd(AMS_CMD_READMEM);
> -
> -	vmaj = ams_i2c_read(AMS_DATA1);
> -	vmin = ams_i2c_read(AMS_DATA2);
> -	if (vmaj != 1 || vmin != 52) {
> -		printk(KERN_INFO "ams: Incorrect device version (%d.%d)\n",
> -			vmaj, vmin);
> -		return -ENODEV;
> -	}
> -
> -	ams_i2c_cmd(AMS_CMD_VERSION);
> -
> -	vmaj = ams_i2c_read(AMS_DATA1);
> -	vmin = ams_i2c_read(AMS_DATA2);
> -	if (vmaj != 0 || vmin != 1) {
> -		printk(KERN_INFO "ams: Incorrect firmware version (%d.%d)\n",
> -			vmaj, vmin);
> -		return -ENODEV;
> -	}
> -
> -	/* Disable interrupts */
> -	ams_i2c_set_irq(AMS_IRQ_ALL, 0);
> -
> -	result = ams_sensor_attach();
> -	if (result < 0)
> -		return result;
> -
> -	/* Set default values */
> -	ams_i2c_write(AMS_SENSLOW, 0x15);
> -	ams_i2c_write(AMS_SENSHIGH, 0x60);
> -	ams_i2c_write(AMS_CTRLX, 0x08);
> -	ams_i2c_write(AMS_CTRLY, 0x0F);
> -	ams_i2c_write(AMS_CTRLZ, 0x4F);
> -	ams_i2c_write(AMS_UNKNOWN1, 0x14);
> -
> -	/* Clear interrupts */
> -	ams_i2c_clear_irq(AMS_IRQ_ALL);
> -
> -	ams_info.has_device = 1;
> -
> -	/* Enable interrupts */
> -	ams_i2c_set_irq(AMS_IRQ_ALL, 1);
> -
> -	printk(KERN_INFO "ams: Found I2C based motion sensor\n");
> -
> -	return 0;
> -}
> -
> -static int ams_i2c_remove(struct i2c_client *client)
> -{
> -	if (ams_info.has_device) {
> -		ams_sensor_detach();
> -
> -		/* Disable interrupts */
> -		ams_i2c_set_irq(AMS_IRQ_ALL, 0);
> -
> -		/* Clear interrupts */
> -		ams_i2c_clear_irq(AMS_IRQ_ALL);
> -
> -		printk(KERN_INFO "ams: Unloading\n");
> -
> -		ams_info.has_device = 0;
> -	}
> -
> -	return 0;
> -}
> -
> -static void ams_i2c_exit(void)
> -{
> -	i2c_del_driver(&ams_i2c_driver);
> -}
> -
> -int __init ams_i2c_init(struct device_node *np)
> -{
> -	int result;
> -
> -	/* Set implementation stuff */
> -	ams_info.of_node = np;
> -	ams_info.exit = ams_i2c_exit;
> -	ams_info.get_vendor = ams_i2c_get_vendor;
> -	ams_info.get_xyz = ams_i2c_get_xyz;
> -	ams_info.clear_irq = ams_i2c_clear_irq;
> -	ams_info.bustype = BUS_I2C;
> -
> -	result = i2c_add_driver(&ams_i2c_driver);
> -
> -	return result;
> -}
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/ams-input.c	2010-08-02 00:11:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,157 +0,0 @@
> -/*
> - * Apple Motion Sensor driver (joystick emulation)
> - *
> - * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> - * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#include <linux/module.h>
> -
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -
> -#include "ams.h"
> -
> -static unsigned int joystick;
> -module_param(joystick, bool, S_IRUGO);
> -MODULE_PARM_DESC(joystick, "Enable the input class device on module load");
> -
> -static unsigned int invert;
> -module_param(invert, bool, S_IWUSR | S_IRUGO);
> -MODULE_PARM_DESC(invert, "Invert input data on X and Y axis");
> -
> -static DEFINE_MUTEX(ams_input_mutex);
> -
> -static void ams_idev_poll(struct input_polled_dev *dev)
> -{
> -	struct input_dev *idev = dev->input;
> -	s8 x, y, z;
> -
> -	mutex_lock(&ams_info.lock);
> -
> -	ams_sensors(&x, &y, &z);
> -
> -	x -= ams_info.xcalib;
> -	y -= ams_info.ycalib;
> -	z -= ams_info.zcalib;
> -
> -	input_report_abs(idev, ABS_X, invert ? -x : x);
> -	input_report_abs(idev, ABS_Y, invert ? -y : y);
> -	input_report_abs(idev, ABS_Z, z);
> -
> -	input_sync(idev);
> -
> -	mutex_unlock(&ams_info.lock);
> -}
> -
> -/* Call with ams_info.lock held! */
> -static int ams_input_enable(void)
> -{
> -	struct input_dev *input;
> -	s8 x, y, z;
> -	int error;
> -
> -	ams_sensors(&x, &y, &z);
> -	ams_info.xcalib = x;
> -	ams_info.ycalib = y;
> -	ams_info.zcalib = z;
> -
> -	ams_info.idev = input_allocate_polled_device();
> -	if (!ams_info.idev)
> -		return -ENOMEM;
> -
> -	ams_info.idev->poll = ams_idev_poll;
> -	ams_info.idev->poll_interval = 25;
> -
> -	input = ams_info.idev->input;
> -	input->name = "Apple Motion Sensor";
> -	input->id.bustype = ams_info.bustype;
> -	input->id.vendor = 0;
> -	input->dev.parent = &ams_info.of_dev->dev;
> -
> -	input_set_abs_params(input, ABS_X, -50, 50, 3, 0);
> -	input_set_abs_params(input, ABS_Y, -50, 50, 3, 0);
> -	input_set_abs_params(input, ABS_Z, -50, 50, 3, 0);
> -
> -	set_bit(EV_ABS, input->evbit);
> -	set_bit(EV_KEY, input->evbit);
> -	set_bit(BTN_TOUCH, input->keybit);
> -
> -	error = input_register_polled_device(ams_info.idev);
> -	if (error) {
> -		input_free_polled_device(ams_info.idev);
> -		ams_info.idev = NULL;
> -		return error;
> -	}
> -
> -	joystick = 1;
> -
> -	return 0;
> -}
> -
> -static void ams_input_disable(void)
> -{
> -	if (ams_info.idev) {
> -		input_unregister_polled_device(ams_info.idev);
> -		input_free_polled_device(ams_info.idev);
> -		ams_info.idev = NULL;
> -	}
> -
> -	joystick = 0;
> -}
> -
> -static ssize_t ams_input_show_joystick(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "%d\n", joystick);
> -}
> -
> -static ssize_t ams_input_store_joystick(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	unsigned long enable;
> -	int error = 0;
> -
> -	if (strict_strtoul(buf, 0, &enable) || enable > 1)
> -		return -EINVAL;
> -
> -	mutex_lock(&ams_input_mutex);
> -
> -	if (enable != joystick) {
> -		if (enable)
> -			error = ams_input_enable();
> -		else
> -			ams_input_disable();
> -	}
> -
> -	mutex_unlock(&ams_input_mutex);
> -
> -	return error ? error : count;
> -}
> -
> -static DEVICE_ATTR(joystick, S_IRUGO | S_IWUSR,
> -	ams_input_show_joystick, ams_input_store_joystick);
> -
> -int ams_input_init(void)
> -{
> -	if (joystick)
> -		ams_input_enable();
> -
> -	return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> -}
> -
> -void ams_input_exit(void)
> -{
> -	device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> -
> -	mutex_lock(&ams_input_mutex);
> -	ams_input_disable();
> -	mutex_unlock(&ams_input_mutex);
> -}
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/ams-pmu.c	2010-08-02 00:11:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,201 +0,0 @@
> -/*
> - * Apple Motion Sensor driver (PMU variant)
> - *
> - * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/adb.h>
> -#include <linux/pmu.h>
> -
> -#include "ams.h"
> -
> -/* Attitude */
> -#define AMS_X			0x00
> -#define AMS_Y			0x01
> -#define AMS_Z			0x02
> -
> -/* Not exactly known, maybe chip vendor */
> -#define AMS_VENDOR		0x03
> -
> -/* Freefall registers */
> -#define AMS_FF_CLEAR		0x04
> -#define AMS_FF_ENABLE		0x05
> -#define AMS_FF_LOW_LIMIT	0x06
> -#define AMS_FF_DEBOUNCE		0x07
> -
> -/* Shock registers */
> -#define AMS_SHOCK_CLEAR		0x08
> -#define AMS_SHOCK_ENABLE	0x09
> -#define AMS_SHOCK_HIGH_LIMIT	0x0a
> -#define AMS_SHOCK_DEBOUNCE	0x0b
> -
> -/* Global interrupt and power control register */
> -#define AMS_CONTROL		0x0c
> -
> -static u8 ams_pmu_cmd;
> -
> -static void ams_pmu_req_complete(struct adb_request *req)
> -{
> -	complete((struct completion *)req->arg);
> -}
> -
> -/* Only call this function from task context */
> -static void ams_pmu_set_register(u8 reg, u8 value)
> -{
> -	static struct adb_request req;
> -	DECLARE_COMPLETION(req_complete);
> -
> -	req.arg = &req_complete;
> -	if (pmu_request(&req, ams_pmu_req_complete, 4, ams_pmu_cmd, 0x00, reg, value))
> -		return;
> -
> -	wait_for_completion(&req_complete);
> -}
> -
> -/* Only call this function from task context */
> -static u8 ams_pmu_get_register(u8 reg)
> -{
> -	static struct adb_request req;
> -	DECLARE_COMPLETION(req_complete);
> -
> -	req.arg = &req_complete;
> -	if (pmu_request(&req, ams_pmu_req_complete, 3, ams_pmu_cmd, 0x01, reg))
> -		return 0;
> -
> -	wait_for_completion(&req_complete);
> -
> -	if (req.reply_len > 0)
> -		return req.reply[0];
> -	else
> -		return 0;
> -}
> -
> -/* Enables or disables the specified interrupts */
> -static void ams_pmu_set_irq(enum ams_irq reg, char enable)
> -{
> -	if (reg & AMS_IRQ_FREEFALL) {
> -		u8 val = ams_pmu_get_register(AMS_FF_ENABLE);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_pmu_set_register(AMS_FF_ENABLE, val);
> -	}
> -
> -	if (reg & AMS_IRQ_SHOCK) {
> -		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
> -	}
> -
> -	if (reg & AMS_IRQ_GLOBAL) {
> -		u8 val = ams_pmu_get_register(AMS_CONTROL);
> -		if (enable)
> -			val |= 0x80;
> -		else
> -			val &= ~0x80;
> -		ams_pmu_set_register(AMS_CONTROL, val);
> -	}
> -}
> -
> -static void ams_pmu_clear_irq(enum ams_irq reg)
> -{
> -	if (reg & AMS_IRQ_FREEFALL)
> -		ams_pmu_set_register(AMS_FF_CLEAR, 0x00);
> -
> -	if (reg & AMS_IRQ_SHOCK)
> -		ams_pmu_set_register(AMS_SHOCK_CLEAR, 0x00);
> -}
> -
> -static u8 ams_pmu_get_vendor(void)
> -{
> -	return ams_pmu_get_register(AMS_VENDOR);
> -}
> -
> -static void ams_pmu_get_xyz(s8 *x, s8 *y, s8 *z)
> -{
> -	*x = ams_pmu_get_register(AMS_X);
> -	*y = ams_pmu_get_register(AMS_Y);
> -	*z = ams_pmu_get_register(AMS_Z);
> -}
> -
> -static void ams_pmu_exit(void)
> -{
> -	ams_sensor_detach();
> -
> -	/* Disable interrupts */
> -	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
> -
> -	/* Clear interrupts */
> -	ams_pmu_clear_irq(AMS_IRQ_ALL);
> -
> -	ams_info.has_device = 0;
> -
> -	printk(KERN_INFO "ams: Unloading\n");
> -}
> -
> -int __init ams_pmu_init(struct device_node *np)
> -{
> -	const u32 *prop;
> -	int result;
> -
> -	/* Set implementation stuff */
> -	ams_info.of_node = np;
> -	ams_info.exit = ams_pmu_exit;
> -	ams_info.get_vendor = ams_pmu_get_vendor;
> -	ams_info.get_xyz = ams_pmu_get_xyz;
> -	ams_info.clear_irq = ams_pmu_clear_irq;
> -	ams_info.bustype = BUS_HOST;
> -
> -	/* Get PMU command, should be 0x4e, but we can never know */
> -	prop = of_get_property(ams_info.of_node, "reg", NULL);
> -	if (!prop)
> -		return -ENODEV;
> -
> -	ams_pmu_cmd = ((*prop) >> 8) & 0xff;
> -
> -	/* Disable interrupts */
> -	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
> -
> -	/* Clear interrupts */
> -	ams_pmu_clear_irq(AMS_IRQ_ALL);
> -
> -	result = ams_sensor_attach();
> -	if (result < 0)
> -		return result;
> -
> -	/* Set default values */
> -	ams_pmu_set_register(AMS_FF_LOW_LIMIT, 0x15);
> -	ams_pmu_set_register(AMS_FF_ENABLE, 0x08);
> -	ams_pmu_set_register(AMS_FF_DEBOUNCE, 0x14);
> -
> -	ams_pmu_set_register(AMS_SHOCK_HIGH_LIMIT, 0x60);
> -	ams_pmu_set_register(AMS_SHOCK_ENABLE, 0x0f);
> -	ams_pmu_set_register(AMS_SHOCK_DEBOUNCE, 0x14);
> -
> -	ams_pmu_set_register(AMS_CONTROL, 0x4f);
> -
> -	/* Clear interrupts */
> -	ams_pmu_clear_irq(AMS_IRQ_ALL);
> -
> -	ams_info.has_device = 1;
> -
> -	/* Enable interrupts */
> -	ams_pmu_set_irq(AMS_IRQ_ALL, 1);
> -
> -	printk(KERN_INFO "ams: Found PMU based motion sensor\n");
> -
> -	return 0;
> -}
> --- linux-2.6.36-rc6.orig/drivers/hwmon/ams/ams.h	2010-09-21 11:07:14.000000000 +0200
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,70 +0,0 @@
> -#include <linux/i2c.h>
> -#include <linux/input-polldev.h>
> -#include <linux/kthread.h>
> -#include <linux/mutex.h>
> -#include <linux/spinlock.h>
> -#include <linux/types.h>
> -#include <linux/of_device.h>
> -
> -enum ams_irq {
> -	AMS_IRQ_FREEFALL = 0x01,
> -	AMS_IRQ_SHOCK = 0x02,
> -	AMS_IRQ_GLOBAL = 0x04,
> -	AMS_IRQ_ALL =
> -		AMS_IRQ_FREEFALL |
> -		AMS_IRQ_SHOCK |
> -		AMS_IRQ_GLOBAL,
> -};
> -
> -struct ams {
> -	/* Locks */
> -	spinlock_t irq_lock;
> -	struct mutex lock;
> -
> -	/* General properties */
> -	struct device_node *of_node;
> -	struct platform_device *of_dev;
> -	char has_device;
> -	char vflag;
> -	u32 orient1;
> -	u32 orient2;
> -
> -	/* Interrupt worker */
> -	struct work_struct worker;
> -	u8 worker_irqs;
> -
> -	/* Implementation
> -	 *
> -	 * Only call these functions with the main lock held.
> -	 */
> -	void (*exit)(void);
> -
> -	void (*get_xyz)(s8 *x, s8 *y, s8 *z);
> -	u8 (*get_vendor)(void);
> -
> -	void (*clear_irq)(enum ams_irq reg);
> -
> -#ifdef CONFIG_SENSORS_AMS_I2C
> -	/* I2C properties */
> -	struct i2c_client *i2c_client;
> -#endif
> -
> -	/* Joystick emulation */
> -	struct input_polled_dev *idev;
> -	__u16 bustype;
> -
> -	/* calibrated null values */
> -	int xcalib, ycalib, zcalib;
> -};
> -
> -extern struct ams ams_info;
> -
> -extern void ams_sensors(s8 *x, s8 *y, s8 *z);
> -extern int ams_sensor_attach(void);
> -extern void ams_sensor_detach(void);
> -
> -extern int ams_pmu_init(struct device_node *np);
> -extern int ams_i2c_init(struct device_node *np);
> -
> -extern int ams_input_init(void);
> -extern void ams_input_exit(void);
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/Makefile	2010-08-02 00:11:14.000000000 +0200
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for Apple Motion Sensor driver
> +#
> +
> +ams-y					:= ams-core.o ams-input.o
> +ams-$(CONFIG_SENSORS_AMS_PMU)		+= ams-pmu.o
> +ams-$(CONFIG_SENSORS_AMS_I2C)		+= ams-i2c.o
> +obj-$(CONFIG_SENSORS_AMS)		+= ams.o
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/ams-core.c	2010-08-02 00:11:14.000000000 +0200
> @@ -0,0 +1,250 @@
> +/*
> + * Apple Motion Sensor driver
> + *
> + * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> + * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <asm/pmac_pfunc.h>
> +
> +#include "ams.h"
> +
> +/* There is only one motion sensor per machine */
> +struct ams ams_info;
> +
> +static unsigned int verbose;
> +module_param(verbose, bool, 0644);
> +MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
> +
> +/* Call with ams_info.lock held! */
> +void ams_sensors(s8 *x, s8 *y, s8 *z)
> +{
> +	u32 orient = ams_info.vflag? ams_info.orient1 : ams_info.orient2;
> +
> +	if (orient & 0x80)
> +		/* X and Y swapped */
> +		ams_info.get_xyz(y, x, z);
> +	else
> +		ams_info.get_xyz(x, y, z);
> +
> +	if (orient & 0x04)
> +		*z = ~(*z);
> +	if (orient & 0x02)
> +		*y = ~(*y);
> +	if (orient & 0x01)
> +		*x = ~(*x);
> +}
> +
> +static ssize_t ams_show_current(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	s8 x, y, z;
> +
> +	mutex_lock(&ams_info.lock);
> +	ams_sensors(&x, &y, &z);
> +	mutex_unlock(&ams_info.lock);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d %d %d\n", x, y, z);
> +}
> +
> +static DEVICE_ATTR(current, S_IRUGO, ams_show_current, NULL);
> +
> +static void ams_handle_irq(void *data)
> +{
> +	enum ams_irq irq = *((enum ams_irq *)data);
> +
> +	spin_lock(&ams_info.irq_lock);
> +
> +	ams_info.worker_irqs |= irq;
> +	schedule_work(&ams_info.worker);
> +
> +	spin_unlock(&ams_info.irq_lock);
> +}
> +
> +static enum ams_irq ams_freefall_irq_data = AMS_IRQ_FREEFALL;
> +static struct pmf_irq_client ams_freefall_client = {
> +	.owner = THIS_MODULE,
> +	.handler = ams_handle_irq,
> +	.data = &ams_freefall_irq_data,
> +};
> +
> +static enum ams_irq ams_shock_irq_data = AMS_IRQ_SHOCK;
> +static struct pmf_irq_client ams_shock_client = {
> +	.owner = THIS_MODULE,
> +	.handler = ams_handle_irq,
> +	.data = &ams_shock_irq_data,
> +};
> +
> +/* Once hard disk parking is implemented in the kernel, this function can
> + * trigger it.
> + */
> +static void ams_worker(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	u8 irqs_to_clear;
> +
> +	mutex_lock(&ams_info.lock);
> +
> +	spin_lock_irqsave(&ams_info.irq_lock, flags);
> +	irqs_to_clear = ams_info.worker_irqs;
> +
> +	if (ams_info.worker_irqs & AMS_IRQ_FREEFALL) {
> +		if (verbose)
> +			printk(KERN_INFO "ams: freefall detected!\n");
> +
> +		ams_info.worker_irqs &= ~AMS_IRQ_FREEFALL;
> +	}
> +
> +	if (ams_info.worker_irqs & AMS_IRQ_SHOCK) {
> +		if (verbose)
> +			printk(KERN_INFO "ams: shock detected!\n");
> +
> +		ams_info.worker_irqs &= ~AMS_IRQ_SHOCK;
> +	}
> +
> +	spin_unlock_irqrestore(&ams_info.irq_lock, flags);
> +
> +	ams_info.clear_irq(irqs_to_clear);
> +
> +	mutex_unlock(&ams_info.lock);
> +}
> +
> +/* Call with ams_info.lock held! */
> +int ams_sensor_attach(void)
> +{
> +	int result;
> +	const u32 *prop;
> +
> +	/* Get orientation */
> +	prop = of_get_property(ams_info.of_node, "orientation", NULL);
> +	if (!prop)
> +		return -ENODEV;
> +	ams_info.orient1 = *prop;
> +	ams_info.orient2 = *(prop + 1);
> +
> +	/* Register freefall interrupt handler */
> +	result = pmf_register_irq_client(ams_info.of_node,
> +			"accel-int-1",
> +			&ams_freefall_client);
> +	if (result < 0)
> +		return -ENODEV;
> +
> +	/* Reset saved irqs */
> +	ams_info.worker_irqs = 0;
> +
> +	/* Register shock interrupt handler */
> +	result = pmf_register_irq_client(ams_info.of_node,
> +			"accel-int-2",
> +			&ams_shock_client);
> +	if (result < 0)
> +		goto release_freefall;
> +
> +	/* Create device */
> +	ams_info.of_dev = of_platform_device_create(ams_info.of_node, "ams", NULL);
> +	if (!ams_info.of_dev) {
> +		result = -ENODEV;
> +		goto release_shock;
> +	}
> +
> +	/* Create attributes */
> +	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
> +	if (result)
> +		goto release_of;
> +
> +	ams_info.vflag = !!(ams_info.get_vendor() & 0x10);
> +
> +	/* Init input device */
> +	result = ams_input_init();
> +	if (result)
> +		goto release_device_file;
> +
> +	return result;
> +release_device_file:
> +	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
> +release_of:
> +	of_device_unregister(ams_info.of_dev);
> +release_shock:
> +	pmf_unregister_irq_client(&ams_shock_client);
> +release_freefall:
> +	pmf_unregister_irq_client(&ams_freefall_client);
> +	return result;
> +}
> +
> +int __init ams_init(void)
> +{
> +	struct device_node *np;
> +
> +	spin_lock_init(&ams_info.irq_lock);
> +	mutex_init(&ams_info.lock);
> +	INIT_WORK(&ams_info.worker, ams_worker);
> +
> +#ifdef CONFIG_SENSORS_AMS_I2C
> +	np = of_find_node_by_name(NULL, "accelerometer");
> +	if (np && of_device_is_compatible(np, "AAPL,accelerometer_1"))
> +		/* Found I2C motion sensor */
> +		return ams_i2c_init(np);
> +#endif
> +
> +#ifdef CONFIG_SENSORS_AMS_PMU
> +	np = of_find_node_by_name(NULL, "sms");
> +	if (np && of_device_is_compatible(np, "sms"))
> +		/* Found PMU motion sensor */
> +		return ams_pmu_init(np);
> +#endif
> +	return -ENODEV;
> +}
> +
> +void ams_sensor_detach(void)
> +{
> +	/* Remove input device */
> +	ams_input_exit();
> +
> +	/* Remove attributes */
> +	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
> +
> +	/* Flush interrupt worker
> +	 *
> +	 * We do this after ams_info.exit(), because an interrupt might
> +	 * have arrived before disabling them.
> +	 */
> +	flush_scheduled_work();
> +
> +	/* Remove device */
> +	of_device_unregister(ams_info.of_dev);
> +
> +	/* Remove handler */
> +	pmf_unregister_irq_client(&ams_shock_client);
> +	pmf_unregister_irq_client(&ams_freefall_client);
> +}
> +
> +static void __exit ams_exit(void)
> +{
> +	/* Shut down implementation */
> +	ams_info.exit();
> +}
> +
> +MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
> +MODULE_DESCRIPTION("Apple Motion Sensor driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(ams_init);
> +module_exit(ams_exit);
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/ams-i2c.c	2010-08-02 00:11:14.000000000 +0200
> @@ -0,0 +1,277 @@
> +/*
> + * Apple Motion Sensor driver (I2C variant)
> + *
> + * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> + * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> + *
> + * Clean room implementation based on the reverse engineered Mac OS X driver by
> + * Johannes Berg <johannes@sipsolutions.net>, documentation available at
> + * http://johannes.sipsolutions.net/PowerBook/Apple_Motion_Sensor_Specification
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +#include "ams.h"
> +
> +/* AMS registers */
> +#define AMS_COMMAND	0x00	/* command register */
> +#define AMS_STATUS	0x01	/* status register */
> +#define AMS_CTRL1	0x02	/* read control 1 (number of values) */
> +#define AMS_CTRL2	0x03	/* read control 2 (offset?) */
> +#define AMS_CTRL3	0x04	/* read control 3 (size of each value?) */
> +#define AMS_DATA1	0x05	/* read data 1 */
> +#define AMS_DATA2	0x06	/* read data 2 */
> +#define AMS_DATA3	0x07	/* read data 3 */
> +#define AMS_DATA4	0x08	/* read data 4 */
> +#define AMS_DATAX	0x20	/* data X */
> +#define AMS_DATAY	0x21	/* data Y */
> +#define AMS_DATAZ	0x22	/* data Z */
> +#define AMS_FREEFALL	0x24	/* freefall int control */
> +#define AMS_SHOCK	0x25	/* shock int control */
> +#define AMS_SENSLOW	0x26	/* sensitivity low limit */
> +#define AMS_SENSHIGH	0x27	/* sensitivity high limit */
> +#define AMS_CTRLX	0x28	/* control X */
> +#define AMS_CTRLY	0x29	/* control Y */
> +#define AMS_CTRLZ	0x2A	/* control Z */
> +#define AMS_UNKNOWN1	0x2B	/* unknown 1 */
> +#define AMS_UNKNOWN2	0x2C	/* unknown 2 */
> +#define AMS_UNKNOWN3	0x2D	/* unknown 3 */
> +#define AMS_VENDOR	0x2E	/* vendor */
> +
> +/* AMS commands - use with the AMS_COMMAND register */
> +enum ams_i2c_cmd {
> +	AMS_CMD_NOOP = 0,
> +	AMS_CMD_VERSION,
> +	AMS_CMD_READMEM,
> +	AMS_CMD_WRITEMEM,
> +	AMS_CMD_ERASEMEM,
> +	AMS_CMD_READEE,
> +	AMS_CMD_WRITEEE,
> +	AMS_CMD_RESET,
> +	AMS_CMD_START,
> +};
> +
> +static int ams_i2c_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id);
> +static int ams_i2c_remove(struct i2c_client *client);
> +
> +static const struct i2c_device_id ams_id[] = {
> +	{ "ams", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ams_id);
> +
> +static struct i2c_driver ams_i2c_driver = {
> +	.driver = {
> +		.name   = "ams",
> +		.owner  = THIS_MODULE,
> +	},
> +	.probe          = ams_i2c_probe,
> +	.remove         = ams_i2c_remove,
> +	.id_table       = ams_id,
> +};
> +
> +static s32 ams_i2c_read(u8 reg)
> +{
> +	return i2c_smbus_read_byte_data(ams_info.i2c_client, reg);
> +}
> +
> +static int ams_i2c_write(u8 reg, u8 value)
> +{
> +	return i2c_smbus_write_byte_data(ams_info.i2c_client, reg, value);
> +}
> +
> +static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
> +{
> +	s32 result;
> +	int count = 3;
> +
> +	ams_i2c_write(AMS_COMMAND, cmd);
> +	msleep(5);
> +
> +	while (count--) {
> +		result = ams_i2c_read(AMS_COMMAND);
> +		if (result == 0 || result & 0x80)
> +			return 0;
> +
> +		schedule_timeout_uninterruptible(HZ / 20);
> +	}
> +
> +	return -1;
> +}
> +
> +static void ams_i2c_set_irq(enum ams_irq reg, char enable)
> +{
> +	if (reg & AMS_IRQ_FREEFALL) {
> +		u8 val = ams_i2c_read(AMS_CTRLX);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLX, val);
> +	}
> +
> +	if (reg & AMS_IRQ_SHOCK) {
> +		u8 val = ams_i2c_read(AMS_CTRLY);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLY, val);
> +	}
> +
> +	if (reg & AMS_IRQ_GLOBAL) {
> +		u8 val = ams_i2c_read(AMS_CTRLZ);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_i2c_write(AMS_CTRLZ, val);
> +	}
> +}
> +
> +static void ams_i2c_clear_irq(enum ams_irq reg)
> +{
> +	if (reg & AMS_IRQ_FREEFALL)
> +		ams_i2c_write(AMS_FREEFALL, 0);
> +
> +	if (reg & AMS_IRQ_SHOCK)
> +		ams_i2c_write(AMS_SHOCK, 0);
> +}
> +
> +static u8 ams_i2c_get_vendor(void)
> +{
> +	return ams_i2c_read(AMS_VENDOR);
> +}
> +
> +static void ams_i2c_get_xyz(s8 *x, s8 *y, s8 *z)
> +{
> +	*x = ams_i2c_read(AMS_DATAX);
> +	*y = ams_i2c_read(AMS_DATAY);
> +	*z = ams_i2c_read(AMS_DATAZ);
> +}
> +
> +static int ams_i2c_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	int vmaj, vmin;
> +	int result;
> +
> +	/* There can be only one */
> +	if (unlikely(ams_info.has_device))
> +		return -ENODEV;
> +
> +	ams_info.i2c_client = client;
> +
> +	if (ams_i2c_cmd(AMS_CMD_RESET)) {
> +		printk(KERN_INFO "ams: Failed to reset the device\n");
> +		return -ENODEV;
> +	}
> +
> +	if (ams_i2c_cmd(AMS_CMD_START)) {
> +		printk(KERN_INFO "ams: Failed to start the device\n");
> +		return -ENODEV;
> +	}
> +
> +	/* get version/vendor information */
> +	ams_i2c_write(AMS_CTRL1, 0x02);
> +	ams_i2c_write(AMS_CTRL2, 0x85);
> +	ams_i2c_write(AMS_CTRL3, 0x01);
> +
> +	ams_i2c_cmd(AMS_CMD_READMEM);
> +
> +	vmaj = ams_i2c_read(AMS_DATA1);
> +	vmin = ams_i2c_read(AMS_DATA2);
> +	if (vmaj != 1 || vmin != 52) {
> +		printk(KERN_INFO "ams: Incorrect device version (%d.%d)\n",
> +			vmaj, vmin);
> +		return -ENODEV;
> +	}
> +
> +	ams_i2c_cmd(AMS_CMD_VERSION);
> +
> +	vmaj = ams_i2c_read(AMS_DATA1);
> +	vmin = ams_i2c_read(AMS_DATA2);
> +	if (vmaj != 0 || vmin != 1) {
> +		printk(KERN_INFO "ams: Incorrect firmware version (%d.%d)\n",
> +			vmaj, vmin);
> +		return -ENODEV;
> +	}
> +
> +	/* Disable interrupts */
> +	ams_i2c_set_irq(AMS_IRQ_ALL, 0);
> +
> +	result = ams_sensor_attach();
> +	if (result < 0)
> +		return result;
> +
> +	/* Set default values */
> +	ams_i2c_write(AMS_SENSLOW, 0x15);
> +	ams_i2c_write(AMS_SENSHIGH, 0x60);
> +	ams_i2c_write(AMS_CTRLX, 0x08);
> +	ams_i2c_write(AMS_CTRLY, 0x0F);
> +	ams_i2c_write(AMS_CTRLZ, 0x4F);
> +	ams_i2c_write(AMS_UNKNOWN1, 0x14);
> +
> +	/* Clear interrupts */
> +	ams_i2c_clear_irq(AMS_IRQ_ALL);
> +
> +	ams_info.has_device = 1;
> +
> +	/* Enable interrupts */
> +	ams_i2c_set_irq(AMS_IRQ_ALL, 1);
> +
> +	printk(KERN_INFO "ams: Found I2C based motion sensor\n");
> +
> +	return 0;
> +}
> +
> +static int ams_i2c_remove(struct i2c_client *client)
> +{
> +	if (ams_info.has_device) {
> +		ams_sensor_detach();
> +
> +		/* Disable interrupts */
> +		ams_i2c_set_irq(AMS_IRQ_ALL, 0);
> +
> +		/* Clear interrupts */
> +		ams_i2c_clear_irq(AMS_IRQ_ALL);
> +
> +		printk(KERN_INFO "ams: Unloading\n");
> +
> +		ams_info.has_device = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ams_i2c_exit(void)
> +{
> +	i2c_del_driver(&ams_i2c_driver);
> +}
> +
> +int __init ams_i2c_init(struct device_node *np)
> +{
> +	int result;
> +
> +	/* Set implementation stuff */
> +	ams_info.of_node = np;
> +	ams_info.exit = ams_i2c_exit;
> +	ams_info.get_vendor = ams_i2c_get_vendor;
> +	ams_info.get_xyz = ams_i2c_get_xyz;
> +	ams_info.clear_irq = ams_i2c_clear_irq;
> +	ams_info.bustype = BUS_I2C;
> +
> +	result = i2c_add_driver(&ams_i2c_driver);
> +
> +	return result;
> +}
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/ams-input.c	2010-08-02 00:11:14.000000000 +0200
> @@ -0,0 +1,157 @@
> +/*
> + * Apple Motion Sensor driver (joystick emulation)
> + *
> + * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
> + * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +#include "ams.h"
> +
> +static unsigned int joystick;
> +module_param(joystick, bool, S_IRUGO);
> +MODULE_PARM_DESC(joystick, "Enable the input class device on module load");
> +
> +static unsigned int invert;
> +module_param(invert, bool, S_IWUSR | S_IRUGO);
> +MODULE_PARM_DESC(invert, "Invert input data on X and Y axis");
> +
> +static DEFINE_MUTEX(ams_input_mutex);
> +
> +static void ams_idev_poll(struct input_polled_dev *dev)
> +{
> +	struct input_dev *idev = dev->input;
> +	s8 x, y, z;
> +
> +	mutex_lock(&ams_info.lock);
> +
> +	ams_sensors(&x, &y, &z);
> +
> +	x -= ams_info.xcalib;
> +	y -= ams_info.ycalib;
> +	z -= ams_info.zcalib;
> +
> +	input_report_abs(idev, ABS_X, invert ? -x : x);
> +	input_report_abs(idev, ABS_Y, invert ? -y : y);
> +	input_report_abs(idev, ABS_Z, z);
> +
> +	input_sync(idev);
> +
> +	mutex_unlock(&ams_info.lock);
> +}
> +
> +/* Call with ams_info.lock held! */
> +static int ams_input_enable(void)
> +{
> +	struct input_dev *input;
> +	s8 x, y, z;
> +	int error;
> +
> +	ams_sensors(&x, &y, &z);
> +	ams_info.xcalib = x;
> +	ams_info.ycalib = y;
> +	ams_info.zcalib = z;
> +
> +	ams_info.idev = input_allocate_polled_device();
> +	if (!ams_info.idev)
> +		return -ENOMEM;
> +
> +	ams_info.idev->poll = ams_idev_poll;
> +	ams_info.idev->poll_interval = 25;
> +
> +	input = ams_info.idev->input;
> +	input->name = "Apple Motion Sensor";
> +	input->id.bustype = ams_info.bustype;
> +	input->id.vendor = 0;
> +	input->dev.parent = &ams_info.of_dev->dev;
> +
> +	input_set_abs_params(input, ABS_X, -50, 50, 3, 0);
> +	input_set_abs_params(input, ABS_Y, -50, 50, 3, 0);
> +	input_set_abs_params(input, ABS_Z, -50, 50, 3, 0);
> +
> +	set_bit(EV_ABS, input->evbit);
> +	set_bit(EV_KEY, input->evbit);
> +	set_bit(BTN_TOUCH, input->keybit);
> +
> +	error = input_register_polled_device(ams_info.idev);
> +	if (error) {
> +		input_free_polled_device(ams_info.idev);
> +		ams_info.idev = NULL;
> +		return error;
> +	}
> +
> +	joystick = 1;
> +
> +	return 0;
> +}
> +
> +static void ams_input_disable(void)
> +{
> +	if (ams_info.idev) {
> +		input_unregister_polled_device(ams_info.idev);
> +		input_free_polled_device(ams_info.idev);
> +		ams_info.idev = NULL;
> +	}
> +
> +	joystick = 0;
> +}
> +
> +static ssize_t ams_input_show_joystick(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", joystick);
> +}
> +
> +static ssize_t ams_input_store_joystick(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	unsigned long enable;
> +	int error = 0;
> +
> +	if (strict_strtoul(buf, 0, &enable) || enable > 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&ams_input_mutex);
> +
> +	if (enable != joystick) {
> +		if (enable)
> +			error = ams_input_enable();
> +		else
> +			ams_input_disable();
> +	}
> +
> +	mutex_unlock(&ams_input_mutex);
> +
> +	return error ? error : count;
> +}
> +
> +static DEVICE_ATTR(joystick, S_IRUGO | S_IWUSR,
> +	ams_input_show_joystick, ams_input_store_joystick);
> +
> +int ams_input_init(void)
> +{
> +	if (joystick)
> +		ams_input_enable();
> +
> +	return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> +}
> +
> +void ams_input_exit(void)
> +{
> +	device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> +
> +	mutex_lock(&ams_input_mutex);
> +	ams_input_disable();
> +	mutex_unlock(&ams_input_mutex);
> +}
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/ams-pmu.c	2010-08-02 00:11:14.000000000 +0200
> @@ -0,0 +1,201 @@
> +/*
> + * Apple Motion Sensor driver (PMU variant)
> + *
> + * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/adb.h>
> +#include <linux/pmu.h>
> +
> +#include "ams.h"
> +
> +/* Attitude */
> +#define AMS_X			0x00
> +#define AMS_Y			0x01
> +#define AMS_Z			0x02
> +
> +/* Not exactly known, maybe chip vendor */
> +#define AMS_VENDOR		0x03
> +
> +/* Freefall registers */
> +#define AMS_FF_CLEAR		0x04
> +#define AMS_FF_ENABLE		0x05
> +#define AMS_FF_LOW_LIMIT	0x06
> +#define AMS_FF_DEBOUNCE		0x07
> +
> +/* Shock registers */
> +#define AMS_SHOCK_CLEAR		0x08
> +#define AMS_SHOCK_ENABLE	0x09
> +#define AMS_SHOCK_HIGH_LIMIT	0x0a
> +#define AMS_SHOCK_DEBOUNCE	0x0b
> +
> +/* Global interrupt and power control register */
> +#define AMS_CONTROL		0x0c
> +
> +static u8 ams_pmu_cmd;
> +
> +static void ams_pmu_req_complete(struct adb_request *req)
> +{
> +	complete((struct completion *)req->arg);
> +}
> +
> +/* Only call this function from task context */
> +static void ams_pmu_set_register(u8 reg, u8 value)
> +{
> +	static struct adb_request req;
> +	DECLARE_COMPLETION(req_complete);
> +
> +	req.arg = &req_complete;
> +	if (pmu_request(&req, ams_pmu_req_complete, 4, ams_pmu_cmd, 0x00, reg, value))
> +		return;
> +
> +	wait_for_completion(&req_complete);
> +}
> +
> +/* Only call this function from task context */
> +static u8 ams_pmu_get_register(u8 reg)
> +{
> +	static struct adb_request req;
> +	DECLARE_COMPLETION(req_complete);
> +
> +	req.arg = &req_complete;
> +	if (pmu_request(&req, ams_pmu_req_complete, 3, ams_pmu_cmd, 0x01, reg))
> +		return 0;
> +
> +	wait_for_completion(&req_complete);
> +
> +	if (req.reply_len > 0)
> +		return req.reply[0];
> +	else
> +		return 0;
> +}
> +
> +/* Enables or disables the specified interrupts */
> +static void ams_pmu_set_irq(enum ams_irq reg, char enable)
> +{
> +	if (reg & AMS_IRQ_FREEFALL) {
> +		u8 val = ams_pmu_get_register(AMS_FF_ENABLE);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_pmu_set_register(AMS_FF_ENABLE, val);
> +	}
> +
> +	if (reg & AMS_IRQ_SHOCK) {
> +		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
> +	}
> +
> +	if (reg & AMS_IRQ_GLOBAL) {
> +		u8 val = ams_pmu_get_register(AMS_CONTROL);
> +		if (enable)
> +			val |= 0x80;
> +		else
> +			val &= ~0x80;
> +		ams_pmu_set_register(AMS_CONTROL, val);
> +	}
> +}
> +
> +static void ams_pmu_clear_irq(enum ams_irq reg)
> +{
> +	if (reg & AMS_IRQ_FREEFALL)
> +		ams_pmu_set_register(AMS_FF_CLEAR, 0x00);
> +
> +	if (reg & AMS_IRQ_SHOCK)
> +		ams_pmu_set_register(AMS_SHOCK_CLEAR, 0x00);
> +}
> +
> +static u8 ams_pmu_get_vendor(void)
> +{
> +	return ams_pmu_get_register(AMS_VENDOR);
> +}
> +
> +static void ams_pmu_get_xyz(s8 *x, s8 *y, s8 *z)
> +{
> +	*x = ams_pmu_get_register(AMS_X);
> +	*y = ams_pmu_get_register(AMS_Y);
> +	*z = ams_pmu_get_register(AMS_Z);
> +}
> +
> +static void ams_pmu_exit(void)
> +{
> +	ams_sensor_detach();
> +
> +	/* Disable interrupts */
> +	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
> +
> +	/* Clear interrupts */
> +	ams_pmu_clear_irq(AMS_IRQ_ALL);
> +
> +	ams_info.has_device = 0;
> +
> +	printk(KERN_INFO "ams: Unloading\n");
> +}
> +
> +int __init ams_pmu_init(struct device_node *np)
> +{
> +	const u32 *prop;
> +	int result;
> +
> +	/* Set implementation stuff */
> +	ams_info.of_node = np;
> +	ams_info.exit = ams_pmu_exit;
> +	ams_info.get_vendor = ams_pmu_get_vendor;
> +	ams_info.get_xyz = ams_pmu_get_xyz;
> +	ams_info.clear_irq = ams_pmu_clear_irq;
> +	ams_info.bustype = BUS_HOST;
> +
> +	/* Get PMU command, should be 0x4e, but we can never know */
> +	prop = of_get_property(ams_info.of_node, "reg", NULL);
> +	if (!prop)
> +		return -ENODEV;
> +
> +	ams_pmu_cmd = ((*prop) >> 8) & 0xff;
> +
> +	/* Disable interrupts */
> +	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
> +
> +	/* Clear interrupts */
> +	ams_pmu_clear_irq(AMS_IRQ_ALL);
> +
> +	result = ams_sensor_attach();
> +	if (result < 0)
> +		return result;
> +
> +	/* Set default values */
> +	ams_pmu_set_register(AMS_FF_LOW_LIMIT, 0x15);
> +	ams_pmu_set_register(AMS_FF_ENABLE, 0x08);
> +	ams_pmu_set_register(AMS_FF_DEBOUNCE, 0x14);
> +
> +	ams_pmu_set_register(AMS_SHOCK_HIGH_LIMIT, 0x60);
> +	ams_pmu_set_register(AMS_SHOCK_ENABLE, 0x0f);
> +	ams_pmu_set_register(AMS_SHOCK_DEBOUNCE, 0x14);
> +
> +	ams_pmu_set_register(AMS_CONTROL, 0x4f);
> +
> +	/* Clear interrupts */
> +	ams_pmu_clear_irq(AMS_IRQ_ALL);
> +
> +	ams_info.has_device = 1;
> +
> +	/* Enable interrupts */
> +	ams_pmu_set_irq(AMS_IRQ_ALL, 1);
> +
> +	printk(KERN_INFO "ams: Found PMU based motion sensor\n");
> +
> +	return 0;
> +}
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.36-rc6/drivers/macintosh/ams/ams.h	2010-09-21 11:07:14.000000000 +0200
> @@ -0,0 +1,70 @@
> +#include <linux/i2c.h>
> +#include <linux/input-polldev.h>
> +#include <linux/kthread.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/of_device.h>
> +
> +enum ams_irq {
> +	AMS_IRQ_FREEFALL = 0x01,
> +	AMS_IRQ_SHOCK = 0x02,
> +	AMS_IRQ_GLOBAL = 0x04,
> +	AMS_IRQ_ALL =
> +		AMS_IRQ_FREEFALL |
> +		AMS_IRQ_SHOCK |
> +		AMS_IRQ_GLOBAL,
> +};
> +
> +struct ams {
> +	/* Locks */
> +	spinlock_t irq_lock;
> +	struct mutex lock;
> +
> +	/* General properties */
> +	struct device_node *of_node;
> +	struct platform_device *of_dev;
> +	char has_device;
> +	char vflag;
> +	u32 orient1;
> +	u32 orient2;
> +
> +	/* Interrupt worker */
> +	struct work_struct worker;
> +	u8 worker_irqs;
> +
> +	/* Implementation
> +	 *
> +	 * Only call these functions with the main lock held.
> +	 */
> +	void (*exit)(void);
> +
> +	void (*get_xyz)(s8 *x, s8 *y, s8 *z);
> +	u8 (*get_vendor)(void);
> +
> +	void (*clear_irq)(enum ams_irq reg);
> +
> +#ifdef CONFIG_SENSORS_AMS_I2C
> +	/* I2C properties */
> +	struct i2c_client *i2c_client;
> +#endif
> +
> +	/* Joystick emulation */
> +	struct input_polled_dev *idev;
> +	__u16 bustype;
> +
> +	/* calibrated null values */
> +	int xcalib, ycalib, zcalib;
> +};
> +
> +extern struct ams ams_info;
> +
> +extern void ams_sensors(s8 *x, s8 *y, s8 *z);
> +extern int ams_sensor_attach(void);
> +extern void ams_sensor_detach(void);
> +
> +extern int ams_pmu_init(struct device_node *np);
> +extern int ams_i2c_init(struct device_node *np);
> +
> +extern int ams_input_init(void);
> +extern void ams_input_exit(void);
> --- linux-2.6.36-rc6.orig/MAINTAINERS	2010-10-05 10:45:16.000000000 +0200
> +++ linux-2.6.36-rc6/MAINTAINERS	2010-10-05 11:51:21.000000000 +0200
> @@ -445,7 +445,7 @@ AMS (Apple Motion Sensor) DRIVER
>  M:	Stelian Pop <stelian@popies.net>
>  M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>  S:	Supported
> -F:	drivers/hwmon/ams/
> +F:	drivers/macintosh/ams/
>  
>  AMSO1100 RNIC DRIVER
>  M:	Tom Tucker <tom@opengridcomputing.com>
> --- linux-2.6.36-rc6.orig/drivers/hwmon/Kconfig	2010-10-05 10:45:16.000000000 +0200
> +++ linux-2.6.36-rc6/drivers/hwmon/Kconfig	2010-10-05 11:42:38.000000000 +0200
> @@ -249,32 +249,6 @@ config SENSORS_K10TEMP
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called k10temp.
>  
> -config SENSORS_AMS
> -	tristate "Apple Motion Sensor driver"
> -	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
> -	select INPUT_POLLDEV
> -	help
> -	  Support for the motion sensor included in PowerBooks. Includes
> -	  implementations for PMU and I2C.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called ams.
> -
> -config SENSORS_AMS_PMU
> -	bool "PMU variant"
> -	depends on SENSORS_AMS && ADB_PMU
> -	default y
> -	help
> -	  PMU variant of motion sensor, found in late 2005 PowerBooks.
> -
> -config SENSORS_AMS_I2C
> -	bool "I2C variant"
> -	depends on SENSORS_AMS && I2C
> -	default y
> -	help
> -	  I2C variant of motion sensor, found in early 2005 PowerBooks and
> -	  iBooks.
> -
>  config SENSORS_ASB100
>  	tristate "Asus ASB100 Bach"
>  	depends on X86 && I2C && EXPERIMENTAL
> --- linux-2.6.36-rc6.orig/drivers/hwmon/Makefile	2010-10-05 10:45:16.000000000 +0200
> +++ linux-2.6.36-rc6/drivers/hwmon/Makefile	2010-10-05 11:41:34.000000000 +0200
> @@ -36,7 +36,6 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462
>  obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
>  obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
>  obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
> -obj-$(CONFIG_SENSORS_AMS)	+= ams/
>  obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
> --- linux-2.6.36-rc6.orig/drivers/macintosh/Kconfig	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc6/drivers/macintosh/Kconfig	2010-10-05 11:42:49.000000000 +0200
> @@ -256,4 +256,30 @@ config PMAC_RACKMETER
>  	  This driver provides some support to control the front panel
>            blue LEDs "vu-meter" of the XServer macs.
>  
> +config SENSORS_AMS
> +	tristate "Apple Motion Sensor driver"
> +	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
> +	select INPUT_POLLDEV
> +	help
> +	  Support for the motion sensor included in PowerBooks. Includes
> +	  implementations for PMU and I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ams.
> +
> +config SENSORS_AMS_PMU
> +	bool "PMU variant"
> +	depends on SENSORS_AMS && ADB_PMU
> +	default y
> +	help
> +	  PMU variant of motion sensor, found in late 2005 PowerBooks.
> +
> +config SENSORS_AMS_I2C
> +	bool "I2C variant"
> +	depends on SENSORS_AMS && I2C
> +	default y
> +	help
> +	  I2C variant of motion sensor, found in early 2005 PowerBooks and
> +	  iBooks.
> +
>  endif # MACINTOSH_DRIVERS
> --- linux-2.6.36-rc6.orig/drivers/macintosh/Makefile	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.36-rc6/drivers/macintosh/Makefile	2010-10-05 11:42:05.000000000 +0200
> @@ -48,3 +48,5 @@ obj-$(CONFIG_WINDFARM_PM121)	+= windfarm
>  				   windfarm_max6690_sensor.o \
>  				   windfarm_lm75_sensor.o windfarm_pid.o
>  obj-$(CONFIG_PMAC_RACKMETER)	+= rack-meter.o
> +
> +obj-$(CONFIG_SENSORS_AMS)	+= ams/
> 
> 
