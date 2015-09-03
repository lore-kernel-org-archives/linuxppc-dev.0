Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7BD51A2AE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 11:30:58 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 3 Sep 2015 07:00:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 73E03E0056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 07:00:14 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t831Urcr46530644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 07:00:53 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t831UqfJ008650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 07:00:53 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
Date: Thu,  3 Sep 2015 09:29:48 +0800
Message-Id: <1441243792-2074-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1441243792-2074-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1441243792-2074-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment of IOV BAR on PowerNV platform is the total size of the IOV
BAR. No matter whether the IOV BAR is extended with number of
roundup_pow_of_two(total_vfs) or number of max PE number (256), the total
size could be calculated by (vfs_expanded * VF_BAR_size).

This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
first case.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8c031b5..e3e0acb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2988,12 +2988,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
-	resource_size_t align, iov_align;
-
-	iov_align = resource_size(&pdev->resource[resno]);
-	if (iov_align)
-		return iov_align;
+	resource_size_t align;
 
+	/*
+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
+	 * SR-IOV. While from hardware perspective, the range mapped by M64
+	 * BAR should be size aligned.
+	 *
+	 * This function returns the total IOV BAR size if expanded or just the
+	 * individual size if not.
+	 */
 	align = pci_iov_resource_size(pdev, resno);
 	if (pdn->vfs_expanded)
 		return pdn->vfs_expanded * align;
-- 
2.5.0
