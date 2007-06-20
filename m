Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id D1581DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 10:15:12 +1000 (EST)
Subject: [PATCH v2] Create add_rtc() function to enable the RTC CMOS driver
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 19 Jun 2007 17:15:10 -0700
Message-Id: <1182298510.5674.358.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to use the RTC CMOS driver, each architecture must register a
platform device for the RTC.

This creates a function to register the platform device based on the RTC
device node and verifies that the RTC port against the hard-coded value
in asm/mc146818rtc.h.  It also sets the RTC to 24-hr mode as 12-hr mode
is not currently supported by the driver.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/sysdev/Makefile         |    1 
 arch/powerpc/sysdev/rtc_cmos_setup.c |   54 +++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

Index: linux-2.6-powerpc-8641/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6-powerpc-8641/arch/powerpc/sysdev/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
+obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o
Index: linux-2.6-powerpc-8641/arch/powerpc/sysdev/rtc_cmos_setup.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc-8641/arch/powerpc/sysdev/rtc_cmos_setup.c
@@ -0,0 +1,54 @@
+/*
+ * Setup code for PC-style Real-Time Clock.
+ *
+ * Author: Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * 2007 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mc146818rtc.h>
+
+#include <asm/prom.h>
+
+static int  __init add_rtc(void)
+{
+	struct device_node *np;
+	struct platform_device *pd;
+	struct resource res;
+
+	np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
+	if (!np)
+		return -ENODEV;
+
+	if (of_address_to_resource(np, 0, &res)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	/*
+	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
+	 * address provided by the device node matches.
+	 */
+	if (res.start != RTC_PORT(0)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	pd = platform_device_register_simple("rtc_cmos", -1,
+					     &res, 1);
+	of_node_put(np);
+	if (IS_ERR(pd))
+		return PTR_ERR(pd);
+
+	/* rtc-cmos only supports 24-hr mode */
+	CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_24H, RTC_CONTROL);
+
+	return 0;
+}
+fs_initcall(add_rtc);
