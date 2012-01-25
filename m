Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD75EB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 13:36:14 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q0P2a9dk007587
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 20:36:10 -0600
Message-ID: <1327458969.19850.48.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix PCI resource handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 25 Jan 2012 13:36:09 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent changes to the handling of PCI resources for host bridges
are breaking the PowerNV code for assigning resources on IODA.

The root of the problem is that the pci_bus attached to a host
bridge no longer has its "legacy" resource pointers populated
but only uses the newer list instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   43 ++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f31162c..5e155df 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -204,11 +204,10 @@ static void __devinit pnv_ioda_offset_bus(struct pci_bus *bus,
 	pr_devel("  -> OBR %s [%x] +%016llx\n",
 		 bus->self ? pci_name(bus->self) : "root", flags, offset);
 
-	for (i = 0; i < 2; i++) {
-		r = bus->resource[i];
+	pci_bus_for_each_resource(bus, r, i) {
 		if (r && (r->flags & flags)) {
-			bus->resource[i]->start += offset;
-			bus->resource[i]->end += offset;
+			r->start += offset;
+			r->end += offset;
 		}
 	}
 	list_for_each_entry(dev, &bus->devices, bus_list)
@@ -288,12 +287,17 @@ static void __devinit pnv_ioda_calc_bus(struct pci_bus *bus, unsigned int flags,
 	 * assignment algorithm is going to be uber-trivial for now, we
 	 * can try to be smarter later at filling out holes.
 	 */
-	start = bus->self ? 0 : bus->resource[bres]->start;
-
-	/* Don't hand out IO 0 */
-	if ((flags & IORESOURCE_IO) && !bus->self)
-		start += 0x1000;
-
+	if (bus->self) {
+		/* No offset for downstream bridges */
+		start = 0;
+	} else {
+		/* Offset from the root */
+		if (flags & IORESOURCE_IO)
+			/* Don't hand out IO 0 */
+			start = hose->io_resource.start + 0x1000;
+		else
+			start = hose->mem_resources[0].start;
+	}
 	while(!list_empty(&head)) {
 		w = list_first_entry(&head, struct resource_wrap, link);
 		list_del(&w->link);
@@ -321,13 +325,20 @@ static void __devinit pnv_ioda_calc_bus(struct pci_bus *bus, unsigned int flags,
  empty:
 	/* Only setup P2P's, not the PHB itself */
 	if (bus->self) {
-		WARN_ON(bus->resource[bres] == NULL);
-		bus->resource[bres]->start = 0;
-		bus->resource[bres]->flags = (*size) ? flags : 0;
-		bus->resource[bres]->end = (*size) ? (*size - 1) : 0;
+		struct resource *res = bus->resource[bres];
+
+		if (WARN_ON(res == NULL))
+			return;
 
-		/* Clear prefetch bus resources for now */
-		bus->resource[2]->flags = 0;
+		/*
+		 * FIXME: We should probably export and call
+		 * pci_bridge_check_ranges() to properly re-initialize
+		 * the PCI portion of the flags here, and to detect
+		 * what the bridge actually supports.
+		 */
+		res->start = 0;
+		res->flags = (*size) ? flags : 0;
+		res->end = (*size) ? (*size - 1) : 0;
 	}
 
 	pr_devel("<- CBR %s [%x] *size=%016llx *align=%016llx\n",
