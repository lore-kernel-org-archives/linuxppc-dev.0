Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0D47C7zDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:08 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A37072BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gvp660227624
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gWEs032123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 06/18] powerpc/powernv: Allocate PE# in reverse order
Date: Fri, 20 May 2016 16:41:30 +1000
Message-Id: <1463726502-14679-7-git-send-email-gwshan@linux.vnet.ibm.com>
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

PE number for one particular PE can be allocated dynamically or
reserved according to the consumed M64 (64-bits prefetchable)
segments of the PE. The M64 segment can't be remapped to arbitrary
PE, meaning the PE number is determined according to the index
of the consumed M64 segment. As below figure shows, M64 resource
grows from low to high end, meaning the PE (number) reserved
according to M64 segment grows from low to high end as well,
so does the dynamically allocated PE number. It will lead to
conflict: PE number (M64 segment) reserved by dynamic allocation
is required by hot added PCI adapter at later point. It fails
the PCI hotplug because of the PE number can't be reserved
based on the index of the consumed M64 segment.

  +---+---+---+---+---+--------------------------------+-----+
  | 0 | 1 | 2 | 3 | 4 |      .......                   | 255 |
  +---+---+---+---+---+--------------------------------+-----+

  PE number for dynamic allocation          ----------------->
  PE number reserved for M64 segment        ----------------->

To resolve above conflicts, this forces the PE number to be
allocated dynamically in reverse order. With this patch applied,
the PE numbers are reserved in ascending order, but allocated
dynamically in reverse order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dea2595..2dc64ca 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -141,16 +141,14 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe;
+	unsigned long pe = phb->ioda.total_pe_num - 1;
 
-	do {
-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe_num, 0);
-		if (pe >= phb->ioda.total_pe_num)
-			return NULL;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	for (pe = phb->ioda.total_pe_num - 1; pe >= 0; pe--) {
+		if (!test_and_set_bit(pe, phb->ioda.pe_alloc))
+			return pnv_ioda_init_pe(phb, pe);
+	}
 
-	return pnv_ioda_init_pe(phb, pe);
+	return NULL;
 }
 
 static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
-- 
2.1.0
