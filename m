Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A143A1A0CBC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:25 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:44:23 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 150F13940049
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:44:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DEIME66060350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:44:18 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDEhr030925
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:16 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 21/50] powerpc/powernv: Increase PE# capacity
Date: Thu,  5 Nov 2015 00:12:21 +1100
Message-Id: <1446642770-4681-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

This extends the PE# capacity so that each of them will be 4-bytes
long. Then we can reuse IODA_INVALID_PE to check the PE# stored in
phb->pe_rmap[] is valid or not.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
 arch/powerpc/platforms/powernv/pci.h      | 7 ++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0e66c4d..ef93a01 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -766,7 +766,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	/* Clear the reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
-		phb->ioda.pe_rmap[rid] = 0;
+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
 
 	/* Release from all parents PELT-V */
 	while (parent) {
@@ -3164,6 +3164,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (prop32)
 		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
 
+	/* Invalidate RID to PE# mapping */
+	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
+		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
+
 	/* Parse 64-bit MMIO range */
 	pnv_ioda_parse_m64_window(phb);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0802fcd..5df945f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -162,11 +162,8 @@ struct pnv_phb {
 			struct list_head	pe_list;
 			struct mutex            pe_list_mutex;
 
-			/* Reverse map of PEs, will have to extend if
-			 * we are to support more than 256 PEs, indexed
-			 * bus { bus, devfn }
-			 */
-			unsigned char		pe_rmap[0x10000];
+			/* Reverse map of PEs, indexed by {bus, devfn} */
+			int			pe_rmap[0x10000];
 
 			/* TCE cache invalidate registers (physical and
 			 * remapped)
-- 
2.1.0
