Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 9E77FB7D6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Jun 2010 09:40:04 +1000 (EST)
Received: by gxk5 with SMTP id 5so740831gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Jun 2010 16:40:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
References: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
	<1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 17:39:43 -0600
Message-ID: <AANLkTil8rrJIS99nVlgCbNre9VbgsXy22H8i51NzXilT@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] powerpc/5200: add mpc5200_psc_ac97_gpio_reset
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 14, 2010 at 3:55 PM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> Work around a silicon bug in the ac97 reset functionality of the
> mpc5200(b). =A0The implementation of the ac97 "cold" reset is flawed.
> If the sync and output lines are high when reset is asserted the
> attached ac97 device may go into test mode. =A0Avoid this by
> reconfiguring the psc to gpio mode and generating the reset manually.
>
> From MPC5200B User's Manual:
> "Some AC97 devices goes to a test mode, if the Sync line is high
> during the Res line is low (reset phase). To avoid this behavior the
> Sync line must be also forced to zero during the reset phase. To do
> that, the pin muxing should switch to GPIO mode and the GPIO control
> register should be used to control the output lines."
>
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
>
> changes since v1
> - Refactored to manipulate port_config and gpio pins internally instead o=
f
> =A0exporting an API.
>
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0103 ++++++++++++++++=
++++++++++
> =A02 files changed, 104 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index b664ce7..1f41382 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -271,6 +271,7 @@ struct mpc52xx_intr {
> =A0/* mpc52xx_common.c */
> =A0extern void mpc5200_setup_xlb_arbiter(void);
> =A0extern void mpc52xx_declare_of_platform_devices(void);
> +extern int mpc5200_psc_ac97_gpio_reset(int psc_number);
> =A0extern void mpc52xx_map_common_devices(void);
> =A0extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
> =A0extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/=
platforms/52xx/mpc52xx_common.c
> index a46bad0..a9866fa 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -12,9 +12,11 @@
>
> =A0#undef DEBUG
>
> +#include <linux/gpio.h>
> =A0#include <linux/kernel.h>
> =A0#include <linux/spinlock.h>
> =A0#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> =A0#include <asm/io.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/mpc52xx.h>
> @@ -37,6 +39,11 @@ static struct of_device_id mpc52xx_bus_ids[] __initdat=
a =3D {
> =A0 =A0 =A0 =A0{}
> =A0};
>
> +static struct of_device_id mpc52xx_gpio_simple[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200-gpio", },
> + =A0 =A0 =A0 {}
> +};
> +
> =A0/*
> =A0* This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_res=
tart().
> =A0* Permanent mapping is required because mpc52xx_restart() can be calle=
d
> @@ -82,6 +89,13 @@ mpc5200_setup_xlb_arbiter(void)
> =A0 =A0 =A0 =A0iounmap(xlb);
> =A0}
>
> +/*
> + * This variable is mapped in mpc52xx_write_port_config() and
> + * mpc52xx_read_port_config().
> + */
> +DEFINE_SPINLOCK(mpc52xx_gpio_lock);

You don't need to define a new spin lock.  Hold the spin lock already
defined in mpc52xx_gpio.c (see below)

> +static u32 __iomem *port_config;
> +
> =A0/**
> =A0* mpc52xx_declare_of_platform_devices: register internal devices and c=
hildren
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 of the localplus bus to the of_platform
> @@ -117,6 +131,7 @@ void __init
> =A0mpc52xx_map_common_devices(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> + =A0 =A0 =A0 const u32 *regaddr;
>
> =A0 =A0 =A0 =A0/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
> =A0 =A0 =A0 =A0 * possibly from a interrupt context. wdt is only implemen=
t
> @@ -135,6 +150,13 @@ mpc52xx_map_common_devices(void)
> =A0 =A0 =A0 =A0np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
> =A0 =A0 =A0 =A0mpc52xx_cdm =3D of_iomap(np, 0);
> =A0 =A0 =A0 =A0of_node_put(np);
> +
> + =A0 =A0 =A0 /* port_config register */
> + =A0 =A0 =A0 np =3D of_find_matching_node(NULL, mpc52xx_gpio_simple);
> + =A0 =A0 =A0 regaddr =3D of_get_address(np, 0, NULL, NULL);
> + =A0 =A0 =A0 port_config =3D ioremap((u32) of_translate_address(np, rega=
ddr), 0x4);
> +
> + =A0 =A0 =A0 of_node_put(np);
> =A0}
>
> =A0/**
> @@ -233,3 +255,84 @@ mpc52xx_restart(char *cmd)
>
> =A0 =A0 =A0 =A0while (1);
> =A0}
> +
> +#define PSC1_RESET =A0 =A0 254
> +#define PSC1_SYNC =A0 =A0 =A0244
> +#define PSC1_SDATA_OUT 246
> +#define PSC2_RESET =A0 =A0 253
> +#define PSC2_SYNC =A0 =A0 =A0240
> +#define PSC2_SDATA_OUT 242

These numbers are dynamically assigned.  You cannot rely on them being
fixed.  You'll need to use the hardware GPIO numbers.

However, as long as you're holding the existing gpio_lock, I've got no
problem with you sidestepping the GPIO api and accessing the registers
directly.  It doesn't need to integrate with the gpio api because the
value of those GPIO signals is irrelevant after port_config is
switched back to PSC ac97 mode.  (Just make sure you use
setbits32()/clrbits32() so you don't disturb the other GPIO line
settings.)

Cheers,
g.

> +#define MPC52xx_GPIO_PSC1_MASK 0x7
> +#define MPC52xx_GPIO_PSC2_MASK (0x7<<4)
> +
> +/**
> + * mpc5200_psc_ac97_gpio_reset: Use gpio pins to reset the ac97 bus
> + *
> + * @psc: psc number to reset (only psc 1 and 2 support ac97)
> + */
> +int mpc5200_psc_ac97_gpio_reset(int psc_number)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 u32 gpio;
> + =A0 =A0 =A0 u32 mux;
> + =A0 =A0 =A0 int out;
> + =A0 =A0 =A0 int reset;
> + =A0 =A0 =A0 int sync;
> +
> + =A0 =A0 =A0 if (!port_config)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 switch (psc_number) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset =A0 =3D PSC1_RESET; =A0 =A0 =A0 =A0 =
=A0 /* AC97_1_RES */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =A0 =A0=3D PSC1_SYNC; =A0 =A0 =A0 =A0 =
=A0 =A0/* AC97_1_SYNC */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out =A0 =A0 =3D PSC1_SDATA_OUT; =A0 =A0 =A0=
 /* AC97_1_SDATA_OUT */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio =A0 =A0=3D MPC52xx_GPIO_PSC1_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset =A0 =3D PSC2_RESET; =A0 =A0 =A0 =A0 =
