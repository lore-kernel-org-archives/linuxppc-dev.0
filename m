Return-Path: <aik@ozlabs.ru>
Received: from mail-gh0-f178.google.com (mail-gh0-f178.google.com
 [209.85.160.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 557112C0333
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2013 01:07:36 +1000 (EST)
Received: by mail-gh0-f178.google.com with SMTP id g15so1091471ghb.37
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jul 2013 08:07:33 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] vfio: add external user support
Date: Sun,  7 Jul 2013 01:07:02 +1000
Message-Id: <1373123227-22969-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
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

The proposed protocol includes:

1. do normal VFIO init stuff such as opening a new container, attaching
group(s) to it, setting an IOMMU driver for a container. When IOMMU is
set for a container, all groups in it are considered ready to use by
an external user.

2. pass a fd of the group we want to accelerate to KVM. KVM calls
vfio_group_get_external_user() to verify if the group is initialized,
IOMMU is set for it and increment the container user counter to prevent
the VFIO group from disposal prior to KVM exit.
The current TCE IOMMU driver marks the whole IOMMU table as busy when
IOMMU is set for a container what prevents other DMA users from
allocating from it so it is safe to grant user space access to it.

3. KVM calls vfio_external_user_iommu_id() to obtian an IOMMU ID which
KVM uses to get an iommu_group struct for later use.

4. When KVM is finished, it calls vfio_group_put_external_user() to
release the VFIO group by decrementing the container user counter.
Everything gets released.

The "vfio: Limit group opens" patch is also required for the consistency.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index c488da5..57aa191 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1370,6 +1370,62 @@ static const struct file_operations vfio_device_fops = {
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
+ * 2. The user space passed a group fd which we want to accelerate in
+ * KVM. KVM uses vfio_group_get_external_user() to verify that:
+ *	- the group is initialized;
+ *	- IOMMU is set for it.
+ * Then vfio_group_get_external_user() increments the container user
+ * counter to prevent the VFIO group from disposal prior to KVM exit.
+ *
+ * 3. KVM calls vfio_external_user_iommu_id() to know an IOMMU ID which
+ * KVM uses to get an iommu_group struct for later use.
+ *
+ * 4. When KVM is finished, it calls vfio_group_put_external_user() to
+ * release the VFIO group by decrementing the container user counter.
+ */
+struct vfio_group *vfio_group_get_external_user(struct file *filep)
+{
+	struct vfio_group *group = filep->private_data;
+
+	if (filep->f_op != &vfio_group_fops)
+		return NULL;
+
+	if (!atomic_inc_not_zero(&group->container_users))
+		return NULL;
+
+	if (!group->container->iommu_driver ||
+			!vfio_group_viable(group)) {
+		atomic_dec(&group->container_users);
+		return NULL;
+	}
+
+	return group;
+}
+EXPORT_SYMBOL_GPL(vfio_group_get_external_user);
+
+void vfio_group_put_external_user(struct vfio_group *group)
+{
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
