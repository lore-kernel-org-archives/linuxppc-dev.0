Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3th61M4XCnzDwHF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 12:30:15 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 10/11] vfio: Check for unregistered notifiers when
 group is actually released
Date: Sun, 18 Dec 2016 12:28:59 +1100
Message-Id: <20161218012900.18142-11-aik@ozlabs.ru>
In-Reply-To: <20161218012900.18142-1-aik@ozlabs.ru>
References: <20161218012900.18142-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves a check for unregistered notifiers from fops release
callback to the place where the group will actually be released.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is going to be used in the following patch in cleanup
path. Since the next patch is RFC, this one might not be needed.
---
 drivers/vfio/vfio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 6b9a98508939..083b581e87c0 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -403,6 +403,8 @@ static void vfio_group_release(struct kref *kref)
 	struct iommu_group *iommu_group = group->iommu_group;
 
 	WARN_ON(!list_empty(&group->device_list));
+	/* Any user didn't unregister? */
+	WARN_ON(group->notifier.head);
 
 	list_for_each_entry_safe(unbound, tmp,
 				 &group->unbound_list, unbound_next) {
@@ -1584,9 +1586,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
 
 	filep->private_data = NULL;
 
-	/* Any user didn't unregister? */
-	WARN_ON(group->notifier.head);
-
 	vfio_group_try_dissolve_container(group);
 
 	atomic_dec(&group->opened);
-- 
2.11.0
