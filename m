Return-Path: <jackzhang@superlink.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id 00999DE290
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 18:09:39 +1100 (EST)
Received: from unknown (HELO D600)
	(Authenticated?user:?jackzhang@superlink.com.cn@[221.219.29.19])
	(envelope-sender <jackzhang@superlink.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 8 Jan 2008 15:00:11 +0800
From: =?gb2312?B?1cXX1Me/?= <jackzhang@superlink.com.cn>
To: <linuxppc-dev@ozlabs.org>
Subject: help
Date: Tue, 8 Jan 2008 15:04:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <mailman.230.1199775553.6908.linuxppc-dev@ozlabs.org>
Message-Id: <20080108070940.00999DE290@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Help

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: =
linuxppc-dev-bounces+jackzhang=3Dsuperlink.com.cn@ozlabs.org
[mailto:linuxppc-dev-bounces+jackzhang=3Dsuperlink.com.cn@ozlabs.org] =
=B4=FA=B1=ED
linuxppc-dev-request@ozlabs.org
=B7=A2=CB=CD=CA=B1=BC=E4: 2008=C4=EA1=D4=C28=C8=D5 14:59
=CA=D5=BC=FE=C8=CB: linuxppc-dev@ozlabs.org
=D6=F7=CC=E2: Linuxppc-dev Digest, Vol 41, Issue 56

Send Linuxppc-dev mailing list submissions to
	linuxppc-dev@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-dev
or, via email, send a message with subject or body 'help' to
	linuxppc-dev-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-dev-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-dev digest..."


Today's Topics:

   1. Re: [PATCH] Fix remainder calculating bug in single floating
      point	division (Kumar Gala)
   2. Re: [PATCH] Fix carry bug in 128-bit unsigned integer adding
      (Kumar Gala)
   3. Re: [PATCH] Hwmon for Taco (Sean MacLennan)
   4. Re: [PATCH] i2c-ibm_iic driver - new patch (Stephen Rothwell)
   5. Re: [PATCH] Hwmon for Taco (Grant Likely)


----------------------------------------------------------------------

Message: 1
Date: Tue, 8 Jan 2008 00:22:25 -0600
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix remainder calculating bug in single floating
	point	division
To: Liu Yu <Yu.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Message-ID: <CC561FA6-0590-4BC0-B42B-7EE1B379CE8E@kernel.crashing.org>
Content-Type: text/plain; charset=3DUS-ASCII; format=3Dflowed; =
delsp=3Dyes


On Jan 6, 2008, at 8:26 AM, Liu Yu wrote:

> This bug exists in the emulation of floating point division for =20
> powerpc.
>
> The original code cannot count the remainder correctly.
> I can provide a test case to trigger this bug.
> When use fdiv to count 1.1754941e-38f / 0.9999999f,
> the result is expected to be 1.175494e-38f,
> but we will get 1.174921e-38f in the original case.
>
> Comments are always welcomed!

can you provide the test case that shows the error.

- k



------------------------------

Message: 2
Date: Tue, 8 Jan 2008 00:27:59 -0600
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix carry bug in 128-bit unsigned integer adding
To: Liu Yu <Yu.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Message-ID: <7040EDB2-7E89-4BBD-A4FC-50E168F9286F@kernel.crashing.org>
Content-Type: text/plain; charset=3DUS-ASCII; format=3Dflowed; =
delsp=3Dyes


On Jan 6, 2008, at 8:26 AM, Liu Yu wrote:

> This bug exists in math emulation for powerpc.
> The macro define are mainly used by multiplication.
>
> When adding two unsigned operands ( r =3D x + y ),
> the carry bit can be counted by whether r is less than x.
> However, when adding three unsigned operands, this method does not =20
> work.
>
> The original code below uses this method to count carry,
> it apparently overlook the case of three operands.
> Assume all the operands is 32-bit wide,
> ( r =3D x + y + last_carry , x =3D 0, y =3D 0xffffffff, last_carry =3D =
1),
> then r is no less than x but it actually gets a carry.
>
> I tried to fix this bug, but this patch seems not that pretty.
> Are there any better ideas?
> Comments are always welcomed!

take a look at how include/math-emu/op-4.h implements __FP_FRAC_ADD_4 =20
& __FP_FRAC_SUB_4.  Will that fix the bug, if so we should make the =20
code match how its done there.

- k



------------------------------

Message: 3
Date: Tue, 08 Jan 2008 01:30:00 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Hwmon for Taco
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
Message-ID: <47831868.3030309@pikatech.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Benjamin Herrenschmidt wrote:
> That should be in the device-tree...
>
> Cheers,
> Ben.
>
>  =20

Now in the device tree. The name of the file has changed.

Cheers,
    Sean

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a0445be..1f89186 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -57,6 +57,16 @@ config SENSORS_ABITUGURU3
       This driver can also be built as a module.  If so, the module
       will be called abituguru3.
=20
+config SENSORS_AD7414
+    tristate "Analog Devices AD7414"
+    depends on I2C && EXPERIMENTAL
+    help
+      If you say yes here you get support for the Analog Devices
+      AD7414 temperature monitoring chip.
+
+      This driver can also be built as a module. If so, the module
+      will be called ad7414.
+
 config SENSORS_AD7418
     tristate "Analog Devices AD7416, AD7417 and AD7418"
     depends on I2C && EXPERIMENTAL
@@ -763,4 +773,13 @@ config HWMON_DEBUG_CHIP
       a problem with I2C support and want to see more of what is going
       on.
=20
+config PIKA_DTM
+    tristate "PIKA DTM (Dynamic Thermal Management)"
+    depends on HWMON && WARP
+    select SENSORS_AD7414
+    default y
+    help
+      Say Y here if you have a PIKA Warp(tm) Appliance. This driver is
+      required for the DTM to work properly.
+
 endif # HWMON
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 55595f6..0c6ee71 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_W83791D)    +=3D w83791d.o
=20
 obj-$(CONFIG_SENSORS_ABITUGURU)    +=3D abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+=3D abituguru3.o
