Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDDF5100802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 09:50:17 +1000 (EST)
Date: Wed, 27 Jun 2012 18:50:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/mpc85xx_ds: convert to unified PCI init
Message-ID: <20120627235007.GC9100@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120627234851.GA9071@tyr.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to how the primary PCI bridge is identified by looking
for an isa subnode, we determine whether to apply uli exclusions
by looking for a uli subnode.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Besides being an example of a real-hardware board to use the new PCI init
(probably one of the more complicated examples due to the uli device
exclusion), this fixes PCI under QEMU's mpc8544ds machine.  QEMU was
only creating one PCI bus, and it wasn't the one Linux had arbitrarily
deemed primary for mpc8544ds (AFAIK, there's no legacy ISA on this
board).

Tested with QEMU mpc8544ds, and real-hardware mpc8572ds (with uli).

 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   97 +++++++++---------------------
 1 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 1fd91e9..6d3265f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -114,71 +114,53 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-static int primary_phb_addr;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
+static struct device_node *pci_with_uli;
+
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	struct device_node* node;
-	struct resource rsrc;
-
-	node = hose->dn;
-	of_address_to_resource(node, 0, &rsrc);
-
-	if ((rsrc.start & 0xfffff) == primary_phb_addr) {
+	if (hose->dn == pci_with_uli)
 		return uli_exclude_device(hose, bus, devfn);
-	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 #endif	/* CONFIG_PCI */
 
-/*
- * Setup the architecture
- */
-static void __init mpc85xx_ds_setup_arch(void)
+static void __init mpc85xx_ds_pci_init(void)
 {
 #ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
+	struct device_node *node;
 
-	if (ppc_md.progress)
-		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
+	fsl_pci_init();
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
-		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+	/* See if we have a ULI under the primary */
+
+	node = of_find_node_by_name(NULL, "uli1575");
+	while ((pci_with_uli = of_get_parent(node))) {
+		of_node_put(node);
+		node = pci_with_uli;
+
+		if (pci_with_uli == fsl_pci_primary) {
+			ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+			break;
 		}
 	}
-
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
+}
 
-	mpc85xx_smp_init();
+/*
+ * Setup the architecture
+ */
+static void __init mpc85xx_ds_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	mpc85xx_ds_pci_init();
+	mpc85xx_smp_init();
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
@@ -190,14 +172,7 @@ static int __init mpc8544_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "MPC8544DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0xb000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return !!of_flat_dt_is_compatible(root, "MPC8544DS");
 }
 
 machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
@@ -215,14 +190,7 @@ static int __init mpc8572_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x8000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return !!of_flat_dt_is_compatible(root, "fsl,MPC8572DS");
 }
 
 /*
@@ -232,14 +200,7 @@ static int __init p2020_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,P2020DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x9000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return !!of_flat_dt_is_compatible(root, "fsl,P2020DS");
 }
 
 define_machine(mpc8544_ds) {
-- 
1.7.5.4
