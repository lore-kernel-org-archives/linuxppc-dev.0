Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 0650ADDF7C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:56:57 +1000 (EST)
Message-ID: <46A10578.6030609@mvista.com>
Date: Fri, 20 Jul 2007 11:56:56 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/6] 85xxCDS: Misc 8548 PCI Corrections.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From cf18185b4e201ff45f2e2a948103dd3dc088c046 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Thu, 19 Jul 2007 10:40:53 -0700
Subject: [PATCH] 85xxCDS: Misc 8548 PCI Corrections.

Setting the host bridge @8000 as primary and only calling setup_pci_atmu
for the PCI Express host bridge. Also fixing a bug in setting the USB
interrupt numbers.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    8 ++++----
 arch/powerpc/sysdev/fsl_pci.c             |    3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 963c6f8..862f394 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -114,7 +114,7 @@ static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 		/* There are two USB controllers.
 		 * Identify them by functon number
 		 */
-			if (PCI_FUNC(dev->devfn))
+			if (PCI_FUNC(dev->devfn) == 3)
 				dev->irq = 11;
 			else
 				dev->irq = 10;
@@ -272,10 +272,10 @@ static void __init mpc85xx_cds_setup_arch(void)
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
 		struct resource rsrc;
 		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0x9000)
-			fsl_add_bridge(np, 0);
-		else
+		if ((rsrc.start & 0xfffff) == 0x8000)
 			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
 	}
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 2eefcde..931e212 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -195,7 +195,8 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	pci_process_bridge_OF_ranges(hose, dev, is_primary);
 
 	/* Setup PEX window registers */
-	setup_pci_atmu(hose, &rsrc);
+	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP))
+		setup_pci_atmu(hose, &rsrc);
 
 	return 0;
 }
-- 
1.5.2.2.549.gaeb59
