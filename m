Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 0F8D1DDF21
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:10:27 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1654096wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 00:10:25 -0700 (PDT)
Message-ID: <fa686aa40710080010h3a26e728s2323e975048cf6a@mail.gmail.com>
Date: Mon, 8 Oct 2007 01:10:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 11/15] [POWERPC] Motion-PRO: Add LED support.
In-Reply-To: <4708C380.3070707@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C380.3070707@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/7/07, Marian Balakowicz <m8@semihalf.com> wrote:
>
> Add LED driver for Promess Motion-PRO board.
>
> Signed-off-by: Jan Wrobel <wrr@semihalf.com>
> ---
>
>  arch/powerpc/configs/motionpro_defconfig |    3
>  arch/powerpc/platforms/52xx/motionpro.c  |   38 +++++
>  drivers/leds/Kconfig                     |    7
>  drivers/leds/Makefile                    |    1
>  drivers/leds/leds-motionpro.c            |  221 +++++++++++++++++++++++++++++++
>  include/asm-powerpc/mpc52xx.h            |    5
>  6 files changed, 274 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/configs/motionpro_defconfig b/arch/powerpc/configs/motionpro_defconfig
> index fcce47e..ce62123 100644
> --- a/arch/powerpc/configs/motionpro_defconfig
> +++ b/arch/powerpc/configs/motionpro_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
>  # Linux kernel version: 2.6.23-rc9
> -# Fri Oct  5 12:54:17 2007
> +# Fri Oct  5 15:18:42 2007
>  #
>  # CONFIG_PPC64 is not set
>
> @@ -610,6 +610,7 @@ CONFIG_LEDS_CLASS=y
>  #
>  # LED drivers
>  #
> +CONFIG_LEDS_MOTIONPRO=y
>
>  #
>  # LED Triggers
> diff --git a/arch/powerpc/platforms/52xx/motionpro.c b/arch/powerpc/platforms/52xx/motionpro.c
> index 2cf8a47..c1bcfd2 100644
> --- a/arch/powerpc/platforms/52xx/motionpro.c
> +++ b/arch/powerpc/platforms/52xx/motionpro.c
> @@ -86,10 +86,48 @@ error:
>         iounmap(gpio);
>  }
>
> +
> +#ifdef CONFIG_LEDS_MOTIONPRO
> +
> +/* Initialize GPT register connected to LED. Turn off LED. */
> +static void motionpro_setup_led(const char *reg_path)
> +{
> +       void __iomem *reg_addr;
> +       u32 reg;
> +
> +       reg_addr = mpc52xx_find_and_map_path(reg_path);
> +       if (!reg_addr){
> +               printk(KERN_ERR __FILE__ ": "
> +                      "LED setup error: can't map GPIO register %s\n",
> +                      reg_path);
> +               return;
> +       }
> +
> +       reg = in_be32(reg_addr);
> +       reg |= MPC52xx_GPT_ENABLE_OUTPUT;
> +       reg &= ~MPC52xx_GPT_OUTPUT_1;
> +       out_be32(reg_addr, reg);

Ideally, firmware should be doing this setup.  Only do it here if
firmware cannot be updated to set these pins correctly.

> +
> +       iounmap(reg_addr);
> +}
> +
> +/* Initialize Motionpro status and ready LEDs */
> +static void motionpro_setup_leds(void)
> +{
> +       motionpro_setup_led("/soc5200@f0000000/gpt@660");
> +       motionpro_setup_led("/soc5200@f0000000/gpt@670");
> +}
> +
> +#endif
> +
>  static void __init motionpro_setup_arch(void)
>  {
>         struct device_node *np;
>
> +#ifdef CONFIG_LEDS_MOTIONPRO
> +       motionpro_setup_leds();
> +#endif

Don't bother making this conditional (Unless the LED GPIO pins can
also have another function).  This is a fixed property of the board,
so just set it up unconditionally.

