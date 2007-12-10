Return-Path: <benh@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 10 Dec 2007 17:32:16 +1100
Subject: [PATCH 2/2] pci: Fix warning in setup-res.c on 32-bit platforms with
	64-bit resources
Message-Id: <20071210063217.292B5DDE27@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds appropriate casts to avoid a warning and print the correct
values in pr_debug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/pci/setup-res.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-work/drivers/pci/setup-res.c
===================================================================
--- linux-work.orig/drivers/pci/setup-res.c	2007-12-10 17:17:32.000000000 +1100
+++ linux-work/drivers/pci/setup-res.c	2007-12-10 17:17:54.000000000 +1100
@@ -51,10 +51,12 @@ pci_update_resource(struct pci_dev *dev,
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	pr_debug("  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
+	pr_debug("  got res [%llx:%llx] bus [%llx:%llx] flags %lx for "
 		 "BAR %d of %s\n", (unsigned long long)res->start,
 		 (unsigned long long)res->end,
-		 region.start, region.end, res->flags, resno, pci_name(dev));
+		 (unsigned long long)region.start,
+		 (unsigned long long)region.end,
+		 (unsigned long)res->flags, resno, pci_name(dev));
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
 	if (res->flags & IORESOURCE_IO)
