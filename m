Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id C27D5DE870
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 05:11:48 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2860234wxd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 12:11:47 -0700 (PDT)
Message-ID: <fa686aa40804241211n69637dh77278d758375a362@mail.gmail.com>
Date: Thu, 24 Apr 2008 13:11:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add gpiolib support for mpc5200
In-Reply-To: <20080424153659.GJ6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080424153659.GJ6692@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 9:36 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi all,
>
>  Feel free to comment on this.
>
>  Sascha
>
>
>  This patch adds gpiolib support for mpc5200 SOCs. I'm not sure
>  whether it's a good idea to make this optional via kconfig.
>  The gpt devices only support a single gpio. In the current of_gpio
>  implementation each chip consumes 32 GPIOs which leads to huge
>  gaps.
>
>  Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Looks pretty good.  You've saved me the need to go write a driver
myself.  Comments below, but I'll pull it into my tree and give it a
spin.

I don't see any mechanism for setting the open drain state of the pin.
 That will either need to be done by platform code or encoded into the
device tree.  Does the OF gpio infrastructure provide any callback to
the driver when something requests the pin?  That would seem to be the
ideal place to set the open drain state.

You'll also need to document the format of the gpio pin specifier for
these devices (ie. first cell is GPIO number, second cell is ????).

As for the wide spans caused by gpt gpios, it is probably okay for
now, but we can rework it to do something clever (like have a single
registration for all gpt gpios) at a later date.

Cheers,
g.

>
>  ---
>   arch/powerpc/platforms/52xx/Kconfig        |    6
>   arch/powerpc/platforms/52xx/Makefile       |    2
>   arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  408 +++++++++++++++++++++++++++++
>   3 files changed, 416 insertions(+)
>
>  Index: arch/powerpc/platforms/52xx/mpc52xx_gpio.c
>  ===================================================================
>  --- /dev/null
>  +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
>  @@ -0,0 +1,408 @@
>  +/*
>  + * MPC52xx gpio driver
>  + *
>  + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
>  + *
>  + * This program is free software; you can redistribute it and/or modify
>  + * it under the terms of the GNU General Public License version 2
>  + * as published by the Free Software Foundation.
>  + *
>  + * This program is distributed in the hope that it will be useful,
>  + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  + * GNU General Public License for more details.
>  + *
>  + * You should have received a copy of the GNU General Public License
>  + * along with this program; if not, write to the Free Software
>  + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>  + */
>  +
>  +#include <linux/of.h>
>  +#include <linux/kernel.h>
>  +#include <linux/of_gpio.h>
>  +#include <linux/io.h>
>  +#include <asm/of_platform.h>
>  +#include <asm/prom.h>
>  +#include <asm/gpio.h>
>  +#include <asm/mpc52xx.h>
>  +#include <sysdev/fsl_soc.h>
>  +
>  +static DEFINE_SPINLOCK(gpio_lock);
>  +
>  +/*
>  + * GPIO LIB API implementation for wakeup GPIOs.
>  + *
>  + * There's a maximum of 8 wakeup GPIOs. Which of these are available
>  + * for use depends on your board setup.
>  + *
>  + * 0 -> GPIO_WKUP_7
>  + * 1 -> GPIO_WKUP_6
>  + * 2 -> PSC6_1
>  + * 3 -> PSC6_0
>  + * 4 -> ETH_17
>  + * 5 -> PSC3_9
>  + * 6 -> PSC2_4
>  + * 7 -> PSC1_4
>  + *
>  + */
>  +static int mpc52xx_wkup_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
>  +       unsigned int ret;
>  +
>  +       ret = (in_8(&regs->wkup_ival) >> (7 - gpio)) & 1;
>  +
>  +       pr_debug("%s: gpio: %d ret: %d\n", __func__, gpio, ret);

dev_dbg maybe?

>  +
>  +       return ret;
>  +}
>  +
>  +static void mpc52xx_wkup_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       tmp = in_8(&regs->wkup_dvo);
>  +       if (val)
>  +               tmp |= 1 << (7 - gpio);
>  +       else
>  +               tmp &= ~(1 << (7 - gpio));
>  +       out_8(&regs->wkup_dvo, tmp);

