Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l0tB0XClzF26G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 22:50:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au,
	paulus@samba.org
Subject: [PATCH 2/3] powerpc/powernv: Use __raw_[rm_]writeq_be() in pci-ioda.c
Date: Mon, 14 May 2018 22:50:32 +1000
Message-Id: <20180514125033.12000-2-mpe@ellerman.id.au>
In-Reply-To: <20180514125033.12000-1-mpe@ellerman.id.au>
References: <20180514125033.12000-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows us to squash some sparse warnings and also avoids having
to do explicity endian conversions in the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3f9c69d7623a..f9f2b1dc9357 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1976,9 +1976,10 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
         mb(); /* Ensure above stores are visible */
         while (start <= end) {
 		if (rm)
-			__raw_rm_writeq(cpu_to_be64(start), invalidate);
+			__raw_rm_writeq_be(start, invalidate);
 		else
-			__raw_writeq(cpu_to_be64(start), invalidate);
+			__raw_writeq_be(start, invalidate);
+
                 start += inc;
         }
 
@@ -2055,9 +2056,9 @@ static void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 
 	mb(); /* Ensure previous TCE table stores are visible */
 	if (rm)
-		__raw_rm_writeq(cpu_to_be64(val), invalidate);
+		__raw_rm_writeq_be(val, invalidate);
 	else
-		__raw_writeq(cpu_to_be64(val), invalidate);
+		__raw_writeq_be(val, invalidate);
 }
 
 static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
@@ -2067,7 +2068,7 @@ static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
 
 	mb(); /* Ensure above stores are visible */
-	__raw_writeq(cpu_to_be64(val), invalidate);
+	__raw_writeq_be(val, invalidate);
 }
 
 static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
@@ -2090,9 +2091,9 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
 
 	while (start <= end) {
 		if (rm)
-			__raw_rm_writeq(cpu_to_be64(start), invalidate);
+			__raw_rm_writeq_be(start, invalidate);
 		else
-			__raw_writeq(cpu_to_be64(start), invalidate);
+			__raw_writeq_be(start, invalidate);
 		start += inc;
 	}
 }
-- 
2.14.1