=A0 /* AC97_2_RES */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =A0 =A0=3D PSC2_SYNC; =A0 =A0 =A0 =A0 =
=A0 =A0/* AC97_2_SYNC */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out =A0 =A0 =3D PSC2_SDATA_OUT; =A0 =A0 =A0=
 /* AC97_2_SDATA_OUT */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio =A0 =A0=3D MPC52xx_GPIO_PSC2_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR __FILE__ ": "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to determine PSC, no ac=
97 cold-reset will be "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "performed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpio_request(reset, "reset");
> + =A0 =A0 =A0 gpio_request(sync, "sync");
> + =A0 =A0 =A0 gpio_request(out, "out");
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&mpc52xx_gpio_lock, flags);
> +
> + =A0 =A0 =A0 mux =3D in_be32(port_config);
> +
> + =A0 =A0 =A0 /* Reconfiure pin-muxing to gpio */
> + =A0 =A0 =A0 out_be32(port_config, mux & (~gpio));
> +
> + =A0 =A0 =A0 /* Assert cold reset */
> + =A0 =A0 =A0 gpio_direction_output(sync, 0);
> + =A0 =A0 =A0 gpio_direction_output(out, 0);
> + =A0 =A0 =A0 gpio_direction_output(reset, 0);
> +
> + =A0 =A0 =A0 /* wait at lease 1 us */
> + =A0 =A0 =A0 udelay(2);
> +
> + =A0 =A0 =A0 /* Deassert reset */
> + =A0 =A0 =A0 gpio_direction_output(reset, 1);
> +
> + =A0 =A0 =A0 /* Restore pin-muxing */
> + =A0 =A0 =A0 out_be32(port_config, mux);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mpc52xx_gpio_lock, flags);
> +
> + =A0 =A0 =A0 gpio_free(out);
> + =A0 =A0 =A0 gpio_free(sync);
> + =A0 =A0 =A0 gpio_free(reset);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mpc5200_psc_ac97_gpio_reset);
> --
> -DISCLAIMER: an automatically appended disclaimer may follow. By posting-
> -to a public e-mail mailing list I hereby grant permission to distribute-
> -and copy this message.-
>
> 1.6.3.1
>
>
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>
> Thank you.
>
> Please consider the environment before printing this email.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
