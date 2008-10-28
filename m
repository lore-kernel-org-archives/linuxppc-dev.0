Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:44 +1100
Subject: [PATCH 7/10] powerpc/pci: Make pcibios_allocate_bus_resources more
	robust
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054944.77073DDF6D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To properly fix PCI hotplug, it's useful to be able to make
the fixup passes on all devices whether they were just hot
plugged or already there.

However, pcibios_allocate_bus_resources() wouldn't cope well
with being called twice for a given bus. This patch makes it
ignore resources that have already been allocated, along with
adding a bit of debug output.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 14:04:45.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 14:04:57.000000000 +1100
@@ -1245,9 +1245,12 @@ static void pcibios_allocate_bus_resourc
 	int i;
 	struct resource *res, *pr;
 
+	pr_debug("PCI: Allocating bus resources for %04x:%02x...\n",
+		 pci_domain_nr(bus), bus->number);
+
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
 		if ((res = bus->resource[i]) == NULL || !res->flags
-		    || res->start > res->end)
+		    || res->start > res->end || res->parent)
 			continue;
 		if (bus->parent == NULL)
 			pr = (res->flags & IORESOURCE_IO) ?
