Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 306D9DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:16 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/22] [POWERPC] 85xx: Clean up from 85xx_ds rename
Date: Thu, 13 Sep 2007 16:07:41 -0500
Message-Id: <11897176841013-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1189717683471-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Renamed functions in 85xx_ds from 8544 to 85xx.

Kept an unique machine def/probe for the MPC8544 DS board to
handle some subtle differences between the future board based
on the DS platform.

Also fixed building w/o CONFIG_PCI and minor whitespace fixes.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   36 ++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 48983bc..3a5c3c4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -1,5 +1,5 @@
 /*
- * MPC8544 DS Board Setup
+ * MPC85xx DS Board Setup
  *
  * Author Xianghua Xiao (x.xiao@freescale.com)
  * Roy Zang <tie-fei.zang@freescale.com>
@@ -44,7 +44,7 @@
 #endif
 
 #ifdef CONFIG_PPC_I8259
-static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq = i8259_irq();
 
@@ -55,7 +55,7 @@ static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
 }
 #endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc8544_ds_pic_init(void)
+void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
 	struct resource r;
@@ -104,16 +104,17 @@ void __init mpc8544_ds_pic_init(void)
 		return;
 	}
 
-	DBG("mpc8544ds: cascade mapped to irq %d\n", cascade_irq);
+	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
 
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
 
-	set_irq_chained_handler(cascade_irq, mpc8544_8259_cascade);
+	set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);
 #endif	/* CONFIG_PPC_I8259 */
 }
 
 #ifdef CONFIG_PCI
+static int primary_phb_addr;
 extern int uses_fsl_uli_m1575;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
@@ -121,13 +122,13 @@ extern int uli_exclude_device(struct pci_controller *hose,
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	struct device_node* node;	
+	struct device_node* node;
 	struct resource rsrc;
 
 	node = (struct device_node *)hose->arch_data;
 	of_address_to_resource(node, 0, &rsrc);
 
-	if ((rsrc.start & 0xfffff) == 0xb000) {
+	if ((rsrc.start & 0xfffff) == primary_phb_addr) {
 		return uli_exclude_device(hose, bus, devfn);
 	}
 
@@ -138,20 +139,20 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 /*
  * Setup the architecture
  */
-static void __init mpc8544_ds_setup_arch(void)
+static void __init mpc85xx_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
 
 	if (ppc_md.progress)
-		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
+		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
 		struct resource rsrc;
 		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0xb000)
+		if ((rsrc.start & 0xfffff) == primary_phb_addr)
 			fsl_add_bridge(np, 1);
 		else
 			fsl_add_bridge(np, 0);
@@ -160,7 +161,7 @@ static void __init mpc8544_ds_setup_arch(void)
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-	printk("MPC8544 DS board from Freescale Semiconductor\n");
+	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
 /*
@@ -170,14 +171,21 @@ static int __init mpc8544_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "MPC8544DS");
+	if (of_flat_dt_is_compatible(root, "MPC8544DS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xb000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
 }
 
 define_machine(mpc8544_ds) {
 	.name			= "MPC8544 DS",
 	.probe			= mpc8544_ds_probe,
-	.setup_arch		= mpc8544_ds_setup_arch,
-	.init_IRQ		= mpc8544_ds_pic_init,
+	.setup_arch		= mpc85xx_ds_setup_arch,
+	.init_IRQ		= mpc85xx_ds_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-- 
1.5.2.4
