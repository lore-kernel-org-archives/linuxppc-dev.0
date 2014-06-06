Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEC041A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:20 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 6 Jun 2014 18:44:17 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D01FE2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s568huIZ8716618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:43:58 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s568iBft023850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:44:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc/powernv: use it_page_shift for TCE invalidation
Date: Fri,  6 Jun 2014 18:44:01 +1000
Message-Id: <1402044246-13650-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
References: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes IODA1/2 to use it_page_shift as it may be bigger than 4K.

This changes involved constant values to use "ull" modifier.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 98824aa..8307fe5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -512,15 +512,16 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
+	const unsigned shift = tbl->it_page_shift;
 
 	start = __pa(startp);
 	end = __pa(endp);
 
 	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
 	if (tbl->it_busno) {
-		start <<= 12;
-		end <<= 12;
-		inc = 128 << 12;
+		start <<= shift;
+		end <<= shift;
+		inc = 128ull << shift;
 		start |= tbl->it_busno;
 		end |= tbl->it_busno;
 	} else if (tbl->it_type & TCE_PCI_SWINV_PAIR) {
@@ -558,18 +559,19 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
+	const unsigned shift = tbl->it_page_shift;
 
 	/* We'll invalidate DMA address in PE scope */
-	start = 0x2ul << 60;
+	start = 0x2ull << 60;
 	start |= (pe->pe_number & 0xFF);
 	end = start;
 
 	/* Figure out the start, end and step */
 	inc = tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
-	start |= (inc << 12);
+	start |= (inc << shift);
 	inc = tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
-	end |= (inc << 12);
-	inc = (0x1ul << 12);
+	end |= (inc << shift);
+	inc = (0x1ull << shift);
 	mb();
 
 	while (start <= end) {
-- 
2.0.0
