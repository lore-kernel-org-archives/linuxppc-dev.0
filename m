Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 0B2E6DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 09:32:58 +1000 (EST)
Message-ID: <46B11823.9050600@mvista.com>
Date: Wed, 01 Aug 2007 16:32:51 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] 85xxCDS: Delete the PCI exclude function.
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 8367fd9e98a97ba680d23bf59fa03fcd930dd9e1 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Wed, 1 Aug 2007 16:24:48 -0700
Subject: [PATCH] 85xxCDS: Delete the PCI exclude function.

Now that the FPGA on the 85xxCDS main board has a quirk, we no longer
need an exclude routine.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6a171e9..d7ee380 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -54,21 +54,6 @@ static volatile u8 *cadmus;
 
 #ifdef CONFIG_PCI
 
-#define ARCADIA_HOST_BRIDGE_IDSEL	17
-#define ARCADIA_2ND_BRIDGE_IDSEL	3
-
-static int mpc85xx_exclude_device(struct pci_controller *hose,
-				  u_char bus, u_char devfn)
-{
-	/* We explicitly do not go past the Tundra 320 Bridge */
-	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-
 static void mpc85xx_cds_restart(char *cmd)
 {
 	struct pci_dev *dev;
@@ -306,7 +291,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 			fsl_add_bridge(np, 0);
 	}
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
 
-- 
1.5.3.rc2.22.g69a9b
