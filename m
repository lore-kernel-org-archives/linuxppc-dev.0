Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AC09C67A75
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:10:12 +1000 (EST)
Date: Fri, 19 May 2006 16:54:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 08/14] powerpc: clean up iSeries PCI probe
Message-Id: <20060519165442.75e40d7c.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
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


Only scan the host bridges and then use the existing pci_devs_phb_init()
routine.

Also fix typo in setup of reg property.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/pci_dn.c           |    6 +++++
 arch/powerpc/platforms/iseries/pci.c   |   42 +++++++++++---------------------
 arch/powerpc/platforms/iseries/setup.c |    2 +-
 3 files changed, 21 insertions(+), 29 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

979e33e7df3519bb4bbc550ad7e52b5ad2b30221
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 12c4c9e..1c18953 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -31,6 +31,7 @@ #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/ppc-pci.h>
+#include <asm/firmware.h>
 
 /*
  * Traverse_func that inits the PCI fields of the device node.
@@ -59,6 +60,11 @@ static void * __devinit update_dn_pci_in
 		pdn->busno = (regs[0] >> 16) & 0xff;
 		pdn->devfn = (regs[0] >> 8) & 0xff;
 	}
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		u32 *busp = (u32 *)get_property(dn, "linux,subbus", NULL);
+		if (busp)
+			pdn->bussubno = *busp;
+	}
 
 	pdn->pci_ext_config_space = (type && *type == 1);
 	return NULL;
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 86a8698..35bcc98 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -166,13 +166,21 @@ static void pci_Log_Error(char *Error_Te
 void iSeries_pcibios_init(void)
 {
 	struct pci_controller *phb;
-	struct device_node *node;
-	struct device_node *dn;
+	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *node = NULL;
 
-	for_each_node_by_type(node, "pci") {
+	if (root == NULL) {
+		printk(KERN_CRIT "iSeries_pcibios_init: can't find root "
+				"of device tree\n");
+		return;
+	}
+	while ((node = of_get_next_child(root, node)) != NULL) {
 		HvBusNumber bus;
 		u32 *busp;
 
+		if ((node->type == NULL) || (strcmp(node->type, "pci") != 0))
+			continue;
+
 		busp = (u32 *)get_property(node, "bus-range", NULL);
 		if (busp == NULL)
 			continue;
@@ -186,33 +194,11 @@ void iSeries_pcibios_init(void)
 		phb->first_busno = bus;
 		phb->last_busno = bus;
 		phb->ops = &iSeries_pci_ops;
+	}
 
-		/* Find and connect the devices. */
-		for (dn = NULL; (dn = of_get_next_child(node, dn)) != NULL;) {
-			struct pci_dn *pdn;
-			u32 *reg;
-
-			reg = (u32 *)get_property(dn, "reg", NULL);
-			if (reg == NULL) {
-				printk(KERN_DEBUG "no reg property!\n");
-				continue;
-			}
-			busp = (u32 *)get_property(dn, "linux,subbus", NULL);
-			if (busp == NULL) {
-				printk(KERN_DEBUG "no subbus property!\n");
-				continue;
-			}
+	of_node_put(root);
 
-			pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
-			if (pdn == NULL)
-				return;
-			dn->data = pdn;
-			pdn->node = dn;
-			pdn->busno = bus;
-			pdn->devfn = (reg[0] >> 8) & 0xff;
-			pdn->bussubno = *busp;
-		}
-	}
+	pci_devs_phb_init();
 }
 
 /*
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index d83f5ed..0f49412 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -1073,7 +1073,7 @@ static void scan_bridge_slot(struct iser
 				snprintf(buf, sizeof(buf), "pci@%x,%d",
 						PCI_SLOT(devfn), function);
 			dt_start_node(dt, buf);
-			reg[0] = (bus << 18) | (devfn << 8);
+			reg[0] = (bus << 16) | (devfn << 8);
 			reg[1] = 0;
 			reg[2] = 0;
 			reg[3] = 0;
-- 
1.3.1.ge923
