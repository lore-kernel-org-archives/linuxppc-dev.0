Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhhX1H04zDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:56 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 23:23:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3406B2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNjHs62259250
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNKdj019406
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 04/22] powerpc/powernv: Increase PE# capacity
Date: Tue,  3 May 2016 23:22:35 +1000
Message-Id: <1462281773-26438-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

Each PHB maintains an array helping to translate 2-bytes Request
ID (RID) to PE# with the assumption that PE# takes one byte, meaning
that we can't have more than 256 PEs. However, pci_dn->pe_number
already had 4-bytes for the PE#.

This extends the PE# capacity for every PHB. After that, the PE number
is represented by 4-bytes value. Then we can reuse IODA_INVALID_PE to
check the PE# in phb->pe_rmap[] is valid or not.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
 arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cbd4c0b..cf96cb5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -768,7 +768,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	/* Clear the reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
-		phb->ioda.pe_rmap[rid] = 0;
+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
 
 	/* Release from all parents PELT-V */
 	while (parent) {
@@ -3406,6 +3406,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (prop32)
 		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
 
+	/* Invalidate RID to PE# mapping */
+	for (segno = 0; segno < ARRAY_SIZE(phb->ioda.pe_rmap); segno++)
+		phb->ioda.pe_rmap[segno] = IODA_INVALID_PE;
+
 	/* Parse 64-bit MMIO range */
 	pnv_ioda_parse_m64_window(phb);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 904f60b..80f5326 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -156,11 +156,8 @@ struct pnv_phb {
 		struct list_head	pe_list;
 		struct mutex            pe_list_mutex;
 
-		/* Reverse map of PEs, will have to extend if
-		 * we are to support more than 256 PEs, indexed
-		 * bus { bus, devfn }
-		 */
-		unsigned char		pe_rmap[0x10000];
+		/* Reverse map of PEs, indexed by {bus, devfn} */
+		unsigned int		pe_rmap[0x10000];
 
 		/* TCE cache invalidate registers (physical and
 		 * remapped)
-- 
2.1.0
