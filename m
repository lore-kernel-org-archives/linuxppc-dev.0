Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B5EBDDF8A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 10:04:43 +1100 (EST)
Date: Wed, 23 Jan 2008 17:02:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
Subject: Re: mpc8568e-mds: pci-e is broken
In-Reply-To: <B4582CB3-2065-40D5-9C16-B0EE1943D83A@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0801231701110.1762@blarg.am.freescale.net>
References: <20080123193712.GA12037@localhost.localdomain>
	<6785FDE5-FEBA-4FE2-A94C-85FCE299D1CC@kernel.crashing.org>
	<20080123195022.GA21157@localhost.localdomain>
	<B4582CB3-2065-40D5-9C16-B0EE1943D83A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton,

Can you try this patch and see if it resolves the issue for you.. (You'll
still get the Apple FW messages)

- k

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4005739..bf13c21 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -133,22 +133,23 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
 	int i;

-	/* deal with bogus pci_bus when we don't have anything connected on PCIe */
-	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
-		if (bus->parent) {
-			for (i = 0; i < 4; ++i)
-				bus->resource[i] = bus->parent->resource[i];
-		}
-	}
-
-	if (fsl_pcie_bus_fixup &&
-	    (bus->parent == hose->bus) &&
-	     early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+	if ((bus->parent == hose->bus) &&
+	    ((fsl_pcie_bus_fixup &&
+	      early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) ||
+	     (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)))
+	{
 		for (i = 0; i < 4; ++i) {
-			if (bus->resource[i] && bus->parent->resource[i]) {
-				bus->resource[i]->start = bus->parent->resource[i]->start;
-				bus->resource[i]->end = bus->parent->resource[i]->end;
-				bus->resource[i]->flags = bus->parent->resource[i]->flags;
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
 			}
 		}
 	}
