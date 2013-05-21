Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2EAA92C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:25:21 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4L3PHQj000380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 22:25:18 -0500
Message-ID: <1369106715.6387.37.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix condition for when to invalidate the
 TCE cache
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 May 2013 13:25:15 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use two flags, one to indicate an invalidation is needed after
creating a new entry and one to indicate an invalidation is needed
after removing an entry. However we were testing the wrong flag
in the remove case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 163bd74..098d357 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -367,7 +367,7 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 	while (npages--)
 		*(tcep++) = 0;
 
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
 		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1);
 }
 
