Return-Path: <Dongsheng.Wang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D82C140164
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 12:26:47 +1000 (EST)
Received: from mail117-ch1 (localhost [127.0.0.1])	by
 mail117-ch1-R.bigfish.com (Postfix) with ESMTP id 2282E100288	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 02:26:09 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 2/2] fsl/mpic_timer: make mpic_timer to support deep sleep
 feature
Date: Mon, 14 Apr 2014 10:24:10 +0800
Message-ID: <1397442250-14886-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
References: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 jason.jin@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

At T104x platfrom the timer clock will be changed when system going to
deep sleep. Add suspend function to switch timer time before system
going to deep sleep, and recovery the time after resume from deep sleep.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index 9d9b062..737a53d 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -11,6 +11,7 @@
  * option) any later version.
  */
 
+#include <linux/fsl/fsl_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -26,6 +28,7 @@
 #include <sysdev/fsl_soc.h>
 #include <asm/io.h>
 
+#include <asm/mpc85xx.h>
 #include <asm/mpic_timer.h>
 
 #define FSL_GLOBAL_TIMER		0x1
@@ -71,8 +74,10 @@ struct timer_group_priv {
 	struct timer_regs __iomem	*regs;
 	struct mpic_timer		timer[TIMERS_PER_GROUP];
 	struct list_head		node;
+	unsigned long			idle;
 	unsigned int			timerfreq;
-	unsigned int			idle;
+	unsigned int			suspended_timerfreq;
+	unsigned int			resume_timerfreq;
 	unsigned int			flags;
 	spinlock_t			lock;
 	void __iomem			*group_tcr;
@@ -88,6 +93,7 @@ static struct cascade_priv cascade_timer[] = {
 };
 
 static LIST_HEAD(timer_group_list);
+static int switch_freq_flag;
 
 static void convert_ticks_to_time(struct timer_group_priv *priv,
 		const u64 ticks, struct timeval *time)
@@ -423,6 +429,33 @@ struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
 }
 EXPORT_SYMBOL(mpic_request_timer);
 
+static void timer_group_get_suspended_freq(struct timer_group_priv *priv)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-clockgen-2.0");
+	if (!np) {
+		pr_err("mpic timer: Missing clockgen device node.\n");
+
+		return;
+	}
+
+	of_property_read_u32(np, "clock-frequency", &priv->suspended_timerfreq);
+	of_node_put(np);
+}
+
+static int need_to_switch_freq(void)
+{
+	u32 svr;
+
+	svr = mfspr(SPRN_SVR);
+	if (SVR_SOC_VER(svr) == SVR_T1040 ||
+			SVR_SOC_VER(svr) == SVR_T1042)
+		return 1;
+
+	return 0;
+}
+
 static int timer_group_get_freq(struct device_node *np,
 			struct timer_group_priv *priv)
 {
@@ -437,6 +470,15 @@ static int timer_group_get_freq(struct device_node *np,
 					&priv->timerfreq);
 			of_node_put(dn);
 		}
+
+		/*
+		 * For deep sleep, if system going to deep sleep,
+		 * timer freq will be changed.
+		 */
+		if (need_to_switch_freq()) {
+			timer_group_get_suspended_freq(priv);
+			switch_freq_flag = 1;
+		}
 	}
 
 	if (priv->timerfreq <= 0)
@@ -445,6 +487,7 @@ static int timer_group_get_freq(struct device_node *np,
 	if (priv->flags & FSL_GLOBAL_TIMER) {
 		div = (1 << (MPIC_TIMER_TCR_CLKDIV >> 8)) * 8;
 		priv->timerfreq /= div;
+		priv->suspended_timerfreq /= div;
 	}
 
 	return 0;
@@ -564,14 +607,190 @@ out:
 	kfree(priv);
 }
 