+obj-$(CONFIG_SENSORS_AD7414)    +=3D ad7414.o
 obj-$(CONFIG_SENSORS_AD7418)    +=3D ad7418.o
 obj-$(CONFIG_SENSORS_ADM1021)    +=3D adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)    +=3D adm1025.o
@@ -69,7 +70,8 @@ obj-$(CONFIG_SENSORS_VT8231)    +=3D vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)    +=3D w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)    +=3D w83l785ts.o
=20
+obj-$(CONFIG_PIKA_DTM)        +=3D pika-dtm.o
+
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS +=3D -DDEBUG
 endif
-
--- /dev/null    2005-11-20 22:22:37.000000000 -0500
+++ drivers/hwmon/pika-dtm.c    2008-01-08 01:23:32.000000000 -0500
@@ -0,0 +1,87 @@
+/*
+ *  drivers/hwmon/pika-dtm.c
+ *
+ *  Overview: On the Warp, the fpga controls the fan. This provides
+ *  the temperature to the fpga.
+ *
+ *  Copyright (c) 2008 PIKA Technologies
+ *    Sean MacLennan <smaclennan@pikatech.com>
+ *
+ *  This program is free software; you can redistribute     it and/or=20
modify it
+ *  under  the terms of     the GNU General  Public License as=20
published by the
+ *  Free Software Foundation;  either version 2 of the    License, or=20
(at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+
+extern int ad7414_get_temp(void);
+
+static unsigned __iomem *dtm_fpga;
+static struct task_struct *dtm_thread;
+
+
+static int pika_dtm_thread(void *arg)
+{
+    while(!kthread_should_stop()) {
+        int temp =3D ad7414_get_temp();
+
+        // Write to FPGA
+        out_be32(dtm_fpga, temp);
+
+        set_current_state(TASK_INTERRUPTIBLE);
+        schedule_timeout(HZ);
+    }
+
+    return 0;
+}
+
+
+int __init pika_dtm_init(void)
+{
+    struct device_node *np;
+    struct resource res;
+
+    if((np =3D of_find_compatible_node(NULL, NULL, "pika,fpga")) =3D=3D =
NULL) {
+        printk(KERN_ERR __FILE__ ": Unable to find FPGA\n");
+        return -ENOENT;
+    }
+
+    /* We do not call of_iomap here since it would map in the entire
+     * fpga space, which is overkill for 4 bytes.
+     */
+    if(of_address_to_resource(np, 0, &res) ||
+       (dtm_fpga =3D ioremap(res.start + 0x20, 4)) =3D=3D NULL) {
+        printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
+        return -ENOENT;
+    }
+
+    dtm_thread =3D kthread_run(pika_dtm_thread, NULL, "pika-dtm");
+
+    if(IS_ERR(dtm_thread)) {
+        iounmap(dtm_fpga);
+        printk(KERN_ERR __FILE__ ": Unable to start PIKA DTM =
thread\n");
+        return PTR_ERR(dtm_thread);
+    }
+
+    return 0;
+}
+module_init(pika_dtm_init);
+
+
+void __exit pika_dtm_exit(void)
+{
+    kthread_stop(dtm_thread);
+    iounmap(dtm_fpga);
+}
+module_exit(pika_dtm_exit);
+
+
+MODULE_DESCRIPTION("PIKA DTM driver");
+MODULE_AUTHOR("Sean MacLennan");
+MODULE_LICENSE("GPL");
--- /dev/null    2005-11-20 22:22:37.000000000 -0500
+++ drivers/hwmon/ad7414.c    2008-01-05 20:36:06.000000000 -0500
@@ -0,0 +1,296 @@
+/*
+ * An hwmon driver for the Analog Devices AD7414
+ *
+ * Copyright 2006 Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Based on ad7418.c
+ * Copyright 2006 Tower Technologies, Alessandro Zummo=20
<a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+
+#define DRV_VERSION "0.2"
+
+/* straight from the datasheet */
+#define AD7414_TEMP_MIN (-55000)
+#define AD7414_TEMP_MAX 125000
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D { 0x48, 0x4a, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD;
+
+/* AD7414 registers */
+#define AD7414_REG_TEMP        0x00
+#define AD7414_REG_CONF        0x01
+#define AD7414_REG_T_HIGH    0x02
+#define AD7414_REG_T_LOW    0x03
+
+struct ad7414_data {
+    struct i2c_client    client;
+    struct device    *dev;
+    struct mutex        lock;
+    char            valid;        /* !=3D0 if following fields are =
valid */
+    unsigned long        last_updated;    /* In jiffies */
+    u16            temp_input;    /* Register values */
+    u8            temp_max;
+    u8            temp_min;
+    u8            temp_alert;
+    u8            temp_max_flag;
+    u8            temp_min_flag;
+};
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter);
+static int ad7414_detect(struct i2c_adapter *adapter, int address, int=20
kind);
+static int ad7414_detach_client(struct i2c_client *client);
+
+static struct i2c_driver ad7414_driver =3D {
+    .driver =3D {
+        .name    =3D "ad7414",
+    },
+    .attach_adapter    =3D ad7414_attach_adapter,
+    .detach_client    =3D ad7414_detach_client,
+};
+
+/*
+ * TEMP: 0.001C/bit (-55C to +125C)
+ * REG: (0.5C/bit, two's complement) << 7
+ */
+static inline int AD7414_TEMP_FROM_REG(u16 reg)
+{
+    /* use integer division instead of equivalent right shift to
+     * guarantee arithmetic shift and preserve the sign
+     */
+    return ((s16)reg / 128) * 500;
+}
+
+/* All registers are word-sized, except for the configuration =
registers.
+ * AD7414 uses a high-byte first convention, which is exactly opposite =
to
+ * the usual practice.
+ */
+static int ad7414_read(struct i2c_client *client, u8 reg)
+{
+    if (reg =3D=3D AD7414_REG_TEMP)
+        return swab16(i2c_smbus_read_word_data(client, reg));
+    else
+        return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int ad7414_write(struct i2c_client *client, u8 reg, u16 value)
+{
+    return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/* PIKA Taco - we need to access the temperature in kernel mode. As a
+ * hack we store the device here. This works because we only have one
+ * ad7414 chip.
+ */
+static struct device *ad7414_dev;
+
+static void ad7414_init_client(struct i2c_client *client)
+{
+    /* TODO: anything to do here??? */
+    ad7414_dev =3D &client->dev;
+}
+
+static struct ad7414_data *ad7414_update_device(struct device *dev)
+{
+    struct i2c_client *client =3D to_i2c_client(dev);
+    struct ad7414_data *data =3D i2c_get_clientdata(client);
+
+    mutex_lock(&data->lock);
+
+    if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+        || !data->valid) {
+        dev_dbg(&client->dev, "starting ad7414 update\n");
+
+        data->temp_input =3D ad7414_read(client, AD7414_REG_TEMP);
+        data->temp_alert =3D (data->temp_input >> 5) & 0x01;
+        data->temp_max_flag =3D (data->temp_input >> 4) & 0x01;
+        data->temp_min_flag =3D (data->temp_input >> 3) & 0x01;
+        data->temp_max =3D ad7414_read(client, AD7414_REG_T_HIGH);
+        data->temp_min =3D ad7414_read(client, AD7414_REG_T_LOW);
+
+        data->last_updated =3D jiffies;
+        data->valid =3D 1;
+    }
+
+    mutex_unlock(&data->lock);
+
+    return data;
+}
+
+int ad7414_get_temp(void)
+{
+    if(ad7414_dev) {
+        struct ad7414_data *data =3D ad7414_update_device(ad7414_dev);
+        return data->temp_input;
+    } else
+        return 0x1f4; // +125
+}
+EXPORT_SYMBOL(ad7414_get_temp);
+
+#define show(value) \
+static ssize_t show_##value(struct device *dev, struct device_attribute =

*attr, char *buf)        \
+{                                    \
+    struct ad7414_data *data =3D ad7414_update_device(dev);        \
+    return sprintf(buf, "%d\n", AD7414_TEMP_FROM_REG(data->value));    =
\
+}
+show(temp_input);
+
+#define show_8(value)    \
+static ssize_t show_##value(struct device *dev, struct device_attribute =

