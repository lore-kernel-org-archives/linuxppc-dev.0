Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id DB6B7DDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:55:48 +1000 (EST)
Subject: [PATCH v4] Create add_rtc() function to enable the RTC CMOS driver
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18067.29586.481904.580320@cargo.ozlabs.ibm.com>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
	<18067.29586.481904.580320@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Jul 2007 09:55:46 -0700
Message-Id: <1184086546.16794.18.camel@rhino>
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
in asm/mc146818rtc.h.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

Fixed line wrapping.

 arch/powerpc/sysdev/Makefile         |    1 
 arch/powerpc/sysdev/rtc_cmos_setup.c |   49 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 7d8ac1b..f65078c 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
+obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 
 # contains only the suspend handler for time
 ifeq ($(CONFIG_RTC_CLASS),)
diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c b/arch/powerpc/sysdev/rtc_cmos_setup.c
new file mode 100644
index 0000000..e276048
--- /dev/null
+++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
@@ -0,0 +1,49 @@
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
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
+	if (!np)
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+	if (ret)
+		return ret;
+
+	/*
+	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
+	 * address provided by the device node matches.
+	 */
+	if (res.start != RTC_PORT(0))
+		return -EINVAL;
+
+	pd = platform_device_register_simple("rtc_cmos", -1,
+					     &res, 1);
+	if (IS_ERR(pd))
+		return PTR_ERR(pd);
+
+	return 0;
+}
+fs_initcall(add_rtc);
