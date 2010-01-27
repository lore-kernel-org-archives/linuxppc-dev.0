Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C2548B7CE6
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 23:07:37 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8 v2] rtc: Add MPC5121 Real time clock driver
Date: Wed, 27 Jan 2010 13:07:26 +0100
Message-Id: <1264594052-20317-3-git-send-email-agust@denx.de>
In-Reply-To: <1264594052-20317-1-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, rtc-linux@googlegroups.com, Anatolij Gustschin <agust@denx.de>,
	dzu@denx.de, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Rigby <jcrigby@gmail.com>

Based on Domen Puncer's rtc driver for 5200.
Changes to Domen's original:

    Changed filenames/routine names from mpc5200* to mpc5121*
    Changed match to only care about compatible and use "fsl,"
    convention for compatible.

    Make alarms more sane by dealing with lack of second alarm
    resolution.

    Deal with the fact that most of the 5121 rtc registers are not
    persistent across a reset even with a battery attached:

        Use actual_time register for time keeping
        and target_time register as an offset to linux time

        The target_time register would normally be used for hibernation
        but hibernation does not work on current silicon

Signed-off-by: John Rigby <jcrigby@gmail.com>
Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: <rtc-linux@googlegroups.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
Changes since v1 (as requested by Alessandro Zummo):
 - Remove history from the driver file, the same history is in
   commit message
 - implement alarm/irq interface using ->ops structure, don't
   use ops->ioctl() any more
 - Clean up probe()
 - replace printk() by dev_*()
 - add arch dependency in Kconfig
 - add requested include linux/init.h
 - move MODULE_XXX to the end
 - use rtc_valid_tm() when returning 'tm'
 - use __init/__exit/__exit_p as this is not a hotpluggable device

 drivers/rtc/Kconfig       |   10 ++
 drivers/rtc/Makefile      |    1 +
 drivers/rtc/rtc-mpc5121.c |  386 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-mpc5121.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8167e9e..2bb8a8b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -868,4 +868,14 @@ config RTC_DRV_MC13783
 	help
 	  This enables support for the Freescale MC13783 PMIC RTC
 
+config RTC_DRV_MPC5121
+	tristate "Freescale MPC5121 built-in RTC"
+	depends on PPC_MPC512x && RTC_CLASS
+	help
+	  If you say yes here you will get support for the
+	  built-in RTC MPC5121.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-mpc5121.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e5160fd..b7148af 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MC13783)	+= rtc-mc13783.o
 obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
+obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
 obj-$(CONFIG_RTC_DRV_NUC900)	+= rtc-nuc900.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
