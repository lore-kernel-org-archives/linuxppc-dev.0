Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0573D1A0415
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 98BAA2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8ekU31457520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8F9g005834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:15 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 06/29] vfio: powerpc/spapr: Disable DMA mappings on
 disabled container
Date: Tue, 10 Mar 2015 01:07:02 +1100
Message-Id: <1425910045-26167-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
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
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 432a0de..d3ab34f 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -333,6 +333,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct iommu_table *tbl = container->tbl;
 		unsigned long tce;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (!tbl)
 			return -ENXIO;
 
@@ -377,6 +380,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct vfio_iommu_type1_dma_unmap param;
 		struct iommu_table *tbl = container->tbl;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (WARN_ON(!tbl))
 			return -ENXIO;
 
-- 
2.0.0
