Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id E1EBBDDE23
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:30:02 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1417523rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 12:30:02 -0800 (PST)
Message-ID: <9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
Date: Mon, 5 Nov 2007 15:30:01 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F7247.9070106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> Jon Smirl wrote:
> > This is my first pass at reworking the Freescale i2c driver. It
> > switches the driver from being a platform driver to an open firmware
> > one. I've checked it out on my hardware and it is working.
>
> We may want to hold off on this until arch/ppc goes away (or at least
> all users of this driver in arch/ppc).

How about renaming the old driver file and leaving it hooked to ppc?
Then it would get deleted when ppc goes away. That would let work
progress on the powerpc version.

I'm working on this because I'm adding codecs under powerpc that use
i2c and I want consistent device tree use.

> > You can specific i2c devices on a bus by adding child nodes for them
> > in the device tree. It does not know how to autoload the i2c chip
> > driver modules.
> >
> > i2c@3d40 {
> >       device_type = "i2c";
> >       compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
>
> dtc supports the "mpc5200b-i2c", "mpc5200-i2c", "fsl-i2c" syntax.
>
> >       cell-index = <1>;
>
> What is cell-index for?

I was using it to control the bus number, is that the wrong attribute?

> >       fsl5200-clocking;
>
> As Matt pointed out, this is redundant.
>
> >       rtc@32 {
> >               device_type = "rtc";
>
> This isn't really necessary.

Code doesn't access it. I copied it from a pre-existing device tree.

> > One side effect is that legacy style i2c drivers won't work anymore.
>
> If you mean legacy-style client drivers, why not?

i2c_new_device() doesn't work with legacy-style client drivers.

>
> > The driver contains a table for mapping device tree style names to
> > linux kernel ones.
>
> Can we please put this in common code instead?
>
> > +static struct i2c_driver_device i2c_devices[] = {
> > +     {"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
> > +     {"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
> > +     {"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
> > +     {"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
> > +     {"epson,pcf8564", "rtc-pcf8563", "pcf8564",},
> > +};
>
> At the very least, include the entries that are already being used with
> this driver in fsl_soc.c.

This is the same table from fsl_soc.c it has been moved. The data
really belongs in the i2c drivers if I can figure out how to get it
there.


> > I'd like to get rid of this table.  There are two obvious solutions,
> > use names in the device tree that match up with the linux device
> > driver names.
>
> This was proposed and rejected a while ago.  For one thing, some drivers
> handle multiple chips, and we shouldn't base device tree bindings on
> what groupings Linux happens to make in what driver supports what.
>
> > Or push these strings into the chip drivers and modify
> > i2c-core to also match on the device tree style names.
>
> That would be ideal; it just hasn't been done yet.

This is not hard to do but the i2c people will have to agree. I need
to change the i2c_driver structure to include the additional names.

> A middle ground for now would be to keep one table in drivers/of or
> something.
>
> > Without one of
> > these changes the table is going to need a mapping for every i2c
> > device on the market.
>
> Nah, only one for every i2c device Linux supports. :-)
>
> > diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> > index 1cf29c9..6f80216 100644
> > --- a/arch/powerpc/sysdev/fsl_soc.c
> > +++ b/arch/powerpc/sysdev/fsl_soc.c
> > @@ -306,122 +306,6 @@ err:
> >
> >  arch_initcall(gfar_of_init);
> >
> > -#ifdef CONFIG_I2C_BOARDINFO
> > -#include <linux/i2c.h>
> > -struct i2c_driver_device {
> > -     char    *of_device;
> > -     char    *i2c_driver;
> > -     char    *i2c_type;
> > -};
> > -
> > -static struct i2c_driver_device i2c_devices[] __initdata = {
> > -     {"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
> > -     {"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
> > -     {"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
> > -     {"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
> > -};
>
> This is obviously not based on head-of-tree -- there are several more
> entries in this table.

It is based on 2.6.23. Head of tree hasn't been working very well for
me. I'll rebase it when I can get things working again.

> > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> > index d8de4ac..5ceb936 100644
> > --- a/drivers/i2c/busses/i2c-mpc.c
> > +++ b/drivers/i2c/busses/i2c-mpc.c
> > @@ -17,7 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/sched.h>
> >  #include <linux/init.h>
> > -#include <linux/platform_device.h>
> > +#include <asm/of_platform.h>
>
> Should be linux/of_platform.h
changed
>
> > @@ -180,7 +182,7 @@ static void mpc_i2c_stop(struct mpc_i2c *i2c)
> >  static int mpc_write(struct mpc_i2c *i2c, int target,
> >                    const u8 * data, int length, int restart)
> >  {
> > -     int i;
> > +     int i, result;
> >       unsigned timeout = i2c->adap.timeout;
> >       u32 flags = restart ? CCR_RSTA : 0;
> >
> > @@ -192,15 +194,15 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
> >       /* Write target byte */
> >       writeb((target << 1), i2c->base + MPC_I2C_DR);
> >
> > -     if (i2c_wait(i2c, timeout, 1) < 0)
> > -             return -1;
> > +     if ((result = i2c_wait(i2c, timeout, 1)) < 0)
> > +             return result;
> >
> >       for (i = 0; i < length; i++) {
> >               /* Write data byte */
> >               writeb(data[i], i2c->base + MPC_I2C_DR);
> >
> > -             if (i2c_wait(i2c, timeout, 1) < 0)
> > -                     return -1;
> > +             if ((result = i2c_wait(i2c, timeout, 1)) < 0)
> > +                     return result;
> >       }
> >
> >       return 0;
>
> This is a separate change from the OF-ization -- at least note it in the
> changelog.
done
>
> > +     for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
> > +             if (!of_device_is_compatible(node, i2c_devices[i].of_device))
> > +                     continue;
> > +             strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
> > +             strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
> > +             printk("i2c driver is %s\n", info->driver_name);
>
> Should be KERN_DEBUG, if it stays at all.
deleted
>
> > +static void of_register_i2c_devices(struct i2c_adapter *adap, struct
> > device_node *adap_node)
> > +{
> > +     struct device_node *node = NULL;
> > +
> > +     while ((node = of_get_next_child(adap_node, node))) {
> > +             struct i2c_board_info info;
> > +             const u32 *addr;
> > +             int len;
> > +
> > +             addr = of_get_property(node, "reg", &len);
> > +             if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
> > +                     printk(KERN_WARNING "i2c-mpc.c: invalid i2c device entry\n");
> > +                     continue;
> > +             }
> > +
> > +             info.irq = irq_of_parse_and_map(node, 0);
> > +             if (info.irq == NO_IRQ)
> > +                     info.irq = -1;
> > +
> > +             if (of_find_i2c_driver(node, &info) < 0)
> > +                     continue;
> > +
> > +             info.platform_data = NULL;
> > +             info.addr = *addr;
> > +
> > +             i2c_new_device(adap, &info);
> > +     }
> > +}
>
> Most of this code should be made generic and placed in drivers/of.

How so, it is specific to adding i2c drivers.

>
> > +     index = of_get_property(op->node, "cell-index", NULL);
> > +    if (!index || *index > 5) {
> > +            printk(KERN_ERR "mpc_i2c_probe: Device node %s has invalid "
> > +                            "cell-index property\n", op->node->full_name);
> > +            return -EINVAL;
> > +    }
> > +
>
> We might as well just use i2c_new_device() instead of messing around
> with bus numbers.  Note that this is technically no longer platform
> code, so it's harder to justify claiming the static numberspace.

I was allowing control of the bus number with "cell-index" and
i2c_add_numbered_adapter().
Should I get rid of this and switch to i2c_add_adapter()?

>
> > +     i2c->base = ioremap((phys_addr_t)mem.start, MPC_I2C_REGION);
> >       if (!i2c->base) {
> >               printk(KERN_ERR "i2c-mpc - failed to map controller\n");
>
> Use of_iomap().

I didn't write this, how should it be done? MPC_I2C_REGION can be
eliminated by using mem.start - mem.end.

>
> >       if (i2c->irq != 0)
>
> if (i2c->irq != NO_IRQ)
>
> > +static struct of_device_id mpc_i2c_of_match[] = {
> > +     {
> > +             .type           = "i2c",
> > +             .compatible     = "fsl-i2c",
> > +     },
> > +};
> > +MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>
> Let's take this opportunity to stop matching on device_type here
> (including updating booting-without-of.txt).

Remove the .type line and leave .compatible?

>
> > +static struct of_platform_driver mpc_i2c_driver = {
> > +     .owner          = THIS_MODULE,
> > +     .name           = DRV_NAME,
> > +     .match_table    = mpc_i2c_of_match,
> > +     .probe          = mpc_i2c_probe,
> > +     .remove         = __devexit_p(mpc_i2c_remove),
> > +     .driver         = {
> > +             .name   = DRV_NAME,
> >       },
> >  };
>
> Do we still need .name if we have .driver.name?

Yes, i2c-core is matching on mpc_i2c_driver.name, i2c-core would need
to be changed to use mpc_i2c_driver.driver.name.

>
> > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> > index 0242d80..b778d35 100644
> > --- a/drivers/rtc/rtc-pcf8563.c
> > +++ b/drivers/rtc/rtc-pcf8563.c
>
> This should be a separate patch.

It will be in final form.

>
> -Scott
>

-- 
Jon Smirl
jonsmirl@gmail.com
