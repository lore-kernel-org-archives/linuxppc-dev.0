Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B5E77DDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:28 +1000 (EST)
Message-Id: <20070612163751.979776796@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:28 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 12/13] powerpc: fix building without PCI
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some code looks can be configured to be built without
PCI support, but does not work properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/52xx/efika.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/efika.c
+++ linux-2.6/arch/powerpc/platforms/52xx/efika.c
@@ -252,6 +252,8 @@ define_machine(efika)
 	.progress		= rtas_progress,
 	.get_boot_time		= rtas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
+#ifdef CONFIG_PCI
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
+#endif
 };
 
Index: linux-2.6/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6/arch/powerpc/platforms/chrp/setup.c
@@ -80,6 +80,7 @@ static unsigned int __iomem *briq_SPOR;
 extern struct smp_ops_t chrp_smp_ops;
 #endif
 
+#ifdef CONFIG_PCI
 static const char *gg2_memtypes[4] = {
 	"FPM", "SDRAM", "EDO", "BEDO"
 };
@@ -93,6 +94,7 @@ static const char *gg2_cachetypes[4] = {
 static const char *gg2_cachemodes[4] = {
 	"Disabled", "Write-Through", "Copy-Back", "Transparent Mode"
 };
+#endif
 
 static const char *chrp_names[] = {
 	"Unknown",
@@ -105,8 +107,6 @@ static const char *chrp_names[] = {
 
 void chrp_show_cpuinfo(struct seq_file *m)
 {
-	int i, sdramen;
-	unsigned int t;
 	struct device_node *root;
 	const char *model = "";
 
@@ -115,8 +115,11 @@ void chrp_show_cpuinfo(struct seq_file *
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 
+#ifdef CONFIG_PCI
 	/* longtrail (goldengate) stuff */
 	if (!strncmp(model, "IBM,LongTrail", 13)) {
+		int i, sdramen;
+		unsigned int t;
 		/* VLSI VAS96011/12 `Golden Gate 2' */
 		/* Memory banks */
 		sdramen = (in_le32(gg2_pci_config_base + GG2_PCI_DRAM_CTRL)
@@ -160,6 +163,7 @@ void chrp_show_cpuinfo(struct seq_file *
 			   gg2_cachetypes[(t>>2) & 3],
 			   gg2_cachemodes[t & 3]);
 	}
+#endif
 	of_node_put(root);
 }
 
@@ -304,6 +308,7 @@ void __init chrp_setup_arch(void)
 	/* On pegasos, enable the L2 cache if not already done by OF */
 	pegasos_set_l2cr();
 
+#ifdef CONFIG_PCI
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
 
@@ -312,13 +317,16 @@ void __init chrp_setup_arch(void)
 	 *  -- Geert
 	 */
 	hydra_init();		/* Mac I/O */
+#endif
 
 	/*
 	 *  Fix the Super I/O configuration
 	 */
 	sio_init();
 
+#ifdef CONFIG_PCI
 	pci_create_OF_bus_map();
+#endif
 
 	/*
 	 * Print the banner, then scroll down so boot progress
@@ -614,5 +622,7 @@ define_machine(chrp) {
 	.set_rtc_time		= chrp_set_rtc_time,
 	.get_rtc_time		= chrp_get_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
+#ifdef CONFIG_PCI
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
+#endif
 };
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -56,6 +56,7 @@ static struct mtd_partition linkstation_
 
 static int __init linkstation_add_bridge(struct device_node *dev)
 {
+#ifdef CONFIG_PCI
 	int len;
 	struct pci_controller *hose;
 	const int *bus_range;
@@ -78,7 +79,7 @@ static int __init linkstation_add_bridge
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
 	pci_process_bridge_OF_ranges(hose, dev, 1);
-
+#endif
 	return 0;
 }
 
Index: linux-2.6/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6/arch/powerpc/sysdev/Makefile
@@ -6,7 +6,7 @@ mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_m
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
-obj-$(CONFIG_PPC_MPC106)	+= grackle.o
+pci-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
 obj-$(CONFIG_PPC_PMI)		+= pmi.o
@@ -14,10 +14,13 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
-obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
+obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_dev.o
+pci-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
-mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
+pci-$(CONFIG_MV64X60)		+= mv64x60_pci.o
+
+obj-$(CONFIG_PCI)		+= $(pci-y)
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o

--
