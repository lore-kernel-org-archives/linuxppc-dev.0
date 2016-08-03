Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464N51QbzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:40 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
Date: Wed,  3 Aug 2016 18:40:55 +1000
Message-Id: <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports helpers which are needed to keep a VFIO container in
memory while there are external users such as KVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio.c                 | 30 ++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
 include/linux/vfio.h                |  6 ++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index d1d70e0..baf6a9c 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1729,6 +1729,36 @@ long vfio_external_check_extension(struct vfio_group *group, unsigned long arg)
 EXPORT_SYMBOL_GPL(vfio_external_check_extension);
 
 /**
+ * External user API for containers, exported by symbols to be linked
+ * dynamically.
+ *
+ */
+struct vfio_container *vfio_container_get_ext(struct file *filep)
+{
+	struct vfio_container *container = filep->private_data;
+
+	if (filep->f_op != &vfio_fops)
+		return ERR_PTR(-EINVAL);
+
+	vfio_container_get(container);
+
+	return container;
+}
+EXPORT_SYMBOL_GPL(vfio_container_get_ext);
+
+void vfio_container_put_ext(struct vfio_container *container)
+{
+	vfio_container_put(container);
+}
+EXPORT_SYMBOL_GPL(vfio_container_put_ext);
+
+void *vfio_container_get_iommu_data_ext(struct vfio_container *container)
+{
+	return container->iommu_data;
+}
+EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
+
+/**
  * Sub-module support
  */
 /*
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 3594ad3..fceea3d 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
 	.detach_group	= tce_iommu_detach_group,
 };
 
+struct iommu_table *vfio_container_spapr_tce_table_get_ext(void *iommu_data,
+		u64 offset)
+{
+	struct tce_container *container = iommu_data;
+	struct iommu_table *tbl = NULL;
+
+	if (tce_iommu_find_table(container, offset, &tbl) < 0)
+		return NULL;
+
+	iommu_table_get(tbl);
+
+	return tbl;
+}
+EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
+
 static int __init tce_iommu_init(void)
 {
 	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
@@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0ecae0b..1c2138a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(struct vfio_group *group);
 extern int vfio_external_user_iommu_id(struct vfio_group *group);
 extern long vfio_external_check_extension(struct vfio_group *group,
 					  unsigned long arg);
+extern struct vfio_container *vfio_container_get_ext(struct file *filep);
+extern void vfio_container_put_ext(struct vfio_container *container);
+extern void *vfio_container_get_iommu_data_ext(
+		struct vfio_container *container);
+extern struct iommu_table *vfio_container_spapr_tce_table_get_ext(
+		void *iommu_data, u64 offset);
 
 /*
  * Sub-module helpers
-- 
2.5.0.rc3
