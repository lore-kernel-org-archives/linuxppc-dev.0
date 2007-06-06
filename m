Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 3F954DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 02:37:54 +1000 (EST)
Subject: [PATCH] Create add_rtc() function to enable the RTC CMOS driver
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Wed, 06 Jun 2007 09:37:53 -0700
Message-Id: <1181147873.5674.116.camel@rhino>
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

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/kernel/setup-common.c |   31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Index: linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-powerpc-8641/arch/powerpc/kernel/setup-common.c
@@ -32,6 +32,7 @@
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/mc146818rtc.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -447,6 +448,36 @@ static __init int add_pcspkr(void)
 }
 device_initcall(add_pcspkr);
 
+#ifdef CONFIG_RTC_DRV_CMOS
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
+device_initcall(add_rtc);
+#endif /* CONFIG_RTC_DRV_CMOS */
+
 void probe_machine(void)
 {
 	extern struct machdep_calls __machine_desc_start;
