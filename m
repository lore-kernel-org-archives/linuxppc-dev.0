Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A1232C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 16:50:43 +1000 (EST)
Message-ID: <1367823016.15842.22.camel@pasglop>
Subject: [PATCH] powerpc/pci: Support per-aperture memory offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 06 May 2013 16:50:16 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Murray <Andrew.Murray@arm.com>, Scott Wood <scottwood@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI core supports an offset per aperture nowadays but our arch
code still has a single offset per host bridge representing the
difference betwen CPU memory addresses and PCI MMIO addresses.

This is a problem as new machines and hypervisor versions are
coming out where the 64-bit windows will have a different offset
(basically mapped 1:1) from the 32-bit windows.

This fixes it by using separate offsets. In the long run, we probably
want to get rid of that intermediary struct pci_controller and have
those directly stored into the pci_host_bridge as they are parsed
but this will be a more invasive change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Now, this is a big one but I'd like to still merge it for 3.10 because
we're having new machine coming up (and new versions of pHyp on existing
machines) that are going to expose MMIO windows with different offsets
(basically our 64-bit windows are 1:1 and our 32-bit windows remapped).

I'm not expecting any major issue with the patch, I've tested it on some
of our machines here and will test it more during the next couple of days
the notable thing is the removal of a "workaround" / fallback on 32-bit
that I suspect only ever mattered for machines long unsupported (PReP ?)
as I don't think we have anything that doesn't populate the bridge
resources and expects to work nowadays (other stuff would break anyway).

This is also why I'm NAK'ing the patch making pci_process_bridge_OF_ranges()
generic since I need to change it for powerpc and this isn't the right
long term approach (we should "merge" pci_controller & pci_host_bridge
instead and directly populate the pci_host_bridge apertures).

If I see no major issue with the patch during the next few days, I'll send
it to Linus with my next pull request, probably at -rc1.

Kumar, Scott, Sethi, please test on FSL HW. I'll take care of macs and 4xx
in addition to the various IBM ppc64 platforms.

Ben.

 arch/powerpc/include/asm/pci-bridge.h       |    6 +-
 arch/powerpc/kernel/pci-common.c            |   97 ++++++++-------------------
 arch/powerpc/kernel/pci_32.c                |    2 +-
 arch/powerpc/kernel/pci_64.c                |    2 +-
 arch/powerpc/platforms/embedded6xx/mpc10x.h |   11 ---
 arch/powerpc/platforms/powermac/pci.c       |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c   |   10 +--
 arch/powerpc/platforms/wsp/wsp_pci.c        |    2 +-
 arch/powerpc/sysdev/fsl_pci.c               |   11 +--
 arch/powerpc/sysdev/ppc4xx_pci.c            |   15 +++--
 10 files changed, 54 insertions(+), 104 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 0694f73..8b11b5b 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -39,11 +39,6 @@ struct pci_controller {
 	resource_size_t io_base_phys;
 	resource_size_t pci_io_size;
 
-	/* Some machines (PReP) have a non 1:1 mapping of
-	 * the PCI memory space in the CPU bus space
-	 */
-	resource_size_t pci_mem_offset;
-
 	/* Some machines have a special region to forward the ISA
 	 * "memory" cycles such as VGA memory regions. Left to 0
 	 * if unsupported
@@ -86,6 +81,7 @@ struct pci_controller {
 	 */
 	struct resource	io_resource;
 	struct resource mem_resources[3];
+	resource_size_t mem_offset[3];
 	int global_number;		/* PCI domain number */
 
 	resource_size_t dma_window_base_cur;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cf00588..f5c5c90 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -786,22 +786,8 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 				hose->isa_mem_size = size;
 			}
 