> +
>         if (ppc_md.progress)
>                 ppc_md.progress("motionpro_setup_arch()", 0);
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 4468cb3..f027009 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -55,6 +55,13 @@ config LEDS_TOSA
>           This option enables support for the LEDs on Sharp Zaurus
>           SL-6000 series.
>
> +config LEDS_MOTIONPRO
> +       tristate "Motionpro LEDs Support"
> +       depends on LEDS_CLASS
> +       help
> +         This option enables support for status and ready LEDs connected
> +         to GPIO lines on Motionpro board.
> +
>  config LEDS_S3C24XX
>         tristate "LED Support for Samsung S3C24XX GPIO LEDs"
>         depends on LEDS_CLASS && ARCH_S3C2410
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index f8995c9..6b45be1 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_NET48XX)            += leds-net48xx.o
>  obj-$(CONFIG_LEDS_WRAP)                        += leds-wrap.o
>  obj-$(CONFIG_LEDS_H1940)               += leds-h1940.o
>  obj-$(CONFIG_LEDS_COBALT)              += leds-cobalt.o
> +obj-$(CONFIG_LEDS_MOTIONPRO)           += leds-motionpro.o
>  obj-$(CONFIG_LEDS_GPIO)                        += leds-gpio.o
>
>  # LED Triggers
> diff --git a/drivers/leds/leds-motionpro.c b/drivers/leds/leds-motionpro.c
> new file mode 100644
> index 0000000..273e375
> --- /dev/null
> +++ b/drivers/leds/leds-motionpro.c
> @@ -0,0 +1,221 @@
> +/*
> + * LEDs driver for the Motionpro board.
> + *
> + * Copyright (C) 2007 Semihalf
> + *
> + * Author: Jan Wrobel <wrr@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc., 51
> + * Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + *
> + * This driver enables control over Motionpro's status and ready LEDs through
> + * sysfs. LEDs can be controlled by writing to sysfs files:
> + * class/leds/motionpro-(ready|status)led/(brightness|delay_off|delay_on).
> + * See Documentation/leds-class.txt for more details
> + *
> + * Before user issues first control command via sysfs, LED blinking is
> + * controlled by the kernel. By default status LED is blinking fast and ready
> + * LED is turned off.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/leds.h>
> +
> +#include <asm/mpc52xx.h>
> +#include <asm/io.h>
> +
> +/* Led status */
> +#define LED_NOT_REGISTERED     0
> +#define LED_KERNEL_CONTROLLED  1
> +#define LED_USER_CONTROLLED    2
> +
> +
> +/* Led control bits */
> +#define LED_ON MPC52xx_GPT_OUTPUT_1
> +
> +static void mpled_set(struct led_classdev *led_cdev,
> +                     enum led_brightness brightness);
> +
> +static struct motionpro_led{
> +       /* Protects the led data */
> +       spinlock_t led_lock;
> +
> +       /* Path to led's control register DTS node */
> +       char *reg_path;
> +
> +       /* Address to access led's register */
> +       void __iomem *reg_addr;
> +
> +       int status;
> +
> +       /* Blinking timer used when led is controlled by the kernel */
> +       struct timer_list kernel_mode_timer;
> +
> +       /*
> +        * Delay between blinks when led is controlled by the kernel.
> +        * If set to 0 led blinking is off.
> +        */
> +       int kernel_mode_delay;
> +
> +       struct led_classdev classdev;
> +}led[] = {

Split the structure definition and the table declaration.  Easier to
follow if it is split.

> +       {
> +               .reg_path = "/soc5200@f0000000/gpt@660",
> +               .reg_addr = 0,
> +               .led_lock = SPIN_LOCK_UNLOCKED,
> +               .status = LED_NOT_REGISTERED,
> +               .kernel_mode_delay = HZ / 10,
> +               .classdev = {
> +                       .name = "motionpro-statusled",
> +                       .brightness_set = mpled_set,
> +                       .default_trigger = "timer",
> +               },
> +       },
> +       {
> +               .reg_path = "/soc5200@f0000000/gpt@670",
> +               .reg_addr = 0,
> +               .led_lock = SPIN_LOCK_UNLOCKED,
> +               .status = LED_NOT_REGISTERED,
> +               .kernel_mode_delay = 0,
> +               .classdev = {
> +                       .name = "motionpro-readyled",
> +                       .brightness_set = mpled_set,
> +                       .default_trigger = "timer",
> +               }
> +       }
> +};
> +
> +/* Timer event - blinks led before user takes control over it */
> +static void mpled_timer_toggle(unsigned long ptr)
> +{
> +       struct motionpro_led *mled = (struct motionpro_led *) ptr;
> +
> +       spin_lock_bh(&mled->led_lock);
> +       if (mled->status == LED_KERNEL_CONTROLLED){
> +               u32 reg = in_be32(mled->reg_addr);
> +               reg ^= LED_ON;
> +               out_be32(mled->reg_addr, reg);
> +               led->kernel_mode_timer.expires = jiffies +
> +                       led->kernel_mode_delay;
> +               add_timer(&led->kernel_mode_timer);
> +       }
> +       spin_unlock_bh(&mled->led_lock);
> +}
> +
> +
> +/*
> + * Turn on/off led according to user settings in sysfs.
> + * First call to this function disables kernel blinking.
> + */
> +static void mpled_set(struct led_classdev *led_cdev,
> +                     enum led_brightness brightness)
> +{
> +       struct motionpro_led *mled;
> +       u32 reg;
> +
> +       mled = container_of(led_cdev, struct motionpro_led, classdev);
> +
> +       spin_lock_bh(&mled->led_lock);
> +       mled->status = LED_USER_CONTROLLED;
> +
> +       reg = in_be32(mled->reg_addr);
> +       if (brightness)
> +               reg |= LED_ON;
> +       else
> +               reg &= ~LED_ON;
> +       out_be32(mled->reg_addr, reg);
> +
> +       spin_unlock_bh(&mled->led_lock);
> +}
> +
> +static void mpled_init_led(void __iomem *reg_addr)
> +{
> +       u32 reg = in_be32(reg_addr);
> +       reg |= MPC52xx_GPT_ENABLE_OUTPUT;
> +       reg &= ~LED_ON;
> +       out_be32(reg_addr, reg);
> +}
> +
> +static void mpled_clean(void)
> +{
> +       int i;
> +       for (i = 0; i < sizeof(led) / sizeof(struct motionpro_led); i++){
> +               if (led[i].status != LED_NOT_REGISTERED){
> +                       spin_lock_bh(&led[i].led_lock);
> +                       led[i].status = LED_NOT_REGISTERED;
> +                       spin_unlock_bh(&led[i].led_lock);
> +                       led_classdev_unregister(&led[i].classdev);
> +               }
> +               if (led[i].reg_addr){
> +                       iounmap(led[i].reg_addr);
> +                       led[i].reg_addr = 0;
> +               }
> +       }
> +}
> +
> +static int __init mpled_init(void)
> +{
> +       int i, error;
> +
> +       for (i = 0; i < sizeof(led) / sizeof(struct motionpro_led); i++){
> +               led[i].reg_addr = mpc52xx_find_and_map_path(led[i].reg_path);
> +               if (!led[i].reg_addr){
> +                       printk(KERN_ERR __FILE__ ": "
> +                              "Error while mapping GPIO register for LED %s\n",
> +                              led[i].classdev.name);
> +                       error = -EIO;
> +                       goto err;
> +               }
> +
> +               mpled_init_led(led[i].reg_addr);
> +               led[i].status = LED_KERNEL_CONTROLLED;
> +               if (led[i].kernel_mode_delay){
> +                       init_timer(&led[i].kernel_mode_timer);
> +                       led[i].kernel_mode_timer.function = mpled_timer_toggle;
> +                       led[i].kernel_mode_timer.data = (unsigned long)&led[i];
> +                       led[i].kernel_mode_timer.expires =
> +                               jiffies + led[i].kernel_mode_delay;
> +                       add_timer(&led[i].kernel_mode_timer);
> +               }
> +
> +               if ((error = led_classdev_register(NULL, &led[i].classdev)) < 0){
> +                       printk(KERN_ERR __FILE__ ": "
> +                              "Error while registering class device for LED "
> +                              "%s\n",
> +                              led[i].classdev.name);
> +                       goto err;
> +               }
> +       }
> +
> +       printk("Motionpro LEDs driver initialized\n");
> +       return 0;
> +err:
> +       mpled_clean();
> +       return error;
> +}

What happens when a kernel is built with support for this board and
another platform?  It looks like this init code tries to setup the
LEDs unconditionally.

You might be better off renaming the gpt nodes as 'led' nodes and
writing a driver which matches something like 'promess,mp-gpt-led' in
the compatible property.  That way your driver setup code only gets
called with there is a match in the device tree.

It also makes your setup code simpler.  You don't need to hardcode the
path to the gpt node.  You just need to search for matching
'compatible' nodes.  In this case, setting the gpt device into output
mode is probably simpler as part of the led driver initialization
(again, assuming that firware hasn't set it up correctly first).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
