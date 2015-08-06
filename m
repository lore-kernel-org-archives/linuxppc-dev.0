Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A48271A1BEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:37 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 198E52CE8063
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764DQhD43778206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:35 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764D1Lu027119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 16/42] powerpc/powernv: Helper function pnv_ioda_init_pe()
Date: Thu,  6 Aug 2015 14:11:21 +1000
Message-Id: <1438834307-26960-17-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces helper function pnv_ioda_init_pe(), which
initialize PE instance after reserving or allocating PE#, to
simplify the code. The patch doesn't introduce behavioural
changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9f53682..9cccf2d5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,6 +132,17 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
+{
+	struct pnv_ioda_pe *pe = &phb->ioda.pe_array[pe_no];
+
+	pe->phb = phb;
+	pe->pe_number = pe_no;
+	INIT_LIST_HEAD(&pe->list);
+
+	return pe;
+}
+
 static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
@@ -144,10 +155,7 @@ static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 		pr_debug("%s: PE %d was reserved on PHB#%x\n",
 			 __func__, pe_no, phb->hose->global_number);
 
-	phb->ioda.pe_array[pe_no].phb = phb;
-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
-
-	return &phb->ioda.pe_array[pe_no];
+	return pnv_ioda_init_pe(phb, pe_no);
 }
 
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
@@ -161,9 +169,7 @@ static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 			return NULL;
 	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
-	return &phb->ioda.pe_array[pe];
+	return pnv_ioda_init_pe(phb, pe);
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
-- 
2.1.0
