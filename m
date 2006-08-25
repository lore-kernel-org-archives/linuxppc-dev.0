Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5A7BA67C5F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 02:59:31 +1000 (EST)
Date: Fri, 25 Aug 2006 11:59:22 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] modify mpc83xx platforms to use new IRQ layer
Message-Id: <20060825115922.12426d15.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes MPC834x MDS (formerly SYS) and ITX platform code to get IRQ data (including PCI) from the device tree, and to use the new IPIC code.

renamed defconfig (sys -> mds), left one redundant NULL assignment in mpc83xx_pcibios_fixup to keep the compiler happy.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>

---

please apply to 2.6.18

 ...mpc834x_sys_defconfig => mpc834x_mds_defconfig} |    0 
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |   49 +++---------------
 arch/powerpc/platforms/83xx/mpc834x_sys.c          |   56 +++-----------------
 arch/powerpc/platforms/83xx/mpc83xx.h              |    1 
 arch/powerpc/platforms/83xx/pci.c                  |    9 +++
 5 files changed, 28 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/configs/mpc834x_sys_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc834x_sys_defconfig
rename to arch/powerpc/configs/mpc834x_mds_defconfig
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index d9675f9..969fbb6 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -46,26 +46,6 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
-#ifdef CONFIG_PCI
-static int
-mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	static char pci_irq_table[][4] =
-	    /*
-	     *      PCI IDSEL/INTPIN->INTLINE
-	     *       A      B      C      D
-	     */
-	{
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* idsel 0x0e */
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x0f */
-		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x10 */
-	};
-
-	const long min_idsel = 0x0e, max_idsel = 0x10, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP;
-}
-#endif				/* CONFIG_PCI */
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -92,8 +72,6 @@ #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc83xx_map_irq;
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
@@ -106,25 +84,13 @@ #endif
 
 void __init mpc834x_itx_init_IRQ(void)
 {
-	u8 senses[8] = {
-		0,			/* EXT 0 */
-		IRQ_SENSE_LEVEL,	/* EXT 1 */
-		IRQ_SENSE_LEVEL,	/* EXT 2 */
-		0,			/* EXT 3 */
-#ifdef CONFIG_PCI
-		IRQ_SENSE_LEVEL,	/* EXT 4 */
-		IRQ_SENSE_LEVEL,	/* EXT 5 */
-		IRQ_SENSE_LEVEL,	/* EXT 6 */
-		IRQ_SENSE_LEVEL,	/* EXT 7 */
-#else
-		0,			/* EXT 4 */
-		0,			/* EXT 5 */
-		0,			/* EXT 6 */
-		0,			/* EXT 7 */
-#endif
-	};
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
 
-	ipic_init(get_immrbase() + 0x00700, 0, 0, senses, 8);
+	ipic_init(np, 0);
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
@@ -153,4 +119,7 @@ define_machine(mpc834x_itx) {
 	.time_init		= mpc83xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup		= mpc83xx_pcibios_fixup,
+#endif
 };
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 5eadf9d..6771961 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -43,33 +43,6 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
-#ifdef CONFIG_PCI
-static int
-mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	static char pci_irq_table[][4] =
-	    /*
-	     *      PCI IDSEL/INTPIN->INTLINE
-	     *       A      B      C      D
-	     */
-	{
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x11 */
-		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x12 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},	/* idsel 0x13 */
-		{0, 0, 0, 0},
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x15 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},	/* idsel 0x16 */
-		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x17 */
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* idsel 0x18 */
-		{0, 0, 0, 0},			/* idsel 0x19 */
-		{0, 0, 0, 0},			/* idsel 0x20 */
-	};
-
-	const long min_idsel = 0x11, max_idsel = 0x20, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP;
-}
-#endif				/* CONFIG_PCI */
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -96,8 +69,6 @@ #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc83xx_map_irq;
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
@@ -110,25 +81,13 @@ #endif
 
 void __init mpc834x_sys_init_IRQ(void)
 {
-	u8 senses[8] = {
-		0,			/* EXT 0 */
-		IRQ_SENSE_LEVEL,	/* EXT 1 */
-		IRQ_SENSE_LEVEL,	/* EXT 2 */
-		0,			/* EXT 3 */
-#ifdef CONFIG_PCI
-		IRQ_SENSE_LEVEL,	/* EXT 4 */
-		IRQ_SENSE_LEVEL,	/* EXT 5 */
-		IRQ_SENSE_LEVEL,	/* EXT 6 */
-		IRQ_SENSE_LEVEL,	/* EXT 7 */
-#else
-		0,			/* EXT 4 */
-		0,			/* EXT 5 */
-		0,			/* EXT 6 */
-		0,			/* EXT 7 */
-#endif
-	};
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
 
-	ipic_init(get_immrbase() + 0x00700, 0, 0, senses, 8);
+	ipic_init(np, 0);
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
@@ -178,4 +137,7 @@ define_machine(mpc834x_sys) {
 	.time_init		= mpc83xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup		= mpc83xx_pcibios_fixup,
+#endif
 };
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 01cae10..2c82bca 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -11,6 +11,7 @@ #include <linux/device.h>
 
 extern int add_bridge(struct device_node *dev);
 extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
+extern void mpc83xx_pcibios_fixup(void);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 9c36505..4557ac5 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -45,6 +45,15 @@ int mpc83xx_exclude_device(u_char bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
+void __init mpc83xx_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	/* map all the PCI irqs */
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
+
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
-- 
1.4.1
