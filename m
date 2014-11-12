Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C9D21A1E90
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:33 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C9AC140139
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:06:30 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B80D61258044
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:29 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2axel58720402
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:59 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aQIS005935
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:26 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc/powernv: Initialize M64 PE in time
Date: Wed, 12 Nov 2014 13:36:07 +1100
Message-Id: <1415759771-11359-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch initializes PE instance when reserving PE number to
keep consistent things as we did before. Also, it replaces the
iteration on bridge's windows with the prefered way.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cf90cce..7a7a688 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -91,6 +91,24 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
+{
+	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
+		pr_warn("%s: Invalid PE %d on PHB#%x\n",
+			__func__, pe_no, phb->hose->global_number);
+		return;
+	}
+
+	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc)) {
+		pr_warn("%s: PE %d was assigned on PHB#%x\n",
+			__func__, pe_no, phb->hose->global_number);
+		return;
+	}
+
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+}
+
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
@@ -185,16 +203,15 @@ static void pnv_ioda2_reserve_m64_pe(struct pnv_phb *phb)
 	 * instead of root bus.
 	 */
 	list_for_each_entry(pdev, &phb->hose->bus->devices, bus_list) {
-		for (i = PCI_BRIDGE_RESOURCES;
-		     i <= PCI_BRIDGE_RESOURCE_END; i++) {
-			r = &pdev->resource[i];
+		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+			r = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
 			if (!r->parent ||
 			    !pnv_pci_is_mem_pref_64(r->flags))
 				continue;
 
 			base = (r->start - phb->ioda.m64_base) / sgsz;
 			for (step = 0; step < resource_size(r) / sgsz; step++)
-				set_bit(base + step, phb->ioda.pe_alloc);
+				pnv_ioda_reserve_pe(phb, base + step);
 		}
 	}
 }
@@ -287,8 +304,6 @@ done:
 	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
 		phb->ioda.total_pe) {
 		pe = &phb->ioda.pe_array[i];
-		pe->phb = phb;
-		pe->pe_number = i;
 
 		if (!master_pe) {
 			pe->flags |= PNV_IODA_PE_MASTER;
-- 
1.8.3.2
