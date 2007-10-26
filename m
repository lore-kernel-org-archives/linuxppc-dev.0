Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 33AD9DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 04:01:59 +1000 (EST)
Message-ID: <472227CD.8080204@mvista.com>
Date: Fri, 26 Oct 2007 10:45:49 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] Allow sharing of CMOS clock setup.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 61da8cf1f92043925ea20ffafafaf0874d761b0e Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Wed, 24 Oct 2007 17:36:59 -0700
Subject: [PATCH] Allow sharing of CMOS clock setup.

Move the CMOS RTC clock setup code from arch/powerpc/platforms/fsl_uli1575.c
to arch/powerpc/sysdev/rtc_cmos_setup.c so it can be used by more platforms.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/fsl_uli1575.c |   14 --------------
 arch/powerpc/sysdev/rtc_cmos_setup.c |   13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index afc9141..171d04f 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/mc146818rtc.h>
 
 #include <asm/system.h>
 #include <asm/pci-bridge.h>
@@ -155,19 +154,6 @@ static void __devinit quirk_final_uli1575(struct pci_dev *dev)
 
 	outb(0xfa, 0x4d0);
 	outb(0x1e, 0x4d1);
-
-	/* setup RTC */
-	CMOS_WRITE(RTC_SET, RTC_CONTROL);
-	CMOS_WRITE(RTC_24H, RTC_CONTROL);
-
-	/* ensure month, date, and week alarm fields are ignored */
-	CMOS_WRITE(0, RTC_VALID);
-
-	outb_p(0x7c, 0x72);
-	outb_p(RTC_ALARM_DONT_CARE, 0x73);
-
-	outb_p(0x7d, 0x72);
-	outb_p(RTC_ALARM_DONT_CARE, 0x73);
 }
 
 /* SATA */
diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c b/arch/powerpc/sysdev/rtc_cmos_setup.c
index 0c9ac7e..4779b0b 100644
--- a/arch/powerpc/sysdev/rtc_cmos_setup.c
+++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
@@ -53,6 +53,19 @@ static int  __init add_rtc(void)
 	if (IS_ERR(pd))
 		return PTR_ERR(pd);
 
+	/* setup RTC */
+	CMOS_WRITE(RTC_SET, RTC_CONTROL);
+	CMOS_WRITE(RTC_24H, RTC_CONTROL);
+
+	/* ensure month, date, and week alarm fields are ignored */
+	CMOS_WRITE(0, RTC_VALID);
+
+	outb_p(0x7c, 0x72);
+	outb_p(RTC_ALARM_DONT_CARE, 0x73);
+
+	outb_p(0x7d, 0x72);
+	outb_p(RTC_ALARM_DONT_CARE, 0x73);
+
 	return 0;
 }
 fs_initcall(add_rtc);
-- 
1.5.3.rc2.22.g69a9b
