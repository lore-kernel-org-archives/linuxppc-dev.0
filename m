Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfR5c3lzDqvt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:35 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBfK6p4wz9sCY
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:28 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 30/41] powerpc: Get rid of ppc_md.init_early()
Date: Tue,  5 Jul 2016 15:04:06 +1000
Message-Id: <1467695057-12431-31-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is now called right after platform probe, so the probe function
can just do the job.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h            |  1 -
 arch/powerpc/kernel/setup_32.c                |  3 ---
 arch/powerpc/kernel/setup_64.c                |  8 --------
 arch/powerpc/platforms/512x/mpc5121_ads.c     |  8 ++++++--
 arch/powerpc/platforms/512x/mpc512x_generic.c |  8 ++++++--
 arch/powerpc/platforms/512x/pdm360ng.c        |  8 ++++++--
 arch/powerpc/platforms/chrp/setup.c           |  5 +++--
 arch/powerpc/platforms/embedded6xx/c2k.c      |  4 +++-
 arch/powerpc/platforms/embedded6xx/gamecube.c |  8 ++------
 arch/powerpc/platforms/embedded6xx/wii.c      |  8 ++------
 arch/powerpc/platforms/maple/setup.c          | 15 ++-------------
 arch/powerpc/platforms/pasemi/setup.c         |  8 ++------
 arch/powerpc/platforms/powermac/setup.c       |  5 +++--
 arch/powerpc/platforms/powernv/setup.c        |  5 +++--
 arch/powerpc/platforms/pseries/setup.c        |  9 +++++----
 15 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 62b1461..29bc9a3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -53,7 +53,6 @@ struct machdep_calls {
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
-	void		(*init_early)(void);
 	/* Optional, may be NULL. */
 	void		(*show_cpuinfo)(struct seq_file *m);
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index e7bb4e7..22347e87 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -263,9 +263,6 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_power_save();
 
-	if (ppc_md.init_early)
-		ppc_md.init_early();
-
 	find_legacy_serial_ports();
 
 	smp_setup_cpu_maps();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index cefe985..a49cb17 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -509,14 +509,6 @@ void __init setup_system(void)
 	/* Probe the machine type */
 	probe_machine();
 
-	/*
-	 * Do some platform specific early initializations, that includes
-	 * setting up the hash table pointers. It also sets up some interrupt-mapping
-	 * related options that will be used by finish_device_tree()
-	 */
-	if (ppc_md.init_early)
-		ppc_md.init_early();
-
  	/*
 	 * We can discover serial ports now since the above did setup the
 	 * hash table management for us, thus ioremap works. We do that early
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 4e03f04..f65d503 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -57,7 +57,12 @@ static void __init mpc5121_ads_init_IRQ(void)
  */
 static int __init mpc5121_ads_probe(void)
 {
-	return of_machine_is_compatible("fsl,mpc5121ads");
+	if (!of_machine_is_compatible("fsl,mpc5121ads"))
+		return 0;
+
+	mpc512x_init_early();
+
+	return 1;
 }
 
 define_machine(mpc5121_ads) {
@@ -65,7 +70,6 @@ define_machine(mpc5121_ads) {
 	.probe			= mpc5121_ads_probe,
 	.setup_arch		= mpc5121_ads_setup_arch,
 	.init			= mpc512x_init,
-	.init_early		= mpc512x_init_early,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index 87eba17..bf884d3 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -38,14 +38,18 @@ static const char * const board[] __initconst = {
  */
 static int __init mpc512x_generic_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	if (!of_device_compatible_match(of_root, board))
+		return 0;
+
+	mpc512x_init_early();
+
+	return 1;
 }
 
 define_machine(mpc512x_generic) {
 	.name			= "MPC512x generic",
 	.probe			= mpc512x_generic_probe,
 	.init			= mpc512x_init,
-	.init_early		= mpc512x_init_early,
 	.setup_arch		= mpc512x_setup_arch,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
index f9cad19..dc81f05 100644
--- a/arch/powerpc/platforms/512x/pdm360ng.c
+++ b/arch/powerpc/platforms/512x/pdm360ng.c
@@ -113,7 +113,12 @@ void __init pdm360ng_init(void)
 
 static int __init pdm360ng_probe(void)
 {
-	return of_machine_is_compatible("ifm,pdm360ng");
+	if (!of_machine_is_compatible("ifm,pdm360ng"))
+		return 0;
+
+	mpc512x_init_early();
+
+	return 1;
 }
 
 define_machine(pdm360ng) {
@@ -121,7 +126,6 @@ define_machine(pdm360ng) {
 	.probe			= pdm360ng_probe,
 	.setup_arch		= mpc512x_setup_arch,
 	.init			= pdm360ng_init,
-	.init_early		= mpc512x_init_early,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 987d1b8..4974fc3 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -253,7 +253,7 @@ static void briq_restart(char *cmd)
  * But unfortunately, the firmware does not connect /chosen/{stdin,stdout}
  * the the built-in serial node. Instead, a /failsafe node is created.
  */
-static __init void chrp_init_early(void)
+static __init void chrp_init(void)
 {
 	struct device_node *node;
 	const char *property;
@@ -587,6 +587,8 @@ static int __init chrp_probe(void)
 
 	pm_power_off = rtas_power_off;
 
+	chrp_init();
+
 	return 1;
 }
 
@@ -595,7 +597,6 @@ define_machine(chrp) {
 	.probe			= chrp_probe,
 	.setup_arch		= chrp_setup_arch,
 	.init			= chrp_init2,
-	.init_early		= chrp_init_early,
 	.show_cpuinfo		= chrp_show_cpuinfo,
 	.init_IRQ		= chrp_init_IRQ,
 	.restart		= rtas_restart,
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
index 45197b5..10a6445 100644
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -130,6 +130,9 @@ static int __init c2k_probe(void)
 
 	_set_L2CR(0);
 	_set_L2CR(L2CR_L2E | L2CR_L2PE | L2CR_L2I);
+
+	mv64x60_init_early();
+
 	return 1;
 }
 
@@ -137,7 +140,6 @@ define_machine(c2k) {
 	.name			= "C2K",
 	.probe			= c2k_probe,
 	.setup_arch		= c2k_setup_arch,
-	.init_early		= mv64x60_init_early,
 	.show_cpuinfo		= c2k_show_cpuinfo,
 	.init_IRQ		= mv64x60_init_irq,
 	.get_irq		= mv64x60_get_irq,
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index defcef8..18a2ba3 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -54,11 +54,6 @@ static void gamecube_halt(void)
 	gamecube_restart(NULL);
 }
 
-static void __init gamecube_init_early(void)
-{
-	ug_udbg_init();
-}
-
 static int __init gamecube_probe(void)
 {
 	if (!of_machine_is_compatible("nintendo,gamecube"))
@@ -66,6 +61,8 @@ static int __init gamecube_probe(void)
 
 	pm_power_off = gamecube_power_off;
 
+	ug_udbg_init();
+
 	return 1;
 }
 
@@ -77,7 +74,6 @@ static void gamecube_shutdown(void)
 define_machine(gamecube) {
 	.name			= "gamecube",
 	.probe			= gamecube_probe,
-	.init_early		= gamecube_init_early,
 	.restart		= gamecube_restart,
 	.halt			= gamecube_halt,
 	.init_IRQ		= flipper_pic_probe,
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index cc65d68..9676b09 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -192,11 +192,6 @@ static void wii_halt(void)
 	wii_spin();
 }
 
-static void __init wii_init_early(void)
-{
-	ug_udbg_init();
-}
-
 static void __init wii_pic_probe(void)
 {
 	flipper_pic_probe();
@@ -210,6 +205,8 @@ static int __init wii_probe(void)
 
 	pm_power_off = wii_power_off;
 
+	ug_udbg_init();
+
 	return 1;
 }
 
@@ -222,7 +219,6 @@ static void wii_shutdown(void)
 define_machine(wii) {
 	.name			= "wii",
 	.probe			= wii_probe,
-	.init_early		= wii_init_early,
 	.setup_arch		= wii_setup_arch,
 	.restart		= wii_restart,
 	.halt			= wii_halt,
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index a1ecbc9..98ae9f5 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -196,18 +196,6 @@ void __init maple_setup_arch(void)
 	mmio_nvram_init();
 }
 
-/* 
- * Early initialization.
- */
-static void __init maple_init_early(void)
-{
-	DBG(" -> maple_init_early\n");
-
-	iommu_init_early_dart(&maple_pci_controller_ops);
-
-	DBG(" <- maple_init_early\n");
-}
-
 /*
  * This is almost identical to pSeries and CHRP. We need to make that
  * code generic at one point, with appropriate bits in the device-tree to
@@ -304,6 +292,8 @@ static int __init maple_probe(void)
 
 	pm_power_off = maple_power_off;
 
+	iommu_init_early_dart(&maple_pci_controller_ops);
+
 	return 1;
 }
 
@@ -311,7 +301,6 @@ define_machine(maple) {
 	.name			= "Maple",
 	.probe			= maple_probe,
 	.setup_arch		= maple_setup_arch,
-	.init_early		= maple_init_early,
 	.init_IRQ		= maple_init_IRQ,
 	.pci_irq_fixup		= maple_pci_irq_fixup,
 	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 8f5e291..e7ad8a4 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -339,11 +339,6 @@ out:
 	return !!(srr1 & 0x2);
 }
 
-static void __init pas_init_early(void)
-{
-	iommu_init_early_pasemi();
-}
-
 #ifdef CONFIG_PCMCIA
 static int pcmcia_notify(struct notifier_block *nb, unsigned long action,
 			 void *data)
@@ -424,6 +419,8 @@ static int __init pas_probe(void)
 	    !of_machine_is_compatible("pasemi,pwrficient"))
 		return 0;
 
+	iommu_init_early_pasemi();
+
 	return 1;
 }
 
@@ -431,7 +428,6 @@ define_machine(pasemi) {
 	.name			= "PA Semi PWRficient",
 	.probe			= pas_probe,
 	.setup_arch		= pas_setup_arch,
-	.init_early		= pas_init_early,
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.restart		= pas_restart,
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 509b18f..3830582 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -450,7 +450,7 @@ pmac_halt(void)
 /* 
  * Early initialization.
  */
-static void __init pmac_init_early(void)
+static void __init pmac_init(void)
 {
 	/* Enable early btext debug if requested */
 	if (strstr(boot_command_line, "btextdbg")) {
@@ -601,6 +601,8 @@ static int __init pmac_probe(void)
 
 	pm_power_off = pmac_power_off;
 
+	pmac_init();
+
 	return 1;
 }
 
@@ -608,7 +610,6 @@ define_machine(powermac) {
 	.name			= "PowerMac",
 	.probe			= pmac_probe,
 	.setup_arch		= pmac_setup_arch,
-	.init_early		= pmac_init_early,
 	.show_cpuinfo		= pmac_show_cpuinfo,
 	.init_IRQ		= pmac_pic_init,
 	.get_irq		= NULL,	/* changed later */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ed99177..e8f7782 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -58,7 +58,7 @@ static void __init pnv_setup_arch(void)
 	/* XXX PMCS */
 }
 
-static void __init pnv_init_early(void)
+static void __init pnv_init(void)
 {
 	/*
 	 * Initialize the LPC bus now so that legacy serial
@@ -276,6 +276,8 @@ static int __init pnv_probe(void)
 
 	pr_debug("PowerNV detected !\n");
 
+	pnv_init();
+
 	return 1;
 }
 
@@ -301,7 +303,6 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
-	.init_early		= pnv_init_early,
 	.setup_arch		= pnv_setup_arch,
 	.init_IRQ		= pnv_init_IRQ,
 	.show_cpuinfo		= pnv_show_cpuinfo,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b883d0e..f6c0cb5 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -693,9 +693,9 @@ static void pSeries_cmo_feature_init(void)
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
-static void __init pSeries_init_early(void)
+static void __init pSeries_init(void)
 {
-	pr_debug(" -> pSeries_init_early()\n");
+	pr_debug(" -> pSeries_init()\n");
 
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
@@ -712,7 +712,7 @@ static void __init pSeries_init_early(void)
 	pSeries_cmo_feature_init();
 	iommu_init_early_pSeries();
 
-	pr_debug(" <- pSeries_init_early()\n");
+	pr_debug(" <- pSeries_init()\n");
 }
 
 /**
@@ -764,6 +764,8 @@ static int __init pSeries_probe(void)
 	pr_debug("Machine is%s LPAR !\n",
 	         (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
+	pSeries_init();
+
 	return 1;
 }
 
@@ -782,7 +784,6 @@ define_machine(pseries) {
 	.name			= "pSeries",
 	.probe			= pSeries_probe,
 	.setup_arch		= pSeries_setup_arch,
-	.init_early		= pSeries_init_early,
 	.show_cpuinfo		= pSeries_show_cpuinfo,
 	.log_error		= pSeries_log_error,
 	.pcibios_fixup		= pSeries_final_fixup,
-- 
2.7.4