*attr, char *buf)        \
+{                                \
+    struct ad7414_data *data =3D ad7414_update_device(dev);    \
+    return sprintf(buf, "%d\n", data->value);        \
+}
+show_8(temp_max);
+show_8(temp_min);
+show_8(temp_alert);
+show_8(temp_max_flag);
+show_8(temp_min_flag);
+
+#define set(value, reg)    \
+static ssize_t set_##value(struct device *dev, struct device_attribute=20
*attr, const char *buf, size_t count)    \
+{                                \
+    struct i2c_client *client =3D to_i2c_client(dev);        \
+    struct ad7414_data *data =3D i2c_get_clientdata(client);    \
+    int temp =3D simple_strtoul(buf, NULL, 10);        \
+                                \
+    mutex_lock(&data->lock);                \
+    data->value =3D temp;                    \
+    ad7414_write(client, reg, data->value);            \
+    mutex_unlock(&data->lock);                \
+    return count;                        \
+}
+set(temp_max, AD7414_REG_T_HIGH);
+set(temp_min, AD7414_REG_T_LOW);
+
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,=20
set_temp_max);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,=20
set_temp_min);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp1_alert, S_IRUGO, show_temp_alert, NULL);
+static DEVICE_ATTR(temp1_max_flag, S_IRUGO, show_temp_max_flag, NULL);
+static DEVICE_ATTR(temp1_min_flag, S_IRUGO, show_temp_min_flag, NULL);
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter)
+{
+    if (!(adapter->class & I2C_CLASS_HWMON))
+        return 0;
+    return i2c_probe(adapter, &addr_data, ad7414_detect);
+}
+
+static struct attribute *ad7414_attributes[] =3D {
+    &dev_attr_temp1_input.attr,
+    &dev_attr_temp1_max.attr,
+    &dev_attr_temp1_min.attr,
+    &dev_attr_temp1_alert.attr,
+    &dev_attr_temp1_max_flag.attr,
+    &dev_attr_temp1_min_flag.attr,
+    NULL
+};
+
+static const struct attribute_group ad7414_group =3D {
+    .attrs =3D ad7414_attributes,
+};
+
+static int ad7414_detect(struct i2c_adapter *adapter, int address, int=20
kind)
+{
+    struct i2c_client *client;
+    struct ad7414_data *data;
+    int err =3D 0;
+
+    if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+                    I2C_FUNC_SMBUS_WORD_DATA))
+        goto exit;
+
+    if (!(data =3D kzalloc(sizeof(struct ad7414_data), GFP_KERNEL))) {
+        err =3D -ENOMEM;
+        goto exit;
+    }
+
+    client =3D &data->client;
+    client->addr =3D address;
+    client->adapter =3D adapter;
+    client->driver =3D &ad7414_driver;
+    client->flags =3D 0;
+
+    i2c_set_clientdata(client, data);
+
+    mutex_init(&data->lock);
+
+    /* TODO: not testing for AD7414 done yet... */
+
+    strlcpy(client->name, ad7414_driver.driver.name, I2C_NAME_SIZE);
+
+    if ((err =3D i2c_attach_client(client)))
+        goto exit_free;
+
+    dev_info(&client->dev, "chip found, driver version " DRV_VERSION =
"\n");
+
+    /* Initialize the AD7414 chip */
+    ad7414_init_client(client);
+
+    /* Register sysfs hooks */
+    if ((err =3D sysfs_create_group(&client->dev.kobj, &ad7414_group)))
+        goto exit_detach;
+
+    data->dev =3D hwmon_device_register(&client->dev);
+    if (IS_ERR(data->dev)) {
+        err =3D PTR_ERR(data->dev);
+        goto exit_remove;
+    }
+
+    return 0;
+
+exit_remove:
+    sysfs_remove_group(&client->dev.kobj, &ad7414_group);
+exit_detach:
+    i2c_detach_client(client);
+exit_free:
+    kfree(data);
+exit:
+    return err;
+}
+
+static int ad7414_detach_client(struct i2c_client *client)
+{
+    struct ad7414_data *data =3D i2c_get_clientdata(client);
+    ad7414_dev =3D NULL;
+    hwmon_device_unregister(data->dev);
+    sysfs_remove_group(&client->dev.kobj, &ad7414_group);
+    i2c_detach_client(client);
+    kfree(data);
+    return 0;
+}
+
+static int __init ad7414_init(void)
+{
+    return i2c_add_driver(&ad7414_driver);
+}
+
+static void __exit ad7414_exit(void)
+{
+    i2c_del_driver(&ad7414_driver);
+}
+
+MODULE_AUTHOR("Stefan Roese <sr@denx.de>");
+MODULE_DESCRIPTION("AD7414 driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ad7414_init);
+module_exit(ad7414_exit);




------------------------------

Message: 4
Date: Tue, 8 Jan 2008 17:36:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] i2c-ibm_iic driver - new patch
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,	Arnd Bergmann
	<arnd@arndb.de>
