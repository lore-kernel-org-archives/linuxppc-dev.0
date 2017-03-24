Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vqDRs2W9yzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 17:44:41 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH guest kernel] vfio/powerpc/spapr_tce: Enforce IOMMU type
 compatibility check
Date: Fri, 24 Mar 2017 17:44:06 +1100
Message-Id: <20170324064406.17076-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing SPAPR TCE driver advertises both VFIO_SPAPR_TCE_IOMMU and
VFIO_SPAPR_TCE_v2_IOMMU types to the userspace and the userspace usually
picks the v2.

Normally the userspace would create a container, attach an IOMMU group
to it and only then set the IOMMU type (which would normally be v2).

However a specific IOMMU group may not support v2, in other words
it may not implement set_window/unset_window/take_ownership/
release_ownership and such a group should not be attached to
a v2 container.

This adds extra checks that a new group can do what the selected IOMMU
type suggests. The userspace can then test the return value from
ioctl(VFIO_SET_IOMMU, VFIO_SPAPR_TCE_v2_IOMMU) and try
VFIO_SPAPR_TCE_IOMMU.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is one of the patches needed to do nested VFIO - for either
second level guest or DPDK running in a guest.
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index cf3de91fbfe7..a7d811524092 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1335,8 +1335,16 @@ static int tce_iommu_attach_group(void *iommu_data,
 
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
+		if (container->v2) {
+			ret = -EPERM;
+			goto unlock_exit;
+		}
 		ret = tce_iommu_take_ownership(container, table_group);
 	} else {
+		if (!container->v2) {
+			ret = -EPERM;
+			goto unlock_exit;
+		}
 		ret = tce_iommu_take_ownership_ddw(container, table_group);
 		if (!tce_groups_attached(container) && !container->tables[0])
 			container->def_window_pending = true;
-- 
2.11.0
