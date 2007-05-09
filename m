Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17985.46275.841370.382482@cargo.ozlabs.ibm.com>
Date: Wed, 9 May 2007 21:47:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix incorrect calculation of I/O window addresses
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My patch "Cope with PCI host bridge I/O window not starting at 0"
introduced a bug in the calculation of the virtual addresses for the
I/O windows of PCI host bridges other than the first, because it
didn't account for the fact that hose->io_resource gets offset so that
it reflects the range of global I/O port numbers assigned to the
bridge.  This fixes it and simplifies get_bus_io_range() in the
process.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 6d05a1f..bb3c0cb 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -1098,35 +1098,24 @@ static int get_bus_io_range(struct pci_bus *bus, unsigned long *start_phys,
 				unsigned long *start_virt, unsigned long *size)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pci_bus_region region;
 	struct resource *res;
 
-	if (bus->self) {
+	if (bus->self)
 		res = bus->resource[0];
-		pcibios_resource_to_bus(bus->self, &region, res);
-		*start_phys = hose->io_base_phys + region.start;
-		*start_virt = (unsigned long) hose->io_base_virt + 
-				region.start;
-		if (region.end > region.start) 
-			*size = region.end - region.start + 1;
-		else {
-			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
-					__FUNCTION__, region.start, region.end);
-			return 1;
-		}
-		
-	} else {
+	else
 		/* Root Bus */
 		res = &hose->io_resource;
-		*start_phys = hose->io_base_phys + res->start;
-		*start_virt = (unsigned long) hose->io_base_virt + res->start;
-		if (res->end > res->start)
-			*size = res->end - res->start + 1;
-		else {
-			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
-					__FUNCTION__, res->start, res->end);
-			return 1;
-		}
+
+	*start_virt = pci_io_base + res->start;
+	*start_phys = *start_virt + hose->io_base_phys
+		- (unsigned long) hose->io_base_virt;
+
+	if (res->end > res->start)
+		*size = res->end - res->start + 1;
+	else {
+		printk("%s(): unexpected region 0x%lx->0x%lx\n", 
+		       __FUNCTION__, res->start, res->end);
+		return 1;
 	}
 
 	return 0;
