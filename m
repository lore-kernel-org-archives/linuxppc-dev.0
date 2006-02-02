Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D9ED68A8B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 06:59:07 +1100 (EST)
Date: Thu, 2 Feb 2006 13:51:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Lindent platforms/83xx
Message-ID: <Pine.LNX.4.44.0602021350450.13198-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ran arch/powerpc/platforms/83xx through Lindent

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 07128b4c47be22093a6c4a1972bae78994e2d11c
tree 0f81fd48006d8b92598cd23d89ab07910756711a
parent 3a37a9fa1aa28844651449eda0c31485ad202b01
author Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 13:48:35 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 13:48:35 -0600

 arch/powerpc/platforms/83xx/mpc834x_sys.c |   31 +++++++++++++----------------
 arch/powerpc/platforms/83xx/mpc834x_sys.h |    2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h     |    2 +-
 arch/powerpc/platforms/83xx/pci.c         |    8 ++++---
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 7d5a278..7c18b4c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -69,15 +69,14 @@ mpc83xx_map_irq(struct pci_dev *dev, uns
 	const long min_idsel = 0x11, max_idsel = 0x20, irqs_per_slot = 4;
 	return PCI_IRQ_TABLE_LOOKUP;
 }
-#endif /* CONFIG_PCI */
+#endif				/* CONFIG_PCI */
 
 /* ************************************************************************
  *
  * Setup the architecture
  *
  */
-static void __init
-mpc834x_sys_setup_arch(void)
+static void __init mpc834x_sys_setup_arch(void)
 {
 	struct device_node *np;
 
@@ -86,14 +85,14 @@ mpc834x_sys_setup_arch(void)
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np != 0) {
-		unsigned int *fp = (int *) get_property(np, "clock-frequency", NULL);
+		unsigned int *fp =
+		    (int *)get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
 			loops_per_jiffy = 50000000 / HZ;
 		of_node_put(np);
 	}
-
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
@@ -104,14 +103,13 @@ mpc834x_sys_setup_arch(void)
 #endif
 
 #ifdef  CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
+	ROOT_DEV = Root_NFS;
 #else
-		ROOT_DEV = Root_HDA1;
+	ROOT_DEV = Root_HDA1;
 #endif
 }
 
-void __init
-mpc834x_sys_init_IRQ(void)
+void __init mpc834x_sys_init_IRQ(void)
 {
 	u8 senses[8] = {
 		0,			/* EXT 0 */
@@ -140,28 +138,27 @@ mpc834x_sys_init_IRQ(void)
 }
 
 #if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong	ds1374_get_rtc_time(void);
-extern int	ds1374_set_rtc_time(ulong);
+extern ulong ds1374_get_rtc_time(void);
+extern int ds1374_set_rtc_time(ulong);
 
-static int __init
-mpc834x_rtc_hookup(void)
+static int __init mpc834x_rtc_hookup(void)
 {
-	struct timespec	tv;
+	struct timespec tv;
 
 	ppc_md.get_rtc_time = ds1374_get_rtc_time;
 	ppc_md.set_rtc_time = ds1374_set_rtc_time;
 
 	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time)();
+	tv.tv_sec = (ppc_md.get_rtc_time) ();
 	do_settimeofday(&tv);
 
 	return 0;
 }
+
 late_initcall(mpc834x_rtc_hookup);
 #endif
 
-void __init
-platform_init(void)
+void __init platform_init(void)
 {
 	/* setup the PowerPC module struct */
 	ppc_md.setup_arch = mpc834x_sys_setup_arch;
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/powerpc/platforms/83xx/mpc834x_sys.h
index e4ca39f..fedecb7 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
@@ -20,4 +20,4 @@
 #define PIRQC	MPC83xx_IRQ_EXT6
 #define PIRQD	MPC83xx_IRQ_EXT7
 
-#endif                /* __MACH_MPC83XX_SYS_H__ */
+#endif				/* __MACH_MPC83XX_SYS_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 228d5c4..01cae10 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -14,4 +14,4 @@ extern int mpc83xx_exclude_device(u_char
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 
-#endif /* __MPC83XX_H__ */
+#endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 70e28fc..16f7d3b 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -61,7 +61,7 @@ int __init add_bridge(struct device_node
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = (int *)get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
@@ -83,7 +83,7 @@ int __init add_bridge(struct device_node
 	if ((rsrc.start & 0xfffff) == 0x8500) {
 		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304);
 	}
-	/* PCI 2*/
+	/* PCI 2 */
 	if ((rsrc.start & 0xfffff) == 0x8600) {
 		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384);
 		primary = 0;
@@ -93,10 +93,10 @@ int __init add_bridge(struct device_node
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%08lx. "
 	       "Firmware bus number: %d->%d\n",
-		rsrc.start, hose->first_busno, hose->last_busno);
+	       rsrc.start, hose->first_busno, hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
+	    hose, hose->cfg_addr, hose->cfg_data);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