Rather than read/modify/write of the device register; the function
would probably be faster (one fewer barrier) if you used a shadow
register of the pin state and the critical region would be
shorter/simpler.  Also, while this device doesn't have the side
effects associated with shared input/output register, it might still
be good form to use a shadow register just for the sake of clarity.

>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +}
>  +
>  +static int mpc52xx_wkup_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       tmp = in_8(&regs->wkup_ddr);
>  +       tmp &= ~(1 << (7 - gpio));
>  +       out_8(&regs->wkup_ddr, tmp);
>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       return 0;
>  +}
>  +
>  +static int mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       /* First set initial value */
>  +       mpc52xx_wkup_gpio_set(gc, gpio, val);
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       /* Then set direction */
>  +       tmp = in_8(&regs->wkup_ddr);
>  +       tmp |= 1 << (7 - gpio);
>  +       out_8(&regs->wkup_ddr, tmp);
>  +
>  +       /* Finally enable the pin */
>  +       tmp = in_8(&regs->wkup_gpioe);
>  +       tmp |= 1 << (7 - gpio);
>  +       out_8(&regs->wkup_gpioe, tmp);

Do you want/need the cost of enabling the pin every time dir_out is
called?  Can it be done when the pin is requested instead?  Or by the
board firmware/platform code?  Some drivers (for example the i2c
bitbang driver for the clock signal; see i2c-gpio.c) change the state
by changing the direction of the pin.

>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +
>  +       return 0;
>  +}
>  +
>  +static int __devinit mpc52xx_wkup_gpiochip_probe(struct of_device *ofdev,
>  +                                    const struct of_device_id *match)
>  +{
>  +       struct of_mm_gpio_chip *mmchip;
>  +       struct of_gpio_chip *chip;
>  +
>  +       mmchip = kzalloc(sizeof(*mmchip), GFP_KERNEL);
>  +       if (!mmchip)
>  +               return -ENOMEM;
>  +
>  +       chip = &mmchip->of_gc;
>  +
>  +       chip->gpio_cells          = 2;
>  +       chip->gc.ngpio            = 8;
>  +       chip->gc.direction_input  = mpc52xx_wkup_gpio_dir_in;
>  +       chip->gc.direction_output = mpc52xx_wkup_gpio_dir_out;
>  +       chip->gc.get              = mpc52xx_wkup_gpio_get;
>  +       chip->gc.set              = mpc52xx_wkup_gpio_set;
>  +
>  +       return of_mm_gpiochip_add(ofdev->node, mmchip);
>  +}
>  +
>  +static int mpc52xx_gpiochip_remove(struct of_device *ofdev)
>  +{
>  +       return -EBUSY;
>  +}
>  +
>  +static struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
>  +       {
>  +               .compatible = "fsl,mpc5200-gpio-wkup",
>  +       },
>  +       {}
>  +};
>  +
>  +static struct of_platform_driver mpc52xx_wkup_gpiochip_driver = {
>  +       .name = "gpio_wkup",
>  +       .match_table = mpc52xx_wkup_gpiochip_match,
>  +       .probe = mpc52xx_wkup_gpiochip_probe,
>  +       .remove = mpc52xx_gpiochip_remove,
>  +};
>  +
>  +/*
>  + * GPIO LIB API implementation for simple GPIOs
>  + *
>  + * There's a maximum of 32 simple GPIOs. Which of these are available
>  + * for use depends on your board setup.
>  + * The numbering reflects the bit numbering in the port registers:
>  + *
>  + *  0..1  > reserved
>  + *  2..3  > IRDA
>  + *  4..7  > ETHR
>  + *  8..11 > reserved
>  + * 12..15 > USB
>  + * 16..17 > reserved
>  + * 18..23 > PSC3
>  + * 24..27 > PSC2
>  + * 28..31 > PSC1
>  + */
>  +static int mpc52xx_simple_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
>  +       unsigned int ret;
>  +
>  +       ret = (in_be32(&regs->simple_ival) >> (31 - gpio)) & 1;
>  +
>  +       return ret;
>  +}
>  +
>  +static void mpc52xx_simple_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       tmp = in_be32(&regs->simple_dvo);
>  +       if (val)
>  +               tmp |= 1 << (31 - gpio);
>  +       else
>  +               tmp &= ~(1 << (31 - gpio));
>  +       out_be32(&regs->simple_dvo, tmp);
>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +}
>  +
>  +static int mpc52xx_simple_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       tmp = in_be32(&regs->simple_ddr);
>  +       tmp &= ~(1 << (31 - gpio));
>  +       out_be32(&regs->simple_ddr, tmp);
>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       return 0;
>  +}
>  +
>  +static int mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpio *regs = mm_gc->regs;
>  +       unsigned int tmp;
>  +       unsigned long flags;
>  +
>  +       /* First set initial value */
>  +       mpc52xx_simple_gpio_set(gc, gpio, val);
>  +
>  +       spin_lock_irqsave(&gpio_lock, flags);
>  +
>  +       /* Then set direction */
>  +       tmp = in_be32(&regs->simple_ddr);
>  +       tmp |= 1 << (31 - gpio);
>  +       out_be32(&regs->simple_ddr, tmp);
>  +
>  +       /* Finally enable the pin */
>  +       tmp = in_be32(&regs->simple_gpioe);
>  +       tmp |= 1 << (31 - gpio);
>  +       out_be32(&regs->simple_gpioe, tmp);

