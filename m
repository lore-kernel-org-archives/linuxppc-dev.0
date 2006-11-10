Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:45:00 +1100
Subject: [PATCH 19/32] powerpc: Resolve the BUID fir RTAS PCI config space
	accesses
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074503.6388367DC5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The BUID is the first entry of a PCI host bridge "reg" property.

Now that PCI busses can be anywhere in the device-tree, we need to
fully translate the value there to a CPU physical address before
we can use it with RTAS.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/rtas_pci.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

Index: linux-cell/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/rtas_pci.c	2006-10-26 17:32:35.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/rtas_pci.c	2006-10-26 17:34:21.000000000 +1000
@@ -231,32 +231,13 @@ void __init init_pci_config_tokens (void
 
 unsigned long __devinit get_phb_buid (struct device_node *phb)
 {
-	int addr_cells;
-	const unsigned int *buid_vals;
-	unsigned int len;
-	unsigned long buid;
-
-	if (ibm_read_pci_config == -1) return 0;
+	struct resource r;
 
-	/* PHB's will always be children of the root node,
-	 * or so it is promised by the current firmware. */
-	if (phb->parent == NULL)
-		return 0;
-	if (phb->parent->parent)
+	if (ibm_read_pci_config == -1)
 		return 0;
-
-	buid_vals = get_property(phb, "reg", &len);
-	if (buid_vals == NULL)
+	if (of_address_to_resource(phb, 0, &r))
 		return 0;
-
-	addr_cells = prom_n_addr_cells(phb);
-	if (addr_cells == 1) {
-		buid = (unsigned long) buid_vals[0];
-	} else {
-		buid = (((unsigned long)buid_vals[0]) << 32UL) |
-			(((unsigned long)buid_vals[1]) & 0xffffffff);
-	}
-	return buid;
+	return r.start;
 }
 
 static int phb_set_bus_ranges(struct device_node *dev,