-			/* We get the PCI/Mem offset from the first range or
-			 * the, current one if the offset came from an ISA
-			 * hole. If they don't match, bugger.
-			 */
-			if (memno == 0 ||
-			    (isa_hole >= 0 && pci_addr != 0 &&
-			     hose->pci_mem_offset == isa_mb))
-				hose->pci_mem_offset = cpu_addr - pci_addr;
-			else if (pci_addr != 0 &&
-				 hose->pci_mem_offset != cpu_addr - pci_addr) {
-				printk(KERN_INFO
-				       " \\--> Skipped (offset mismatch) !\n");
-				continue;
-			}
-
 			/* Build resource */
+			hose->mem_offset[memno] = cpu_addr - pci_addr;
 			res = &hose->mem_resources[memno++];
 			res->flags = IORESOURCE_MEM;
 			if (pci_space & 0x40000000)
@@ -817,20 +803,6 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			res->child = NULL;
 		}
 	}
-
-	/* If there's an ISA hole and the pci_mem_offset is -not- matching
-	 * the ISA hole offset, then we need to remove the ISA hole from
-	 * the resource list for that brige
-	 */
-	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
-		unsigned int next = isa_hole + 1;
-		printk(KERN_INFO " Removing ISA hole at 0x%016llx\n", isa_mb);
-		if (next < memno)
-			memmove(&hose->mem_resources[isa_hole],
-				&hose->mem_resources[next],
-				sizeof(struct resource) * (memno - next));
-		hose->mem_resources[--memno].flags = 0;
-	}
 }
 
 /* Decide whether to display the domain number in /proc */
@@ -916,6 +888,7 @@ static int pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pci_dev *dev = bus->self;
 	resource_size_t offset;
+	struct pci_bus_region region;
 	u16 command;
 	int i;
 
@@ -925,10 +898,10 @@ static int pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 
 	/* Job is a bit different between memory and IO */
 	if (res->flags & IORESOURCE_MEM) {
-		/* If the BAR is non-0 (res != pci_mem_offset) then it's probably been
-		 * initialized by somebody
-		 */
-		if (res->start != hose->pci_mem_offset)
+		pcibios_resource_to_bus(dev, &region, res);
+
+		/* If the BAR is non-0 then it's probably been initialized */
+		if (region.start != 0)
 			return 0;
 
 		/* The BAR is 0, let's check if memory decoding is enabled on
@@ -940,11 +913,11 @@ static int pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 
 		/* Memory decoding is enabled and the BAR is 0. If any of the bridge
 		 * resources covers that starting address (0 then it's good enough for
-		 * us for memory
+		 * us for memory space)
 		 */
 		for (i = 0; i < 3; i++) {
 			if ((hose->mem_resources[i].flags & IORESOURCE_MEM) &&
-			    hose->mem_resources[i].start == hose->pci_mem_offset)
+			    hose->mem_resources[i].start == hose->mem_offset[i])
 				return 0;
 		}
 
@@ -1381,10 +1354,9 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
 
  no_io:
 	/* Check for memory */