Message-ID: <20080108173636.73db1623.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=3D"us-ascii"

On Tue, 08 Jan 2008 00:56:27 -0500 Sean MacLennan =
<smaclennan@pikatech.com>
wrote:
>
> Stephen Rothwell wrote:
> >
> > On Mon, 07 Jan 2008 21:03:12 -0500 Sean MacLennan
<smaclennan@pikatech.com> wrote:
> >  =20
> > Please don't post patches as attachments.
> =20
> Ok.

Unfortunately, you are using thunderbird and so the patch is now =
wrapped.
There is a workaround, see Documentation/email-clients.txt.

> > Please split the assignments from the tests.  Here and elsewhere.
> >  =20
> I made the changes in my code. I am trying to leave the original code =
as=20
> much as possible.

Thats all we ask.

> >> +	} else {
> >> +		if (dev->irq !=3D NO_IRQ){
> >> +		    iic_interrupt_mode(dev, 0);
> >> +		    free_irq(dev->irq, dev);
> >> +		}
> >> +		iounmap(dev->vaddr);
> >> +		kfree(dev);
> >>    =20
> >
> > Should these last two be after the below brace?
> >
> >  =20
> I'm not really qualified to answer, but I will anyway ;) I assume the=20
> original author is basically saying if he cannot delete the adapter, =
it=20
> is unsafe to free the memory since the i2c code may still use it. If I =

> have read that right, then I agree.

OK, I can see that this is a "that should not happen" condition.

> +    if (iic_force_poll)
> +        dev->irq =3D NO_IRQ;
> +    else if ((dev->irq =3D irq_of_parse_and_map(np, 0)) =3D=3D =
NO_IRQ)

You missed this one.

Overall looks better, except all your indentation is now 4 spaces. We =
use
a TAB character for each level of indentation and you should be able to
set your editor to *display* the TABs as 4 places if that is what you =
like.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url :
http://ozlabs.org/pipermail/linuxppc-dev/attachments/20080108/3c5fd612/at=
tac
hment-0001.pgp=20

------------------------------

Message: 5
Date: Mon, 7 Jan 2008 23:59:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Hwmon for Taco
To: "Sean MacLennan" <smaclennan@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
Message-ID:
	<fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1

On 1/7/08, Sean MacLennan <smaclennan@pikatech.com> wrote:
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a0445be..1f89186 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -57,6 +57,16 @@ config SENSORS_ABITUGURU3
>        This driver can also be built as a module.  If so, the module
>        will be called abituguru3.
>
> +config SENSORS_AD7414
> +    tristate "Analog Devices AD7414"
> +    depends on I2C && EXPERIMENTAL
> +    help
> +      If you say yes here you get support for the Analog Devices
> +      AD7414 temperature monitoring chip.
> +
> +      This driver can also be built as a module. If so, the module
> +      will be called ad7414.
> +
>  config SENSORS_AD7418
>      tristate "Analog Devices AD7416, AD7417 and AD7418"
>      depends on I2C && EXPERIMENTAL
> @@ -763,4 +773,13 @@ config HWMON_DEBUG_CHIP
>        a problem with I2C support and want to see more of what is =
going
>        on.
>
> +config PIKA_DTM
> +    tristate "PIKA DTM (Dynamic Thermal Management)"
> +    depends on HWMON && WARP
> +    select SENSORS_AD7414

select is dangerous because it bypasses dependency checking.  Make it
'depends on' instead.

> +    default y
> +    help
> +      Say Y here if you have a PIKA Warp(tm) Appliance. This driver =
is
> +      required for the DTM to work properly.
> +

This patch should be split in 2; one for the AD7414 driver and one for
the thermal management driver.

>  endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 55595f6..0c6ee71 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_W83791D)    +=3D w83791d.o
>
>  obj-$(CONFIG_SENSORS_ABITUGURU)    +=3D abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+=3D abituguru3.o
> +obj-$(CONFIG_SENSORS_AD7414)    +=3D ad7414.o
>  obj-$(CONFIG_SENSORS_AD7418)    +=3D ad7418.o
>  obj-$(CONFIG_SENSORS_ADM1021)    +=3D adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)    +=3D adm1025.o
> @@ -69,7 +70,8 @@ obj-$(CONFIG_SENSORS_VT8231)    +=3D vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)    +=3D w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)    +=3D w83l785ts.o
>
> +obj-$(CONFIG_PIKA_DTM)        +=3D pika-dtm.o
> +
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS +=3D -DDEBUG
>  endif
> -
> --- /dev/null    2005-11-20 22:22:37.000000000 -0500
> +++ drivers/hwmon/pika-dtm.c    2008-01-08 01:23:32.000000000 -0500

