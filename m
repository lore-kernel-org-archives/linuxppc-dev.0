Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97C8ADE074
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:53:49 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4I7rfpr004390
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 00:53:42 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n4I7rZmI022435
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 02:53:36 -0500 (CDT)
Date: Mon, 18 May 2009 15:53:30 +0800
From: "=?utf-8?B?SG9uZ2p1biBDaGVu?=" <r66092@freescale.com>
To: "=?utf-8?B?d2Q=?=" <wd@denx.de>
References: <mailman.7208.1241640931.26545.linuxppc-dev@ozlabs.org>
Subject: =?utf-8?B?UmU6IExpbnV4cHBjLWRldiBEaWdlc3QsIFZvbCA1NywgSXNzdWUgNDI=?=
Message-ID: <200905181553293732620@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: =?utf-8?B?bGludXhwcGMtZGV2QG96bGFicy5vcmc=?= <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why should you reinvent wheel for MPC512x DMA driver? We have a ready DMA driver, which has been used by MPC5121 AC97, VIU, ATA etc.

B.R,
Hongjun Chen
2009-05-18

发件人： linuxppc-dev-request@ozlabs.org
发送时间： 2009-05-07 04:38:43
收件人： linuxppc-dev@ozlabs.org
抄送： 
主题： Linuxppc-dev Digest, Vol 57, Issue 42

Send Linuxppc-dev mailing list submissions to
linuxppc-dev@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
https://ozlabs.org/mailman/listinfo/linuxppc-dev
or, via email, send a message with subject or body 'help' to
linuxppc-dev-request@ozlabs.org

You can reach the person managing the list at
linuxppc-dev-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-dev digest..."


Today's Topics:

   1. [PATCH 08/12] mpc5121: Added I2C support. (Wolfgang Denk)
   2. [PATCH 05/12] mpc5121ads: Added Reset Module node to DTS.
      (Wolfgang Denk)
   3. [PATCH 10/12] mpc5121: Add MPC5121 Real time clock driver.
      (Wolfgang Denk)
   4. [PATCH 11/12] mpc5121: Added MPC512x DMA driver. (Wolfgang Denk)


----------------------------------------------------------------------

Message: 1
Date: Wed,  6 May 2009 22:15:15 +0200
From: Wolfgang Denk  <wd@denx.de >
Subject: [PATCH 08/12] mpc5121: Added I2C support.
To: linuxppc-dev@ozlabs.org
Cc: linux-i2c@vger.kernel.org, Piotr Ziecik  <kosmo@semihalf.com >,
Wolfgang Denk  <wd@denx.de >
Message-ID:  <1241640919-4650-9-git-send-email-wd@denx.de >

From: Piotr Ziecik  <kosmo@semihalf.com >

- Enabled I2C interrupts on MPC5121.
- Updated Kconfig for i2c-mpc driver.

Signed-off-by: Piotr Ziecik  <kosmo@semihalf.com >
Signed-off-by: Wolfgang Denk  <wd@denx.de >
Cc:  <linux-i2c@vger.kernel.org >
Cc: Grant Likely  <grant.likely@secretlab.ca >
Cc: John Rigby  <jcrigby@gmail.com >
---
 arch/powerpc/platforms/512x/mpc5121_ads.c    |    2 ++
 arch/powerpc/platforms/512x/mpc512x.h        |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c |   24 ++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                   |    9 +++++----
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 441abc4..a8976b4 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,6 +42,8 @@ static void __init mpc5121_ads_setup_arch(void)
  for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
  mpc83xx_add_bridge(np);
 #endif
+
+ mpc512x_init_i2c();
 }

 static void __init mpc5121_ads_init_IRQ(void)
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 9c03693..f4db8a7 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,5 +13,6 @@
 #define __MPC512X_H__
 extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 extern void __init mpc512x_init_IRQ(void);
+extern void __init mpc512x_init_i2c(void);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif /* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 7135d89..b776e45 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -65,6 +65,30 @@ void __init mpc512x_init_IRQ(void)
  ipic_set_default_priority();
 }

+void __init mpc512x_init_i2c(void)
+{
+ struct device_node *np;
+ void __iomem *i2cctl;
+
+ /* Enable I2C interrupts */
+ np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-i2c-ctrl");
+ if (np) {
+ i2cctl = of_iomap(np, 0);
+ if (i2cctl) {
+ /*
+  * Set interrupt enable bits:
+  *  - I2C-0: bit 24,
+  *  - I2C-1: bit 26,
+  *  - I2C-2: bit 28.
+  */
+ out_be32(i2cctl, 0x15000000);
+ iounmap(i2cctl);
+ }
+
+ of_node_put(np);
+ }
+}
+
 /*
  * Nodes to do bus probe on, soc and localbus
  */
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a48c8ae..57ed637 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -391,13 +391,14 @@ config I2C_IXP2000
    instead.

 config I2C_MPC
- tristate "MPC107/824x/85xx/52xx/86xx"
+ tristate "MPC107/824x/85xx/512x/52xx/86xx"
  depends on PPC32
  help
    If you say yes to this option, support will be included for the
-   built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-   MPC85xx/MPC8641 family processors. The driver may also work on 52xx
-   family processors, though interrupts are known not to work.
+   built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245,
+   MPC85xx/MPC8641 and MPC512x family processors. The driver may
+   also work on 52xx family processors, though interrupts are known
+   not to work.

    This driver can also be built as a module.  If so, the module
    will be called i2c-mpc.
-- 
1.6.0.6



------------------------------

Message: 2
Date: Wed,  6 May 2009 22:15:12 +0200
From: Wolfgang Denk  <wd@denx.de >
Subject: [PATCH 05/12] mpc5121ads: Added Reset Module node to DTS.
To: linuxppc-dev@ozlabs.org
Cc: Piotr Ziecik  <kosmo@semihalf.com >, Wolfgang Denk  <wd@denx.de >
Message-ID:  <1241640919-4650-6-git-send-email-wd@denx.de >

From: Piotr Ziecik  <kosmo@semihalf.com >

Signed-off-by: Piotr Ziecik  <kosmo@semihalf.com >
Signed-off-by: Wolfgang Denk  <wd@denx.de >
Cc: Grant Likely  <grant.likely@secretlab.ca >
Cc: John Rigby  <jcrigby@gmail.com >
---
 arch/powerpc/boot/dts/mpc5121ads.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c2b8dbf..1b83a9d 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -166,6 +166,11 @@
  interrupt-parent =  < &ipic  >;
  };

