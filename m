Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Oct 2008 13:58:19 +1100
Subject: [PATCH] powerpc: Add support for ISA holes on 4xx PCI/X/E
Message-Id: <20081010025849.0AAC9DDED8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for ISA memory holes on the PCI, PCI-X and
PCI-E busses of the 4xx platforms. The patch includes changes
to the Bamboo and Canyonlands device-trees to add such a hole,
others can be updated separately.

The ISA memory hole is an additional outbound window configured
in the bridge to generate PCI cycles in the low memory addresses,
thus allowing to access things such as the hard-decoded VGA
aperture at 0xa0000..0xbffff or other similar things. It's made
accessible to userspace via the new legacy_mem file in sysfs for
which support was added by a previous patch.

This patch depends on "powerpc: Add legacy PCI access via sysfs"
posted earlier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Despite being a bit late, I'd like that still going into .28 as
this whole serie is meant to allow me to fix Xorg to stop doing
horrible things to /dev/mem, often scribbling over system
memory etc... in its attempts to access the legacy areas. Support
for legacy memory isn't critical though, so I'm find if you
prefer delaying this one.

 arch/powerpc/boot/dts/bamboo.dts      |    3 
 arch/powerpc/boot/dts/canyonlands.dts |    3 
 arch/powerpc/sysdev/ppc4xx_pci.c      |  306 +++++++++++++++++++++++-----------
 3 files changed, 213 insertions(+), 99 deletions(-)

--- linux-work.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2008-10-10 11:21:59.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/ppc4xx_pci.c	2008-10-10 11:53:20.000000000 +1100
@@ -198,11 +198,41 @@ static int __init ppc4xx_parse_dma_range
  * 4xx PCI 2.x part
  */
 
+static int __init ppc4xx_setup_one_pci_PMM(struct pci_controller	*hose,
+					   void __iomem			*reg,
+					   u64				plb_addr,
+					   u64				pci_addr,
+					   u64				size,
+					   unsigned int			flags,
+					   int				index)
+{
+	u32 ma, pcila, pciha;
+
+	if ((plb_addr + size) > 0xffffffffull || !is_power_of_2(size) ||
+	    size < 0x1000 || (plb_addr & (size - 1)) != 0) {
+		printk(KERN_WARNING "%s: Resource out of range\n",
+		       hose->dn->full_name);
+		return -1;
+	}
+	ma = (0xffffffffu << ilog2(size)) | 1;
+	if (flags & IORESOURCE_PREFETCH)
+		ma |= 2;
+
+	pciha = RES_TO_U32_HIGH(pci_addr);
+	pcila = RES_TO_U32_LOW(pci_addr);
+
+	writel(plb_addr, reg + PCIL0_PMM0LA + (0x10 * index));
+	writel(pcila, reg + PCIL0_PMM0PCILA + (0x10 * index));
+	writel(pciha, reg + PCIL0_PMM0PCIHA + (0x10 * index));
+	writel(ma, reg + PCIL0_PMM0MA + (0x10 * index));
+
+	return 0;
+}
+
 static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 					     void __iomem *reg)
 {
-	u32 la, ma, pcila, pciha;
-	int i, j;
+	int i, j, found_isa_hole = 0;
 
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
@@ -217,28 +247,29 @@ static void __init ppc4xx_configure_pci_
 			break;
 		}
 
-		/* Calculate register values */
-		la = res->start;
-		pciha = RES_TO_U32_HIGH(res->start - hose->pci_mem_offset);
-		pcila = RES_TO_U32_LOW(res->start - hose->pci_mem_offset);
-
-		ma = res->end + 1 - res->start;
-		if (!is_power_of_2(ma) || ma < 0x1000 || ma > 0xffffffffu) {
-			printk(KERN_WARNING "%s: Resource out of range\n",
-			       hose->dn->full_name);
-			continue;
+		/* Configure the resource */
+		if (ppc4xx_setup_one_pci_PMM(hose, reg,
+					     res->start,
+					     res->start - hose->pci_mem_offset,
+					     res->end + 1 - res->start,
+					     res->flags,
+					     j) == 0) {
+			j++;
+
+			/* If the resource PCI address is 0 then we have our
+			 * ISA memory hole
+			 */
+			if (res->start == hose->pci_mem_offset)
+				found_isa_hole = 1;
 		}
-		ma = (0xffffffffu << ilog2(ma)) | 0x1;
-		if (res->flags & IORESOURCE_PREFETCH)
-			ma |= 0x2;
-
-		/* Program register values */
-		writel(la, reg + PCIL0_PMM0LA + (0x10 * j));
-		writel(pcila, reg + PCIL0_PMM0PCILA + (0x10 * j));
-		writel(pciha, reg + PCIL0_PMM0PCIHA + (0x10 * j));
-		writel(ma, reg + PCIL0_PMM0MA + (0x10 * j));
-		j++;
 	}
