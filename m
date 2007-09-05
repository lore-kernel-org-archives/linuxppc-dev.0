Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD7BEE0340
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:29:27 +1000 (EST)
Date: Wed, 5 Sep 2007 14:29:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 06/10] mpc82xx: Remove a bunch of cruft that duplicates
	generic functionality.
Message-ID: <20070905192916.GE32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m82xx_calibrate_decr(), mpc82xx_ads_show_cpuinfo(), and mpc82xx_halt() do
anything useful beyond what the generic code does.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/Makefile      |    1 -
 arch/powerpc/platforms/82xx/mpc82xx.c     |  109 -----------------------------
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |   10 +--
 arch/powerpc/platforms/82xx/pq2ads.h      |    6 --
 4 files changed, 2 insertions(+), 124 deletions(-)
 delete mode 100644 arch/powerpc/platforms/82xx/mpc82xx.c

diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index d9fd4c8..534c353 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -1,5 +1,4 @@
 #
 # Makefile for the PowerPC 82xx linux kernel.
 #
-obj-$(CONFIG_PPC_82xx) += mpc82xx.o
 obj-$(CONFIG_MPC82xx_ADS) += mpc82xx_ads.o
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
deleted file mode 100644
index c706871..0000000
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * MPC82xx setup and early boot code plus other random bits.
- *
- * Author: Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * Copyright (c) 2006 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
-#include <linux/fsl_devices.h>
-#include <linux/fs_uart_pd.h>
-
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpc8260.h>
-#include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
-#include <asm/cpm2.h>
-#include <asm/udbg.h>
-#include <asm/i8259.h>
-#include <linux/fs_enet_pd.h>
-
-#include <sysdev/fsl_soc.h>
-#include <sysdev/cpm2_pic.h>
-
-#include "pq2ads.h"
-
-static int __init get_freq(char *name, unsigned long *val)
-{
-	struct device_node *cpu;
-	const unsigned int *fp;
-	int found = 0;
-
-	/* The cpu node should have timebase and clock frequency properties */
-	cpu = of_find_node_by_type(NULL, "cpu");
-
-	if (cpu) {
-		fp = of_get_property(cpu, name, NULL);
-		if (fp) {
-			found = 1;
-			*val = *fp;
-		}
-
-		of_node_put(cpu);
-	}
-
-	return found;
-}
-
-void __init m82xx_calibrate_decr(void)
-{
-	ppc_tb_freq = 125000000;
-	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-				"(not found)\n");
-	}
-	ppc_tb_freq /= 4;
-	ppc_proc_freq = 1000000000;
-	if (!get_freq("clock-frequency", &ppc_proc_freq))
-		printk(KERN_ERR "WARNING: Estimating processor frequency"
-				"(not found)\n");
-}
-
-void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
-{
-	uint pvid, svid, phid1;
-	uint memsize = total_memory;
-
-	pvid = mfspr(SPRN_PVR);
-	svid = mfspr(SPRN_SVR);
-
-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
-	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
-	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-
-	/* Display cpu Pll setting */
-	phid1 = mfspr(SPRN_HID1);
-	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
-}
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index c0a0c56..64e8ca9 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -621,12 +621,6 @@ static void m82xx_restart(char *cmd)
 	while (1) ;
 }
 
-static void m82xx_halt(void)
-{
-	local_irq_disable();
-	while (1) ;
-}
-
 define_machine(mpc82xx_ads)
 {
 	.name = "MPC82xx ADS",
@@ -635,6 +629,6 @@ define_machine(mpc82xx_ads)
 	.init_IRQ =    mpc82xx_ads_pic_init,
 	.show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
 	.get_irq =    cpm2_get_irq,
-	.calibrate_decr =    m82xx_calibrate_decr,
-	.restart = m82xx_restart,.halt = m82xx_halt,
+	.calibrate_decr = generic_calibrate_decr,
+	.restart = m82xx_restart,
 };
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 6f749b7..8b67048 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -24,10 +24,6 @@
 
 #include <linux/seq_file.h>
 
-/* For our show_cpuinfo hooks. */
-#define CPUINFO_VENDOR		"Freescale Semiconductor"
-#define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
-
 /* Backword-compatibility stuff for the drivers */
 #define CPM_MAP_ADDR		((uint)0xf0000000)
 #define CPM_IRQ_OFFSET 0
@@ -58,8 +54,6 @@
 #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
 
 void m82xx_pci_init_irq(void);
-void mpc82xx_ads_show_cpuinfo(struct seq_file*);
-void m82xx_calibrate_decr(void);
 
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
-- 
1.5.3
