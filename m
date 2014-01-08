Return-Path: <Minghuan.Lian@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DF4C2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 16:01:55 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 05/12][v4] pci: fsl: port PCI ATMU related code
Date: Wed, 8 Jan 2014 13:01:56 +0800
Message-ID: <1389157323-3088-5-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch ports PCI ATMU related code, just uses general IO API
iowrite32be/ioread32be instead of out_be32/in_be32, uses structure
fsl_pci instead of PowerPC's pci_controller and uses dev_*()
instead of pr_*() to output the information.
The patch also provides the weak function
fsl_arch_pci64_dma_offset(), the architecture-specific driver may
return different offset.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 190 ++++++++++++++++++++------------------
 include/linux/fsl/pci-common.h    |   3 +
 2 files changed, 103 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index a706100..26ee4c3 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -35,6 +35,10 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+u64 __weak fsl_arch_pci64_dma_offset(void)
+{
+	return 0;
+}
 
 int __weak fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn)
 {
@@ -225,8 +229,8 @@ static int early_fsl_find_capability(struct fsl_pci *pci,
 }
 
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
-	unsigned int index, const struct resource *res,
-	resource_size_t offset)
+			  unsigned int index, const struct resource *res,
+			  resource_size_t offset)
 {
 	resource_size_t pci_addr = res->start - offset;
 	resource_size_t phys_addr = res->start;
@@ -247,10 +251,10 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 		if (index + i >= 5)
 			return -1;
 
-		out_be32(&pci->pow[index + i].potar, pci_addr >> 12);
-		out_be32(&pci->pow[index + i].potear, (u64)pci_addr >> 44);
-		out_be32(&pci->pow[index + i].powbar, phys_addr >> 12);
-		out_be32(&pci->pow[index + i].powar, flags | (bits - 1));
+		iowrite32be(pci_addr >> 12, &pci->pow[index + i].potar);
+		iowrite32be((u64)pci_addr >> 44, &pci->pow[index + i].potear);
+		iowrite32be(phys_addr >> 12, &pci->pow[index + i].powbar);
+		iowrite32be(flags | (bits - 1), &pci->pow[index + i].powar);
 
 		pci_addr += (resource_size_t)1U << bits;
 		phys_addr += (resource_size_t)1U << bits;
@@ -261,21 +265,19 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 }
 
 /* atmu setup for fsl pci/pcie controller */