+
+	/* Handle ISA memory hole if not already covered */
+	if (j <= 2 && !found_isa_hole && hose->isa_mem_size)
+		if (ppc4xx_setup_one_pci_PMM(hose, reg, hose->isa_mem_phys, 0,
+					     hose->isa_mem_size, 0, j) == 0)
+			printk(KERN_INFO "%s: Legacy ISA memory support enabled\n",
+			       hose->dn->full_name);
 }
 
 static void __init ppc4xx_configure_pci_PTMs(struct pci_controller *hose,
@@ -349,11 +380,52 @@ static void __init ppc4xx_probe_pci_brid
  * 4xx PCI-X part
  */
 
+static int __init ppc4xx_setup_one_pcix_POM(struct pci_controller	*hose,
+					    void __iomem		*reg,
+					    u64				plb_addr,
+					    u64				pci_addr,
+					    u64				size,
+					    unsigned int		flags,
+					    int				index)
+{
+	u32 lah, lal, pciah, pcial, sa;
+
+	if (!is_power_of_2(size) || size < 0x1000 ||
+	    (plb_addr & (size - 1)) != 0) {
+		printk(KERN_WARNING "%s: Resource out of range\n",
+		       hose->dn->full_name);
+		return -1;
+	}
+
+	/* Calculate register values */
+	lah = RES_TO_U32_HIGH(plb_addr);
+	lal = RES_TO_U32_LOW(plb_addr);
+	pciah = RES_TO_U32_HIGH(pci_addr);
+	pcial = RES_TO_U32_LOW(pci_addr);
+	sa = (0xffffffffu << ilog2(size)) | 0x1;
+
+	/* Program register values */
+	if (index == 0) {
+		writel(lah, reg + PCIX0_POM0LAH);
+		writel(lal, reg + PCIX0_POM0LAL);
+		writel(pciah, reg + PCIX0_POM0PCIAH);
+		writel(pcial, reg + PCIX0_POM0PCIAL);
+		writel(sa, reg + PCIX0_POM0SA);
+	} else {
+		writel(lah, reg + PCIX0_POM1LAH);
+		writel(lal, reg + PCIX0_POM1LAL);
+		writel(pciah, reg + PCIX0_POM1PCIAH);
+		writel(pcial, reg + PCIX0_POM1PCIAL);
+		writel(sa, reg + PCIX0_POM1SA);
+	}
+
+	return 0;
+}
+
 static void __init ppc4xx_configure_pcix_POMs(struct pci_controller *hose,
 					      void __iomem *reg)
 {
-	u32 lah, lal, pciah, pcial, sa;
-	int i, j;
+	int i, j, found_isa_hole = 0;
 
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
@@ -368,36 +440,29 @@ static void __init ppc4xx_configure_pcix
 			break;
 		}
 
-		/* Calculate register values */
-		lah = RES_TO_U32_HIGH(res->start);
-		lal = RES_TO_U32_LOW(res->start);
-		pciah = RES_TO_U32_HIGH(res->start - hose->pci_mem_offset);
-		pcial = RES_TO_U32_LOW(res->start - hose->pci_mem_offset);
-		sa = res->end + 1 - res->start;
-		if (!is_power_of_2(sa) || sa < 0x100000 ||
-		    sa > 0xffffffffu) {
-			printk(KERN_WARNING "%s: Resource out of range\n",
-			       hose->dn->full_name);
-			continue;
-		}
-		sa = (0xffffffffu << ilog2(sa)) | 0x1;
-
-		/* Program register values */
-		if (j == 0) {
-			writel(lah, reg + PCIX0_POM0LAH);
-			writel(lal, reg + PCIX0_POM0LAL);
-			writel(pciah, reg + PCIX0_POM0PCIAH);
-			writel(pcial, reg + PCIX0_POM0PCIAL);
-			writel(sa, reg + PCIX0_POM0SA);
-		} else {
-			writel(lah, reg + PCIX0_POM1LAH);
-			writel(lal, reg + PCIX0_POM1LAL);
-			writel(pciah, reg + PCIX0_POM1PCIAH);
-			writel(pcial, reg + PCIX0_POM1PCIAL);
-			writel(sa, reg + PCIX0_POM1SA);
+		/* Configure the resource */
+		if (ppc4xx_setup_one_pcix_POM(hose, reg,
+					      res->start,
+					      res->start - hose->pci_mem_offset,
+					      res->end + 1 - res->start,
+					      res->flags,
+					      j) == 0) {
+			j++;
+
+			/* If the resource PCI address is 0 then we have our
+			 * ISA memory hole
+			 */
+			if (res->start == hose->pci_mem_offset)
+				found_isa_hole = 1;
 		}
-		j++;
 	}
+
+	/* Handle ISA memory hole if not already covered */
+	if (j <= 1 && !found_isa_hole && hose->isa_mem_size)
+		if (ppc4xx_setup_one_pcix_POM(hose, reg, hose->isa_mem_phys, 0,
+					      hose->isa_mem_size, 0, j) == 0)
+			printk(KERN_INFO "%s: Legacy ISA memory support enabled\n",
+			       hose->dn->full_name);
 }
 
 static void __init ppc4xx_configure_pcix_PIMs(struct pci_controller *hose,
@@ -1314,12 +1379,72 @@ static struct pci_ops ppc4xx_pciex_pci_o
 	.write = ppc4xx_pciex_write_config,
 };
 
