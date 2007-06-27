Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9D9CDDF38
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/15] [POWERPC] Remove hack to determine the 2nd PHBs bus
	number
Date: Tue, 26 Jun 2007 20:16:34 -0500
Message-Id: <11829070102887-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070091056-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have the pci_controller in the exclude function we can easy
figure out if the bus number is the PHB or not.  The old style of using a
variable setup at init time was actually broken and would only work in
specific cases.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/pci.c         |    8 +-------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    7 +------
 arch/powerpc/platforms/85xx/pci.c         |    3 ---
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index f92e71f..8da935c 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -33,15 +33,10 @@
 #define DBG(x...)
 #endif
 
-int mpc83xx_pci2_busno;
-
 int mpc83xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
+	if ((bus == hose->first_busno) && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (mpc83xx_pci2_busno)
-		if (bus == (mpc83xx_pci2_busno) && PCI_SLOT(devfn) == 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -86,7 +81,6 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384);
 		primary = 0;
 		hose->bus_offset = hose->first_busno;
-		mpc83xx_pci2_busno = hose->first_busno;
 	}
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index fcea5ab..04a1eaa 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -55,16 +55,11 @@ static volatile u8 *cadmus;
 #define ARCADIA_HOST_BRIDGE_IDSEL	17
 #define ARCADIA_2ND_BRIDGE_IDSEL	3
 
-extern int mpc85xx_pci2_busno;
-
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				  u_char bus, u_char devfn)
 {
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
+	if ((bus == hose->first_busno) && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (mpc85xx_pci2_busno)
-		if (bus == (mpc85xx_pci2_busno) && PCI_SLOT(devfn) == 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
 	/* We explicitly do not go past the Tundra 320 Bridge */
 	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 72a1bc5..be67f67 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -33,8 +33,6 @@
 #define DBG(x...)
 #endif
 
-int mpc85xx_pci2_busno = 0;
-
 #ifdef CONFIG_PCI
 int __init mpc85xx_add_bridge(struct device_node *dev)
 {
@@ -74,7 +72,6 @@ int __init mpc85xx_add_bridge(struct device_node *dev)
 		setup_indirect_pci(hose, immr + 0x9000, immr + 0x9004);
 		primary = 0;
 		hose->bus_offset = hose->first_busno;
-		mpc85xx_pci2_busno = hose->first_busno;
 	}
 
 	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
-- 
1.5.2.1
