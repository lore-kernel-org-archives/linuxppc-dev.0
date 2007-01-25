Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1ABC6DE06E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 18:32:09 +1100 (EST)
Date: Thu, 25 Jan 2007 01:37:54 -0600
To: paulus@samba.org
Subject: [PATCH] generic RTC support for PPC
Message-ID: <20070125073754.GA10004@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the PPC RTC functions use the generic RTC infrastructure if they
are not already defined (and an RTC is registered in the system).

This should make it possible to remove the hideous direct access used
in some of the 83xx platforms.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: powerpc/arch/powerpc/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/Kconfig
+++ powerpc/arch/powerpc/Kconfig
@@ -687,6 +687,12 @@ config TAU_AVERAGE
 
 	  If in doubt, say N here.
 
+config PPC_GENRTC
+	bool "Generic RTC support"
+	help
+	  Support for using regular RTC registered with the RTC framework
+	  as the main hardware clock on powerpc.
+
 endmenu
 
 source arch/powerpc/platforms/embedded6xx/Kconfig
Index: powerpc/arch/powerpc/sysdev/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/sysdev/Makefile
+++ powerpc/arch/powerpc/sysdev/Makefile
@@ -22,4 +22,5 @@ endif
 ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_MTD)		+= rom.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
+obj-$(CONFIG_PPC_GENRTC)	+= genrtc.o
 endif
Index: powerpc/arch/powerpc/sysdev/genrtc.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/sysdev/genrtc.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/time.h>
+#include <linux/device.h>
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+static struct class_device *rtc_dev;
+
+static void genrtc_set_rtc_time_work(struct work_struct *work);
+
+static struct rtc_time delayed_tm;
+static struct workqueue_struct *rtc_workqueue;
+static DECLARE_WORK(rtc_work, genrtc_set_rtc_time_work);
+
+static void genrtc_set_rtc_time_work(struct work_struct *work)
+{
+	rtc_set_time(rtc_dev, &delayed_tm);
+}
+
+static int genrtc_set_rtc_time(struct rtc_time *tm)
+{
+	if (in_interrupt()) {
+		/* Can't access RTC with interrupts off, since some of
+		 * the drivers might sleep. Delay the setting with a
+		 * work queue.
+		 */
+		memcpy(&delayed_tm, tm, sizeof(struct rtc_time));
+		queue_work(rtc_workqueue, &rtc_work);
+		return 0;
+	} else
+		return rtc_set_time(rtc_dev, tm);
+}
+
+static void genrtc_get_rtc_time(struct rtc_time *tm)
+{
+	rtc_read_time(rtc_dev, tm);
+}
+
+static int __init genrtc_rtc_hookup(void)
+{
+	/* Don't init if the platform has already set up rtc functions. */
+	if (ppc_md.get_rtc_time || ppc_md.set_rtc_time)
+		return -1;
+
+	rtc_dev = rtc_class_open("rtc0");
+
+	if (!rtc_dev) {
+		printk("genrtc_rtc_hookup: Failed to open rtc0\n");
+		return -1;
+	}
+
+	ppc_md.get_rtc_time = genrtc_get_rtc_time;
+	ppc_md.set_rtc_time = genrtc_set_rtc_time;
+
+	return 0;
+}
+late_initcall(genrtc_rtc_hookup);
+
