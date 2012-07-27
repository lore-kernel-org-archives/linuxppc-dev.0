Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64EC92C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 23:14:10 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343370058-2983-1-git-send-email-Dongsheng.wang@freescale.com>
Date: Fri, 27 Jul 2012 08:13:52 -0500
Message-Id: <2F4F76E5-1ACD-4F30-A997-9811DCE82202@kernel.crashing.org>
References: <1343370058-2983-1-git-send-email-Dongsheng.wang@freescale.com>
To: "<Dongsheng.wang@freescale.com>" <Dongsheng.wang@freescale.com>
Cc: scottwood@freescale.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 27, 2012, at 1:20 AM, <Dongsheng.wang@freescale.com> =
<Dongsheng.wang@freescale.com> wrote:

> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>=20
> Global timers A and B internal to the PIC. The two independent groups
> of global timer, group A and group B, are identical in their =
functionality.
> The hardware timer generates an interrupt on every timer cycle.
> e.g
> Power management can use the hardware timer to wake up the machine.
>=20
> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

How much of this is FSL specific vs openpic?  OpenPIC spec's timer =
support (only a single group).

> ---
> arch/powerpc/include/asm/mpic_timer.h |   15 +
> arch/powerpc/platforms/Kconfig        |    5 +
> arch/powerpc/sysdev/Makefile          |    1 +
> arch/powerpc/sysdev/mpic_timer.c      |  459 =
+++++++++++++++++++++++++++++++++
> 4 files changed, 480 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/include/asm/mpic_timer.h
> create mode 100644 arch/powerpc/sysdev/mpic_timer.c
>=20
> diff --git a/arch/powerpc/include/asm/mpic_timer.h =
b/arch/powerpc/include/asm/mpic_timer.h
> new file mode 100644
> index 0000000..01d58a2
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpic_timer.h
> @@ -0,0 +1,15 @@
> +#ifndef __MPIC_TIMER__
> +#define __MPIC_TIMER__
> +
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +
> +struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
> +		const struct timeval *time);
> +
> +void mpic_start_timer(struct mpic_timer *handle);
> +
> +void mpic_stop_timer(struct mpic_timer *handle);
> +
> +void mpic_free_timer(struct mpic_timer *handle);
> +#endif
> diff --git a/arch/powerpc/platforms/Kconfig =
b/arch/powerpc/platforms/Kconfig
> index f21af8d..3466690 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -87,6 +87,11 @@ config MPIC
> 	bool
> 	default n
>=20
> +config MPIC_TIMER
> +	bool "MPIC Global Timer"
> +	depends on MPIC && FSL_SOC
> +	default n
> +
> config PPC_EPAPR_HV_PIC
> 	bool
> 	default n
> diff --git a/arch/powerpc/sysdev/Makefile =
b/arch/powerpc/sysdev/Makefile
> index b0aff6c..3002f28 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -4,6 +4,7 @@ ccflags-$(CONFIG_PPC64)		:=3D =
-mno-minimal-toc
>=20
> mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o mpic_u3msi.o =
mpic_pasemi_msi.o
> obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y)
> +obj-$(CONFIG_MPIC_TIMER)	+=3D mpic_timer.o
> obj-$(CONFIG_PPC_EPAPR_HV_PIC)	+=3D ehv_pic.o
> fsl-msi-obj-$(CONFIG_PCI_MSI)	+=3D fsl_msi.o
> obj-$(CONFIG_PPC_MSI_BITMAP)	+=3D msi_bitmap.o
> diff --git a/arch/powerpc/sysdev/mpic_timer.c =
b/arch/powerpc/sysdev/mpic_timer.c
> new file mode 100644
> index 0000000..ef0db4d
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpic_timer.c
> @@ -0,0 +1,459 @@
> +/*
> + * Copyright (c) 2012 Freescale Semiconductor, Inc. All rights =
reserved.
> + *
> + * This program is free software; you can redistribute it and/or =
modify it
> + * under the terms of the GNU General Public License version 2 as =
published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <asm/io.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <asm/mpic_timer.h>
> +
> +
> +#define MPIC_TIMER_TCR_ROVR_OFFSET	24
> +#define MPIC_TIMER_TCR_CLKDIV_64	0x00000300
> +
> +#define MPIC_TIMER_STOP			0x80000000
> +#define MPIC_ALL_TIMER			4
> +
> +#define MAX_TIME			(~0U>>1)
> +#define MAX_TIME_CASCADE		(~0U)
> +
> +#define TIMER_OFFSET(num)		(1 << (MPIC_ALL_TIMER - 1 - =
num))
> +#define ONE_SECOND			1000000
> +
> +struct timer_regs {
> +	u32	gtccr;
> +	u32	res0[3];
> +	u32	gtbcr;
> +	u32	res1[3];
> +	u32	gtvpr;
> +	u32	res2[3];
> +	u32	gtdr;
> +	u32	res3[3];
> +};
> +
> +struct mpic_timer {
> +	void			*dev;
> +	struct cascade_priv	*cascade_handle;
> +	unsigned int		num;
> +	int			irq;
> +};
> +
> +struct cascade_priv {
> +	u32 tcr_value;			/* TCR register: CASC & ROVR =
value */
> +	unsigned int cascade_map;	/* cascade map */
> +	unsigned int timer_num;		/* cascade control timer */
> +};
> +
> +struct group_priv {
> +	struct timer_regs __iomem	*regs;
> +	struct mpic_timer		timer[MPIC_ALL_TIMER];
> +	struct list_head		node;
> +	unsigned int			idle;
> +	spinlock_t			lock;
> +	void __iomem			*group_tcr;
> +};
> +
> +static struct cascade_priv cascade_timer[] =3D {
> +	/* cascade timer 0 and 1 */
> +	{0x1, 0xc, 0x1},
> +	/* cascade timer 1 and 2 */
> +	{0x2, 0x6, 0x2},
> +	/* cascade timer 2 and 3 */
> +	{0x4, 0x3, 0x3}
> +};
> +
> +static u32 ccbfreq;
> +static u64 max_value;		/* prevent u64 overflow */
> +static LIST_HEAD(group_list);
> +
> +/* the time set by the user is converted to "ticks" */
> +static int transform_time(const struct timeval *time, int clkdiv, u64 =
*ticks)
> +{
> +	u64 tmp =3D 0;
> +	u64 tmp_sec =3D 0;
> +	u64 tmp_ms =3D 0;
> +	u64 tmp_us =3D 0;
> +	u32 div =3D 0;
> +
> +	if ((time->tv_sec + time->tv_usec) =3D=3D 0 ||
> +			time->tv_sec < 0 || time->tv_usec < 0)
> +		return -EINVAL;
> +
> +	if (time->tv_usec > ONE_SECOND)
> +		return -EINVAL;
> +
> +	if (time->tv_sec > max_value ||
> +			(time->tv_sec =3D=3D max_value && time->tv_usec =
> 0))
> +		return -EINVAL;
> +
> +	div =3D (1 << (clkdiv >> 8)) * 8;
> +
> +	tmp_sec =3D div_u64((u64)time->tv_sec * (u64)ccbfreq, div);
> +	tmp +=3D tmp_sec;
> +
> +	tmp_ms =3D time->tv_usec / 1000;
> +	tmp_ms =3D div_u64((u64)tmp_ms * (u64)ccbfreq, div * 1000);
> +	tmp +=3D tmp_ms;
> +
> +	tmp_us =3D time->tv_usec % 1000;
> +	tmp_us =3D div_u64((u64)tmp_us * (u64)ccbfreq, div * 1000000);
> +	tmp +=3D tmp_us;
> +
> +	*ticks =3D tmp;
> +
> +	return 0;
> +}
> +
> +/* detect whether there is a cascade timer available */
> +struct mpic_timer *detect_idle_cascade_timer(void)

