Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 24/63] powerpc: Make OF PCI device tree accesses endian safe
Date: Wed,  7 Aug 2013 02:01:41 +1000
Message-Id: <1375804940-22050-25-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/pci-common.c  |  6 +++---
 arch/powerpc/kernel/pci_of_scan.c | 23 +++++++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 22fe401..7d72f8f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -667,7 +667,7 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 				  struct device_node *dev, int primary)
 {
-	const u32 *ranges;
+	const __be32 *ranges;
 	int rlen;
 	int pna = of_n_addr_cells(dev);
 	int np = pna + 5;
@@ -687,7 +687,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	/* Parse it */
 	while ((rlen -= np * 4) >= 0) {
 		/* Read next ranges element */
-		pci_space = ranges[0];
+		pci_space = of_read_number(ranges, 1);
 		pci_addr = of_read_number(ranges + 1, 2);
 		cpu_addr = of_translate_address(dev, ranges + 3);
 		size = of_read_number(ranges + pna + 3, 2);
@@ -704,7 +704,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 		/* Now consume following elements while they are contiguous */
 		for (; rlen >= np * sizeof(u32);
 		     ranges += np, rlen -= np * 4) {
-			if (ranges[0] != pci_space)
+			if (of_read_number(ranges, 1) != pci_space)
 				break;
 			pci_next = of_read_number(ranges + 1, 2);
 			cpu_next = of_translate_address(dev, ranges + 3);
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 15d9105..4368ec6 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -24,12 +24,12 @@
  */
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
 {
-	const u32 *prop;
+	const __be32 *prop;
 	int len;
 
 	prop = of_get_property(np, name, &len);
 	if (prop && len >= 4)
-		return *prop;
+		return of_read_number(prop, 1);
 	return def;
 }
 
@@ -77,7 +77,7 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 	unsigned int flags;
 	struct pci_bus_region region;
 	struct resource *res;
-	const u32 *addrs;
+	const __be32 *addrs;
 	u32 i;
 	int proplen;
 
@@ -86,14 +86,14 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 		return;
 	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
-		flags = pci_parse_of_flags(addrs[0], 0);
+		flags = pci_parse_of_flags(of_read_number(addrs, 1), 0);
 		if (!flags)
 			continue;
 		base = of_read_number(&addrs[1], 2);
 		size = of_read_number(&addrs[3], 2);
 		if (!size)
 			continue;
-		i = addrs[0] & 0xff;
+		i = of_read_number(addrs, 1) & 0xff;
 		pr_debug("  base: %llx, size: %llx, i: %x\n",
 			 (unsigned long long)base,
 			 (unsigned long long)size, i);
@@ -207,7 +207,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 {
 	struct device_node *node = dev->dev.of_node;
 	struct pci_bus *bus;
-	const u32 *busrange, *ranges;
+	const __be32 *busrange, *ranges;
 	int len, i, mode;
 	struct pci_bus_region region;
 	struct resource *res;
@@ -230,9 +230,11 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		return;
 	}
 
-	bus = pci_find_bus(pci_domain_nr(dev->bus), busrange[0]);
+	bus = pci_find_bus(pci_domain_nr(dev->bus),
+			   of_read_number(busrange, 1));
 	if (!bus) {
-		bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
+		bus = pci_add_new_bus(dev->bus, dev,
+				      of_read_number(busrange, 1));
 		if (!bus) {
 			printk(KERN_ERR "Failed to create pci bus for %s\n",
 			       node->full_name);
@@ -241,7 +243,8 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 	}
 
 	bus->primary = dev->bus->number;
-	pci_bus_insert_busn_res(bus, busrange[0], busrange[1]);
+	pci_bus_insert_busn_res(bus, of_read_number(busrange, 1),
+				of_read_number(busrange+1, 1));
 	bus->bridge_ctl = 0;
 
 	/* parse ranges property */
@@ -254,7 +257,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 	}
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
-		flags = pci_parse_of_flags(ranges[0], 1);
+		flags = pci_parse_of_flags(of_read_number(ranges, 1), 1);
 		size = of_read_number(&ranges[6], 2);
 		if (flags == 0 || size == 0)
 			continue;
-- 
1.8.1.2
