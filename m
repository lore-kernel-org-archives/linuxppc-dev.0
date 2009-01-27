Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 62A39DE0FC
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 15:42:14 +1100 (EST)
Received: by qyk14 with SMTP id 14so11683414qyk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 20:42:12 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: Bugfix for PCI mapping of memory and IMMR
To: linuxppc-dev@ozlabs.org, w.sang@pengutronix.de
Date: Mon, 26 Jan 2009 21:34:36 -0700
Message-ID: <20090127043315.26160.43312.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch ensures that memory gets properly mapped into the PCI
address space.  Without this patch, the memory window BAR is left
at whatever value happened to be loaded into the BAR when Linux
was booted.  Without this patch, memory could end up getting mapped
at any of the 1G address boundaries instead of at '0' where Linux
expects it.

Similarly, this patch also ensures that the internally memory mapped
registers (IMMR) are mapped to the correct PCI address range.

Without this patch, PCI appears to work correctly until a PCI
device is inserted which DMAs into memory.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

This is a bugfix that I intend to merge into 2.6.29 and once it is
mainlined get it added to the stable queue.  If you have a 5200 system,
please test and make sure it works for you.

Thanks
g.

 arch/powerpc/platforms/52xx/mpc52xx_pci.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index c3f2c21..87ff522 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -20,14 +20,6 @@
 
 
 /* ======================================================================== */
-/* PCI windows config                                                       */
-/* ======================================================================== */
-
-#define MPC52xx_PCI_TARGET_IO	0xf0000000
-#define MPC52xx_PCI_TARGET_MEM	0x00000000
-
-
-/* ======================================================================== */
 /* Structures mapping & Defines for PCI Unit                                */
 /* ======================================================================== */
 
@@ -244,7 +236,7 @@ static struct pci_ops mpc52xx_pci_ops = {
 
 static void __init
 mpc52xx_pci_setup(struct pci_controller *hose,
-                  struct mpc52xx_pci __iomem *pci_regs)
+                  struct mpc52xx_pci __iomem *pci_regs, phys_addr_t pci_phys)
 {
 	struct resource *res;
 	u32 tmp;
@@ -314,10 +306,14 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 	/* Set all the IWCR fields at once; they're in the same reg */
 	out_be32(&pci_regs->iwcr, MPC52xx_PCI_IWCR_PACK(iwcr0, iwcr1, iwcr2));
 
-	out_be32(&pci_regs->tbatr0,
-		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_IO );
-	out_be32(&pci_regs->tbatr1,
-		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_MEM );
+	/* Map IMMR onto PCI bus */
+	pci_phys &= 0xfffc0000; /* bar0 has only 14 significant bits */
+	out_be32(&pci_regs->tbatr0, MPC52xx_PCI_TBATR_ENABLE | pci_phys);
+	out_be32(&pci_regs->bar0, PCI_BASE_ADDRESS_MEM_PREFETCH | pci_phys);
+
+	/* Map memory onto PCI bus */
+	out_be32(&pci_regs->tbatr1, MPC52xx_PCI_TBATR_ENABLE);
+	out_be32(&pci_regs->bar1, PCI_BASE_ADDRESS_MEM_PREFETCH);
 
 	out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD | MPC52xx_PCI_TCR_WCT8);
 
@@ -414,7 +410,7 @@ mpc52xx_add_bridge(struct device_node *node)
 
 	/* Finish setting up PCI using values obtained by
 	 * pci_proces_bridge_OF_ranges */
-	mpc52xx_pci_setup(hose, pci_regs);
+	mpc52xx_pci_setup(hose, pci_regs, rsrc.start);
 
 	return 0;
 }
