Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:55:02 +1100
Subject: [PATCH 17/19] [POWERPC] Improve resource setup of PowerMac G5 HT
	bridge
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035505.6EA6CDDE1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The device node for the HT bridge on G5s doesn't contain useful ranges.

We used to give it a bunch of the known PCI space and then punch a "hole"
in it based on where the AGP or PCIe region was. This reworks it to
use the actual register in the bridge that controls the decoding instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/powermac/pci.c |  146 +++++++++++++++-------------------
 1 file changed, 66 insertions(+), 80 deletions(-)

--- linux-merge.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-19 15:53:00.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pci.c	2007-12-19 15:55:29.000000000 +1100
@@ -40,8 +40,6 @@
 static int has_uninorth;
 #ifdef CONFIG_PPC64
 static struct pci_controller *u3_agp;
-static struct pci_controller *u4_pcie;
-static struct pci_controller *u3_ht;
 #else
 static int has_second_ohare;
 #endif /* CONFIG_PPC64 */
@@ -779,16 +777,50 @@ static void __init setup_u4_pcie(struct 
 	 */
 	hose->first_busno = 0x00;
 	hose->last_busno = 0xff;
-	u4_pcie = hose;
+}
+
+static void __init parse_region_decode(struct pci_controller *hose,
+				       u32 decode)
+{
+	unsigned long base, end, next = -1;
+	int i, cur = -1;
+
+	/* Iterate through all bits. We ignore the last bit as this region is
+	 * reserved for the ROM among other niceties
+	 */
+	for (i = 0; i < 31; i++) {
+		if ((decode & (0x80000000 >> i)) == 0)
+			continue;
+		if (i < 16) {
+			base = 0xf0000000 | (((u32)i) << 24);
+			end = base + 0x00ffffff;
+		} else {
+			base = ((u32)i-16) << 28;
+			end = base + 0x0fffffff;
+		}
+		if (base != next) {
+			if (++cur >= 3) {
+				printk(KERN_WARNING "PCI: Too many ranges !\n");
+				break;
+			}
+			hose->mem_resources[cur].flags = IORESOURCE_MEM;
+			hose->mem_resources[cur].name = hose->dn->full_name;
+			hose->mem_resources[cur].start = base;
+			hose->mem_resources[cur].end = end;
+			DBG("  %d: 0x%08lx-0x%08lx\n", cur, base, end);
+		} else {
+			DBG("   :           -0x%08lx\n", end);
+			hose->mem_resources[cur].end = end;
+		}
+		next = end + 1;
+	}
 }
 
 static void __init setup_u3_ht(struct pci_controller* hose)
 {
 	struct device_node *np = hose->dn;
-	struct pci_controller *other = NULL;
 	struct resource cfg_res, self_res;
-	int i, cur;
-
+	u32 decode;
 
 	hose->ops = &u3_ht_pci_ops;
 
@@ -808,12 +840,9 @@ static void __init setup_u3_ht(struct pc
 				 self_res.end - self_res.start + 1);
 
 	/*
-	 * /ht node doesn't expose a "ranges" property, so we "remove"
-	 * regions that have been allocated to AGP. So far, this version of
-	 * the code doesn't assign any of the 0xfxxxxxxx "fine" memory regions
-	 * to /ht. We need to fix that sooner or later by either parsing all
-	 * child "ranges" properties or figuring out the U3 address space
-	 * decoding logic and then read its configuration register (if any).
+	 * /ht node doesn't expose a "ranges" property, we read the register
+	 * that controls the decoding logic and use that for memory regions.
+	 * The IO region is hard coded since it is fixed in HW as well.
 	 */
 	hose->io_base_phys = 0xf4000000;
 	hose->pci_io_size = 0x00400000;
@@ -824,76 +853,33 @@ static void __init setup_u3_ht(struct pc
 	hose->pci_mem_offset = 0;
 	hose->first_busno = 0;
 	hose->last_busno = 0xef;
-	hose->mem_resources[0].name = np->full_name;
-	hose->mem_resources[0].start = 0x80000000;
-	hose->mem_resources[0].end = 0xefffffff;
-	hose->mem_resources[0].flags = IORESOURCE_MEM;
-
-	u3_ht = hose;
-
-	if (u3_agp != NULL)
-		other = u3_agp;
-	else if (u4_pcie != NULL)
-		other = u4_pcie;
 
-	if (other == NULL) {
-		DBG("U3/4 has no AGP/PCIE, using full resource range\n");
-		return;
-	}
+	/* Note: fix offset when cfg_addr becomes a void * */
+	decode = in_be32(hose->cfg_addr + 0x80);
 
-	/* Fixup bus range vs. PCIE */
-	if (u4_pcie)
-		hose->last_busno = u4_pcie->first_busno - 1;
-
-	/* We "remove" the AGP resources from the resources allocated to HT,
-	 * that is we create "holes". However, that code does assumptions
-	 * that so far happen to be true (cross fingers...), typically that
-	 * resources in the AGP node are properly ordered
-	 */
-	cur = 0;
-	for (i=0; i<3; i++) {
-		struct resource *res = &other->mem_resources[i];
-		if (res->flags != IORESOURCE_MEM)
-			continue;
-		/* We don't care about "fine" resources */
-		if (res->start >= 0xf0000000)
-			continue;
-		/* Check if it's just a matter of "shrinking" us in one
-		 * direction
-		 */
-		if (hose->mem_resources[cur].start == res->start) {
-			DBG("U3/HT: shrink start of %d, %08lx -> %08lx\n",
-			    cur, hose->mem_resources[cur].start,
-			    res->end + 1);
-			hose->mem_resources[cur].start = res->end + 1;
-			continue;
-		}
-		if (hose->mem_resources[cur].end == res->end) {
-			DBG("U3/HT: shrink end of %d, %08lx -> %08lx\n",
-			    cur, hose->mem_resources[cur].end,
-			    res->start - 1);
-			hose->mem_resources[cur].end = res->start - 1;
-			continue;
-		}
-		/* No, it's not the case, we need a hole */
-		if (cur == 2) {
-			/* not enough resources for a hole, we drop part
-			 * of the range
-			 */
-			printk(KERN_WARNING "Running out of resources"
-			       " for /ht host !\n");
-			hose->mem_resources[cur].end = res->start - 1;
-			continue;
-		}
-		cur++;
-		DBG("U3/HT: hole, %d end at %08lx, %d start at %08lx\n",
-		    cur-1, res->start - 1, cur, res->end + 1);
-		hose->mem_resources[cur].name = np->full_name;
-		hose->mem_resources[cur].flags = IORESOURCE_MEM;
-		hose->mem_resources[cur].start = res->end + 1;
-		hose->mem_resources[cur].end = hose->mem_resources[cur-1].end;
-		hose->mem_resources[cur-1].end = res->start - 1;
-	}
+	DBG("PCI: Apple HT bridge decode register: 0x%08x\n", decode);
+
+	/* NOTE: The decode register setup is a bit weird... region
+	 * 0xf8000000 for example is marked as enabled in there while it's
+	 & actually the memory controller registers.
+	 * That means that we are incorrectly attributing it to HT.
+	 *
+	 * In a similar vein, region 0xf4000000 is actually the HT IO space but
+	 * also marked as enabled in here and 0xf9000000 is used by some other
+	 * internal bits of the northbridge.
+	 *
+	 * Unfortunately, we can't just mask out those bit as we would end
+	 * up with more regions than we can cope (linux can only cope with
+	 * 3 memory regions for a PHB at this stage).
+	 *
+	 * So for now, we just do a little hack. We happen to -know- that
+	 * Apple firmware doesn't assign things below 0xfa000000 for that
+	 * bridge anyway so we mask out all bits we don't want.
+	 */
+	decode &= 0x003fffff;
+
+	/* Now parse the resulting bits and build resources */
+	parse_region_decode(hose, decode);
 }
 #endif /* CONFIG_PPC64 */
 
