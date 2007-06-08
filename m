Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 474F6DDF88
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 22:34:49 +1000 (EST)
Subject: [PATCH 2/6] 82xx: Add the support of Wind River SBC PowerQUICCII 82xx
From: Mark Zhan <rongkai.zhan@windriver.com>
To: "paulus@samba.org" <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:51:21 +0800
Message-Id: <1181292681.11341.11.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make some common mpc82xx platform hook functions be shared by different
82xx boards.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
 b/arch/powerpc/platforms/82xx/mpc82xx.c     |   28 +++++++++++++++++---
 b/arch/powerpc/platforms/82xx/mpc82xx_ads.c |   38
++++++----------------------
 b/arch/powerpc/platforms/82xx/pq2ads.h      |    2 -
 b/include/asm-powerpc/mpc8260.h             |    5 +++
 4 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c
b/arch/powerpc/platforms/82xx/mpc82xx.c
index cc9900d..0623c54 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -50,8 +50,6 @@ #include <linux/fs_enet_pd.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
-#include "pq2ads.h"
-
 static int __init get_freq(char *name, unsigned long *val)
 {
 	struct device_node *cpu;
@@ -74,7 +72,7 @@ static int __init get_freq(char *name, u
 	return found;
 }
 
-void __init m82xx_calibrate_decr(void)
+void __init mpc82xx_calibrate_decr(void)
 {
 	ppc_tb_freq = 125000000;
 	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
@@ -88,7 +86,7 @@ void __init m82xx_calibrate_decr(void)
 				"(not found)\n");
 }
 
-void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
+void mpc82xx_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
@@ -108,3 +106,25 @@ void mpc82xx_ads_show_cpuinfo(struct seq
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
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 47cb09f..4fec1ce 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -611,35 +611,15 @@ static int __init mpc82xx_ads_probe(void
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
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h
b/arch/powerpc/platforms/82xx/pq2ads.h
index 5b5cca6..d83def1 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -59,8 +59,6 @@ #define SIU_INT_SCC3		((uint)0x2a+CPM_IR
 #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
 
 void m82xx_pci_init_irq(void);
-void mpc82xx_ads_show_cpuinfo(struct seq_file*);
-void m82xx_calibrate_decr(void);
 
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/mpc8260.h
b/include/asm-powerpc/mpc8260.h
index e0d4807..e058e9e 100644
--- a/include/asm-powerpc/mpc8260.h
+++ b/include/asm-powerpc/mpc8260.h
@@ -19,6 +19,11 @@ #ifdef CONFIG_PCI_8260
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
