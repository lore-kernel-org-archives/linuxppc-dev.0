Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 4848F68648
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 08:12:05 +1000 (EST)
To: linuxppc-dev@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 22 Oct 2005 23:05:11 +0200
Sender: wd@denx.de
Message-Id: <20051022210511.9DFA9352B25@atlas.denx.de>
Cc: lm-sensors@lm-sensors.org
Subject: [PATCH 2.6] Add generic support for DS1377 RTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patch (against current Linux 2.6  tree)  moves  generic
DS1377  RTC  support from the "radstone_ppc7d" platform specific file
to it's proper place ("drivers/i2c/chips/ds1337.c") and makes it thus
common and available for other boards too.


---
Add common ds1337_get_rtc_time() and ds1337_set_rtc_time() routines.
Derived from radstone platform specific code.

Fix BIN2BCD month conversion.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>

---
commit 80387b45146a9e397c1fec1138f3eb3884c42ed8
tree 690680af98e271f64025a49c30b1bfcb5b5c465c
parent d85b5d8b85163f43dd2d7d62dbd3db630cbe2663
author Marian Balakowicz <m8@semihalf.com> Tue, 18 Oct 2005 18:32:28 +0200
committer Marian Balakowicz <m8@semihalf.com> Tue, 18 Oct 2005 18:32:28 +0200

 arch/ppc/platforms/radstone_ppc7d.c |   48 ++++++++---------------------------
 drivers/i2c/chips/ds1337.c          |   44 +++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/arch/ppc/platforms/radstone_ppc7d.c b/arch/ppc/platforms/radstone_ppc7d.c
--- a/arch/ppc/platforms/radstone_ppc7d.c
+++ b/arch/ppc/platforms/radstone_ppc7d.c
@@ -1,6 +1,11 @@
 /*
  * arch/ppc/platforms/radstone_ppc7d.c
  *
+ * Copyright 2005 DENX Software Engineering
+ * ppc7d_get_rtc_time(), ppc7d_set_rtc_time() renamed
+ * to generic ds1337_get_rtc_time() and ds1337_set_rtc_time()
+ * and moved to ds1337.c
+ *
  * Board setup routines for the Radstone PPC7D boards.
  *
  * Author: James Chapman <jchapman@katalix.com>
@@ -74,10 +79,10 @@ static int ppc7d_has_alma;
 extern void gen550_progress(char *, unsigned short);
 extern void gen550_init(int, struct uart_port *);
 
-/* FIXME - move to h file */
-extern int ds1337_do_command(int id, int cmd, void *arg);
-#define DS1337_GET_DATE         0
-#define DS1337_SET_DATE         1
+/* Real Time Clock support.
+ * PPC7D has a DS1337 accessed by I2C. */
+extern ulong ds1337_get_rtc_time(void);
+extern int ds1337_set_rtc_time(unsigned long nowtime);
 
 /* residual data */
 unsigned char __res[sizeof(bd_t)];
@@ -1249,37 +1254,6 @@ static void __init ppc7d_setup_arch(void
 
 }
 
