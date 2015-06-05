Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F8411A1D6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:37:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 5 Jun 2015 16:37:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 24BA52BB0061
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:36:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t556ancM23068842
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556aPj4015304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12 10/34] vfio: powerpc/spapr: Disable DMA mappings on
 disabled container
Date: Fri,  5 Jun 2015 16:35:02 +1000
Message-Id: <1433486126-23551-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment DMA map/unmap requests are handled irrespective to
the container's state. This allows the user space to pin memory which
it might not be allowed to pin.

This adds checks to MAP/UNMAP that the container is enabled, otherwise
-EPERM is returned.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 6e2e15f..5bbdf37 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -318,6 +318,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct iommu_table *tbl = container->tbl;
 		unsigned long tce;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (!tbl)
 			return -ENXIO;
 
@@ -362,6 +365,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct vfio_iommu_type1_dma_unmap param;
 		struct iommu_table *tbl = container->tbl;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (WARN_ON(!tbl))
 			return -ENXIO;
 
-- 
2.4.0.rc3.8.gfb3e7d5