+ reset@e00 { // Reset module
+ compatible = "fsl,mpc5121-reset";
+ reg =  <0xe00 0x100 >;
+ };
+
  clock@f00 { // Clock control
  compatible = "fsl,mpc5121-clock";
  reg =  <0xf00 0x100 >;
-- 
1.6.0.6



------------------------------

Message: 3
Date: Wed,  6 May 2009 22:15:17 +0200
From: Wolfgang Denk  <wd@denx.de >
Subject: [PATCH 10/12] mpc5121: Add MPC5121 Real time clock driver.
To: linuxppc-dev@ozlabs.org
Cc: Piotr Ziecik  <kosmo@semihalf.com >, rtc-linux@googlegroups.com,
John Rigby  <jrigby@freescale.com >, Wolfgang Denk  <wd@denx.de >
Message-ID:  <1241640919-4650-11-git-send-email-wd@denx.de >

From: John Rigby  <jrigby@freescale.com >

Based on Domen Puncer's rtc driver for 5200 posted to
the ppclinux mailing list:
http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11675
but never commited anywhere.

Changes to Domen's original:

    Changed filenames/routine names from mpc5200* to mpc5121*
    Changed match to only care about compatible and use "fsl,"
    convention for compatible.

    Make alarms more sane by dealing with lack of second alarm resolution.

    Deal with the fact that most of the 5121 rtc registers are not persistent
    across a reset even with a battery attached:

Use actual_time register for time keeping
and target_time register as an offset to linux time

The target_time register would normally be used for hibernation
but hibernation does not work on current silicon

Signed-off-by: John Rigby  <jrigby@freescale.com >
Signed-off-by: Piotr Ziecik  <kosmo@semihalf.com >
Signed-off-by: Wolfgang Denk  <wd@denx.de >
Cc:  <rtc-linux@googlegroups.com >
Cc: Grant Likely  <grant.likely@secretlab.ca >
Cc: John Rigby  <jcrigby@gmail.com >
---
 drivers/rtc/Kconfig       |   10 +
 drivers/rtc/Makefile      |    1 +
 drivers/rtc/rtc-mpc5121.c |  408 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-mpc5121.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4e9851f..900d5b8 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -750,4 +750,14 @@ config RTC_DRV_PS3
    This driver can also be built as a module. If so, the module
    will be called rtc-ps3.

+config RTC_DRV_MPC5121
+ tristate "Freescale MPC5121 built-in RTC"
+ depends on RTC_CLASS
+ help
+   If you say yes here you will get support for the
+   built-in RTC MPC5121.
+
+   This driver can also be built as a module. If so, the module
+   will be called rtc-mpc5121.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6c0639a..8c6d6a7 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RTC_DRV_STARFIRE) += rtc-starfire.o
 obj-$(CONFIG_RTC_DRV_MAX6900) += rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902) += rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MV) += rtc-mv.o
