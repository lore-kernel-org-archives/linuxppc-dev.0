Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69D3C1A1DB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:12:11 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3F5131401B5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:12:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BF0B72BB0051
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7DEC0M010879230
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7DEBZkc022614
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:11:35 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v3 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
Date: Thu, 13 Aug 2015 22:11:07 +0800
Message-Id: <1439475071-7001-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9ac324e..67b8f72 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2987,12 +2987,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
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
+	 * This function return the total IOV BAR size if expanded or just the
+	 * individual size if not.
+	 */
 	align = pci_iov_resource_size(pdev, resno);
 	if (pdn->vfs_expanded)
 		return pdn->vfs_expanded * align;
-- 
1.7.9.5
