Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93FBD2C049B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 19:11:55 +1100 (EST)
Received: from mail115-co1 (localhost [127.0.0.1])	by
 mail115-co1-R.bigfish.com (Postfix) with ESMTP id 2B41C900187	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 08:11:51 +0000 (UTC)
Received: from CO1EHSMHS010.bigfish.com (unknown [10.243.78.231])	by
 mail115-co1.bigfish.com (Postfix) with ESMTP id 4555BC006F	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 08:11:48 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <kumar.gala@freescale.com>
Subject: [PATCH 2/3] powerpc/mpic: add global timer support
Date: Fri, 8 Mar 2013 15:38:46 +0800
Message-ID: <1362728327-21013-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1362728327-21013-1-git-send-email-dongsheng.wang@freescale.com>
References: <1362728327-21013-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPIC global timer is a hardware timer inside the Freescale PIC comply
to Open-PIC standard. When the timer is timeout of the specified interval,
the hardware timer generates an interrupt. The driver currently is only
tested on fsl chip, but it can potentially support other global timers
complying to Open-PIC standard.

The two independent groups of global timer on fsl chip, group A and group B,
are identical in their functionality, except that they appear at different
locations within the PIC register map. The hardware timer can be cascaded to
create timers larger than the default 31-bit global timers. Timer cascade
fields allow configuration of up to two 63-bit timers. But These two groups
of timers cannot be cascaded together.

It can be used as a wakeup source for low power modes. It also could be used
as periodical timer for protocols, drivers and etc.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/mpic_timer.h |   46 +++
 arch/powerpc/platforms/Kconfig        |   12 +
 arch/powerpc/sysdev/Makefile          |    1 +
 arch/powerpc/sysdev/mpic_timer.c      |  606 +++++++++++++++++++++++++++++++++
 4 files changed, 665 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mpic_timer.h
 create mode 100644 arch/powerpc/sysdev/mpic_timer.c

diff --git a/arch/powerpc/include/asm/mpic_timer.h b/arch/powerpc/include/asm/mpic_timer.h
new file mode 100644
index 0000000..0e23cd4
--- /dev/null
+++ b/arch/powerpc/include/asm/mpic_timer.h
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/include/asm/mpic_timer.h
+ *
+ * Header file for Mpic Global Timer
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Wang Dongsheng <Dongsheng.Wang@freescale.com>
+ *	   Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MPIC_TIMER__
+#define __MPIC_TIMER__
+
+#include <linux/interrupt.h>
+#include <linux/time.h>
+
+struct mpic_timer {
+	void			*dev;
+	struct cascade_priv	*cascade_handle;
+	unsigned int		num;
+	unsigned int		irq;
+};
+
+#ifdef CONFIG_MPIC_TIMER
+struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
+		const struct timeval *time);
+void mpic_start_timer(struct mpic_timer *handle);
+void mpic_stop_timer(struct mpic_timer *handle);
+void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time);
+void mpic_free_timer(struct mpic_timer *handle);
+#else
+struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
+		const struct timeval *time) { return NULL; }
+void mpic_start_timer(struct mpic_timer *handle) { }
+void mpic_stop_timer(struct mpic_timer *handle) { }
+void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time) { }
+void mpic_free_timer(struct mpic_timer *handle) { }
+#endif
+
+#endif
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 48a920d..5af04fa 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -87,6 +87,18 @@ config MPIC
 	bool
 	default n
 
+config MPIC_TIMER
+	bool "MPIC Global Timer"
+	depends on MPIC && FSL_SOC
+	default n
+	help
+	  The MPIC global timer is a hardware timer inside the
+	  Freescale PIC comply to Open-PIC standard. When the
+	  timer is timeout of the specified interval, the hardware
+	  timer generates an interrupt. The driver currently is
+	  only tested on fsl chip, but it can potentially support
+	  other global timers complying to Open-PIC standard.
+
 config PPC_EPAPR_HV_PIC
 	bool
 	default n
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index a57600b..ff6184a 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -4,6 +4,7 @@ ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
 
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
+obj-$(CONFIG_MPIC_TIMER)        += mpic_timer.o
 mpic-msgr-obj-$(CONFIG_MPIC_MSGR)	+= mpic_msgr.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y) $(mpic-msgr-obj-y)
 obj-$(CONFIG_PPC_EPAPR_HV_PIC)	+= ehv_pic.o
diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
new file mode 100644
index 0000000..3aaa3d4
--- /dev/null
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -0,0 +1,606 @@
+/*
+ * MPIC timer driver
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ * Author: Dongsheng Wang <Dongsheng.Wang@freescale.com>
+ *	   Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/syscore_ops.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/io.h>
+
+#include <asm/mpic_timer.h>
+
+#define FSL_GLOBAL_TIMER		0x1
+
+#define MPIC_TIMER_TCR_CLKDIV_64	0x00000300
+#define MPIC_TIMER_TCR_ROVR_OFFSET	24
+
+#define TIMER_STOP			0x80000000
+#define TIMERS_PER_GROUP		4
+#define MAX_TICKS			(~0U >> 1)
+#define MAX_TICKS_CASCADE		(~0U)
+#define TIMER_OFFSET(num)		(1 << (TIMERS_PER_GROUP - 1 - num))
+
+/* tv_usec should be less than ONE_SECOND, otherwise use tv_sec */
+#define ONE_SECOND			1000000
+
+struct timer_regs {
+	u32	gtccr;
+	u32	res0[3];
+	u32	gtbcr;
+	u32	res1[3];
+	u32	gtvpr;
+	u32	res2[3];
+	u32	gtdr;
+	u32	res3[3];
+};
+
+struct cascade_priv {
+	u32 tcr_value;			/* TCR register: CASC & ROVR value */
+	unsigned int cascade_map;	/* cascade map */
+	unsigned int timer_num;		/* cascade control timer */
+};
+
+struct timer_group_priv {
+	struct timer_regs __iomem	*regs;
+	struct mpic_timer		timer[TIMERS_PER_GROUP];
+	struct list_head		node;
+	unsigned int			timerfreq;
+	unsigned int			idle;
+	unsigned int			flags;
+	spinlock_t			lock;
+	void __iomem			*group_tcr;
+};
+
+static struct cascade_priv cascade_timer[] = {
+	/* cascade timer 0 and 1 */
+	{0x1, 0xc, 0x1},
+	/* cascade timer 1 and 2 */
+	{0x2, 0x6, 0x2},
+	/* cascade timer 2 and 3 */
+	{0x4, 0x3, 0x3}
+};
+
+static LIST_HEAD(timer_group_list);
+
+static void convert_ticks_to_time(struct timer_group_priv *priv,
+		const u64 ticks, struct timeval *time)
+{
+	u64 tmp_sec;
+	u32 rem_us;
+	u32 div;
+
+	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
+		time->tv_sec = (__kernel_time_t)
+			div_u64_rem(ticks, priv->timerfreq, &rem_us);
+		tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
+		time->tv_usec = (__kernel_suseconds_t)
+			div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
+
+		return;
+	}
+
+	div = (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
+
+	time->tv_sec = (__kernel_time_t)div_u64(ticks, priv->timerfreq / div);
+	tmp_sec = div_u64((u64)time->tv_sec * (u64)priv->timerfreq, div);
+
+	time->tv_usec = (__kernel_suseconds_t)
+		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq / div);
+
+	return;
+}
+
+/* the time set by the user is converted to "ticks" */
+static int convert_time_to_ticks(struct timer_group_priv *priv,
+		const struct timeval *time, u64 *ticks)
+{
+	u64 max_value;		/* prevent u64 overflow */
+	u64 tmp = 0;
+
+	u64 tmp_sec;
+	u64 tmp_ms;
+	u64 tmp_us;
+	u32 div;
+
+	max_value = div_u64(ULLONG_MAX, priv->timerfreq);
+
+	if (time->tv_sec > max_value ||
+			(time->tv_sec == max_value && time->tv_usec > 0))
+		return -EINVAL;
+
+	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
+		tmp_sec = time->tv_sec * priv->timerfreq;
+		tmp_ms = time->tv_usec / 1000 * priv->timerfreq / 1000;
+		tmp_us = time->tv_usec % 1000 * priv->timerfreq / 1000000;
+
+		*ticks = tmp_sec + tmp_ms + tmp_us;
+
+		return 0;
+	}
+
+	div = (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
+
+	tmp_sec = div_u64((u64)time->tv_sec * (u64)priv->timerfreq, div);
+	tmp += tmp_sec;
+
+	tmp_ms = time->tv_usec / 1000;
+	tmp_ms = div_u64((u64)tmp_ms * (u64)priv->timerfreq, div * 1000);
+	tmp += tmp_ms;
+
+	tmp_us = time->tv_usec % 1000;
+	tmp_us = div_u64((u64)tmp_us * (u64)priv->timerfreq, div * 1000000);
+	tmp += tmp_us;
+
+	*ticks = tmp;
+
+	return 0;
+}
+
+/* detect whether there is a cascade timer available */
+static struct mpic_timer *detect_idle_cascade_timer(
+					struct timer_group_priv *priv)
+{
+	struct cascade_priv *casc_priv;
+	unsigned int map;
+	unsigned int array_size = ARRAY_SIZE(cascade_timer);
+	unsigned int num;
+	unsigned int i;
+	unsigned long flags;
+
+	casc_priv = cascade_timer;
+	for (i = 0; i < array_size; i++) {
+		spin_lock_irqsave(&priv->lock, flags);
+		map = casc_priv->cascade_map & priv->idle;
+		if (map == casc_priv->cascade_map) {
+			num = casc_priv->timer_num;
+			priv->timer[num].cascade_handle = casc_priv;
+
+			/* set timer busy */
+			priv->idle &= ~casc_priv->cascade_map;
+			spin_unlock_irqrestore(&priv->lock, flags);
+			return &priv->timer[num];
+		}
+		spin_unlock_irqrestore(&priv->lock, flags);
+		casc_priv++;
+	}
+
+	return NULL;
+}
+
+static int set_cascade_timer(struct timer_group_priv *priv, u64 ticks,
+		unsigned int num)
+{
+	struct cascade_priv *casc_priv;
+	u32 tcr;
+	u32 tmp_ticks;
+	u32 rem_ticks;
+
+	/* set group tcr reg for cascade */
+	casc_priv = priv->timer[num].cascade_handle;
+	if (!casc_priv)
+		return -EINVAL;
+
+	tcr = casc_priv->tcr_value |
+		(casc_priv->tcr_value << MPIC_TIMER_TCR_ROVR_OFFSET);
+	setbits32(priv->group_tcr, tcr);
+
+	tmp_ticks = div_u64_rem(ticks, MAX_TICKS_CASCADE, &rem_ticks);
+
+	out_be32(&priv->regs[num].gtccr, 0);
+	out_be32(&priv->regs[num].gtbcr, tmp_ticks | TIMER_STOP);
+
+	out_be32(&priv->regs[num - 1].gtccr, 0);
+	out_be32(&priv->regs[num - 1].gtbcr, rem_ticks);
+
+	return 0;
+}
+
+static struct mpic_timer *get_cascade_timer(struct timer_group_priv *priv,
+					u64 ticks)
+{
+	struct mpic_timer *allocated_timer;
+
+	/* Two cascade timers: Support the maximum time */
+	const u64 max_ticks = (u64)MAX_TICKS * (u64)MAX_TICKS_CASCADE;
+	int ret;
+
+	if (ticks > max_ticks)
+		return NULL;
+
+	/* detect idle timer */
+	allocated_timer = detect_idle_cascade_timer(priv);
+	if (!allocated_timer)
+		return NULL;
+
+	/* set ticks to timer */
+	ret = set_cascade_timer(priv, ticks, allocated_timer->num);
+	if (ret < 0)
+		return NULL;
+
+	return allocated_timer;
+}
+
+static struct mpic_timer *get_timer(const struct timeval *time)
+{
+	struct timer_group_priv *priv;
+	struct mpic_timer *timer;
+
+	u64 ticks;
+	unsigned int num;
+	unsigned int i;
+	unsigned long flags;
+	int ret;
+
+	list_for_each_entry(priv, &timer_group_list, node) {
+		ret = convert_time_to_ticks(priv, time, &ticks);
+		if (ret < 0)
+			return NULL;
+
+		if (ticks > MAX_TICKS) {
+			if (!(priv->flags & FSL_GLOBAL_TIMER))
+				return NULL;
+
+			timer = get_cascade_timer(priv, ticks);
+			if (!timer)
+				continue;
+			else
+				return timer;
+		}
+
+		for (i = 0; i < TIMERS_PER_GROUP; i++) {
+			/* one timer: Reverse allocation */
+			num = TIMERS_PER_GROUP - 1 - i;
+			spin_lock_irqsave(&priv->lock, flags);
+			if (priv->idle & (1 << i)) {
+				/* set timer busy */
+				priv->idle &= ~(1 << i);
+				/* set ticks & stop timer */
+				out_be32(&priv->regs[num].gtbcr,
+					ticks | TIMER_STOP);
+				out_be32(&priv->regs[num].gtccr, 0);
+				priv->timer[num].cascade_handle = NULL;
+				spin_unlock_irqrestore(&priv->lock, flags);
+				return &priv->timer[num];
+			}
+			spin_unlock_irqrestore(&priv->lock, flags);
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * mpic_start_timer - start hardware timer
+ * @handle: the timer to be started.
+ *
+ * It will do ->fn(->dev) callback from the hardware interrupt at
+ * the ->timeval point in the future.
+ */
+void mpic_start_timer(struct mpic_timer *handle)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+
+	clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+}
+EXPORT_SYMBOL(mpic_start_timer);
+
+/**
+ * mpic_stop_timer - stop hardware timer
+ * @handle: the timer to be stoped
+ *
+ * The timer periodically generates an interrupt. Unless user stops the timer.
+ */
+void mpic_stop_timer(struct mpic_timer *handle)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+	struct cascade_priv *casc_priv;
+
+	setbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+
+	casc_priv = priv->timer[handle->num].cascade_handle;
+	if (casc_priv) {
+		out_be32(&priv->regs[handle->num].gtccr, 0);
+		out_be32(&priv->regs[handle->num - 1].gtccr, 0);
+	} else {
+		out_be32(&priv->regs[handle->num].gtccr, 0);
+	}
+}
+EXPORT_SYMBOL(mpic_stop_timer);
+
+/**
+ * mpic_get_remain_time - get timer time
+ * @handle: the timer to be selected.
+ * @time: time for timer
+ *
+ * Query timer remaining time.
+ */
+void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+	struct cascade_priv *casc_priv;
+
+	u64 ticks;
+	u32 tmp_ticks;
+
+	casc_priv = priv->timer[handle->num].cascade_handle;
+	if (casc_priv) {
+		tmp_ticks = in_be32(&priv->regs[handle->num].gtccr);
+		ticks = ((u64)tmp_ticks & UINT_MAX) * (u64)MAX_TICKS_CASCADE;
+		tmp_ticks = in_be32(&priv->regs[handle->num - 1].gtccr);
+		ticks += tmp_ticks;
+	} else {
+		ticks = in_be32(&priv->regs[handle->num].gtccr);
+	}
+
+	convert_ticks_to_time(priv, ticks, time);
+}
+EXPORT_SYMBOL(mpic_get_remain_time);
+
+/**
+ * mpic_free_timer - free hardware timer
+ * @handle: the timer to be removed.
+ *
+ * Free the timer.
+ *
+ * Note: can not be used in interrupt context.
+ */
+void mpic_free_timer(struct mpic_timer *handle)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+
+	struct cascade_priv *casc_priv;
+	unsigned long flags;
+
+	mpic_stop_timer(handle);
+
+	casc_priv = priv->timer[handle->num].cascade_handle;
+
+	free_irq(priv->timer[handle->num].irq, priv->timer[handle->num].dev);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (casc_priv) {
+		u32 tcr;
+		tcr = casc_priv->tcr_value | (casc_priv->tcr_value <<
+					MPIC_TIMER_TCR_ROVR_OFFSET);
+		clrbits32(priv->group_tcr, tcr);
+		priv->idle |= casc_priv->cascade_map;
+		priv->timer[handle->num].cascade_handle = NULL;
+	} else {
+		priv->idle |= TIMER_OFFSET(handle->num);
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+EXPORT_SYMBOL(mpic_free_timer);
+
+/**
+ * mpic_request_timer - get a hardware timer
+ * @fn: interrupt handler function
+ * @dev: callback function of the data
+ * @time: time for timer
+ *
+ * This executes the "request_irq", returning NULL
+ * else "handle" on success.
+ */
+struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
+					const struct timeval *time)
+{
+	struct mpic_timer *allocated_timer;
+	int ret;
+
+	if (list_empty(&timer_group_list))
+		return NULL;
+
+	if (!(time->tv_sec + time->tv_usec) ||
+			time->tv_sec < 0 || time->tv_usec < 0)
+		return NULL;
+
+	if (time->tv_usec > ONE_SECOND)
+		return NULL;
+
+	allocated_timer = get_timer(time);
+	if (!allocated_timer)
+		return NULL;
+
+	ret = request_irq(allocated_timer->irq, fn,
+			IRQF_TRIGGER_LOW, "global-timer", dev);
+	if (ret) {
+		mpic_free_timer(allocated_timer);
+		return NULL;
+	}
+
+	allocated_timer->dev = dev;
+
+	return allocated_timer;
+}
+EXPORT_SYMBOL(mpic_request_timer);
+
+static int timer_group_get_freq(struct device_node *np,
+			struct timer_group_priv *priv)
+{
+	if (priv->flags & FSL_GLOBAL_TIMER) {
+		struct device_node *dn;
+
+		dn = of_find_compatible_node(NULL, NULL, "fsl,mpic");
+		if (dn) {
+			of_property_read_u32(dn, "clock-frequency",
+					&priv->timerfreq);
+			of_node_put(dn);
+		}
+	}
+
+	if (priv->timerfreq <= 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int timer_group_get_irq(struct device_node *np,
+		struct timer_group_priv *priv)
+{
+	const u32 all_timer[] = { 0, TIMERS_PER_GROUP };
+	const u32 *p;
+	u32 offset;
+	u32 count;
+
+	unsigned int i;
+	unsigned int j;
+	unsigned int irq_index = 0;
+	unsigned int irq;
+	int len;
+
+	p = of_get_property(np, "fsl,available-ranges", &len);
+	if (p && len % (2 * sizeof(u32)) != 0) {
+		pr_err("%s: malformed available-ranges property.\n",
+				np->full_name);
+		return -EINVAL;
+	}
+
+	if (!p) {
+		p = all_timer;
+		len = sizeof(all_timer);
+	}
+
+	len /= 2 * sizeof(u32);
+
+	for (i = 0; i < len; i++) {
+		offset = p[i * 2];
+		count = p[i * 2 + 1];
+		for (j = 0; j < count; j++) {
+			irq = irq_of_parse_and_map(np, irq_index);
+			if (!irq) {
+				pr_err("%s: irq parse and map failed.\n",
+						np->full_name);
+				return -EINVAL;
+			}
+
+			/* Set timer idle */
+			priv->idle |= TIMER_OFFSET((offset + j));
+			priv->timer[offset + j].irq = irq;
+			priv->timer[offset + j].num = offset + j;
+			irq_index++;
+		}
+	}
+
+	return 0;
+}
+
+static void timer_group_init(struct device_node *np)
+{
+	struct timer_group_priv *priv;
+	unsigned int i = 0;
+	int ret;
+
+	priv = kzalloc(sizeof(struct timer_group_priv), GFP_KERNEL);
+	if (!priv) {
+		pr_err("%s: cannot allocate memory for group.\n",
+				np->full_name);
+		return;
+	}
+
+	if (of_device_is_compatible(np, "fsl,mpic-global-timer"))
+		priv->flags |= FSL_GLOBAL_TIMER;
+
+	priv->regs = of_iomap(np, i++);
+	if (!priv->regs) {
+		pr_err("%s: cannot ioremap timer register address.\n",
+				np->full_name);
+		goto out;
+	}
+
+	if (priv->flags & FSL_GLOBAL_TIMER) {
+		priv->group_tcr = of_iomap(np, i++);
+		if (!priv->group_tcr) {
+			pr_err("%s: cannot ioremap tcr address.\n",
+					np->full_name);
+			goto out;
+		}
+	}
+
+	ret = timer_group_get_freq(np, priv);
+	if (ret < 0) {
+		pr_err("%s: cannot get timer frequency.\n", np->full_name);
+		goto out;
+	}
+
+	ret = timer_group_get_irq(np, priv);
+	if (ret < 0) {
+		pr_err("%s: cannot get timer irqs.\n", np->full_name);
+		goto out;
+	}
+
+	spin_lock_init(&priv->lock);
+
+	/* Init FSL timer hardware */
+	if (priv->flags & FSL_GLOBAL_TIMER)
+		setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV_64);
+
+	list_add_tail(&priv->node, &timer_group_list);
+
+	return;
+
+out:
+	if (priv->regs)
+		iounmap(priv->regs);
+
+	if (priv->group_tcr)
+		iounmap(priv->group_tcr);
+
+	kfree(priv);
+}
+
+static void mpic_timer_resume(void)
+{
+	struct timer_group_priv *priv;
+
+	list_for_each_entry(priv, &timer_group_list, node) {
+		/* Init FSL timer hardware */
+		if (priv->flags & FSL_GLOBAL_TIMER)
+			setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV_64);
+	}
+}
+
+static const struct of_device_id mpic_timer_ids[] = {
+	{ .compatible = "fsl,mpic-global-timer", },
+	{},
+};
+
+static struct syscore_ops mpic_timer_syscore_ops = {
+	.resume = mpic_timer_resume,
+};
+
+static int __init mpic_timer_init(void)
+{
+	struct device_node *np = NULL;
+
+	for_each_matching_node(np, mpic_timer_ids)
+		timer_group_init(np);
+
+	register_syscore_ops(&mpic_timer_syscore_ops);
+
+	if (list_empty(&timer_group_list))
+		return -ENODEV;
+
+	return 0;
+}
+subsys_initcall(mpic_timer_init);
-- 
1.7.5.1