-/* Real Time Clock support.
- * PPC7D has a DS1337 accessed by I2C.
- */
-static ulong ppc7d_get_rtc_time(void)
-{
-        struct rtc_time tm;
-        int result;
-
-        spin_lock(&rtc_lock);
-        result = ds1337_do_command(0, DS1337_GET_DATE, &tm);
-        spin_unlock(&rtc_lock);
-
-        if (result == 0)
-                result = mktime(tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
-
-        return result;
-}
-
-static int ppc7d_set_rtc_time(unsigned long nowtime)
-{
-        struct rtc_time tm;
-        int result;
-
-        spin_lock(&rtc_lock);
-        to_tm(nowtime, &tm);
-        result = ds1337_do_command(0, DS1337_SET_DATE, &tm);
-        spin_unlock(&rtc_lock);
-
-        return result;
-}
-
 /* This kernel command line parameter can be used to have the target
  * wait for a JTAG debugger to attach. Of course, a JTAG debugger
  * with hardware breakpoint support can have the target stop at any
@@ -1336,8 +1310,8 @@ static void ppc7d_init2(void)
 	outb(data8, PPC7D_CPLD_LEDS);
 
         /* Hook up RTC. We couldn't do this earlier because we need the I2C subsystem */
-        ppc_md.set_rtc_time = ppc7d_set_rtc_time;
-        ppc_md.get_rtc_time = ppc7d_get_rtc_time;
+        ppc_md.set_rtc_time = ds1337_set_rtc_time;
+        ppc_md.get_rtc_time = ds1337_get_rtc_time;
 
 	pr_debug("%s: exit\n", __FUNCTION__);
 }
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -1,6 +1,10 @@
 /*
  *  linux/drivers/i2c/chips/ds1337.c
  *
+ *  Copyright 2005 DENX Software Engineering
+ *  Added ds1337_get_rtc_time and ds1337_set_rtc_time routines.
+ *  Based on radstone platform specific code.
+ * 
  *  Copyright (C) 2005 James Chapman <jchapman@katalix.com>
  *
  *	based on linux/drivers/acorn/char/pcf8583.c
@@ -21,6 +25,7 @@
 #include <linux/rtc.h>		/* get the user-level API */
 #include <linux/bcd.h>
 #include <linux/list.h>
+#include <asm/time.h>
 
 /* Device registers */
 #define DS1337_REG_HOUR		2
@@ -34,6 +39,8 @@
 #define DS1337_GET_DATE		0
 #define DS1337_SET_DATE		1
 
+extern spinlock_t rtc_lock;
+
 /*
  * Functions declaration
  */
@@ -164,9 +171,9 @@ static int ds1337_set_datetime(struct i2
 	buf[1] = BIN2BCD(dt->tm_sec);
 	buf[2] = BIN2BCD(dt->tm_min);
 	buf[3] = BIN2BCD(dt->tm_hour);
-	buf[4] = BIN2BCD(dt->tm_wday) + 1;
+	buf[4] = BIN2BCD(dt->tm_wday + 1);
 	buf[5] = BIN2BCD(dt->tm_mday);
-	buf[6] = BIN2BCD(dt->tm_mon) + 1;
+	buf[6] = BIN2BCD(dt->tm_mon + 1);
 	val = dt->tm_year;
 	if (val >= 100) {
 		val -= 100;
@@ -223,6 +230,37 @@ int ds1337_do_command(int bus, int cmd, 
 	return -ENODEV;
 }
 
+ulong ds1337_get_rtc_time(void)
+{
+	struct rtc_time tm;
+	int result;
+
+	spin_lock(&rtc_lock);
+	result = ds1337_do_command(0, DS1337_GET_DATE, &tm);
+	spin_unlock(&rtc_lock);
+
+	if (result == 0)
+		result = mktime(tm.tm_year + 1900, tm.tm_mon + 1,
+				tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	return result;
+}
+
+int ds1337_set_rtc_time(unsigned long nowtime)
+{
+	struct rtc_time tm;
+	int result;
+
+	spin_lock(&rtc_lock);
+	to_tm(nowtime, &tm);
+	tm.tm_year -= 1900;
+	tm.tm_mon -= 1;
+	result = ds1337_do_command(0, DS1337_SET_DATE, &tm);
+	spin_unlock(&rtc_lock);
+
+	return result;
+}
+
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_probe(adapter, &addr_data, ds1337_detect);
@@ -375,6 +413,8 @@ MODULE_DESCRIPTION("DS1337 RTC driver");
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL_GPL(ds1337_do_command);
+EXPORT_SYMBOL_GPL(ds1337_get_rtc_time);
+EXPORT_SYMBOL_GPL(ds1337_set_rtc_time);
 
 module_init(ds1337_init);
 module_exit(ds1337_exit);



!-------------------------------------------------------------flip-
