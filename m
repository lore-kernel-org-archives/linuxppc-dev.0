Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx70C0TxFzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:58:35 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 18:58:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 80AA32BB0070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:57:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T8vjtN60293264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:57:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T8v11w003123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:57:02 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 03/11] powerpc/powernv: Rename
 pnv_pci_ioda2_tce_invalidate_entire
Date: Fri, 29 Apr 2016 18:55:16 +1000
Message-Id: <1461920124-21719-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..ca307b6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1811,7 +1811,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
-static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
+static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
 	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
@@ -2075,7 +2075,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_ioda2_tce_invalidate_entire(pe);
+	pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2219,7 +2219,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_ioda2_tce_invalidate_entire(pe);
+		pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
-- 
2.5.0.rc3
