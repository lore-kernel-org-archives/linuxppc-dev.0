Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57E6A1A028F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:40:38 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 14:40:37 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BED44357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:40:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6H4eIk91835298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:40:18 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6H4eXGB014029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 14:40:34 +1000
Date: Thu, 17 Jul 2014 14:40:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Guo Chao <yan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/6] powerpc/powernv: Enable M64 aperatus for PHB3
Message-ID: <20140717044033.GA27480@shangw>
References: <1405513475-24220-1-git-send-email-yan@linux.vnet.ibm.com>
 <1405513475-24220-2-git-send-email-yan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405513475-24220-2-git-send-email-yan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2014 at 08:24:30PM +0800, Guo Chao wrote:
>This patch enables M64 aperatus for PHB3.
>
>We already had platform hook (ppc_md.pcibios_window_alignment) to affect
>the PCI resource assignment done in PCI core so that each PE's M32 resource
>was built on basis of M32 segment size. Similarly, we're using that for
>M64 assignment on basis of M64 segment size.
>
>   * We're using last M64 BAR to cover M64 aperatus, and it's shared by all
>     256 PEs.
>   * We don't support P7IOC yet. However, some function callbacks are added
>     to (struct pnv_phb) so that we can reuse them on P7IOC in future.
>   * PE, corresponding to PCI bus with large M64 BAR device attached, might
>     span multiple M64 segments. We introduce "compound" PE to cover the case.
>     The compound PE is a list of PEs and the master PE is used as before.
>     The slave PEs are just for MMIO isolation.
>
>Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

It looks good to me except the PELTV bits (I told you before), which can be
fixed later. Without PELTV, we can rely software to maintain master/slave
business. However, it's worthy to have PELTV setup correctly so that inbound
ER errors can freeze multiple PEs (if applicable) by hardware.

Also, I run it on P7 box and no problem found there.

Thanks,
Gavin

