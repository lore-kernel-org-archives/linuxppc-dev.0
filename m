Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9178B1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:18:05 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 15:47:59 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EE47DE0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:50:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8UAHJ3V36634788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:47:19 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8UAHohO027486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:47:50 +0530
Subject: [PATCH v2] rtc/tpo: Driver to support rtc and wakeup on PowerNV
 platform
To: devicetree@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com,
 a.zummo@towertech.it
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Tue, 30 Sep 2014 15:46:34 +0530
Message-ID: <20140930101448.9310.32342.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements the OPAL rtc driver that binds with the rtc
driver subsystem. The driver uses the platform device infrastructure
to probe the rtc device and register it to rtc class framework. The
'wakeup' is supported depending upon the property 'has-tpo' present
in the OF node. It provides a way to load the generic rtc driver in
in the absence of an OPAL driver.

The patch also moves the existing OPAL rtc get/set time interfaces to the
new driver and exposes the necessary OPAL calls using EXPORT_SYMBOL_GPL.

Test results:
-------------
Host:
[root@tul163p1 ~]# ls -l /sys/class/rtc/
total 0
lrwxrwxrwx 1 root root 0 Sep 30 04:58 rtc0 -> ../../devices/opal-rtc/rtc/rtc0
[root@tul163p1 ~]# cat /sys/devices/opal-rtc/rtc/rtc0/time
10:01:51
[root@tul163p1 ~]# cat /sys/devices/opal-rtc/rtc/rtc0/time
10:02:07
[root@tul163p1 ~]# echo `date '+%s' -d '+ 3 minutes'` > /sys/class/rtc/rtc0/wakealarm
[root@tul163p1 ~]# cat /sys/class/rtc/rtc0/wakealarm
1412071532
[root@tul163p1 ~]#

FSP:
$ smgr mfgState
standby
$ smgr mfgState
ipling
$

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
---

Changes in v2
=============
- Added Documentation/devicetree/bindings/rtc/rtc-opal.txt
- Explicitly turn off RTC_UIE mode by setting 'rtc->uie_unsupported'

Dependency
==========
This patch depends upon the below patch posted on 'linuxppc-dev@lists.ozlabs.org'
[PATCH 1/4] powerpc/powernv: Add OPAL check token call
Signed-off-by: Michael Neuling <mikey@neuling.org>

 Documentation/devicetree/bindings/rtc/rtc-opal.txt |   16 +
 arch/powerpc/include/asm/opal.h                    |    7 -
 arch/powerpc/kernel/time.c                         |    1 
 arch/powerpc/platforms/powernv/opal-async.c        |    3 
 arch/powerpc/platforms/powernv/opal-rtc.c          |   63 +----
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    2 
 arch/powerpc/platforms/powernv/opal.c              |    6 
 arch/powerpc/platforms/powernv/setup.c             |    2 
 drivers/rtc/Kconfig                                |   11 +
 drivers/rtc/Makefile                               |    1 
 drivers/rtc/rtc-opal.c                             |  261 ++++++++++++++++++++
 11 files changed, 325 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-opal.txt
 create mode 100644 drivers/rtc/rtc-opal.c

diff --git a/Documentation/devicetree/bindings/rtc/rtc-opal.txt b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
new file mode 100644
index 0000000..af87e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
@@ -0,0 +1,16 @@
+IBM OPAL real-time clock
+------------------------
+
+Required properties:
+- comapatible: Should be "ibm,opal-rtc"
+
+Optional properties:
+- has-tpo: Decides if the wakeup is supported or not.
+
+Example:
+	rtc {
+		compatible = "ibm,opal-rtc";
+		has-tpo;
+		phandle = <0x10000029>;
+		linux,phandle = <0x10000029>;
+	};
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 4593a93..215c560 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -152,6 +152,8 @@ struct opal_sg_list {
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
+#define OPAL_WRITE_TPO				103
+#define OPAL_READ_TPO				104
 
 #ifndef __ASSEMBLY__
 
@@ -790,6 +792,9 @@ int64_t opal_rtc_read(__be32 *year_month_day,
 		      __be64 *hour_minute_second_millisecond);
 int64_t opal_rtc_write(uint32_t year_month_day,
 		       uint64_t hour_minute_second_millisecond);
+int64_t opal_tpo_read(uint64_t token, __be32 *year_mon_day, __be32 *hour_min);
+int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
+		       uint32_t hour_min);
 int64_t opal_cec_power_down(uint64_t request);
 int64_t opal_cec_reboot(void);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
