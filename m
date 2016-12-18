Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3th60h6cpCzDwGb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 12:29:40 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 09/11] vfio iommu: Add helpers to (un)register
 blocking notifiers per group
Date: Sun, 18 Dec 2016 12:28:58 +1100
Message-Id: <20161218012900.18142-10-aik@ozlabs.ru>
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

c086de81 "vfio iommu: Add blocking notifier to notify DMA_UNMAP" added
notifiers to a VFIO group. However even though the code underneath
uses groups, the API takes device struct pointers.

This adds helpers which do the same thing but take IOMMU groups instead.

This adds vfio_iommu_group_set_kvm() which is a wrapper on top of
vfio_group_set_kvm() but also takes an iommu_group.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/vfio.h |  6 +++++
 drivers/vfio/vfio.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index edf9b2cad277..8a3488ba4732 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -127,9 +127,15 @@ extern int vfio_register_notifier(struct device *dev,
 extern int vfio_unregister_notifier(struct device *dev,
 				    enum vfio_notify_type type,
 				    struct notifier_block *nb);
+extern int vfio_iommu_group_register_notifier(struct iommu_group *grp,
+		enum vfio_notify_type type, unsigned long *events,
+		struct notifier_block *nb);
+extern int vfio_iommu_group_unregister_notifier(struct iommu_group *grp,
+		enum vfio_notify_type type, struct notifier_block *nb);
 
 struct kvm;
 extern void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+extern void vfio_iommu_group_set_kvm(struct iommu_group *grp, struct kvm *kvm);
 
 /*
  * Sub-module helpers
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 9901c4671e2f..6b9a98508939 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2077,6 +2077,23 @@ void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(vfio_group_set_kvm);
 
+void vfio_iommu_group_set_kvm(struct iommu_group *grp, struct kvm *kvm)
+{
+	struct vfio_group *group;
+
+	if (!grp)
+		return;
+
+	group = vfio_group_get_from_iommu(grp);
+	if (!group)
+		return;
+
+	vfio_group_set_kvm(group, kvm);
+
+	vfio_group_put(group);
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_group_set_kvm);
+
 static int vfio_register_group_notifier(struct vfio_group *group,
 					unsigned long *events,
 					struct notifier_block *nb)
@@ -2197,6 +2214,65 @@ int vfio_unregister_notifier(struct device *dev, enum vfio_notify_type type,
 }
 EXPORT_SYMBOL(vfio_unregister_notifier);
 
+int vfio_iommu_group_register_notifier(struct iommu_group *iommugroup,
+		enum vfio_notify_type type,
+		unsigned long *events, struct notifier_block *nb)
+{
+	struct vfio_group *group;
+	int ret;
+
+	if (!iommugroup || !nb || !events || (*events == 0))
+		return -EINVAL;
+
+	group = vfio_group_get_from_iommu(iommugroup);
+	if (!group)
+		return -ENODEV;
+
+	switch (type) {
+	case VFIO_IOMMU_NOTIFY:
+		ret = vfio_register_iommu_notifier(group, events, nb);
+		break;
+	case VFIO_GROUP_NOTIFY:
+		ret = vfio_register_group_notifier(group, events, nb);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL(vfio_iommu_group_register_notifier);
+
+int vfio_iommu_group_unregister_notifier(struct iommu_group *grp,
+		enum vfio_notify_type type, struct notifier_block *nb)
+{
+	struct vfio_group *group;
+	int ret;
+
+	if (!grp || !nb)
+		return -EINVAL;
+
+	group = vfio_group_get_from_iommu(grp);
+	if (!group)
+		return -ENODEV;
+
+	switch (type) {
+	case VFIO_IOMMU_NOTIFY:
+		ret = vfio_unregister_iommu_notifier(group, nb);
+		break;
+	case VFIO_GROUP_NOTIFY:
+		ret = vfio_unregister_group_notifier(group, nb);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL(vfio_iommu_group_unregister_notifier);
+
 /**
  * Module/class support
  */
-- 
2.11.0
