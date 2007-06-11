Return-Path: <rzhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 6635CDDF08
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 21:55:50 +1000 (EST)
Subject: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class driver
	subsystem
From: Mark Zhan <rongkai.zhan@windriver.com>
To: a.zummo@towertech.it
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:56:40 +0800
Message-Id: <1181548600.5217.16.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the support of ST M48T59 RTC chip driver in RTC class subsystem for
Wind River SBC PowerQUICCII 82xx board

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
 b/drivers/rtc/Kconfig      |   10 +
 b/drivers/rtc/Makefile     |    1 
 b/drivers/rtc/rtc-m48t59.c |  360
+++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4e4c10a..ca6a064 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -329,6 +329,16 @@ config RTC_DRV_S3C
 	  This driver can also be build as a module. If so, the module
 	  will be called rtc-s3c.
 
+config RTC_DRV_M48T59
+	tristate "ST M48T59"
+	depends on RTC_CLASS
+	help
+	  If you say Y here you will get support for the
+	  ST M48T59 RTC chip.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-m48t59".
+
 config RTC_DRV_EP93XX
 	tristate "Cirrus Logic EP93XX"
 	depends on RTC_CLASS && ARCH_EP93XX
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a1afbc2..70ba581 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
+obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
new file mode 100644
index 0000000..0737827
--- /dev/null
+++ b/drivers/rtc/rtc-m48t59.c
@@ -0,0 +1,360 @@
+/*
+ * ST M48T59 RTC driver
+ *
+ * Copyright (c) 2007 Wind River Systems, Inc.
+ *
+ * Author: Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/bcd.h>
+
+#define DEBUG_M48T59 1
+
+#ifdef DEBUG_M48T59
+#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: "fmt,
__FUNCTION__, ##args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#define M48T59_YEAR		0x1fff
+#define M48T59_MONTH		0x1ffe
+#define M48T59_MDAY		0x1ffd	/* Day of Month */
+#define M48T59_WDAY		0x1ffc	/* Day of Week */
+#define M48T59_HOUR		0x1ffb
+#define M48T59_MIN		0x1ffa
+#define M48T59_SEC		0x1ff9
+#define M48T59_CNTL		0x1ff8
+#define M48T59_WATCHDOG		0x1ff7
+#define M48T59_INTR		0x1ff6
+#define M48T59_ALARM_DATE	0x1ff5
+#define M48T59_ALARM_HOUR	0x1ff4
+#define M48T59_ALARM_MIN	0x1ff3
+#define M48T59_ALARM_SEC	0x1ff2
+#define M48T59_UNUSED		0x1ff1
+#define M48T59_FLAGS		0x1ff0
+
+#define M48T59_WDAY_CB		0x20	/* Century Bit */
+#define M48T59_WDAY_CEB		0x10	/* Century Enable Bit */
+
+#define M48T59_CNTL_READ	0x40;
+#define M48T59_CNTL_WRITE	0x80;
+
+#define M48T59_FLAGS_WDT	0x80	/* watchdog timer expired */
+#define M48T59_FLAGS_AF		0x40	/* alarm */
+#define M48T59_FLAGS_BF		0x10	/* low battery */
+
+#define M48T59_INTR_AFE		0x80	/* Alarm Interrupt Enable */
+#define M48T59_INTR_ABE		0x20
+
+static unsigned char * m48t59_vbase = NULL;
+static unsigned int m48t59_irq = -1;
+
+#define M48T59_READ(reg)	readb(m48t59_vbase+reg)
+#define M48T59_WRITE(val, reg)	writeb((val), (m48t59_vbase+reg))
+
+/**
+ * NOTE: M48T59 only uses BCD mode
+ */
+static int m48t59_rtc_read_time(struct device *dev, struct rtc_time
*tm)
+{
+	unsigned char val;
+
+	/* Issue the READ command */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) | 0x40), M48T59_CNTL);
+
+	tm->tm_year	= BCD2BIN(M48T59_READ(M48T59_YEAR));
+	/* tm_mon is 0-11 */
+	tm->tm_mon	= BCD2BIN(M48T59_READ(M48T59_MONTH)) - 1;
+	tm->tm_mday	= BCD2BIN(M48T59_READ(M48T59_MDAY));
+
+	val = M48T59_READ(M48T59_WDAY);
+	if ((val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB)) {
+		DPRINTK("Century bit is enabled\n");
+		tm->tm_year += 100;	/* one century */
+	}
+
+	tm->tm_wday	= BCD2BIN(val & 0x07);
+	tm->tm_hour	= BCD2BIN(M48T59_READ(M48T59_HOUR) & 0x3F);
+	tm->tm_min	= BCD2BIN(M48T59_READ(M48T59_MIN) & 0x7F);
+	tm->tm_sec	= BCD2BIN(M48T59_READ(M48T59_SEC) & 0x7F);
+
+	/* Clear the READ bit to restore the update */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) & ~0x40), M48T59_CNTL);
+
+	DPRINTK("RTC read time %04d-%02d-%02d %02d/%02d/%02d\n",
+		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+
+static int m48t59_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char val = 0;
+
+	DPRINTK("RTC set time %04d-%02d-%02d %02d/%02d/%02d\n",
+		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	/* Issue the WRITE command */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) | 0x80), M48T59_CNTL);
+
+	M48T59_WRITE((BIN2BCD(tm->tm_sec) & 0x7F), M48T59_SEC);
+	M48T59_WRITE((BIN2BCD(tm->tm_min) & 0x7F), M48T59_MIN);
+	M48T59_WRITE((BIN2BCD(tm->tm_hour) & 0x3F), M48T59_HOUR);
+	M48T59_WRITE((BIN2BCD(tm->tm_mday) & 0x3F), M48T59_MDAY);
+	/* tm_mon is 0-11 */
+	M48T59_WRITE((BIN2BCD(tm->tm_mon + 1) & 0x1F), M48T59_MONTH);
+	M48T59_WRITE(BIN2BCD(tm->tm_year % 100), M48T59_YEAR);
+
+	if (tm->tm_year/100)
+		val = (M48T59_WDAY_CEB | M48T59_WDAY_CB);
+	val |= (BIN2BCD(tm->tm_wday) & 0x07);
+	M48T59_WRITE(val, M48T59_WDAY);
+
+	/* update ended */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) & ~0x80), M48T59_CNTL);
+
+	return 0;
+}
+
+/*
+ * Read alarm time and date in RTC
+ */
+static int m48t59_rtc_readalarm(struct device *dev, struct rtc_wkalrm
*alrm)
+{
+	unsigned char val;
+	struct rtc_time *tm = &alrm->time;
+
+	/* If no irq, we don't support ALARM */
+	if (m48t59_irq == -1)
+		return -EIO;
+
+	/* Issue the READ command */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) | 0x40), M48T59_CNTL);
+
+	tm->tm_year = BCD2BIN(M48T59_READ(M48T59_YEAR));
+	/* tm_mon is 0-11 */
+	tm->tm_mon = BCD2BIN(M48T59_READ(M48T59_MONTH)) - 1;
+
+	val = M48T59_READ(M48T59_WDAY);
+	if ((val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB))
+		tm->tm_year += 100;	/* one century */
+
+	tm->tm_mday = BCD2BIN(M48T59_READ(M48T59_ALARM_DATE));
+	tm->tm_hour = BCD2BIN(M48T59_READ(M48T59_ALARM_HOUR));
+	tm->tm_min = BCD2BIN(M48T59_READ(M48T59_ALARM_MIN));
+	tm->tm_sec = BCD2BIN(M48T59_READ(M48T59_ALARM_SEC));
+
+	/* Clear the READ bit to restore the update */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) & ~0x40), M48T59_CNTL);
+
+	DPRINTK("RTC read alarm time %04d-%02d-%02d %02d/%02d/%02d\n",
+		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+
+/*
+ * Set alarm time and date in RTC
+ */
+static int m48t59_rtc_setalarm(struct device *dev, struct rtc_wkalrm
*alrm)
+{
+	struct rtc_time *tm = &alrm->time;
+	unsigned char mday, hour, min, sec;
+
+	if (m48t59_irq == -1)
+		return -EIO;
+
+	/*
+	 * 0xff means "always match"
+	 */
+	mday = tm->tm_mday;
+	mday = (mday >= 1 && mday <= 31) ? BIN2BCD(mday) : 0xff;
+	if (mday == 0xff)
+		mday = M48T59_READ(M48T59_MDAY);
+
+	hour = tm->tm_hour;
+	hour = (hour < 24) ? BIN2BCD(hour) : 0x00;
+
+	min = tm->tm_min;
+	min = (min < 60) ? BIN2BCD(min) : 0x00;
+
+	sec = tm->tm_sec;
+	sec = (sec < 60) ? BIN2BCD(sec) : 0x00;
+
+	/* Issue the WRITE command */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) | 0x80), M48T59_CNTL);
+
+	M48T59_WRITE(mday, M48T59_ALARM_DATE);
+	M48T59_WRITE(hour, M48T59_ALARM_HOUR);
+	M48T59_WRITE(min, M48T59_ALARM_MIN);
+	M48T59_WRITE(sec, M48T59_ALARM_SEC);
+
+	/* update ended */
+	M48T59_WRITE((M48T59_READ(M48T59_CNTL) & ~0x80), M48T59_CNTL);
+
+	DPRINTK("RTC set alarm time %04d-%02d-%02d %02d/%02d/%02d\n",
+		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	return 0;
+}
+
+/*
+ * Handle commands from user-space
+ */
+static int m48t59_rtc_ioctl(struct device *dev, unsigned int cmd,
+			unsigned long arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case RTC_AIE_OFF:	/* alarm interrupt off */
+		M48T59_WRITE(0x00, M48T59_INTR);
+		break;
+	case RTC_AIE_ON:	/* alarm interrupt on */
+		M48T59_WRITE(M48T59_INTR_AFE, M48T59_INTR);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return ret;
+}
+
+static int m48t59_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	unsigned char val;
+
+	val = M48T59_READ(M48T59_FLAGS);
+	seq_printf(seq, "battery\t\t: %s\n",
+		 (val & M48T59_FLAGS_BF) ? "low" : "normal");
+
+	return 0;
+}
+
+/*
+ * IRQ handler for the RTC
+ */
+static irqreturn_t m48t59_rtc_interrupt(int irq, void *dev_id)
+{
+	unsigned char flags;
+	struct platform_device *pdev = (struct platform_device *)dev_id;
+	struct rtc_device *rdev;
+
+	flags = M48T59_READ(M48T59_FLAGS);
+	if (flags & M48T59_FLAGS_AF) {
+		rdev = (struct rtc_device *)platform_get_drvdata(pdev);
+		rtc_update_irq(rdev, 1, (RTC_AF | RTC_IRQF));
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static const struct rtc_class_ops m48t59_rtc_ops = {
+	.ioctl		= m48t59_rtc_ioctl,
+	.read_time	= m48t59_rtc_read_time,
+	.set_time	= m48t59_rtc_set_time,
+	.read_alarm	= m48t59_rtc_readalarm,
+	.set_alarm	= m48t59_rtc_setalarm,
+	.proc		= m48t59_rtc_proc,
+};
+
+static int __devinit m48t59_rtc_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct rtc_device *rtc_dev;
+	int ret = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	m48t59_vbase = ioremap(res->start, (res->end - res->start + 1));
+	if (!m48t59_vbase)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res)
+		m48t59_irq = res->start;
+
+	if (m48t59_irq != -1) {
+		ret = request_irq(m48t59_irq, m48t59_rtc_interrupt,
+			IRQF_SHARED, "rtc-m48t59", pdev);
+		if (ret)
+			goto err_unmap;
+	}
+
+	rtc_dev = rtc_device_register("m48t59", &pdev->dev,
+				&m48t59_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc_dev)) {
+		ret = PTR_ERR(rtc_dev);
+		goto err_freeirq;
+	}
+
+	platform_set_drvdata(pdev, rtc_dev);
+	return 0;
+
+err_freeirq:
+	if (m48t59_irq != -1)
+		free_irq(m48t59_irq, pdev);
+err_unmap:
+	iounmap(m48t59_vbase);
+	return ret;
+}
+
+static int __devexit m48t59_rtc_remove(struct platform_device *pdev)
+{
+	struct rtc_device *rtc = platform_get_drvdata(pdev);
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (m48t59_vbase)
+		iounmap(m48t59_vbase);
+	m48t59_vbase = NULL;
+
+	if (m48t59_irq != -1)
+		free_irq(m48t59_irq, pdev);
+	m48t59_irq = -1;
+	return 0;
+}
+
+static struct platform_driver m48t59_rtc_platform_driver = {
+	.driver		= {
+		.name	= "rtc-m48t59",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= m48t59_rtc_probe,
+	.remove		= __devexit_p(m48t59_rtc_remove),
+};
+
+static int __init m48t59_rtc_init(void)
+{
+	return platform_driver_register(&m48t59_rtc_platform_driver);
+}
+
+static void __exit m48t59_rtc_exit(void)
+{
+	platform_driver_unregister(&m48t59_rtc_platform_driver);
+}
+
+module_init(m48t59_rtc_init);
+module_exit(m48t59_rtc_exit);
+
+MODULE_AUTHOR("Mark Zhan <rongkai.zhan@windriver.com>");
+MODULE_DESCRIPTION("M48T59 RTC driver");
+MODULE_LICENSE("GPL");