This is *very* board specific and not very complex a driver.  It
should probably live with the platform code somewhere in
arch/powerpc/platforms.  You can use the machine_device_initcall()
hook to kick off the thread.

> @@ -0,0 +1,87 @@
> +/*
> + *  drivers/hwmon/pika-dtm.c
> + *
> + *  Overview: On the Warp, the fpga controls the fan. This provides
> + *  the temperature to the fpga.
> + *
> + *  Copyright (c) 2008 PIKA Technologies
> + *    Sean MacLennan <smaclennan@pikatech.com>
> + *
> + *  This program is free software; you can redistribute     it and/or
> modify it
> + *  under  the terms of     the GNU General  Public License as
> published by the
> + *  Free Software Foundation;  either version 2 of the    License, or
> (at your
> + *  option) any later version.

Your mailer chewed up the patch here (line wrap).

> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kthread.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +
> +
> +extern int ad7414_get_temp(void);

Bad!  Function decls must be in common header files.

> +
> +static unsigned __iomem *dtm_fpga;
> +static struct task_struct *dtm_thread;
> +
> +
> +static int pika_dtm_thread(void *arg)
> +{
> +    while(!kthread_should_stop()) {
> +        int temp =3D ad7414_get_temp();
> +
> +        // Write to FPGA

Style; use /* */, not //

