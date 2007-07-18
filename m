Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03E5BDEF2A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1ZjO5019113
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:45 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZiqT001510
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:44 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B3hI007932
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:03 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 88C31AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:43 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZhUh015391
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:43 -0500
Date: Tue, 17 Jul 2007 20:35:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 33/61] mpc82xx: Remove a bunch of cruft that duplicates
	generic functionality.
Message-ID: <20070718013543.GE15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/mpc8272ads.c |   37 ++------------
 arch/powerpc/platforms/82xx/mpc82xx.c    |   76 +-----------------------------
 arch/powerpc/platforms/82xx/pq2ads.h     |    5 --
 3 files changed, 7 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index cd14a48..b23fa73 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -11,42 +11,21 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/fs_enet_pd.h>
 
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
 #include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc8260.h>
-#include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <platforms/82xx/pq2.h>
-#include <asm/prom.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
-#include <linux/fs_enet_pd.h>
+#include <asm/time.h>
+
+#include <platforms/82xx/pq2.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
@@ -584,12 +563,6 @@ static void __init mpc8272ads_setup_arch(void)
 	of_node_put(np);
 #endif
 
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8272ads_setup_arch(), finish", 0);
 }
@@ -611,7 +584,7 @@ define_machine(mpc8272ads)
 	.init_IRQ = mpc8272ads_pic_init,
 	.show_cpuinfo = m82xx_show_cpuinfo,
 	.get_irq = cpm2_get_irq,
-	.calibrate_decr = m82xx_calibrate_decr,
+	.calibrate_decr = generic_calibrate_decr,
 	.restart = pq2_restart,
 	.halt = pq2_halt,
 };
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index a2a9c8d..1d3d0e9 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -11,82 +11,10 @@
  * option) any later version.
  */
 
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
 #include <linux/seq_file.h>
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
-#include <asm/bootinfo.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpc8260.h>
-#include <asm/irq.h>
 #include <mm/mmu_decl.h>
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
+#include <asm/machdep.h>
+#include <asm/system.h>
 
 void m82xx_show_cpuinfo(struct seq_file *m)
 {
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 4802292..4546ce6 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -25,10 +25,6 @@
 #include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
-/* For our show_cpuinfo hooks. */
-#define CPUINFO_VENDOR		"Freescale Semiconductor"
-#define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
-
 /* Backword-compatibility stuff for the drivers */
 #define CPM_MAP_ADDR		((uint)0xf0000000)
 #define CPM_IRQ_OFFSET 0
@@ -60,7 +56,6 @@
 
 void m82xx_pci_init_irq(void);
 void m82xx_show_cpuinfo(struct seq_file *);
-void m82xx_calibrate_decr(void);
 
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
-- 
1.5.0.3
