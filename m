Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F179767B59
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:44 +1000 (EST)
Date: Tue, 26 Sep 2006 13:36:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/7] [POWERPC] modify PCI code for a merged kernel
Message-Id: <20060926133651.897ad602.sfr@canb.auug.org.au>
In-Reply-To: <20060926133548.43afd711.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c         |   58 ++++++++++++++++++----------------
 arch/powerpc/platforms/iseries/pci.c |    4 --
 2 files changed, 30 insertions(+), 32 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index c1b1e14..78d3c0f 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -30,6 +30,7 @@ #include <asm/pci-bridge.h>
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
+#include <asm/firmware.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -209,7 +210,6 @@ void pcibios_free_controller(struct pci_
 		kfree(phb);
 }
 
-#ifndef CONFIG_PPC_ISERIES
 void __devinit pcibios_claim_one_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
@@ -238,10 +238,12 @@ static void __init pcibios_claim_of_setu
 {
 	struct pci_bus *b;
 
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return;
+
 	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
 }
-#endif
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
@@ -554,9 +556,8 @@ static int __init pcibios_init(void)
 	 */
 	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
 
-#ifdef CONFIG_PPC_ISERIES
-	iSeries_pcibios_init(); 
-#endif
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		iSeries_pcibios_init();
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
 
@@ -566,15 +567,15 @@ #endif
 		pci_bus_add_devices(hose->bus);
 	}
 
-#ifndef CONFIG_PPC_ISERIES
-	if (pci_probe_only)
-		pcibios_claim_of_setup();
-	else
-		/* FIXME: `else' will be removed when
-		   pci_assign_unassigned_resources() is able to work
-		   correctly with [partially] allocated PCI tree. */
-		pci_assign_unassigned_resources();
-#endif /* !CONFIG_PPC_ISERIES */
+	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
+		if (pci_probe_only)
+			pcibios_claim_of_setup();
+		else
+			/* FIXME: `else' will be removed when
+			   pci_assign_unassigned_resources() is able to work
+			   correctly with [partially] allocated PCI tree. */
+			pci_assign_unassigned_resources();
+	}
 
 	/* Call machine dependent final fixup */
 	if (ppc_md.pcibios_fixup)
@@ -586,8 +587,9 @@ #endif /* !CONFIG_PPC_ISERIES */
 		printk(KERN_DEBUG "ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-	/* map in PCI I/O space */
-	phbs_remap_io();
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		/* map in PCI I/O space */
+		phbs_remap_io();
 #endif
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
@@ -637,13 +639,13 @@ int pcibios_enable_device(struct pci_dev
  */
 int pci_domain_nr(struct pci_bus *bus)
 {
-#ifdef CONFIG_PPC_ISERIES
-	return 0;
-#else
-	struct pci_controller *hose = pci_bus_to_host(bus);
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+	else {
+		struct pci_controller *hose = pci_bus_to_host(bus);
 
-	return hose->global_number;
-#endif
+		return hose->global_number;
+	}
 }
 
 EXPORT_SYMBOL(pci_domain_nr);
@@ -651,12 +653,12 @@ EXPORT_SYMBOL(pci_domain_nr);
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
-#ifdef CONFIG_PPC_ISERIES
-	return 0;
-#else
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	return hose->buid;
-#endif
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+	else {
+		struct pci_controller *hose = pci_bus_to_host(bus);
+		return hose->buid;
+	}
 }
 
 /*
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 3eb1206..e904b36 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -262,10 +262,6 @@ void __init iSeries_pci_final_fixup(void
 	mf_display_src(0xC9000200);
 }
 
-void pcibios_fixup_bus(struct pci_bus *PciBus)
-{
-}
-
 void pcibios_fixup_resources(struct pci_dev *pdev)
 {
 }
-- 
1.4.2.1
