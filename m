Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhvb60PNzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:33:31 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:24 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id ABE2EE0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:56:12 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNDE827000888
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:13 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNEKP031684
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:17 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 07/22] powerpc/powernv: Setup PE for root bus
Date: Tue,  3 May 2016 23:22:38 +1000
Message-Id: <1462281773-26438-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no parent bridge for root bus, meaning pcibios_setup_bridge()
isn't invoked for root bus. The PE for root bus is the ancestor of
other PEs in PELTV. It means we need PE for root bus populated before
all others.

This populates the PE for root bus in pcibios_setup_bridge() path
if it's not existing. The PE number next to the reserved one is
used as the PE# to avoid holes in continuous M64 space.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 49 ++++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f63902a..de3f292 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -201,14 +201,14 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 	set_bit(phb->ioda.m64_bar_idx, &phb->ioda.m64_bar_alloc);
 
 	/*
-	 * Strip off the segment used by the reserved PE, which is
-	 * expected to be 0 or last one of PE capabicity.
+	 * Exclude the segments for reserved and root bus PE, which
+	 * are first or last two PEs.
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe_idx == 0)
-		r->start += phb->ioda.m64_segsize;
+		r->start += (2 * phb->ioda.m64_segsize);
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
-		r->end -= phb->ioda.m64_segsize;
+		r->end -= (2 * phb->ioda.m64_segsize);
 	else
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
@@ -288,14 +288,14 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 	}
 
 	/*
-	 * Exclude the segment used by the reserved PE, which
-	 * is expected to be 0 or last supported PE#.
+	 * Exclude the segments for reserved and root bus PE, which
+	 * are first or last two PEs.
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe_idx == 0)
-		r->start += phb->ioda.m64_segsize;
+		r->start += (2 * phb->ioda.m64_segsize);
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
-		r->end -= phb->ioda.m64_segsize;
+		r->end -= (2 * phb->ioda.m64_segsize);
 	else
 		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
@@ -1066,8 +1066,13 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 		return NULL;
 	}
 
+	/* PE number for root bus should have been reserved */
+	if (pci_is_root_bus(bus) &&
+	    phb->ioda.root_pe_idx != IODA_INVALID_PE)
+		pe = &phb->ioda.pe_array[phb->ioda.root_pe_idx];
+
 	/* Check if PE is determined by M64 */
-	if (phb->pick_m64_pe)
+	if (!pe && phb->pick_m64_pe)
 		pe = phb->pick_m64_pe(bus, all);
 
 	/* The PE number isn't pinned by M64 */
@@ -3149,6 +3154,15 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	struct pnv_ioda_pe *pe;
 	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
 
+	/* The PE for root bus should be realized before any one else */
+	if (!phb->ioda.root_pe_populated) {
+		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
+		if (pe) {
+			phb->ioda.root_pe_idx = pe->pe_number;
+			phb->ioda.root_pe_populated = true;
+		}
+	}
+
 	/* Don't assign PE to PCI bus, which doesn't have subordinate devices */
 	if (list_empty(&bus->devices))
 		return;
@@ -3413,7 +3427,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 			phb->ioda.dma32_segmap[segno] = IODA_INVALID_PE;
 	}
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
+
+	/*
+	 * Choose PE number for root bus, which shouldn't have
+	 * M64 resources consumed by its child devices. To pick
+	 * the PE number adjacent to the reserved one if possible.
+	 */
+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe_idx);
+	if (phb->ioda.reserved_pe_idx == 0) {
+		phb->ioda.root_pe_idx = 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1)) {
+		phb->ioda.root_pe_idx = phb->ioda.reserved_pe_idx - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else {
+		phb->ioda.root_pe_idx = IODA_INVALID_PE;
+	}
 
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
 	mutex_init(&phb->ioda.pe_list_mutex);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 80f5326..a81bf01 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -114,6 +114,8 @@ struct pnv_phb {
 		/* Global bridge info */
 		unsigned int		total_pe_num;
 		unsigned int		reserved_pe_idx;
+		unsigned int		root_pe_idx;
+		bool			root_pe_populated;
 
 		/* 32-bit MMIO window */
 		unsigned int		m32_size;
-- 
2.1.0
