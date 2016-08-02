Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6d01JTzDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248qiM016263
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:03 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grd4x1sf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:02 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:11:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 82E353578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724Avww30867584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724AurL009799
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 5/9] powerpc/powernv: Fix endian for return value from
 pnv_tce_get()
Date: Tue,  2 Aug 2016 14:10:33 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-6-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the warning reported from sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                             arch/powerpc/platforms/powernv/pci.o
        :
  arch/powerpc/platforms/powernv/pci.c:761:16: \
  warning: incorrect type in return expression (different base types)
  arch/powerpc/platforms/powernv/pci.c:761:16: \
  expected unsigned long
  arch/powerpc/platforms/powernv/pci.c:761:16: \
  got restricted __be64 [usertype] <noident>

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: c5bb44edee19 ("powerpc/powernv: Implement accessor to TCE entry")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b32bafb..9a26a57 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -758,7 +758,7 @@ void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	return *(pnv_tce(tbl, index - tbl->it_offset));
+	return (__force unsigned long)(*(pnv_tce(tbl, index - tbl->it_offset)));
 }
 
 struct iommu_table *pnv_pci_table_alloc(int nid)
-- 
2.1.0