-	offset = hose->pci_mem_offset;
-	pr_debug("hose mem offset: %016llx\n", (unsigned long long)offset);
 	for (i = 0; i < 3; i++) {
 		pres = &hose->mem_resources[i];
+		offset = hose->mem_offset[i];
 		if (!(pres->flags & IORESOURCE_MEM))
 			continue;
 		pr_debug("hose mem res: %pR\n", pres);
@@ -1524,6 +1496,7 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 					struct list_head *resources)
 {
 	struct resource *res;
+	resource_size_t offset;
 	int i;
 
 	/* Hookup PHB IO resource */
@@ -1533,51 +1506,37 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 		printk(KERN_WARNING "PCI: I/O resource not set for host"
 		       " bridge %s (domain %d)\n",
 		       hose->dn->full_name, hose->global_number);
-#ifdef CONFIG_PPC32
-		/* Workaround for lack of IO resource only on 32-bit */
-		res->start = (unsigned long)hose->io_base_virt - isa_io_base;
-		res->end = res->start + IO_SPACE_LIMIT;
-		res->flags = IORESOURCE_IO;
-#endif /* CONFIG_PPC32 */
-	}
-	if (res->flags) {
-		pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
+	} else {
+		offset = pcibios_io_space_offset(hose);
+
+		pr_debug("PCI: PHB IO resource    = %08llx-%08llx [%lx] off 0x%08llx\n",
 			 (unsigned long long)res->start,
 			 (unsigned long long)res->end,
-			 (unsigned long)res->flags);
-		pci_add_resource_offset(resources, res, pcibios_io_space_offset(hose));
-
-		pr_debug("PCI: PHB IO  offset     = %08lx\n",
-			 (unsigned long)hose->io_base_virt - _IO_BASE);
+			 (unsigned long)res->flags,
+			 (unsigned long long)offset);
+		pci_add_resource_offset(resources, res, offset);
 	}
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
 		res = &hose->mem_resources[i];
 		if (!res->flags) {
-			if (i > 0)
-				continue;
 			printk(KERN_ERR "PCI: Memory resource 0 not set for "
 			       "host bridge %s (domain %d)\n",
 			       hose->dn->full_name, hose->global_number);
-#ifdef CONFIG_PPC32
-			/* Workaround for lack of MEM resource only on 32-bit */
-			res->start = hose->pci_mem_offset;
-			res->end = (resource_size_t)-1LL;
-			res->flags = IORESOURCE_MEM;
-#endif /* CONFIG_PPC32 */
-		}
-		if (res->flags) {
-			pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n", i,
-				 (unsigned long long)res->start,
-				 (unsigned long long)res->end,
-				 (unsigned long)res->flags);
-			pci_add_resource_offset(resources, res, hose->pci_mem_offset);
+			continue;
 		}
-	}
+		offset = hose->mem_offset[i];
 
