Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 53620B7B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:00:55 +1100 (EST)
Received: by yxe8 with SMTP id 8so479043yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 14:00:53 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257882118.14374.2@antares>
References: <1257882118.14374.2@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 13:59:39 -0700
Message-ID: <fa686aa40911101259we3c8f0bl887c57a582db1dcc@mail.gmail.com>
Subject: Re: [PATCH 2/3] mpc52xx/wdt: merge WDT code into the GPT
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 10, 2009 at 12:41 PM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Merge the WDT code into the GPT interface.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---

Hi Albrecht,

Thanks for this work.  Comments below.

>
> Notes:
>
> The maximum timeout for a 5200 GPT @ 33 MHz clock is ~130 seconds. =A0As =
this
> exceeds the range of an int, some api's had to be changed to u64.
>
> The WDT api is exported as to keep the WDT driver separated from the GPT
> driver.
>
> If GPT0 is used as WDT, this prevents the use of any GPT0 GPT function (i=
.e.
> they will fail with -EBUSY). =A0IOW, the safety function always has prece=
dence
> over the GPT function. =A0If the kernel has been compiled with
> CONFIG_WATCHDOG_NOWAYOUT, this means that GPT0 is locked in WDT mode unti=
l
> the next reboot - this may be a requirement in safety applications.

This description would look great in the header comment block of the
.c file.

Also, as I commented in patch 3; I'd rather see all the WDT
functionality rolled into this driver.  As long as you keep the
functional code blocks logically arranged, I think the driver will be
easier to maintain and understand that way.

> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0| =A0 18 ++-
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0281 +++++++++++++++++++=
+++++++---
> =A02 files changed, 270 insertions(+), 29 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_gpt.c
> index 2c3fa13..8274ebb 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -60,9 +60,13 @@
> =A0#include <asm/mpc52xx.h>
>
> =A0MODULE_DESCRIPTION("Freescale MPC52xx gpt driver");
> -MODULE_AUTHOR("Sascha Hauer, Grant Likely");
> +MODULE_AUTHOR("Sascha Hauer, Grant Likely, Albrecht Dre=DF");
> =A0MODULE_LICENSE("GPL");
>
> +#if (defined(CONFIG_MPC5200_WDT)) || (defined(CONFIG_MPC5200_WDT_MODULE)=
)
> +#define HAVE_MPC5200_WDT
> +#endif
> +
> =A0/**
> =A0* struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
> =A0* @dev: pointer to device structure
> @@ -70,6 +74,8 @@ MODULE_LICENSE("GPL");
> =A0* @lock: spinlock to coordinate between different functions.
> =A0* @of_gc: of_gpio_chip instance structure; used when GPIO is enabled
> =A0* @irqhost: Pointer to irq_host instance; used when IRQ mode is suppor=
ted
> + * @wdt_mode: only used for gpt 0: 0 gpt-only timer, 1 can be used as a
> + * =A0 =A0 =A0 =A0 =A0 =A0wdt, 2 currently used as wdt, cannot be used a=
s gpt
> =A0*/
> =A0struct mpc52xx_gpt_priv {
> =A0 =A0 =A0 =A0struct list_head list; =A0 =A0 =A0 =A0 =A0/* List of all G=
PT devices */
> @@ -78,6 +84,9 @@ struct mpc52xx_gpt_priv {
> =A0 =A0 =A0 =A0spinlock_t lock;
> =A0 =A0 =A0 =A0struct irq_host *irqhost;
> =A0 =A0 =A0 =A0u32 ipb_freq;
> +#if defined(HAVE_MPC5200_WDT)
> + =A0 =A0 =A0 u8 wdt_mode;
> +#endif

I wouldn't bother with the #if/#endif.  I'm willing to sacrifice
32bits for the sake of readability of the code.

> +#define NS_PER_SEC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000000000LL
> +
> +#define MPC52xx_GPT_CAN_WDT =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define MPC52xx_GPT_IS_WDT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
> +
> +
> =A0/* -------------------------------------------------------------------=
--
> =A0* Cascaded interrupt controller hooks
> =A0*/
> @@ -375,36 +393,22 @@ struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int i=
rq)
> =A0}
> =A0EXPORT_SYMBOL(mpc52xx_gpt_from_irq);
>
> -/**
> - * mpc52xx_gpt_start_timer - Set and enable the GPT timer
> - * @gpt: Pointer to gpt private data structure
> - * @period: period of timer
> - * @continuous: set to 1 to make timer continuous free running
> - *
> - * An interrupt will be generated every time the timer fires
> - */
> -int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int continuous)
> +/* Calculate the timer counter input register MBAR + 0x6n4 from the
> + * period in ns. =A0The maximum period for 33 MHz IPB clock is ~130s. */
> +static int mpc52xx_gpt_calc_counter_input(u64 period, u64 ipb_freq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 *reg_val)
> =A0{
> - =A0 =A0 =A0 u32 clear, set;
> =A0 =A0 =A0 =A0u64 clocks;
> =A0 =A0 =A0 =A0u32 prescale;
> - =A0 =A0 =A0 unsigned long flags;
> -
> - =A0 =A0 =A0 clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTI=
NUOUS;
> - =A0 =A0 =A0 set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER=
_ENABLE;
> - =A0 =A0 =A0 if (continuous)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set |=3D MPC52xx_GPT_MODE_CONTINUOUS;
>
> =A0 =A0 =A0 =A0/* Determine the number of clocks in the requested period.=
 =A064 bit
> =A0 =A0 =A0 =A0 * arithmatic is done here to preserve the precision until=
 the value
> - =A0 =A0 =A0 =A0* is scaled back down into the u32 range. =A0Period is i=
n 'ns', bus
> - =A0 =A0 =A0 =A0* frequency is in Hz. */
> - =A0 =A0 =A0 clocks =3D (u64)period * (u64)gpt->ipb_freq;
> - =A0 =A0 =A0 do_div(clocks, 1000000000); /* Scale it down to ns range */
> + =A0 =A0 =A0 =A0* is scaled back down into the u32 range. */
> + =A0 =A0 =A0 clocks =3D period * ipb_freq;
> + =A0 =A0 =A0 do_div(clocks, NS_PER_SEC); =A0 =A0 =A0 =A0 /* Scale it dow=
n to ns range */

Nit: I wouldn't bother with the NS_PER_SEC macro personally.  ns per s
is such a fundamental property that I'd rather see the actual number.

>
> - =A0 =A0 =A0 /* This device cannot handle a clock count greater than 32 =
bits */
> - =A0 =A0 =A0 if (clocks > 0xffffffff)
> + =A0 =A0 =A0 /* the maximum count is 0x10000 pre-scaler * 0xffff count *=
/
> + =A0 =A0 =A0 if (clocks > 0xffff0000)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;

This a bug fix?  Separate patch please.

> =A0 =A0 =A0 =A0/* Calculate the prescaler and count values from the clock=
s value.
> @@ -427,9 +431,47 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv =
*gpt, int period,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 *reg_val =3D (prescale & 0xffff) << 16 | clocks;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * mpc52xx_gpt_start_timer - Set and enable the GPT timer
> + * @gpt: Pointer to gpt private data structure
> + * @period: period of timer in ns
> + * @continuous: set to 1 to make timer continuous free running
> + *
> + * An interrupt will be generated every time the timer fires
> + */
> +int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 period,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int continuous)
> +{
> + =A0 =A0 =A0 u32 clear, set;
> + =A0 =A0 =A0 u32 counter_reg;
> + =A0 =A0 =A0 unsigned long flags;
> +
> +#if defined(HAVE_MPC5200_WDT)
> + =A0 =A0 =A0 /* reject the operation if the timer is used as watchdog (g=
pt 0 only) */
> + =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
> + =A0 =A0 =A0 if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
> +#endif

I think the behaviour needs to be consistent, regardless of
HAVE_MPC5200_WDT state.  If the IS_WDT flag is set, then this needs
to bail, even if WDT support is not enabled.

Also, move this code block down into the spin lock/unlock block lower
in the function.  it doesn't make much sense to grab the spin lock
twice in the same function, and the worst think that can happen if
this test fails is that a few extra cycles are burned calculating what
the counter_reg value should be.

> +
> + =A0 =A0 =A0 clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTI=
NUOUS;
> + =A0 =A0 =A0 set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER=
_ENABLE;
> + =A0 =A0 =A0 if (continuous)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set |=3D MPC52xx_GPT_MODE_CONTINUOUS;
> +
> + =A0 =A0 =A0 if (mpc52xx_gpt_calc_counter_input(period, (u64)gpt->ipb_fr=
eq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&counter_reg) !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0/* Set and enable the timer */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&gpt->lock, flags);
> - =A0 =A0 =A0 out_be32(&gpt->regs->count, prescale << 16 | clocks);
> + =A0 =A0 =A0 out_be32(&gpt->regs->count, counter_reg);
> =A0 =A0 =A0 =A0clrsetbits_be32(&gpt->regs->mode, clear, set);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&gpt->lock, flags);
>
> @@ -437,12 +479,175 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_pri=
v *gpt, int period,
> =A0}
> =A0EXPORT_SYMBOL(mpc52xx_gpt_start_timer);
>
> -void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
> +/**
> + * mpc52xx_gpt_timer_period - Return the timer period in nanoseconds
> + * Note: reads the timer config directly from the hardware
> + */
> +u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt)
> +{
> + =A0 =A0 =A0 u64 period;
> + =A0 =A0 =A0 u32 prescale;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
> + =A0 =A0 =A0 period =3D in_be32(&gpt->regs->count);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
> +
> + =A0 =A0 =A0 prescale =3D period >> 16;
> + =A0 =A0 =A0 period &=3D 0xffff;
> + =A0 =A0 =A0 if (prescale =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 0x10000;
> + =A0 =A0 =A0 period =3D period * (u64) prescale * NS_PER_SEC;
> + =A0 =A0 =A0 do_div(period, (u64)gpt->ipb_freq);

Are the casts necessary?  Maybe prescale should just be a u64 value?

> + =A0 =A0 =A0 return period;
> +}
> +EXPORT_SYMBOL(mpc52xx_gpt_timer_period);
> +
> +int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
> =A0{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 /* reject the operation if the timer is used as watchdog (g=
pt 0 only) */
> + =A0 =A0 =A0 spin_lock_irqsave(&gpt->lock, flags);
> +#if defined(HAVE_MPC5200_WDT)
> + =A0 =A0 =A0 if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&gpt->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +#endif

Again, drop the #if/endif wrapper.

> +/**
> + * mpc52xx_gpt_wdt_release - Release the watchdog so it can be used as g=
pt
> + * @gpt_wdt: the watchdog gpt
> + *
> + * Note: Stops the watchdog if CONFIG_WATCHDOG_NOWAYOUT is not defined.
> + * the function does not protect itself form being called without a
> + * timer or with a timer which cannot function as wdt.
> + */
> +int mpc52xx_gpt_wdt_release(struct mpc52xx_gpt_priv *gpt_wdt)
> +{
> +#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&gpt_wdt->lock, flags);
> + =A0 =A0 =A0 clrbits32(&gpt_wdt->regs->mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52=
xx_GPT_MODE_WDT_EN);
> + =A0 =A0 =A0 gpt_wdt->wdt_mode &=3D ~MPC52xx_GPT_IS_WDT;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&gpt_wdt->lock, flags);
> +#endif
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mpc52xx_gpt_wdt_release);
> +
> +#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
> +/**
> + * mpc52xx_gpt_wdt_stop - Stop the watchdog
> + * @gpt_wdt: the watchdog gpt
> + *
> + * Note: the function does not protect itself form being called without =
a
> + * timer or with a timer which cannot function as wdt.
> + */
> +int mpc52xx_gpt_wdt_stop(struct mpc52xx_gpt_priv *gpt_wdt)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&gpt_wdt->lock, flags);
> + =A0 =A0 =A0 clrbits32(&gpt_wdt->regs->mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52=
xx_GPT_MODE_WDT_EN);
> + =A0 =A0 =A0 gpt_wdt->wdt_mode &=3D ~MPC52xx_GPT_IS_WDT;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&gpt_wdt->lock, flags);
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mpc52xx_gpt_wdt_stop);
> +#endif =A0/* =A0CONFIG_WATCHDOG_NOWAYOUT =A0*/
> +#endif =A0/* =A0HAVE_MPC5200_WDT =A0*/
> +
> =A0/* -------------------------------------------------------------------=
--
> =A0* of_platform bus binding code
> =A0*/
> @@ -473,6 +678,30 @@ static int __devinit mpc52xx_gpt_probe(struct of_dev=
ice *ofdev,
> =A0 =A0 =A0 =A0list_add(&gpt->list, &mpc52xx_gpt_list);
> =A0 =A0 =A0 =A0mutex_unlock(&mpc52xx_gpt_list_mutex);
>
> +#if defined(HAVE_MPC5200_WDT)
> + =A0 =A0 =A0 /* check if this device could be a watchdog */
> + =A0 =A0 =A0 if (of_get_property(ofdev->node, "fsl,has-wdt", NULL) ||
> + =A0 =A0 =A0 =A0 =A0 of_get_property(ofdev->node, "has-wdt", NULL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *on_boot_wdt;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpt->wdt_mode =3D MPC52xx_GPT_CAN_WDT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the device shall be used as on-=
boot watchdog */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 on_boot_wdt =3D of_get_property(ofdev->node=
, "wdt,on-boot", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (on_boot_wdt) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpt->wdt_mode |=3D MPC52xx_=
GPT_IS_WDT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*on_boot_wdt > 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_gpt_wdt_sta=
rt(gpt, *on_boot_wdt) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(gp=
t->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"running as wdt, timeout %us\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*on_boot_wdt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(gp=
t->dev, "reserved as wdt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(gpt->dev, "can fun=
ction as wdt\n");
> + =A0 =A0 =A0 }
> +#endif

Ditto on the #if/endif

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
