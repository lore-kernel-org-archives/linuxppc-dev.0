Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14DE41A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 11:26:02 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 602DA140285
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2015 11:26:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 5 Aug 2015 06:55:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9495D3940067
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2015 06:55:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t751PrMo15204420
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2015 06:55:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t751Pr9Z030191
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2015 06:55:53 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 2/6] powerpc/powernv: simplify the calculation of iov
 resource
Date: Wed,  5 Aug 2015 09:24:59 +0800
Message-Id: <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The alignment of IOV BAR on PowerNV platform is the total size of the IOV
BAR. No matter whether the IOV BAR is truncated or not, the total size
could be calculated by (vfs_expanded * VF size).

This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
first case.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9b41dba..7192e62 100644
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
