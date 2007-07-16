Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C9B92DDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 05:49:56 +1000 (EST)
Message-ID: <469B33F2.9040306@windriver.com>
Date: Mon, 16 Jul 2007 17:01:38 +0800
From: Mark Zhan <rongkai.zhan@windriver.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] 82xx: some 82xx platform hook functions can be shared
	by different boards
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some mpc82xx platform hooks in mpc82xx_ads.c are actually not specific to ads board, they could be shared by different 
82xx boards.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  arch/powerpc/platforms/82xx/mpc82xx.c     |   30 +++++++++++++++++++----
  arch/powerpc/platforms/82xx/mpc82xx_ads.c |   38 +++++++-----------------------
  arch/powerpc/platforms/82xx/pq2ads.h      |    2 -
  include/asm-powerpc/mpc8260.h             |    5 +++
  4 files changed, 39 insertions(+), 36 deletions(-)

Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/mpc82xx.c
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/platforms/82xx/mpc82xx.c	2007-07-16 15:20:51.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/mpc82xx.c	2007-07-16 15:52:42.000000000 +0800
@@ -50,8 +50,6 @@
  #include <sysdev/fsl_soc.h>
  #include <sysdev/cpm2_pic.h>

-#include "pq2ads.h"
-
  static int __init get_freq(char *name, unsigned long *val)
  {
  	struct device_node *cpu;
@@ -74,7 +72,7 @@
  	return found;
  }

-void __init m82xx_calibrate_decr(void)
+void __init mpc82xx_calibrate_decr(void)
  {
  	ppc_tb_freq = 125000000;
  	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
@@ -88,7 +86,7 @@
  				"(not found)\n");
  }

-void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
+void mpc82xx_show_cpuinfo(struct seq_file *m)
  {
  	uint pvid, svid, phid1;
  	uint memsize = total_memory;
@@ -96,7 +94,7 @@
  	pvid = mfspr(SPRN_PVR);
  	svid = mfspr(SPRN_SVR);

-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Vendor\t\t: %s\n", CPUINFO_VENDOR);
  	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
  	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
  	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
@@ -108,3 +106,25 @@
  	/* Display the amount of memory */
  	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
  }
+
+#define RMR_CSRE 0x00000001
+
+void mpc82xx_restart(char *cmd)
+{
+	__volatile__ unsigned char dummy;
+
+	local_irq_disable();
+	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
+
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
+	printk("Restart failed\n");
+	while (1) ;
+}
+
+void mpc82xx_halt(void)
+{
+	local_irq_disable();
+	while (1) ;
+}
Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2007-07-16 15:20:51.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2007-07-16 15:47:04.000000000 +0800
@@ -606,35 +606,15 @@
  	return 1;
  }

-#define RMR_CSRE 0x00000001
-static void m82xx_restart(char *cmd)
-{
-	__volatile__ unsigned char dummy;
-
-	local_irq_disable();
-	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
-
-	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
-	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
-	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
-	printk("Restart failed\n");
-	while (1) ;
-}
-
-static void m82xx_halt(void)
-{
-	local_irq_disable();
-	while (1) ;
-}
-
  define_machine(mpc82xx_ads)
  {
-	.name = "MPC82xx ADS",
-	.probe = mpc82xx_ads_probe,
-	.setup_arch =    mpc82xx_ads_setup_arch,
-	.init_IRQ =    mpc82xx_ads_pic_init,
-	.show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
-	.get_irq =    cpm2_get_irq,
-	.calibrate_decr =    m82xx_calibrate_decr,
-	.restart = m82xx_restart,.halt = m82xx_halt,
+	.name		= "MPC82xx ADS",
+	.probe		= mpc82xx_ads_probe,
+	.setup_arch	= mpc82xx_ads_setup_arch,
+	.init_IRQ	= mpc82xx_ads_pic_init,
+	.show_cpuinfo	= mpc82xx_show_cpuinfo,
+	.get_irq	= cpm2_get_irq,
+	.calibrate_decr	= mpc82xx_calibrate_decr,
+	.restart	= mpc82xx_restart,
+	.halt		= mpc82xx_halt,
  };
Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/pq2ads.h
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/platforms/82xx/pq2ads.h	2007-07-16 15:20:51.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/pq2ads.h	2007-07-16 15:47:04.000000000 +0800
@@ -59,8 +59,6 @@
  #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)

  void m82xx_pci_init_irq(void);
-void mpc82xx_ads_show_cpuinfo(struct seq_file*);
-void m82xx_calibrate_decr(void);

  #endif /* __MACH_ADS8260_DEFS */
  #endif /* __KERNEL__ */
Index: linux-powerpc-2.6.x/include/asm-powerpc/mpc8260.h
===================================================================
--- linux-powerpc-2.6.x.orig/include/asm-powerpc/mpc8260.h	2007-07-16 15:21:09.000000000 +0800
+++ linux-powerpc-2.6.x/include/asm-powerpc/mpc8260.h	2007-07-16 15:52:16.000000000 +0800
@@ -19,6 +19,11 @@
  #include <platforms/82xx/m82xx_pci.h>
  #endif

+extern void mpc82xx_show_cpuinfo(struct seq_file *);
+extern void mpc82xx_calibrate_decr(void);
+extern void mpc82xx_restart(char *cmd);
+extern void mpc82xx_halt(void);
+
  #endif /* CONFIG_8260 */
  #endif /* !__ASM_POWERPC_MPC8260_H__ */
  #endif /* __KERNEL__ */
