Return-Path: <Andrew.Murray@arm.com>
From: Andrew Murray <Andrew.Murray@arm.com>
To: robherring2@gmail.com
Subject: [PATCH v9 2/3] of/pci: mips: convert to common of_pci_range_parser
Date: Tue,  7 May 2013 16:31:13 +0100
Message-Id: <1367940674-11987-3-git-send-email-Andrew.Murray@arm.com>
In-Reply-To: <1367940674-11987-1-git-send-email-Andrew.Murray@arm.com>
References: <1367940674-11987-1-git-send-email-Andrew.Murray@arm.com>
Cc: linux-mips@linux-mips.org, siva.kallam@samsung.com,
 linus.walleij@linaro.org, thierry.reding@avionic-design.de,
 Liviu.Dudau@arm.com, juhosg@openwrt.org, paulus@samba.org,
 linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, jg1.han@samsung.com,
 jgunthorpe@obsidianresearch.com, thomas.abraham@linaro.org,
 linux-pci@vger.kernel.org, grant.likely@linaro.org, arnd@arndb.de,
 devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, monstr@monstr.eu,
 linux-kernel@vger.kernel.org, suren.reddy@samsung.com,
 Andrew Murray <Andrew.Murray@arm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts the pci_load_of_ranges function to use the new common
of_pci_range_parser.

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/pci/pci.c |   50 ++++++++++++++++++--------------------------------
 1 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 0872f12..0d291e9 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -122,51 +122,37 @@ static void pcibios_scanbus(struct pci_controller *hose)
 #ifdef CONFIG_OF
 void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 {
-	const __be32 *ranges;
-	int rlen;
-	int pna = of_n_addr_cells(node);
-	int np = pna + 5;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
 
 	pr_info("PCI host bridge %s ranges:\n", node->full_name);
-	ranges = of_get_property(node, "ranges", &rlen);
-	if (ranges == NULL)
-		return;
 	hose->of_node = node;
 
-	while ((rlen -= np * 4) >= 0) {
-		u32 pci_space;
+	if (of_pci_range_parser_init(&parser, node))
+		return;
+
+	for_each_of_pci_range(&parser, &range) {
 		struct resource *res = NULL;
-		u64 addr, size;
-
-		pci_space = be32_to_cpup(&ranges[0]);
-		addr = of_translate_address(node, ranges + 3);
-		size = of_read_number(ranges + pna + 3, 2);
-		ranges += np;
-		switch ((pci_space >> 24) & 0x3) {
-		case 1:		/* PCI IO space */
+
+		switch (range.flags & IORESOURCE_TYPE_BITS) {
+		case IORESOURCE_IO:
 			pr_info("  IO 0x%016llx..0x%016llx\n",
-					addr, addr + size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			hose->io_map_base =
-				(unsigned long)ioremap(addr, size);
+				(unsigned long)ioremap(range.cpu_addr,
+						       range.size);
 			res = hose->io_resource;
-			res->flags = IORESOURCE_IO;
 			break;
-		case 2:		/* PCI Memory space */
-		case 3:		/* PCI 64 bits Memory space */
+		case IORESOURCE_MEM:
 			pr_info(" MEM 0x%016llx..0x%016llx\n",
-					addr, addr + size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			res = hose->mem_resource;
-			res->flags = IORESOURCE_MEM;
 			break;
 		}
-		if (res != NULL) {
-			res->start = addr;
-			res->name = node->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
+		if (res != NULL)
+			of_pci_range_to_resource(&range, node, res);
 	}
 }
 #endif
-- 
1.7.0.4