+static void mpic_reset_time(struct mpic_timer *handle, struct timeval *bcr_time,
+				struct timeval *ccr_time)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+
+	u64 ccr_ticks = 0;
+	u64 bcr_ticks = 0;
+
+	/* switch bcr time */
+	convert_time_to_ticks(priv, bcr_time, &bcr_ticks);
+
+	/* switch ccr time */
+	convert_time_to_ticks(priv, ccr_time, &ccr_ticks);
+
+	if (handle->cascade_handle) {
+		u32 tmp_ticks;
+		u32 rem_ticks;
+
+		/* reset ccr ticks to bcr */
+		tmp_ticks = div_u64_rem(ccr_ticks, MAX_TICKS_CASCADE,
+					&rem_ticks);
+		out_be32(&priv->regs[handle->num].gtbcr,
+			tmp_ticks | TIMER_STOP);
+		out_be32(&priv->regs[handle->num - 1].gtbcr, rem_ticks);
+
+		/* start timer */
+		clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+
+		/* reset bcr */
+		tmp_ticks = div_u64_rem(bcr_ticks, MAX_TICKS_CASCADE,
+					&rem_ticks);
+		out_be32(&priv->regs[handle->num].gtbcr,
+			tmp_ticks & ~TIMER_STOP);
+		out_be32(&priv->regs[handle->num - 1].gtbcr, rem_ticks);
+	} else {
+		/* reset ccr ticks to bcr */
+		out_be32(&priv->regs[handle->num].gtbcr,
+			ccr_ticks | TIMER_STOP);
+		/* start timer */
+		clrbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+		/* reset bcr */
+		out_be32(&priv->regs[handle->num].gtbcr,
+			bcr_ticks & ~TIMER_STOP);
+	}
+}
+
+static void do_switch_time(struct mpic_timer *handle, unsigned int new_freq)
+{
+	struct timer_group_priv *priv = container_of(handle,
+			struct timer_group_priv, timer[handle->num]);
+	struct timeval ccr_time;
+	struct timeval bcr_time;
+	unsigned int timerfreq;
+	u32 test_stop;
+	u64 ticks;
+
+	test_stop = in_be32(&priv->regs[handle->num].gtbcr);
+	test_stop &= TIMER_STOP;
+	if (test_stop)
+		return;
+
+	/* stop timer, prepare reset time */
+	setbits32(&priv->regs[handle->num].gtbcr, TIMER_STOP);
+
+	/* get bcr time */
+	if (handle->cascade_handle) {
+		u32 tmp_ticks;
+
+		tmp_ticks = in_be32(&priv->regs[handle->num].gtbcr);
+		tmp_ticks &= ~TIMER_STOP;
+		ticks = ((u64)tmp_ticks & UINT_MAX) * (u64)MAX_TICKS_CASCADE;
+		tmp_ticks = in_be32(&priv->regs[handle->num - 1].gtbcr);
+		ticks += tmp_ticks;
+	} else {
+		ticks = in_be32(&priv->regs[handle->num].gtbcr);
+		ticks &= ~TIMER_STOP;
+	}
+	convert_ticks_to_time(priv, ticks, &bcr_time);
+
+	/* get ccr time */
+	mpic_get_remain_time(handle, &ccr_time);
+
+	/* recalculate timer time */
+	timerfreq = priv->timerfreq;
+	priv->timerfreq = new_freq;
+	mpic_reset_time(handle, &bcr_time, &ccr_time);
+	priv->timerfreq = timerfreq;
+}
+
+static void switch_group_timer(struct timer_group_priv *priv,
+				unsigned int new_freq)
+{
+	int i, num;
+
+	for (i = 0; i < TIMERS_PER_GROUP; i++) {
+		num = TIMERS_PER_GROUP - 1 - i;
+		/* cascade */
+		if ((i + 1) < TIMERS_PER_GROUP &&
+				priv->timer[num].cascade_handle) {
+			do_switch_time(&priv->timer[num], new_freq);
+			i++;
+			continue;
+		}
+
+		if (!test_bit(i, &priv->idle))
+			do_switch_time(&priv->timer[num], new_freq);
+	}
+}
+
+static int mpic_timer_suspend(void)
+{
+	struct timer_group_priv *priv;
+	suspend_state_t pm_state;
+
+	pm_state = pm_suspend_state();
+
+	list_for_each_entry(priv, &timer_group_list, node) {
+		/* timer not be used */
+		if (priv->idle == 0xf)
+			continue;
+
+		switch (pm_state) {
+		case PM_SUSPEND_STANDBY:
+			break;
+		case PM_SUSPEND_MEM:
+			if (!switch_freq_flag)
+				continue;
+
+			if (!priv->suspended_timerfreq) {
+				pr_warn("Mpic timer will not be accurate.\n");
+				continue;
+			}
+
+			/* will switch timers, a set of timer */
+			switch_group_timer(priv, priv->suspended_timerfreq);
+
+			/* Software: switch timerfreq to suspended freq */
+			priv->resume_timerfreq = priv->timerfreq;
+			priv->timerfreq = priv->suspended_timerfreq;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static void mpic_timer_resume(void)
 {
 	struct timer_group_priv *priv;
+	suspend_state_t pm_state;
+
+	pm_state = pm_suspend_state();
 
 	list_for_each_entry(priv, &timer_group_list, node) {
 		/* Init FSL timer hardware */
 		if (priv->flags & FSL_GLOBAL_TIMER)
 			setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
+
+		/* timer not be used */
+		if (priv->idle == 0xf)
+			continue;
+
+		switch (pm_state) {
+		case PM_SUSPEND_STANDBY:
+			break;
+		case PM_SUSPEND_MEM:
+			if (!switch_freq_flag)
+				continue;
+
+			if (!priv->suspended_timerfreq)
+				continue;
+
+			/* will switch timers, a set of timer */
+			switch_group_timer(priv, priv->resume_timerfreq);
+
+			/* restore timerfreq */
+			priv->timerfreq = priv->resume_timerfreq;
+			break;
+		default:
+			break;
+		}
 	}
 }
 
@@ -581,6 +800,7 @@ static const struct of_device_id mpic_timer_ids[] = {
 };
 
 static struct syscore_ops mpic_timer_syscore_ops = {
+	.suspend = mpic_timer_suspend,
 	.resume = mpic_timer_resume,
 };
 
-- 
1.8.5
