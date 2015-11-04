Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1F9F1A0CE2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:14:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 98D852BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDsUF20250630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:14:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDRaF032720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 22/50] powerpc/powernv: Introduce pnv_ioda_init_pe()
Date: Thu,  5 Nov 2015 00:12:22 +1100
Message-Id: <1446642770-4681-23-git-send-email-gwshan@linux.vnet.ibm.com>
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

This introduces pnv_ioda_init_pe() to initialize the specified PE
instance (phb->ioda.pe_array[x]). It's used by pnv_ioda_alloc_pe()
and pnv_ioda_reserve_pe(). No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ef93a01..488e0f8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -129,6 +129,14 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
+{
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+
+	return &phb->ioda.pe_array[pe_no];
+}
+
 static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
@@ -141,8 +149,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 		pr_debug("%s: PE %d was reserved on PHB#%x\n",
 			 __func__, pe_no, phb->hose->global_number);
 
-	phb->ioda.pe_array[pe_no].phb = phb;
-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	pnv_ioda_init_pe(phb, pe_no);
 }
 
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
@@ -156,8 +163,7 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 			return IODA_INVALID_PE;
 	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
+	pnv_ioda_init_pe(phb, pe);
 	return pe;
 }
 
-- 
2.1.0
