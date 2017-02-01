Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vCpc33ZLVzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:32:51 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org
Subject: [PATCH kernel] vfio/spapr: Fix missing mutex unlock when creating a
 window
Date: Wed,  1 Feb 2017 14:26:16 +1100
Message-Id: <20170201032616.23350-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

d9c728949ddc: "vfio/spapr: Postpone default window creation" added
an additional exit to the VFIO_IOMMU_SPAPR_TCE_CREATE case and made it
possible to return from tce_iommu_ioctl() without unlocking
container->lock; this fixes the issue.

Fixes: d9c728949ddc
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 128d10282d16..7690e5bf3cf1 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1123,12 +1123,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 		mutex_lock(&container->lock);
 
 		ret = tce_iommu_create_default_window(container);
-		if (ret)
-			return ret;
-
-		ret = tce_iommu_create_window(container, create.page_shift,
-				create.window_size, create.levels,
-				&create.start_addr);
+		if (!ret)
+			ret = tce_iommu_create_window(container,
+					create.page_shift,
+					create.window_size, create.levels,
+					&create.start_addr);
 
 		mutex_unlock(&container->lock);
 
-- 
2.11.0