ditto here

>  +
>  +       spin_unlock_irqrestore(&gpio_lock, flags);
>  +
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +
>  +       return 0;
>  +}
>  +
>  +static int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofdev,
>  +                                    const struct of_device_id *match)
>  +{
>  +       struct of_mm_gpio_chip *mmchip;
>  +       struct of_gpio_chip *chip;
>  +
>  +       mmchip = kzalloc(sizeof(*mmchip), GFP_KERNEL);
>  +       if (!mmchip)
>  +               return -ENOMEM;
>  +
>  +       chip = &mmchip->of_gc;
>  +
>  +       chip->gpio_cells          = 2;
>  +       chip->gc.ngpio            = 32;
>  +       chip->gc.direction_input  = mpc52xx_simple_gpio_dir_in;
>  +       chip->gc.direction_output = mpc52xx_simple_gpio_dir_out;
>  +       chip->gc.get              = mpc52xx_simple_gpio_get;
>  +       chip->gc.set              = mpc52xx_simple_gpio_set;
>  +
>  +       return of_mm_gpiochip_add(ofdev->node, mmchip);
>  +}
>  +
>  +static struct of_device_id mpc52xx_simple_gpiochip_match[] = {
>  +       {
>  +               .compatible = "fsl,mpc5200-gpio",
>  +       },
>  +       {}
>  +};
>  +
>  +static struct of_platform_driver mpc52xx_simple_gpiochip_driver = {
>  +       .name = "gpio",
>  +       .match_table = mpc52xx_simple_gpiochip_match,
>  +       .probe = mpc52xx_simple_gpiochip_probe,
>  +       .remove = mpc52xx_gpiochip_remove,
>  +};
>  +
>  +/*
>  + * GPIO LIB API implementation for gpt GPIOs.
>  + *
>  + * Each gpt only has a single GPIO.
>  + */
>  +static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
>  +       unsigned int ret;
>  +
>  +       return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
>  +
>  +       return ret;
>  +}
>  +
>  +static void mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
>  +
>  +       if (val)
>  +               out_be32(&regs->mode, 0x34);
>  +       else
>  +               out_be32(&regs->mode, 0x24);
>  +
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +}
>  +
>  +static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  +{
>  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  +       struct mpc52xx_gpt *regs = mm_gc->regs;
>  +
>  +       out_be32(&regs->mode, 0x04);
>  +
>  +       return 0;
>  +}
>  +
>  +static int mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  +{
>  +       mpc52xx_gpt_gpio_set(gc, gpio, val);
>  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
>  +
>  +       return 0;
>  +}
>  +
>  +static int __devinit mpc52xx_gpt_gpiochip_probe(struct of_device *ofdev,
>  +                                    const struct of_device_id *match)
>  +{
>  +       struct of_mm_gpio_chip *mmchip;
>  +       struct of_gpio_chip *chip;
>  +
>  +       mmchip = kzalloc(sizeof(*mmchip), GFP_KERNEL);
>  +       if (!mmchip)
>  +               return -ENOMEM;
>  +
>  +       chip = &mmchip->of_gc;
>  +
>  +       chip->gpio_cells          = 2;
>  +       chip->gc.ngpio            = 1;
>  +       chip->gc.direction_input  = mpc52xx_gpt_gpio_dir_in;
>  +       chip->gc.direction_output = mpc52xx_gpt_gpio_dir_out;
>  +       chip->gc.get              = mpc52xx_gpt_gpio_get;
>  +       chip->gc.set              = mpc52xx_gpt_gpio_set;
>  +
>  +       return of_mm_gpiochip_add(ofdev->node, mmchip);
>  +}
>  +
>  +static struct of_device_id mpc52xx_gpt_gpiochip_match[] = {
>  +       {
>  +               .compatible = "fsl,mpc5200-gpt-gpio",
>  +       },
>  +       {}
>  +};
>  +
>  +static struct of_platform_driver mpc52xx_gpt_gpiochip_driver = {
>  +       .name = "gpio_gpt",
>  +       .match_table = mpc52xx_gpt_gpiochip_match,
>  +       .probe = mpc52xx_gpt_gpiochip_probe,
>  +       .remove = mpc52xx_gpiochip_remove,
>  +};
>  +
>  +static int __init mpc52xx_gpio_init(void)
>  +{
>  +       if (of_register_platform_driver(&mpc52xx_wkup_gpiochip_driver))
>  +               printk(KERN_ERR "Unable to register wakeup GPIO driver\n");
>  +
>  +       if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
>  +               printk(KERN_ERR "Unable to register simple GPIO driver\n");
>  +
>  +       if (of_register_platform_driver(&mpc52xx_gpt_gpiochip_driver))
>  +               printk(KERN_ERR "Unable to register gpt GPIO driver\n");
>  +
>  +       return 0;
>  +}
>  +
>  +
>  +/* Make sure we get initialised before anyone else tries to use us */
>  +subsys_initcall(mpc52xx_gpio_init);
>  +
>  +/* No exit call at the moment as we cannot unregister of gpio chips */
>  +
>  +MODULE_DESCRIPTION("Freescale MPC52xx gpio driver");
>  +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
>  +MODULE_LICENSE("GPL v2");
>  +
>  Index: arch/powerpc/platforms/52xx/Kconfig
>  ===================================================================
>  --- a/arch/powerpc/platforms/52xx/Kconfig.orig
>  +++ b/arch/powerpc/platforms/52xx/Kconfig
>  @@ -44,3 +44,9 @@ config PPC_MPC5200_BUGFIX
>
>           It is safe to say 'Y' here
>
>  +config PPC_MPC5200_GPIO
>  +       bool "MPC5200 GPIO support"
>  +       depends on PPC_MPC52xx
>  +       select HAVE_GPIO_LIB
>  +       help
>  +         Enable gpiolib support for mpc5200 based boards
>  Index: arch/powerpc/platforms/52xx/Makefile
>  ===================================================================
>  --- a/arch/powerpc/platforms/52xx/Makefile.orig
>  +++ b/arch/powerpc/platforms/52xx/Makefile
>  @@ -14,3 +14,5 @@ obj-$(CONFIG_PM)              += mpc52xx_sleep.o mpc
>   ifeq ($(CONFIG_PPC_LITE5200),y)
>         obj-$(CONFIG_PM)        += lite5200_sleep.o lite5200_pm.o
>   endif
>  +
>  +obj-$(CONFIG_PPC_MPC5200_GPIO) += mpc52xx_gpio.o
>  \ No newline at end of file
>
>  --
>  Pengutronix e.K. - Linux Solutions for Science and Industry
>  -----------------------------------------------------------
>  Kontakt-Informationen finden Sie im Header dieser Mail oder
>  auf der Webseite -> http://www.pengutronix.de/impressum/ <-
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