+static int __init ppc4xx_setup_one_pciex_POM(struct ppc4xx_pciex_port	*port,
+					     struct pci_controller	*hose,
+					     void __iomem		*mbase,
+					     u64			plb_addr,
+					     u64			pci_addr,
+					     u64			size,
+					     unsigned int		flags,
+					     int			index)
+{
+	u32 lah, lal, pciah, pcial, sa;
+
+	if (!is_power_of_2(size) ||
+	    (index < 2 && size < 0x100000) ||
+	    (index == 2 && size < 0x100) ||
+	    (plb_addr & (size - 1)) != 0) {
+		printk(KERN_WARNING "%s: Resource out of range\n",
+		       hose->dn->full_name);
+		return -1;
+	}
+
+	/* Calculate register values */
+	lah = RES_TO_U32_HIGH(plb_addr);
+	lal = RES_TO_U32_LOW(plb_addr);
+	pciah = RES_TO_U32_HIGH(pci_addr);
+	pcial = RES_TO_U32_LOW(pci_addr);
+	sa = (0xffffffffu << ilog2(size)) | 0x1;
+
+	/* Program register values */
+	switch (index) {
+	case 0:
+		out_le32(mbase + PECFG_POM0LAH, pciah);
+		out_le32(mbase + PECFG_POM0LAL, pcial);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR1BAH, lah);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR1BAL, lal);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKH, 0x7fffffff);
+		/* Note that 3 here means enabled | single region */
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL, sa | 3);
+		break;
+	case 1:
+		out_le32(mbase + PECFG_POM1LAH, pciah);
+		out_le32(mbase + PECFG_POM1LAL, pcial);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAH, lah);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAL, lal);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKH, 0x7fffffff);
+		/* Note that 3 here means enabled | single region */
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKL, sa | 3);
+		break;
+	case 2:
+		out_le32(mbase + PECFG_POM2LAH, pciah);
+		out_le32(mbase + PECFG_POM2LAL, pcial);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR3BAH, lah);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR3BAL, lal);
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR3MSKH, 0x7fffffff);
+		/* Note that 3 here means enabled | IO space !!! */
+		dcr_write(port->dcrs, DCRO_PEGPL_OMR3MSKL, sa | 3);
+		break;
+	}
+
+	return 0;
+}
+
 static void __init ppc4xx_configure_pciex_POMs(struct ppc4xx_pciex_port *port,
 					       struct pci_controller *hose,
 					       void __iomem *mbase)
 {
-	u32 lah, lal, pciah, pcial, sa;
-	int i, j;
+	int i, j, found_isa_hole = 0;
 
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
@@ -1334,53 +1459,38 @@ static void __init ppc4xx_configure_pcie
 			break;
 		}
 
