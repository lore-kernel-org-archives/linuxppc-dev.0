Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18AECDEFB2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1Zn3a019132
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:49 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Zm5S001532
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:48 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B7II007941
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:07 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 9C950AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:47 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zl6R015404
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:47 -0500
Date: Tue, 17 Jul 2007 20:35:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 36/61] mpc82xx: Factor PCI init out of mpc8272ads.
Message-ID: <20070718013547.GH15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/dts/mpc8272ads.dts     |    3 +-
 arch/powerpc/boot/dts/mpc8560ads.dts     |    2 +-
 arch/powerpc/platforms/82xx/mpc8272ads.c |   86 ++---------------------------
 arch/powerpc/platforms/82xx/pq2.c        |   44 +++++++++++++++
 arch/powerpc/platforms/82xx/pq2.h        |    7 +++
 arch/powerpc/platforms/82xx/pq2ads.h     |    1 -
 6 files changed, 59 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 8c69cd0..ae52ada 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -161,8 +161,7 @@
 			interrupt-controller;
 			reg = <10c00 80>;
 			built-in;
-			device_type = "cpm-pic";
-			compatible = "CPM2";
+			compatible = "fsl,pq2-pic";
 		};
 
 		pci@0500 {
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1626587..847a095 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -249,7 +249,7 @@
 				interrupt-parent = <&mpic>;
 				reg = <90c00 80>;
 				built-in;
-				device_type = "cpm-pic";
+				compatible = "fsl,pq2-pic";
 			};
 
 			scc@91a00 {
diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index e5b7a0f..388b090 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -18,11 +18,12 @@
 #include <linux/fs_enet_pd.h>
 
 #include <asm/io.h>
-#include <asm/pci-bridge.h>
 #include <asm/mpc8260.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
 #include <asm/time.h>
 
 #include <platforms/82xx/pq2.h>
@@ -35,29 +36,15 @@
 
 static void __init mpc8272ads_pic_init(void)
 {
-	struct device_node *np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
-	struct resource r;
-	cpm2_map_t *cpm_reg;
-
-	if (np == NULL) {
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	if (!np) {
 		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
 		return;
 	}
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "PIC init: invalid resource\n");
-		of_node_put(np);
-		return;
-	}
+
 	cpm2_pic_init(np);
 	of_node_put(np);
 
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	cpm_reg = (cpm2_map_t *) ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	cpm_reg->im_intctl.ic_siprr = 0x05309770;
-	iounmap(cpm_reg);
-
 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
 	pq2ads_pci_init_irq();
 }
@@ -302,67 +289,12 @@ void __init mpc8272ads_board_setup(void)
 	iounmap(immap);
 }
 
-#ifdef CONFIG_PCI
-static int m82xx_pci_exclude_device(struct pci_controller *hose,
-				    u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-
-static void __init mpc82xx_add_bridge(struct device_node *np)
-{
-	int len;
-	struct pci_controller *hose;
-	struct resource r;
-	const int *bus_range;
-	const uint *ptr;
-
-	memset(&r, 0, sizeof(r));
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_INFO "No PCI reg property in device tree\n");
-		return;
-	}
-	if (!(ptr = of_get_property(np, "clock-frequency", NULL))) {
-		printk(KERN_INFO "No clock-frequency property in PCI node");
-		return;
-	}
-	of_node_put(np);
-	bus_range = of_get_property(np, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-		       " bus 0\n", np->full_name);
-	}
-
-	pci_assign_all_buses = 1;
-
-	hose = pcibios_alloc_controller(np);
-
-	if (!hose)
-		return;
-
-	hose->first_busno = bus_range ? bus_range[0] : 0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-
-	setup_indirect_pci(hose,
-			   r.start + offsetof(pci_cpm2_t, pci_cfg_addr),
-			   r.start + offsetof(pci_cpm2_t, pci_cfg_data));
-
-	pci_process_bridge_OF_ranges(hose, np, 1);
-}
-#endif
 
 /*
  * Setup the architecture
  */
 static void __init mpc8272ads_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8272ads_setup_arch()", 0);
 	cpm2_reset();
@@ -371,13 +303,7 @@ static void __init mpc8272ads_setup_arch(void)
 
 	mpc8272ads_board_setup();
 
-#ifdef CONFIG_PCI
-	ppc_md.pci_exclude_device = m82xx_pci_exclude_device;
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc82xx_add_bridge(np);
-
-	of_node_put(np);
-#endif
+	pq2_init_pci();
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8272ads_setup_arch(), finish", 0);
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index e58980d..76df8d7 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -16,6 +16,7 @@
 
 #include <asm/cpm2.h>
 #include <asm/io.h>
+#include <asm/pci-bridge.h>
 #include <asm/system.h>
 
 #include <platforms/82xx/pq2.h>
@@ -42,3 +43,46 @@ void pq2_halt(void)
 	while (1)
 		;
 }
+
+#ifdef CONFIG_PCI
+static int pq2_pci_exclude_device(struct pci_controller *hose,
+                                  u_char bus, u8 devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static void __init pq2_pci_add_bridge(struct device_node *np)
+{
+	struct pci_controller *hose;
+	struct resource r;
+
+	if (of_address_to_resource(np, 0, &r) || r.end - r.start < 0x10b) {
+		printk(KERN_ERR "No valid PCI reg property in device tree\n");
+		return;
+	}
+
+	pci_assign_all_buses = 1;
+
+	hose = pcibios_alloc_controller(np);
+	if (!hose)
+		return;
+
+	hose->arch_data = np;
+
+	setup_indirect_pci(hose, r.start + 0x100, r.start + 0x104);
+	pci_process_bridge_OF_ranges(hose, np, 1);
+}
+
+void __init pq2_init_pci(void)
+{
+	struct device_node *np = NULL;
+
+	ppc_md.pci_exclude_device = pq2_pci_exclude_device;
+
+	while ((np = of_find_compatible_node(np, NULL, "fsl,pq2-pci")))
+		pq2_pci_add_bridge(np);
+}
+#endif
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
index 6bce391..4de5b06 100644
--- a/arch/powerpc/platforms/82xx/pq2.h
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -3,14 +3,21 @@
 
 void pq2_restart(char *cmd);
 void pq2_halt(void);
+int pq2ads_pci_init_irq(void);
+void pq2_init_pci(void);
 
 #ifdef CONFIG_PCI
 int pq2ads_pci_init_irq(void);
+void pq2_init_pci(void);
 #else
 static inline int pq2ads_pci_init_irq(void)
 {
 	return 0;
 }
+
+static inline void pq2_init_pci(void)
+{
+}
 #endif
 
 #endif
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 4546ce6..482153a 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -54,7 +54,6 @@
 #define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
 #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
 
-void m82xx_pci_init_irq(void);
 void m82xx_show_cpuinfo(struct seq_file *);
 
 #endif /* __MACH_ADS8260_DEFS */
-- 
1.5.0.3