+obj-$(CONFIG_RTC_DRV_MPC5121) += rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_OMAP) += rtc-omap.o
 obj-$(CONFIG_RTC_DRV_PCF8563) += rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583) += rtc-pcf8583.o
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
new file mode 100644
index 0000000..63460cb
--- /dev/null
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -0,0 +1,408 @@
+/*
+ * Real-time clock driver for MPC5121
+ *
+ * Copyright 2007, Domen Puncer  <domen.puncer@telargo.com >
+ * Copyright 2008, Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * History:
+ *
+ * Based on mpc5200_rtc.c written by Domen Puncer  <domen.puncer@telargo.com >
+ *   posted to linuxppc-embedded mailing list:
+ *     http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11675
+ *   but never committed to any public tree.
+ *
+ * Author: John Rigby  <jrigby@freescale.com >
+ *   Converted to 5121 rtc driver.
+ *
+ *   Make alarms more sane by dealing with lack of second alarm resolution.
+ *
+ *   Use actual_time time register for time keeping since it is persistent
+ *   and the normal rtc registers are not.  Use target_time register as an
+ *   offset to linux time.
+ *
+ */
+
+#include  <linux/module.h >
+#include  <linux/rtc.h >
+#include  <linux/of_device.h >
+#include  <linux/of_platform.h >
+#include  <linux/io.h >
+
+struct mpc5121_rtc_regs {
+ u8 set_time; /* RTC + 0x00 */
+ u8 hour_set; /* RTC + 0x01 */
+ u8 minute_set; /* RTC + 0x02 */
+ u8 second_set; /* RTC + 0x03 */
+
+ u8 set_date; /* RTC + 0x04 */
+ u8 month_set; /* RTC + 0x05 */
+ u8 weekday_set; /* RTC + 0x06 */
+ u8 date_set; /* RTC + 0x07 */
+
+ u8 write_sw; /* RTC + 0x08 */
+ u8 sw_set; /* RTC + 0x09 */
+ u16 year_set; /* RTC + 0x0a */
+
+ u8 alm_enable; /* RTC + 0x0c */
+ u8 alm_hour_set; /* RTC + 0x0d */
+ u8 alm_min_set; /* RTC + 0x0e */
+ u8 int_enable; /* RTC + 0x0f */
+
+ u8 reserved1;
+ u8 hour; /* RTC + 0x11 */
+ u8 minute; /* RTC + 0x12 */
+ u8 second; /* RTC + 0x13 */
+
+ u8 month; /* RTC + 0x14 */
+ u8 wday_mday; /* RTC + 0x15 */
+ u16 year; /* RTC + 0x16 */
+
+ u8 int_alm; /* RTC + 0x18 */
+ u8 int_sw; /* RTC + 0x19 */
+ u8 alm_status; /* RTC + 0x1a */
+ u8 sw_minute; /* RTC + 0x1b */
+
+ u8 bus_error_1; /* RTC + 0x1c */
+ u8 int_day; /* RTC + 0x1d */
+ u8 int_min; /* RTC + 0x1e */
+ u8 int_sec; /* RTC + 0x1f */
+
+ /*
+  * target_time:
+  * intended to be used for hibernation but hibernation
+  * does not work on silicon rev 1.5 so use it for non-volatile
+  * storage of offset between the actual_time register and linux
+  * time
+  */
+ u32 target_time; /* RTC + 0x20 */
+ /*
+  * actual_time:
+  *  readonly time since VBAT_RTC was last connected
+  */
+ u32 actual_time; /* RTC + 0x24 */
+ u32 keep_alive; /* RTC + 0x28 */
+};
+
+struct mpc5121_rtc_data {
+ unsigned irq;
+ unsigned irq_periodic;
+ struct mpc5121_rtc_regs __iomem *regs;
+ struct rtc_device *rtc;
+ struct rtc_wkalrm wkalarm;
+};
+
+/*
+ * Update second/minute/hour registers.
+ *
+ * This is just so alarm will work.
+ */
+static void mpc5121_rtc_update_smh(struct mpc5121_rtc_regs __iomem *regs,
+ struct rtc_time *tm)
+{
+ out_8(®s- >second_set, tm- >tm_sec);
+ out_8(®s- >minute_set, tm- >tm_min);
+ out_8(®s- >hour_set, tm- >tm_hour);
+
+ /* set time sequence */
+ out_8(®s- >set_time, 0x1);
+ out_8(®s- >set_time, 0x3);
+ out_8(®s- >set_time, 0x1);
+ out_8(®s- >set_time, 0x0);
+}
+
+static int mpc5121_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+ unsigned long now;
+
+ /*
+  * linux time is actual_time plus the offset saved in target_time
+  */
+ now = in_be32(®s- >actual_time) + in_be32(®s- >target_time);
+
+ rtc_time_to_tm(now, tm);
+
+ /*
+  * update second minute hour registers
+  * so alarms will work
+  */
+ mpc5121_rtc_update_smh(regs, tm);
+
+ return 0;
+}
+
+static int mpc5121_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+ int ret;
+ unsigned long now;
+
+
+ /*
+  * The actual_time register is read only so we write the offset
+  * between it and linux time to the target_time register.
+  */
+ ret = rtc_tm_to_time(tm, &now);
+ if (ret == 0)
+ out_be32(®s- >target_time, now - in_be32(®s- >actual_time));
+
+ /*
+  * update second minute hour registers
+  * so alarms will work
+  */
+ mpc5121_rtc_update_smh(regs, tm);
+
+ return 0;
+}
+
+static int mpc5121_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ *alarm = rtc- >wkalarm;
+
+ alarm- >pending = in_8(®s- >alm_status);
+
+ return 0;
+}
+
+static int mpc5121_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ /*
+  * the alarm has no seconds so deal with it
+  */
+ if (alarm- >time.tm_sec) {
+ alarm- >time.tm_sec = 0;
+ alarm- >time.tm_min++;
+ if (alarm- >time.tm_min  >= 60) {
+ alarm- >time.tm_min = 0;
+ alarm- >time.tm_hour++;
+ if (alarm- >time.tm_hour  >= 24)
+ alarm- >time.tm_hour = 0;
+ }
+ }
+
+ alarm- >time.tm_mday = -1;
+ alarm- >time.tm_mon = -1;
+ alarm- >time.tm_year = -1;
+
+ out_8(®s- >alm_min_set, alarm- >time.tm_min);
+ out_8(®s- >alm_hour_set, alarm- >time.tm_hour);
+
+ out_8(®s- >alm_enable, alarm- >enabled);
+
+ rtc- >wkalarm = *alarm;
+ return 0;
+}
+
+static irqreturn_t mpc5121_rtc_handler(int irq, void *dev)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata((struct device *)dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ if (in_8(®s- >int_alm)) {
+ /* acknowledge and clear status */
+ out_8(®s- >int_alm, 1);
+ out_8(®s- >alm_status, 1);
+
+ rtc_update_irq(rtc- >rtc, 1, RTC_IRQF | RTC_AF);
+ return IRQ_HANDLED;
+ }
+
+ return IRQ_NONE;
+}
+
+static irqreturn_t mpc5121_rtc_handler_upd(int irq, void *dev)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata((struct device *)dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ if (in_8(®s- >int_sec) && (in_8(®s- >int_enable) & 0x1)) {
+ /* acknowledge */
+ out_8(®s- >int_sec, 1);
+
+ rtc_update_irq(rtc- >rtc, 1, RTC_IRQF | RTC_UF);
+ return IRQ_HANDLED;
+ }
+
+ return IRQ_NONE;
+}
+
+static int mpc5121_rtc_ioctl(struct device *dev, unsigned int cmd,
+ unsigned long arg)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ switch (cmd) {
+ /* alarm interrupt */
+ case RTC_AIE_ON:
+ out_8(®s- >alm_enable, 1);
+ rtc- >wkalarm.enabled = 1;
+ break;
+ case RTC_AIE_OFF:
+ out_8(®s- >alm_enable, 0);
+ rtc- >wkalarm.enabled = 0;
+ break;
+
+ /* update interrupt */
+ case RTC_UIE_ON:
+ out_8(®s- >int_enable,
+ (in_8(®s- >int_enable) & ~0x8) | 0x1);
+ break;
+ case RTC_UIE_OFF:
+ out_8(®s- >int_enable, in_8(®s- >int_enable) & ~0x1);
+ break;
+
+ /* no periodic interrupts */
+ case RTC_IRQP_READ:
+ case RTC_IRQP_SET:
+ return -ENOTTY;
+
+ default:
+ return -ENOIOCTLCMD;
+ }
+ return 0;
+}
+
+static const struct rtc_class_ops mpc5121_rtc_ops = {
+ .read_time = mpc5121_rtc_read_time,
+ .set_time = mpc5121_rtc_set_time,
+ .read_alarm = mpc5121_rtc_read_alarm,
+ .set_alarm = mpc5121_rtc_set_alarm,
+ .ioctl = mpc5121_rtc_ioctl,
+};
+
+static int __devinit mpc5121_rtc_probe(struct of_device *op,
+ const struct of_device_id *match)
+{
+ struct mpc5121_rtc_data *rtc;
+ int err = 0;
+ u32 ka;
+
+ rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+ if (!rtc) {
+ err = -ENOMEM;
+ goto out;
+ }
+
+ rtc- >regs = of_iomap(op- >node, 0);
+
+ if (!rtc- >regs) {
+ printk(KERN_ERR "%s: couldn't map io space\n", __func__);
+ err = -ENOSYS;
+ goto out_free;
+ }
+
+ device_init_wakeup(&op- >dev, 1);
+
+ rtc- >rtc = rtc_device_register("mpc5121-rtc", &op- >dev,
+ &mpc5121_rtc_ops, THIS_MODULE);
+ if (IS_ERR(rtc- >rtc)) {
+ err = PTR_ERR(rtc- >rtc);
+ goto out_unmap;
+ }
+
+ dev_set_drvdata(&op- >dev, rtc);
+
+ rtc- >irq = irq_of_parse_and_map(op- >node, 1);
+ err = request_irq(rtc- >irq, mpc5121_rtc_handler, IRQF_DISABLED,
+ "mpc5121-rtc", &op- >dev);
+ if (err) {
+ printk(KERN_ERR "%s: could not request irq: %i\n",
+ __func__, rtc- >irq);
+ goto out_dispose;
+ }
+
+ rtc- >irq_periodic = irq_of_parse_and_map(op- >node, 0);
+ err = request_irq(rtc- >irq_periodic, mpc5121_rtc_handler_upd,
+  IRQF_DISABLED, "mpc5121-rtc_upd", &op- >dev);
+ if (err) {
+ printk(KERN_ERR "%s: could not request irq: %i\n",
+ __func__, rtc- >irq_periodic);
+ goto out_dispose2;
+ }
+
+ ka = in_be32(&rtc- >regs- >keep_alive);
+ if (ka & 0x02) {
+ printk(KERN_WARNING
+ "mpc5121-rtc: Battery or oscillator failure!\n");
+ out_be32(&rtc- >regs- >keep_alive, ka);
+ }
+
+ goto out;
+
+out_dispose2:
+ irq_dispose_mapping(rtc- >irq_periodic);
+ free_irq(rtc- >irq, &op- >dev);
+out_dispose:
+ irq_dispose_mapping(rtc- >irq);
+out_unmap:
+ iounmap(rtc- >regs);
+out_free:
+ kfree(rtc);
+out:
+ return err;
+}
+
+static int __devexit mpc5121_rtc_remove(struct of_device *op)
+{
+ struct mpc5121_rtc_data *rtc = dev_get_drvdata(&op- >dev);
+ struct mpc5121_rtc_regs __iomem *regs = rtc- >regs;
+
+ /* disable interrupt, so there are no nasty surprises */
+ out_8(®s- >alm_enable, 0);
+ out_8(®s- >int_enable, in_8(®s- >int_enable) & ~0x1);
+
+ rtc_device_unregister(rtc- >rtc);
+ iounmap(rtc- >regs);
+ free_irq(rtc- >irq, &op- >dev);
+ free_irq(rtc- >irq_periodic, &op- >dev);
+ irq_dispose_mapping(rtc- >irq);
+ irq_dispose_mapping(rtc- >irq_periodic);
+ dev_set_drvdata(&op- >dev, NULL);
+ kfree(rtc);
+
+ return 0;
+}
+
+static struct of_device_id mpc5121_rtc_match[] = {
+ { .compatible = "fsl,mpc5121-rtc", },
+ {},
+};
+
+static struct of_platform_driver mpc5121_rtc_driver = {
+ .owner = THIS_MODULE,
+ .name = "mpc5121-rtc",
+ .match_table = mpc5121_rtc_match,
+ .probe = mpc5121_rtc_probe,
+ .remove = mpc5121_rtc_remove,
+};
+
+static int __init mpc5121_rtc_init(void)
+{
+ return of_register_platform_driver(&mpc5121_rtc_driver);
+}
+
+static void __exit mpc5121_rtc_exit(void)
+{
+ of_unregister_platform_driver(&mpc5121_rtc_driver);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Rigby  <jrigby@freescale.com >");
+
+module_init(mpc5121_rtc_init);
+module_exit(mpc5121_rtc_exit);
-- 
1.6.0.6



------------------------------

Message: 4
Date: Wed,  6 May 2009 22:15:18 +0200
From: Wolfgang Denk  <wd@denx.de >
Subject: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.
To: linuxppc-dev@ozlabs.org
Cc: Piotr Ziecik  <kosmo@semihalf.com >, Wolfgang Denk  <wd@denx.de >
Message-ID:  <1241640919-4650-12-git-send-email-wd@denx.de >

From: Piotr Ziecik  <kosmo@semihalf.com >

This patch adds initial version of MPC512x DMA driver.
Only memory to memory transfers are currenly supported.

Signed-off-by: Piotr Ziecik  <kosmo@semihalf.com >
Signed-off-by: Wolfgang Denk  <wd@denx.de >
Cc: Grant Likely  <grant.likely@secretlab.ca >
Cc: John Rigby  <jcrigby@gmail.com >
---
 arch/powerpc/boot/dts/mpc5121ads.dts         |    2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c |    1 +
 drivers/dma/Kconfig                          |    7 +
 drivers/dma/Makefile                         |    1 +
 drivers/dma/mpc512x_dma.c                    |  642 ++++++++++++++++++++++++++
 drivers/dma/mpc512x_dma.h                    |  192 ++++++++
 6 files changed, 844 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dma/mpc512x_dma.c
 create mode 100644 drivers/dma/mpc512x_dma.h

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c2d9de9..e7f0e09 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -373,7 +373,7 @@
  };

  dma@14000 {
- compatible = "fsl,mpc5121-dma2";
+ compatible = "fsl,mpc512x-dma";
  reg =  <0x14000 0x1800 >;
  interrupts =  <65 0x8 >;
  interrupt-parent =  < &ipic  >;
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index b776e45..135fd6b 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -95,6 +95,7 @@ void __init mpc512x_init_i2c(void)
 static struct of_device_id __initdata of_bus_ids[] = {
  { .compatible = "fsl,mpc5121-immr", },
  { .compatible = "fsl,mpc5121-localbus", },
+ { .compatible = "fsl,mpc5121-dma", },
  { .compatible = "fsl,mpc5121-nfc", },
  {},
 };
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3b3c01b..e734a7a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -55,6 +55,13 @@ config FSL_DMA
    The Elo is the DMA controller on some 82xx and 83xx parts, and the
    Elo Plus is the DMA controller on 85xx and 86xx parts.

+config MPC512X_DMA
+ tristate "Freescale MPC512x built-in DMA engine support"
+ depends on PPC_MPC512x
+ select DMA_ENGINE
+ ---help---
+   Enable support for the Freescale MPC512x built-in DMA engine.
+
 config MV_XOR
  bool "Marvell XOR engine support"
  depends on PLAT_ORION
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 2e5dc96..f02806c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
 ioatdma-objs := ioat.o ioat_dma.o ioat_dca.o
 obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
+obj-$(CONFIG_MPC512X_DMA) += mpc512x_dma.o
 obj-$(CONFIG_MV_XOR) += mv_xor.o
 obj-$(CONFIG_DW_DMAC) += dw_dmac.o
 obj-$(CONFIG_MX3_IPU) += ipu/
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
new file mode 100644
index 0000000..1aac897
--- /dev/null
+++ b/drivers/dma/mpc512x_dma.c
@@ -0,0 +1,642 @@
+/*
+ * Copyright (C) Semihalf 2009
+ *
+ * Written by: Piotr Ziecik  <kosmo@semihalf.com >
+ *
+ * Approved as OSADL project by a majority of OSADL members and funded
+ * by OSADL membership fees in 2009;  for details see www.osadl.org.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+/*
+ * This is initial version of MPC5121 DMA driver. Only memory to memory
+ * transfers are supported (tested using dmatest module).
+ */
+
+#include  <linux/module.h >
+#include  <linux/dmaengine.h >
+#include  <linux/dma-mapping.h >
+#include  <linux/interrupt.h >
+#include  <linux/io.h >
+#include  <linux/of_device.h >
+#include  <linux/of_platform.h >
+
+#include  <linux/random.h >
+
+#include "mpc512x_dma.h"
+
+#define DRV_NAME "mpc512x_dma"
+
+/* Convert struct dma_chan to struct mpc_dma_chan */
+static inline struct mpc_dma_chan *dma_chan_to_mpc_dma_chan(struct dma_chan *c)
+{
+ return container_of(c, struct mpc_dma_chan, chan);
+}
+
+/* Convert struct dma_chan to struct mpc_dma */
+static inline struct mpc_dma *dma_chan_to_mpc_dma(struct dma_chan *c)
+{
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(c);
+ return container_of(mchan, struct mpc_dma, channels[c- >chan_id]);
+}
+
+/*
+ * Execute all queued DMA descriptors.
+ *
+ * Following requirements must be met while calling mpc_dma_execute():
+ *  a) mchan- >lock is acquired,
+ *  b) mchan- >active list is empty,
+ *  c) mchan- >queued list contains at least one entry.
+ */
+static void mpc_dma_execute(struct mpc_dma_chan *mchan)
+{
+ struct mpc_dma *mdma = dma_chan_to_mpc_dma(&mchan- >chan);
+ struct mpc_dma_desc *first = NULL;
+ struct mpc_dma_desc *prev = NULL;
+ struct mpc_dma_desc *mdesc;
+ int cid = mchan- >chan.chan_id;
+
+ /* Move all queued descriptors to active list */
+ list_splice_tail_init(&mchan- >queued, &mchan- >active);
+
+ /* Chain descriptors into one transaction */
+ list_for_each_entry(mdesc, &mchan- >active, node) {
+ if (!first)
+ first = mdesc;
+
+ if (!prev) {
+ prev = mdesc;
+ continue;
+ }
+
+ prev- >tcd- >dlast_sga = mdesc- >tcd_paddr;
+ prev- >tcd- >e_sg = 1;
+ mdesc- >tcd- >start = 1;
+
+ prev = mdesc;
+ }
+
+ prev- >tcd- >start = 0;
+ prev- >tcd- >int_maj = 1;
+
+ /* Send first descriptor in chain into hardware */
+ memcpy_toio(&mdma- >tcd[cid], first- >tcd, sizeof(struct mpc_dma_tcd));
+ out_8(&mdma- >regs- >dmassrt, cid);
+}
+
+/* Handle interrupt on one half of DMA controller (32 channels) */
+static void mpc_dma_irq_process(struct mpc_dma *mdma, u32 is, u32 es, int off)
+{
+ struct mpc_dma_chan *mchan;
+ struct mpc_dma_desc *mdesc;
+ u32 status = is | es;
+ int ch;
+
+ while ((ch = fls(status) - 1)  >= 0) {
+ status &= ~(1  < < ch);
+ mchan = &mdma- >channels[ch + off];
+
+ spin_lock(&mchan- >lock);
+
+ /* Check error status */
+ if (es & (1  < < ch))
+ list_for_each_entry(mdesc, &mchan- >active, node)
+ mdesc- >error = -EIO;
+
+ /* Execute queued descriptors */
+ list_splice_tail_init(&mchan- >active, &mchan- >completed);
+ if (!list_empty(&mchan- >queued))
+ mpc_dma_execute(mchan);
+
+ spin_unlock(&mchan- >lock);
+ }
+}
+
+/* Interrupt handler */
+static irqreturn_t mpc_dma_irq(int irq, void *data)
+{
+ struct mpc_dma *mdma = data;
+ uint es;
+
+ /* Save error status register */
+ es = in_be32(&mdma- >regs- >dmaes);
+ spin_lock(&mdma- >error_status_lock);
+ if ((es & MPC_DMA_DMAES_VLD) && mdma- >error_status == 0)
+ mdma- >error_status = es;
+ spin_unlock(&mdma- >error_status_lock);
+
+ /* Handle interrupt on each channel */
+ mpc_dma_irq_process(mdma, in_be32(&mdma- >regs- >dmainth),
+ in_be32(&mdma- >regs- >dmaerrh), 32);
+ mpc_dma_irq_process(mdma, in_be32(&mdma- >regs- >dmaintl),
+ in_be32(&mdma- >regs- >dmaerrl), 0);
+
+ /* Ack interrupt on all channels */
+ out_be32(&mdma- >regs- >dmainth, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaintl, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaerrh, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaerrl, 0xFFFFFFFF);
+
+ /* Schedule tasklet */
+ tasklet_schedule(&mdma- >tasklet);
+
+ return IRQ_HANDLED;
+}
+
+/* DMA Tasklet */
+static void mpc_dma_tasklet(unsigned long data)
+{
+ struct mpc_dma *mdma = (void *)data;
+ dma_cookie_t last_cookie = 0;
+ struct mpc_dma_chan *mchan;
+ struct mpc_dma_desc *mdesc;
+ struct dma_async_tx_descriptor *desc;
+ unsigned long flags;
+ LIST_HEAD(list);
+ uint es;
+ int i;
+
+ spin_lock_irqsave(&mdma- >error_status_lock, flags);
+ es = mdma- >error_status;
+ mdma- >error_status = 0;
+ spin_unlock_irqrestore(&mdma- >error_status_lock, flags);
+
+ /* Print nice error report */
+ if (es) {
+ dev_err(mdma- >dma.dev,
+ "Hardware reported following error(s) on channel %u:\n",
+       MPC_DMA_DMAES_ERRCHN(es));
+
+ if (es & MPC_DMA_DMAES_GPE)
+ dev_err(mdma- >dma.dev, "- Group Priority Error\n");
+ if (es & MPC_DMA_DMAES_CPE)
+ dev_err(mdma- >dma.dev, "- Channel Priority Error\n");
+ if (es & MPC_DMA_DMAES_SAE)
+ dev_err(mdma- >dma.dev, "- Source Address Error\n");
+ if (es & MPC_DMA_DMAES_SOE)
+ dev_err(mdma- >dma.dev, "- Source Offset"
+ " Configuration Error\n");
+ if (es & MPC_DMA_DMAES_DAE)
+ dev_err(mdma- >dma.dev, "- Destination Address"
+ " Error\n");
+ if (es & MPC_DMA_DMAES_DOE)
+ dev_err(mdma- >dma.dev, "- Destination Offset"
+ " Configuration Error\n");
+ if (es & MPC_DMA_DMAES_NCE)
+ dev_err(mdma- >dma.dev, "- NBytes/Citter"
+ " Configuration Error\n");
+ if (es & MPC_DMA_DMAES_SGE)
+ dev_err(mdma- >dma.dev, "- Scatter/Gather"
+ " Configuration Error\n");
+ if (es & MPC_DMA_DMAES_SBE)
+ dev_err(mdma- >dma.dev, "- Source Bus Error\n");
+ if (es & MPC_DMA_DMAES_DBE)
+ dev_err(mdma- >dma.dev, "- Destination Bus Error\n");
+ }
+
+ for (i = 0; i  < mdma- >dma.chancnt; i++) {
+ mchan = &mdma- >channels[i];
+
+ /* Get all completed descriptors */
+ spin_lock_irqsave(&mchan- >lock, flags);
+ if (!list_empty(&mchan- >completed))
+ list_splice_tail_init(&mchan- >completed, &list);
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+
+ if (list_empty(&list))
+ continue;
+
+ /* Execute callbacks and run dependencies */
+ list_for_each_entry(mdesc, &list, node) {
+ desc = &mdesc- >desc;
+
+ if (desc- >callback)
+ desc- >callback(desc- >callback_param);
+
+ last_cookie = desc- >cookie;
+ dma_run_dependencies(desc);
+ }
+
+ /* Free descriptors */
+ spin_lock_irqsave(&mchan- >lock, flags);
+ list_splice_tail_init(&list, &mchan- >free);
+ mchan- >completed_cookie = last_cookie;
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+ }
+}
+
+/* Submit descriptor to hardware */
+static dma_cookie_t mpc_dma_tx_submit(struct dma_async_tx_descriptor *txd)
+{
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(txd- >chan);
+ struct mpc_dma_desc *mdesc;
+ unsigned long flags;
+ dma_cookie_t cookie;
+
+ mdesc = container_of(txd, struct mpc_dma_desc, desc);
+
+ spin_lock_irqsave(&mchan- >lock, flags);
+
+ /* Move descriptor to queue */
+ list_move_tail(&mdesc- >node, &mchan- >queued);
+
+ /* If channel is idle, execute all queued descriptors */
+ if (list_empty(&mchan- >active))
+ mpc_dma_execute(mchan);
+
+ /* Update cookie */
+ cookie = mchan- >chan.cookie + 1;
+ if (cookie  <= 0)
+ cookie = 1;
+
+ mchan- >chan.cookie = cookie;
+ mdesc- >desc.cookie = cookie;
+
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+
+ return cookie;
+}
+
+/* Alloc channel resources */
+static int mpc_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+ struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+ struct mpc_dma_desc *mdesc;
+ struct mpc_dma_tcd *tcd;
+ dma_addr_t tcd_paddr;
+ unsigned long flags;
+ LIST_HEAD(descs);
+ int i;
+
+ /* Alloc DMA memory for Transfer Control Descriptors */
+ tcd = dma_alloc_coherent(mdma- >dma.dev,
+ MPC_DMA_DESCRIPTORS * sizeof(struct mpc_dma_tcd),
+ &tcd_paddr, GFP_KERNEL);
+ if (!tcd)
+ return -ENOMEM;
+
+ /* Alloc descriptors for this channel */
+ for (i = 0; i  < MPC_DMA_DESCRIPTORS; i++) {
+ mdesc = kzalloc(sizeof(struct mpc_dma_desc), GFP_KERNEL);
+ if (!mdesc) {
+ dev_notice(mdma- >dma.dev, "Memory allocation error. "
+ "Allocated only %u descriptors\n", i);
+ break;
+ }
+
+ dma_async_tx_descriptor_init(&mdesc- >desc, chan);
+ mdesc- >desc.flags = DMA_CTRL_ACK;
+ mdesc- >desc.tx_submit = mpc_dma_tx_submit;
+
+ mdesc- >tcd = &tcd[i];
+ mdesc- >tcd_paddr = tcd_paddr + (i * sizeof(struct mpc_dma_tcd));
+
+ list_add_tail(&mdesc- >node, &descs);
+ }
+
+ /* Return error only if no descriptors were allocated */
+ if (i == 0) {
+ dma_free_coherent(mdma- >dma.dev,
+ MPC_DMA_DESCRIPTORS * sizeof(struct mpc_dma_tcd),
+ tcd, tcd_paddr);
+ return -ENOMEM;
+ }
+
+ spin_lock_irqsave(&mchan- >lock, flags);
+ mchan- >tcd = tcd;
+ mchan- >tcd_paddr = tcd_paddr;
+ list_splice_tail_init(&descs, &mchan- >free);
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+
+ /* Enable Error Interrupt */
+ out_8(&mdma- >regs- >dmaseei, chan- >chan_id);
+
+ return 0;
+}
+
+/* Free channel resources */
+static void mpc_dma_free_chan_resources(struct dma_chan *chan)
+{
+ struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+ struct mpc_dma_desc *mdesc, *tmp;
+ struct mpc_dma_tcd *tcd;
+ dma_addr_t tcd_paddr;
+ unsigned long flags;
+ LIST_HEAD(descs);
+
+ spin_lock_irqsave(&mchan- >lock, flags);
+
+ /* Channel must be idle */
+ BUG_ON(!list_empty(&mchan- >prepared));
+ BUG_ON(!list_empty(&mchan- >queued));
+ BUG_ON(!list_empty(&mchan- >active));
+ BUG_ON(!list_empty(&mchan- >completed));
+
+ /* Move data */
+ list_splice_tail_init(&mchan- >free, &descs);
+ tcd = mchan- >tcd;
+ tcd_paddr = mchan- >tcd_paddr;
+
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+
+ /* Free DMA memory used by descriptors */
+ dma_free_coherent(mdma- >dma.dev,
+ MPC_DMA_DESCRIPTORS * sizeof(struct mpc_dma_tcd),
+ tcd, tcd_paddr);
+
+ /* Free descriptors */
+ list_for_each_entry_safe(mdesc, tmp, &descs, node)
+ kfree(mdesc);
+
+ /* Disable Error Interrupt */
+ out_8(&mdma- >regs- >dmaceei, chan- >chan_id);
+}
+
+/* Send all pending descriptor to hardware */
+static void mpc_dma_issue_pending(struct dma_chan *chan)
+{
+ /*
+  * We are posting descriptors to the hardware as soon as
+  * they are ready, so this function does nothing.
+  */
+}
+
+/* Check request completion status */
+static enum dma_status
+mpc_dma_is_tx_complete(struct dma_chan *chan, dma_cookie_t cookie,
+ dma_cookie_t *done, dma_cookie_t *used)
+{
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+ unsigned long flags;
+ dma_cookie_t last_used;
+ dma_cookie_t last_complete;
+
+ spin_lock_irqsave(&mchan- >lock, flags);
+ last_used = mchan- >chan.cookie;
+ last_complete = mchan- >completed_cookie;
+ spin_unlock_irqrestore(&mchan- >lock, flags);
+
+ if (done)
+ *done = last_complete;
+
+ if (used)
+ *used = last_used;
+
+ return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+/* Prepare descriptor for memory to memory copy */
+static struct dma_async_tx_descriptor *
+mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
+ size_t len, unsigned long flags)
+{
+ struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+ struct mpc_dma_desc *mdesc = NULL;
+ struct mpc_dma_tcd *tcd;
+ unsigned long iflags;
+
+ /* Get free descriptor */
+ spin_lock_irqsave(&mchan- >lock, iflags);
+ if (!list_empty(&mchan- >free)) {
+ mdesc = list_first_entry(&mchan- >free, struct mpc_dma_desc,
+ node);
+ list_del(&mdesc- >node);
+ }
+ spin_unlock_irqrestore(&mchan- >lock, iflags);
+
+ if (!mdesc)
+ return NULL;
+
+ mdesc- >error = 0;
+ tcd = mdesc- >tcd;
+
+ /* Prepare Transfer Control Descriptor for this transaction */
+ memset(tcd, 0, sizeof(struct mpc_dma_tcd));
+
+ if (IS_ALIGNED(src | dst | len, 32)) {
+ tcd- >ssize = MPC_DMA_TSIZE_32;
+ tcd- >dsize = MPC_DMA_TSIZE_32;
+ tcd- >soff = 32;
+ tcd- >doff = 32;
+ } else if (IS_ALIGNED(src | dst | len, 16)) {
+ tcd- >ssize = MPC_DMA_TSIZE_16;
+ tcd- >dsize = MPC_DMA_TSIZE_16;
+ tcd- >soff = 16;
+ tcd- >doff = 16;
+ } else if (IS_ALIGNED(src | dst | len, 4)) {
+ tcd- >ssize = MPC_DMA_TSIZE_4;
+ tcd- >dsize = MPC_DMA_TSIZE_4;
+ tcd- >soff = 4;
+ tcd- >doff = 4;
+ } else if (IS_ALIGNED(src | dst | len, 2)) {
+ tcd- >ssize = MPC_DMA_TSIZE_2;
+ tcd- >dsize = MPC_DMA_TSIZE_2;
+ tcd- >soff = 2;
+ tcd- >doff = 2;
+ } else {
+ tcd- >ssize = MPC_DMA_TSIZE_1;
+ tcd- >dsize = MPC_DMA_TSIZE_1;
+ tcd- >soff = 1;
+ tcd- >doff = 1;
+ }
+
+ tcd- >saddr = src;
+ tcd- >daddr = dst;
+ tcd- >nbytes = len;
+ tcd- >biter = 1;
+ tcd- >citer = 1;
+
+ /* Place descriptor in prepared list */
+ spin_lock_irqsave(&mchan- >lock, iflags);
+ list_add_tail(&mdesc- >node, &mchan- >prepared);
+ spin_unlock_irqrestore(&mchan- >lock, iflags);
+
+ return &mdesc- >desc;
+}
+
+static int __init mpc_dma_probe(struct of_device *op,
+ const struct of_device_id *match)
+{
+ struct device_node *dn = op- >node;
+ struct device *dev = &op- >dev;
+ struct dma_device *dma;
+ struct mpc_dma *mdma;
+ struct mpc_dma_chan *mchan;
+ struct resource res;
+ ulong regs_start, regs_size;
+ int retval, i;
+
+ mdma = devm_kzalloc(dev, sizeof(struct mpc_dma), GFP_KERNEL);
+ if (!mdma) {
+ dev_err(dev, "Memory exhausted!\n");
+ return -ENOMEM;
+ }
+
+ mdma- >irq = irq_of_parse_and_map(dn, 0);
+ if (mdma- >irq == NO_IRQ) {
+ dev_err(dev, "Error mapping IRQ!\n");
+ return -EINVAL;
+ }
+
+ retval = of_address_to_resource(dn, 0, &res);
+ if (retval) {
+ dev_err(dev, "Error parsing memory region!\n");
+ return retval;
+ }
+
+ regs_start = res.start;
+ regs_size = res.end - res.start + 1;
+
+ if (!devm_request_mem_region(dev, regs_start, regs_size, DRV_NAME)) {
+ dev_err(dev, "Error requesting memory region!\n");
+ return -EBUSY;
+ }
+
+ mdma- >regs = devm_ioremap(dev, regs_start, regs_size);
+ if (!mdma- >regs) {
+ dev_err(dev, "Error mapping memory region!\n");
+ return -ENOMEM;
+ }
+
+ mdma- >tcd = (struct mpc_dma_tcd *)((u8 *)(mdma- >regs)
+ + MPC_DMA_TCD_OFFSET);
+
+ retval = devm_request_irq(dev, mdma- >irq, &mpc_dma_irq, 0, DRV_NAME,
+ mdma);
+ if (retval) {
+ dev_err(dev, "Error requesting IRQ!\n");
+ return -EINVAL;
+ }
+
+ spin_lock_init(&mdma- >error_status_lock);
+
+ dma = &mdma- >dma;
+ dma- >dev = dev;
+ dma- >chancnt = MPC_DMA_CHANNELS;
+ dma- >device_alloc_chan_resources = mpc_dma_alloc_chan_resources;
+ dma- >device_free_chan_resources = mpc_dma_free_chan_resources;
+ dma- >device_issue_pending = mpc_dma_issue_pending;
+ dma- >device_is_tx_complete = mpc_dma_is_tx_complete;
+ dma- >device_prep_dma_memcpy = mpc_dma_prep_memcpy;
+
+ INIT_LIST_HEAD(&dma- >channels);
+ dma_cap_set(DMA_MEMCPY, dma- >cap_mask);
+
+ for (i = 0; i  < dma- >chancnt; i++) {
+ mchan = &mdma- >channels[i];
+
+ mchan- >chan.device = dma;
+ mchan- >chan.chan_id = i;
+ mchan- >chan.cookie = 1;
+ mchan- >completed_cookie = mchan- >chan.cookie;
+
+ INIT_LIST_HEAD(&mchan- >free);
+ INIT_LIST_HEAD(&mchan- >prepared);
+ INIT_LIST_HEAD(&mchan- >queued);
+ INIT_LIST_HEAD(&mchan- >active);
+ INIT_LIST_HEAD(&mchan- >completed);
+
+ spin_lock_init(&mchan- >lock);
+ list_add_tail(&mchan- >chan.device_node, &dma- >channels);
+ }
+
+ tasklet_init(&mdma- >tasklet, mpc_dma_tasklet, (unsigned long)mdma);
+
+ /*
+  * Configure DMA Engine:
+  * - Dynamic clock,
+  * - Round-robin group arbitration,
+  * - Round-robin channel arbitration.
+  */
+ out_be32(&mdma- >regs- >dmacr, MPC_DMA_DMACR_EDCG |
+ MPC_DMA_DMACR_ERGA | MPC_DMA_DMACR_ERCA);
+
+ /* Disable hardware DMA requests */
+ out_be32(&mdma- >regs- >dmaerqh, 0);
+ out_be32(&mdma- >regs- >dmaerql, 0);
+
+ /* Disable error interrupts */
+ out_be32(&mdma- >regs- >dmaeeih, 0);
+ out_be32(&mdma- >regs- >dmaeeil, 0);
+
+ /* Clear interrupts status */
+ out_be32(&mdma- >regs- >dmainth, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaintl, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaerrh, 0xFFFFFFFF);
+ out_be32(&mdma- >regs- >dmaerrl, 0xFFFFFFFF);
+
+ /* Route interrupts to IPIC */
+ out_be32(&mdma- >regs- >dmaihsa, 0);
+ out_be32(&mdma- >regs- >dmailsa, 0);
+
+ /* Register DMA engine */
+ dev_set_drvdata(dev, mdma);
+ retval = dma_async_device_register(dma);
+ if (retval)
+ devm_free_irq(dev, mdma- >irq, mdma);
+
+ return retval;
+}
+
+static void __exit mpc_dma_remove(struct of_device *op)
+{
+ struct device *dev = &op- >dev;
+ struct mpc_dma *mdma = dev_get_drvdata(dev);
+
+ devm_free_irq(dev, mdma- >irq, mdma);
+}
+
+static struct of_device_id mpc_dma_match[] = {
+ { .compatible = "fsl,mpc512x-dma", },
+ {},
+};
+
+static struct of_platform_driver mpc_dma_driver = {
+ .name = DRV_NAME,
+ .owner = THIS_MODULE,
+ .match_table = mpc_dma_match,
+ .probe = mpc_dma_probe,
+ .remove = __exit_p(mpc_dma_remove),
+ .suspend = NULL,
+ .resume = NULL,
+ .driver = {
+ .name = DRV_NAME,
+ .owner = THIS_MODULE,
+ },
+};
+
+static int __init mpc_dma_init(void)
+{
+ return of_register_platform_driver(&mpc_dma_driver);
+}
+
+static void __exit mpc_dma_exit(void)
+{
+ of_unregister_platform_driver(&mpc_dma_driver);
+}
+
+module_init(mpc_dma_init);
+module_exit(mpc_dma_exit);
+
+/* MODULE API */
+MODULE_VERSION("0.5");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Piotr Ziecik  <kosmo@semihalf.com >");
diff --git a/drivers/dma/mpc512x_dma.h b/drivers/dma/mpc512x_dma.h
new file mode 100644
index 0000000..867415b
--- /dev/null
+++ b/drivers/dma/mpc512x_dma.h
@@ -0,0 +1,192 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
+ * Copyright (C) Semihalf, 2009.
+ *
+ * Written by Piotr Ziecik  <kosmo@semihalf.com >. Hardware description
+ * (defines, structures and comments) was taken from MPC5121 DMA driver
+ * written by Hongjun Chen  <hong-jun.chen@freescale.com >.
+ *
+ * Approved as OSADL project by a majority of OSADL members and funded
+ * by OSADL membership fees in 2009;  for details see www.osadl.org.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef _MPC512X_DMA_H_
+#define _MPC512X_DMA_H_
+
+#include  <linux/dmaengine.h >
+
+/* Number of DMA Transfer descriptors allocated per channel */
+#define MPC_DMA_DESCRIPTORS 64
+
+/* Macro definitions */
+#define MPC_DMA_CHANNELS 64
+#define MPC_DMA_TCD_OFFSET 0x1000
+
+/* Arbitration mode of group and channel */
+#define MPC_DMA_DMACR_EDCG (1  < < 31)
+#define MPC_DMA_DMACR_ERGA (1  < < 3)
+#define MPC_DMA_DMACR_ERCA (1  < < 2)
+
+/* Error codes */
+#define MPC_DMA_DMAES_VLD (1  < < 31)
+#define MPC_DMA_DMAES_GPE (1  < < 15)
+#define MPC_DMA_DMAES_CPE (1  < < 14)
+#define MPC_DMA_DMAES_ERRCHN(err) \
+ (((err)  > > 8) & 0x3f)
+#define MPC_DMA_DMAES_SAE (1  < < 7)
+#define MPC_DMA_DMAES_SOE (1  < < 6)
+#define MPC_DMA_DMAES_DAE (1  < < 5)
+#define MPC_DMA_DMAES_DOE (1  < < 4)
+#define MPC_DMA_DMAES_NCE (1  < < 3)
+#define MPC_DMA_DMAES_SGE (1  < < 2)
+#define MPC_DMA_DMAES_SBE (1  < < 1)
+#define MPC_DMA_DMAES_DBE (1  < < 0)
+
+#define MPC_DMA_TSIZE_1 0x00
+#define MPC_DMA_TSIZE_2 0x01
+#define MPC_DMA_TSIZE_4 0x02
+#define MPC_DMA_TSIZE_16 0x04
+#define MPC_DMA_TSIZE_32 0x05
+
+/* MPC5121 DMA engine registers */
+struct __attribute__ ((__packed__)) mpc_dma_regs {
+ /* 0x00 */
+ u32 dmacr; /* DMA control register */
+ u32 dmaes; /* DMA error status */
+ /* 0x08 */
+ u32 dmaerqh; /* DMA enable request high(channels 63~32) */
+ u32 dmaerql; /* DMA enable request low(channels 31~0) */
+ u32 dmaeeih; /* DMA enable error interrupt high(ch63~32) */
+ u32 dmaeeil; /* DMA enable error interrupt low(ch31~0) */
+ /* 0x18 */
+ u8 dmaserq; /* DMA set enable request */
+ u8 dmacerq; /* DMA clear enable request */
+ u8 dmaseei; /* DMA set enable error interrupt */
+ u8 dmaceei; /* DMA clear enable error interrupt */
+ /* 0x1c */
+ u8 dmacint; /* DMA clear interrupt request */
+ u8 dmacerr; /* DMA clear error */
+ u8 dmassrt; /* DMA set start bit */
+ u8 dmacdne; /* DMA clear DONE status bit */
+ /* 0x20 */
+ u32 dmainth; /* DMA interrupt request high(ch63~32) */
+ u32 dmaintl; /* DMA interrupt request low(ch31~0) */
+ u32 dmaerrh; /* DMA error high(ch63~32) */
+ u32 dmaerrl; /* DMA error low(ch31~0) */
+ /* 0x30 */
+ u32 dmahrsh; /* DMA hw request status high(ch63~32) */
+ u32 dmahrsl; /* DMA hardware request status low(ch31~0) */
+ u32 dmaihsa; /* DMA interrupt high select AXE(ch63~32) */
+ u32 dmailsa; /* DMA interrupt low select AXE(ch31~0) */
+ /* 0x40 ~ 0xff */
+ u32 reserve0[48]; /* Reserved */
+ /* 0x100 */
+ u8 dchpri[MPC_DMA_CHANNELS];
+ /* DMA channels(0~63) priority */
+};
+
+struct __attribute__ ((__packed__)) mpc_dma_tcd {
+ /* 0x00 */
+ u32 saddr; /* Source address */
+
+ u32 smod:5; /* Source address modulo */
+ u32 ssize:3; /* Source data transfer size */
+ u32 dmod:5; /* Destination address modulo */
+ u32 dsize:3; /* Destination data transfer size */
+ u32 soff:16; /* Signed source address offset */
+
+ /* 0x08 */
+ u32 nbytes; /* Inner "minor" byte count */
+ u32 slast; /* Last source address adjustment */
+ u32 daddr; /* Destination address */
+
+ /* 0x14 */
+ u32 citer_elink:1; /* Enable channel-to-channel linking on
+  * minor loop complete
+  */
+ u32 citer_linkch:6; /* Link channel for minor loop complete */
+ u32 citer:9; /* Current "major" iteration count */
+ u32 doff:16; /* Signed destination address offset */
+
+ /* 0x18 */
+ u32 dlast_sga; /* Last Destination address adjustment/scatter
+  * gather address
+  */
+
+ /* 0x1c */
+ u32 biter_elink:1; /* Enable channel-to-channel linking on major
+  * loop complete
+  */
+ u32 biter_linkch:6;
+ u32 biter:9; /* Beginning "major" iteration count */
+ u32 bwc:2; /* Bandwidth control */
+ u32 major_linkch:6; /* Link channel number */
+ u32 done:1; /* Channel done */
+ u32 active:1; /* Channel active */
+ u32 major_elink:1; /* Enable channel-to-channel linking on major
+  * loop complete
+  */
+ u32 e_sg:1; /* Enable scatter/gather processing */
+ u32 d_req:1; /* Disable request */
+ u32 int_half:1; /* Enable an interrupt when major counter is
+  * half complete
+  */
+ u32 int_maj:1; /* Enable an interrupt when major iteration
+  * count completes
+  */
+ u32 start:1; /* Channel start */
+};
+
+struct mpc_dma_desc {
+ struct dma_async_tx_descriptor desc;
+ struct mpc_dma_tcd *tcd;
+ dma_addr_t tcd_paddr;
+ int error;
+ struct list_head node;
+};
+
+struct mpc_dma_chan {
+ struct dma_chan chan;
+ struct list_head free;
+ struct list_head prepared;
+ struct list_head queued;
+ struct list_head active;
+ struct list_head completed;
+ struct mpc_dma_tcd *tcd;
+ dma_addr_t tcd_paddr;
+ dma_cookie_t completed_cookie;
+
+ /* Lock for this structure */
+ spinlock_t lock;
+};
+
+struct mpc_dma {
+ struct dma_device dma;
+ struct tasklet_struct tasklet;
+ struct mpc_dma_chan channels[MPC_DMA_CHANNELS];
+ struct mpc_dma_regs __iomem *regs;
+ struct mpc_dma_tcd __iomem *tcd;
+ int irq;
+ uint error_status;
+
+ /* Lock for error_status field in this structure */
+ spinlock_t error_status_lock;
+};
+
+#endif /* _MPC512X_DMA_H_ */
-- 
1.6.0.6



------------------------------

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

End of Linuxppc-dev Digest, Vol 57, Issue 42
********************************************