@@ -960,8 +965,6 @@ extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
 struct rtc_time;
-extern int opal_set_rtc_time(struct rtc_time *tm);
-extern void opal_get_rtc_time(struct rtc_time *tm);
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 extern void opal_flash_init(void);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 368ab37..149dc80 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -989,6 +989,7 @@ void GregorianDay(struct rtc_time * tm)
 
 	tm->tm_wday = day % 7;
 }
+EXPORT_SYMBOL_GPL(GregorianDay);
 
 void to_tm(int tim, struct rtc_time * tm)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index e462ab9..693b6cd 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -71,6 +71,7 @@ int opal_async_get_token_interruptible(void)
 
 	return token;
 }
+EXPORT_SYMBOL_GPL(opal_async_get_token_interruptible);
 
 int __opal_async_release_token(int token)
 {
@@ -102,6 +103,7 @@ int opal_async_release_token(int token)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(opal_async_release_token);
 
 int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 {
@@ -120,6 +122,7 @@ int opal_async_wait_response(uint64_t token, struct opal_msg *msg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(opal_async_wait_response);
 
 static int opal_async_comp_event(struct notifier_block *nb,
 		unsigned long msg_type, void *msg)
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index b1885db..a3c1b43 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -15,6 +15,8 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/opal.h>
 #include <asm/firmware.h>
@@ -49,11 +51,9 @@ unsigned long __init opal_get_boot_time(void)
 		else
 			mdelay(10);
 	}
-	if (rc != OPAL_SUCCESS) {
-		ppc_md.get_rtc_time = NULL;
-		ppc_md.set_rtc_time = NULL;
+	if (rc != OPAL_SUCCESS)
 		return 0;
-	}
+
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
@@ -61,49 +61,24 @@ unsigned long __init opal_get_boot_time(void)
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
-void opal_get_rtc_time(struct rtc_time *tm)
+static __init int opal_time_init(void)
 {
-	long rc = OPAL_BUSY;
-	u32 y_m_d;
-	u64 h_m_s_ms;
-	__be32 __y_m_d;
-	__be64 __h_m_s_ms;
+	struct platform_device *pdev;
+	struct device_node *rtc;
 
-	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
-			opal_poll_events(NULL);
+	rtc = of_find_node_by_path("/ibm,opal/rtc");
+	if (rtc) {
+		pdev = of_platform_device_create(rtc, "opal-rtc", NULL);
+		of_node_put(rtc);
+	} else {
+		if (opal_check_token(OPAL_RTC_READ) == OPAL_TOKEN_PRESENT ||
+		    opal_check_token(OPAL_READ_TPO) == OPAL_TOKEN_PRESENT)
+			pdev = platform_device_register_simple("opal-rtc", -1,
+							       NULL, 0);
 		else
-			mdelay(10);
+			return -ENODEV;
 	}
-	if (rc != OPAL_SUCCESS)
-		return;
-	y_m_d = be32_to_cpu(__y_m_d);
-	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
-	opal_to_tm(y_m_d, h_m_s_ms, tm);
-}
-
-int opal_set_rtc_time(struct rtc_time *tm)
-{
-	long rc = OPAL_BUSY;
-	u32 y_m_d = 0;
-	u64 h_m_s_ms = 0;
-
-	y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) / 100)) << 24;
-	y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) % 100)) << 16;
-	y_m_d |= ((u32)bin2bcd((tm->tm_mon + 1))) << 8;
-	y_m_d |= ((u32)bin2bcd(tm->tm_mday));
 
