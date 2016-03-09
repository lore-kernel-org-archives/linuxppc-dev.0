Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDC731A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:14 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2E72B357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296Tvkk64815340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TW3r023839
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:33 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 02/10] powerpc/powernv: Rename
 pnv_pci_ioda2_tce_invalidate_entire
Date: Wed,  9 Mar 2016 17:28:58 +1100
Message-Id: <1457504946-40649-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As in fact pnv_pci_ioda2_tce_invalidate_entire() invalidates TCEs for
the specific PE rather than the entire cache, rename it to
pnv_pci_ioda2_tce_invalidate_pe(). In later patches we will add
a proper pnv_pci_ioda2_tce_invalidate_entire().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57dc2dc..889eca3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1824,7 +1824,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
-static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
+static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
 	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
@@ -2101,7 +2101,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_ioda2_tce_invalidate_entire(pe);
+	pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2245,7 +2245,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_ioda2_tce_invalidate_entire(pe);
+		pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
-- 
2.5.0.rc3