>---
> arch/powerpc/include/asm/opal.h           |   8 +-
> arch/powerpc/platforms/powernv/pci-ioda.c | 301 +++++++++++++++++++++++++++---
> arch/powerpc/platforms/powernv/pci.h      |  20 ++
> 3 files changed, 307 insertions(+), 22 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>index 0da1dbd..ae885cc 100644
>--- a/arch/powerpc/include/asm/opal.h
>+++ b/arch/powerpc/include/asm/opal.h
>@@ -340,6 +340,12 @@ enum OpalMveEnableAction {
> 	OPAL_ENABLE_MVE = 1
> };
>
>+enum OpalM64EnableAction {
>+	OPAL_DISABLE_M64 = 0,
>+	OPAL_ENABLE_M64_SPLIT = 1,
>+	OPAL_ENABLE_M64_NON_SPLIT = 2
>+};
>+
> enum OpalPciResetScope {
> 	OPAL_PHB_COMPLETE = 1, OPAL_PCI_LINK = 2, OPAL_PHB_ERROR = 3,
> 	OPAL_PCI_HOT_RESET = 4, OPAL_PCI_FUNDAMENTAL_RESET = 5,
>@@ -768,7 +774,7 @@ int64_t opal_pci_set_phb_mem_window(uint64_t phb_id, uint16_t window_type,
> 				    uint16_t window_num,
> 				    uint64_t starting_real_address,
> 				    uint64_t starting_pci_address,
>-				    uint16_t segment_size);
>+				    uint64_t size);
> int64_t opal_pci_map_pe_mmio_window(uint64_t phb_id, uint16_t pe_number,
> 				    uint16_t window_type, uint16_t window_num,
> 				    uint16_t segment_num);
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 93fd815..2b659d9 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -36,6 +36,7 @@
> #include <asm/tce.h>
> #include <asm/xics.h>
> #include <asm/debug.h>
>+#include <asm/firmware.h>
>
> #include "powernv.h"
> #include "pci.h"
>@@ -82,6 +83,12 @@ static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
> 		: : "r" (val), "r" (paddr) : "memory");
> }
>
>+static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>+{
>+	return ((flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) ==
>+		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>+}
>+
> static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
> {
> 	unsigned long pe;
>@@ -106,6 +113,240 @@ static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
> 	clear_bit(pe, phb->ioda.pe_alloc);
> }
>
>+/* The default M64 BAR is shared by all PEs */
>+static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>+{
>+	const char *desc;
>+	struct resource *r;
>+	s64 rc;
>+
>+	/* Configure the default M64 BAR */
>+	rc = opal_pci_set_phb_mem_window(phb->opal_id,
>+					 OPAL_M64_WINDOW_TYPE,
>+					 phb->ioda.m64_bar_idx,
>+					 phb->ioda.m64_base,
>+					 0, /* unused */
>+					 phb->ioda.m64_size);
>+	if (rc != OPAL_SUCCESS) {
>+		desc = "configuring";
>+		goto fail;
>+	}
>+
>+	/* Enable the default M64 BAR */
>+	rc = opal_pci_phb_mmio_enable(phb->opal_id,
>+				      OPAL_M64_WINDOW_TYPE,
>+				      phb->ioda.m64_bar_idx,
>+				      OPAL_ENABLE_M64_SPLIT);
>+	if (rc != OPAL_SUCCESS) {
>+		desc = "enabling";
>+		goto fail;
>+	}
>+
>+	/* Mark the M64 BAR assigned */
>+	set_bit(phb->ioda.m64_bar_idx, &phb->ioda.m64_bar_alloc);
>+
>+	/*
>+	 * Strip off the segment used by the reserved PE, which is
>+	 * expected to be 0 or last one of PE capabicity.
>+	 */
>+	r = &phb->hose->mem_resources[1];
>+	if (phb->ioda.reserved_pe == 0)
>+		r->start += phb->ioda.m64_segsize;
>+	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
>+		r->end -= phb->ioda.m64_segsize;
>+	else
>+		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
>+			phb->ioda.reserved_pe);
>+
>+	return 0;
>+
>+fail:
>+	pr_warn("  Failure %lld %s M64 BAR#%d\n",
>+		rc, desc, phb->ioda.m64_bar_idx);
>+	opal_pci_phb_mmio_enable(phb->opal_id,
>+				 OPAL_M64_WINDOW_TYPE,
>+				 phb->ioda.m64_bar_idx,
>+				 OPAL_DISABLE_M64);
>+	return -EIO;
>+}
>+
>+static void pnv_ioda2_alloc_m64_pe(struct pnv_phb *phb)
>+{
>+	resource_size_t sgsz = phb->ioda.m64_segsize;
>+	struct pci_dev *pdev;
>+	struct resource *r;
>+	int base, step, i;
>+
>+	/*
>+	 * Root bus always has full M64 range and root port has
>+	 * M64 range used in reality. So we're checking root port
>+	 * instead of root bus.
>+	 */
>+	list_for_each_entry(pdev, &phb->hose->bus->devices, bus_list) {
>+		for (i = PCI_BRIDGE_RESOURCES;
>+		     i <= PCI_BRIDGE_RESOURCE_END; i++) {
>+			r = &pdev->resource[i];
>+			if (!r->parent ||
>+			    !pnv_pci_is_mem_pref_64(r->flags))
>+				continue;
>+
>+			base = (r->start - phb->ioda.m64_base) / sgsz;
>+			for (step = 0; step < resource_size(r) / sgsz; step++)
>+				set_bit(base + step, phb->ioda.pe_alloc);
>+		}
>+	}
>+}
>+
>+static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
>+				 struct pci_bus *bus, int all)
>+{
>+	resource_size_t segsz = phb->ioda.m64_segsize;
>+	struct pci_dev *pdev;
>+	struct resource *r;
>+	struct pnv_ioda_pe *master_pe, *pe;
>+	unsigned long size, *pe_alloc;
>+	bool found;
>+	int start, i, j;
>+
>+	/* Root bus shouldn't use M64 */
>+	if (pci_is_root_bus(bus))
>+		return IODA_INVALID_PE;
>+
>+	/* We support only one M64 window on each bus */
>+	found = false;
>+	pci_bus_for_each_resource(bus, r, i) {
>+		if (r && r->parent &&
>+		    pnv_pci_is_mem_pref_64(r->flags)) {
>+			found = true;
>+			break;
>+		}
>+	}
>+
>+	/* No M64 window found ? */
>+	if (!found)
>+		return IODA_INVALID_PE;
>+
>+	/* Allocate bitmap */
>+	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
>+	pe_alloc = kzalloc(size, GFP_KERNEL);
>+	if (!pe_alloc) {
>+		pr_warn("%s: Out of memory !\n",
>+			__func__);
>+		return IODA_INVALID_PE;
>+	}
>+
>+	/*
>+	 * Figure out reserved PE numbers by the PE
>+	 * the its child PEs.
>+	 */
>+	start = (r->start - phb->ioda.m64_base) / segsz;
>+	for (i = 0; i < resource_size(r) / segsz; i++)
>+		set_bit(start + i, pe_alloc);
>+
>+	if (all)
>+		goto done;
>+
>+	/*
>+	 * If the PE doesn't cover all subordinate buses,
>+	 * we need subtract from reserved PEs for children.
>+	 */
>+	list_for_each_entry(pdev, &bus->devices, bus_list) {
>+		if (!pdev->subordinate)
>+			continue;
>+
>+		pci_bus_for_each_resource(pdev->subordinate, r, i) {
>+			if (!r || !r->parent ||
>+			    !pnv_pci_is_mem_pref_64(r->flags))
>+				continue;
>+
>+			start = (r->start - phb->ioda.m64_base) / segsz;
>+			for (j = 0; j < resource_size(r) / segsz ; j++)
>+				clear_bit(start + j, pe_alloc);
>+                }
>+        }
>+
>+	/*
>+	 * the current bus might not own M64 window and that's all
>+	 * contributed by its child buses. For the case, we needn't
>+	 * pick M64 dependent PE#.
>+	 */
>+	if (bitmap_empty(pe_alloc, phb->ioda.total_pe)) {
>+		kfree(pe_alloc);
>+		return IODA_INVALID_PE;
>+	}
>+
>+	/*
>+	 * Figure out the master PE and put all slave PEs to master
>+	 * PE's list to form compound PE.
>+	 */
>+done:
>+	master_pe = NULL;
>+	i = -1;
>+	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
>+		phb->ioda.total_pe) {
>+		pe = &phb->ioda.pe_array[i];
>+		pe->phb = phb;
>+		pe->pe_number = i;
>+
>+		if (!master_pe) {
>+			pe->flags |= PNV_IODA_PE_MASTER;
>+			INIT_LIST_HEAD(&pe->slaves);
>+			master_pe = pe;
>+		} else {
>+			pe->flags |= PNV_IODA_PE_SLAVE;
>+			pe->master = master_pe;
>+			list_add_tail(&pe->list, &master_pe->slaves);
>+		}
>+	}
>+
>+	kfree(pe_alloc);
>+	return master_pe->pe_number;
>+}
>+
>+static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>+{
>+	struct pci_controller *hose = phb->hose;
>+	struct device_node *dn = hose->dn;
>+	struct resource *res;
>+	const u32 *r;
>+	u64 pci_addr;
>+
>+	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
>+		pr_info("  Firmware too old to support M64 window\n");
>+		return;
>+	}
>+
>+	r = of_get_property(dn, "ibm,opal-m64-window", NULL);
>+	if (!r) {
>+		pr_info("  No <ibm,opal-m64-window> on %s\n",
>+			dn->full_name);
>+		return;
>+	}
>+
>+	/* FIXME: Support M64 for P7IOC */
>+	if (phb->type != PNV_PHB_IODA2) {
>+		pr_info("  Not support M64 window\n");
>+		return;
>+	}
>+
>+	res = &hose->mem_resources[1];
>+	res->start = of_translate_address(dn, r + 2);
>+	res->end = res->start + of_read_number(r + 4, 2) - 1;
>+	res->flags = (IORESOURCE_MEM | IORESOURCE_MEM_64 | IORESOURCE_PREFETCH);
>+	pci_addr = of_read_number(r, 2);
>+	hose->mem_offset[1] = res->start - pci_addr;
>+
>+	phb->ioda.m64_size = resource_size(res);
>+	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
>+	phb->ioda.m64_base = pci_addr;
>+
>+	/* Use last M64 BAR to cover M64 window */
>+	phb->ioda.m64_bar_idx = 15;
>+	phb->init_m64 = pnv_ioda2_init_m64;
>+	phb->alloc_m64_pe = pnv_ioda2_alloc_m64_pe;
>+	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
>+}
>+
> /* Currently those 2 are only used when MSIs are enabled, this will change
>  * but in the meantime, we need to protect them to avoid warnings
>  */
>@@ -363,9 +604,16 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
> 	struct pci_controller *hose = pci_bus_to_host(bus);
> 	struct pnv_phb *phb = hose->private_data;
> 	struct pnv_ioda_pe *pe;
>-	int pe_num;
>+	int pe_num = IODA_INVALID_PE;
>+
>+	/* Check if PE is determined by M64 */
>+	if (phb->pick_m64_pe)
>+		pe_num = phb->pick_m64_pe(phb, bus, all);
>+
>+	/* The PE number isn't pinned by M64 */
>+	if (pe_num == IODA_INVALID_PE)
>+		pe_num = pnv_ioda_alloc_pe(phb);
>
>-	pe_num = pnv_ioda_alloc_pe(phb);
> 	if (pe_num == IODA_INVALID_PE) {
> 		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
> 			__func__, pci_domain_nr(bus), bus->number);
>@@ -373,7 +621,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
> 	}
>
> 	pe = &phb->ioda.pe_array[pe_num];
>-	pe->flags = (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>+	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
> 	pe->pbus = bus;
> 	pe->pdev = NULL;
> 	pe->tce32_seg = -1;
>@@ -441,8 +689,15 @@ static void pnv_ioda_setup_PEs(struct pci_bus *bus)
> static void pnv_pci_ioda_setup_PEs(void)
> {
> 	struct pci_controller *hose, *tmp;
>+	struct pnv_phb *phb;
>
> 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>+		phb = hose->private_data;
>+
>+		/* M64 layout might affect PE allocation */
>+		if (phb->alloc_m64_pe)
>+			phb->alloc_m64_pe(phb);
>+
> 		pnv_ioda_setup_PEs(hose->bus);
> 	}
> }
>@@ -1067,9 +1322,6 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
> 				index++;
> 			}
> 		} else if (res->flags & IORESOURCE_MEM) {
>-			/* WARNING: Assumes M32 is mem region 0 in PHB. We need to
>-			 * harden that algorithm when we start supporting M64
>-			 */
> 			region.start = res->start -
> 				       hose->mem_offset[0] -
> 				       phb->ioda.m32_pci_base;
>@@ -1190,7 +1442,10 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
> 		bridge = bridge->bus->self;
> 	}
>
>-	/* We need support prefetchable memory window later */
>+	/* We fail back to M32 if M64 isn't supported */
>+	if (phb->ioda.m64_segsize &&
>+	    pnv_pci_is_mem_pref_64(type))
>+		return phb->ioda.m64_segsize;
> 	if (type & IORESOURCE_MEM)
> 		return phb->ioda.m32_segsize;
>
>@@ -1311,6 +1566,10 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 	prop32 = of_get_property(np, "ibm,opal-reserved-pe", NULL);
> 	if (prop32)
> 		phb->ioda.reserved_pe = be32_to_cpup(prop32);
>+
>+	/* Parse 64-bit MMIO range */
>+	pnv_ioda_parse_m64_window(phb);
>+
> 	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
> 	/* FW Has already off top 64k of M32 space (MSI space) */
> 	phb->ioda.m32_size += 0x10000;
>@@ -1346,14 +1605,6 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 	/* Calculate how many 32-bit TCE segments we have */
> 	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
>
>-	/* Clear unusable m64 */
>-	hose->mem_resources[1].flags = 0;
>-	hose->mem_resources[1].start = 0;
>-	hose->mem_resources[1].end = 0;
>-	hose->mem_resources[2].flags = 0;
>-	hose->mem_resources[2].start = 0;
>-	hose->mem_resources[2].end = 0;
>-
> #if 0 /* We should really do that ... */
> 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
> 					 window_type,
>@@ -1363,12 +1614,16 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 					 segment_size);
> #endif
>
>-	pr_info("  %d (%d) PE's M32: 0x%x [segment=0x%x]"
>-		" IO: 0x%x [segment=0x%x]\n",
>-		phb->ioda.total_pe,
>-		phb->ioda.reserved_pe,
>-		phb->ioda.m32_size, phb->ioda.m32_segsize,
>-		phb->ioda.io_size, phb->ioda.io_segsize);
>+	pr_info("  %03d (%03d) PE's M32: 0x%x [segment=0x%x]\n",
>+		phb->ioda.total_pe, phb->ioda.reserved_pe,
>+		phb->ioda.m32_size, phb->ioda.m32_segsize);
>+	if (phb->ioda.m64_size)
>+		pr_info("                 M64: 0x%lx [segment=0x%lx]\n",
>+			phb->ioda.m64_size, phb->ioda.m64_segsize);
>+	if (phb->ioda.io_size)
>+		pr_info("                  IO: 0x%x [segment=0x%x]\n",
>+			phb->ioda.io_size, phb->ioda.io_segsize);
>+
>
> 	phb->hose->ops = &pnv_pci_ops;
> #ifdef CONFIG_EEH
>@@ -1416,6 +1671,10 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
> 		ioda_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
> 		ioda_eeh_phb_reset(hose, OPAL_DEASSERT_RESET);
> 	}
>+
>+	/* Configure M64 window */
>+	if (phb->init_m64 && phb->init_m64(phb))
>+		hose->mem_resources[1].flags = 0;
> }
>
> void __init pnv_pci_init_ioda2_phb(struct device_node *np)
>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>index 676232c..def7171 100644
>--- a/arch/powerpc/platforms/powernv/pci.h
>+++ b/arch/powerpc/platforms/powernv/pci.h
>@@ -21,6 +21,8 @@ enum pnv_phb_model {
> #define PNV_IODA_PE_DEV		(1 << 0)	/* PE has single PCI device	*/
> #define PNV_IODA_PE_BUS		(1 << 1)	/* PE has primary PCI bus	*/
> #define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
>+#define PNV_IODA_PE_MASTER	(1 << 3)	/* Master PE in compound case	*/
>+#define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
>
> /* Data associated with a PE, including IOMMU tracking etc.. */
> struct pnv_phb;
>@@ -64,6 +66,10 @@ struct pnv_ioda_pe {
> 	 */
> 	int			mve_number;
>
>+	/* PEs in compound case */
>+	struct pnv_ioda_pe	*master;
>+	struct list_head	slaves;
>+
> 	/* Link in list of PE#s */
> 	struct list_head	dma_link;
> 	struct list_head	list;
>@@ -119,6 +125,9 @@ struct pnv_phb {
> 	void (*fixup_phb)(struct pci_controller *hose);
> 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
> 	void (*shutdown)(struct pnv_phb *phb);
>+	int (*init_m64)(struct pnv_phb *phb);
>+	void (*alloc_m64_pe)(struct pnv_phb *phb);
>+	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
>
> 	union {
> 		struct {
>@@ -129,9 +138,20 @@ struct pnv_phb {
> 			/* Global bridge info */
> 			unsigned int		total_pe;
> 			unsigned int		reserved_pe;
>+
>+			/* 32-bit MMIO window */
> 			unsigned int		m32_size;
> 			unsigned int		m32_segsize;
> 			unsigned int		m32_pci_base;
>+
>+			/* 64-bit MMIO window */
>+			unsigned int		m64_bar_idx;
>+			unsigned long		m64_size;
>+			unsigned long		m64_segsize;
>+			unsigned long		m64_base;
>+			unsigned long		m64_bar_alloc;
>+
>+			/* IO ports */
> 			unsigned int		io_size;
> 			unsigned int		io_segsize;
> 			unsigned int		io_pci_base;
>-- 
>1.9.1
>
