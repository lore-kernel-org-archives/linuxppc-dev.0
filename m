Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id AA097DDEC3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:59:10 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1581684anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jan 2008 22:59:09 -0800 (PST)
Message-ID: <fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
Date: Mon, 7 Jan 2008 23:59:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: [PATCH] Hwmon for Taco
In-Reply-To: <47831868.3030309@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
	<47831868.3030309@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
>        a problem with I2C support and want to see more of what is going
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
> +      Say Y here if you have a PIKA Warp(tm) Appliance. This driver is
> +      required for the DTM to work properly.
> +

This patch should be split in 2; one for the AD7414 driver and one for
the thermal management driver.

>  endif # HWMON
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 55595f6..0c6ee71 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_W83791D)    += w83791d.o
>
>  obj-$(CONFIG_SENSORS_ABITUGURU)    += abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
> +obj-$(CONFIG_SENSORS_AD7414)    += ad7414.o
>  obj-$(CONFIG_SENSORS_AD7418)    += ad7418.o
>  obj-$(CONFIG_SENSORS_ADM1021)    += adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)    += adm1025.o
> @@ -69,7 +70,8 @@ obj-$(CONFIG_SENSORS_VT8231)    += vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)    += w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)    += w83l785ts.o
>
> +obj-$(CONFIG_PIKA_DTM)        += pika-dtm.o
> +
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
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
> +        int temp = ad7414_get_temp();
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
> +    if((np = of_find_compatible_node(NULL, NULL, "pika,fpga")) == NULL) {
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
> +       (dtm_fpga = ioremap(res.start + 0x20, 4)) == NULL) {
> +        printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
> +        return -ENOENT;
> +    }
> +
> +    dtm_thread = kthread_run(pika_dtm_thread, NULL, "pika-dtm");
> +
> +    if(IS_ERR(dtm_thread)) {
> +        iounmap(dtm_fpga);
> +        printk(KERN_ERR __FILE__ ": Unable to start PIKA DTM thread\n");
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
> + * Copyright 2006 Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * Based on ad7418.c
> + * Copyright 2006 Tower Technologies, Alessandro Zummo
> <a.zummo@towertech.it>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
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
> +static unsigned short normal_i2c[] = { 0x48, 0x4a, I2C_CLIENT_END };
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
> +    char            valid;        /* !=0 if following fields are valid */
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
> +static int ad7414_detect(struct i2c_adapter *adapter, int address, int
> kind);
> +static int ad7414_detach_client(struct i2c_client *client);
> +
> +static struct i2c_driver ad7414_driver = {
> +    .driver = {
> +        .name    = "ad7414",
> +    },
> +    .attach_adapter    = ad7414_attach_adapter,
> +    .detach_client    = ad7414_detach_client,
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
> +/* All registers are word-sized, except for the configuration registers.
> + * AD7414 uses a high-byte first convention, which is exactly opposite to
> + * the usual practice.
> + */
> +static int ad7414_read(struct i2c_client *client, u8 reg)
> +{
> +    if (reg == AD7414_REG_TEMP)
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
> +    ad7414_dev = &client->dev;

ick.

> +}
> +
> +static struct ad7414_data *ad7414_update_device(struct device *dev)
> +{
> +    struct i2c_client *client = to_i2c_client(dev);
> +    struct ad7414_data *data = i2c_get_clientdata(client);
> +
> +    mutex_lock(&data->lock);
> +
> +    if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +        || !data->valid) {
> +        dev_dbg(&client->dev, "starting ad7414 update\n");
> +
> +        data->temp_input = ad7414_read(client, AD7414_REG_TEMP);
> +        data->temp_alert = (data->temp_input >> 5) & 0x01;
> +        data->temp_max_flag = (data->temp_input >> 4) & 0x01;
> +        data->temp_min_flag = (data->temp_input >> 3) & 0x01;
> +        data->temp_max = ad7414_read(client, AD7414_REG_T_HIGH);
> +        data->temp_min = ad7414_read(client, AD7414_REG_T_LOW);
> +
> +        data->last_updated = jiffies;
> +        data->valid = 1;
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
> +        struct ad7414_data *data = ad7414_update_device(ad7414_dev);
> +        return data->temp_input;
> +    } else
> +        return 0x1f4; // +125

Style; c++ comment

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
