Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 9BC01DDF1A
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:56:27 +1000 (EST)
Message-ID: <46A1055A.4090805@mvista.com>
Date: Fri, 20 Jul 2007 11:56:26 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/6] 85xxCDS: Skip the fake PCI bridge (FPGA)
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 83bfbe730b1fad2ac9b22d33990e7378d920e844 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Fri, 20 Jul 2007 11:18:26 -0700
Subject: [PATCH] 85xxCDS: Skip the fake PCI bridge (FPGA)

The 85xxCDS has an FPGA that incorrectly appears as a PCI-to-PCI bridge.
This patch adds a fixup routine that will skip the bridge. With the fixup
in place, the existing exclude routine is no longer needed.

Note: This code was originally part of a larger patch posted by Andy Fleming.
The original patch also contained changes which handled the 85xx PCI Express
host bridge. The host bridge changes have been submitted in a new form, but
the FPGA changes in this patch were lost in the process.

Signed-off-by Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/kernel/pci_32.c              |   13 ++++++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   16 ----------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index bfcfa14..05c2ebd 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -80,7 +80,18 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 	dev->resource[1].start = dev->resource[1].end = 0;
 	dev->resource[1].flags = 0;
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CPC710_PCI64, fixup_cpc710_pci64);
+
+static void __devinit skip_fake_bridge(struct pci_dev *dev)
+{
+	/* Make it an error to skip the fake bridge
+	 * in pci_setup_device() in probe.c */
+	dev->hdr_type = 0x7f;
+}
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
+
 
 static void
 pcibios_fixup_resources(struct pci_dev *dev)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 2539bb5..8046acb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -53,21 +53,6 @@ static volatile u8 *cadmus;
 
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
 static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 {
 	u_char c;
@@ -226,7 +211,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 			fsl_add_bridge(np, 1);
 	}
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
 
-- 
1.5.2.2.549.gaeb59