-		/* Calculate register values */
-		lah = RES_TO_U32_HIGH(res->start);
-		lal = RES_TO_U32_LOW(res->start);
-		pciah = RES_TO_U32_HIGH(res->start - hose->pci_mem_offset);
-		pcial = RES_TO_U32_LOW(res->start - hose->pci_mem_offset);
-		sa = res->end + 1 - res->start;
-		if (!is_power_of_2(sa) || sa < 0x100000 ||
-		    sa > 0xffffffffu) {
-			printk(KERN_WARNING "%s: Resource out of range\n",
-			       port->node->full_name);
-			continue;
-		}
-		sa = (0xffffffffu << ilog2(sa)) | 0x1;
-
-		/* Program register values */
-		switch (j) {
-		case 0:
-			out_le32(mbase + PECFG_POM0LAH, pciah);
-			out_le32(mbase + PECFG_POM0LAL, pcial);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR1BAH, lah);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR1BAL, lal);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKH, 0x7fffffff);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL, sa | 3);
-			break;
-		case 1:
-			out_le32(mbase + PECFG_POM1LAH, pciah);
-			out_le32(mbase + PECFG_POM1LAL, pcial);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAH, lah);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAL, lal);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKH, 0x7fffffff);
-			dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKL, sa | 3);
-			break;
+		/* Configure the resource */
+		if (ppc4xx_setup_one_pciex_POM(port, hose, mbase,
+					       res->start,
+					       res->start - hose->pci_mem_offset,
+					       res->end + 1 - res->start,
+					       res->flags,
+					       j) == 0) {
+			j++;
+
+			/* If the resource PCI address is 0 then we have our
+			 * ISA memory hole
+			 */
+			if (res->start == hose->pci_mem_offset)
+				found_isa_hole = 1;
 		}
-		j++;
 	}
 
-	/* Configure IO, always 64K starting at 0 */
-	if (hose->io_resource.flags & IORESOURCE_IO) {
-		lah = RES_TO_U32_HIGH(hose->io_base_phys);
-		lal = RES_TO_U32_LOW(hose->io_base_phys);
-		out_le32(mbase + PECFG_POM2LAH, 0);
-		out_le32(mbase + PECFG_POM2LAL, 0);
-		dcr_write(port->dcrs, DCRO_PEGPL_OMR3BAH, lah);
-		dcr_write(port->dcrs, DCRO_PEGPL_OMR3BAL, lal);
-		dcr_write(port->dcrs, DCRO_PEGPL_OMR3MSKH, 0x7fffffff);
-		dcr_write(port->dcrs, DCRO_PEGPL_OMR3MSKL, 0xffff0000 | 3);
-	}
+	/* Handle ISA memory hole if not already covered */
+	if (j <= 1 && !found_isa_hole && hose->isa_mem_size)
+		if (ppc4xx_setup_one_pciex_POM(port, hose, mbase,
+					       hose->isa_mem_phys, 0,
+					       hose->isa_mem_size, 0, j) == 0)
+			printk(KERN_INFO "%s: Legacy ISA memory support enabled\n",
+			       hose->dn->full_name);
+
+	/* Configure IO, always 64K starting at 0. We hard wire it to 64K !
+	 * Note also that it -has- to be region index 2 on this HW
+	 */
+	if (hose->io_resource.flags & IORESOURCE_IO)
+		ppc4xx_setup_one_pciex_POM(port, hose, mbase,
+					   hose->io_base_phys, 0,
+					   0x10000, IORESOURCE_IO, 2);
 }
 
 static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
Index: linux-work/arch/powerpc/boot/dts/bamboo.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2008-10-10 11:25:19.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2008-10-10 11:27:11.000000000 +1100
@@ -269,7 +269,8 @@
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <0x02000000 0x00000000 0xa0000000 0x00000000 0xa0000000 0x00000000 0x20000000
+			ranges = <0x02000000 0x00000000 0xa0000000 0x00000000 0xa0000000 0x00000000 0x40000000
+				  0x02000000 0x00000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
Index: linux-work/arch/powerpc/boot/dts/canyonlands.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/canyonlands.dts	2008-10-10 11:27:27.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/canyonlands.dts	2008-10-10 11:34:26.000000000 +1100
@@ -343,6 +343,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000c 0x0ee00000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
@@ -373,6 +374,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00000000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
@@ -414,6 +416,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00100000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