-static void setup_pci_atmu(struct pci_controller *hose)
+static void setup_pci_atmu(struct fsl_pci *pci)
 {
-	struct ccsr_pci __iomem *pci = hose->private_data;
 	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
 	u64 mem, sz, paddr_hi = 0;
 	u64 offset = 0, paddr_lo = ULLONG_MAX;
 	u32 pcicsrbar = 0, pcicsrbar_sz;
 	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
 			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
-	const char *name = hose->dn->full_name;
 	const u64 *reg;
 	int len;
 
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
+	if (pci->is_pcie) {
+		if (in_be32(&pci->regs->block_rev1) >= PCIE_IP_REV_2_2) {
 			win_idx = 2;
 			start_idx = 0;
 			end_idx = 3;
@@ -283,47 +285,54 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	/* Disable all windows (except powar0 since it's ignored) */
-	for(i = 1; i < 5; i++)
-		out_be32(&pci->pow[i].powar, 0);
+	for (i = 1; i < 5; i++)
+		iowrite32be(0, &pci->regs->pow[i].powar);
 	for (i = start_idx; i < end_idx; i++)
-		out_be32(&pci->piw[i].piwar, 0);
+		iowrite32be(0, &pci->regs->piw[i].piwar);
 
 	/* Setup outbound MEM window */
-	for(i = 0, j = 1; i < 3; i++) {
-		if (!(hose->mem_resources[i].flags & IORESOURCE_MEM))
+	for (i = 0, j = 1; i < 3; i++) {
+		if (!(pci->mem_resources[i].flags & IORESOURCE_MEM))
 			continue;
 
-		paddr_lo = min(paddr_lo, (u64)hose->mem_resources[i].start);
-		paddr_hi = max(paddr_hi, (u64)hose->mem_resources[i].end);
+		paddr_lo = min_t(u64, paddr_lo, pci->mem_resources[i].start);
+		paddr_hi = max_t(u64, paddr_hi, pci->mem_resources[i].end);
 
 		/* We assume all memory resources have the same offset */
-		offset = hose->mem_offset[i];
-		n = setup_one_atmu(pci, j, &hose->mem_resources[i], offset);
+		offset = pci->mem_offset[i];
+		n = setup_one_atmu(pci->regs, j, &pci->mem_resources[i],
+				   offset);
 
 		if (n < 0 || j >= 5) {
-			pr_err("Ran out of outbound PCI ATMUs for resource %d!\n", i);
-			hose->mem_resources[i].flags |= IORESOURCE_DISABLED;
+			dev_err(pci->dev,
+				"Ran out of outbound PCI ATMUs for resource %d!\n",
+				i);
+			pci->mem_resources[i].flags |= IORESOURCE_DISABLED;
 		} else
 			j += n;
 	}
 
 	/* Setup outbound IO window */
-	if (hose->io_resource.flags & IORESOURCE_IO) {
-		if (j >= 5) {
-			pr_err("Ran out of outbound PCI ATMUs for IO resource\n");
-		} else {
-			pr_debug("PCI IO resource start 0x%016llx, size 0x%016llx, "
-				 "phy base 0x%016llx.\n",
-				 (u64)hose->io_resource.start,
-				 (u64)resource_size(&hose->io_resource),
-				 (u64)hose->io_base_phys);
-			out_be32(&pci->pow[j].potar, (hose->io_resource.start >> 12));
-			out_be32(&pci->pow[j].potear, 0);
-			out_be32(&pci->pow[j].powbar, (hose->io_base_phys >> 12));
+	if (pci->io_resource.flags & IORESOURCE_IO) {
+		if (j >= 5)
+			dev_err(pci->dev,
+				"Ran out of outbound PCI ATMUs for IO resource\n");
+		else {
+			dev_dbg(pci->dev,
+				 "PCI IO resource start 0x%016llx,"
+				 "size 0x%016llx, phy base 0x%016llx.\n",
+				 (u64)pci->io_resource.start,
+				 (u64)resource_size(&pci->io_resource),
+				 (u64)pci->io_base_phys);
+			iowrite32be(pci->io_resource.start >> 12,
+				    &pci->regs->pow[j].potar);
+			iowrite32be(0, &pci->regs->pow[j].potear);
+			iowrite32be(pci->io_base_phys >> 12,
+				    &pci->regs->pow[j].powbar);
 			/* Enable, IO R/W */
-			out_be32(&pci->pow[j].powar, 0x80088000
-				| (ilog2(hose->io_resource.end
-				- hose->io_resource.start + 1) - 1));
+			iowrite32be(0x80088000 |
+				  (ilog2(resource_size(&pci->io_resource)) - 1),
+				  &pci->regs->pow[j].powar);
 		}
 	}
 
@@ -332,18 +341,20 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	paddr_lo -= offset;
 
 	if (paddr_hi == paddr_lo) {
-		pr_err("%s: No outbound window space\n", name);
+		dev_err(pci->dev, "No outbound window space\n");
 		return;
 	}
 
 	if (paddr_lo == 0) {
-		pr_err("%s: No space for inbound window\n", name);
+		dev_err(pci->dev, "No space for inbound window\n");
 		return;
 	}
 
 	/* setup PCSRBAR/PEXCSRBAR */
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, 0xffffffff);
-	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, &pcicsrbar_sz);
+	early_fsl_write_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				     0xffffffff);
+	early_fsl_read_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				    &pcicsrbar_sz);
 	pcicsrbar_sz = ~pcicsrbar_sz + 1;
 
 	if (paddr_hi < (0x100000000ull - pcicsrbar_sz) ||
@@ -351,11 +362,12 @@ static void setup_pci_atmu(struct pci_controller *hose)
 		pcicsrbar = 0x100000000ull - pcicsrbar_sz;
 	else
 		pcicsrbar = (paddr_lo - pcicsrbar_sz) & -pcicsrbar_sz;
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, pcicsrbar);
+	early_fsl_write_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				     pcicsrbar);
 
-	paddr_lo = min(paddr_lo, (u64)pcicsrbar);
+	paddr_lo = min_t(u64, paddr_lo, pcicsrbar);
 
-	pr_info("%s: PCICSRBAR @ 0x%x\n", name, pcicsrbar);
+	dev_info(pci->dev, "PCICSRBAR @ 0x%x\n", pcicsrbar);
 
 	/* Setup inbound mem window */
 	mem = memblock_end_of_DRAM();
@@ -372,17 +384,19 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	 * can avoid allocating a new ATMU by extending the DDR ATMU by one
 	 * page.
 	 */
-	reg = of_get_property(hose->dn, "msi-address-64", &len);
+	reg = of_get_property(pci->dn, "msi-address-64", &len);
 	if (reg && (len == sizeof(u64))) {
 		u64 address = be64_to_cpup(reg);
 
 		if ((address >= mem) && (address < (mem + PAGE_SIZE))) {
-			pr_info("%s: extending DDR ATMU to cover MSIIR", name);
+			dev_info(pci->dev,
+				 "extending DDR ATMU to cover MSIIR\n");
 			mem += PAGE_SIZE;
 		} else {
 			/* TODO: Create a new ATMU for MSIIR */
-			pr_warn("%s: msi-address-64 address of %llx is "
-				"unsupported\n", name, address);
+			dev_warn(pci->dev,
+				 "msi-address-64 address of %llx is "
+				 "unsupported\n", address);
 		}
 	}
 
@@ -390,25 +404,26 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	mem_log = ilog2(sz);
 
 	/* PCIe can overmap inbound & outbound since RX & TX are separated */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+	if (pci->is_pcie) {
 		/* Size window to exact size if power-of-two or one size up */
 		if ((1ull << mem_log) != mem) {
 			mem_log++;
 			if ((1ull << mem_log) > mem)
-				pr_info("%s: Setting PCI inbound window "
-					"greater than memory size\n", name);
+				dev_info(pci->dev,
+					 "Setting PCI inbound window "
+					 "greater than memory size\n");
 		}
 
 		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
 
 		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-		out_be32(&pci->piw[win_idx].piwbar, 0x00000000);
-		out_be32(&pci->piw[win_idx].piwar,  piwar);
+		iowrite32be(0, &pci->regs->piw[win_idx].pitar);
+		iowrite32be(0, &pci->regs->piw[win_idx].piwbar);
+		iowrite32be(piwar, &pci->regs->piw[win_idx].piwar);
 		win_idx--;
 
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)sz;
+		pci->dma_window_base_cur = 0x00000000;
+		pci->dma_window_size = (resource_size_t)sz;
 
 		/*
 		 * if we have >4G of memory setup second PCI inbound window to
@@ -425,28 +440,22 @@ static void setup_pci_atmu(struct pci_controller *hose)
 			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
 
 			/* Setup inbound memory window */
-			out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-			out_be32(&pci->piw[win_idx].piwbear,
-					pci64_dma_offset >> 44);
-			out_be32(&pci->piw[win_idx].piwbar,
-					pci64_dma_offset >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
-
-			/*
-			 * install our own dma_set_mask handler to fixup dma_ops
-			 * and dma_offset
-			 */
-			ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
-
-			pr_info("%s: Setup 64-bit PCI DMA window\n", name);
+			iowrite32be(0, &pci->regs->piw[win_idx].pitar);
+			iowrite32be(fsl_arch_pci64_dma_offset() >> 44,
+				    &pci->regs->piw[win_idx].piwbear);
+			iowrite32be(fsl_arch_pci64_dma_offset() >> 12,
+				    &pci->regs->piw[win_idx].piwbar);
+			iowrite32be(piwar,
+				    &pci->regs->piw[win_idx].piwar);
 		}
 	} else {
 		u64 paddr = 0;
 
 		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwar,  (piwar | (mem_log - 1)));
