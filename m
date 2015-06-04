Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D60581A0A84
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3EE932BB0065
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hRew57409714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h1Lb005340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 14/42] powerpc/powernv: Allocate PE# in deasending order
Date: Thu,  4 Jun 2015 16:41:43 +1000
Message-Id: <1433400131-18429-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The available PE#, represented by a bitmap in the PHB, is allocated
in asending order. It conflicts with the fact that M64 segments are
assigned in same order. In order to avoid the conflict, the patch
allocates PE# in deasending order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from [PATCH v5 v4 06/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8b0ef5..0d6539a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -152,18 +152,23 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe;
+	unsigned long pe_no;
+	unsigned long limit = phb->ioda.total_pe - 1;
 
 	do {
-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe, 0);
-		if (pe >= phb->ioda.total_pe)
+		pe_no = find_next_zero_bit(phb->ioda.pe_alloc,
+					   phb->ioda.total_pe, limit);
+		if (pe_no < phb->ioda.total_pe &&
+		    !test_and_set_bit(pe_no, phb->ioda.pe_alloc))
+			break;
+
+		if (--limit >= phb->ioda.total_pe)
 			return IODA_INVALID_PE;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	} while (1);
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
-	return pe;
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	return pe_no;
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
-- 
2.1.0
