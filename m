Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA0DD67A2E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jun 2006 13:13:12 +1000 (EST)
Subject: Re: snd-aoa: using feature calls for GPIOs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1149187342.7875.9.camel@johannes>
References: <1149187342.7875.9.camel@johannes>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 13:11:53 +1000
Message-Id: <1149477113.8543.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Anyway, I'm sure I'm doing something stupid in there and just can't find
> it, I even 'disassembled' all the platform functions I have to see what
> happens in them, and they also write 0 or 1 just like the code below...
> Maybe I got some offsets wrong?

The platform function write bit 0 of the register only afaik. Bit 0x4 is
"output enable" so if you clear it, your GPIOs won't do much :)

Also, bit 0x2 is the input data, though it's only useful if "output
enable" is cleared (or it will just reflect the state of the outputs).

Forget about what snd-powermac does, it's bogus anyway.

Ben.

> --- snd-aoa.orig/aoa.h	2006-06-01 20:29:56.252070199 +0200
> +++ snd-aoa/aoa.h	2006-06-01 20:31:03.972070199 +0200
> @@ -125,6 +125,7 @@ extern int aoa_snd_ctl_add(struct snd_kc
>  
>  /* GPIO stuff */
>  extern struct gpio_methods *pmf_gpio_methods;
> +extern struct gpio_methods *ftr_gpio_methods;
>  /* extern struct gpio_methods *map_gpio_methods; */
>  
>  #endif /* __AOA_H */
> --- snd-aoa.orig/core/Makefile	2006-06-01 20:29:56.252070199 +0200
> +++ snd-aoa/core/Makefile	2006-06-01 20:31:03.972070199 +0200
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_SND_AOA) += snd-aoa.o
>  snd-aoa-objs := snd-aoa-core.o \
>  		snd-aoa-alsa.o \
> -		snd-aoa-gpio-pmf.o
> +		snd-aoa-gpio-pmf.o \
> +		snd-aoa-gpio-feature.o
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ snd-aoa/core/snd-aoa-gpio-feature.c	2006-06-01 20:31:03.992070199 +0200
> @@ -0,0 +1,322 @@
> +/*
> + * Apple Onboard Audio feature call GPIO control
> + *
> + * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
> + *
> + * GPL v2, can be found in COPYING.
> + */
> +
> +#include <asm/pmac_feature.h>
> +#include <linux/interrupt.h>
> +#include "../aoa.h"
> +
> +static int headphone_mute_gpio;
> +static int amp_mute_gpio;
> +static int lineout_mute_gpio;
> +static int hw_reset_gpio;
> +static int lineout_detect_gpio;
> +static int headphone_detect_gpio;
> +static int linein_detect_gpio;
> +
> +static int headphone_mute_gpio_activestate;
> +static int amp_mute_gpio_activestate;
> +static int lineout_mute_gpio_activestate;
> +static int hw_reset_gpio_activestate;
> +static int lineout_detect_gpio_activestate;
> +static int headphone_detect_gpio_activestate;
> +static int linein_detect_gpio_activestate;
> +
> +static int lineout_detect_irq;
> +static int linein_detect_irq;
> +static int headphone_detect_irq;
> +
> +static void get_gpio(char *name, int *gpioptr, int *gpioactiveptr)
> +{
> +	struct device_node *np;
> +	u32 *reg;
> +
> +	*gpioptr = -1;
> +
> +	np = of_find_node_by_name(NULL, name);
> +	if (!np)
> +		return;
> +
> +	reg = (u32 *)get_property(np, "reg", NULL);
> +	if (!reg)
> +		return;
> +
> +	*gpioptr = *reg;
> +
> +	/* this is a hack, usually the GPIOs 'reg' property
> +	 * should have the offset based from the GPIO space
> +	 * which is at 0x50, but apparently not always... */
> +	if (*gpioptr < 0x50)
> +		*gpioptr += 0x50;
> +
> +	reg = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
> +	if (!reg)
> +		*gpioactiveptr = 1;
> +	else
> +		*gpioactiveptr = *reg;
> +
> +	printk(KERN_DEBUG "gpio %s = %d (active = %d)\n", name, *gpioptr, *gpioactiveptr);
> +}
> +
> +static void get_irq(char *name, int *irqptr)
> +{
> +	struct device_node *np;
> +
> +	*irqptr = -1;
> +	np = of_find_node_by_name(NULL, name);
> +	if (!np)
> +		return;
> +	if (np->n_intrs != 1)
> +		return;
> +	*irqptr = np->intrs[0].line;
> +
> +	printk(KERN_DEBUG "got %s irq = %d\n", name, *irqptr);
> +}
> +
> +#define SWITCH_GPIO(name, on)					\
> +	((on)?(name##_gpio_activestate==0?0:1):(name##_gpio_activestate==0?1:0))
> +
> +#define FTR_GPIO(name, bit)					\
> +static void ftr_gpio_set_##name(struct gpio_runtime *rt, int on)\
> +{								\
> +	if (unlikely(!rt)) return;				\
> +								\
> +	if (name##_mute_gpio < 0)				\
> +		return;						\
> +								\
> +	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,		\
> +			  name##_mute_gpio,			\
> +			  SWITCH_GPIO(name##_mute, on));	\
> +								\
> +	rt->implementation_private &= ~(1<<bit);		\
> +	rt->implementation_private |= (!!on << bit);		\
> +}								\
> +static int ftr_gpio_get_##name(struct gpio_runtime *rt)		\
> +{								\
> +	if (unlikely(!rt)) return 0;				\
> +	return (rt->implementation_private>>bit)&1;		\
> +}
> +
> +FTR_GPIO(headphone, 0);
> +FTR_GPIO(amp, 1);
> +FTR_GPIO(lineout, 2);
> +
> +static void ftr_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
> +{
> +	if (unlikely(!rt)) return;
> +	if (hw_reset_gpio < 0)
> +		return;
> +
> +	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
> +			  hw_reset_gpio, SWITCH_GPIO(hw_reset, on));
> +}
> +
> +static void ftr_gpio_all_amps_off(struct gpio_runtime *rt)
> +{
> +	int saved;
> +
> +	if (unlikely(!rt)) return;
> +	saved = rt->implementation_private;
> +	ftr_gpio_set_headphone(rt, 0);
> +	ftr_gpio_set_amp(rt, 0);
> +	ftr_gpio_set_lineout(rt, 0);
> +	rt->implementation_private = saved;
> +}
> +
> +static void ftr_gpio_all_amps_restore(struct gpio_runtime *rt)
> +{
> +	int s;
> +
> +	if (unlikely(!rt)) return;
> +	s = rt->implementation_private;
> +	ftr_gpio_set_headphone(rt, (s>>0)&1);
> +	ftr_gpio_set_amp(rt, (s>>1)&1);
> +	ftr_gpio_set_lineout(rt, (s>>2)&1);
> +}
> +
> +static void ftr_handle_notify(void *data)
> +{
> +	struct gpio_notification *notif = data;
> +
> +	mutex_lock(&notif->mutex);
> +	if (notif->notify)
> +		notif->notify(notif->data);
> +	mutex_unlock(&notif->mutex);
> +}
> +
> +static void ftr_gpio_init(struct gpio_runtime *rt)
> +{
> +	get_gpio("headphone-mute", &headphone_mute_gpio,
> +				   &headphone_mute_gpio_activestate);
> +	get_gpio("amp-mute", &amp_mute_gpio,
> +			     &amp_mute_gpio_activestate);
> +	get_gpio("lineout-mute", &lineout_mute_gpio,
> +				 &lineout_mute_gpio_activestate);
> +	get_gpio("hw-reset", &hw_reset_gpio,
> +			     &hw_reset_gpio_activestate);
> +	get_gpio("headphone-detect", &headphone_detect_gpio,
> +				     &headphone_detect_gpio_activestate);
> +	get_gpio("lineout-detect", &lineout_detect_gpio,
> +				   &lineout_detect_gpio_activestate);
> +	get_gpio("linein-detect", &linein_detect_gpio,
> +				  &linein_detect_gpio_activestate);
> +
> +	get_irq("headphone-detect", &headphone_detect_irq);
> +	get_irq("lineout-detect", &lineout_detect_irq);
> +	get_irq("linein-detect", &linein_detect_irq);
> +
> +	ftr_gpio_all_amps_off(rt);
> +	rt->implementation_private = 0;
> +	INIT_WORK(&rt->headphone_notify.work, ftr_handle_notify, &rt->headphone_notify);
> +	INIT_WORK(&rt->line_in_notify.work, ftr_handle_notify, &rt->line_in_notify);
> +	INIT_WORK(&rt->line_out_notify.work, ftr_handle_notify, &rt->line_out_notify);
> +	mutex_init(&rt->headphone_notify.mutex);
> +	mutex_init(&rt->line_in_notify.mutex);
> +	mutex_init(&rt->line_out_notify.mutex);
> +}
> +
> +static void ftr_gpio_exit(struct gpio_runtime *rt)
> +{
> +	ftr_gpio_all_amps_off(rt);
> +	rt->implementation_private = 0;
> +	if (rt->headphone_notify.notify)
> +		free_irq(headphone_detect_irq, &rt->headphone_notify);
> +	if (rt->line_in_notify.gpio_private)
> +		free_irq(linein_detect_irq, &rt->line_in_notify);
> +	if (rt->line_out_notify.gpio_private)
> +		free_irq(lineout_detect_irq, &rt->line_out_notify);
> +	cancel_delayed_work(&rt->headphone_notify.work);
> +	cancel_delayed_work(&rt->line_in_notify.work);
> +	cancel_delayed_work(&rt->line_out_notify.work);
> +	flush_scheduled_work();
> +	mutex_destroy(&rt->headphone_notify.mutex);
> +	mutex_destroy(&rt->line_in_notify.mutex);
> +	mutex_destroy(&rt->line_out_notify.mutex);
> +}
> +
> +irqreturn_t ftr_handle_notify_irq(int xx, void *data, struct pt_regs *regs)
> +{
> +	struct gpio_notification *notif = data;
> +
> +	schedule_work(&notif->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ftr_set_notify(struct gpio_runtime *rt,
> +			  enum notify_type type,
> +			  notify_func_t notify,
> +			  void *data)
> +{
> +	struct gpio_notification *notif;
> +	notify_func_t old;
> +	int irq;
> +	char *name;
> +	int err = -EBUSY;
> +
> +	switch (type) {
> +	case AOA_NOTIFY_HEADPHONE:
> +		notif = &rt->headphone_notify;
> +		name = "headphone-detect";
> +		irq = headphone_detect_irq;
> +		break;
> +	case AOA_NOTIFY_LINE_IN:
> +		notif = &rt->line_in_notify;
> +		name = "linein-detect";
> +		irq = linein_detect_irq;
> +		break;
> +	case AOA_NOTIFY_LINE_OUT:
> +		notif = &rt->line_out_notify;
> +		name = "lineout-detect";
> +		irq = lineout_detect_irq;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (irq == -1)
> +		return -ENODEV;
> +
> +	mutex_lock(&notif->mutex);
> +
> +	old = notif->notify;
> +
> +	if (!old && !notify) {
> +		err = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (old && notify) {
> +		if (old == notify && notif->data == data)
> +			err = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (old && !notify) {
> +		free_irq(irq, notif);
> +	}
> +	if (!old && notify) {
> +		request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
> +	}
> +	notif->notify = notify;
> +	notif->data = data;
> +
> +	err = 0;
> + out_unlock:
> +	mutex_unlock(&notif->mutex);
> +	return err;
> +}
> +
> +static int ftr_get_detect(struct gpio_runtime *rt,
> +			  enum notify_type type)
> +{
> +	int gpio, ret, active;
> +
> +	switch (type) {
> +	case AOA_NOTIFY_HEADPHONE:
> +		gpio = headphone_detect_gpio;
> +		active = headphone_detect_gpio_activestate;
> +		break;
> +	case AOA_NOTIFY_LINE_IN:
> +		gpio = linein_detect_gpio;
> +		active = linein_detect_gpio_activestate;
> +		break;
> +	case AOA_NOTIFY_LINE_OUT:
> +		gpio = lineout_detect_gpio;
> +		active = lineout_detect_gpio_activestate;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (gpio == -1)
> +		return -ENODEV;
> +
> +	ret = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, gpio, 0);
> +	if (ret < 0)
> +		return ret;
> +	return ((ret >> 1) & 1) == active;
> +}
> +
> +static struct gpio_methods methods = {
> +	.init			= ftr_gpio_init,
> +	.exit			= ftr_gpio_exit,
> +	.all_amps_off		= ftr_gpio_all_amps_off,
> +	.all_amps_restore	= ftr_gpio_all_amps_restore,
> +	.set_headphone		= ftr_gpio_set_headphone,
> +	.set_speakers		= ftr_gpio_set_amp,
> +	.set_lineout		= ftr_gpio_set_lineout,
> +	.set_hw_reset		= ftr_gpio_set_hw_reset,
> +	.get_headphone		= ftr_gpio_get_headphone,
> +	.get_speakers		= ftr_gpio_get_amp,
> +	.get_lineout		= ftr_gpio_get_lineout,
> +	.set_notify		= ftr_set_notify,
> +	.get_detect		= ftr_get_detect,
> +};
> +
> +struct gpio_methods *ftr_gpio_methods = &methods;
> +EXPORT_SYMBOL_GPL(ftr_gpio_methods);
> 
