Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 077E71A0655
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EE85C3578062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:12 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D4PQ42926328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CdZQ002995
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 12/42] powerpc/powernv: Increase PE# capacity
Date: Thu,  6 Aug 2015 14:11:17 +1000
Message-Id: <1438834307-26960-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each PHB maintains an array helping to translate RID (Request
ID) to PE# with the assumption that PE# takes 8 bits, indicating
that we can't have more than 256 PEs. However, pci_dn->pe_number
already had 4-bytes for the PE#.

The patch extends the PE# capacity so that each of them will be
4-bytes long. Then we can use IODA_INVALID_PE to check one entry
in phb->pe_rmap[] is valid or not.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++++--
 arch/powerpc/platforms/powernv/pci.h      | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57ba8fd..3094c61 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -786,7 +786,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	/* Clear the reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
-		phb->ioda.pe_rmap[rid] = 0;
+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
 
 	/* Release from all parents PELT-V */
 	while (parent) {
@@ -3134,7 +3134,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	unsigned long size, pemap_off;
 	const __be64 *prop64;
 	const __be32 *prop32;
-	int len;
+	int len, i;
 	u64 phb_id;
 	void *aux;
 	long rc;
@@ -3201,6 +3201,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (prop32)
 		phb->ioda.reserved_pe = be32_to_cpup(prop32);
 
+	/* Invalidate RID to PE# mapping */
+	for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
+		phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
+
 	/* Parse 64-bit MMIO range */
 	pnv_ioda_parse_m64_window(phb);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 1dc9578..6f8568e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -175,11 +175,10 @@ struct pnv_phb {
 			struct list_head	pe_list;
 			struct mutex            pe_list_mutex;
 
-			/* Reverse map of PEs, will have to extend if
-			 * we are to support more than 256 PEs, indexed
-			 * bus { bus, devfn }
+			/* Reverse map of PEs, indexed by
+			 * { bus, devfn }
 			 */
-			unsigned char		pe_rmap[0x10000];
+			int			pe_rmap[0x10000];
 
 			/* 32-bit TCE tables allocation */
 			unsigned long		dma32_segcount;
-- 
2.1.0