-	pr_debug("PCI: PHB MEM offset     = %016llx\n",
-		 (unsigned long long)hose->pci_mem_offset);
+
+		pr_debug("PCI: PHB MEM resource %d = %08llx-%08llx [%lx] off 0x%08llx\n", i,
+			 (unsigned long long)res->start,
+			 (unsigned long long)res->end,
+			 (unsigned long)res->flags,
+			 (unsigned long long)offset);
+
+		pci_add_resource_offset(resources, res, offset);
+	}
 }
 
 /*
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e37c215..432459c 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -295,7 +295,7 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
 	case IOBASE_BRIDGE_NUMBER:
 		return (long)hose->first_busno;
 	case IOBASE_MEMORY:
-		return (long)hose->pci_mem_offset;
+		return (long)hose->mem_offset[0];
 	case IOBASE_IO:
 		return (long)hose->io_base_phys;
 	case IOBASE_ISA_IO:
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 51a133a..873050d 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -246,7 +246,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	case IOBASE_BRIDGE_NUMBER:
 		return (long)hose->first_busno;
 	case IOBASE_MEMORY:
-		return (long)hose->pci_mem_offset;
+		return (long)hose->mem_offset[0];
 	case IOBASE_IO:
 		return (long)hose->io_base_phys;
 	case IOBASE_ISA_IO:
diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index b30a6a3..b290b63 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -81,17 +81,6 @@
 #define	MPC10X_MAPB_PCI_MEM_OFFSET	(MPC10X_MAPB_ISA_MEM_BASE -	\
 					 MPC10X_MAPB_PCI_MEM_START)
 
-/* Set hose members to values appropriate for the mem map used */
-#define	MPC10X_SETUP_HOSE(hose, map) {					\
-	(hose)->pci_mem_offset = MPC10X_MAP##map##_PCI_MEM_OFFSET;	\
-	(hose)->io_space.start = MPC10X_MAP##map##_PCI_IO_START;	\
-	(hose)->io_space.end = MPC10X_MAP##map##_PCI_IO_END;		\
-	(hose)->mem_space.start = MPC10X_MAP##map##_PCI_MEM_START;	\
-	(hose)->mem_space.end = MPC10X_MAP##map##_PCI_MEM_END;		\
-	(hose)->io_base_virt = (void *)MPC10X_MAP##map##_ISA_IO_BASE;	\
-}
-
-
 /* Miscellaneous Configuration register offsets */
 #define	MPC10X_CFG_PIR_REG		0x09
 #define	MPC10X_CFG_PIR_HOST_BRIDGE	0x00
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 2b8af75..cf7009b 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -824,6 +824,7 @@ static void __init parse_region_decode(struct pci_controller *hose,
 			hose->mem_resources[cur].name = hose->dn->full_name;
 			hose->mem_resources[cur].start = base;
 			hose->mem_resources[cur].end = end;
+			hose->mem_offset[cur] = 0;
 			DBG("  %d: 0x%08lx-0x%08lx\n", cur, base, end);
 		} else {
 			DBG("   :           -0x%08lx\n", end);
@@ -866,7 +867,6 @@ static void __init setup_u3_ht(struct pci_controller* hose)
 	hose->io_resource.start = 0;
 	hose->io_resource.end = 0x003fffff;
 	hose->io_resource.flags = IORESOURCE_IO;
-	hose->pci_mem_offset = 0;
 	hose->first_busno = 0;
 	hose->last_busno = 0xef;
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 97b08fc..1da578b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -915,11 +915,14 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 				index++;
 			}
 		} else if (res->flags & IORESOURCE_MEM) {
+			/* WARNING: Assumes M32 is mem region 0 in PHB. We need to
+			 * harden that algorithm when we start supporting M64
+			 */
 			region.start = res->start -
-				       hose->pci_mem_offset -
+				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
 			region.end   = res->end -
-				       hose->pci_mem_offset -
+				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
 			index = region.start / phb->ioda.m32_segsize;
 
@@ -1115,8 +1118,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	phb->ioda.m32_size += 0x10000;
 
 	phb->ioda.m32_segsize = phb->ioda.m32_size / phb->ioda.total_pe;
-	phb->ioda.m32_pci_base = hose->mem_resources[0].start -
-		hose->pci_mem_offset;
+	phb->ioda.m32_pci_base = hose->mem_resources[0].start - hose->mem_offset[0];
 	phb->ioda.io_size = hose->pci_io_size;
 	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe;
 	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
diff --git a/arch/powerpc/platforms/wsp/wsp_pci.c b/arch/powerpc/platforms/wsp/wsp_pci.c
index 8e22f56..62cb527 100644
--- a/arch/powerpc/platforms/wsp/wsp_pci.c
+++ b/arch/powerpc/platforms/wsp/wsp_pci.c
@@ -502,7 +502,7 @@ static void __init wsp_pcie_configure_hw(struct pci_controller *hose)
 		 (~(hose->mem_resources[0].end -
 		    hose->mem_resources[0].start)) & 0x3ffffff0000ul);
 	out_be64(hose->cfg_data + PCIE_REG_M32A_START_ADDR,
-		 (hose->mem_resources[0].start - hose->pci_mem_offset) | 1);
+		 (hose->mem_resources[0].start - hose->mem_offset[0]) | 1);
 
 	/* Clear all TVT entries
 	 *
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index cffe7ed..028ac1f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -178,7 +178,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	struct ccsr_pci __iomem *pci = hose->private_data;
 	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
 	u64 mem, sz, paddr_hi = 0;
-	u64 paddr_lo = ULLONG_MAX;
+	u64 offset = 0, paddr_lo = ULLONG_MAX;
 	u32 pcicsrbar = 0, pcicsrbar_sz;
 	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
 			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
@@ -208,8 +208,9 @@ static void setup_pci_atmu(struct pci_controller *hose)
 		paddr_lo = min(paddr_lo, (u64)hose->mem_resources[i].start);
 		paddr_hi = max(paddr_hi, (u64)hose->mem_resources[i].end);
 
-		n = setup_one_atmu(pci, j, &hose->mem_resources[i],
-				   hose->pci_mem_offset);
+		/* We assume all memory resources have the same offset */
+		offset = hose->mem_offset[i];
+		n = setup_one_atmu(pci, j, &hose->mem_resources[i], offset);
 
 		if (n < 0 || j >= 5) {
 			pr_err("Ran out of outbound PCI ATMUs for resource %d!\n", i);
@@ -239,8 +240,8 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	/* convert to pci address space */
-	paddr_hi -= hose->pci_mem_offset;
-	paddr_lo -= hose->pci_mem_offset;
+	paddr_hi -= offset;
+	paddr_lo -= offset;
 
 	if (paddr_hi == paddr_lo) {
 		pr_err("%s: No outbound window space\n", name);
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 56e8b3c..64603a1 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -257,6 +257,7 @@ static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
 		struct resource *res = &hose->mem_resources[i];
+		resource_size_t offset = hose->mem_offset[i];
 
 		/* we only care about memory windows */
 		if (!(res->flags & IORESOURCE_MEM))
@@ -270,7 +271,7 @@ static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 		/* Configure the resource */
 		if (ppc4xx_setup_one_pci_PMM(hose, reg,
 					     res->start,
-					     res->start - hose->pci_mem_offset,
+					     res->start - offset,
 					     resource_size(res),
 					     res->flags,
 					     j) == 0) {
@@ -279,7 +280,7 @@ static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 			/* If the resource PCI address is 0 then we have our
 			 * ISA memory hole
 			 */
-			if (res->start == hose->pci_mem_offset)
+			if (res->start == offset)
 				found_isa_hole = 1;
 		}
 	}
@@ -457,6 +458,7 @@ static void __init ppc4xx_configure_pcix_POMs(struct pci_controller *hose,
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
 		struct resource *res = &hose->mem_resources[i];
+		resource_size_t offset = hose->mem_offset[i];
 
 		/* we only care about memory windows */
 		if (!(res->flags & IORESOURCE_MEM))
@@ -470,7 +472,7 @@ static void __init ppc4xx_configure_pcix_POMs(struct pci_controller *hose,
 		/* Configure the resource */
 		if (ppc4xx_setup_one_pcix_POM(hose, reg,
 					      res->start,
-					      res->start - hose->pci_mem_offset,
+					      res->start - offset,
 					      resource_size(res),
 					      res->flags,
 					      j) == 0) {
@@ -479,7 +481,7 @@ static void __init ppc4xx_configure_pcix_POMs(struct pci_controller *hose,
 			/* If the resource PCI address is 0 then we have our
 			 * ISA memory hole
 			 */
-			if (res->start == hose->pci_mem_offset)
+			if (res->start == offset)
 				found_isa_hole = 1;
 		}
 	}
@@ -1792,6 +1794,7 @@ static void __init ppc4xx_configure_pciex_POMs(struct ppc4xx_pciex_port *port,
 	/* Setup outbound memory windows */
 	for (i = j = 0; i < 3; i++) {
 		struct resource *res = &hose->mem_resources[i];
+		resource_size_t offset = hose->mem_offset[i];
 
 		/* we only care about memory windows */
 		if (!(res->flags & IORESOURCE_MEM))
@@ -1805,7 +1808,7 @@ static void __init ppc4xx_configure_pciex_POMs(struct ppc4xx_pciex_port *port,
 		/* Configure the resource */
 		if (ppc4xx_setup_one_pciex_POM(port, hose, mbase,
 					       res->start,
-					       res->start - hose->pci_mem_offset,
+					       res->start - offset,
 					       resource_size(res),
 					       res->flags,
 					       j) == 0) {
@@ -1814,7 +1817,7 @@ static void __init ppc4xx_configure_pciex_POMs(struct ppc4xx_pciex_port *port,
 			/* If the resource PCI address is 0 then we have our
 			 * ISA memory hole
 			 */
-			if (res->start == hose->pci_mem_offset)
+			if (res->start == offset)
 				found_isa_hole = 1;
 		}
 	}