> +        out_be32(dtm_fpga, temp);
> +
> +        set_current_state(TASK_INTERRUPTIBLE);
> +        schedule_timeout(HZ);
> +    }
> +
> +    return 0;
> +}
> +
> +
> +int __init pika_dtm_init(void)
> +{
> +    struct device_node *np;
> +    struct resource res;
> +
> +    if((np =3D of_find_compatible_node(NULL, NULL, "pika,fpga")) =
=3D=3D NULL) {
> +        printk(KERN_ERR __FILE__ ": Unable to find FPGA\n");
> +        return -ENOENT;
> +    }
> +
> +    /* We do not call of_iomap here since it would map in the entire
> +     * fpga space, which is overkill for 4 bytes.
> +     */

iomapping is not expensive; just map the whole space (it's going to
map a minimum 4k page anyway).  The code will be easier to read if you
just use of_iomap().

> +    if(of_address_to_resource(np, 0, &res) ||
> +       (dtm_fpga =3D ioremap(res.start + 0x20, 4)) =3D=3D NULL) {
> +        printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
> +        return -ENOENT;
> +    }
> +
> +    dtm_thread =3D kthread_run(pika_dtm_thread, NULL, "pika-dtm");
> +
> +    if(IS_ERR(dtm_thread)) {
> +        iounmap(dtm_fpga);
> +        printk(KERN_ERR __FILE__ ": Unable to start PIKA DTM =
thread\n");
> +        return PTR_ERR(dtm_thread);
> +    }
> +
> +    return 0;
> +}
> +module_init(pika_dtm_init);
> +
> +
> +void __exit pika_dtm_exit(void)
> +{
> +    kthread_stop(dtm_thread);
> +    iounmap(dtm_fpga);
> +}
> +module_exit(pika_dtm_exit);
> +
> +
> +MODULE_DESCRIPTION("PIKA DTM driver");
> +MODULE_AUTHOR("Sean MacLennan");
> +MODULE_LICENSE("GPL");
> --- /dev/null    2005-11-20 22:22:37.000000000 -0500
> +++ drivers/hwmon/ad7414.c    2008-01-05 20:36:06.000000000 -0500
> @@ -0,0 +1,296 @@
> +/*
> + * An hwmon driver for the Analog Devices AD7414
> + *
> + * Copyright 2006 Stefan Roese <sr@denx.de>, DENX Software =
Engineering
> + *
> + * Based on ad7418.c
> + * Copyright 2006 Tower Technologies, Alessandro Zummo
> <a.zummo@towertech.it>
> + *
> + * This program is free software; you can redistribute it and/or =
modify
> + * it under the terms of the GNU General Public License as published =
by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +
> +#define DRV_VERSION "0.2"
> +
> +/* straight from the datasheet */
> +#define AD7414_TEMP_MIN (-55000)
> +#define AD7414_TEMP_MAX 125000
> +
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] =3D { 0x48, 0x4a, I2C_CLIENT_END =
};
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD;
> +
> +/* AD7414 registers */
> +#define AD7414_REG_TEMP        0x00
> +#define AD7414_REG_CONF        0x01
> +#define AD7414_REG_T_HIGH    0x02
> +#define AD7414_REG_T_LOW    0x03
> +
> +struct ad7414_data {
> +    struct i2c_client    client;
> +    struct device    *dev;
> +    struct mutex        lock;
> +    char            valid;        /* !=3D0 if following fields are =
valid */
> +    unsigned long        last_updated;    /* In jiffies */
> +    u16            temp_input;    /* Register values */
> +    u8            temp_max;
> +    u8            temp_min;
> +    u8            temp_alert;
> +    u8            temp_max_flag;
> +    u8            temp_min_flag;
> +};
> +
> +static int ad7414_attach_adapter(struct i2c_adapter *adapter);
> +static int ad7414_detect(struct i2c_adapter *adapter, int address, =
int
> kind);
> +static int ad7414_detach_client(struct i2c_client *client);
> +
> +static struct i2c_driver ad7414_driver =3D {
> +    .driver =3D {
> +        .name    =3D "ad7414",
> +    },
> +    .attach_adapter    =3D ad7414_attach_adapter,
> +    .detach_client    =3D ad7414_detach_client,
> +};
> +
> +/*
> + * TEMP: 0.001C/bit (-55C to +125C)
> + * REG: (0.5C/bit, two's complement) << 7
> + */
> +static inline int AD7414_TEMP_FROM_REG(u16 reg)
> +{
> +    /* use integer division instead of equivalent right shift to
> +     * guarantee arithmetic shift and preserve the sign
> +     */
> +    return ((s16)reg / 128) * 500;
> +}
> +
> +/* All registers are word-sized, except for the configuration =
registers.
> + * AD7414 uses a high-byte first convention, which is exactly =
opposite to
> + * the usual practice.
> + */
> +static int ad7414_read(struct i2c_client *client, u8 reg)
> +{
> +    if (reg =3D=3D AD7414_REG_TEMP)
> +        return swab16(i2c_smbus_read_word_data(client, reg));
> +    else
> +        return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int ad7414_write(struct i2c_client *client, u8 reg, u16 value)
> +{
> +    return i2c_smbus_write_byte_data(client, reg, value);
> +}
> +
> +/* PIKA Taco - we need to access the temperature in kernel mode. As a
> + * hack we store the device here. This works because we only have one
> + * ad7414 chip.
> + */
> +static struct device *ad7414_dev;

Can you use a list_head instead?  That would allow multiple instances.

This driver shouldn't contain board specific code.

> +
> +static void ad7414_init_client(struct i2c_client *client)
> +{
> +    /* TODO: anything to do here??? */
> +    ad7414_dev =3D &client->dev;

ick.

> +}
> +
> +static struct ad7414_data *ad7414_update_device(struct device *dev)
> +{
> +    struct i2c_client *client =3D to_i2c_client(dev);
> +    struct ad7414_data *data =3D i2c_get_clientdata(client);
> +
> +    mutex_lock(&data->lock);
> +
> +    if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +        || !data->valid) {
> +        dev_dbg(&client->dev, "starting ad7414 update\n");
> +
> +        data->temp_input =3D ad7414_read(client, AD7414_REG_TEMP);
> +        data->temp_alert =3D (data->temp_input >> 5) & 0x01;
> +        data->temp_max_flag =3D (data->temp_input >> 4) & 0x01;
> +        data->temp_min_flag =3D (data->temp_input >> 3) & 0x01;
> +        data->temp_max =3D ad7414_read(client, AD7414_REG_T_HIGH);
> +        data->temp_min =3D ad7414_read(client, AD7414_REG_T_LOW);
> +
> +        data->last_updated =3D jiffies;
> +        data->valid =3D 1;
> +    }
> +
> +    mutex_unlock(&data->lock);
> +
> +    return data;
> +}
> +
> +int ad7414_get_temp(void)

maybe ad7414_get_temp(int index)?  Would allow for multiple instances.

> +{
> +    if(ad7414_dev) {
> +        struct ad7414_data *data =3D =
ad7414_update_device(ad7414_dev);
> +        return data->temp_input;
> +    } else
> +        return 0x1f4; // +125

Style; c++ comment

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


------------------------------

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

End of Linuxppc-dev Digest, Vol 41, Issue 56
********************************************