-	h_m_s_ms |= ((u64)bin2bcd(tm->tm_hour)) << 56;
-	h_m_s_ms |= ((u64)bin2bcd(tm->tm_min)) << 48;
-	h_m_s_ms |= ((u64)bin2bcd(tm->tm_sec)) << 40;
-
-	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_rtc_write(y_m_d, h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
-			opal_poll_events(NULL);
-		else
-			mdelay(10);
-	}
-	return rc == OPAL_SUCCESS ? 0 : -EIO;
+	return PTR_ERR_OR_ZERO(pdev);
 }
+machine_subsys_initcall(powernv, opal_time_init);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 5718855..3dfe93e95 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -248,3 +248,5 @@ OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
+OPAL_CALL(opal_tpo_write,			OPAL_WRITE_TPO);
+OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b44eec3..c87f6d9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -784,3 +784,9 @@ void opal_free_sg_list(struct opal_sg_list *sg)
 			sg = NULL;
 	}
 }
+
+EXPORT_SYMBOL_GPL(opal_poll_events);
+EXPORT_SYMBOL_GPL(opal_rtc_read);
+EXPORT_SYMBOL_GPL(opal_rtc_write);
+EXPORT_SYMBOL_GPL(opal_tpo_read);
+EXPORT_SYMBOL_GPL(opal_tpo_write);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5a0e2dc..8179c26 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -257,8 +257,6 @@ static unsigned long pnv_memory_block_size(void)
 static void __init pnv_setup_machdep_opal(void)
 {
 	ppc_md.get_boot_time = opal_get_boot_time;
-	ppc_md.get_rtc_time = opal_get_rtc_time;
-	ppc_md.set_rtc_time = opal_set_rtc_time;
 	ppc_md.restart = pnv_restart;
 	ppc_md.power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a168e96..4229e00 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -949,6 +949,17 @@ config RTC_DRV_NUC900
 	  If you say yes here you get support for the RTC subsystem of the
 	  NUC910/NUC920 used in embedded systems.
 
+config RTC_DRV_OPAL
+	tristate "IBM OPAL RTC driver"
+	depends on PPC_POWERNV
+	default y
+	help
+	  If you say yes here you get support for the PowerNV platform RTC
+	  driver based on OPAL interfaces.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-opal.
+
 comment "on-CPU RTC drivers"
 
 config RTC_DRV_DAVINCI
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 56f061c..c4e7d1e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
 obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
 obj-$(CONFIG_RTC_DRV_NUC900)	+= rtc-nuc900.o
+obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
new file mode 100644
index 0000000..95f6521
--- /dev/null
+++ b/drivers/rtc/rtc-opal.c
@@ -0,0 +1,261 @@
+/*
+ * IBM OPAL RTC driver
+ * Copyright (C) 2014 IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#define DRVNAME		"rtc-opal"
+#define pr_fmt(fmt)	DRVNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <linux/delay.h>
+#include <linux/bcd.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <asm/opal.h>
+#include <asm/firmware.h>
+
+static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
+{
+	tm->tm_year = ((bcd2bin(y_m_d >> 24) * 100) +
+		       bcd2bin((y_m_d >> 16) & 0xff)) - 1900;
+	tm->tm_mon  = bcd2bin((y_m_d >> 8) & 0xff) - 1;
+	tm->tm_mday = bcd2bin(y_m_d & 0xff);
+	tm->tm_hour = bcd2bin((h_m_s_ms >> 56) & 0xff);
+	tm->tm_min  = bcd2bin((h_m_s_ms >> 48) & 0xff);
+	tm->tm_sec  = bcd2bin((h_m_s_ms >> 40) & 0xff);
+
+	GregorianDay(tm);
+}
+
+static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
+{
+	*y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) / 100)) << 24;
+	*y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) % 100)) << 16;
+	*y_m_d |= ((u32)bin2bcd((tm->tm_mon + 1))) << 8;
+	*y_m_d |= ((u32)bin2bcd(tm->tm_mday));
+
+	*h_m_s_ms |= ((u64)bin2bcd(tm->tm_hour)) << 56;
+	*h_m_s_ms |= ((u64)bin2bcd(tm->tm_min)) << 48;
+	*h_m_s_ms |= ((u64)bin2bcd(tm->tm_sec)) << 40;
+}
+
+static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
+{
+	long rc = OPAL_BUSY;
+	u32 y_m_d;
+	u64 h_m_s_ms;
+	__be32 __y_m_d;
+	__be64 __h_m_s_ms;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			msleep(10);
+	}
+
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	y_m_d = be32_to_cpu(__y_m_d);
+	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
+	opal_to_tm(y_m_d, h_m_s_ms, tm);
+
+	return 0;
+}
+
+static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
+{
+	long rc = OPAL_BUSY;
+	u32 y_m_d = 0;
+	u64 h_m_s_ms = 0;
+
+	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_rtc_write(y_m_d, h_m_s_ms);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			msleep(10);
+	}
+
+	return rc == OPAL_SUCCESS ? 0 : -EIO;
+}
+
+/*
+ * TPO	Timed Power-On
+ *
+ * TPO get/set OPAL calls care about the hour and min and to make it consistent
+ * with the rtc utility time conversion functions, we use the 'u64' to store
+ * its value and perform bit shift by 32 before use..
+ */
+static int opal_get_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	__be32 __y_m_d, __h_m;
+	struct opal_msg msg;
+	int rc, token;
+	u64 h_m_s_ms;
+	u32 y_m_d;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("Failed to get the async token\n");
+
+		return token;
+	}
+
+	rc = opal_tpo_read(token, &__y_m_d, &__h_m);
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	y_m_d = be32_to_cpu(__y_m_d);
+	h_m_s_ms = ((u64)be32_to_cpu(__h_m) << 32);
+	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
+
+exit:
+	opal_async_release_token(token);
+	return rc;
+}
+
+/* Set Timed Power-On */
+static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	u64 h_m_s_ms = 0, token;
+	struct opal_msg msg;
+	u32 y_m_d = 0;
+	int rc;
+
+	tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("Failed to get the async token\n");
+
+		return token;
+	}
+
+	/* TPO, we care about hour and minute */
+	rc = opal_tpo_write(token, y_m_d,
+			    (u32)((h_m_s_ms >> 32) & 0xffff0000));
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS)
+		rc = -EIO;
+
+exit:
+	opal_async_release_token(token);
+	return rc;
+}
+
+static const struct rtc_class_ops opal_rtc_ops = {
+	.read_time	= opal_get_rtc_time,
+	.set_time	= opal_set_rtc_time,
+	.read_alarm	= opal_get_tpo_time,
+	.set_alarm	= opal_set_tpo_time,
+};
+
+static int opal_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc;
+
+	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
+						 NULL))
+		device_set_wakeup_capable(&pdev->dev, true);
+
+	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
+				       THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->uie_unsupported = 1;
+
+	return 0;
+}
+
+static const struct of_device_id opal_rtc_match[] = {
+	{
+		.compatible	= "ibm,opal-rtc",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, opal_rtc_match);
+
+static const struct platform_device_id opal_rtc_driver_ids[] = {
+	{
+		.name		= "opal-rtc",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, opal_rtc_driver_ids);
+
+static struct platform_driver opal_rtc_driver = {
+	.probe		= opal_rtc_probe,
+	.id_table	= opal_rtc_driver_ids,
+	.driver		= {
+		.name		= DRVNAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= opal_rtc_match,
+	},
+};
+
+static int __init opal_rtc_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return -ENODEV;
+
+	return platform_driver_register(&opal_rtc_driver);
+}
+
+static void __exit opal_rtc_exit(void)
+{
+	platform_driver_unregister(&opal_rtc_driver);
+}
+
+MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("IBM OPAL RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(opal_rtc_init);
+module_exit(opal_rtc_exit);
