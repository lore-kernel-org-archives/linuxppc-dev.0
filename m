Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BB121A070B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 12:23:02 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E136D14131D
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:23:01 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 06:53:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3A06EE004C
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:53:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9M1MvUL62521582
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:52:57 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9M1MuUv001194
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:52:57 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
Date: Thu, 22 Oct 2015 09:22:15 +0800
Message-Id: <1445476939-2995-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 02324c6..dc0c90b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2998,17 +2998,21 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
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
+	 * This function returns the total IOV BAR size if M64 BAR is in
+	 * Shared PE mode or just VF BAR size if not.
+	 */
 	align = pci_iov_resource_size(pdev, resno);
-	if (pdn->vfs_expanded)
-		return pdn->vfs_expanded * align;
+	if (!pdn->vfs_expanded)
+		return align;
 
-	return align;
+	return pdn->vfs_expanded * align;
 }
 #endif /* CONFIG_PCI_IOV */
 
-- 
2.5.0
