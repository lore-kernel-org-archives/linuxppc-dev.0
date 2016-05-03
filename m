Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSS1K64zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:48 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:42:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6FA2B3578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435gcpZ59572240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gDks027120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 04/26] powerpc/powernv: Reorder fields in struct pnv_phb
Date: Tue,  3 May 2016 15:41:23 +1000
Message-Id: <1462254105-24128-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves those fields in struct pnv_phb that are related to PE
allocation around. No logical change.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 78f035e..f2a1452 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -140,15 +140,14 @@ struct pnv_phb {
 		unsigned int		io_segsize;
 		unsigned int		io_pci_base;
 
-		/* PE allocation bitmap */
-		unsigned long		*pe_alloc;
-		/* PE allocation mutex */
+		/* PE allocation */
 		struct mutex		pe_alloc_mutex;
+		unsigned long		*pe_alloc;
+		struct pnv_ioda_pe	*pe_array;
 
 		/* M32 & IO segment maps */
 		unsigned int		*m32_segmap;
 		unsigned int		*io_segmap;
-		struct pnv_ioda_pe	*pe_array;
 
 		/* IRQ chip */
 		int			irq_chip_init;
-- 
2.1.0
