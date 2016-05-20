Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0F5dLRzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:09 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C75642CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:07 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gxZL57933948
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gXU9031424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 08/18] powerpc/powernv: Setup PE for root bus
Date: Fri, 20 May 2016 16:41:32 +1000
Message-Id: <1463726502-14679-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
if it's not populated yet. The PE number next to the reserved one
is used as the PE# to avoid holes in continuous M64 space.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 49 ++++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cc6a7c4..3186a29 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -194,14 +194,14 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
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
@@ -281,14 +281,14 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
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
 		WARN(1, "Wrong reserved PE#%d on PHB#%d\n",
 		     phb->ioda.reserved_pe_idx, phb->hose->global_number);
@@ -1062,8 +1062,13 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
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
@@ -3224,6 +3229,15 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
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
@@ -3497,7 +3511,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
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
index de56ed2..8927e5d 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -110,6 +110,8 @@ struct pnv_phb {
 		/* Global bridge info */
 		unsigned int		total_pe_num;
 		unsigned int		reserved_pe_idx;
+		unsigned int		root_pe_idx;
+		bool			root_pe_populated;
 
 		/* 32-bit MMIO window */
 		unsigned int		m32_size;
-- 
2.1.0
