Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3520DE04C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 14:25:39 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0B3PC70001109
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 14:25:12 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0B3Pctd1929316
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 14:25:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0B3PcvQ030020
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 14:25:38 +1100
Date: Fri, 11 Jan 2008 14:25:34 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: Enable RTC for Ebony and Walnut (v2)
Message-ID: <20080111032534.GA25055@localhost.localdomain>
References: <20071221022130.GI2665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221022130.GI2665@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch extends the Ebony and Walnut platform code to instantiate
the existing ds1742 RTC class driver for the DS1743 RTC/NVRAM chip
found on both those boards.  The patch uses a helper function to scan
the device tree and instantiate the appropriate platform_device based
on it, so it should be easy to extend for other boards which have mmio
mapped RTC chips.

Along with this, the device tree binding for the ds1743 chips is
tweaked, based on the existing DS1385 OF binding found at:
	http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346-it.txt
Although that document covers the NVRAM portion of the chip, whereas
here we're interested in the RTC portion, so it's not entirely clear
if that's a good model.

This implements only RTC class driver support - that is /dev/rtc0, not
/dev/rtc, and the low-level get/set time callbacks remain
unimplemented.  That means in order to get at the clock you will
either need a modified version of hwclock which will look at
/dev/rtc0, or you'll need to configure udev to symlink rtc0 to rtc.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Updated for kernel changes and feedback.

Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2008-01-11 14:17:03.000000000 +1100
@@ -158,9 +158,10 @@
 					};
 				};
 
-				ds1743@1,0 {
+				nvram@1,0 {
 					/* NVRAM & RTC */
-					compatible = "ds1743";
+					compatible = "ds1743-nvram";
+					#bytes = <2000>;
 					reg = <1 0 2000>;
 				};
 
Index: working-2.6/arch/powerpc/platforms/44x/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/44x/ebony.c	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/44x/ebony.c	2008-01-11 14:17:03.000000000 +1100
@@ -18,6 +18,7 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/rtc.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -38,6 +39,7 @@ static __initdata struct of_device_id eb
 static int __init ebony_device_probe(void)
 {
 	of_platform_bus_probe(NULL, ebony_of_bus, NULL);
+	of_instantiate_rtc();
 
 	return 0;
 }
Index: working-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/Kconfig	2007-12-10 10:52:44.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/Kconfig	2008-01-11 14:17:03.000000000 +1100
@@ -315,6 +315,12 @@ config FSL_ULI1575
 config CPM
 	bool
 
+config OF_RTC
+	bool
+	help
+	  Uses information from the OF or flattened device tree to instatiate
+	  platform devices for direct mapped RTC chips like the DS1742 or DS1743.
+
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
 endmenu
Index: working-2.6/arch/powerpc/sysdev/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/Makefile	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/sysdev/Makefile	2008-01-11 14:17:03.000000000 +1100
@@ -27,6 +27,7 @@ obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
Index: working-2.6/arch/powerpc/sysdev/of_rtc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/sysdev/of_rtc.c	2008-01-11 14:17:03.000000000 +1100
@@ -0,0 +1,59 @@
+/*
+ * Instantiate mmio-mapped RTC chips based on device tree information
+ *
+ * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+static __initdata struct {
+	const char *compatible;
+	char *plat_name;
+} of_rtc_table[] = {
+	{ "ds1743-nvram", "rtc-ds1742" },
+};
+
+void __init of_instantiate_rtc(void)
+{
+	struct device_node *node;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(of_rtc_table); i++) {
+		char *plat_name = of_rtc_table[i].plat_name;
+
+		for_each_compatible_node(node, NULL,
+					 of_rtc_table[i].compatible) {
+			struct resource *res;
+
+			res = kmalloc(sizeof(*res), GFP_KERNEL);
+			if (!res) {
+				printk(KERN_ERR "OF RTC: Out of memory "
+				       "allocating resource structure for %s\n",
+				       node->full_name);
+				continue;
+			}
+
+			err = of_address_to_resource(node, 0, res);
+			if (err) {
+				printk(KERN_ERR "OF RTC: Error "
+				       "translating resources for %s\n",
+				       node->full_name);
+				continue;
+			}
+
+			printk(KERN_INFO "OF_RTC: %s is a %s @ 0x%llx-0x%llx\n",
+			       node->full_name, plat_name,
+			       (unsigned long long)res->start,
+			       (unsigned long long)res->end);
+			platform_device_register_simple(plat_name, -1, res, 1);
+		}
+	}
+}
Index: working-2.6/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/44x/Kconfig	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/44x/Kconfig	2008-01-11 14:17:03.000000000 +1100
@@ -13,6 +13,7 @@ config EBONY
 	default y
 	select 440GP
 	select PCI
+	select OF_RTC
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
Index: working-2.6/include/asm-powerpc/of_platform.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/of_platform.h	2008-01-11 11:45:29.000000000 +1100
+++ working-2.6/include/asm-powerpc/of_platform.h	2008-01-11 14:17:03.000000000 +1100
@@ -37,4 +37,6 @@ extern int of_platform_bus_probe(struct 
 
 extern struct of_device *of_find_device_by_phandle(phandle ph);
 
+extern void of_instantiate_rtc(void);
+
 #endif	/* _ASM_POWERPC_OF_PLATFORM_H */
Index: working-2.6/arch/powerpc/boot/dts/walnut.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/walnut.dts	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/boot/dts/walnut.dts	2008-01-11 14:17:03.000000000 +1100
@@ -175,9 +175,10 @@
 				};
 			};
 
-			ds1743@1,0 {
+			nvram@1,0 {
 				/* NVRAM and RTC */
-				compatible = "ds1743";
+				compatible = "ds1743-nvram";
+				#bytes = <2000>;
 				reg = <1 0 2000>;
 			};
 
Index: working-2.6/arch/powerpc/platforms/40x/walnut.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/40x/walnut.c	2008-01-11 11:45:27.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/40x/walnut.c	2008-01-11 14:17:03.000000000 +1100
@@ -36,6 +36,7 @@ static __initdata struct of_device_id wa
 static int __init walnut_device_probe(void)
 {
 	of_platform_bus_probe(NULL, walnut_of_bus, NULL);
+	of_instantiate_rtc();
 
 	return 0;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