+		iowrite32be(paddr >> 12, &pci->regs->piw[win_idx].pitar);
+		iowrite32be(paddr >> 12, &pci->regs->piw[win_idx].piwbar);
+		iowrite32be((piwar | (mem_log - 1)),
+			    &pci->regs->piw[win_idx].piwar);
 		win_idx--;
 
 		paddr += 1ull << mem_log;
@@ -456,35 +465,36 @@ static void setup_pci_atmu(struct pci_controller *hose)
 			mem_log = ilog2(sz);
 			piwar |= (mem_log - 1);
 
-			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
+			iowrite32be(paddr >> 12,
+				    &pci->regs->piw[win_idx].pitar);
+			iowrite32be(paddr >> 12,
+				    &pci->regs->piw[win_idx].piwbar);
+			iowrite32be(piwar,
+				    &pci->regs->piw[win_idx].piwar);
 			win_idx--;
 
 			paddr += 1ull << mem_log;
 		}
 
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)paddr;
+		pci->dma_window_base_cur = 0x00000000;
+		pci->dma_window_size = (resource_size_t)paddr;
 	}
 
-	if (hose->dma_window_size < mem) {
-#ifdef CONFIG_SWIOTLB
-		ppc_swiotlb_enable = 1;
-#else
-		pr_err("%s: ERROR: Memory size exceeds PCI ATMU ability to "
-			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
-			 name);
+	if (pci->dma_window_size < mem) {
+#ifndef CONFIG_SWIOTLB
+		dev_err(pci->dev,
+			"Memory size exceeds PCI ATMU ability to "
+			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n");
 #endif
 		/* adjusting outbound windows could reclaim space in mem map */
 		if (paddr_hi < 0xffffffffull)
-			pr_warning("%s: WARNING: Outbound window cfg leaves "
+			dev_warn(pci->dev,
+				 "Outbound window cfg leaves "
 				"gaps in memory map. Adjusting the memory map "
-				"could reduce unnecessary bounce buffering.\n",
-				name);
+				"could reduce unnecessary bounce buffering.\n");
 
-		pr_info("%s: DMA window size is 0x%llx\n", name,
-			(u64)hose->dma_window_size);
+		dev_info(pci->dev, "DMA window size is 0x%llx\n",
+			 (u64)pci->dma_window_size);
 	}
 }
 
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index fd6c497..02bcf5b 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -163,5 +163,8 @@ int fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn);
  */
 extern struct pci_bus *fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr);
 
+/* Return PCI64 DMA offset */
+u64 fsl_arch_pci64_dma_offset(void);
+
 #endif /* __PCI_COMMON_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2
