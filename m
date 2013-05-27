Return-Path: <Sergey.Gerasimov@astrosoft-development.com>
Received: from storage.astrosoft.ru (storage.astrosoft.ru [195.218.158.6])
 by ozlabs.org (Postfix) with SMTP id 717DF2C02B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 22:40:20 +1000 (EST)
From: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>,
 Roy Zang <tie-fei.zang@freescale.com>, Jia Hongtao <B38951@freescale.com>,
 Li Yang <leoli@freescale.com>
Subject: [PATCH 1/1] MPC831x: fix PCI express probing
Date: Mon, 27 May 2013 14:29:43 +0200
Message-Id: <1369657783-19962-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
Cc: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For MPC831x the bus probing function also needs the fixup to assign
addresses to the PCI devices as it was for MPC85xx and MPC86xx.
The fixup of the bridge vendor and device ID should be done early in
PCI probing. Else the bridge is not detected as FIXUP_HEADER is called
too late.

Signed-off-by: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 68 +++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 028ac1f..94d1bd4 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -84,6 +84,34 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 	return 0;
 }
 
+void fsl_pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
+	int i;
+
+
+	if ((bus->parent == hose->bus)
+		&& ((fsl_pcie_bus_fixup
+			&& pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP))
+			|| (hose->indirect_type
+				& PPC_INDIRECT_TYPE_NO_PCIE_LINK))) {
+		for (i = 0; i < 4; ++i) {
+			struct resource *res = bus->resource[i];
+			struct resource *par = bus->parent->resource[i];
+			if (res) {
+				res->start = 0;
+				res->end   = 0;
+				res->flags = 0;
+			}
+			if (res && par) {
+				res->start = par->start;
+				res->end   = par->end;
+				res->flags = par->flags;
+			}
+		}
+	}
+}
+
 static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 				    int offset, int len, u32 *val)
 {
@@ -419,43 +447,6 @@ static void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }
 
-void fsl_pcibios_fixup_bus(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	int i, is_pcie = 0, no_link;
-
-	/* The root complex bridge comes up with bogus resources,
-	 * we copy the PHB ones in.
-	 *
-	 * With the current generic PCI code, the PHB bus no longer
-	 * has bus->resource[0..4] set, so things are a bit more
-	 * tricky.
-	 */
-
-	if (fsl_pcie_bus_fixup)
-		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
-	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
-
-	if (bus->parent == hose->bus && (is_pcie || no_link)) {
-		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
-			struct resource *res = bus->resource[i];
-			struct resource *par;
-
-			if (!res)
-				continue;
-			if (i == 0)
-				par = &hose->io_resource;
-			else if (i < 4)
-				par = &hose->mem_resources[i-1];
-			else par = NULL;
-
-			res->start = par ? par->start : 0;
-			res->end   = par ? par->end   : 0;
-			res->flags = par ? par->flags : 0;
-		}
-	}
-}
-
 int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 {
 	int len;
@@ -562,7 +553,8 @@ no_bridge:
 }
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
+	quirk_fsl_pcie_header);
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
-- 
1.7.11.7