should this be static?

> +{
> +	struct group_priv *priv;
> +	struct cascade_priv *casc_priv;
> +	unsigned int tmp;
> +	unsigned int array_size =3D ARRAY_SIZE(cascade_timer);
> +	unsigned int num;
> +	unsigned int i;
> +
> +	list_for_each_entry(priv, &group_list, node) {
> +		casc_priv =3D cascade_timer;
> +
> +		for (i =3D 0; i < array_size; i++) {
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&priv->lock, flags);
> +			tmp =3D casc_priv->cascade_map & priv->idle;
> +			if (tmp =3D=3D casc_priv->cascade_map) {
> +				num =3D casc_priv->timer_num;
> +				priv->timer[num].cascade_handle =3D =
casc_priv;
> +
> +				/* set timer busy */
> +				priv->idle &=3D ~casc_priv->cascade_map;
> +				spin_unlock_irqrestore(&priv->lock, =
flags);
> +				return &priv->timer[num];
> +			}
> +			spin_unlock_irqrestore(&priv->lock, flags);
> +			casc_priv++;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int set_cascade_timer(struct group_priv *priv, u64 ticks,
> +		unsigned int num)
> +{
> +	struct cascade_priv *casc_priv;
> +	u32 tmp;
> +	u32 tmp_ticks;
> +	u32 rem_ticks;
> +
> +	/* set group tcr reg for cascade */
> +	casc_priv =3D priv->timer[num].cascade_handle;
> +	if (!casc_priv)
> +		return -EINVAL;
> +
> +	tmp =3D casc_priv->tcr_value |
> +		(casc_priv->tcr_value << MPIC_TIMER_TCR_ROVR_OFFSET);
> +	setbits32(priv->group_tcr, tmp);
> +
> +	tmp_ticks =3D div_u64_rem(ticks, MAX_TIME_CASCADE, &rem_ticks);
> +
> +	out_be32(&priv->regs[num].gtccr, 0);
> +	out_be32(&priv->regs[num].gtbcr, tmp_ticks | MPIC_TIMER_STOP);
> +
> +	out_be32(&priv->regs[num - 1].gtccr, 0);
> +	out_be32(&priv->regs[num - 1].gtbcr, rem_ticks);
> +
> +	return 0;
> +}
> +
> +struct mpic_timer *get_cascade_timer(u64 ticks)
> +{

should this be static?

> +	struct group_priv *priv =3D NULL;
> +	struct mpic_timer *allocated_timer =3D NULL;
> +
> +	/* Two cascade timers: Support the maximum time */
> +	const u64 max_ticks =3D (u64)MAX_TIME * (u64)MAX_TIME_CASCADE;
> +	int ret;
> +
> +	if (ticks > max_ticks)
> +		return NULL;
> +
> +	/* detect idle timer */
> +	allocated_timer =3D detect_idle_cascade_timer();
> +	if (!allocated_timer)
> +		return NULL;
> +
> +	priv =3D container_of(allocated_timer, struct group_priv,
> +			timer[allocated_timer->num]);
> +
> +	/* set ticks to timer */
> +	ret =3D set_cascade_timer(priv, ticks, allocated_timer->num);
> +	if (ret < 0)
> +		return NULL;
> +
> +	return allocated_timer;
> +}
> +
> +struct mpic_timer *get_timer(u64 ticks)
> +{

should this be static?

> +	struct group_priv *priv;
> +	unsigned int num;
> +	unsigned int i;
> +
> +	list_for_each_entry(priv, &group_list, node) {
> +		for (i =3D 0; i < MPIC_ALL_TIMER; i++) {
> +			unsigned long flags;
> +
> +			/* one timer: Reverse allocation */
> +			num =3D MPIC_ALL_TIMER - 1 - i;
> +
> +			spin_lock_irqsave(&priv->lock, flags);
> +			if (priv->idle & (1 << i)) {
> +				/* set timer busy */
> +				priv->idle &=3D ~(1 << i);
> +				/* set ticks & stop timer */
> +				out_be32(&priv->regs[num].gtbcr,
> +					ticks | MPIC_TIMER_STOP);
> +				out_be32(&priv->regs[num].gtccr, 0);
> +
> +				spin_unlock_irqrestore(&priv->lock, =
flags);
> +				priv->timer[num].cascade_handle =3D =
NULL;
> +
> +				return &priv->timer[num];
> +			}
> +			spin_unlock_irqrestore(&priv->lock, flags);
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * mpic_request_timer - get a hardware timer
> + * @fn: interrupt handler function
> + * @dev: callback function of the data
> + * @time: time for timer
> + *
> + * This executes the "request_irq", returning NULL
> + * else "handle" on success.
> + */
> +struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
> +					const struct timeval *time)
> +{
> +	struct mpic_timer *allocated_timer =3D NULL;
> +	u64 ticks =3D 0;
> +	int ret =3D 0;
> +
> +	if (list_empty(&group_list))
> +		return NULL;
> +
> +	ret =3D transform_time(time, MPIC_TIMER_TCR_CLKDIV_64, &ticks);
> +	if (ret < 0)
> +		return NULL;
> +
> +	if (ticks > MAX_TIME)
> +		allocated_timer =3D get_cascade_timer(ticks);
> +	else
> +		allocated_timer =3D get_timer(ticks);
> +
> +	if (!allocated_timer)
> +		return NULL;
> +
> +	ret =3D request_irq(allocated_timer->irq, fn, IRQF_TRIGGER_LOW,
> +			"mpic-global-timer", dev);
> +	if (ret)
> +		return NULL;
> +
> +	allocated_timer->dev =3D dev;
> +
> +	return allocated_timer;
> +}
> +EXPORT_SYMBOL(mpic_request_timer);
> +
> +/**
> + * mpic_start_timer - start hardware timer
> + * @handle: the timer to be started.
> + *
> + * It will do ->fn(->dev) callback from the hardware interrupt at
> + * the ->timeval point in the future.
> + */
> +void mpic_start_timer(struct mpic_timer *handle)
> +{
> +	struct group_priv *priv =3D container_of(handle, struct =
group_priv,
> +			timer[handle->num]);
> +
> +	clrbits32(&priv->regs[handle->num].gtbcr, MPIC_TIMER_STOP);
> +}
> +EXPORT_SYMBOL(mpic_start_timer);
> +
> +/**
> + * mpic_stop_timer - stop hardware timer
> + * @handle: the timer to be stoped
> + *
> + * The timer periodically generates an interrupt. Unless user stops =
the timer.
> + */
> +void mpic_stop_timer(struct mpic_timer *handle)
> +{
> +	struct group_priv *priv =3D container_of(handle, struct =
group_priv,
> +			timer[handle->num]);
> +
> +	setbits32(&priv->regs[handle->num].gtbcr, MPIC_TIMER_STOP);
> +}
> +EXPORT_SYMBOL(mpic_stop_timer);
> +
> +/**
> + * mpic_free_timer - free hardware timer
> + * @handle: the timer to be removed.
> + *
> + * Free the timer.
> + *
> + * Note: can not be used in interrupt context.
> + */
> +void mpic_free_timer(struct mpic_timer *handle)
> +{
> +	struct group_priv *priv =3D container_of(handle, struct =
group_priv,
> +			timer[handle->num]);
> +
> +	struct cascade_priv *casc_priv =3D NULL;
> +	unsigned long flags;
> +
> +	mpic_stop_timer(handle);
> +
> +	casc_priv =3D priv->timer[handle->num].cascade_handle;
> +
> +	free_irq(priv->timer[handle->num].irq, =
priv->timer[handle->num].dev);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (casc_priv) {
> +		u32 tmp;
> +		tmp =3D casc_priv->tcr_value | (casc_priv->tcr_value <<
> +					MPIC_TIMER_TCR_ROVR_OFFSET);
> +		clrbits32(priv->group_tcr, tmp);
> +		priv->idle |=3D casc_priv->cascade_map;
> +		priv->timer[handle->num].cascade_handle =3D NULL;
> +	} else {
> +		priv->idle |=3D 1 << (MPIC_ALL_TIMER - 1 - handle->num);
> +	}
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +EXPORT_SYMBOL(mpic_free_timer);
> +
> +static void group_init(struct device_node *np)
> +{
> +	struct group_priv *priv =3D NULL;
> +	const u32 all_timer[] =3D { 0, MPIC_ALL_TIMER };
> +	const u32 *p;
> +	u32 offset;
> +	u32 count;
> +
> +	unsigned int i =3D 0;
> +	unsigned int j =3D 0;
> +	unsigned int irq_index =3D 0;
> +	int irq =3D 0;
> +	int len =3D 0;
> +
> +	priv =3D kzalloc(sizeof(struct group_priv), GFP_KERNEL);
> +	if (!priv) {
> +		pr_err("%s: cannot allocate memory for group.\n",
> +				np->full_name);
> +		return;
> +	}
> +
> +	priv->regs =3D of_iomap(np, 0);
> +	if (!priv->regs) {
> +		pr_err("%s: cannot ioremap register address.\n",
> +				np->full_name);
> +		goto out;
> +	}
> +
> +	priv->group_tcr =3D of_iomap(np, 1);
> +	if (!priv->group_tcr) {
> +		pr_err("%s: cannot ioremap tcr address.\n", =
np->full_name);
> +		goto out;
> +	}
> +
> +	/* Get irq numbers form dts */
> +	p =3D of_get_property(np, "fsl,available-ranges", &len);
> +	if (p && len % (2 * sizeof(u32)) !=3D 0) {
> +		pr_err("%s: malformed fsl,available-ranges property.\n",
> +				np->full_name);
> +		goto out;
> +	}
> +
> +	if (!p) {
> +		p =3D all_timer;
> +		len =3D sizeof(all_timer);
> +	}
> +
> +	len /=3D 2 * sizeof(u32);
> +
> +	for (i =3D 0; i < len; i++) {
> +		offset =3D p[i * 2];
> +		count =3D p[i * 2 + 1];
> +		for (j =3D 0; j < count; j++) {
> +			irq =3D irq_of_parse_and_map(np, irq_index);
> +			if (!irq)
> +				break;
> +
> +			/* Set timer idle */
> +			priv->idle |=3D TIMER_OFFSET((offset + j));
> +			priv->timer[offset + j].irq =3D irq;
> +			priv->timer[offset + j].num =3D offset + j;
> +			irq_index++;
> +		}
> +	}
> +
> +	/* Init lock */
> +	spin_lock_init(&priv->lock);
> +
> +	/* Init timer hardware */
> +	setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV_64);
> +
> +	list_add_tail(&priv->node, &group_list);
> +
> +	return;
> +out:
> +	if (priv->group_tcr)
> +		iounmap(priv->group_tcr);
> +
> +	if (priv->regs)
> +		iounmap(priv->regs);
> +
> +	kfree(priv);
> +}
> +
> +static int __init mpic_timer_init(void)
> +{
> +	struct device_node *np =3D NULL;
> +
> +	ccbfreq =3D fsl_get_sys_freq();
> +	if (ccbfreq =3D=3D 0) {
> +		pr_err("mpic_timer: No bus frequency "
> +				"in device tree.\n");
> +		return -ENODEV;
> +	}
> +
> +	max_value =3D div_u64(ULLONG_MAX, ccbfreq);
> +
> +	for_each_compatible_node(np, NULL, "fsl,mpic-global-timer")
> +		group_init(np);
> +
> +	if (list_empty(&group_list))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +arch_initcall(mpic_timer_init);
> --=20
> 1.7.5.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