new file mode 100644
index 0000000..27daf9f
--- /dev/null
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -0,0 +1,386 @@
+/*
+ * Real-time clock driver for MPC5121
+ *
+ * Copyright 2007, Domen Puncer <domen.puncer@telargo.com>
+ * Copyright 2008, Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+
+struct mpc5121_rtc_regs {
+	u8 set_time;		/* RTC + 0x00 */
+	u8 hour_set;		/* RTC + 0x01 */
+	u8 minute_set;		/* RTC + 0x02 */
+	u8 second_set;		/* RTC + 0x03 */
+
+	u8 set_date;		/* RTC + 0x04 */
+	u8 month_set;		/* RTC + 0x05 */
+	u8 weekday_set;		/* RTC + 0x06 */
+	u8 date_set;		/* RTC + 0x07 */
+
+	u8 write_sw;		/* RTC + 0x08 */
+	u8 sw_set;		/* RTC + 0x09 */
+	u16 year_set;		/* RTC + 0x0a */
+
+	u8 alm_enable;		/* RTC + 0x0c */
+	u8 alm_hour_set;	/* RTC + 0x0d */
+	u8 alm_min_set;		/* RTC + 0x0e */
+	u8 int_enable;		/* RTC + 0x0f */
+
+	u8 reserved1;
+	u8 hour;		/* RTC + 0x11 */
+	u8 minute;		/* RTC + 0x12 */
+	u8 second;		/* RTC + 0x13 */
+
+	u8 month;		/* RTC + 0x14 */
+	u8 wday_mday;		/* RTC + 0x15 */
+	u16 year;		/* RTC + 0x16 */
+
+	u8 int_alm;		/* RTC + 0x18 */
+	u8 int_sw;		/* RTC + 0x19 */
+	u8 alm_status;		/* RTC + 0x1a */
+	u8 sw_minute;		/* RTC + 0x1b */
+
+	u8 bus_error_1;		/* RTC + 0x1c */
+	u8 int_day;		/* RTC + 0x1d */
+	u8 int_min;		/* RTC + 0x1e */
+	u8 int_sec;		/* RTC + 0x1f */
+
+	/*
+	 * target_time:
+	 *	intended to be used for hibernation but hibernation
+	 *	does not work on silicon rev 1.5 so use it for non-volatile
+	 *	storage of offset between the actual_time register and linux
+	 *	time
+	 */
+	u32 target_time;	/* RTC + 0x20 */
+	/*
+	 * actual_time:
+	 * 	readonly time since VBAT_RTC was last connected
+	 */
+	u32 actual_time;	/* RTC + 0x24 */
+	u32 keep_alive;		/* RTC + 0x28 */
+};
+
+struct mpc5121_rtc_data {
+	unsigned irq;
+	unsigned irq_periodic;
+	struct mpc5121_rtc_regs __iomem *regs;
+	struct rtc_device *rtc;
+	struct rtc_wkalrm wkalarm;
+};
+
+/*
+ * Update second/minute/hour registers.
+ *
+ * This is just so alarm will work.
+ */
+static void mpc5121_rtc_update_smh(struct mpc5121_rtc_regs __iomem *regs,
+				   struct rtc_time *tm)
+{
+	out_8(&regs->second_set, tm->tm_sec);
+	out_8(&regs->minute_set, tm->tm_min);
+	out_8(&regs->hour_set, tm->tm_hour);
+
+	/* set time sequence */
+	out_8(&regs->set_time, 0x1);
+	out_8(&regs->set_time, 0x3);
+	out_8(&regs->set_time, 0x1);
+	out_8(&regs->set_time, 0x0);
+}
+
+static int mpc5121_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+	unsigned long now;
+
+	/*
+	 * linux time is actual_time plus the offset saved in target_time
+	 */
+	now = in_be32(&regs->actual_time) + in_be32(&regs->target_time);
+
+	rtc_time_to_tm(now, tm);
+
+	/*
+	 * update second minute hour registers
+	 * so alarms will work
+	 */
+	mpc5121_rtc_update_smh(regs, tm);
+
+	return rtc_valid_tm(tm);
+}
+
+static int mpc5121_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+	int ret;
+	unsigned long now;
+
+	/*
+	 * The actual_time register is read only so we write the offset
+	 * between it and linux time to the target_time register.
+	 */
+	ret = rtc_tm_to_time(tm, &now);
+	if (ret == 0)
+		out_be32(&regs->target_time, now - in_be32(&regs->actual_time));
+
+	/*
+	 * update second minute hour registers
+	 * so alarms will work
+	 */
+	mpc5121_rtc_update_smh(regs, tm);
+
+	return 0;
+}
+
+static int mpc5121_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+
+	*alarm = rtc->wkalarm;
+
+	alarm->pending = in_8(&regs->alm_status);
+
+	return 0;
+}
+
+static int mpc5121_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+
+	/*
+	 * the alarm has no seconds so deal with it
+	 */
+	if (alarm->time.tm_sec) {
+		alarm->time.tm_sec = 0;
+		alarm->time.tm_min++;
+		if (alarm->time.tm_min >= 60) {
+			alarm->time.tm_min = 0;
+			alarm->time.tm_hour++;
+			if (alarm->time.tm_hour >= 24)
+				alarm->time.tm_hour = 0;
+		}
+	}
+
+	alarm->time.tm_mday = -1;
+	alarm->time.tm_mon = -1;
+	alarm->time.tm_year = -1;
+
+	out_8(&regs->alm_min_set, alarm->time.tm_min);
+	out_8(&regs->alm_hour_set, alarm->time.tm_hour);
+
+	out_8(&regs->alm_enable, alarm->enabled);
+
+	rtc->wkalarm = *alarm;
+	return 0;
+}
+
+static irqreturn_t mpc5121_rtc_handler(int irq, void *dev)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata((struct device *)dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+
+	if (in_8(&regs->int_alm)) {
+		/* acknowledge and clear status */
+		out_8(&regs->int_alm, 1);
+		out_8(&regs->alm_status, 1);
+
+		rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_AF);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t mpc5121_rtc_handler_upd(int irq, void *dev)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata((struct device *)dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+
+	if (in_8(&regs->int_sec) && (in_8(&regs->int_enable) & 0x1)) {
+		/* acknowledge */
+		out_8(&regs->int_sec, 1);
+
+		rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_UF);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int mpc5121_rtc_alarm_irq_enable(struct device *dev,
+					unsigned int enabled)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+	int val;
+
+	if (enabled)
+		val = 1;
+	else
+		val = 0;
+
+	out_8(&regs->alm_enable, val);
+	rtc->wkalarm.enabled = val;
+
+	return 0;
+}
+
+static int mpc5121_rtc_update_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+	int val;
+
+	val = in_8(&regs->int_enable);
+
+	if (enabled)
+		val = (val & ~0x8) | 0x1;
+	else
+		val &= ~0x1;
+
+	out_8(&regs->int_enable, val);
+
+	return 0;
+}
+
+static const struct rtc_class_ops mpc5121_rtc_ops = {
+	.read_time = mpc5121_rtc_read_time,
+	.set_time = mpc5121_rtc_set_time,
+	.read_alarm = mpc5121_rtc_read_alarm,
+	.set_alarm = mpc5121_rtc_set_alarm,
+	.alarm_irq_enable = mpc5121_rtc_alarm_irq_enable,
+	.update_irq_enable = mpc5121_rtc_update_irq_enable,
+};
+
+static int __init mpc5121_rtc_probe(struct of_device *op,
+					const struct of_device_id *match)
+{
+	struct mpc5121_rtc_data *rtc;
+	int err = 0;
+	u32 ka;
+
+	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->regs = of_iomap(op->node, 0);
+	if (!rtc->regs) {
+		dev_err(&op->dev, "%s: couldn't map io space\n", __func__);
+		err = -ENOSYS;
+		goto out_free;
+	}
+
+	device_init_wakeup(&op->dev, 1);
+
+	rtc->rtc = rtc_device_register("mpc5121-rtc", &op->dev,
+					&mpc5121_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc)) {
+		err = PTR_ERR(rtc->rtc);
+		goto out_unmap;
+	}
+
+	dev_set_drvdata(&op->dev, rtc);
+
+	rtc->irq = irq_of_parse_and_map(op->node, 1);
+	err = request_irq(rtc->irq, mpc5121_rtc_handler, IRQF_DISABLED,
+						"mpc5121-rtc", &op->dev);
+	if (err) {
+		dev_err(&op->dev, "%s: could not request irq: %i\n",
+							__func__, rtc->irq);
+		goto out_dispose;
+	}
+
+	rtc->irq_periodic = irq_of_parse_and_map(op->node, 0);
+	err = request_irq(rtc->irq_periodic, mpc5121_rtc_handler_upd,
+				IRQF_DISABLED, "mpc5121-rtc_upd", &op->dev);
+	if (err) {
+		dev_err(&op->dev, "%s: could not request irq: %i\n",
+						__func__, rtc->irq_periodic);
+		goto out_dispose2;
+	}
+
+	ka = in_be32(&rtc->regs->keep_alive);
+	if (ka & 0x02) {
+		dev_warn(&op->dev,
+			"mpc5121-rtc: Battery or oscillator failure!\n");
+		out_be32(&rtc->regs->keep_alive, ka);
+	}
+
+	return 0;
+
+out_dispose2:
+	irq_dispose_mapping(rtc->irq_periodic);
+	free_irq(rtc->irq, &op->dev);
+out_dispose:
+	irq_dispose_mapping(rtc->irq);
+out_unmap:
+	iounmap(rtc->regs);
+out_free:
+	kfree(rtc);
+
+	return err;
+}
+
+static int __exit mpc5121_rtc_remove(struct of_device *op)
+{
+	struct mpc5121_rtc_data *rtc = dev_get_drvdata(&op->dev);
+	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
+
+	/* disable interrupt, so there are no nasty surprises */
+	out_8(&regs->alm_enable, 0);
+	out_8(&regs->int_enable, in_8(&regs->int_enable) & ~0x1);
+
+	rtc_device_unregister(rtc->rtc);
+	iounmap(rtc->regs);
+	free_irq(rtc->irq, &op->dev);
+	free_irq(rtc->irq_periodic, &op->dev);
+	irq_dispose_mapping(rtc->irq);
+	irq_dispose_mapping(rtc->irq_periodic);
+	dev_set_drvdata(&op->dev, NULL);
+	kfree(rtc);
+
+	return 0;
+}
+
+static struct of_device_id mpc5121_rtc_match[] = {
+	{ .compatible = "fsl,mpc5121-rtc", },
+	{},
+};
+
+static struct of_platform_driver mpc5121_rtc_driver = {
+	.owner = THIS_MODULE,
+	.name = "mpc5121-rtc",
+	.match_table = mpc5121_rtc_match,
+	.probe = mpc5121_rtc_probe,
+	.remove = __exit_p(mpc5121_rtc_remove),
+};
+
+static int __init mpc5121_rtc_init(void)
+{
+	return of_register_platform_driver(&mpc5121_rtc_driver);
+}
+module_init(mpc5121_rtc_init);
+
+static void __exit mpc5121_rtc_exit(void)
+{
+	of_unregister_platform_driver(&mpc5121_rtc_driver);
+}
+module_exit(mpc5121_rtc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Rigby <jcrigby@gmail.com>");
-- 
1.5.6.3
