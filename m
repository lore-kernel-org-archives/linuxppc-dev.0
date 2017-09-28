Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3y2k8n4V2zzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 15:42:01 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2] vfio/spapr: Add cond_resched() for huge updates
Date: Thu, 28 Sep 2017 15:41:26 +1000
Message-Id: <20170928054126.5347-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clearing very big IOMMU tables can trigger soft lockups. This adds
cond_resched() for every second spend in the loop.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The testcase is POWER9 box with 264GB guest, 4 VFIO devices from
independent IOMMU groups, 64K IOMMU pages. This configuration produces
4325376 TCE entries, each entry update incurs 4 OPAL calls to update
an individual PE TCE cache; this produced lockups for more than 20s.
Reducing table size to 4194304 (i.e. 256GB guest) or removing one
of 4 VFIO devices makes the problem go away.

---
Changes:
v2:
* replaced with time based solution
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 63112c36ab2d..b7a317520f2a 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -505,8 +505,15 @@ static int tce_iommu_clear(struct tce_container *container,
 	unsigned long oldhpa;
 	long ret;
 	enum dma_data_direction direction;
+	unsigned long time_limit = jiffies + HZ;
 
 	for ( ; pages; --pages, ++entry) {
+
+		if (time_after(jiffies, time_limit)) {
+			cond_resched();
+			time_limit = jiffies + HZ;
+		}
+
 		direction = DMA_NONE;
 		oldhpa = 0;
 		ret = iommu_tce_xchg(tbl, entry, &oldhpa, &direction);
-- 
2.11.0
