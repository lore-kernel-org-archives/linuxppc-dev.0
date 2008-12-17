Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14B37DDF21
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 06:43:32 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] POWERPC/fsl-pci: Better ATMU setup
Date: Wed, 17 Dec 2008 11:43:25 -0800
Message-Id: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code that sets up the outbound ATMU windows, which is used to map CPU
physical addresses into PCI bus addresses where BARs will be mapped, didn't
work so well.

For one, it leaked the ioremap() of the ATMU registers.  Another small bug
was the high 20 bits of the PCI bus address were left as zero.  It's legal
for prefetchable memory regions to be above 32 bits, so the high 20 bits
might not be zero.

Mainly, it couldn't handle ranges that were not a power of two in size or
were not naturally aligned.  The ATMU windows have these requirements (size
& alignment), but the code didn't bother to check if the ranges it was
programming met them.  If they didn't, the windows would silently be
programmed incorrectly.

This new code can handle ranges which are not power of two sized nor
naturally aligned.  It simply splits the ranges into multiple valid ATMU
windows.  As there are only four windows, pooly aligned or sized ranges
(which didn't even work before) may run out of windows.  In this case an
error is printed and an effort is made to disable the unmapped resources.

An improvement that could be made would be to make use of the default
outbound window.  Iff hose->pci_mem_offset is zero, then it's possible that
some or all of the ranges might not need an outbound window and could just
use the default window.

The default ATMU window can support a pci_mem_offset less than zero too,
but pci_mem_offset is unsigned.  One could say the abilities allowed a
powerpc pci_controller is neither subset nor a superset of the abilities of
a Freescale PCIe controller.  Thankfully, the most useful bits are in the
intersection of the two abilities.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |  104 ++++++++++++++++++++++++++++-------------
 1 files changed, 71 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 5b264eb..656f914 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -28,62 +28,100 @@
 #include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
+static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
+	unsigned int index, const struct resource *res,
+	resource_size_t offset)
+{
+	resource_size_t pci_addr = res->start - offset;
+	resource_size_t phys_addr = res->start;
+	resource_size_t size = res->end - res->start + 1;
+	u32 flags = 0x80044000; /* enable & mem R/W */
+	unsigned int i;
+
+	pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
+		(u64)res->start, (u64)size);
+
+	for (i = 0; size > 0; i++) {
+		unsigned int bits = min(__ilog2(size),
+					__ffs(pci_addr | phys_addr));
+
+		if (index + i >= 5)
+			return -1;
+
+		out_be32(&pci->pow[index + i].potar, pci_addr >> 12);
+		out_be32(&pci->pow[index + i].potear, (u64)pci_addr >> 44);
+		out_be32(&pci->pow[index + i].powbar, phys_addr >> 12);
+		out_be32(&pci->pow[index + i].powar, flags | (bits - 1));
+
+		pci_addr += (resource_size_t)1U << bits;
+		phys_addr += (resource_size_t)1U << bits;
+		size -= (resource_size_t)1U << bits;
+	}
+
+	return i;
+}
+
 /* atmu setup for fsl pci/pcie controller */
 void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 {
 	struct ccsr_pci __iomem *pci;
-	int i;
+	int i, j, n;
 
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
 	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+	if (!pci) {
+	    dev_err(hose->parent, "Unable to map ATMU registers\n");
+	    return;
+	}
 
-	/* Disable all windows (except powar0 since its ignored) */
+	/* Disable all windows (except powar0 since it's ignored) */
 	for(i = 1; i < 5; i++)
 		out_be32(&pci->pow[i].powar, 0);
 	for(i = 0; i < 3; i++)
 		out_be32(&pci->piw[i].piwar, 0);
 
 	/* Setup outbound MEM window */
-	for(i = 0; i < 3; i++)
-		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
-			resource_size_t pci_addr_start =
-				 hose->mem_resources[i].start -
-				 hose->pci_mem_offset;
-			pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
-				(u64)hose->mem_resources[i].start,
-				(u64)hose->mem_resources[i].end
-				  - (u64)hose->mem_resources[i].start + 1);
-			out_be32(&pci->pow[i+1].potar, (pci_addr_start >> 12));
-			out_be32(&pci->pow[i+1].potear, 0);
-			out_be32(&pci->pow[i+1].powbar,
-				(hose->mem_resources[i].start >> 12));
-			/* Enable, Mem R/W */
-			out_be32(&pci->pow[i+1].powar, 0x80044000
-				| (__ilog2(hose->mem_resources[i].end
-				- hose->mem_resources[i].start + 1) - 1));
-		}
+	for(i = 0, j = 1; i < 3; i++) {
+		if (!(hose->mem_resources[i].flags & IORESOURCE_MEM))
+			continue;
+
+		n = setup_one_atmu(pci, j, &hose->mem_resources[i],
+				   hose->pci_mem_offset);
+
+		if (n < 0 || j >= 5) {
+			pr_err("Ran out of outbound PCI ATMUs for resource %d!\n", i);
+			hose->mem_resources[i].flags |= IORESOURCE_DISABLED;
+		} else
+			j += n;
+	}
 
 	/* Setup outbound IO window */
-	if (hose->io_resource.flags & IORESOURCE_IO){
-		pr_debug("PCI IO resource start 0x%016llx, size 0x%016llx, "
-			 "phy base 0x%016llx.\n",
-			(u64)hose->io_resource.start,
-			(u64)hose->io_resource.end - (u64)hose->io_resource.start + 1,
-			(u64)hose->io_base_phys);
-		out_be32(&pci->pow[i+1].potar, (hose->io_resource.start >> 12));
-		out_be32(&pci->pow[i+1].potear, 0);
-		out_be32(&pci->pow[i+1].powbar, (hose->io_base_phys >> 12));
-		/* Enable, IO R/W */
-		out_be32(&pci->pow[i+1].powar, 0x80088000
-			| (__ilog2(hose->io_resource.end
-			- hose->io_resource.start + 1) - 1));
+	if (hose->io_resource.flags & IORESOURCE_IO) {
+		if (j >= 5) {
+			pr_err("Ran out of outbound PCI ATMUs for IO resource\n");
+		} else {
+			pr_debug("PCI IO resource start 0x%016llx, size 0x%016llx, "
+				 "phy base 0x%016llx.\n",
+				(u64)hose->io_resource.start,
+				(u64)hose->io_resource.end - (u64)hose->io_resource.start + 1,
+				(u64)hose->io_base_phys);
+			out_be32(&pci->pow[j].potar, (hose->io_resource.start >> 12));
+			out_be32(&pci->pow[j].potear, 0);
+			out_be32(&pci->pow[j].powbar, (hose->io_base_phys >> 12));
+			/* Enable, IO R/W */
+			out_be32(&pci->pow[j].powar, 0x80088000
+				| (__ilog2(hose->io_resource.end
+				- hose->io_resource.start + 1) - 1));
+		}
 	}
 
 	/* Setup 2G inbound Memory Window @ 1 */
 	out_be32(&pci->piw[2].pitar, 0x00000000);
 	out_be32(&pci->piw[2].piwbar,0x00000000);
 	out_be32(&pci->piw[2].piwar, PIWAR_2G);
+
+	iounmap(pci);
 }
 
 void __init setup_pci_cmd(struct pci_controller *hose)
-- 
1.5.4.1
