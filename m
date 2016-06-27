Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpc1DL2zDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:16 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpb261wz9t1N
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:15 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/17] powerpc/powernv/pci: Use the device-tree to get
 available range of M64's
Date: Mon, 27 Jun 2016 22:25:29 +1000
Message-Id: <1467030333-31435-14-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

M64's are the configurable 64-bit windows that cover the 64-bit MMIO
space. We used to hard code 16 windows. Newer chips might have a
variable number and might need to reserve some as well (for example
on PHB4/POWER9, M32 and M64 are actually unified and we use M64#0
to map the 32-bit space).

So newer OPALs will provide a property we can use to know what range
of windows is available. The property is named so that it can
eventually support multiple ranges but we only use the first one for
now.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 49 +++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5f08cd5..b674a38 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -192,9 +192,6 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 		goto fail;
 	}
 
-	/* Mark the M64 BAR assigned */
-	set_bit(phb->ioda.m64_bar_idx, &phb->ioda.m64_bar_alloc);
-
 	/*
 	 * Strip off the segment used by the reserved PE, which is
 	 * expected to be 0 or last one of PE capabicity.
@@ -405,6 +402,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	struct pci_controller *hose = phb->hose;
 	struct device_node *dn = hose->dn;
 	struct resource *res;
+	u32 m64_range[2], i;
 	const u32 *r;
 	u64 pci_addr;
 
@@ -426,6 +424,29 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 		return;
 	}
 
+	/* Find the available M64 BAR range and pickup the last one for
+	 * covering the whole 64-bits space. We support only one range.
+	 */
+	if (of_property_read_u32_array(dn, "ibm,opal-available-m64-ranges",
+				       m64_range, 2)) {
+		/* In absence of the property, assume 0..15 */
+		m64_range[0] = 0;
+		m64_range[1] = 16;
+	}
+	/* We only support 64 bits in our allocator */
+	if (m64_range[1] > 63) {
+		pr_warn("%s: Limiting M64 range to 63 (from %d) on PHB#%x\n",
+			__func__, m64_range[1], phb->hose->global_number);
+		m64_range[1] = 63;
+	}
+	/* Empty range, no m64 */
+	if (m64_range[1] <= m64_range[0]) {
+		pr_warn("%s: M64 empty, disabling M64 usage on PHB#%x\n",
+			__func__, phb->hose->global_number);
+		return;
+	}
+
+	/* Configure M64 informations */
 	res = &hose->mem_resources[1];
 	res->name = dn->full_name;
 	res->start = of_translate_address(dn, r + 2);
@@ -438,11 +459,27 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe_num;
 	phb->ioda.m64_base = pci_addr;
 
-	pr_info(" MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
-			res->start, res->end, pci_addr);
+	/* This lines up nicely with the display from processing OF ranges */
+	pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx (M64 #%d..%d)\n",
+		res->start, res->end, pci_addr, m64_range[0],
+		m64_range[0] + m64_range[1] - 1);
+
+	/* Mark all M64 used up by default */
+	phb->ioda.m64_bar_alloc = (unsigned long)-1;
 
 	/* Use last M64 BAR to cover M64 window */
-	phb->ioda.m64_bar_idx = 15;
+	m64_range[1]--;
+	phb->ioda.m64_bar_idx = m64_range[0] + m64_range[1];
+
+	pr_info(" Using M64 #%d as default window\n", phb->ioda.m64_bar_idx);
+
+	/* Mark remaining ones free */
+	for (i = m64_range[0]; i < m64_range[1]; i++)
+		clear_bit(i, &phb->ioda.m64_bar_alloc);
+
+	/* Setup init functions for M64 based on IODA version, IODA3 uses
+	 * the IODA2 code
+	 */
 	if (phb->type == PNV_PHB_IODA1)
 		phb->init_m64 = pnv_ioda1_init_m64;
 	else
-- 
2.7.4
