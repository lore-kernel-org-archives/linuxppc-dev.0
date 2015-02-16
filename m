Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA95D1A019F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 09CFB3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7ZRf14680206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7AlC000815
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:10 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 06/28] vfio: powerpc/spapr: Disable DMA mappings on
 disabled container
Date: Mon, 16 Feb 2015 21:05:58 +1100
Message-Id: <1424081180-4494-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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
index 2beeae5..67ea392 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -345,6 +345,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct iommu_table *tbl = container->tbl;
 		unsigned long tce;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (!tbl)
 			return -ENXIO;
 
@@ -389,6 +392,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		struct vfio_iommu_type1_dma_unmap param;
 		struct iommu_table *tbl = container->tbl;
 
+		if (!container->enabled)
+			return -EPERM;
+
 		if (WARN_ON(!tbl))
 			return -ENXIO;
 
-- 
2.0.0
