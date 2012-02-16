Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6647B6F9C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:38:13 +1100 (EST)
Message-ID: <1329370678.3772.50.camel@pasglop>
Subject: [PATCH v2] powerpc/fsl/pci: Fix PCIe fixup regression
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Thu, 16 Feb 2012 16:37:58 +1100
In-Reply-To: <1329279740.3772.24.camel@pasglop>
References: <1329279740.3772.24.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Upstream changes to the way PHB resources are registered
broke the resource fixup for FSL boards.

We can no longer rely on the resource pointer array for the PHB's
pci_bus structure, so let's leave it alone and go straight for
the PHB resources instead. This also makes the code generally
more readable.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Properly clear resources above what's in the PHB

With this, I got a radeon and a e1000 working with upstream.

Let's my other patch (the one changing the header quirk) for now
as it seems to be breaking DMA, I'll investigate.

Kumar, can I have an ack for this ?

 arch/powerpc/sysdev/fsl_pci.c |   48 ++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 30eb17e..6073288 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -385,26 +385,36 @@ static void __init setup_pci_cmd(struct pci_controller *hose)
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	int i;
-
-	if ((bus->parent == hose->bus) &&
-	    ((fsl_pcie_bus_fixup &&
-	      early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) ||
-	     (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)))
-	{
-		for (i = 0; i < 4; ++i) {
+	int i, is_pcie = 0, no_link;
+
+	/* The root complex bridge comes up with bogus resources,
+	 * we copy the PHB ones in.
+	 *
+	 * With the current generic PCI code, the PHB bus no longer
+	 * has bus->resource[0..4] set, so things are a bit more
+	 * tricky.
+	 */
+
+	if (fsl_pcie_bus_fixup)
+		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
+	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
+
+	if (bus->parent == hose->bus && (is_pcie || no_link)) {
+		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
 			struct resource *res = bus->resource[i];
-			struct resource *par = bus->parent->resource[i];
-			if (res) {
-				res->start = 0;
-				res->end   = 0;
-				res->flags = 0;
-			}
-			if (res && par) {
-				res->start = par->start;
-				res->end   = par->end;
-				res->flags = par->flags;
-			}
+			struct resource *par;
+
+			if (!res)
+				continue;
+			if (i == 0)
+				par = &hose->io_resource;
+			else if (i < 4)
+				par = &hose->mem_resources[i-1];
+			else par = NULL;
+
+			res->start = par ? par->start : 0;
+			res->end   = par ? par->end   : 0;
+			res->flags = par ? par->flags : 0;
 		}
 	}
 }
-- 
1.7.9
