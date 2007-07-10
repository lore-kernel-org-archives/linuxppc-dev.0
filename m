Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172]) by ozlabs.org (Postfix) with ESMTP id E9802DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 21:12:49 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 012FA1E85
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 13:12:47 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id DFABD1C54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 13:12:46 +0200 (CEST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [POWERPC] Move generic MPC82xx functions out of ADS-specific
Date: Tue, 10 Jul 2007 13:12:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707101312.46052.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The non board-specific mpc82xx_halt and mpc82xx_restart functions are defined
in arch/powerpc/platforms/82xx/mpc82xx_ads.c. This patch moves them to
mpc82xx.c to make them usable by other MPC82xx boards.

Signed-off-by: Laurent Pinchart <laurent.pinchart@technotrade.biz>
---
 arch/powerpc/platforms/82xx/mpc82xx.c     |   33 
+++++++++++++++--------------
 arch/powerpc/platforms/82xx/mpc82xx.h     |   24 +++++++++++++++++++++
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |   31 ++++++++++++++-------------
 arch/powerpc/platforms/82xx/pq2ads.h      |    1 -
 4 files changed, 57 insertions(+), 32 deletions(-)
 create mode 100644 arch/powerpc/platforms/82xx/mpc82xx.h

diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c 
b/arch/powerpc/platforms/82xx/mpc82xx.c
index cc9900d..d67c754 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -50,7 +50,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
-#include "pq2ads.h"
+#include "mpc82xx.h"
 
 static int __init get_freq(char *name, unsigned long *val)
 {
@@ -88,23 +88,24 @@ void __init m82xx_calibrate_decr(void)
 				"(not found)\n");
 }
 
-void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
+#define RMR_CSRE 0x00000001
+void m82xx_restart(char *cmd)
 {
-	uint pvid, svid, phid1;
-	uint memsize = total_memory;
+	__volatile__ unsigned char dummy;
 
-	pvid = mfspr(SPRN_PVR);
-	svid = mfspr(SPRN_SVR);
+	local_irq_disable();
+	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
 
-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
-	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
-	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-
-	/* Display cpu Pll setting */
-	phid1 = mfspr(SPRN_HID1);
-	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
+	printk("Restart failed\n");
+	while (1) ;
+}
 
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+void m82xx_halt(void)
+{
+	local_irq_disable();
+	while (1) ;
 }
+
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.h 
b/arch/powerpc/platforms/82xx/mpc82xx.h
new file mode 100644
index 0000000..427925b
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/mpc82xx.h
@@ -0,0 +1,24 @@
+/*
+ * MPC82xx setup and early boot code plus other random bits.
+ *
+ * Author: Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MACH_MPC82XX_H__
+#define __MACH_MPC82XX_H__
+
+#include <linux/init.h>
+
+extern void __init m82xx_calibrate_decr(void);
+extern void m82xx_restart(char *cmd);
+extern void m82xx_halt(void);
+
+#endif
+
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c 
b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 47cb09f..1af9449 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -51,6 +51,7 @@
 #include <sysdev/fsl_soc.h>
 #include <../sysdev/cpm2_pic.h>
 
+#include "mpc82xx.h"
 #include "pq2ads.h"
 
 #ifdef CONFIG_PCI
@@ -611,25 +612,25 @@ static int __init mpc82xx_ads_probe(void)
 	return 1;
 }
 
-#define RMR_CSRE 0x00000001
-static void m82xx_restart(char *cmd)
+void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
 {
-	__volatile__ unsigned char dummy;
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
 
-	local_irq_disable();
-	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
 
-	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
-	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
-	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
-	printk("Restart failed\n");
-	while (1) ;
-}
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
-static void m82xx_halt(void)
-{
-	local_irq_disable();
-	while (1) ;
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 define_machine(mpc82xx_ads)
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h 
b/arch/powerpc/platforms/82xx/pq2ads.h
index 5b5cca6..5056fe5 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -60,7 +60,6 @@
 
 void m82xx_pci_init_irq(void);
 void mpc82xx_ads_show_cpuinfo(struct seq_file*);
-void m82xx_calibrate_decr(void);
 
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
-- 
1.5.0
