Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 6704CDDF22
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:36:04 +1000 (EST)
Received: from [10.50.1.88] (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id 81A121D29E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:36:03 -0700 (PDT)
Subject: [PATCH 4/5] Add RTC CMOS support for the MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1179245829.8132.100.camel@rhino>
References: <1179245829.8132.100.camel@rhino>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:36:03 -0700
Message-Id: <1179246963.8132.121.camel@rhino>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This enables the new RTC CMOS driver to be used on the MPC8641 HPCN.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   27 +++++++++++++++++++
 1 file changed, 27 insertions(+)


Index: powerpc-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- powerpc-8641.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ powerpc-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/mc146818rtc.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -368,6 +369,32 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_A
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+
+#ifdef CONFIG_RTC_DRV_CMOS
+struct resource rtc_platform_resource = {
+	.flags		= IORESOURCE_IO,
+	.start		= RTC_PORT(0),
+	.end		= RTC_PORT(1),
+};
+
+static int  __init mpc8641_hpcn_add_rtc(void)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_register_simple("rtc_cmos", -1,
+					     &rtc_platform_resource, 1);
+	if (IS_ERR(pd))
+		return PTR_ERR(pd);
+
+	/* rtc-cmos only supports 24-hr mode */
+	CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_24H, RTC_CONTROL);
+
+	return 0;
+}
+arch_initcall(mpc8641_hpcn_add_rtc);
+
+#endif /* CONFIG_RTC_DRV_CMOS */
+
 #endif /* CONFIG_PCI */
 
 
