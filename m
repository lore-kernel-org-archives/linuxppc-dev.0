Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33BB92C022F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 10:54:39 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so87609pbc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 17:54:37 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/10] vfio: add external user support
Date: Tue, 16 Jul 2013 10:53:58 +1000
Message-Id: <1373936045-22653-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFIO is designed to be used via ioctls on file descriptors
returned by VFIO.

However in some situations support for an external user is required.
The first user is KVM on PPC64 (SPAPR TCE protocol) which is going to
use the existing VFIO groups for exclusive access in real/virtual mode
on a host to avoid passing map/unmap requests to the user space which
would made things pretty slow.

The protocol includes:

1. do normal VFIO init operation:
	- opening a new container;
	- attaching group(s) to it;
	- setting an IOMMU driver for a container.
When IOMMU is set for a container, all groups in it are
considered ready to use by an external user.

2. User space passes a group fd to an external user.
The external user calls vfio_group_get_external_user()
to verify that:
	- the group is initialized;
	- IOMMU is set for it.
If both checks passed, vfio_group_get_external_user()
increments the container user counter to prevent
the VFIO group from disposal before KVM exits.

3. The external user calls vfio_external_user_iommu_id()
to know an IOMMU ID. PPC64 KVM uses it to link logical bus
number (LIOBN) with IOMMU ID.

4. When the external KVM finishes, it calls
vfio_group_put_external_user() to release the VFIO group.
This call decrements the container user counter.
Everything gets released.

The "vfio: Limit group opens" patch is also required for the consistency.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
2013/07/11:
* added vfio_group_get()/vfio_group_put()
* protocol description changed

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h |  7 ++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index c488da5..58b034b 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1370,6 +1370,68 @@ static const struct file_operations vfio_device_fops = {
 };
 
 /**
+ * External user API, exported by symbols to be linked dynamically.
+ *
+ * The protocol includes:
+ *  1. do normal VFIO init operation:
+ *	- opening a new container;
+ *	- attaching group(s) to it;
+ *	- setting an IOMMU driver for a container.
+ * When IOMMU is set for a container, all groups in it are
+ * considered ready to use by an external user.
+ *
+ * 2. User space passes a group fd to an external user.
+ * The external user calls vfio_group_get_external_user()
+ * to verify that:
+ *	- the group is initialized;
+ *	- IOMMU is set for it.
+ * If both checks passed, vfio_group_get_external_user()
+ * increments the container user counter to prevent
+ * the VFIO group from disposal before KVM exits.
+ *
+ * 3. The external user calls vfio_external_user_iommu_id()
+ * to know an IOMMU ID.
+ *
+ * 4. When the external KVM finishes, it calls
+ * vfio_group_put_external_user() to release the VFIO group.
+ * This call decrements the container user counter.
+ */
+struct vfio_group *vfio_group_get_external_user(struct file *filep)
+{
+	struct vfio_group *group = filep->private_data;
+
+	if (filep->f_op != &vfio_group_fops)
+		return ERR_PTR(-EINVAL);
+
+	if (!atomic_inc_not_zero(&group->container_users))
+		return ERR_PTR(-EINVAL);
+
+	if (!group->container->iommu_driver ||
+			!vfio_group_viable(group)) {
+		atomic_dec(&group->container_users);
+		return ERR_PTR(-EINVAL);
+	}
+
+	vfio_group_get(group);
+
+	return group;
+}
+EXPORT_SYMBOL_GPL(vfio_group_get_external_user);
+
+void vfio_group_put_external_user(struct vfio_group *group)
+{
+	vfio_group_put(group);
+	vfio_group_try_dissolve_container(group);
+}
+EXPORT_SYMBOL_GPL(vfio_group_put_external_user);
+
+int vfio_external_user_iommu_id(struct vfio_group *group)
+{
+	return iommu_group_id(group->iommu_group);
+}
+EXPORT_SYMBOL_GPL(vfio_external_user_iommu_id);
+
+/**
  * Module/class support
  */
 static char *vfio_devnode(struct device *dev, umode_t *mode)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index ac8d488..24579a0 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -90,4 +90,11 @@ extern void vfio_unregister_iommu_driver(
 	TYPE tmp;						\
 	offsetof(TYPE, MEMBER) + sizeof(tmp.MEMBER); })		\
 
+/*
+ * External user API
+ */
+extern struct vfio_group *vfio_group_get_external_user(struct file *filep);
+extern void vfio_group_put_external_user(struct vfio_group *group);
+extern int vfio_external_user_iommu_id(struct vfio_group *group);
+
 #endif /* VFIO_H */
-- 
1.8.3.2
